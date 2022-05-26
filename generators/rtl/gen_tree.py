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
        self.module_name = 'reg'
        # file place
        self.folder_name = folder_name
        # root rtl_obj
        self.rtl_obj = create_obj(node = self.node, parent_obj= None, base_addr=0)
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
        self.mhdl = ''
        self.def_str = ''
        self.port_str = ''

    def scan(self):
        # scan the root obj
        for child in self.node.children(unroll=True, skip_not_present=False):
            if(isinstance(child, AddrmapNode)):
                Top_Addrmap = child
                base_addr = child.absolute_address
            elif(isinstance(child, SignalNode)):
                new_signal = create_obj(child, self.rtl_obj)
                signal_name = child.get_path_segment()
                new_signal.hierachy.append(signal_name)
                new_signal.hierachy_name = signal_name
                self.rtl_obj.children.append(new_signal)
                self.global_signal_map.append(new_signal)
        # create reg_mst and reg_slv
        module_name = Top_Addrmap.get_path_segment()
        if(os.path.exists(self.folder_name)):
            shutil.rmtree(self.folder_name)
        # create new folder
        os.mkdir(self.folder_name)
        Top_Map = addrmap_str(Top_Addrmap, master = True, Root = self, hierarchy = [], base_addr = base_addr)

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
        # self.define()
        # self.port()
        # self.third_party_wire()
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

    # write the top rtl file for including others
    def write(self):
        self.mhdl = ''
        instanted_module = self.reg_slv[:]
        instanted_module.insert(0,self.reg_mst)
        for slv in instanted_module:
            if slv.master:
                module_name = 'regmst_' + slv.module_name
                self.mhdl += '%s %s(\n'%(module_name, module_name)
                self.mhdl += '\t\"s/^global_sync_reset_out$/%s_global_sync_reset_out/g\" \\\n'%(slv.module_name)
                self.mhdl += ');\n\n'
            else:
                module_name = 'regslv_' + slv.module_name
                self.mhdl += '%s %s(\n'%(module_name, module_name)
                self.mhdl += '\t\t\t\"s/fsm_clk/PCLK/g\", \\\n'
                self.mhdl += '\t\t\t\"s/fsm_rstn/PRESETn/g\", \\\n'
                if(slv.cdc):
                    self.mhdl += '\t\t\t\"s/regfile_clk/%s_regfile_clk/g\", \\\n'%(slv.module_name)
                    self.mhdl += '\t\t\t\"s/regfile_rstn/%s_regfile_rstn/g\", \\\n'%(slv.module_name)
                self.mhdl += '\t\t\t\"s/^req_vld$/%s_req_vld/g\", \\\n'%(slv.module_name)
                self.mhdl += '\t\t\t\"s/^ack_vld$/%s_ack_vld/g\", \\\n'%(slv.module_name)
                self.mhdl += '\t\t\t\"s/^wr_en$/%s_wr_en/g\", \\\n'%(slv.module_name)
                self.mhdl += '\t\t\t\"s/^rd_en$/%s_rd_en/g\", \\\n'%(slv.module_name)
                self.mhdl += '\t\t\t\"s/^addr$/%s_addr/g\", \\\n'%(slv.module_name)
                self.mhdl += '\t\t\t\"s/^wr_data$/%s_wr_data/g\", \\\n'%(slv.module_name)
                self.mhdl += '\t\t\t\"s/^rd_data$/%s_rd_data/g\", \\\n'%(slv.module_name)
                self.mhdl += '\t\t\t\"s/^global_sync_reset_in$/%s_global_sync_reset_out/g\", \\\n'%(slv.parent_module_name)
                self.mhdl += '\t\t\t\"s/^global_sync_reset_out$/%s_global_sync_reset_out/g\" \\\n'%(slv.module_name)
                self.mhdl += '\t\t\t);\n\n'

        file_name = self.module_name + '_top.mhdl'
        fw = open(file_name,'w')
        fw.write(self.mhdl)
        fw.close()
        folder_name = self.folder_name
        shutil.move(file_name,folder_name)
