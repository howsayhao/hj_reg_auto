import sys
from fnmatch import fnmatchcase
from time import time

import utils.message as message
from systemrdl import RDLListener, RDLWalker
from systemrdl.node import FieldNode, RootNode, AddrmapNode


class PreprocessListener(RDLListener):
    """
    A listener for the `preprocess_walker` which preprocesses the register model

    - insert `hdl_path_slice` properties for each `field` instance
    - complement user-defined properties for instances
        - hj_genrtl
        - hj_flatten_addrmap
    - check whether there are illegal assignments
    - filter some instances by setting ispresent=false in the UVM RAL model
    """
    def __init__(self, user_ops:dict):
        """
        set some properties used in the traverse process
        """
        self.indent = 0
        self.is_in_regmst = False
        self.is_in_regslv = False
        self.is_in_flatten_addrmap = False
        self.is_in_3rd_party_IP = False
        self.is_in_ext_mem = False
        self.is_filtered = False

        self.rtl_path = []
        self.reg_name = []
        self.regslv_name = []
        self.runtime_stack = []
        self.total_reg_num = 0
        self.filter_reg_num = 0
        self.total_size = 0
        self.start_time = time()

        # user-defined operations
        self.filter_pattern = user_ops.get("filter", None)

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
        message.debug("%sEntering addrmap: %s" % ("\t"*self.indent, node.get_path()))

        # push properties of the parent addrmap instance to stack (protect)
        # once entering new addrmap instance
        self.runtime_stack.append((self.is_in_regmst,
                                   self.is_in_regslv,
                                   self.is_in_flatten_addrmap,
                                   self.is_in_3rd_party_IP,
                                   self.rtl_path))

        # reset properties
        (self.is_in_regmst,
        self.is_in_regslv,
        self.is_in_flatten_addrmap,
        self.is_in_3rd_party_IP) = False, False, False, False
        self.rtl_path = []

        # distinguish different types of addrmap
        if isinstance(node.parent, RootNode):
            # the model traverses in the root addrmap, and shall generate a regmst module in RTL

            # set properties
            node.inst.properties["hj_genrtl"] = True
            node.inst.properties["hj_flatten_addrmap"] = False

            self.is_in_regmst = True

            self.regslv_name.append(node.inst_name)
            rtl_module_name = "regmst_{}".format(node.inst_name)
            self.rtl_path.append(rtl_module_name)
            self.total_size = node.total_size

            message.debug("%sgenerate %s" % ("\t"*self.indent, rtl_module_name))

        elif (node.get_property("hj_genrtl", default=True)) and \
            (not self.is_in_flatten_addrmap) and \
            (not node.inst.def_src_ref.filename.endswith(".xml")):
            # hj_genrtl = True, hj_flatten_addrmap = <don't care>
            # the model traverses in a sub-addrmap, and shall generate a regslv module in RTL

            # set properties
            node.inst.properties["hj_genrtl"] = True
            node.inst.properties["hj_flatten_addrmap"] = False

            self.is_in_regslv = True
            self.regslv_name.append(node.inst_name)

            rtl_module_name = "regslv_{}".format("__".join(self.regslv_name))
            self.rtl_path.append(rtl_module_name)
            print("\t"*self.indent, "generate", rtl_module_name)

        elif (node.get_property("hj_flatten_addrmap", default=True) or \
            self.is_in_flatten_addrmap) and \
            (not node.inst.def_src_ref.filename.endswith(".xml")):
            # hj_genrtl = False, hj_flatten_addrmap = True
            # the model traverses in a sub-addrmap, and shall generate no module in RTL,
            # all components inside this addrmap will be flatten in the parent scope

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

            # set properties
            node.inst.properties["hj_genrtl"] = False
            node.inst.properties["hj_flatten_addrmap"] = False

            self.is_in_3rd_party_IP = True
            message.debug("%sRecognized as 3rd party IP: " % ("\t"*self.indent))

            ext_hdl_path = node.get_property("hj_ext_hdl_path_down", default="")
            if ext_hdl_path == "":
                message.error("external hdl path property (hj_ext_hdl_path_down) "
                              "for 3rd party IP: %s is not provided" % (node.inst_name))
                sys.exit(1)
            self.rtl_path.append(ext_hdl_path)

    def exit_Addrmap(self, node):
        """
        """
        print("\t"*self.indent, "Exiting addrmap: %s" % (node.get_path()))

        # pop properties of the parent addrmap instance to stack (restore)
        # once exiting new addrmap instance
        (self.is_in_regmst,
        self.is_in_regslv,
        self.is_in_flatten_addrmap,
        self.is_in_3rd_party_IP,
        self.rtl_path) = self.runtime_stack.pop()

        if (isinstance(node.parent, RootNode)) \
            or ((node.get_property("hj_genrtl", default=True)) \
            and (not self.is_in_flatten_addrmap)):
            self.regslv_name.pop()

    def enter_Mem(self, node):
        message.debug("%sEntering memory: %s" % ("\t"*self.indent, node.get_path()))

        self.is_in_ext_mem = True

    def exit_Mem(self, node):
        message.debug("%sExiting memory: %s" % ("\t"*self.indent, node.get_path()))

        self.is_in_ext_mem = False

    def enter_Regfile(self, node):
        print("\t"*self.indent, "Entering regfile: %s" % (node.get_path()))

        self.reg_name.append(node.inst_name)

    def exit_Regfile(self, node):
        print("\t"*self.indent, "Exiting regfile: %s" % (node.get_path()))

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
            self.rtl_path.append("{}.field_value".format(field_rtl_inst_name))
            # assign hdl_path_slice for each field to recognize RTL hierarchy
            node.inst.properties["hdl_path_slice"] = [".".join(self.rtl_path)]
            print("\t"*self.indent, "generate hdl_path_slice: %s" % (node.inst.properties["hdl_path_slice"][0]))
        else:
            # FIXME: 3rd party IP RTL path generation
            pass

    def exit_Field(self, node):
        if not self.is_in_3rd_party_IP:
            self.rtl_path.pop()
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

        if not isinstance(node, FieldNode):
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
