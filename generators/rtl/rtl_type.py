class reg_slv_if(object):
    def __init__(self, obj) -> None:
        self.obj = obj
        self.clk = 'clk'
        self.rst_n = 'rst_n'
        self.req_vld = ''
        self.req_rdy = ''
        self.wr_en = ''
        self.rd_en = ''
        self.addr = ''
        self.wr_data = ''
        self.sync_in = ''
        self.sync_out = ''
        self.ack_rdy = ''
        self.ack_vld = ''
        self.rd_data = ''
        self.global_sync = ''

class reg_slv_if_m(object):
    def __init__(self, obj) -> None:
        pass

# a class contains external registers maps to common external top module's addr
class addrpointer(object):
    def __init__(self, addr) -> None:
        self.addr = addr
        self.registers = []
        self.register_names = []
        self.addr_str = []

class RTL_NODE(object):
    def __init__(self, obj) -> None:
        self.obj = obj
        self.name = ""
        self.desc = ""
        self.parent = None
        self.children = []
        self.hierachy = []
        self.hierachy_name = ''
        self.external = False
        self.external_top = None

class Signal(RTL_NODE):
    def __init__(self, obj, width = "1") -> None:
        RTL_NODE.__init__(self,obj)
        self.width = width
        self.dir = 'dual'
        self.source = None
        self.sink = None


class Field(RTL_NODE):
    def __init__(self, obj) -> None:
        RTL_NODE.__init__(self,obj)
        self.alias = False
        self.alias_field = []
        self.fieldwidth = 0
        self.reset = 0
        self.next = ""
        self.resetsignal = "regslv_rstn"
        self.syncresetsignal = ""
        self.syncresetsignal = ""

        self.sw = "RW"
        self.onread = "NA"
        self.onwrite = "NA"
        self.swmod = False
        self.swacc = False
        self.singlepulse = False
        self.hw = "R"
        self.hwclr = ""
        self.hwset = ""

        self.precedence = "SW"

        self.msb = 0
        self.lsb = 0




class Reg(RTL_NODE):
    def __init__(self, obj) -> None:
        RTL_NODE.__init__(self,obj)
        self.id = 0
        self.alias = False
        self.alias_origin = ""
        self.shared_origin = ""
        # for snapshot
        self.snap = False
        self.snap_origin = None
        self.snap_id = 0
        self.snap_reg = []

        self.origin_reg = None
        self.alias_reg = []
        # regfile properties
        self.regwidth = 32
        self.addr = 0
        self.offset = 0
        self.first_shared = False
        self.shared = False


class Regfile(RTL_NODE):
    def __init__(self, obj) -> None:
        RTL_NODE.__init__(self,obj)
        self.alignment = ""
        self.addr = 0


class Memory(RTL_NODE):
    def __init__(self, obj) -> None:
        RTL_NODE.__init__(self,obj)
        self.mementries = 0
        self.memwidth = 16
        self.sw = "RW"
        self.external = True
        self.addr = 0

        self.ref = ""
        self.ref_id = 0

        self.addr_sub = 0
        self.valid_width = 0
        self.entry_width = 0

        self.cdc_clk = ""



class Addressmap(RTL_NODE):
    def __init__(self,obj) -> None:
        RTL_NODE.__init__(self,obj)
        self.alignment = ""
        self.sharedextbus = False
        self.errextbus = True
        self.addressing = "bigendien"
        self.external = True
        self.addr = 0
        self.cdc_clock = ""


class Root(RTL_NODE):
    def __init__(self,obj) -> None:
        RTL_NODE.__init__(self,obj)