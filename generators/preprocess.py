import sys
from fnmatch import fnmatchcase
from time import time

from numpy import isin
from generators.rtl.rtl_type import Root

import utils.message as message
from systemrdl import RDLListener, RDLWalker
from systemrdl.node import FieldNode, RootNode, AddrmapNode


class PreprocessListener(RDLListener):
    """
    A listener for the `preprocess_walker` which preprocesses the register model

    - insert `hdl_path_slice` properties for each `field` instance
    - complement user-defined properties for instances
        - hj_genmst
        - hj_genslv
        - hj_gendisp
        - hj_flatten_addrmap
    - check whether there are illegal assignments and try to fix some wrong assignments
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
        self.reginst_name = []
        self.runtime_stack = []
        self.total_reg_num = 0
        self.filter_reg_num = 0
        self.total_size = 0
        self.start_time = time()

        # user-defined operations
        self.filter_pattern = user_ops.pop("filter", None)
        self.keep_quiet = user_ops.pop("quiet", False)

        print("Start preprocessing......")

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
        - 3rd party IP (forwarding interface)
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
                                   self.field_hdl_path))

        # reset properties
        (self.is_in_regmst,
        self.is_in_regslv,
        self.is_in_regdisp,
        self.is_in_flatten_addrmap,
        self.is_in_3rd_party_IP) = False, False, False, False, False
        self.field_hdl_path = []

        # distinguish different types of addrmap
        if isinstance(node.parent, RootNode):
            # the model traverses in the root addrmap, so it shall generate a regmst module in RTL
            if (not node.get_property("hj_genmst") is True) or (not node.get_property("hj_flatten_addrmap") is False):
                message.warning("the root/top addrmap is automatically treated as a regmst, "
                                "it's recommended to explicitly assign: hj_genmst=true, hj_flatten_addrmap=false")

            # set properties
            node.inst.properties["hj_genmst"] = True
            node.inst.properties["hj_genslv"] = False
            node.inst.properties["hj_gendisp"] = False
            node.inst.properties["hj_flatten_addrmap"] = False

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
                (not node.inst.def_src_ref.filename.endswith(".xml"))):
            # the model traverses in the immediate sub-addrmap of root addrmap,
            # or in a sub-addrmap, hj_gendisp = true, hj_genmst/hj_genslv/hj_flatten_addrmap = <don't care>,
            # so it shall generate a regdisp module in RTL
            if isinstance(node.parent.parent, RootNode) and \
                ((not node.get_property("hj_gendisp") is True) or \
                (not node.get_property("hj_flatten_addrmap") is False)):
                message.warning("the immediate sub-addrmap of the root/top addrmap is automatically treated as a regdisp, "
                                "it's recommended to explicitly assign: hj_gendisp=true, hj_flatten_addrmap=false")

            # set properties
            node.inst.properties["hj_genmst"] = False
            node.inst.properties["hj_genslv"] = False
            node.inst.properties["hj_gendisp"] = True
            node.inst.properties["hj_flatten_addrmap"] = False

            self.is_in_regdisp = True
            self.reginst_name.append(node.inst_name)
            rtl_module_name = "regdisp_{}".format("__".join(self.reginst_name))
            node.inst.properties["rtl_module_name"] = rtl_module_name

            if not self.keep_quiet:
                message.debug("%sgenerate %s" % ("\t"*self.indent, rtl_module_name))

        elif (node.get_property("hj_genslv", default=True)) and \
            (not self.is_in_flatten_addrmap) and \
            (not node.inst.def_src_ref.filename.endswith(".xml")):
            # the model traverses in a sub-addrmap, and hj_gendisp = false,
            # hj_genslv = true, hj_flatten_addrmap/hj_genmst = <don't care>
            # so it shall generate a regslv module in RTL
            # FIXME
            # set properties
            node.inst.properties["hj_genmst"] = False
            node.inst.properties["hj_genslv"] = True
            node.inst.properties["hj_gendisp"] = False
            node.inst.properties["hj_flatten_addrmap"] = False

            self.is_in_regslv = True
            self.reginst_name.append(node.inst_name)

            rtl_module_name = "regslv_{}".format("__".join(self.reginst_name))
            node.inst.properties["rtl_module_name"] = rtl_module_name
            self.field_hdl_path.append(rtl_module_name)

            if not self.keep_quiet:
                message.debug("%sgenerate%s" % ("\t"*self.indent, rtl_module_name))

        elif (node.get_property("hj_flatten_addrmap", default=True) or \
            self.is_in_flatten_addrmap) and \
            (not node.inst.def_src_ref.filename.endswith(".xml")):
            # hj_genrtl = False, hj_flatten_addrmap = True
            # the model traverses in a sub-addrmap, and shall generate no module in RTL,
            # all components inside this addrmap will be flatten in the parent scope
            # FIXME
            # explicitly assignment hj_genrtl=True is illegal under an addrmap
            # which is assigned hj_flatten_addrmap=True and will be ignored
            if node.get_property("hj_genrtl"):
                message.warning("property assignment hj_genrtl=true will be ignored because its parent "
                                "addrmap has assigned property hj_flatten_addrmap=true")

            # set properties
            node.inst.properties["hj_genrtl"] = False
            node.inst.properties["hj_flatten_addrmap"] = True

            if isinstance(node.parent.parent, RootNode):
                self.is_in_regmst = True
            else:
                self.is_in_regslv = True

            self.is_in_flatten_addrmap = True
            self.reg_name.append(node.inst_name)
        else:
            # hj_genrtl = False, hj_flatten_addrmap = False
            # the model traverses in a sub-addrmap, and shall forward
            # reg_native_if to 3rd party IP, so no RTL module is generated
            # FIXME
            # set properties
            node.inst.properties["hj_genrtl"] = False
            node.inst.properties["hj_flatten_addrmap"] = False

            self.is_in_3rd_party_IP = True
            if not self.keep_quiet:
                message.debug("%sRecognized as 3rd party IP: " % ("\t"*self.indent))

            ext_hdl_path = node.get_property("hj_ext_hdl_path_down", default="")
            if ext_hdl_path == "":
                message.error("external hdl path property (hj_ext_hdl_path_down) "
                              "for 3rd party IP: %s is not provided" % (node.inst_name))
                sys.exit(1)
            self.field_hdl_path.append(ext_hdl_path)

    def exit_Addrmap(self, node):
        """
        """
        print("\t"*self.indent, "Exiting addrmap: %s" % (node.get_path()))

        # pop properties of the parent addrmap instance to stack (restore)
        # once exiting new addrmap instance
        (self.is_in_regmst,
        self.is_in_regslv,
        self.is_in_regdisp,
        self.is_in_flatten_addrmap,
        self.is_in_3rd_party_IP,
        self.field_hdl_path) = self.runtime_stack.pop()
        # FIXME
        if (isinstance(node.parent, RootNode)) \
            or ((node.get_property("hj_genrtl", default=True)) \
            and (not self.is_in_flatten_addrmap)):
            self.reginst_name.pop()

    def enter_Mem(self, node):
        if not self.keep_quiet:
            message.debug("%sEntering memory: %s" % ("\t"*self.indent, node.get_path()))

        self.is_in_ext_mem = True

    def exit_Mem(self, node):
        if not self.keep_quiet:
            message.debug("%sExiting memory: %s" % ("\t"*self.indent, node.get_path()))

        self.is_in_ext_mem = False

    def enter_Regfile(self, node):
        if not self.keep_quiet:
            message.debug("%sEntering regfile: %s" % ("\t"*self.indent, node.get_path()))

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
            print("\t"*self.indent, "generate hdl_path_slice: %s" % (node.inst.properties["hdl_path_slice"][0]))
        else:
            # FIXME: 3rd party IP RTL path generation
            pass

    def exit_Field(self, node):
        if not self.is_in_3rd_party_IP:
            self.field_hdl_path.pop()
        else:
            # FIXME: 3rd party IP RTL path generation
            pass

    def enter_Signal(self, node):
        pass

    def exit_Signal(self, node):
        pass

    def enter_Component(self, node):
        self.indent += 1

        # remove a instance from UVM RAL model when matched with filter patterns
        # by setting ispresent=False in that instance object
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
            message.debug("%s%s, filtered: %s" % ("\t"*self.indent,
                                                  node.get_path_segment(),
                                                  self.is_filtered))

    def exit_Component(self, node):
        self.indent -= 1
        self.is_filtered = self.runtime_stack.pop()

    def get_statistics(self):
        """
        get some statistic information
        - total register number
        - filtered register number
        """
        message.info("total register number: %d" % (self.total_reg_num))
        message.info("total size: %s bytes" % (hex(self.total_size)))
        message.info("UVM filtered register number: %d" % (self.filter_reg_num))
        message.info("preprocessing time: %.4fs" % (time() - self.start_time))

def preprocess(root:RootNode, **user_ops):
    """
    traverse the register model
    """
    preprocess_walker = RDLWalker(unroll=True)
    preprocess_listener = PreprocessListener(user_ops)
    preprocess_walker.walk(root, preprocess_listener)
    preprocess_listener.get_statistics()
