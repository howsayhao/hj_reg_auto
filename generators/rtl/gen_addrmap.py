import os
import sys

import utils.message as message
from systemrdl.node import *

from .create_obj import *
from .gen_field_rtl import *
from .rtl_type import *
from .addr_handle import *
from .gen_module_rtl import *


class addrmap_str(object):
    def __init__(self, node:Node, master:bool, Root:RTL_NODE, hierarchy:list, base_addr) -> None:
        # rtl module name from the Top addressmap(self.node)'s instance name
        self.module_name = ('__'.join(hierarchy[:]) + '__' + node.get_path_segment() if(master is False) else node.get_path_segment()).replace('][','_').replace('[','').replace(']','')
        self.parent_module_name = '__'.join(hierarchy[:]).replace('][','_').replace('[','').replace(']','')
        self.node = node
        # if the master is true, it will gen a reg_mst
        self.master = master
        # create a new rtl_type addressmap top node to save information from node
        self.rtl_obj = None
        self.Root = Root
        self.folder_name = Root.folder_name
        # show program walking schedule
        self.indent = 0
        # Top addressmap's internal and external addr map (addr with register instance(register may overlap))
        self.base_addr = base_addr
        self.internal_addr_map = []
        self.external_addr_map = []
        # Top addressmap's internal and external register map (register instance with addr(addr may overlap))
        self.internal_register_map = []
        self.external_register_map = []
        # alias and shared register map in Top addressmap
        self.alias_register_map = []
        self.shared_register_map = []
        self.snap_register_map = []
        # sync_reset signals
        self.signal_map = []
        self.global_signal_map = Root.global_signal_map
        # module internal reg num = N, external module num = M
        self.M = 0
        self.N = 0
        self.thirdparty_num = 0
        self.ext_module = []
        # module sub addrmap inst_id which is used in submodule instantion
        self.inst = 0
        # addrmap properties
        self.rsvdset = node.get_property('rsvdset')
        # cdc properties
        self.cdc = node.get_property('hj_cdc') if('hj_cdc' in node.inst.properties) else False
        # split_mux property
        self.reg_mux_size = node.get_property('hj_reg_mux_size') if('hj_reg_mux_size' in node.inst.properties) else 128
        self.ext_mux_size = node.get_property('hj_ext_mux_size') if('hj_ext_mux_size' in node.inst.properties) else 128
        self.skip_reg_mux_dff_0 = node.get_property('hj_skip_reg_mux_dff_0') if('hj_skip_reg_mux_dff_0' in node.inst.properties) else True
        self.skip_reg_mux_dff_1 = node.get_property('hj_skip_reg_mux_dff_1') if('hj_skip_reg_mux_dff_1' in node.inst.properties) else True
        self.skip_ext_mux_dff_0 = node.get_property('hj_skip_ext_mux_dff_0') if('hj_skip_ext_mux_dff_0' in node.inst.properties) else False
        self.skip_ext_mux_dff_1 = node.get_property('hj_skip_ext_mux_dff_1') if('hj_skip_ext_mux_dff_1' in node.inst.properties) else False
        # access width
        self.DATA_WIDTH = 32
        self.ADDR_WIDTH = 64
        # ports
        self.field_in = []
        self.field_out = []
        # reg_slv_if
        self.reg_slv_if = reg_slv_if(self.module_name)

        self.hierarchy = hierarchy

        # output(rtl) components
        self.rtl = ''
        self.standard_ports = ''
        self.external_ports = ''
        self.fields_ports = ''
        self.parameter = ''
        self.wire_declaration = ''
        self.reg_wire = ''
        self.decode_logic = ''
        self.state_machine = ''
        self.reg_instantion = ''
        self.external_logic = ''
        self.snapshot_str = ''
        # self.mem_port = ''
        self.split_mux = ''
        self.output_select = ''
        self.cdc_deliver = ''

    # collect port information for wrapper
    def get_ports(self) -> None:
        for internal_register in self.internal_register_map:
            # if the register is alias reg or shared reg(not the first), its field will not be instanced
            if(internal_register.alias is True or (internal_register.shared is True and internal_register.first_shared is False)):
                pass
            else:
                for field in internal_register.children:
                    field_name = '_'.join(field.hierachy[:-1]).replace('][','_').replace('[','').replace(']','') + '__%s'%(field.hierachy[-1])
                    if(field.hw != "`HW_RO"):
                        next_value_signal = Signal(field_name + '__next_value')
                        next_value_signal.width = field.fieldwidth
                        self.field_in.append(next_value_signal)
                        pulse_signal = Signal(field_name + '__pulse')
                        pulse_signal.width = "1"
                        self.field_in.append(pulse_signal)
                    curr_value_signal = Signal(field_name + '__curr_value')
                    curr_value_signal.width = field.fieldwidth
                    self.field_out.append(curr_value_signal)
                    if(field.swmod):
                        swmod_signal = Signal(field_name + '__swmod_out')
                        self.field_out.append(swmod_signal)
                    if(field.swacc):
                        swacc_signal = Signal(field_name + '__swacc_out')
                        self.field_out.append(swacc_signal)

    # show enter component information
    def enter(self, node:Node) -> None:
        node_name = node.get_path_segment()
        self.hierarchy.append(node_name)
        # print('\t'*self.indent + 'entering ' + node.get_path_segment())
        self.indent += 1
    # show exit component information
    def exit(self, node:Node) -> None:
        self.indent -= 1
        # print('\t'*self.indent + 'exiting ' + node.get_path_segment())
        self.hierarchy.pop(-1)

    # generate module rtl file(.v file)
    def write(self) -> None:

        self.get_internal_strcture()

        # add instance information to wrapper
        if(self.master):
            self.Root.reg_mst = self
        else:
            self.Root.reg_slv.append(self)
        self.get_ports()
        self.Root.field_in  += self.field_in
        self.Root.field_out += self.field_out

        if(self.master is True):
            file_name = 'regmst_' + self.module_name + '.v'
        else:
            file_name = 'regslv_' + self.module_name + '.v'

        # generate the .v file and move the file into designated folder
        with open(os.path.join(self.folder_name, file_name), 'w') as f:
            f.write(self.rtl)

    # get information from node tree and generate corresponding rtl str
    def get_internal_strcture(self) -> None:
        """
        traverses the whole node-structure parsed by complier
        creates the corresponding rtl_type tree structure
        """
        self.rtl_obj = create_obj(node = self.node,parent_obj = None, base_addr=self.base_addr)
        self.rtl_obj.external = False
        self.walking(self.node,self.rtl_obj)

        # retraverse the register-map to allocate alias and shared register information
        self.reg_alias_shared_handle()

        # get top level addr map and decoder rtl str, generate .vh file with register-addr information
        self.get_decoder()

        # generate different parts of the whole rtl
        self.N = len(self.internal_addr_map)
        self.M = len(self.external_addr_map)
        self.get_module_rtl()

    # traverse the node tree to get the information as well as a new tree saving information and fill the different maps
    def walking(self, node:Node, rtl_obj:RTL_NODE) -> None:
        """
        Travese and create structure-tree in recursion
        Different nodes would be treated seperately:
            Addrmap
                with hj_genslv              : treated as external block, generate new .v file with inner structure
                without hj_genslv           : treated as internal block
            Memory                          : treated as external block(snapshot memory), addition logic would be created
            Regfile                         : treated as internal block
            Reg
                with regwidth = DATA_WIDTH  : treated as normal register
                with regwidth > DATA_WIDTH  : treated as snapshot register, addition logic would be created
        """
        self.enter(node)
        i = 0
        # traverse the node's childnode
        for child in node.children(unroll=True, skip_not_present=False):
            # create the child rtl_type object with corresponding properties
            new_obj = create_obj(child,rtl_obj,self.base_addr)

            # to judge if the address is treated as internal or external
            genslv = False
            flatten_addrmap = False
            if(isinstance(child, AddrmapNode)):
                genslv = child.get_property('hj_genslv') if('hj_genslv' in child.inst.properties) else False
                flatten_addrmap = child.get_property('hj_flatten_addrmap') if('hj_flatten_addrmap' in child.inst.properties) else True

                # for regslv gen_rtl
                if(genslv is True and child not in self.Root.genslv_node):
                    rtl_obj.hierachy_name = '_'.join(rtl_obj.hierachy[:]).replace('][','_').replace('[','').replace(']','')
                    base_addr = child.absolute_address
                    ext_addr = addrmap_str(node = child,master =  False,Root = self.Root, hierarchy = self.hierarchy, base_addr=base_addr)
                    ext_addr.write()
                    self.Root.children.append(ext_addr)
                    self.Root.genslv_node.append(child)
                    new_obj.DATA_WIDTH = 32
                    new_obj.ADDR_WIDTH = 64
                    self.ext_module.append(new_obj)
                    new_obj.id = len(self.ext_module) - 1
                    self.ext_instance(ext_addr)
                    self.inst += 1

                # for 3rd party IP
                elif(genslv is False and flatten_addrmap is False):
                    rtl_obj.hierachy_name = '_'.join(rtl_obj.hierachy[:]).replace('][','_').replace('[','').replace(']','')
                    base_addr = child.absolute_address
                    ext_addr = addrmap_str(node = child,master =  False,Root = self.Root, hierarchy = self.hierarchy, base_addr=base_addr)
                    new_obj.DATA_WIDTH = 32
                    new_obj.ADDR_WIDTH = 64
                    self.ext_module.append(new_obj)
                    new_obj.id = len(self.ext_module) - 1
                    self.ext_instance(ext_addr)

                # external property mark so related blocked won't gen
                if(genslv is True or flatten_addrmap is False):
                    new_obj.external = True
                    if(new_obj.parent is not None):
                        new_obj.external_top = new_obj.parent.external_top
                    else:
                        new_obj.external_top = new_obj

            # link the childnode with parentnode, child will inherit the parent's external properties
            new_obj.parent = rtl_obj
            if(rtl_obj.external):
                new_obj.external = rtl_obj.external
                if(rtl_obj.external_top is None):
                    new_obj.external_top = rtl_obj
                else:
                    new_obj.external_top = rtl_obj.external_top
            elif(new_obj.external):
                new_obj.external_top = new_obj

            # deep copy to seperate the two list
            new_obj.hierachy= rtl_obj.hierachy[:]
            new_obj.hierachy.append(new_obj.obj)
            rtl_obj.children.append(new_obj)
            new_obj.module_name = self.module_name + '__'  +'_'.join(new_obj.hierachy[:]).replace('][','_').replace('[','').replace(']','')

            # handle snap_shot register situation
            if(isinstance(new_obj, Reg)):
                if(child.get_property('regwidth') > self.DATA_WIDTH):
                    new_obj.snap = True
                    snap_num = int(child.get_property('regwidth') / self.DATA_WIDTH)
                    if(rtl_obj.external is False):
                        self.snap_register_map.append(new_obj)
                    for j in range(snap_num):
                        snap_reg_name = child.get_path_segment() + '_snap_' + str(j)
                        snap_reg = Reg(snap_reg_name)
                        snap_reg.snap_origin = new_obj
                        snap_reg.id = j
                        snap_reg.addr = int(new_obj.addr + j * self.DATA_WIDTH/8)
                        snap_reg.external = new_obj.external
                        snap_reg.external_top = new_obj.external_top
                        snap_reg.hierachy = new_obj.hierachy[:]
                        snap_reg.hierachy.append('_snap_' + str(j))
                        new_obj.snap_reg.append(snap_reg)
                        self.obj_handling(None,snap_reg, rtl_obj)
                else:
                    new_obj.snap = False

            # handle external block cdc issue
            if(isinstance(new_obj, Addressmap) or isinstance(new_obj, Memory)):
                cdc = child.get_property('hj_cdc') if('hj_cdc' in child.inst.properties) else None
                if(isinstance(new_obj, Addressmap)):
                    if(cdc is not None and genslv is False and flatten_addrmap is True):
                        try:
                            sys.exit(1)
                        except:
                            print('Internal Addrmap Cannot Have Different Clock!'%(new_obj.obj))
                new_obj.cdc = cdc

            # collect information of new_obj created into class-self-strcture
            self.obj_handling(child,new_obj, rtl_obj)

            self.walking(child,rtl_obj.children[i])
            i = i + 1
        self.exit(node)

    # handle with new_obj created
    def obj_handling(self, node:Node, new_obj:RTL_NODE, parent_obj:RTL_NODE):
        if(isinstance(node, SignalNode) and new_obj.external is False):
            self.signal_map.append(new_obj)
        if(isinstance(node, FieldNode) and new_obj.external is False):
            syn_rst = []
            if('hj_syncresetsignal' in node.inst.properties):
                signal_map = self.signal_map + self.global_signal_map
                for signal in node.get_property('hj_syncresetsignal').split(','):
                    # avoid blank space in signal_name
                    signal = signal.replace(' ','')
                    # search the signal defined in addrmap before
                    signal_is_defined = 0
                    for ref_signal in signal_map:
                        if(signal == ref_signal.obj and set(parent_obj.hierachy)>set(ref_signal.hierachy[:-1])):
                            signal_name = '_'.join(ref_signal.hierachy[:]).replace('][','_').replace('[','').replace(']','')
                            ref_signal.hierachy_name = signal_name
                            syn_rst.append(signal_name)
                            signal_is_defined = 1

                            # when global signal is used in internal, it would show on the port
                            if(ref_signal in self.signal_map):
                                pass
                            else:
                                self.signal_map.append(ref_signal)

                    if(not signal_is_defined and not parent_obj.external):
                        message.error("Signal %s in Field %s(%s) Hasn't Been Defined Yet!"%(signal,node.get_path_segment(),parent_obj.hierachy))
                        sys.exit(1)

            new_obj.syncresetsignal = node.get_property('hj_syncresetsignal') if('hj_syncresetsignal' in node.inst.properties) else ''
            new_obj.syncresetsignal = syn_rst
        if(isinstance(new_obj, Reg)):
            if(new_obj.external and new_obj.snap is not True):
                self.external_register_map.append(new_obj)
                new_obj.id = len(self.external_register_map) - 1
            elif(new_obj.snap is not True):
                self.internal_register_map.append(new_obj)
                new_obj.id = len(self.internal_register_map) - 1
            # alias regs in the same addrmap, shared regs in different addrmap
            if(new_obj.snap_origin is None):
                if(node.inst.alias_primary_inst is not None):
                    new_obj.alias = True
                    # new_obj.alias_origin = node.inst.alias_primary_inst
                    new_obj.alias_origin = node.inst.alias_primary_inst
                    self.alias_register_map.append(new_obj)
                if(node.get_property('shared') is True):
                    new_obj.shared = True
                    new_obj.shared_origin = node.inst.original_def
                    self.shared_register_map.append(new_obj)

    # handle the regs' alias and shared situation
    def reg_alias_shared_handle(self) -> None:
        """
        register with alias or shared information would be marked and recorded in alias/shared_register_map
        both registers' properties would be gathered together and instantiated on ONE register

        for alias register  : the original register would append the alias register and be instantiated finally
        for shared register : the first declared register would append the other shared register and be instantiated finally
        """
        all_register_map = self.internal_register_map + self.snap_register_map

        # find the alias register and the prime register which is be aliased
        for alias_register in self.alias_register_map:
            for prime_register in all_register_map:
                if(prime_register.ref is None):
                    pass
                elif(alias_register.alias_origin == prime_register.ref.inst):
                    prime_register.alias_reg.append(alias_register)
                    alias_register.origin_reg = prime_register
                    break

        # find the shared register and the first shared register will be build in hardware
        for shared_register in self.shared_register_map:
            first_shared = 1
            for first_shared_register in all_register_map:
                # there has shared register before then the reg became the first shared register's alias register
                if(shared_register.shared_origin == first_shared_register.shared_origin and first_shared_register.first_shared is True):
                    first_shared = 0
                    first_shared_register.alias_reg.append(shared_register)
                    shared_register.origin_reg = first_shared_register
                    shared_register.first_shared = False
            # there is no shared register before then the reg became the first shared register
            if(first_shared == 1):
                shared_register.first_shared = True

    # external sub addrmap instance define
    def ext_instance(self, ext_addr) -> str:
        # sub_module_name = node.get_path_segment()
        sub_module_name = ext_addr.module_name

        # for global instantion
        ext_addr.reg_slv_if = reg_slv_if(sub_module_name)
        if(self.master):
            module_name = 'regmst_' + self.module_name
        else:
            module_name = 'regslv_' + self.module_name
        ext_addr.reg_slv_if.global_sync = '%s_fsm_sync_reset'%(module_name)
        ext_addr.reg_slv_if.req_vld = '%s_ext_req_vld[%d]'%(module_name,self.inst)
        ext_addr.reg_slv_if.req_rdy = '%s_ext_req_rdy[%d]'%(module_name,self.inst)
        ext_addr.reg_slv_if.ack_vld = '%s_ext_ack_vld[%d]'%(module_name,self.inst)
        ext_addr.reg_slv_if.ack_rdy = '%s_ext_ack_rdy'%(module_name)
        ext_addr.reg_slv_if.rd_data = '%s_ext_rd_data[%d]'%(module_name,self.inst)
        ext_addr.reg_slv_if.wr_en = '%s_wr_en'%(module_name)
        ext_addr.reg_slv_if.rd_en = '%s_rd_en'%(module_name)
        ext_addr.reg_slv_if.wr_data = '%s_wr_data'%(module_name)
        ext_addr.reg_slv_if.addr = '%s_addr'%(module_name)

    # get C head and decode rtl code from (reg - addr) map
    def get_decoder(self) -> list:
        """
        the function would generate two kinds of str:
            define_str  : used in .vh file to indicate the register's address
            decode_str  : used in .v file to make up the decoder part

        cause different register may share the same addr such as memory's entries
        the function would rearrange the mapping from register - addr to addr - register
        """

        # change reg - addr map to addr - reg map
        for register in self.internal_register_map:
            # if more than 1 reg has the same addr, the new_addr object will add a register instance in its list
            if(len(self.internal_addr_map) == 0 or self.internal_addr_map[-1].addr != register.addr):
                # register snapshoted won't be allocated into addrmap which it's snap_reg would be allocated
                if(register.snap is not True):
                    new_addr = addrpointer(register.addr)
                    new_addr.registers.append(register)
                    self.internal_addr_map.append(new_addr)
            else:
                self.internal_addr_map[-1].registers.append(register)

        for register in self.external_register_map:
            # if more than 1 reg has the same base addr, which means they share a same external obj, which foward a sel outside
            if(len(self.external_addr_map) == 0 or self.external_addr_map[-1].addr != register.external_top.addr):
                if(register.snap is not True):
                    new_addr = addrpointer(register.external_top.addr)
                    new_addr.registers.append(register)
                    self.external_addr_map.append(new_addr)
            else:
                self.external_addr_map[-1].registers.append(register)

        # generate define and decode str from new addr-reg map
        define_str = ''
        define_str += '`ifndef __%s_vh__\n'%(self.module_name)
        define_str += '`define __%s_vh__\n'%(self.module_name)
        define_str += '//' + 'Address Definition Here'.center(100,"*") + '//\n'
        for addr in self.internal_addr_map:
            for register in addr.registers:
                register.hierachy_name = '_'.join(register.hierachy[:]).replace('][','_').replace('[','').replace(']','')
                addr.register_names.append('`' + register.hierachy_name)
                rtl_reg_name = register.hierachy_name
                rtl_reg_addr = '64\'h' + self.get_hex(register.addr)
                define_str += '`define %s %s//internal\n'%(rtl_reg_name,rtl_reg_addr)

        for addr in self.external_addr_map:
            for register in addr.registers:
                register.hierachy_name = '_'.join(register.hierachy[:]).replace('][','_').replace('[','').replace(']','')
                addr.register_names.append('`' + register.hierachy_name)
                rtl_reg_name = register.hierachy_name
                if(isinstance(register.addr,str)):
                    rtl_reg_addr = register.addr
                else:
                    rtl_reg_addr = '64\'h' + self.get_hex(register.addr)
                define_str += '`define %s %s//external\n'%(rtl_reg_name,rtl_reg_addr)
        define_str += '`endif'
        decode_str = ''
        return[define_str,decode_str]

    def get_ext_connection(self) -> list:
        ext_port = ''
        ext_connect = ''
        i = 0
        if(len(self.external_register_map)>0):
            # modified
            i = 0
            for addr in self.external_addr_map:
                ext_module = addr.registers[0].external_top
                if(isinstance(ext_module, Memory)):
                    if(self.master):
                        ext_module.ref = "regmst_" + self.module_name
                    else:
                        ext_module.ref = "regslv_" + self.module_name
                    ext_module.ref_id = i
                    self.Root.third_party.append(ext_module)
                    self.thirdparty_num += 1
                i += 1

        return[ext_port,ext_connect]

    def get_module_rtl(self) -> None:
        # collect all parts of rtl together into whole .v file
        self.rtl += '`include "xregister.vh"\n'
        self.rtl += '`default_nettype none\n'
        if(self.master):
            self.rtl += 'module ' + 'regmst_' + self.module_name + '(\n'
        else:
            self.rtl += 'module ' + 'regslv_' + self.module_name + '(\n'

        # regmst has 1 external port to connect dispatch
        if(self.master):
            self.rtl += '//' + 'EXTERNAL MODULE PORT START'.center(100,"*") + '//\n'
            self.rtl += get_ext_port()
            self.rtl += '//' + 'EXTERNAL MODULE PORT END'.center(100,"*") + '//\n'
            self.rtl += '\n\n'

        self.rtl += '//' + 'INTERNAL FIELD PORT START'.center(100,"*") + '//\n'
        self.rtl += get_regfile_port(self.internal_register_map + self.snap_register_map, self.signal_map, self.N)
        self.rtl += '//' + 'INTERNAL FIELD PORT END'.center(100,"*") + '//\n'
        self.rtl += '\n\n'

        self.rtl += '//' + 'STANDARD PORT START'.center(100,"*") + '//\n'
        self.rtl += get_regslv_port(self.master, self.cdc)
        self.rtl += '//' + 'STANDARD PORT END'.center(100,"*") + '//\n'
        self.rtl += ');\n'
        self.rtl += '\n\n'

        self.rtl += '//' + 'PARAMETER DEFINITION START'.center(100,"*") + '//\n'
        self.rtl += '\tparameter                  ADDR_WIDTH = 64          ;\n'
        self.rtl += '\tparameter                  DATA_WIDTH = 32          ;\n'
        self.rtl += '\t//N:number of internal registers, M:number of external modules\n'
        self.rtl += '\tlocalparam                 N = %d                    ;\n'%(self.N)
        self.rtl += '\tlocalparam                 M = %d                    ;\n'%(self.M) if(self.master) else ''
        self.rtl += '\tlocalparam                 REG_NUM = N ? N : 1      ;\n'
        self.rtl += '\tlocalparam                 EXT_NUM = M ? M : 1      ;\n' if(self.master) else ''
        self.rtl += '//' + 'PARAMETER DEFINITION END'.center(100,"*") + '//\n'
        self.rtl += '\n\n'

        self.rtl += '//' + 'PORT DECLARATION START'.center(100,"*") + '//\n'
        self.rtl += get_regslv_define(self.master, self.cdc)

        # regmst has 1 external port to connect dispatch
        if(self.master):
            self.rtl += get_ext_define()

        self.rtl += get_regfile_define(self.internal_register_map + self.snap_register_map, self.signal_map, self.N)
        self.rtl += '//' + 'PORT DECLARATION END'.center(100,"*") + '//\n'
        self.rtl += '\n\n'

        self.rtl += '//' + 'WIRE DECLARATION START'.center(100,"*") + '//\n'
        self.rtl += get_fsm_wire()
        self.rtl += get_decoder_wire(self.N)
        self.rtl += get_splitmux_wire(self.N)
        self.rtl += get_regslv_wire(self.master, self.cdc)
        self.rtl += get_regfile_wire(self.N)
        self.rtl += get_internal_reg_wire(self.internal_register_map)
        self.rtl += get_snaped_reg_wire(self.snap_register_map)

        self.rtl += '//' + 'WIRE DECLARATION END'.center(100,"*") + '//\n'
        self.rtl += '\n\n'


        self.rtl += '//' + 'ADDRESS DECODER START'.center(100,"*") + '//\n'
        self.rtl += get_decoder(self.internal_addr_map)
        self.rtl += '//' + 'ADDRESS DECODER END'.center(100,"*") + '//\n'
        self.rtl += '\n\n'

        self.rtl += '//' + 'STATE MACHINE INSTANCE START'.center(100,"*") + '//\n'
        self.rtl += get_fsm_ins(self.module_name, self.master)
        self.rtl += '//' + 'STATE MACHINE INSTANCE END'.center(100,"*") + '//\n'
        self.rtl += '\n\n'

        self.rtl += '//' + 'SPLIT MUX INSTANCE START'.center(100,"*") + '//\n'
        self.rtl += get_split_mux_ins(self.M, self.N, self.reg_mux_size, self.skip_reg_mux_dff_0, self.skip_reg_mux_dff_1)
        self.rtl += '//' + 'SPLIT MUX INSTANCE END'.center(100,"*") + '//\n'
        self.rtl += '\n\n'

        self.rtl += '//' + 'ULTIMATE MUX START'.center(100,"*") + '//\n'
        self.rtl += get_ultimate_mux(self.master, self.M, self.N)
        self.rtl += '//' + 'ULTIMATE MUX END'.center(100,"*") + '//\n'
        self.rtl += '\n\n'

        if(not self.master):
            self.rtl += '//' + 'REGSLV CDC DELIVER INSTANT START'.center(100,"*") + '//\n'
            self.rtl += get_regslv_cdc(self.cdc)
            self.rtl += '//' + 'REGSLV CDC DELIVER INSTANT END'.center(100,"*") + '//\n'
            self.rtl += '\n\n'

        self.rtl += '//' + 'REG/FIELD INSTANCE START'.center(100,"*") + '//\n'
        self.rtl += get_reg_rtl(self.internal_register_map, self.rsvdset)
        self.rtl += '//' + 'REG/FIELD INSTANCE END'.center(100,"*") + '//\n'
        self.rtl += '\n\n'

        self.rtl += '//' + 'REG/FIELD INSTANCE START'.center(100,"*") + '//\n'
        self.rtl += get_snapped_reg_rtl(self.snap_register_map, self.rsvdset)
        self.rtl += '//' + 'REG/FIELD INSTANCE END'.center(100,"*") + '//\n'
        self.rtl += '\n\n'

        self.rtl += 'endmodule\n'
        self.rtl += '`default_nettype wire'
    # convert addr or reset value from int(decimal) to str(hex)
    def get_hex(self,dec_d:int) -> str:
        if(dec_d is None):
            return '0'
        hex_d = str(hex(dec_d)[2:])
        return hex_d
