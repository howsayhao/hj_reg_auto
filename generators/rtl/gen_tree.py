import os

from systemrdl.node import *

from .create_obj import *
from .gen_addrmap import *
from .gen_field_rtl import *
from .rtl_type import *


class root_str(object):
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

        if not (os.path.exists(self.folder_name)):
            os.mkdir(self.folder_name)

        Top_Map = addrmap_str(Top_Addrmap, master = not Top_Addrmap.get_property("hj_genslv"), Root = self, hierarchy = [], base_addr = base_addr)

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
