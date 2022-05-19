from dataclasses import field
from email.policy import default
import utils.message as message

from systemrdl import RDLWalker
from systemrdl.node import RootNode

from systemrdl import RDLListener
from systemrdl.node import FieldNode

class PreprocessListener(RDLListener):
    """
    A listener for preprocessing the register model

    1. insert hdl_path properties for each `field` instance
    2. complete user-defined properties
    """
    def __init__(self):
        self.indent = 0
        self.rtl_path = []
        self.is_in_regslv = False
        self.is_in_regmst = False
        self.is_in_3rd_party_IP = False
        self.is_in_ext_mem = False
        self.gen_rtl_module = False
        self.need_flatten = False
        self.flatten_node = None
        self.reg_name = ""
        self.is_alias = False
        print("Start preprocessing......\n", "-"*20)

    def enter_Addrmap(self, node):
        """
        """
        print("\t"*self.indent, "Entering addrmap: %s" % (node.get_path()))
        rtl_hierarchy = node.get_path().replace(".", "__")

        if isinstance(node.parent, RootNode):
            # the model traverses in the root addrmap,
            # and shall generate a regmst module in RTL
            self.is_in_regmst = True
            self.gen_rtl_module = True
            rtl_module_name = "regmst_{}".format(rtl_hierarchy)
            print("\t"*self.indent, "generate", rtl_module_name)
        else:
            if (self.is_in_regmst):
                self.is_in_regmst = False
                if (node.get_property("hj_genrtl", default=True)):
                    # from regmst to downstream regslv
                    self.rtl_path.pop()
                else:
                    # from regmst to flatten addrmap or 3rd party IPs
                    rtl_hierarchy = node.parent.get_path().replace(".", "__")

            if node.get_property("hj_genrtl", default=True):
                self.is_in_regslv = True
                self.gen_rtl_module = True
                rtl_module_name = "regslv_{}".format(rtl_hierarchy)
                print("\t"*self.indent, "generate", rtl_module_name)
            elif (not node.get_property("hj_genrtl", default=True)) and (not node.get_property("hj_flatten_addrmap", default=True)):
                self.is_in_3rd_party_IP = True
                rtl_module_name = node.inst_name
                print("\t"*self.indent, "generate reg_native_if for 3rd party IP: %s" % (node.inst_name))

        if (not self.gen_rtl_module) and (not self.is_in_3rd_party_IP):
            self.need_flatten = True
            self.flatten_node = node
            return

        self.rtl_path.append(rtl_module_name)

    def exit_Addrmap(self, node):
        """
        """
        print("\t"*self.indent, "Exiting addrmap: %s" % (node.get_path()))

        if (not self.gen_rtl_module) and (not self.is_in_3rd_party_IP):
            self.need_flatten = False
            self.flatten_node = None

        if isinstance(node.parent, RootNode):
            self.is_in_regmst = False
            self.gen_rtl_module = False
        else:
            if isinstance(node.parent.parent, RootNode):
                self.is_in_regmst = True

            if node.get_property("hj_genrtl", default=True):
                self.is_in_regslv = False
                self.gen_rtl_module = False
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

    def exit_Regfile(self, node):
        print("\t"*self.indent, "Exiting regfile: %s" % (node.get_path()))

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