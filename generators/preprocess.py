import math
from fnmatch import fnmatchcase
from time import time

import utils.message as message
from utils.misc import convert_size
from systemrdl import RDLListener, RDLWalker
from systemrdl.node import AddrmapNode, RegfileNode , FieldNode, RootNode, MemNode, SignalNode


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

        self.is_filtered = False

        self.all_rtl_mod = []
        self.field_hdl_path = []
        self.reg_name = []
        self.runtime_stack = []
        self.total_reg_num = 0
        self.filter_reg_num = 0
        self.total_size = 0
        self.start_time = time()

        # 6 types of addrmap instance
        self.prop_list = [
            "hj_gennetwork",
            "hj_genmst",
            "hj_gendisp",
            "hj_genslv",
            "hj_flatten_addrmap",
            "hj_3rd_party_ip"
        ]


        # user-defined operations
        # filter
        self.filter_pattern = user_ops.pop("filter", None)
        # keep quiet to screen debug message
        self.keep_quiet = user_ops.pop("quiet", False)

        message.info("HRDA Generator: start preprocessing")

    def enter_Addrmap(self, node):
        # debug message
        if not self.keep_quiet:
            message.debug(
                "addrmap: %s, address: 0x%x-0x%x, size: %s" % (
                    node.get_path_segment(array_suffix="_{index:d}"),
                    node.absolute_address,
                    node.absolute_address + node.size,
                    convert_size(node.size)
                ), self.indent
            )

        # addrmap imported by IP-XACT (.xml) files are treated as 3rd party IP automatically
        if node.inst.def_src_ref.filename.endswith(".xml"):
            node.inst.properties["hj_3rd_party_ip"] = True

        # check if addrmap is assigned one of following properties exclusively:
        #   hj_gennetwork, hj_genmst, hj_gendisp, hj_genslv, hj_flatten_addrmap, hj_3rd_party_ip
        prop_num = 0
        for prop in self.prop_list:
            if node.get_property(prop):
                prop_num += 1
            else:
                node.inst.properties[prop] = False

        if not prop_num == 1:
            message.error(
                "%s, %d: %d:\n%s\n"
                "addrmap instance %s must be explicitly assigned one of following properties exclusively: "
                "hj_gennetwork, hj_genmst, hj_gendisp, hj_genslv, hj_flatten_addrmap, hj_3rd_party_ip" % (
                    node.inst.inst_src_ref.filename,
                    node.inst.inst_src_ref.line,
                    node.inst.inst_src_ref.line_selection[0],
                    node.inst.inst_src_ref.line_text,
                    node.get_path_segment(array_suffix="_{index:d}"),
                )
            )

        # push properties of the parent addrmap instance to stack
        # once entering new addrmap instance
        self.runtime_stack.append(self.is_filtered)

        self.is_filtered = False

        # ========================================================================================================
        # distinguish different types and hierarchical levels of addrmap
        # - soc level
        #     - first-level addrmap contains the whole register network on the chip
        #     - second-level addrmap contains a register tree and corresponds to regmst
        #     - third-level addrmap corresponds to regdisp under regmst directly
        # - subsystem level
        #     - fourth-level addrmap contains all register components for one subsystem and corresponds to regdisp
        #     - fifth-level addrmap or mem may corresponds to regslv, memory, 3rd party IP, regdisp or simply be
        #       flattened in the parent addrmap
        #     - downstream levels can be extended by adding regdisp
        # ========================================================================================================

        if isinstance(node.parent, RootNode):
            # top-level addrmap instance can only be register network, regdisp or regslv
            if not (node.get_property("hj_gennetwork") or
                    node.get_property("hj_gendisp") or
                    node.get_property("hj_genslv")):
                message.error(
                    "%s, %d: %d:\n%s\n"
                    "top-level addrmap instance %s can only be one of following types: "
                    "reg_network, regdisp, regslv" % (
                        node.inst.def_src_ref.filename,
                        node.inst.def_src_ref.line,
                        node.inst.def_src_ref.line_selection[0],
                        node.inst.def_src_ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}"),
                    )
                )

            # for top-level (root) addrmap instance, calculate its total size
            self.total_size = node.total_size

        # the model traverses in addrmap which represents for the whole register network
        if node.get_property("hj_gennetwork"):
            # check whether addrmap which represents for the whole register network
            # is a top-level (root) addrmap instance
            if not isinstance(node.parent, RootNode):
                message.error(
                    "%s, %d: %d:\n%s\n"
                    "current addrmap %s represents for the whole register network, "
                    "so it must be a top-level (root) addrmap instance" % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}"),
                    )
                )

        # the model traverses in addrmap which represents for regmst
        elif node.get_property("hj_genmst"):
            # debug message
            if not self.keep_quiet:
                message.debug("generate regmst_{}".format(node.inst_name), self.indent)

            # check whether regmst is instantiated under addrmap which represents for the whole register network,
            # if not, its address allocation will be wrong
            if not node.parent.get_property("hj_gennetwork"):
                message.error(
                    "%s, %d: %d:\n%s\n"
                    "current addrmap %s represents for regmst, "
                    "so it must be instantiated under addrmap which represents for the whole register network" % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}"),
                    )
                )

            # check whether regmst addrmap consist of 2 immediate children:
            #   - regdisp
            #   - debug regfile (db_regs)
            iter = node.children(skip_not_present=False)

            try:
                # check whether first child of regmst is regdisp
                disp_node = next(iter)
                if not (isinstance(disp_node, AddrmapNode) and
                    disp_node.get_property("hj_gendisp")):
                    message.error(
                        "%s, %d: %d:\n%s\n"
                        "first instance under regmst addrmap %s is not regdisp addrmap" % (
                            node.inst.inst_src_ref.filename,
                            node.inst.inst_src_ref.line,
                            node.inst.inst_src_ref.line_selection[0],
                            node.inst.inst_src_ref.line_text,
                            node.get_path_segment(array_suffix="_{index:d}")
                        )
                    )

                # check whether second child of regmst is debug regfile
                rf_node = next(iter)
                if not (isinstance(rf_node, RegfileNode) and
                    node.type_name == "db_regs" and
                    node.inst_name == "db_regs"):
                    message.error(
                        "%s, %d: %d:\n%s\n"
                        "second instance under regmst addrmap %s is not debug regfile" % (
                            node.inst.inst_src_ref.filename,
                            node.inst.inst_src_ref.line,
                            node.inst.inst_src_ref.line_selection[0],
                            node.inst.inst_src_ref.line_text,
                            node.get_path_segment(array_suffix="_{index:d}")
                        )
                    )

            except message.HRDAError:
                # reraise HRDAError to the upper exception handler to
                # stop HRDA execution
                raise message.HRDAError

            except StopIteration:
                # less than 2 instances under regmst found
                message.error(
                    "%s, %d: %d:\n%s\n"
                    "less than two instances under regmst addrmap %s found" % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}")
                    )
                )
            else:
                try:
                    next(iter)
                    # if there is no exception,
                    # more than 2 instances under regmst are found
                    message.error(
                        "%s, %d: %d:\n%s\n"
                        "more than two instances under regmst addrmap %s found" % (
                            node.inst.inst_src_ref.filename,
                            node.inst.inst_src_ref.line,
                            node.inst.inst_src_ref.line_selection[0],
                            node.inst.inst_src_ref.line_text,
                            node.get_path_segment(array_suffix="_{index:d}")
                        )
                    )
                except StopIteration:
                    # actually it is a correct situation
                    pass

            # regmst uses absolute address to decode and forward transactions
            if node.get_property("hj_use_abs_addr") is False:
                message.warning(
                    "%s, %d: %d:\n%s\n"
                    "current addrmap %s represents for regmst, so hj_use_abs_addr must be true" % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}")
                    )
                )

            node.inst.properties["hj_use_abs_addr"] = True

            # update rtl module names
            self.all_rtl_mod.append("regmst_{}".format(node.inst_name))
            node.inst.properties["rtl_mod_name"] = "regmst_{}".format(node.inst_name)

            # push field hdl path to stack and update it with current addrmap instance
            self.runtime_stack.append(self.field_hdl_path)
            self.field_hdl_path = [
                "regmst_{}".format(node.inst_name)
            ]

        # the model traverses in addrmap which represents for regdisp
        elif node.get_property("hj_gendisp"):
            # debug message
            if not self.keep_quiet:
                message.debug("generate regdisp_{}".format(node.inst_name), self.indent)

            # check whether regdisp is instantiated under addrmap which represents for regmst or regdisp
            if not isinstance(node.parent, RootNode) and \
                not node.parent.get_property("hj_genmst") and \
                not node.parent.get_property("hj_gendisp"):
                message.error(
                    "%s, %d: %d:\n%s\n"
                    "current addrmap %s represents for regdisp, so it must be instantiated at top level, "
                    "or under addrmap which represents for regmst or regdisp, but parent addrmap %s does not" % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}"),
                        node.parent.get_path_segment(array_suffix="_{index:d}")
                    )
                )

            # regdisp uses absolute address to decode and forward transactions
            if node.get_property("hj_use_abs_addr") is False:
                message.warning(
                    "%s, %d: %d:\n%s\n"
                    "current addrmap %s represents for regdisp, so hj_use_abs_addr must be true" % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}")
                    )
                )

            node.inst.properties["hj_use_abs_addr"] = True

            # update rtl module names
            self.all_rtl_mod.append("regdisp_{}".format(node.inst_name))
            node.inst.properties["rtl_mod_name"] = "regdisp_{}".format(node.inst_name)

            node.inst.properties["forward_num"] = len(list(node.children(unroll=True, skip_not_present=False)))

        # the model traverses in addrmap which represents for regslv
        elif node.get_property("hj_genslv"):
            # debug message
            if not self.keep_quiet:
                message.debug(
                    "generate regslv_{}".format(node.get_path_segment(array_suffix="_{index:d}")),
                    self.indent
                )

            if not isinstance(node.parent, RootNode) and \
                not node.parent.get_property("hj_gendisp"):
                message.error(
                    "%s, %d: %d:\n%s\n"
                    "current addrmap %s represents for regslv, so it must be instantiated at top level, "
                    "or under addrmap which represents for regdisp, but parent addrmap %s does not" % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}"),
                        node.parent.get_path_segment(array_suffix="_{index:d}")
                    )
                )

            # regslv uses absolute address to decode transactions
            if node.get_property("hj_use_abs_addr"):
                message.warning(
                    "%s, %d: %d:\n%s\n"
                    "current addrmap %s represents for regslv, so hj_use_abs_addr must be false" % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}")
                    )
                )

            node.inst.properties["hj_use_abs_addr"] = False

            # SystemRDL instance properties do not need array suffix
            node.inst.properties["rtl_mod_name"] = "regslv_{}".format(node.inst_name)

            # array instance in SystemRDL needs index suffix of corresponding RTL module names
            self.all_rtl_mod.append("regslv_{}".format(node.get_path_segment(array_suffix="_{index:d}")))

            self.runtime_stack.append(self.field_hdl_path)
            self.field_hdl_path = [
                "regslv_{}".format(node.get_path_segment(array_suffix="_{index:d}"))
            ]

        # the model traverses in addrmap which will be flattened in the parent addrmap
        # so it represents for no RTL module
        elif node.get_property("hj_flatten_addrmap"):

            # flattened addrmap can only be defined under the addrmap instantiated as regslv
            if not node.parent.get_property("hj_genslv") and not node.parent.get_property("hj_flatten_addrmap"):
                message.error(
                    "%s, %d: %d:\n%s\n"
                    "current addrmap %s can only be flattened in parent addrmap which "
                    "represents for regslv or is also flattened, but parent addrmap %s does not." % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}"),
                        node.parent.get_path_segment(array_suffix="_{index:d}")
                    )
                )

            # RTL port names of registers inside flattened addrmap will be prefixed with the
            # flattened addrmap name to avoid name collision
            self.reg_name.append(node.get_path_segment(array_suffix="_{index:d}"))

            # flattened addrmap does not use address
            node.inst.properties["hj_use_abs_addr"] = False

        # the model traverses in addrmap which represents for 3rd party IP
        elif node.get_property("hj_3rd_party_ip"):
            # debug message
            if not self.keep_quiet:
                message.debug("Recognized as 3rd party IP", self.indent)

            # check whether 3rd party IP are forwarded by regdisp
            if not node.parent.get_property("hj_gendisp") and not node.parent.get_property("hj_3rd_party_ip"):
                message.error(
                    "%s, %d: %d:\n%s\n"
                    "current addrmap %s representing for 3rd party IP must be covered by 3rd party IP addrmap, "
                    "or have a parent addrmap which represents for regdisp, but parent addrmap %s does not." % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}"),
                        node.parent.get_path_segment(array_suffix="_{index:d}")
                    )
                )

            # as for 3rd party IP, hj_use_abs_addr needs to be assigned by user
            if node.get_property("hj_use_abs_addr") is None:
                message.warning(
                    "%s, %d: %d:\n%s\n"
                    "current addrmap %s represents for 3rd party IP, but you don't explicitly "
                    "assign the property hj_use_abs_addr, and it will be assigned to true" % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}")
                    )
                )
                # write default value
                node.inst.properties["hj_use_abs_addr"] = True

            node.inst.properties["hj_3rd_party_ip"] = True
            node.inst.properties["ispresent"] = False

            node.inst.properties["rtl_mod_name"] = node.inst_name

            self.is_filtered = True

    def exit_Addrmap(self, node):
        # pop properties of the parent addrmap instance from stack
        # once exiting new addrmap instance
        if node.get_property("hj_genmst") or \
            node.get_property("hj_genslv"):
            self.field_hdl_path = self.runtime_stack.pop()

        if node.get_property("hj_flatten_addrmap"):
            self.reg_name.pop()

        self.is_filtered = self.runtime_stack.pop()

    def enter_Mem(self, node):
        # debug message
        if not self.keep_quiet:
            message.debug(
                "memory: %s, address: 0x%x-0x%x, size: %s" % (
                    node.get_path_segment(array_suffix="_{index:d}"),
                    node.absolute_address,
                    node.absolute_address + node.size,
                    convert_size(node.size)
                ), self.indent
            )

        if not node.parent.get_property("hj_gendisp") and \
            not node.parent.get_property("hj_3rd_party_ip"):
            message.error(
                "%s, %d: %d:\n%s\n"
                "the parent addrmap %s of memory instance %s is not recognized as "
                "regdisp or 3rd party IP, and memories must be forwarded by a regdisp or 3rd party IP" % (
                    node.inst.inst_src_ref.filename,
                    node.inst.inst_src_ref.line,
                    node.inst.inst_src_ref.line_selection[0],
                    node.inst.inst_src_ref.line_text,
                    node.parent.get_path_segment(array_suffix="_{index:d}"),
                    node.get_path_segment(array_suffix="_{index:d}")
                )
            )

        # check if memory width satisfies the requirement of 32 * (2^i)
        if not math.log2(node.get_property("memwidth", default=32) // 32).is_integer():
            message.error(
                "%s, %d: %d:\n%s\n"
                "width of memory %s requires a number of 32 * (2^i), such as 32, 64, 128..." % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}")
                )
            )

        # explicitly assign hj_use_abs_addr to false in a mem instance will be ignored and raise a warning
        if node.get_property("hj_use_abs_addr") is False:
            message.warning(
                "%s, %d: %d:\n%s\n"
                "current addrmap %s represents for regmst, so hj_use_abs_addr must be true" % (
                    node.inst.inst_src_ref.filename,
                    node.inst.inst_src_ref.line,
                    node.inst.inst_src_ref.line_selection[0],
                    node.inst.inst_src_ref.line_text,
                    node.get_path_segment(array_suffix="_{index:d}")
                )
            )

        node.inst.properties["hj_use_abs_addr"] = False
        node.inst.properties["rtl_mod_name"] = "mem_{}".format(node.inst_name)

    def exit_Mem(self, node):
        pass

    def enter_Regfile(self, node):
        # debug message
        if not self.keep_quiet:
            message.debug(
                "regfile: %s, address: 0x%x-0x%x, size: %s" % (
                    node.get_path_segment(array_suffix="_{index:d}"),
                    node.absolute_address,
                    node.absolute_address + node.size,
                    convert_size(node.size)
                ), self.indent
            )

        # regfile can only be instantiated:
        #   - under regmst as debug registers (db_regs)
        #   - under regslv
        #   - under regfile (nested)
        if node.parent.get_property("hj_genmst") and not (
                node.type_name == "db_regs" and
                node.inst_name == "db_regs"
            ):
                message.error(
                    "%s, %d: %d:\n%s\n"
                    "illegal to instantiate regfile %s under %s which represents for regmst" % (
                        node.inst.inst_src_ref.filename,
                        node.inst.inst_src_ref.line,
                        node.inst.inst_src_ref.line_selection[0],
                        node.inst.inst_src_ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}"),
                        node.parent.get_path_segment(array_suffix="_{index:d}")
                    )
                )
        elif not node.parent.get_property("hj_genslv") and \
            not isinstance(node.parent, RegfileNode):
            message.error(
                "%s, %d: %d:\n%s\n"
                "illegal to instantiate regfile %s under %s which is neither regslv nor regfile" % (
                    node.inst.inst_src_ref.filename,
                    node.inst.inst_src_ref.line,
                    node.inst.inst_src_ref.line_selection[0],
                    node.inst.inst_src_ref.line_text,
                    node.get_path_segment(array_suffix="_{index:d}"),
                    node.parent.get_path_segment(array_suffix="_{index:d}")
                )
            )
        if not self.is_filtered:
            self.reg_name.append(node.inst_name)

    def exit_Regfile(self, node):
        if not self.is_filtered:
            self.reg_name.pop()

    def enter_Reg(self, node):
        self.total_reg_num += 1

        if not self.is_filtered:
            # physical implementation of alias registers is the same as the original register
            self.reg_name.append(node.alias_primary.inst_name if node.is_alias else node.inst_name)

        else:
            self.filter_reg_num += 1

    def exit_Reg(self, node):
        if not self.is_filtered:
            self.reg_name.pop()

    def enter_Field(self, node):
        # hdl_path_slice of filtered fields will be ignored in generated uvm ral model
        if not self.is_filtered:
            field_rtl_inst_name = "x__{reg_name}__{field_name}".format(
                reg_name="_".join(self.reg_name),
                field_name=node.inst_name
            )

            self.field_hdl_path.append("{}.field_value".format(field_rtl_inst_name))

            # assign hdl_path_slice for each field to recognize RTL hierarchy
            node.inst.properties["hdl_path_slice"] = [
                ".".join(self.field_hdl_path)
            ]

    def exit_Field(self, node):
        if not self.is_filtered:
            self.field_hdl_path.pop()

    def enter_Component(self, node):
        self.indent += 1

        self.runtime_stack.append(self.is_filtered)

        # remove an instance from uvm ral model when it matches with filter patterns
        # by setting ispresent=false in that instance object
        if self.is_filtered:
            node.inst.properties["ispresent"] = False

        else:
            if self.filter_pattern is not None:
                for pat in self.filter_pattern:
                    if fnmatchcase(node.get_path_segment(array_suffix="_{index:d}"), pat):
                        self.is_filtered = True
                        node.inst.properties["ispresent"] = False
                        break

    def exit_Component(self, node):
        self.indent -= 1

        self.is_filtered = self.runtime_stack.pop()

    def post_check(self):
        """
        """
        if len(self.all_rtl_mod) != len(set(self.all_rtl_mod)):
            message.error(
                "duplicate RTL module names found, please check your addrmap instance names that "
                "represent for regmst, regdisp or regslv modules"
            )

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
