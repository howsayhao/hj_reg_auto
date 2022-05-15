import utils.message as message

from systemrdl import RDLWalker
from systemrdl.node import RootNode

from systemrdl import RDLListener
from systemrdl.node import FieldNode

class PreprocessListener(RDLListener):
    """
    A listener for preprocessing the register model

    1. Traverse the compiled register model and
    insert hdl_path properties for each `reg` instance
    """
    def __init__(self):
        self.indent = 0
        self.rtl_path = []
        self.is_in_regslv = False
        self.is_in_regmst = False
        self.is_in_3rd_party_IP = False
        self.is_in_ext_mem = False

    def enter_Addrmap(self, node):
        """
        """
        print("\t"*self.indent, "Entering addrmap: %s" % (node.get_path()))

        if isinstance(node.parent, RootNode):
            self.is_in_regmst = True
            rtl_module_name = "regmst_{}".format(node.inst_name)
            print("\t"*self.indent, "generate", rtl_module_name)
        else:
            self.is_in_regmst = False
            if node.get_property("hj_genrtl"):
                self.is_in_regslv = True
                rtl_module_name = "regslv_{}".format(node.inst_name)
                print("\t"*self.indent, "generate", rtl_module_name)
            elif (not node.get_property("hj_genrtl")) and (not node.get_property("hj_flatten_addrmap")):
                self.is_in_3rd_party_IP = True
                rtl_module_name = node.inst_name
                print("\t"*self.indent, "generate reg_native_if for 3rd party IP: %s" % (node.inst_name))
            else:
                return

            self.rtl_path.append(rtl_module_name)

    def exit_Addrmap(self, node):
        """
        """
        print("\t"*self.indent, "Exiting addrmap: %s" % (node.get_path()))

        if isinstance(node.parent, RootNode):
            self.is_in_regmst = False
        else:
            self.is_in_regmst = True
            if node.get_property("hj_genrtl"):
                self.is_in_regslv = False
            elif (not node.get_property("hj_genrtl")) and (not node.get_property("hj_flatten_addrmap")):
                self.is_in_3rd_party_IP = False
            else:
                return

            self.rtl_path.pop()

    def enter_Mem(self, node):
        print("\t"*self.indent, "Entering memory: %s" % (node.get_path()))
        self.is_in_ext_mem = True

    def exit_Mem(self, node):
        print("\t"*self.indent, "Exiting memory: %s" % (node.get_path()))
        self.is_in_ext_mem = False

    def enter_Regfile(self, node):
        print("\t"*self.indent, "Entering regfile: %s" % (node.get_path()))

        self.rtl_path.append(node.inst_name)

    def exit_Regfile(self, node):
        print("\t"*self.indent, "Exiting regfile: %s" % (node.get_path()))

        self.rtl_path.pop()

    def enter_Reg(self, node):
        print("\t"*self.indent, "Entering register: %s" % (node.get_path()))

        if self.is_in_regmst:
            print("registers cannot be defined in regmst modules yet")
        elif self.is_in_regslv or self.is_in_3rd_party_IP:
            self.rtl_path.append(node.inst_name)
            node.inst.properties["hdl_path"] = ".".join(self.rtl_path)

    def exit_Reg(self, node):
        print("\t"*self.indent, "Exiting register: %s" % (node.get_path()))

        if self.is_in_regslv or self.is_in_3rd_party_IP:
            self.rtl_path.pop()

    def enter_Field(self, node):
        print("\t"*self.indent, "Entering field: %s" % (node.get_path()))

    def exit_Field(self, node):
        print("\t"*self.indent, "Exiting field: %s" % (node.get_path()))

    def enter_Signal(self, node):
        pass

    def exit_Signal(self, node):
        pass

    def enter_Component(self, node):
        if not isinstance(node, FieldNode):
            print("\t"*self.indent, node.get_path_segment())
            self.indent += 1

    def exit_Component(self, node):
        if not isinstance(node, FieldNode):
            self.indent -= 1

def preprocess(root:RootNode):
    # Traverse the register model
    walker = RDLWalker(unroll=True)
    walker.walk(root, PreprocessListener())