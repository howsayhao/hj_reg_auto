import sys

from systemrdl.node import *

from .rtl_type import *


# create new rtl_type from node type while copying the useful information to draw rtl
def create_obj(node:Node, parent_obj:RTL_NODE, base_addr) -> RTL_NODE:
    if isinstance(node, SignalNode):
        new_obj = Signal(node.get_path_segment())
        # self.signal_map.append(new_obj)
    elif isinstance(node, RootNode):
        # get rootnode information
        new_obj = Root("Root")
    elif isinstance(node, AddrmapNode):
        # get addrmap information
        new_obj = Addressmap(node.get_path_segment())
        new_obj.name = node.get_property('name')
        new_obj.desc = node.get_property('desc')
        new_obj.addressing = node.get_property('addressing').name
        new_obj.alignment = node.get_property('alignment')
        new_obj.sharedextbus = node.get_property('sharedextbus')
        new_obj.errextbus = node.get_property('errextbus')
        new_obj.rsvdset = node.get_property('rsvdset')
        new_obj.addr = node.absolute_address
        # different from rdl, when a addrmap's hj_genslv property is True, it will be treated as an internal regfile
        new_obj.external = node.get_property('hj_genslv') if('hj_genslv' in node.inst.properties) else False
    elif isinstance(node, RegfileNode):
        # get regfile information
        new_obj = Regfile(node.get_path_segment())
        new_obj.name = node.get_property('name')
        new_obj.desc = node.get_property('desc')
        new_obj.alignment = node.get_property('alignment')
        new_obj.addr = node.absolute_address
    elif isinstance(node, MemNode):
        # get memory information
        new_obj = Memory(node.get_path_segment())
        new_obj.name = node.get_property('name')
        new_obj.desc = node.get_property('desc')
        new_obj.sw = node.get_property('sw').name
        new_obj.memwidth = node.get_property('memwidth')
        new_obj.mementries = node.get_property('mementries')
        new_obj.addr = node.absolute_address
    elif isinstance(node, RegNode):
        # get register information
        new_obj = Reg(node.get_path_segment())
        # for alias or shared registers it will add a mark
        if(node.inst.alias_primary_inst is not None):
            new_obj.alias = True
            new_obj.alias_origin = node.inst.alias_primary_inst.inst_name
            # self.alias_register_map.append(new_obj)
        if(node.get_property('shared') is True):
            new_obj.shared = True
            new_obj.shared_origin = node.inst.original_def.type_name
            # self.shared_register_map.append(new_obj)
        # for independent registers
        new_obj.name = node.get_property('name')
        new_obj.desc = node.get_property('desc')
        new_obj.regwidth = node.get_property('regwidth')
        new_obj.shared = node.get_property('shared')
        new_obj.offset = node.address_offset
        new_obj.addr = node.absolute_address - base_addr
        new_obj.external = node.external
    elif isinstance(node, FieldNode):
        # get field information
        new_obj = Field(node.get_path_segment())
        new_obj.name = node.get_property('name')
        new_obj.desc = node.get_property('desc')
        new_obj.alias = parent_obj.alias
        # field signal link
        new_obj.fieldwidth = node.get_property('fieldwidth')
        new_obj.next = node.get_property('next')
        syn_rst = []
        new_obj.syncresetsignal = syn_rst
        new_obj.reset = str(new_obj.fieldwidth) + '\'h' + get_hex(node.get_property('reset'))

        # new_obj.resetsignal = node.get_property('resetsignal').get_path_segment()
        # field place
        new_obj.msb = node.msb
        new_obj.lsb = node.lsb
        #software accesstype
        sw = node.get_property('sw').name.upper()
        if(sw == 'R' or sw == 'W'):
            sw += 'O'
        new_obj.sw = '`' + 'SW_' + sw
        new_obj.onread = '`' + node.get_property('onread').name.upper() if(node.get_property('onread') is not None) else '`NA'
        new_obj.onwrite = '`' + node.get_property('onwrite').name.upper() if(node.get_property('onwrite') is not None) else '`NA'
        new_obj.swmod = node.get_property('swmod')
        new_obj.swacc = node.get_property('swacc')
        new_obj.singlepulse = node.get_property('singlepulse')
        if(new_obj.onwrite != '`NA' and new_obj.singlepulse is True and new_obj.parent.external is False):
            try:
                sys.exit(1)
            except:
                print('Filed ONWRITE TYPE Collided with SINGLEPULSE @%s'%(new_obj.obj))
        # hardware access type
        new_obj.hw = node.get_property('hw').name
        new_obj.hwclr = node.get_property('hwclr')
        new_obj.hwset = node.get_property('hwset')
        # detect the corruption
        if(new_obj.hw == 'ro' and (new_obj.hwclr is True or new_obj.hwset is True and new_obj.parent.external is False)):
            try:
                sys.exit(1)
            except:
                print('Filed HW TYPE Collided with HWCLR/HWSET @%s'%(new_obj.obj))
        elif(new_obj.hw == 'rw' and new_obj.hwclr is True):
            new_obj.hw = '`HW_CLR'
        elif(new_obj.hw == 'rw' and new_obj.hwset is True):
            new_obj.hw = '`HW_SET'
        elif(new_obj.hw == 'rw'):
            new_obj.hw = '`HW_RW'
        else:
            new_obj.hw = '`HW_RO'
        new_obj.precedence = node.get_property('precedence').name
    return new_obj

# convert addr or reset value from int(decimal) to str(hex)
def get_hex(dec_d:int) -> str:
    if(dec_d is None):
        return '0'
    hex_d = str(hex(dec_d)[2:])
    return hex_d
