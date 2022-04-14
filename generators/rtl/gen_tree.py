import os
import shutil

from systemrdl.node import *

from .create_obj import *
from .gen_addrmap import *
from .gen_field_rtl import *
from .rtl_type import *


class Root_str(object):
    def __init__(self, node:Node, folder_name:str):
        self.node = node
        self.module_name = 'reg_tree'
        # file place
        self.folder_name = folder_name
        # root rtl_obj
        self.rtl_obj = create_obj(node = self.node, parent_obj= None)
        self.children = []
        # root component
        self.global_signal_map = []
        self.reg_mst = None
        self.reg_slv = []
        self.third_party = []
        self.genrtl_node = []
        # ports
        self.field_in = []
        self.field_out = []
        # rtl nested
        # self.children = []
        self.rtl = ''
        self.def_str = ''
        self.port_str = ''

    def scan(self):
        # scan the root obj
        for child in self.node.children(unroll=True, skip_not_present=True):
            if(isinstance(child, AddrmapNode)):
                Top_Addrmap = child
            elif(isinstance(child, SignalNode)):
                new_signal = create_obj(child, self.rtl_obj)
                signal_name = child.get_path_segment()
                new_signal.hierachy_name = signal_name
                self.rtl_obj.children.append(new_signal)
                self.global_signal_map.append(new_signal)
        # create reg_mst and reg_slv
        module_name = Top_Addrmap.get_path_segment()
        if(os.path.exists(self.folder_name)):
            shutil.rmtree(self.folder_name)
        # create new folder
        os.mkdir(self.folder_name)
        Top_Map = addrmap_str(Top_Addrmap, master = True, Root = self, hierarchy = [])

        # create reg_mst's reg_slv_if
        Top_Map.reg_slv_if.global_sync = 'fsm_sync_reset'
        Top_Map.reg_slv_if.req_vld = 'req_vld'
        Top_Map.reg_slv_if.req_rdy = 'req_rdy'
        Top_Map.reg_slv_if.ack_vld = 'ack_vld'
        Top_Map.reg_slv_if.ack_rdy = 'ack_rdy'
        Top_Map.reg_slv_if.rd_data = 'rd_data'
        Top_Map.reg_slv_if.wr_en = 'wr_en'
        Top_Map.reg_slv_if.rd_en = 'rd_en'
        Top_Map.reg_slv_if.wr_data = 'wr_data'
        Top_Map.reg_slv_if.addr = 'addr'
        # start write addrmap regmst and regslv rtl file
        Top_Map.write()
        self.children.append(Top_Map)
        # get all object instantiate
        self.define()
        self.port()
        self.third_party_wire()
        self.write()

    def define(self):
        ins = self.reg_slv[:]
        ins.insert(0,self.reg_mst)
        # get internal/external wire definition and connectinon
        # reg_slv will be treated as external module by upstream modules, so we only need to define upstream wire and connects them
        for module in ins:
            if(module.M >= 0):
                M = module.M if(module.M > 0) else 1
                module_name = 'regslv_' + module.module_name if(module.master is not True) else 'regmst_' + module.module_name
                self.def_str += 'logic [%d-1:0] %s_ext_req_vld;\n'%(M,module_name) + \
                                'logic [%d-1:0] %s_ext_req_rdy;\n'%(M,module_name) + \
                                'logic [%d-1:0] %s_ext_ack_vld;\n'%(M,module_name) + \
                                'logic %s_ext_ack_rdy;\n'%(module_name) + \
                                'logic [%d-1:0] [`DATA_WIDTH-1:0]%s_ext_rd_data;\n'%(M,module_name) + \
                                'logic %s_wr_en;\n'%(module_name) + \
                                'logic %s_rd_en;\n'%(module_name) + \
                                'logic %s_fsm_sync_reset;\n'%(module_name) + \
                                'logic [`DATA_WIDTH-1:0]%s_wr_data;\n'%(module_name) + \
                                'logic [`ADDR_WIDTH-1:0] %s_addr;\n'%(module_name)
                                # 'logic %s_cdc_pulse_out;\n'%(module_name)

    def port(self):
        ins = self.reg_slv[:]
        ins.insert(0,self.reg_mst)
        # necessary port from outside (APB/AHB master) for reg_mst
        self.port_str += '\t//reg_mst interface port\n'
        self.port_str += '\t input clk\n'
        self.port_str += '\t,input rstn\n'
        self.port_str += '\t,input [`ADDR_WIDTH-1:0]PADDR\n'
        self.port_str += '\t,input PWRITE\n'
        self.port_str += '\t,input PSEL\n'
        self.port_str += '\t,input PENABLE\n'
        self.port_str += '\t,input [`DATA_WIDTH-1:0]PWDATA\n'
        self.port_str += '\t,output [`DATA_WIDTH-1:0]PRDATA\n'
        self.port_str += '\t,output PREADY\n'
        self.port_str += '\t,output PSLVERR\n'
        self.port_str += '\t,input clear\n'
        self.port_str += '\t,input interrupt\n'

        # declare cdc_pulse
        self.port_str += '\t//reg module cdc pulse port\n'
        for slv in ins:
            module_name = 'regslv_' + slv.module_name if(slv.master is not True) else 'regmst_' + slv.module_name
            self.port_str += '\t,output %s_cdc_pulse_out\n'%(module_name)

        # declare field in/out port
        self.port_str += '\t//field interface port\n'
        for slv in self.reg_slv:
            for field_port in slv.field_in:
                self.port_str += '\t,input [%s-1:0]%s\n'%(field_port.width,field_port.obj)
                # print('\t,input [%s-1:0]%s\n'%(field_port.width,field_port.obj))
            for field_port in slv.field_out:
                self.port_str += '\t,output [%s-1:0]%s\n'%(field_port.width,field_port.obj)
        self.port_str += '\t//field interface end\n'
        # declare sync_reset port
        self.port_str += '\t//sync_reset interface start\n'
        for slv in self.reg_slv:
            for native_sync_signal in slv.signal_map:
                self.port_str += '\t,input %s\n'%(native_sync_signal.hierachy_name)
        self.port_str += '\t//sync_reset interface end\n'

    # if any third party or memory is used, the corresponding ports would be created
    def third_party_wire(self):
        self.def_str += '//external IP/memory port define\n'
        self.port_str += '//external IP/memory port declare\n'
        for module in self.third_party:
            wire_name = module.ref + "__"  + module.obj
            # each external memory or third IP will have seperate wires from referenced module
            self.port_str += '\t,output %s_req_vld\n'%(wire_name)
            self.port_str += '\t,input %s_ack_vld\n'%(wire_name)
            self.port_str += '\t,input %s_req_rdy\n'%(wire_name)
            self.port_str += '\t,output %s_ack_rdy\n'%(wire_name)
            self.port_str += '\t,input [`DATA_WIDTH-1:0]%s_rd_data\n'%(wire_name)
            # allocate each external module to referenced module
            self.def_str += '//external: %s ref:%s  wire connection define\n'%(module.obj, module.ref)
            self.def_str += 'assign %s_req_vld = %s_ext_req_vld[%d];\n'%(wire_name, module.ref, module.ref_id)
            self.def_str += 'assign %s_ack_rdy = %s_ext_ack_rdy;\n'%(wire_name, module.ref)
            self.def_str += 'assign %s_ext_ack_vld[%d] = %s_ack_vld;\n'%(module.ref, module.ref_id, wire_name)
            self.def_str += 'assign %s_ext_req_rdy[%d] = %s_req_rdy;\n'%(module.ref, module.ref_id, wire_name)
            self.def_str += 'assign %s_ext_rd_data[%d] = %s_rd_data;\n'%(module.ref, module.ref_id, wire_name)
        self.port_str += '//external IP/memory port declare\n'
        # for slv in self.reg_slv:
        #     # the slv need ports for third party or memory, some common ports would be generated
        #     if(slv.thirdparty_num > 0):
        #         module_name = 'regslv_' + slv.module_name
        #         self.port_str += '\t,output %s_addr\n'%(module_name)
        #         self.port_str += '\t,output %s_wr_en\n'%(module_name)
        #         self.port_str += '\t,output %s_rd_en\n'%(module_name)
        #         self.port_str += '\t,output %s_wr_data\n'%(module_name)
        #         self.port_str += '\t,output %s_fsm_sync_reset\n'%(module_name)
        # self.port_str += '//external IP/memory port end\n'

    # write the top rtl file for including others
    def write(self):
        self.rtl += '`define ADDR_WIDTH 7\'d64\n'
        self.rtl += '`define DATA_WIDTH 6\'d32\n'
        self.rtl += 'module ' + 'reg_tree \n'
        # self.rtl += '#(parameter ADDR_WIDTH = 64,\nparameter DATA_WIDTH = 32)\n'
        self.rtl += '(\n'
        self.rtl += self.port_str
        self.rtl += ');\n'

        self.rtl += '//parameter instance here\n'
        # self.rtl += 'parameter ADDR_WIDTH = 64;\n'
        # self.rtl += 'parameter DATA_WIDTH = 32;\n'
        self.rtl += '//wire definition here\n'
        # get internal/external wire definition and connectinon
        self.rtl += self.def_str
        ins = self.reg_slv[:]
        ins.insert(0,self.reg_mst)
        # instantiate the regmst and regslv
        self.rtl += '//reg module instance here\n'
        for slv in ins:
            if(slv.master):
                self.rtl += 'regmst_%s #(.ADDR_WIDTH(`ADDR_WIDTH), .DATA_WIDTH(`DATA_WIDTH))\n\tregmst_%s (\n'%(slv.module_name, slv.module_name)
            else:
                self.rtl += 'regslv_%s #(.ADDR_WIDTH(`ADDR_WIDTH), .DATA_WIDTH(`DATA_WIDTH))\n\tregslv_%s (\n'%(slv.module_name, slv.module_name)
            # each instance has correspond reg_slv_if
            slv_if = slv.reg_slv_if
            if(slv.master):
                self.rtl += '\t//APB interface instance\n' + \
                            '\t.clk(%s)'%(slv_if.clk) + \
                            ',.rstn(%s)'%(slv_if.rstn) + \
                            ',.PADDR(PADDR), .PWRITE(PWRITE), .PSEL(PSEL), .PENABLE(PENABLE), .PWDATA(PWDATA), .PRDATA(PRDATA), .PREADY(PREADY), .PSLVERR(PSLVERR)\n\t'
            else:
                self.rtl += '\t//reg_module upstream interface instance\n' + \
                            '\t.clk(%s)'%(slv_if.clk) + \
                            ',.rstn(%s)'%(slv_if.rstn) + \
                            ',.req_vld(%s)'%(slv_if.req_vld) + \
                            ',.req_rdy(%s)\n\t'%(slv_if.req_rdy) + \
                            ',.wr_en(%s)'%(slv_if.wr_en) + \
                            ',.rd_en(%s)'%(slv_if.rd_en) + \
                            ',.addr(%s)'%(slv_if.addr) + \
                            ',.wr_data(%s)\n\t'%(slv_if.wr_data) + \
                            ',.ack_vld(%s)'%(slv_if.ack_vld) + \
                            ',.ack_rdy(%s)'%(slv_if.ack_rdy) + \
                            ',.rd_data(%s)\n\t'%(slv_if.rd_data)

            for native_sync_signal in slv.signal_map + self.global_signal_map:
                self.rtl += ',.%s(%s)\n\t'%(native_sync_signal.hierachy_name, native_sync_signal.hierachy_name)
            # regmst will generate the interrupt signal and get clear signal from top
            self.rtl += ',.clear(clear), .interrupt(interrupt)\n\t' if(slv.master is True) else ''
            if(slv.M >= 0):
                # when module has external downstream module, the corresponding ports will be generated
                module_name = 'regslv_' + slv.module_name if(slv.master is not True) else 'regmst_' + slv.module_name
                self.rtl += '//reg_slv downstream interface instance\n\t' + \
                            ',.ext_req_vld(%s_ext_req_vld),'%(module_name) +  \
                            '.ext_req_rdy(%s_ext_req_rdy),'%(module_name) +  \
                            '.ext_ack_vld(%s_ext_ack_vld),'%(module_name) +  \
                            '.ext_ack_rdy(%s_ext_ack_rdy),'%(module_name) +  \
                            '.ext_rd_data(%s_ext_rd_data)\n\t'%(module_name) +\
                            ',.ext_wr_en(%s_wr_en),'%(module_name) +  \
                            '.ext_rd_en(%s_rd_en),'%(module_name) +  \
                            '.ext_wr_data(%s_wr_data),'%(module_name) +  \
                            '.ext_addr(%s_addr),'%(module_name) + \
                            '.cdc_pulse_out(%s_cdc_pulse_out)\n\t'%(module_name)

            # regslv will get the reset signal from upstream module as well as other signal
            module_name = 'regslv_' + slv.module_name if(slv.master is not True) else 'regmst_' + slv.module_name
            if(slv.master):
                self.rtl += ',.global_sync_reset_out(%s_fsm_sync_reset)'%(module_name)
            else:
                self.rtl += ',.global_sync_reset_out(%s_fsm_sync_reset)'%(module_name)
                self.rtl += ',.global_sync_reset_in(%s)'%(slv_if.global_sync)
            # each modules' field ports will be connected to top transparently
            i = 0
            self.rtl += '//field ports instance\n\t'
            for field_port in slv.field_in + slv.field_out:
                self.rtl += ',.%s(%s)'%(field_port.obj,field_port.obj)
                i += 1
                self.rtl += '\n\t' if (i % 3 == 0) else ''
            self.rtl += '\n\t);\n'

        self.rtl += 'endmodule'

        file_name = self.module_name + '_top.v'
        fw = open(file_name,'w')
        fw.write(self.rtl)
        fw.close()
        folder_name = self.folder_name
        shutil.move(file_name,folder_name)
