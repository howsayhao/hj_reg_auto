import sys
from fnmatch import fnmatchcase
from time import time

import utils.message as message
from systemrdl import RDLListener, RDLWalker
from systemrdl.node import AddrmapNode, FieldNode, RootNode, MemNode, AddressableNode

# FIXME: node.inst_name vs. node.get_path_segment()
# thus hierarchical path for array would be ambiguous

class PreprocessListener(RDLListener):
    """
    A listener for the `preprocess_walker` which preprocesses the register model

    - insert `hdl_path_slice` properties for each `field` instance
    - complement user-defined properties for instances
        - hj_genmst
        - hj_genslv
        - hj_gendisp
        - hj_flatten_addrmap
        - hj_use_abs_addr
    - check whether there are illegal assignments and try to fix some wrong property assignments
    - filter some instances by setting ispresent=false, thus the UVM RAL model won't consists of them
    - complement RTL module names of all `addrmap` instances
    """
    def __init__(self, user_ops:dict):
        """
        set some properties used in the traverse process
        """
        self.indent = 0
        self.is_in_regmst = False
        self.is_in_regslv = False
        self.is_in_regdisp = False
        self.is_in_flatten_addrmap = False
        self.is_in_3rd_party_IP = False
        self.is_in_ext_mem = False
        self.is_filtered = False

        self.field_hdl_path = []
        self.reg_name = []
        self.reginst_name = []  # regslv/regdisp RTL module name (hierarchical)
        self.runtime_stack = []
        self.total_reg_num = 0
        self.filter_reg_num = 0
        self.total_size = 0
        self.start_time = time()

        # user-defined operations
        self.filter_pattern = user_ops.pop("filter", None)
        self.keep_quiet = user_ops.pop("quiet", False)

        message.info("Start preprocessing...")

    def enter_Addrmap(self, node):
        """
        handle `addrmap` instances and distinguish different RTL generation methods
        by recognizing `hj_genmst`, `hj_genslv`, `hj_gendisp` and `hj_flatten_addrmap`
        properties defined in SystemRDL

        There may be several RTL generation methods corresponding to `addrmap` instances:
        - regmst module
        - regslv module
        - regdisp module
        - flatten addrmap (no module)
        - 3rd party IP (forward interface)
        """
        if not self.keep_quiet:
            message.debug("%sEntering addrmap: %s" % ("\t"*self.indent, node.get_path()))

        # push properties of the parent addrmap instance to stack (protect)
        # once entering new addrmap instance
        self.runtime_stack.append((self.is_in_regmst,
                                   self.is_in_regslv,
                                   self.is_in_regdisp,
                                   self.is_in_flatten_addrmap,
                                   self.is_in_3rd_party_IP,
                                   self.is_filtered,
                                   self.field_hdl_path))

        # reset properties
        (self.is_in_regmst,
        self.is_in_regslv,
        self.is_in_regdisp,
        self.is_in_flatten_addrmap,
        self.is_in_3rd_party_IP,
        self.is_filtered) = False, False, False, False, False, False
        self.field_hdl_path = []

        # distinguish different types of addrmap
        if isinstance(node.parent, RootNode):
            # the model traverses in the root addrmap, so it shall generate a regmst module in RTL
            if (not node.get_property("hj_genmst") is True) or (not node.get_property("hj_flatten_addrmap") is False):
                message.warning("%s: the root/top addrmap is automatically treated as a regmst, "
                                "it's recommended to explicitly assign: hj_genmst=true, "
                                "hj_flatten_addrmap=false" % (node.get_path()))

            if node.get_property("hj_use_abs_addr") is False:
                message.warning("%s: the current addrmap is treated as a regmst, the property hj_use_abs_addr "
                                "is forced to true" % (node.get_path()))

            # set properties
            node.inst.properties["hj_genmst"] = True
            node.inst.properties["hj_genslv"] = False
            node.inst.properties["hj_gendisp"] = False
            node.inst.properties["hj_flatten_addrmap"] = False
            node.inst.properties["hj_3rd_party_IP"] = False
            node.inst.properties["hj_use_abs_addr"] = True

            self.is_in_regmst = True
            self.reginst_name.append(node.inst_name)
            rtl_module_name = "regmst_{}".format("__".join(self.reginst_name))
            node.inst.properties["rtl_module_name"] = rtl_module_name
            self.field_hdl_path.append(rtl_module_name)
            self.total_size = node.total_size

            if not self.keep_quiet:
                message.debug("%sgenerate %s" % ("\t"*self.indent, rtl_module_name))

        elif (isinstance(node.parent.parent, RootNode)) or \
                ((node.get_property("hj_gendisp", default=True)) and \
                (not self.is_in_flatten_addrmap) and \
                (not self.is_in_3rd_party_IP) and \
                (not node.inst.def_src_ref.filename.endswith(".xml"))):
            # the model traverses in the immediate sub-addrmap of root addrmap,
            # or in a sub-addrmap, hj_gendisp = true, hj_genmst/hj_genslv/hj_flatten_addrmap = <don't care>,
            # so it shall generate a regdisp module in RTL
            if (not node.get_property("hj_gendisp") is True) or \
                (not node.get_property("hj_flatten_addrmap") is False):
                message.warning("%s: the current addrmap is treated as a regdisp, it's recommended "
                                "to explicitly assign: hj_gendisp=true, hj_flatten_addrmap=false" % (node.get_path()))

            if node.get_property("hj_genmst") or node.get_property("hj_genslv"):
                message.error("%s: the property hj_genmst/hj_genslv is not allowed to assigned to true in an addrmap "
                              "treated as regdisp, possible reasons: immediate sub-addrmap of the root/top "
                              "addrmap is automatically treated as regdisp module, or you don't explicitly "
                              "assign hj_gendisp to false (default: true)" % (node.get_path()))
                sys.exit(1)

            for child in node.children(skip_not_present=False):
                if not isinstance(child, (AddrmapNode, MemNode)):
                    message.error("%s: addrmap recognized as a regdisp module is allowed to have immediate "
                                  "children of addrmap or mem type only, the child instance %s is illegal. "
                                  "If you do want a regslv, please explicitly assign hj_gendisp to false"
                                  % (node.get_path(), child.get_path()))
                    sys.exit(1)

            if node.get_property("hj_use_abs_addr") is False:
                message.warning("%s: the current addrmap is treated as a regdisp, the property hj_use_abs_addr "
                                "is forced to true" % (node.get_path()))

            # set properties
            node.inst.properties["hj_genmst"] = False
            node.inst.properties["hj_genslv"] = False
            node.inst.properties["hj_gendisp"] = True
            node.inst.properties["hj_flatten_addrmap"] = False
            node.inst.properties["hj_3rd_party_IP"] = False
            node.inst.properties["hj_use_abs_addr"] = True
            node.inst.properties["forward_num"] = len(list(node.children(unroll=True, skip_not_present=False)))

            self.is_in_regdisp = True
            self.reginst_name.append(node.inst_name)
            rtl_module_name = "regdisp_{}".format("__".join(self.reginst_name))
            node.inst.properties["rtl_module_name"] = rtl_module_name

            if not self.keep_quiet:
                message.debug("%sgenerate %s" % ("\t"*self.indent, rtl_module_name))

        elif (node.get_property("hj_genslv", default=True)) and \
            (not self.is_in_flatten_addrmap) and \
            (not self.is_in_3rd_party_IP) and \
            (not node.inst.def_src_ref.filename.endswith(".xml")):
            # the model traverses in a sub-addrmap, and hj_gendisp = false, hj_genslv = true/not declared,
            # hj_flatten_addrmap/hj_genmst = <don't care>, and it is this addrmap is neither
            # included in a flatten addramp, nor imported from IP-XACT,
            # so it shall generate a regslv module in RTL
            if (not node.get_property("hj_genslv") is True) or (not node.get_property("hj_flatten_addrmap") is False):
                message.warning("%s: the current addrmap is treated as a regslv, it's recommended "
                                "to explicitly assign: hj_genslv=true, hj_flatten_addrmap=false" % (node.get_path()))

            if node.get_property("hj_use_abs_addr"):
                message.warning("%s: the current addrmap is treated as a regslv, the property hj_use_abs_addr "
                                "is forced to false" % (node.get_path()))

            # set properties
            node.inst.properties["hj_genmst"] = False
            node.inst.properties["hj_genslv"] = True
            node.inst.properties["hj_gendisp"] = False
            node.inst.properties["hj_flatten_addrmap"] = False
            node.inst.properties["hj_3rd_party_IP"] = False
            node.inst.properties["hj_use_abs_addr"] = False

            self.is_in_regslv = True
            self.reginst_name.append(node.inst_name)

            rtl_module_name = "regslv_{}".format("__".join(self.reginst_name))
            node.inst.properties["rtl_module_name"] = rtl_module_name
            self.field_hdl_path.append(rtl_module_name)

            if not self.keep_quiet:
                message.debug("%sgenerate %s" % ("\t"*self.indent, rtl_module_name))

        elif (node.get_property("hj_flatten_addrmap", default=True) or self.is_in_flatten_addrmap) and \
            (not self.is_in_3rd_party_IP) and (not node.inst.def_src_ref.filename.endswith(".xml")):
            # the model traverses in a sub-addrmap, and hj_gendisp = false, hj_genmst = <don't care>,
            # hj_genslv = false, hj_flatten_addrmap = true/not declared, so it shall generate no module in RTL,
            # all components inside this addrmap will be flatten in the parent scope

            if node.get_property("hj_genmst") or node.get_property("hj_genslv") or node.get_property("hj_gendisp"):
                message.error("%s: the property hj_genmst/hj_genslv/hj_gendisp is not allowed to assigned to true in "
                              "an addrmap to be flatten, possible reasons: an ancestor addrmap instance is assigned"
                              "hj_flatten_addrmap=true, so all of its descendants will be flatten" % (node.get_path()))
                sys.exit(1)
            if not node.get_property("hj_flatten_addrmap"):
                message.warning("%s: the current addrmap is to be flatten in its parent scope, it's recommended "
                                "to explicitly assign: hj_flatten_addrmap=true" % (node.get_path()))

            # set properties
            node.inst.properties["hj_genmst"] = False
            node.inst.properties["hj_genslv"] = False
            node.inst.properties["hj_gendisp"] = False
            node.inst.properties["hj_flatten_addrmap"] = True
            node.inst.properties["hj_3rd_party_IP"] = False
            node.inst.properties["hj_use_abs_addr"] = False

            # flatten addrmap can only be defined under the addrmap instantiated as regslv
            if node.parent.get_property("hj_gendisp") or node.parent.get_property("hj_genmst"):
                message.error("%s: the addrmap cannot be flatten in the parent addrmap which "
                              "is instantiated as regdisp/regmst in RTL" % (node.get_path()))
                sys.exit(1)
            self.is_in_regslv = True

            self.is_in_flatten_addrmap = True
            self.reg_name.append(node.inst_name)
        else:
            # the model traverses in a sub-addrmap, which is imported from IP-XACT (.xml), or it satisfies:
            # hj_gendisp = false, hj_genslv = false, hj_genmst = false and hj_flatten_addrmap = false, so it
            # shall forward reg_native_if to 3rd party IP and no RTL module is generated

            if not node.parent.get_property("hj_gendisp"):
                message.error("%s: the parent addrmap %s is not recognized as regdisp, but 3rd party IP "
                              "must be forwarded by a regdisp module" % (node.get_path(), node.parent.get_path()))
                sys.exit(1)

            if node.get_property("hj_use_abs_addr") is None:
                message.warning("%s: the current addrmap is treated as a 3rd party IP, but you don't explicitly "
                                "assign the property hj_use_abs_addr, and it will be assigned to true" % (node.get_path()))

            # set properties
            node.inst.properties["hj_genmst"] = False
            node.inst.properties["hj_genslv"] = False
            node.inst.properties["hj_gendisp"] = False
            node.inst.properties["hj_flatten_addrmap"] = False
            node.inst.properties["hj_3rd_party_IP"] = True
            node.inst.properties["ispresent"] = False
            node.inst.properties["hj_use_abs_addr"] = True

            self.is_in_3rd_party_IP = True
            self.is_filtered = True
            if not self.keep_quiet:
                message.debug("%sRecognized as 3rd party IP" % ("\t"*self.indent))

    def exit_Addrmap(self, node):
        if not self.keep_quiet:
            message.debug("%sExiting addrmap: %s" % ("\t"*self.indent, node.get_path()))

        # pop properties of the parent addrmap instance to stack (restore)
        # once exiting new addrmap instance
        (self.is_in_regmst,
        self.is_in_regslv,
        self.is_in_regdisp,
        self.is_in_flatten_addrmap,
        self.is_in_3rd_party_IP,
        self.is_filtered,
        self.field_hdl_path) = self.runtime_stack.pop()

        if node.get_property("hj_genmst") or node.get_property("hj_genslv") or node.get_property("hj_gendisp"):
            self.reginst_name.pop()

    def enter_Mem(self, node):
        if not node.parent.get_property("hj_gendisp"):
            message.error("%s: the parent addrmap %s is not recognized as regdisp, but external memories"
                            "must be forwarded by a regdisp module" % (node.get_path(), node.parent.get_path()))
            sys.exit(1)

        if not self.keep_quiet:
            message.debug("%sEntering memory: %s" % ("\t"*self.indent, node.get_path()))

        if node.get_property("hj_use_abs_addr"):
            message.warning("%s: the property hj_use_abs_addr in a memory instance"
                            "is forced to false" % (node.get_path()))
        node.inst.properties["hj_use_abs_addr"] = False
        self.is_in_ext_mem = True

    def exit_Mem(self, node):
        if not self.keep_quiet:
            message.debug("%sExiting memory: %s" % ("\t"*self.indent, node.get_path()))

        self.is_in_ext_mem = False

    def enter_Regfile(self, node):
        if not self.keep_quiet:
            message.debug("%sEntering regfile: %s" % ("\t"*self.indent, node.get_path()))

        # regfile can only be instantiated under regslv, flatten addrmap and 3rd party IP
        if node.parent.get_property("hj_gendisp") or node.parent.get_property("hj_genmst"):
            message.error("%s: illegal to define regfile under %s which is recognized as regdisp/regmst" %
                          (node.get_path(), node.parent.get_path()))
            sys.exit(1)

        self.reg_name.append(node.inst_name)

    def exit_Regfile(self, node):
        if not self.keep_quiet:
            message.debug("%sExiting regfile: %s" % ("\t"*self.indent, node.get_path()))

        self.reg_name.pop()

    def enter_Reg(self, node):

        reg_rtl_inst_name = node.alias_primary.inst_name if node.is_alias else node.inst_name

        self.reg_name.append(reg_rtl_inst_name)
        self.total_reg_num += 1
        if self.is_filtered:
            self.filter_reg_num += 1

    def exit_Reg(self, node):
        self.reg_name.pop()

    def enter_Field(self, node):
        if not self.is_in_3rd_party_IP:
            field_rtl_inst_name = "x__{reg_name}__{field_name}".format(reg_name="_".join(self.reg_name),
                                                                       field_name=node.inst_name)
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
                    if fnmatchcase(node.get_path(), pat):
                        self.is_filtered = True
                        node.inst.properties["ispresent"] = False
                        break

        if (not self.keep_quiet) and (not isinstance(node, FieldNode)):
            message.debug("%s%s %s, filtered: %s" % (
                "\t"*self.indent,
                node.get_path_segment(),
                hex(node.absolute_address) if isinstance(node, AddressableNode) else "",
                self.is_filtered)
            )

    def exit_Component(self, node):
        self.indent -= 1
        self.is_filtered = self.runtime_stack.pop()

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
    preprocess_listener.get_report()
