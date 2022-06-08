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
        self.genslv_node = []
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
        self.write()

    # top wrapper mhdl
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
