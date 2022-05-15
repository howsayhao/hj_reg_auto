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

    def enter_Addrmap(self, node):
        print("\t"*self.indent, "Entering addrmap: %s" % (node.get_path()))
        if isinstance(node.parent, RootNode):
            rtl_module_name = "regmst_{}".format(node.inst_name)
            print("\t"*self.indent, rtl_module_name)
        elif node.get_property("hj_genrtl"):
            print("\t"*self.indent, "generate regslv_%s" % (node.inst_name))

    def exit_Addrmap(self, node):
        print("\t"*self.indent, "Exiting addrmap: %s" % (node.get_path()))

    def enter_Regfile(self, node):
        print("\t"*self.indent, "Entering regfile: %s" % (node.get_path()))

    def exit_Regfile(self, node):
        print("\t"*self.indent, "Exiting regfile: %s" % (node.get_path()))

    def enter_Reg(self, node):
        print("\t"*self.indent, "Entering register: %s" % (node.get_path()))

    def exit_Reg(self, node):
        print("\t"*self.indent, "Exiting register: %s" % (node.get_path()))

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