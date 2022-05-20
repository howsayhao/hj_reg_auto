import utils.message as message

from systemrdl import RDLWalker
from systemrdl.node import RootNode

from systemrdl import RDLListener
from systemrdl.node import FieldNode

class PreprocessListener(RDLListener):
    """
    A listener for preprocessing the register model

    1. insert hdl_path properties for each `field` instance
    2. complement user-defined properties for instances
        - hj_genrtl
        - hj_flatten_addrmap
    """
    def __init__(self):
        self.indent = 0
        self.is_in_regmst = False
        self.is_in_regslv = False
        self.is_in_flatten_addrmap = False
        self.is_in_3rd_party_IP = False
        self.is_in_ext_mem = False
        self.rtl_path = []
        self.reg_name = []
        self.regslv_name = []
        self.runtime_stack = []
        print("Start preprocessing......")

    def enter_Addrmap(self, node):
        """
        handle addrmap instances and distinguish different RTL generation methods
        by recognizing `hj_genrtl` and `hj_flatten_addrmap` properties in SystemRDL

        There may be several RTL generation methods corresponding to `addrmap` instances:
        - regmst module
        - regslv module
        - flatten addrmap (no module)
        - 3rd party IP
        """
        print("\t"*self.indent, "Entering addrmap: %s" % (node.get_path()))

        # push properties of the parent addrmap instance to stack (protect)
        # once entering new addrmap instance
        self.runtime_stack.append((self.is_in_regmst,
                                   self.is_in_regslv,
                                   self.is_in_flatten_addrmap,
                                   self.is_in_3rd_party_IP))

        if isinstance(node.parent, RootNode):
            # the model traverses in the root addrmap, and shall generate a regmst module in RTL

            # set properties
            node.inst.properties["hj_genrtl"] = True
            node.inst.properties["hj_flatten_addrmap"] = False

            self.is_in_regmst,
            self.is_in_regslv,
            self.is_in_flatten_addrmap,
            self.is_in_3rd_party_IP = True, False, False, False

            rtl_module_name = "regmst_{}".format(node.inst_name)
            self.rtl_path.append(rtl_module_name)
            print("\t"*self.indent, "generate", rtl_module_name)

        elif node.get_property("hj_genrtl", default=True):
            # the model traverses in a sub-addrmap, and shall generate a regslv module in RTL

            # set properties
            node.inst.properties["hj_genrtl"] = True
            node.inst.properties["hj_flatten_addrmap"] = False

            self.is_in_regmst,
            self.is_in_regslv,
            self.is_in_flatten_addrmap,
            self.is_in_3rd_party_IP = False, True, False, False

            self.regslv_name.append(node.inst_name)
            rtl_module_name = "regslv_{}".format("__".join(self.regslv_name))
            self.rtl_path.append(rtl_module_name)
            print("\t"*self.indent, "generate", rtl_module_name)

        elif node.get_property("hj_flatten_addrmap", default=True):
            # the model traverses in a sub-addrmap, and shall generate no module in RTL,
            # all components inside this addrmap will be flatten in the parent scope

            # set properties
            node.inst.properties["hj_genrtl"] = False
            node.inst.properties["hj_flatten_addrmap"] = True

            self.is_in_regmst,
            self.is_in_regslv,
            self.is_in_flatten_addrmap,
            self.is_in_3rd_party_IP = False, True, True, False

            self.reg_name.append(node.inst_name)
        else:
            # the model traverses in a sub-addrmap, and shall forward
            # reg_native_if to 3rd party IP, so no RTL module is generated

            # set properties
            node.inst.properties["hj_genrtl"] = False
            node.inst.properties["hj_flatten_addrmap"] = False

            self.is_in_regmst,
            self.is_in_regslv,
            self.is_in_3rd_party_IP = False, False, True

    def exit_Addrmap(self, node):
        """
        """
        print("\t"*self.indent, "Exiting addrmap: %s" % (node.get_path()))

        # pop properties of the parent addrmap instance to stack (restore)
        # once exiting new addrmap instance
        self.is_in_regmst,
        self.is_in_regslv,
        self.is_in_3rd_party_IP = self.runtime_stack.pop()

        self.rtl_path.pop()

    def enter_Mem(self, node):
        print("\t"*self.indent, "Entering memory: %s" % (node.get_path()))
        self.is_in_ext_mem = True

    def exit_Mem(self, node):
        print("\t"*self.indent, "Exiting memory: %s" % (node.get_path()))
        self.is_in_ext_mem = False

    def enter_Regfile(self, node):
        print("\t"*self.indent, "Entering regfile: %s" % (node.get_path()))

        self.reg_name.append(node.inst_name)

    def exit_Regfile(self, node):
        print("\t"*self.indent, "Exiting regfile: %s" % (node.get_path()))

        self.reg_name.pop()

    def enter_Reg(self, node):
        print("\t"*self.indent, "Entering register: %s" % (node.get_path()))

        self.is_alias = node.is_alias

        if self.is_alias:
            reg_rtl_inst_name = node.alias_primary.inst_name
        else:
            reg_rtl_inst_name = node.inst_name

        if self.need_flatten:
            self.reg_name = "{}_{}_{}".format(self.flatten_node.inst_name,
                                              self.flatten_node.get_rel_path(node.parent, hier_separator="_"),
                                              reg_rtl_inst_name)
        else:
            self.reg_name = reg_rtl_inst_name

    def exit_Reg(self, node):
        print("\t"*self.indent, "Exiting register: %s" % (node.get_path()))

        self.is_alias = False
        self.reg_name = ""

    def enter_Field(self, node):
        print("\t"*self.indent, "Entering field: %s" % (node.get_path()))

        if not self.is_in_3rd_party_IP:
            field_rtl_inst_name = "x__{reg_name}__{field_name}".format(reg_name=self.reg_name, field_name=node.inst_name)
            self.rtl_path.append("{}.field_value".format(field_rtl_inst_name))
            node.inst.properties["hdl_path_slice"] = [".".join(self.rtl_path)]
            print("\t"*self.indent, "generate hdl_path_slice: %s" % (node.inst.properties["hdl_path_slice"][0]))

    def exit_Field(self, node):
        print("\t"*self.indent, "Exiting field: %s" % (node.get_path()))

        if not self.is_in_3rd_party_IP:
            self.rtl_path.pop()

    def enter_Signal(self, node):
        pass

    def exit_Signal(self, node):
        pass

    def enter_Component(self, node):
        self.indent += 1
        if not isinstance(node, FieldNode):
            print("\t"*self.indent, node.get_path_segment())

    def exit_Component(self, node):
        self.indent -= 1

def preprocess(root:RootNode):
    # Traverse the register model
    walker = RDLWalker(unroll=True)
    walker.walk(root, PreprocessListener())