import math
from fnmatch import fnmatchcase
from re import A
from time import time

import utils.message as message
from systemrdl import RDLListener, RDLWalker
from systemrdl.node import AddrmapNode, RegfileNode , FieldNode, RootNode, MemNode, AddressableNode


class PreprocessChecker:
    """

    """
    pass

class PreprocessListener(RDLListener):
    """
    A listener for the `preprocess_walker` which preprocesses the register model.

    For component instances in SystemRDL:
    - addrmap
        - complement user-defined properties to distinguish different RTL types of addrmap instances
            - hj_gennetwork
            - hj_genmst
            - hj_gendisp
            - hj_genslv
            - hj_flatten_addrmap
            - hj_3rd_party_ip
        - check whether properties above are mutually exclusive
        - complement RTL module names of all regmst, regdisp, regslv instances
    - mem
        - check memory width
        - whether memories are instantiated under regdisp or 3rd party IP
    - field
        - insert `hdl_path_slice` properties

    Addtionally:
    - check violations of instance hierarchy relationship
    - filter some instances by setting ispresent to false, thus generated uvm ral model would ignore them
        - wildcard matching are supported
    """
    def __init__(self, user_ops:dict):
        """
        set some properties used in the traverse process
        """
        self.indent = 0

        self.is_in_regnetwork = False
        self.is_in_regmst = False
        self.is_in_regslv = False
        self.is_in_regdisp = False
        self.is_in_flatten_addrmap = False
        self.is_in_3rd_party_IP = False
        self.is_in_ext_mem = False
        self.is_filtered = False

        self.all_rtl_mod = []
        self.field_hdl_path = []
        self.reg_name = []
        self.runtime_stack = []
        self.total_reg_num = 0
        self.filter_reg_num = 0
        self.total_size = 0
        self.start_time = time()

        # user-defined operations
        self.filter_pattern = user_ops.pop("filter", None)
        self.keep_quiet = user_ops.pop("quiet", False)

        message.info("HRDA Generator: start preprocessing")

    def enter_Addrmap(self, node):
        # debug message
        if not self.keep_quiet:
            message.debug(
                "%sEntering addrmap: %s" % (
                    "\t"*self.indent,
                    node.get_path_segment(array_suffix = "_{index:d}")
                )
            )

        # check if addrmap is assigned one of following properties exclusively:
        #   hj_gennetwork, hj_genmst, hj_gendisp, hj_genslv, hj_flatten_addrmap, hj_3rd_party_ip
        prop_num = 0
        prop_list = [
            "hj_gennetwork",
            "hj_genmst",
            "hj_gendisp",
            "hj_genslv",
            "hj_flatten_addrmap",
            "hj_3rd_party_ip"
        ]

        # imported IP-XACT (.xml) files are treated as 3rd party IP automatically
        if node.inst.def_src_ref.filename.endswith(".xml"):
            node.inst.properties["hj_3rd_party_ip"] = True

        for prop in prop_list:
            if node.get_property(prop):
                prop_num += 1
            else:
                node.inst.properties[prop] = False

        if not prop_num == 1:
            message.error(
                "%s, %d, %d:\n%s\n"
                "addrmap instance %s must be explicitly assigned one of following properties exclusively: "
                "hj_gennetwork, hj_genmst, hj_gendisp, hj_genslv, hj_flatten_addrmap, hj_3rd_party_ip" % (
                    node.inst.inst_src_ref.filename,
                    node.inst.inst_src_ref.line,
                    node.inst.inst_src_ref.line_selection[0],
                    node.inst.inst_src_ref.line_text,
                    node.get_path_segment(array_suffix = "_{index:d}"),
                )
            )

        # push properties of the parent addrmap instance to stack
        # once entering new addrmap instance
        self.runtime_stack.append(
            (
                self.is_in_regmst,
                self.is_in_regslv,
                self.is_in_regdisp,
                self.is_in_flatten_addrmap,
                self.is_in_3rd_party_IP,
                self.is_filtered
            )
        )

        # reset properties
        (
            self.is_in_regmst,
            self.is_in_regslv,
            self.is_in_regdisp,
            self.is_in_flatten_addrmap,
            self.is_in_3rd_party_IP,
            self.is_filtered
        ) = False, False, False, False, False, False

        # for top-level (root) addrmap instance, calculate its total size
        if isinstance(node.parent, RootNode):
            self.total_size = node.total_size

        # ====================================================================================================
        # distinguish different types and hierarchical levels of addrmap
        # - soc level
        #     - first-level addrmap contains the whole register network on the chip
        #     - second-level addrmap contains a register tree and corresponds to regmst
        #     - third-level addrmap corresponds to regdisp under regmst directly
        # - subsystem level
        #     - fourth-level addrmap contains all register components for one subsystem and corresponds to regdisp
        #     - fifth-level addrmap or mem may corresponds to regslv, memory, 3rd party IP, regdisp or simply be
        #       flatten in the parent addrmap
        #     - downstream levels can be extended by adding regdisp
        # ====================================================================================================

        # the model traverses in addrmap which represents for the whole register network
        if node.get_property("hj_gennetwork"):
            # check whether addrmap which represents for the whole register network
            # is a top-level (root) addrmap instance
            if not isinstance(node.parent, RootNode):
                message.error(
                    "%s, %d, %d:\n%s\n"
                    "current addrmap %s represents for the whole register network, "
                    "so it must be a top-level (root) addrmap instance" % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix = "_{index:d}"),
                    )
                )

            self.is_in_regnetwork = True

        # the model traverses in addrmap which represents for regmst
        elif node.get_property("hj_genmst"):
            # check whether regmst is instantiated under addrmap which represents for the whole register network,
            # if not, its address allocation will be wrong
            if not self.is_in_regnetwork:
                message.error(
                    "%s, %d, %d:\n%s\n"
                    "current addrmap %s represents for regmst, "
                    "so it must be instantiated under addrmap which represents for the whole register network" % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix = "_{index:d}"),
                    )
                )

            # check whether regmst addrmap consist of 2 immediate children:
            # regdisp and debug regfile (db_regs)
            mst_children = list(node.children(skip_not_present=False))

            if len(mst_children) == 2:
                if not isinstance(mst_children[0], AddrmapNode) or \
                    not mst_children[0].get_property("hj_gendisp"):
                    message.error(
                        "%s, %d, %d:\n%s\n"
                        "first instance under regmst addrmap %s is not regdisp addrmap" % (
                            node.inst.inst_src_ref.filename,
                            node.inst.inst_src_ref.line,
                            node.inst.inst_src_ref.line_selection[0],
                            node.inst.inst_src_ref.line_text,
                            node.get_path_segment(array_suffix = "_{index:d}")
                        )
                    )
                elif not isinstance(mst_children[1], RegfileNode):
                    message.error(
                        "%s, %d, %d:\n%s\n"
                        "second instance under regmst addrmap %s is not debug regfile" % (
                            node.inst.inst_src_ref.filename,
                            node.inst.inst_src_ref.line,
                            node.inst.inst_src_ref.line_selection[0],
                            node.inst.inst_src_ref.line_text,
                            node.get_path_segment(array_suffix = "_{index:d}")
                        )
                    )
            else:
                message.error(
                    "%s, %d, %d:\n%s\n"
                    "there should be two instances under regmst addrmap %s: "
                    "regdisp addrmap and debug regfile" % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix = "_{index:d}")
                    )
                )

            self.is_in_regmst = True

            if not self.keep_quiet:
                message.debug(
                    "%sgenerate %s" % (
                        "\t"*self.indent,
                        "regmst_{}".format(node.inst_name)
                    )
                )

            # update rtl module names
            self.all_rtl_mod.append("regmst_{}".format(node.inst_name))
            node.inst.properties["rtl_mod_name"] = "regmst_{}".format(node.inst_name)

            # regmst uses absolute address to decode and forward transactions
            if node.get_property("hj_use_abs_addr") is False:
                message.warning(
                    "%s, %d, %d:\n%s\n"
                    "current addrmap %s represents for regmst, so hj_use_abs_addr must be true" % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix = "_{index:d}")
                    )
                )

            node.inst.properties["hj_use_abs_addr"] = True

            # push field hdl path to stack and update it with current addrmap instance
            self.runtime_stack.append(self.field_hdl_path)
            self.field_hdl_path = [
                "regmst_{}".format(node.inst_name)
            ]

        # the model traverses in addrmap which represents for regdisp
        elif node.get_property("hj_gendisp"):

            # check if immediate children of regdisp are regslv, 3rd party IP or memory
            for child in node.children(skip_not_present=False):
                if not isinstance(child, MemNode) and \
                    not child.get_property("hj_gendisp") and \
                    not child.get_property("hj_genslv") and \
                    not child.get_property("hj_3rd_party_ip"):
                    message.error(
                        "%s, %d, %d:\n%s\n"
                        "current addrmap %s represents for regdisp and is allowed to have immediate children "
                        "of regdisp, regslv, 3rd party IP or memory only, its child instance %s is illegal." % (
                            node.inst.inst_src_ref.filename,
                            node.inst.inst_src_ref.line,
                            node.inst.inst_src_ref.line_selection[0],
                            node.inst.inst_src_ref.line_text,
                            node.get_path_segment(array_suffix = "_{index:d}"),
                            child.get_path_segment(array_suffix = "_{index:d}")
                        )
                    )

            if node.get_property("hj_use_abs_addr") is False:
                message.warning(
                    "%s, %d, %d:\n%s\n"
                    "current addrmap %s represents for regdisp, so hj_use_abs_addr must be true" % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix = "_{index:d}")
                    )
                )

            # dynamic properties during walking
            self.is_in_regdisp = True
            rtl_mod_name = "regdisp_{}".format(node.inst_name)
            self.all_rtl_mod.append(rtl_mod_name)

            # update instance properties
            node.inst.properties["hj_use_abs_addr"] = True
            node.inst.properties["forward_num"] = len(list(node.children(unroll=True, skip_not_present=False)))
            node.inst.properties["rtl_mod_name"] = rtl_mod_name

            if not self.keep_quiet:
                message.debug("%sgenerate %s" % ("\t"*self.indent, rtl_mod_name))

        # the model traverses in addrmap which represents for regslv
        elif node.get_property("hj_genslv"):

            if node.get_property("hj_use_abs_addr"):
                message.warning(
                    "%s, %d, %d:\n%s\n"
                    "current addrmap %s represents for regslv, so hj_use_abs_addr must be false" % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix = "_{index:d}")
                    )
                )

            node.inst.properties["hj_use_abs_addr"] = False

            # dynamic properties during walking
            self.is_in_regslv = True
            self.runtime_stack.append(self.field_hdl_path)
            self.field_hdl_path.clear()

            node.inst.properties["rtl_mod_name"] = "regslv_{}".format(node.inst_name)

            # fix: array instance in SystemRDL needs index suffix of corresponding RTL module names
            rtl_mod_name = "regslv_{}".format(node.get_path_segment(array_suffix="_{index:d}"))
            self.all_rtl_mod.append(rtl_mod_name)
            self.field_hdl_path.append(rtl_mod_name)

            if not self.keep_quiet:
                message.debug("%sgenerate %s" % ("\t"*self.indent, rtl_mod_name))

        # the model traverses in addrmap which will be flatten in the parent addrmap
        # so it represents for no RTL module
        elif node.get_property("hj_flatten_addrmap"):

            # dynamic properties during walking
            self.is_in_regslv = True    # FIXME
            self.is_in_flatten_addrmap = True
            self.reg_name.append(node.get_path_segment(array_suffix="_{index:d}"))

            # update instance properties
            node.inst.properties["hj_use_abs_addr"] = False

            # flatten addrmap can only be defined under the addrmap instantiated as regslv
            if not node.parent.get_property("hj_genslv"):
                message.error(
                    "%s, %d, %d:\n%s\n"
                    "current addrmap %s can only be flatten in the parent addrmap which "
                    "represents for regslv, but parent addrmap %s does not." % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix = "_{index:d}"),
                        node.parent.get_path_segment(array_suffix = "_{index:d}")
                    )
                )

        # the model traverses in addrmap which represents for 3rd party IP
        elif node.get_property("hj_3rd_party_ip"):

            # check whether 3rd party IP are forwarded by regdisp
            if not node.parent.get_property("hj_gendisp"):
                message.error(
                    "%s, %d, %d:\n%s\n"
                    "current addrmap %s representing for 3rd party IP must have a parent "
                    "addrmap which represents for regdisp, but parent addrmap %s does not." % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix = "_{index:d}"),
                        node.parent.get_path_segment(array_suffix = "_{index:d}")
                    )
                )

            # hj_use_abs_addr needs to be assigned by user
            if node.get_property("hj_use_abs_addr") is None:
                message.warning(
                    "%s, %d, %d:\n%s\n"
                    "current addrmap %s represents for 3rd party IP, but you don't explicitly "
                    "assign the property hj_use_abs_addr, and it will be assigned to true" % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix = "_{index:d}")
                    )
                )

            # set properties
            node.inst.properties["hj_genmst"] = False
            node.inst.properties["hj_genslv"] = False
            node.inst.properties["hj_gendisp"] = False
            node.inst.properties["hj_flatten_addrmap"] = False
            node.inst.properties["hj_3rd_party_ip"] = True
            node.inst.properties["ispresent"] = False
            node.inst.properties["hj_use_abs_addr"] = True
            node.inst.properties["rtl_mod_name"] = node.inst_name

            self.is_in_3rd_party_IP = True
            self.is_filtered = True
            if not self.keep_quiet:
                message.debug("%sRecognized as 3rd party IP" % ("\t"*self.indent))


    def exit_Addrmap(self, node):
        # debug message
        if not self.keep_quiet:
            message.debug(
                "%sExiting addrmap: %s" % (
                    "\t"*self.indent,
                    node.get_path_segment(array_suffix = "_{index:d}")
                )
            )

        # pop properties of the parent addrmap instance from stack
        # once exiting new addrmap instance
        if node.get_property("hj_genmst") or \
            node.get_property("hj_genslv"):
            self.field_hdl_path = self.runtime_stack.pop()

        if node.get_property("hj_flatten_addrmap"):
            self.reg_name.pop()

        (
            self.is_in_regmst,
            self.is_in_regslv,
            self.is_in_regdisp,
            self.is_in_flatten_addrmap,
            self.is_in_3rd_party_IP,
            self.is_filtered
        ) = self.runtime_stack.pop()

    def enter_Mem(self, node):
        # debug message
        if not self.keep_quiet:
            message.debug(
                "%sEntering memory: %s" % (
                    "\t"*self.indent,
                    node.get_path_segment(array_suffix = "_{index:d}")
                )
            )

        if not node.parent.get_property("hj_gendisp") and \
            not node.parent.get_property("hj_3rd_party_ip"):
            message.error(
                "%s, %d, %d:\n%s\n"
                "the parent addrmap %s of memory instance %s is not recognized as "
                "regdisp or 3rd party IP, and memories must be forwarded by a regdisp or 3rd party IP" % (
                    node.inst.inst_src_ref.filename,
                    node.inst.inst_src_ref.line,
                    node.inst.inst_src_ref.line_selection[0],
                    node.inst.inst_src_ref.line_text,
                    node.parent.get_path(array_suffix = "_{index:d}"),
                    node.get_path_segment(array_suffix = "_{index:d}")
                )
            )

        # check if memory width satisfies the requirement of 32 * (2^i)
        if not math.log2(node.get_property("memwidth", default=32) // 32).is_integer():
            message.error(
                "%s, %d, %d:\n%s\n"
                "width of memory %s requires a number of 32 * (2^i), such as 32, 64, 128..." % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix = "_{index:d}")
                )
            )

        # explicitly assign hj_use_abs_addr to false in a mem instance will be ignored and raise a warning
        if node.get_property("hj_use_abs_addr") is False:
            message.warning(
                "%s, %d, %d:\n%s\n"
                "current addrmap %s represents for regmst, so hj_use_abs_addr must be true" % (
                    node.inst.inst_src_ref.filename,
                    node.inst.inst_src_ref.line,
                    node.inst.inst_src_ref.line_selection[0],
                    node.inst.inst_src_ref.line_text,
                    node.get_path_segment(array_suffix = "_{index:d}")
                )
            )

        node.inst.properties["hj_use_abs_addr"] = False
        node.inst.properties["rtl_mod_name"] = "mem_{}".format(node.inst_name)
        self.is_in_ext_mem = True

    def exit_Mem(self, node):
        # debug message
        if not self.keep_quiet:
            message.debug(
                "%sExiting memory: %s" % (
                    "\t"*self.indent,
                    node.get_path_segment(array_suffix = "_{index:d}")
                )
            )

        self.is_in_ext_mem = False

    def enter_Regfile(self, node):
        # debug message
        if not self.keep_quiet:
            message.debug("%sEntering regfile: %s" % ("\t"*self.indent, node.get_path_segment(array_suffix = "_{index:d}")))

        # regfile can only be instantiated under regslv, flatten addrmap and 3rd party IP
        # except for pre-defined debug registers in regmst
        if node.parent.get_property("hj_gendisp") or node.parent.get_property("hj_genmst"):
            if not node.type_name == "db_regs":
                message.error("%s: illegal to instantiate other regfile under %s which is recognized as regdisp/regmst" %
                          (node.get_path_segment(array_suffix = "_{index:d}"), node.parent.get_path_segment(array_suffix = "_{index:d}")))

        self.reg_name.append(node.inst_name)

    def exit_Regfile(self, node):
        if not self.keep_quiet:
            message.debug("%sExiting regfile: %s" % ("\t"*self.indent, node.get_path_segment(array_suffix = "_{index:d}")))

        self.reg_name.pop()

    def enter_Reg(self, node):
        # physical implementation of alias registers is the same as the original register
        self.reg_name.append(node.alias_primary.inst_name if node.is_alias else node.inst_name)
        self.total_reg_num += 1

        if self.is_filtered:
            self.filter_reg_num += 1

    def exit_Reg(self, node):
        self.reg_name.pop()

    def enter_Field(self, node):
        if not self.is_in_3rd_party_IP:
            field_rtl_inst_name = "x__{reg_name}__{field_name}".format(
                reg_name="_".join(self.reg_name),
                field_name=node.inst_name
            )

            self.field_hdl_path.append("{}.field_value".format(field_rtl_inst_name))

            # assign hdl_path_slice for each field to recognize RTL hierarchy
            node.inst.properties["hdl_path_slice"] = [".".join(self.field_hdl_path)]

            if not self.keep_quiet:
                message.debug("%sgenerate hdl_path_slice: %s" %
                              ("\t"*self.indent, node.inst.properties["hdl_path_slice"][0]))

    def exit_Field(self, node):
        if not self.is_in_3rd_party_IP:
            self.field_hdl_path.pop()

    def enter_Component(self, node):
        self.indent += 1

        # remove an instance from UVM RAL model when it matches with filter patterns
        # by setting ispresent=false in that instance object
        self.runtime_stack.append(self.is_filtered)
        if self.is_filtered:
            node.inst.properties["ispresent"] = False
        else:
            if self.filter_pattern is not None:
                for pat in self.filter_pattern:
                    if fnmatchcase(node.get_path_segment(array_suffix = "_{index:d}"), pat):
                        self.is_filtered = True
                        node.inst.properties["ispresent"] = False
                        break

        if (not self.keep_quiet) and (not isinstance(node, FieldNode)):
            message.debug("%s%s %s, filtered: %s" % (
                "\t"*self.indent,
                node.get_path_segment(),
                hex(node.absolute_address) if isinstance(node, AddressableNode) else "",
                self.is_filtered))

    def exit_Component(self, node):
        self.indent -= 1
        self.is_filtered = self.runtime_stack.pop()

    def post_check(self):
        """
        """
        if len(self.all_rtl_mod) != len(set(self.all_rtl_mod)):
            message.error("duplicate RTL module names found, please check your addrmap instance names that "
                          "represent for regmst, regdisp or regslv modules")

    def get_report(self):
        """
        get some statistic information
        - total register number
        - filtered register number
        """
        message.info("HRDA preprocess report\n"
                     "------------------------------------------------\n"
                     "total register number: %d\n"
                     "total size: %s (%s) bytes\n"
                     "filtered register number in UVM simulation: %d\n"
                     "------------------------------------------------"
                     % (self.total_reg_num, self.total_size, hex(self.total_size), self.filter_reg_num))
        message.info("preprocessing time: %.4fs" % (time() - self.start_time))

def preprocess(root:RootNode, **user_ops):
    """
    traverse the register model
    """
    preprocess_walker = RDLWalker(unroll=True)
    preprocess_listener = PreprocessListener(user_ops)

    preprocess_walker.walk(root, preprocess_listener)

    preprocess_listener.post_check()
    preprocess_listener.get_report()
