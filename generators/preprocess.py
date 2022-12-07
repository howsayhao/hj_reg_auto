import math
from fnmatch import fnmatchcase
from time import time

import utils.message as message
from utils.misc import convert_size
from systemrdl import RDLListener, RDLWalker
from systemrdl.rdltypes import AccessType
from systemrdl.node import AddrmapNode, RegfileNode, RootNode, MemNode

# FIXME: array suffix

class DomainSecurityLevel:
    SECURE = 0
    NON_SECURE = 1
    CONFIGURABLE = 2

class PreprocessAddressHandler:
    """
    Handle address mapping preprocessing.
    """
    @staticmethod
    def remap_top_addrmap(root:RootNode):
        """
        It's so annoying that SystemRDL does not allow to allocate base address
        other than 0, so here is just a compromise solution
        """
        # base address assigned by user-defined property base_addr
        # only in addrmap at the top level
        if root.top.get_property("base_addr"):
            root.top.inst.addr_offset = root.top.get_property("base_addr")

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

    Additionally:
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
        self.is_in_regslv = False
        self.is_in_3rd_party_ip = False
        self.int_reg_addr_loc_num = 0   # only used in regslv
        self.int_reg_idx = []        # only used in regslv
        self.addr_list = []
        self.current_base_addr = 0
        self.runtime_stack = []

        self.total_reg_num = 0
        self.filter_reg_num = 0
        self.total_size = 0
        self.start_time = time()

        self.user_def_base_addr = 0

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

        # skip preprocess check
        self.skip_preprocess_check = user_ops.pop("skip_preprocess_check", False)

        message.info("HRDA Generator: start preprocessing")

    def enter_Addrmap(self, node):
        # debug message
        if not self.keep_quiet:
            message.debug(
                "addrmap: %s, address: 0x%x-0x%x, size: %s" % (
                    node.get_path_segment(array_suffix="_{index:d}"),
                    node.absolute_address,
                    node.absolute_address + node.size - 1,
                    convert_size(node.size)
                ), self.indent
            )

        # addrmap imported by IP-XACT (.xml) files are treated as 3rd party IP automatically
        if str(node.inst.def_src_ref.filename).endswith(".xml"):
            node.inst.properties["hj_3rd_party_ip"] = True

        # check if addrmap is assigned one of following properties exclusively:
        #   hj_gennetwork, hj_genmst, hj_gendisp, hj_genslv, hj_flatten_addrmap, hj_3rd_party_ip
        prop_num = 0
        for prop in self.prop_list:
            if node.get_property(prop):
                prop_num += 1
            else:
                node.inst.properties[prop] = False

        if prop_num == 0:
            if self.is_in_3rd_party_ip:
                node.inst.properties["hj_3rd_party_ip"] = True
            prop_num = 1

        if not self.skip_preprocess_check and not prop_num == 1:
            message.error(
                "%s, %d: %d:\n%s\n"
                "addrmap instance %s must be explicitly assigned one of following properties exclusively: "
                "hj_gennetwork, hj_genmst, hj_gendisp, hj_genslv, hj_flatten_addrmap, hj_3rd_party_ip" % (
                    self.ref.filename,
                    self.ref.line,
                    self.ref.line_selection[0],
                    self.ref.line_text,
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
            # for top-level (root) addrmap instance, calculate its total size
            self.total_size = node.total_size

        # the model traverses in addrmap which represents for an entity of register network
        if node.get_property("hj_gennetwork"):
            pass

        # the model traverses in addrmap which represents for regmst
        elif node.get_property("hj_genmst"):
            # debug message
            if not self.keep_quiet:
                message.debug(
                    "generate regmst_{}".format(node.get_path_segment(array_suffix="_{index:d}")),
                    self.indent
                )

            # check whether regmst addrmap consist of 2 immediate children:
            #   - regdisp
            #   - debug regfile (db_regs)
            iter = node.children(skip_not_present=False)

            try:
                # check whether first child of regmst is regdisp
                disp_node = next(iter)
                if not self.skip_preprocess_check and \
                    not (isinstance(disp_node, AddrmapNode) and
                    disp_node.get_property("hj_gendisp")):
                    message.error(
                        "%s, %d: %d:\n%s\n"
                        "first instance under regmst addrmap %s is not regdisp addrmap" % (
                            self.ref.filename,
                            self.ref.line,
                            self.ref.line_selection[0],
                            self.ref.line_text,
                            node.get_path_segment(array_suffix="_{index:d}")
                        )
                    )

                # check whether second child of regmst is debug regfile
                rf_node = next(iter)
                if not self.skip_preprocess_check and \
                    not (isinstance(rf_node, RegfileNode) and
                    rf_node.type_name == "db_regs" and
                    rf_node.inst_name == "db_regs"):
                    message.error(
                        "%s, %d: %d:\n%s\n"
                        "second instance under regmst addrmap %s is not debug regfile" % (
                            self.ref.filename,
                            self.ref.line,
                            self.ref.line_selection[0],
                            self.ref.line_text,
                            node.get_path_segment(array_suffix="_{index:d}")
                        )
                    )

            except message.HRDAError:
                # reraise HRDAError to the upper exception handler to
                # stop HRDA execution
                raise message.HRDAError

            except StopIteration:
                # less than 2 instances under regmst found
                if not self.skip_preprocess_check:
                    message.error(
                        "%s, %d: %d:\n%s\n"
                        "less than two instances under regmst addrmap %s found" % (
                            self.ref.filename,
                            self.ref.line,
                            self.ref.line_selection[0],
                            self.ref.line_text,
                            node.get_path_segment(array_suffix="_{index:d}")
                        )
                    )
            else:
                try:
                    next(iter)
                    # if there is no exception,
                    # more than 2 instances under regmst are found
                    if not self.skip_preprocess_check:
                        message.error(
                            "%s, %d: %d:\n%s\n"
                            "more than two instances under regmst addrmap %s found" % (
                                self.ref.filename,
                                self.ref.line,
                                self.ref.line_selection[0],
                                self.ref.line_text,
                                node.get_path_segment(array_suffix="_{index:d}")
                            )
                        )
                except StopIteration:
                    # actually it is a correct situation
                    pass

            # regmst defaults to use absolute address to decode and forward transactions
            if node.get_property("hj_use_abs_addr") is None:
                node.inst.properties["hj_use_abs_addr"] = True

            if not self.skip_preprocess_check and \
                not node.get_property("hj_use_abs_addr"):
                message.warning(
                    "%s, %d: %d:\n%s\n"
                    "addrmap %s represents for regmst, so hj_use_abs_addr is "
                    "recommended to be true (now is false)" % (
                        self.ref.filename,
                        self.ref.line,
                        self.ref.line_selection[0],
                        self.ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}")
                    )
                )

            # update rtl module names
            if not node.is_array or (node.is_array and node.current_idx[0] == 0):
                self.all_rtl_mod.append("regmst_{}".format(node.inst_name))
                node.inst.properties["rtl_name"] = "regmst_{}".format(node.inst_name)

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

            if not self.skip_preprocess_check:
                # check whether regdisp is instantiated at top level
                # or under addrmap which represents for regmst or regdisp
                if not isinstance(node.parent, RootNode) and \
                    not node.parent.get_property("hj_genmst") and \
                    not node.parent.get_property("hj_gendisp"):
                    message.error(
                        "%s, %d: %d:\n%s\n"
                        "addrmap %s represents for regdisp, so it must be instantiated at top level, "
                        "or under addrmap which represents for regmst or regdisp" % (
                            self.ref.filename,
                            self.ref.line,
                            self.ref.line_selection[0],
                            self.ref.line_text,
                            node.get_path_segment(array_suffix="_{index:d}")
                        )
                    )

                # the child of regdisp can only be:
                # regdisp, regslv, 3rd party IP, memory
                for child in node.children(skip_not_present=False):
                    if not ((isinstance(child, AddrmapNode) and (child.get_property("hj_gendisp") or \
                        child.get_property("hj_genslv") or child.get_property("hj_3rd_party_ip"))) \
                        or isinstance(child, MemNode)):
                        message.error(
                            "%s, %d: %d:\n%s\n"
                            "addrmap %s represents for regdisp, but its child %s is not one of the "
                            "following type: regdisp, regslv, 3rd party IP, memory" % (
                                self.ref.filename,
                                self.ref.line,
                                self.ref.line_selection[0],
                                self.ref.line_text,
                                node.get_path_segment(array_suffix="_{index:d}"),
                                child.get_path_segment(array_suffix="_{index:d}")
                            )
                        )

            # regdisp defaults to use address offset to decode and forward transactions
            if node.get_property("hj_use_abs_addr") is None:
                node.inst.properties["hj_use_abs_addr"] = False

            # update rtl module names
            if not node.is_array or (node.is_array and node.current_idx[0] == 0):
                self.all_rtl_mod.append("regdisp_{}".format(node.inst_name))
                node.inst.properties["rtl_name"] = "regdisp_{}".format(node.inst_name)

            # get total interface number this regdisp forwards to,
            # namely the number of downstream reg_native_if
            node.inst.properties["forward_num"] = len(list(node.children(unroll=True, skip_not_present=False)))

        # the model traverses in addrmap which represents for regslv
        elif node.get_property("hj_genslv"):
            # debug message
            if not self.keep_quiet:
                message.debug(
                    "generate regslv_{}, CDC enabled: {}".format(node.get_path_segment(array_suffix="_{index:d}"), bool(node.get_property("hj_cdc", default=False))),
                    self.indent
                )

            self.is_in_regslv = True
            self.int_reg_addr_loc_num = 0
            self.int_reg_idx = []
            self.addr_list = []
            self.current_base_addr = node.absolute_address

            # regslv defaults to use address offset to decode transactions
            if node.get_property("hj_use_abs_addr") is None:
                node.inst.properties["hj_use_abs_addr"] = False

            if not self.skip_preprocess_check and \
                node.get_property("hj_use_abs_addr"):
                message.warning(
                    "%s, %d: %d:\n%s\n"
                    "addrmap %s represents for regslv, so hj_use_abs_addr is recommended to be false" % (
                        self.ref.filename,
                        self.ref.line,
                        self.ref.line_selection[0],
                        self.ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}")
                    )
                )

            if not node.is_array or (node.is_array and node.current_idx[0] == 0):
                self.all_rtl_mod.append("regslv_{}".format(node.inst_name))
                node.inst.properties["rtl_name"] = "regslv_{}".format(node.inst_name)

            self.runtime_stack.append(self.field_hdl_path)
            self.field_hdl_path = [
                "regslv_{}".format(node.get_path_segment(array_suffix="_{index:d}"))
            ]

        # the model traverses in addrmap which will be flattened in the parent addrmap
        # so it represents for no RTL module
        elif node.get_property("hj_flatten_addrmap"):
            # flattened addrmap can only be defined under the addrmap instantiated as regslv
            if not self.skip_preprocess_check and \
                not node.parent.get_property("hj_genslv") and \
                not node.parent.get_property("hj_flatten_addrmap"):
                message.error(
                    "%s, %d: %d:\n%s\n"
                    "addrmap %s can only be flattened in parent addrmap which "
                    "represents for regslv or is also flattened, but parent addrmap %s does not." % (
                        self.ref.filename,
                        self.ref.line,
                        self.ref.line_selection[0],
                        self.ref.line_text,
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
                message.debug("Recognized as 3rd party IP, CDC enabled: {}".format(node.get_property("hj_cdc", default=False)), self.indent)

            if not node.parent.get_property("hj_3rd_party_ip", default=False):
                self.is_in_3rd_party_ip = True

                # as for 3rd party IP, hj_use_abs_addr needs to be assigned by user
                if not self.skip_preprocess_check and \
                    node.get_property("hj_use_abs_addr") is None:
                    message.warning(
                        "%s, %d: %d:\n%s\n"
                        "addrmap %s represents for 3rd party IP, but you don't explicitly "
                        "assign the property hj_use_abs_addr, and it will be assigned to false" % (
                            self.ref.filename,
                            self.ref.line,
                            self.ref.line_selection[0],
                            self.ref.line_text,
                            node.get_path_segment(array_suffix="_{index:d}")
                        )
                    )
                    # default: use address offset to decode accesses
                    node.inst.properties["hj_use_abs_addr"] = False

            node.inst.properties["ispresent"] = False
            node.inst.properties["rtl_name"] = node.inst_name

            self.is_filtered = True

    def exit_Addrmap(self, node):
        # pop properties of the parent addrmap instance from stack
        # once exiting new addrmap instance
        if node.get_property("hj_genmst") or \
            node.get_property("hj_genslv"):
            self.field_hdl_path = self.runtime_stack.pop()

        if node.get_property("hj_genslv"):
            node.inst.properties["int_reg_addr_loc_num"] = self.int_reg_addr_loc_num
            node.inst.properties["int_reg_idx"] = self.int_reg_idx
            node.inst.properties["addr_list"] = self.addr_list

            self.int_reg_addr_loc_num = 0
            self.int_reg_idx = []
            self.addr_list = []
            self.is_in_regslv = False

        if node.get_property("hj_flatten_addrmap"):
            self.reg_name.pop()

        if node.get_property("hj_3rd_party_ip") and \
            not node.parent.get_property("hj_3rd_party_ip", default=False):
            self.is_in_3rd_party_ip = False

        self.is_filtered = self.runtime_stack.pop()

    def enter_Mem(self, node):
        # memory imported by IP-XACT (.xml) files are treated as 3rd party IP automatically
        if str(node.inst.def_src_ref.filename).endswith(".xml"):
            node.inst.properties["hj_3rd_party_ip"] = True

        # debug message
        if not self.keep_quiet:
            message.debug(
                "memory: %s, address: 0x%x-0x%x, size: %s, CDC enabled: %s" % (
                    node.get_path_segment(array_suffix="_{index:d}"),
                    node.absolute_address,
                    node.absolute_address + node.size,
                    convert_size(node.size),
                    bool(node.get_property("hj_cdc", default=False))
                ), self.indent
            )

        # check if width of memory that are connected to regdisp satisfies the requirement of 32 * (2^i)
        if not self.skip_preprocess_check and node.parent.get_property("hj_gendisp") and \
            not math.log2(node.get_property("memwidth", default=32) // 32).is_integer():
            message.error(
                "%s, %d: %d:\n%s\n"
                "width of memory %s requires a number of 32 * (2^i), such as 32, 64, 128..." % (
                        self.ref.filename,
                        self.ref.line,
                        self.ref.line_selection[0],
                        self.ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}")
                )
            )

        # memory must use address offset to decode accesses
        node.inst.properties["hj_use_abs_addr"] = False

        node.inst.properties["rtl_name"] = "mem_{}".format(node.inst_name)

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

        self.reg_name.append(node.inst_name)

        # regfile can only be instantiated:
        #   - under regmst as debug registers (db_regs)
        #   - under regslv
        #   - under regfile (nested)
        #   - inside 3rd party IPs
        if not self.skip_preprocess_check and not self.is_in_3rd_party_ip \
            and isinstance(node.parent, AddrmapNode):
                if node.parent.get_property("hj_genmst"):
                    if not (node.type_name == "db_regs" and node.inst_name == "db_regs"):
                        message.error(
                            "%s, %d: %d:\n%s\n"
                            "illegal to instantiate regfile %s under %s which represents for regmst" % (
                                self.ref.filename,
                                self.ref.line,
                                self.ref.line_selection[0],
                                self.ref.line_text,
                                node.get_path_segment(array_suffix="_{index:d}"),
                                node.parent.get_path_segment(array_suffix="_{index:d}")
                            )
                        )
                else:
                    if not node.parent.get_property("hj_genslv"):
                        message.error(
                            "%s, %d: %d:\n%s\n"
                            "illegal to instantiate regfile %s under %s which is neither regslv nor regfile" % (
                                self.ref.filename,
                                self.ref.line,
                                self.ref.line_selection[0],
                                self.ref.line_text,
                                node.get_path_segment(array_suffix="_{index:d}"),
                                node.parent.get_path_segment(array_suffix="_{index:d}")
                            )
                        )

    def exit_Regfile(self, node):
        self.reg_name.pop()

    def enter_Reg(self, node):
        self.total_reg_num += 1

        if self.is_in_regslv:
            if not self.skip_preprocess_check and \
                node.size < 4:
                message.error(
                    "%s, %d: %d:\n%s\n"
                    "HRDA doesn't support internal registers with a size of less than 32 bit (4 byte), "
                    "but register %s has a size of %d byte, " % (
                        self.ref.filename,
                        self.ref.line,
                        self.ref.line_selection[0],
                        self.ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}"),
                        node.size
                    )
                )
            else:
                node.inst.properties["need_snapshot"] = (node.size > 4)

                self.int_reg_idx.append((
                    self.int_reg_addr_loc_num,
                    self.int_reg_addr_loc_num + node.size // 4 - 1
                ))

                self.addr_list.extend([
                        node.absolute_address - self.current_base_addr + i * 4 for i in range(node.size // 4)
                    ])
                self.int_reg_addr_loc_num += node.size // 4

        # physical implementation of alias registers is the same as the original register
        self.reg_name.append(node.alias_primary.inst_name if node.is_alias else node.inst_name)

        if self.is_filtered:
            self.filter_reg_num += 1

    def exit_Reg(self, node):
        self.reg_name.pop()

    def enter_Field(self, node):
        if node.get_property("hard_wired"):
            if not self.skip_preprocess_check and \
                node.get_property("hwclr") or node.get_property("hwset") or \
                not node.get_property("sw") == AccessType.r or node.get_property("onread"):
                message.error(
                    "%s, %d: %d:\n%s\n"
                    "hard-wired field %s is only allowed to have following access types: "
                    "hw = r/rw/na (without any side effect like hwclr or hwset), "
                    "sw = r (without any side effect like rset or rclr)" % (
                        self.ref.filename,
                        self.ref.line,
                        self.ref.line_selection[0],
                        self.ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}")
                    )
                )
            if not self.skip_preprocess_check and \
                node.get_property("hj_syncresetsignal"):
                message.error(
                    "%s, %d: %d:\n%s\n"
                    "hard-wired field %s is not allowed to have synchronous reset signals" % (
                        self.ref.filename,
                        self.ref.line,
                        self.ref.line_selection[0],
                        self.ref.line_text,
                        node.get_path_segment(array_suffix="_{index:d}")
                    )
                )
        if not self.skip_preprocess_check and \
            node.is_hw_writable and node.get_property("singlepulse"):
            message.warning(
                "%s, %d: %d:\n%s\n"
                "field %s is both hardware writable and software single pulse" % (
                    self.ref.filename,
                    self.ref.line,
                    self.ref.line_selection[0],
                    self.ref.line_text,
                    node.get_path_segment(array_suffix="_{index:d}")
                )
            )

        # if field is used for interrupt, the parent register must be an interrupt register
        if node.get_property("intr"):
            node.parent.inst.properties["intr"] = True

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

        # get instance source reference
        if node.inst.inst_src_ref:
            self.ref = node.inst.inst_src_ref
        elif node.inst.def_src_ref:
            self.ref = node.inst.def_src_ref
        else:
            message.error(
                "instance {} has no source reference".format(
                    node.inst_name
                )
            )

        if not hasattr(self.ref, "line"):
            self.ref.line = 1
        if not hasattr(self.ref, "line_selection"):
            self.ref.line_selection = [1, 1]
        if not hasattr(self.ref, "line_text"):
            self.ref.line_text = ""

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

        # secure/non-secure property check
        if isinstance(node, (AddrmapNode, MemNode)):
            secure_config_ref = node.get_property("secure_config_ref", default=None)

            if secure_config_ref:
                if node.get_property("secure_attr", default=DomainSecurityLevel.NON_SECURE) != \
                DomainSecurityLevel.CONFIGURABLE:
                    if not self.skip_preprocess_check:
                        message.error(
                            "%s, %d: %d:\n%s\n"
                            "property secure_config_ref is set in %s, "
                            "so it must have secure_attr set to configurable (secure_attr = 2)" % (
                                self.ref.filename,
                                self.ref.line,
                                self.ref.line_selection[0],
                                self.ref.line_text,
                                node.get_path_segment(array_suffix="_{index:d}")
                            )
                        )
                else:
                    if node.find_by_path(secure_config_ref) is None:
                        message.error(
                            "%s, %d: %d:\n%s\n"
                            "property secure_config_ref is set in %s, "
                            "but the path %s does not exist" % (
                                self.ref.filename,
                                self.ref.line,
                                self.ref.line_selection[0],
                                self.ref.line_text,
                                node.get_path_segment(array_suffix="_{index:d}"),
                                secure_config_ref
                            )
                        )


    def exit_Component(self, node):
        self.indent -= 1

        self.is_filtered = self.runtime_stack.pop()

    def post_check(self):
        """
        """
        dup = {x for x in self.all_rtl_mod if self.all_rtl_mod.count(x) > 1}

        if len(dup) > 0:
            message.warning(
                "following duplicate RTL module names found: %s, please check your addrmap "
                "instance names that represent for regmst, regdisp or regslv modules" % (", ".join(dup))
            )

    def get_report(self):
        """
        get some statistic information
        - total register number
        - filtered register number
        """
        message.info(
            "HRDA preprocess report\n"
            "------------------------------------------------\n"
            "total register number: %d\n"
            "total size: %s (%s bytes)\n"
            "filtered register number in UVM RAL model: %d\n"
            "preprocessing time: %.4fs\n"
            "------------------------------------------------" % (
                self.total_reg_num,
                convert_size(self.total_size),
                hex(self.total_size),
                self.filter_reg_num,
                time() - self.start_time
            )
        )

def preprocess(root:RootNode, **user_ops):
    """
    traverse the register model
    """
    PreprocessAddressHandler.remap_top_addrmap(root)

    preprocess_walker = RDLWalker(unroll=True, skip_not_present=False)
    preprocess_listener = PreprocessListener(user_ops)

    preprocess_walker.walk(root, preprocess_listener)

    message.info(
        "all type definitions in the root scope: %s" % (
            ", ".join(root.inst.comp_defs.keys())
        )
    )

    preprocess_listener.post_check()
    preprocess_listener.get_report()
