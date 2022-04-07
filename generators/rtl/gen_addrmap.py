from systemrdl.node import *
import sys
import shutil

from .rtl_type import *
from .gen_field_rtl import *
from .create_obj import *

class addrmap_str(object):
    def __init__(self, node:Node, master:bool, Root:RTL_NODE):
        # rtl module name from the Top addressmap(self.node)'s instance name
        self.module_name = node.get_path_segment()
        self.node = node
        # if the master is true, it will gen a reg_mst
        self.master = master
        # create a new rtl_type addressmap top node to save information from node
        self.rtl_obj = create_obj(node = self.node,parent_obj = None)
        self.Root = Root
        self.folder_name = Root.folder_name
        # show program walking schedule
        self.indent = 0
        # Top addressmap's internal and external addr map (addr with register instance(register may overlap))
        self.internal_addr_map = []
        self.external_addr_map = []
        # Top addressmap's internal and external register map (register instance with addr(addr may overlap))
        self.internal_register_map = []
        self.external_register_map = []
        # alias and shared register map in Top addressmap
        self.alias_register_map = []
        self.shared_register_map = []
        # sync_reset signals
        self.signal_map = []
        self.global_signal_map = Root.global_signal_map
        # module internal reg num = N, external module num = M
        self.M = 0
        self.N = 0
        self.thirdparty_num = 0
        # module sub addrmap inst_id which is used in submodule instantion
        self.inst = 0
        # addrmap properties
        self.rsvdset = node.get_property('rsvdset')
        # access width
        self.DATA_WIDTH = 32
        # ports
        self.field_in = []
        self.field_out = []
        # reg_slv_if
        self.reg_slv_if = reg_slv_if(self.module_name)

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
        self.ext_instance_port = ''
        # self.mem_port = ''
        self.split_mux = ''
        self.output_select = ''

    def get_ports(self):
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
                    self.field_in.append(next_value_signal)
                    curr_value_signal = Signal(field_name + '__curr_value')
                    curr_value_signal.width = field.fieldwidth
                    self.field_out.append(curr_value_signal)
                    if(field.swmod):
                        swmod_signal = Signal(field_name + 'swmod_signal')
                        self.field_out.append(curr_value_signal)
                    if(field.swacc):
                        swacc_signal = Signal(field_name + '__swacc_out')
                        self.field_out.append(swacc_signal)

    # show enter component information
    def enter(self, node:Node):
        print('\t'*self.indent + 'entering ' + node.get_path_segment())
        self.indent += 1
    # show exit component information
    def exit(self, node:Node):
        self.indent -= 1
        print('\t'*self.indent + 'exiting ' + node.get_path_segment())

    # get rtl str
    def write(self):
        if(self.master):
            self.Root.reg_mst = self
        else:
            self.Root.reg_slv.append(self)
        # get different parts of rtl str
        self.get_internal_strcture()
        self.get_ports()
        self.rtl += '`include "xregister.vh"\n'
        if(self.master is True):
            file_name = 'regmst_' + self.module_name + '.v'
            self.rtl += 'module ' + 'regmst_' + self.module_name + '(\n'
        else:
            file_name = 'regslv_' + self.module_name + '.v'
            self.rtl += 'module ' + 'regslv_' + self.module_name + '(\n'
        self.rtl += self.external_ports + \
                    self.fields_ports + \
                    self.standard_ports + ');\n' + \
                    self.parameter + '\n\n' + \
                    self.wire_declaration + '\n\n' + \
                    self.reg_wire + '\n\n' + \
                    self.decode_logic + '\n\n' + \
                    self.state_machine + '\n\n' + \
                    self.reg_instantion + '\n\n' + \
                    self.external_logic + '\n\n' + \
                    self.ext_instance_port + '\n\n' + \
                    self.split_mux + '\n\n' + \
                    self.output_select + 'endmodule'

        # self.Root.field_wire += self.fields_ports
        self.Root.field_in += self.field_in
        self.Root.field_out += self.field_out

        fw = open(file_name,'w')
        fw.write(self.rtl)
        fw.close()
        folder_name = self.folder_name
        shutil.move(file_name,folder_name)

    # get information from node tree and generate corresponding rtl str
    def get_internal_strcture(self):
        # walking the node tree to fill information in different maps and get new rtl_type tree
        print('\n###start traverse %s###'%self.module_name)
        self.rtl_obj.external = False
        self.walking(self.node,self.rtl_obj)
        print('###end traverse %s###\n'%self.module_name)
        # retraverse the map to allobcate alias and shared information
        self.reg_alias_shared_handle()
        # get top level addr map and decoder rtl str
        [define_str,decode_str] = self.get_decoder()
        file_name = self.module_name + '.vh'
        fw = open(file_name,'w')
        fw.write(define_str)
        fw.close()
        shutil.move(file_name,self.folder_name)
        self.decode_logic = decode_str
        # get internal reg instantion rtl str
        self.reg_instantion = self.get_reg()
        # get external module wire connections
        [ext_port,ext_connect] = self.get_ext_connection()
        self.external_logic = ext_connect
        self.N = len(self.internal_addr_map)
        self.M = len(self.external_addr_map)
        # different parts of the whole rtl
        self.get_module_rtl()

    # traverse the node tree to get the information as well as a new tree saving information and fill the different maps
    def walking(self, node:Node, rtl_obj:RTL_NODE):
        self.enter(node)
        i = 0
        # traverse the node's childnode
        for child in node.children(unroll=True, skip_not_present=True):
            # to judge if the address is treated as internal or external
            genrtl = False
            if(isinstance(child, AddrmapNode)):
                genrtl = child.get_property('hj_genrtl') if('hj_genrtl' in child.inst.properties) else False
                if(genrtl is True):
                    ext_addr = addrmap_str(node = child,master =  False,Root = self.Root)
                    ext_addr.write()
                    self.Root.children.append(ext_addr)
                    self.ext_instance(ext_addr)
                    self.inst += 1
            # create the child rtl_type object with corresponding properties
            new_obj = create_obj(child,rtl_obj)
            # handle addrmap genrtl nested situation
            if(isinstance(child, AddrmapNode)):
                genrtl = child.get_property('hj_genrtl') if('hj_genrtl' in child.inst.properties) else False
                if(genrtl is True):
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
            # create external addr access for decoder
            if(isinstance(child, MemNode)):
                mem_bit = new_obj.mementries * new_obj.memwidth
                mem_entries = int(mem_bit / self.DATA_WIDTH)
                for entry in range(mem_entries):
                    visual_reg_name = node.get_path_segment() + '_' + str(entry)
                    visual_reg = Reg(visual_reg_name)
                    visual_reg.external = True
                    visual_reg.addr = int(new_obj.addr + entry * new_obj.memwidth/8)
                    new_obj.children.append(visual_reg)
                    self.external_register_map.append(visual_reg)
                    visual_reg.id = len(self.external_register_map) - 1
                    visual_reg.external_top = new_obj.external_top

            # record the regs' external property in internal&external register map
            self.obj_handling(child,new_obj, rtl_obj)
            # preserve the hierachy for the new_object to show real placement in rtl
            # deep copy to seperate the two list
            new_obj.hierachy= rtl_obj.hierachy[:]
            new_obj.hierachy.append(new_obj.obj)
            # create the tree from original node tree
            rtl_obj.children.append(new_obj)
            self.walking(child,rtl_obj.children[i])
            i = i + 1
        self.exit(node)

    # handle with new_obj created
    def obj_handling(self, node:Node, new_obj:RTL_NODE, parent_obj:RTL_NODE):
        if(isinstance(node, SignalNode) and new_obj.external is False):
            self.signal_map.append(new_obj)
        if(isinstance(node, FieldNode)):
            syn_rst = []
            if('hj_syncresetsignal' in node.inst.properties):
                signal_map = self.signal_map + self.global_signal_map
                for signal in node.get_property('hj_syncresetsignal').split(','):
                    signal = signal.replace(' ','')
                    for ref_signal in signal_map:
                        if(signal == ref_signal.obj and set(parent_obj.hierachy)>set(ref_signal.hierachy[:-1])):
                            signal_name = '_'.join(ref_signal.hierachy[:]).replace('][','_').replace('[','').replace(']','')
                            ref_signal.hierachy_name = signal_name
                            syn_rst.append(signal_name)

            new_obj.syncresetsignal = node.get_property('hj_syncresetsignal') if('hj_syncresetsignal' in node.inst.properties) else ''
            new_obj.syncresetsignal = syn_rst
        if(isinstance(new_obj, Reg)):
            if(new_obj.external):
                self.external_register_map.append(new_obj)
                new_obj.id = len(self.external_register_map) - 1
            else:
                self.internal_register_map.append(new_obj)
                new_obj.id = len(self.internal_register_map) - 1
            # alias regs in the same addrmap, shared regs in different addrmap
            if(node.inst.alias_primary_inst is not None):
                new_obj.alias = True
                new_obj.alias_origin = node.inst.alias_primary_inst.inst_name
                self.alias_register_map.append(new_obj)
            if(node.get_property('shared') is True):
                new_obj.shared = True
                new_obj.shared_origin = node.inst.original_def.type_name
                self.shared_register_map.append(new_obj)
    # handle the regs' alias and shared situation
    def reg_alias_shared_handle(self) -> None:
        # all_register_map = self.internal_register_map + self.external_register_map
        all_register_map = self.internal_register_map
        # find the alias register and the prime register which is be aliased
        for alias_register in self.alias_register_map:
            for prime_register in all_register_map:
                if(alias_register.alias_origin == prime_register.obj):
                    prime_register.alias_reg.append(alias_register)
                    alias_register.origin_reg = prime_register
                    break
        # find the shared register and the first shared register will be build in hardware
        for shared_register in self.shared_register_map:
            first_shared = 1
            if(shared_register.obj == 'shared_3'):
                pass
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
        # ins_str = ''
        # ins_str += 'regslv_%s #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))\n\tregslv_%s (\n'%(sub_module_name,sub_module_name)
        # ins_str += '\t.clk(clk), .global_sync_reset_in(global_sync_reset_out), .rstn(rstn),\n'
        # ins_str += '\t.req_vld(ext_req_vld[%d]), .rd_data(ext_rd_data[%d]), .ack_vld_t(ext_ack_vld_t[%d]),\n'%(self.inst,self.inst,self.inst)
        # ins_str += '\t.req_rdy(ext_req_rdy_s[%d]), .ack_rdy(ext_ack_rdy_s),\n'%(self.inst)
        # for signal in ext_addr.signal_map + self.global_signal_map:
        #     ins_str += '\t.%s(%s),\n'%(signal.hierachy_name,signal.hierachy_name)

        # ins_str += '\t.wr_en(wr_en_ff), .rd_en(rd_en_ff), .addr(addr_ff), .wr_data(wr_data_ff)\n'
        # ins_str += ');\n'

        # for global instantion
        ext_addr.reg_slv_if = reg_slv_if(sub_module_name)
        module_name = 'regslv_' + self.module_name
        ext_addr.reg_slv_if.global_sync = '%s_fsm_sync_reset'%(module_name)
        ext_addr.reg_slv_if.req_vld = '%s_ext_req_vld[%d]'%(module_name,self.inst)
        ext_addr.reg_slv_if.req_rdy = '%s_ext_req_rdy[%d]'%(module_name,self.inst)
        ext_addr.reg_slv_if.ack_vld = '%s_ext_ack_vld[%d]'%(module_name,self.inst)
        ext_addr.reg_slv_if.ack_rdy = '%s_ext_ack_rdy[%d]'%(module_name,self.inst)
        ext_addr.reg_slv_if.rd_data = '%s_ext_rd_data[%d]'%(module_name,self.inst)
        ext_addr.reg_slv_if.wr_en = '%s_wr_en'%(module_name)
        ext_addr.reg_slv_if.rd_en = '%s_rd_en'%(module_name)
        ext_addr.reg_slv_if.wr_data = '%s_wr_data'%(module_name)
        ext_addr.reg_slv_if.addr = '%s_addr'%(module_name)

        # return ins_str

    # get C head and decode rtl code from (reg - addr) map
    def get_decoder(self) -> list:
        define_str = ''
        define_str += '`ifndef __%s_vh__\n'%(self.module_name)
        define_str += '`define __%s_vh__\n'%(self.module_name)
        define_str += '//' + 'Address Definition Here'.center(100,"*") + '//\n'
        decode_str = ''
        decode_str += '//' + 'Address Decoding START Here'.center(100,"*") + '//\n'
        decode_str += 'always_comb begin\n'
        decode_str += '\t\treg_sel = {REG_NUM{1\'b0}};\n'
        decode_str += '\t\text_sel = {EXT_NUM{1\'b0}};\n'
        decode_str += '\t\tdummy_reg = 1\'b0;\n'
        decode_str += '\tunique case (addr)\n'
        # change reg - addr map to addr - reg map
        for register in self.internal_register_map:
            # if more than 1 reg has the same addr, the new_addr object will add a register instance in its list
            if(len(self.internal_addr_map) == 0 or self.internal_addr_map[-1].addr != register.addr):
                new_addr = addrpointer(register.addr)
                new_addr.registers.append(register)
                self.internal_addr_map.append(new_addr)
            else:
                self.internal_addr_map[-1].registers.append(register)

        for register in self.external_register_map:
            # if more than 1 reg has the same base addr, which means they share a same external obj, which foward a sel outside
            if(len(self.external_addr_map) == 0 or self.external_addr_map[-1].addr != register.external_top.addr):
                new_addr = addrpointer(register.external_top.addr)
                new_addr.registers.append(register)
                self.external_addr_map.append(new_addr)
            else:
                self.external_addr_map[-1].registers.append(register)

        for addr in self.internal_addr_map:
            for register in addr.registers:
                register.hierachy_name = '_'.join(register.hierachy[:]).replace('][','_').replace('[','').replace(']','')
                addr.register_names.append('`' + register.hierachy_name)
                rtl_reg_name = register.hierachy_name
                rtl_reg_addr = '64\'h' + self.get_hex(register.addr)
                define_str += '`define %s %s//internal\n'%(rtl_reg_name,rtl_reg_addr)
            decode_str += '\t\t' + rtl_reg_addr + ':' + 'reg_sel[%s] = 1\'b1;//%s\n'%(register.id,register.hierachy[:])
            # decode_str += '\t\t' + ','.join(addr.register_names) + ':' + 'reg_sel[%s] = 1\'b1;//%s\n'%(register.id,register.hierachy[:])
        for addr in self.external_addr_map:
            for register in addr.registers:
                register.hierachy_name = '_'.join(register.hierachy[:]).replace('][','_').replace('[','').replace(']','')
                addr.register_names.append('`' + register.hierachy_name)
                rtl_reg_name = register.hierachy_name
                rtl_reg_addr = '64\'h' + self.get_hex(register.addr)
                addr.addr_str.append(rtl_reg_addr)
                define_str += '`define %s %s//external\n'%(rtl_reg_name,rtl_reg_addr)
            decode_str += '\t\t' + ','.join(addr.addr_str) + ':' + 'ext_sel[%s] = 1\'b1;//external module %s\n'%(self.external_addr_map.index(addr),addr.registers[0].external_top.obj)
            # decode_str += '\t\t' + ','.join(addr.register_names) + ':' + 'ext_sel[%s] = 1\'b1;//external module %s\n'%(self.external_addr_map.index(addr),addr.registers[0].external_top.obj)
        decode_str += '\t\tdefault: dummy_reg = 1\'b1;\n'
        decode_str += '\tendcase\n'
        decode_str += 'end\n'
        decode_str += '//' + 'Address Decoding END Here'.center(100,"*") + '//\n'
        define_str += '`endif'
        return[define_str,decode_str]

    # internal reg ports
    def gen_reg_port(self,register:RTL_NODE):
        reg_port_str = ''
        rtl_reg_name = '_'.join(register.hierachy[:]).replace('][','_').replace('[','').replace(']','')
        # if the reg is alias or share
        if(register.shared):
            pass
        if(register.alias or (register.shared and len(register.alias_reg) == 0)):
            field_bin = register.origin_reg.children
        else:
            field_bin = register.children
        # traverse the original register's field bin
        for field in field_bin:
            if(field.sw == "`SW_RW" or field.sw == "`SW_RO" or field.sw == "`SW_RW1" ):
                rtl_field_name = '_'.join(field.hierachy[:-1]).replace('][','_').replace('[','').replace(']','') + '__%s'%(field.hierachy[-1])
                reg_port_str += '\t%s[%d:%d] = %s__curr_value;\n'%(rtl_reg_name,field.msb,field.lsb,rtl_field_name)
        return reg_port_str

    # internal reg instance
    def get_reg(self) -> str:
        regstr = ''
        regstr += '//' + 'Register&field Instantiate START Here'.center(100,"*") + '//\n'
        self.reg_wire += '//' + 'internal register operation wire declare START'.center(100,"*") + '//\n'
        for register in self.internal_register_map:
            addr = '64\'h' + self.get_hex(register.addr)
            offset = '64\'h' + '64\'h' + self.get_hex(register.offset)
            rtl_reg_name = '_'.join(register.hierachy[:]).replace('][','_').replace('[','').replace(']','')
            regstr += '//' + 'REG INSTANT'.center(100,"=") + '//\n'
            regstr += '//' + ('REG NAME: %s'%(rtl_reg_name)) + '//\n'
            regstr += '//' + ('REG HIERARCHY: %s'%(register.hierachy)) + '//\n'
            regstr += '//' + ('REG ABSOLUTE_ADDR:%s'%(addr)) + '//\n'
            regstr += '//' + ('REG OFFSET_ADDR:%s'%(offset)) + '//\n'
            regstr += 'logic [%d:0] %s'%(register.regwidth-1,rtl_reg_name) + ';\n'
            self.reg_wire += 'logic [%d:0] %s_wr_data'%(register.regwidth-1,rtl_reg_name) + ';\n'
            regstr += 'assign %s_wr_data = reg_sel[%d] && wr_en_ff ? wr_data_ff : 0;\n'%(rtl_reg_name,register.id)
            # get field instantion
            regstr += gen_field_rtl(register)
            regstr += ''
            rsv_value = hex(int('1'*register.regwidth,2)) if(self.rsvdset) else '0x0'
            regstr += 'always_comb begin\n'
            regstr += '\t%s[%d:0] = %d\'h%s;\n'%(rtl_reg_name,register.regwidth-1,register.regwidth,rsv_value[2:])
            regstr += self.gen_reg_port(register)
            regstr += 'end\n'
            regstr += 'assign reg_rd_data_in[%d] = %s;\n'%(register.id,rtl_reg_name)
            regstr += '//' + 'END REG INSTANT'.center(100,"=") + '//\n'
        self.reg_wire += '//' + 'internal register operation wire declare END'.center(100,"*") + '//\n'
        regstr += '//' + 'Register&field Instantiate END Here'.center(100,"*") + '//\n'
        return regstr

    def get_ext_connection(self) -> list:
        ext_port = ''
        ext_connect = ''
        i = 0
        if(len(self.external_register_map)>0):
            ext_connect += '//' + 'EXTERNAL CONNECTION INSTANT START'.center(100,"*") + '//\n'
            ext_connect += 'assign ext_wr_en = wr_en_ff;\n'
            ext_connect += 'assign ext_rd_en = rd_en_ff;\n'
            ext_connect += 'assign ext_addr = addr_decode;\n'
            ext_connect += 'assign ext_wr_data = wr_data_ff;\n'
            for addr in self.external_addr_map:
                ext_connect += '//%s connection, external[%s];\n'%(addr.registers[0].external_top.obj,i)
                ext_connect += 'assign ext_req_vld[%s] = ext_sel[%s] & req_vld_s;\n'%(i,i)
                ext_connect += 'assign ext_ack[%s] = ext_ack_vld[%s] & ext_sel[%s];\n'%(i,i,i)
                i += 1
            ext_connect += '//' + 'EXTERNAL CONNECTION INSTANT END'.center(100,"*") + '//\n'
            # modified
            i = 0
            for addr in self.external_addr_map:
                ext_module = addr.registers[0].external_top
                if(isinstance(ext_module, Memory)):
                    ext_module.ref = "regslv_" + self.module_name
                    ext_module.ref_id = i
                    self.Root.third_party.append(ext_module)
                    self.thirdparty_num += 1
                i += 1

        return[ext_port,ext_connect]

    def get_module_rtl(self) -> None:
        # get module_standard in/outputs
        self.standard_ports += '\tclk,\n' + \
                               '\trstn,\n' + \
                               '\treq_vld,\n' + \
                               '\treq_rdy,\n' + \
                               '\twr_en,rd_en,\n' + \
                               '\taddr,\n' + \
                               '\twr_data,\n'
        if(self.master is True):
            self.standard_ports += '\tglobal_sync_reset_out,\n'
            self.standard_ports += '\tinterrupt,\n'
            self.standard_ports += '\tclear,\n'
        else:
            self.standard_ports += '\tglobal_sync_reset_in,\n'
            self.standard_ports += '\tglobal_sync_reset_out,\n'

        signal_map = self.signal_map + self.global_signal_map
        for signal in signal_map:
            self.standard_ports += '\t%s,\n'%(signal.hierachy_name)

        self.standard_ports += '\tack_vld,\n' + \
                               '\tack_rdy,\n' + \
                               '\trd_data\n'

        # get module_external modules' in/outputs
        self.external_ports += '//' + 'EXTERNAL module connection port START'.center(100,"*") + '//\n'
        if(len(self.external_addr_map) > 0):
            self.external_ports += '\text_req_vld,\n' + \
                                   '\text_req_rdy,\n' + \
                                   '\text_wr_en,ext_rd_en,\n' + \
                                   '\text_addr,\n' + \
                                   '\text_wr_data,\n' + \
                                   '\text_ack_vld,\n' + \
                                   '\text_ack_rdy,\n' + \
                                   '\text_rd_data,\n'
        self.external_ports += '//' + 'EXTERNAL module connection port END'.center(100,"*") + '//\n'

        # get module_internal fields' in/outputs
        self.fields_ports += '//' + 'INTERNAL field connection port START'.center(100,"*") + '//\n'
        for internal_register in self.internal_register_map:
            # if the register is alias reg or shared reg(not the first), its field will not be instanced
            if(internal_register.alias is True or (internal_register.shared is True and internal_register.first_shared is False)):
                pass
            else:
                for field in internal_register.children:
                    field_name = '_'.join(field.hierachy[:-1]).replace('][','_').replace('[','').replace(']','') + '__%s'%(field.hierachy[-1])
                    self.fields_ports += '//%s\n'%(field.hierachy) + \
                                         '\t%s__next_value,\n'%(field_name) + \
                                         '\t%s__pulse,\n'%(field_name) if(field.hw != "`HW_RO") else ''
                    self.fields_ports += '\t%s__curr_value,\n'%(field_name)
                    self.fields_ports += '\t%s__swmod_out,\n'%(field_name) if field.swmod else ''
                    self.fields_ports += '\t%s__swacc_out,\n'%(field_name) if field.swacc else ''
        # self.fields_ports = self.fields_ports[:] + '\n'
        self.fields_ports += '//' + 'INTERNAL field connection port END'.center(100,"*") + '//\n'

        # get regslv parameter
        self.parameter += '//' + 'PARAMETER Definition START Here'.center(100,"*") + '//\n' + \
                          'parameter ADDR_WIDTH = 64;\n' + \
                          'parameter DATA_WIDTH = 32;\n' + \
                          '//N:number of internal registers, M:number of external modules\n' + \
                          'localparam N = %s;\n'%(self.N) + \
                          'localparam M = %s;\n'%(self.M) + \
                          'localparam REG_NUM = N ? N :1;\n' + \
                          'localparam EXT_NUM = M ? M :1;\n' + \
                          '//' + 'PARAMETER Definition END Here'.center(100,"*") + '//\n'

        # get reg_slv native ports
        self.wire_declaration += '//' + 'WIRE DECLARATION START'.center(100,"*") + '//\n' + \
                                 'input clk;\n' + \
                                 'input rstn;\n' + \
                                 'input req_vld;\n' + \
                                 'output req_rdy;\n' + \
                                 'input wr_en;\n' + \
                                 'input rd_en;\n' + \
                                 'input [ADDR_WIDTH-1:0] addr;\n' + \
                                 'input [DATA_WIDTH-1:0] wr_data;\n' + \
                                 'output [DATA_WIDTH-1:0] rd_data;\n' + \
                                 'input global_sync_reset_in;\n' + \
                                 'output global_sync_reset_out;\n' + \
                                 'output ack_vld;\n' + \
                                 'input ack_rdy;\n'
        self.wire_declaration += '//declare the syn_rst\n'
        for signal in signal_map:
            self.wire_declaration += 'input %s;\n'%(signal.hierachy_name)
        # get reg_slv external ports
        self.wire_declaration += '//declare the portwidth of external module\n' + \
                                 'output [EXT_NUM-1:0] ext_req_vld;\n' + \
                                 'input ext_req_rdy;\n' + \
                                 'output ext_wr_en;\n' + \
                                 'output ext_rd_en;\n' + \
                                 'output [ADDR_WIDTH-1:0] ext_addr;\n' + \
                                 'output [DATA_WIDTH-1:0] ext_wr_data;\n' + \
                                 'input [EXT_NUM-1:0] [DATA_WIDTH-1:0] ext_rd_data;\n' + \
                                 'input [EXT_NUM-1:0] ext_ack_vld;\n' + \
                                 'output ext_ack_rdy;\n'

        # get reg_slv_field ports
        for internal_register in self.internal_register_map:
            # if the register is alias reg or shared reg(not the first), its field will not be instanced
            if(internal_register.alias is True or (internal_register.shared is True and internal_register.first_shared is False)):
                pass
            else:
                for field in internal_register.children:
                    field_name = '_'.join(field.hierachy[:-1]).replace('][','_').replace('[','').replace(']','') + '__%s'%(field.hierachy[-1])
                    self.wire_declaration += '//%s\n'%(field.hierachy) + \
                                         'input [%d-1:0] %s__next_value;\n'%(field.fieldwidth,field_name) + \
                                         'input %s__pulse;\n'%(field_name) if(field.hw != "`HW_RO") else ''
                    self.wire_declaration += 'output [%d-1:0] %s__curr_value;\n'%(field.fieldwidth,field_name)
                    self.wire_declaration += 'output %s__swmod_out;\n'%(field_name) if field.swmod else ''
                    self.wire_declaration += 'output %s__swacc_out;\n'%(field_name) if field.swacc else ''

        self.wire_declaration += 'logic [EXT_NUM-1:0] ext_sel;\n' + \
                                 'wire external;\n' + \
                                 'assign external = |ext_sel;\n' + \
                                 'wire [DATA_WIDTH-1:0] ext_rd_data_vld;\n' + \
                                 '//declare the portwidth of internal registers\n' + \
                                 'wire [REG_NUM-1:0] [DATA_WIDTH-1:0] reg_rd_data_in;\n' + \
                                 'wire [DATA_WIDTH-1:0] reg_rd_data_vld;\n' + \
                                 'logic [REG_NUM-1:0] reg_sel;\n' + \
                                 'wire internal;\n' + \
                                 'logic dummy_reg;\n' + \
                                 'assign internal = (|reg_sel) | dummy_reg;\n' + \
                                 'wire wr_en_ff;\nwire rd_en_ff;\nwire [ADDR_WIDTH-1:0] addr_decode;\nwire [DATA_WIDTH-1:0] wr_data_ff;\n' + \
                                 'wire [REG_NUM-1:0] wr_sel_ff;\nwire [REG_NUM-1:0] rd_sel_ff;\n' + \
                                 'assign wr_sel_ff = {REG_NUM{wr_en_ff}} & reg_sel;\nassign rd_sel_ff = {REG_NUM{rd_en_ff}} & reg_sel;\n' + \
                                 'wire [DATA_WIDTH-1:0] rd_data_vld_in;\nwire ack_vld_in;\n' + \
                                 'wire ext_reg_ack_vld;\n' + \
                                 'wire ext_ack_rdy;\n' + \
                                 'wire[EXT_NUM-1:0] ext_ack_vld;\n' + \
                                 'wire[EXT_NUM-1:0] ext_ack;\n' + \
                                 'wire[EXT_NUM-1:0] ext_req_rdy;\n' + \
                                 'wire req_vld_s;\n' + \
                                 '//' + 'WIRE DECLARATION END'.center(100,"*") + '//\n'

        # get state machine instantiate
        self.state_machine += '//' + 'STATE MACHINE INSTANCE START'.center(100,"*") + '//\n'
        if(self.master is False):
            self.state_machine += 'slv_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH), .M(M), .N(N))\n' + \
                                  '\tslv_fsm_%s (\n'%(self.module_name) + \
                                  '\t.clk(clk), .rstn(rstn), .req_vld(req_vld), .wr_en(wr_en), .rd_en(rd_en), .addr(addr), .wr_data(wr_data),\n' + \
                                  '\t.rd_data_vld_in(rd_data_vld_in), .ack_vld_in(ack_vld_in), .req_vld_s(req_vld_s),\n' + \
                                  '\t.wr_en_ff(wr_en_ff), .rd_en_ff(rd_en_ff), .addr_decode(addr_decode), .wr_data_ff(wr_data_ff),\n' + \
                                  '\t.req_rdy_m(req_rdy), .ack_rdy_m(ack_rdy),\n' + \
                                  '\t.req_rdy_s(|{ext_req_rdy&ext_sel,internal}), .ack_rdy_s(ext_ack_rdy),\n' + \
                                  '\t.rd_data(rd_data), .ack_vld(ack_vld),\n' + \
                                  '\t.global_sync_reset_in(global_sync_reset_in),\n' + \
                                  '\t.global_sync_reset_out(global_sync_reset_out)\n' + '\t);\n'
        else:
            self.state_machine += 'mst_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH), .M(M))\n' + \
                                  '\tmst_fsm%s (\n'%(self.module_name) + \
                                  '\t.clk(clk), .rstn(rstn), .req_vld(req_vld), .wr_en(wr_en), .rd_en(rd_en), .addr(addr), .wr_data(wr_data),\n' + \
                                  '\t.rd_data_vld_in(rd_data_vld_in), .ack_vld_in(ack_vld_in),\n' + \
                                  '\t.wr_en_ff(wr_en_ff), .rd_en_ff(rd_en_ff), .addr_ff(addr_ff), .wr_data_ff(wr_data_ff),\n' + \
                                  '\t.req_rdy_m(req_rdy), .ack_rdy_m(ack_rdy),\n' + \
                                  '\t.req_rdy_s(ext_req_rdy), .ack_rdy_s(ext_ack_rdy),\n' + \
                                  '\t.rd_data(rd_data), .ack_vld(ack_vld),\n' + \
                                  '\t.global_sync_reset(global_sync_reset),\n' + \
                                  '\t.slv_sel(ext_sel), .slv_sel_ff(ext_sel_ff),\n' + \
                                  '\t.dummy_reg(dummy_reg), .dummy_reg_ff(dummy_reg_ff),\n' + \
                                  '\t.clear(clear), .interrupt(interrupt)\n' + \
                                  '\t);\n'
        self.state_machine += '//' + 'STATE MACHINE INSTANCE END'.center(100,"*") + '//\n'
        # get split mux instantiate
        self.split_mux += '//' + 'Rd_data/Ack_vld Split Mux START Here'.center(100,"*") + '//\n'
        if(self.N > 0):
            self.split_mux += 'split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(N+1), .GROUP_SIZE(64)) rd_split_mux\n' + \
                              '(.clk(clk), .rst_n(rstn),\n' + \
                              '.din({reg_rd_data_in,{DATA_WIDTH{1\'b0}}}), .sel({rd_sel_ff,dummy_reg}),\n' + \
                              '.dout(reg_rd_data_vld), .dout_vld(reg_ack_vld)\n' + \
                              ');\n'
        if(self.M > 0):
            self.split_mux += 'split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(M), .GROUP_SIZE(64)) ext_rd_split_mux\n' + \
                              '(.clk(clk), .rst_n(rstn),\n' + \
                              '.din(ext_rd_data), .sel(ext_ack),\n' + \
                              '.dout(ext_rd_data_vld), .dout_vld(ext_reg_ack_vld)\n' + \
                              ');\n'
        self.split_mux += '//' + 'Rd_data/Ack_vld Split Mux END Here'.center(100,"*") + '//\n'
        # get output select
        self.output_select += '//' + 'Final Split Mux OUT Signal Definitinon START Here'.center(100,"*") + '//\n'
        self.output_select += '// select which to read out and transfer the corresponding vld signal\n'
        if(self.M > 0 and self.N > 0):
            self.output_select += 'assign rd_data_vld_in = reg_ack_vld ? reg_rd_data_vld : (ext_reg_ack_vld ? ext_rd_data_vld : 0);\n'
            self.output_select += 'assign ack_vld_in = reg_ack_vld | ext_reg_ack_vld| (wr_en_ff & internal);\n'
        elif(self.M == 0 and self.N > 0):
            self.output_select += 'assign rd_data_vld_in = reg_ack_vld ? reg_rd_data_vld : 0;\n'
            self.output_select += 'assign ack_vld_in = reg_ack_vld | (wr_en_ff & internal);\n'
        elif(self.M > 0 and self.N == 0):
            self.output_select += 'assign rd_data_vld_in = dummy_reg ? {DATA_WIDTH{1\'b0}} : (ext_reg_ack_vld ? ext_rd_data_vld : 0);\n'
            self.output_select += 'assign ack_vld_in = dummy_reg |ext_reg_ack_vld;\n'
        else:
            try:
                sys.exit(1)
            except:
                print('NO internal or external regs found!')
        self.output_select += '//' + 'Final Split Mux OUT Signal Definitinon END Here'.center(100,"*") + '//\n'

    # convert addr or reset value from int(decimal) to str(hex)
    def get_hex(self,dec_d:int) -> str:
        if(dec_d is None):
            return '0'
        hex_d = str(hex(dec_d)[2:])
        return hex_d