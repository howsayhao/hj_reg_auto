import math
from .rtl_type import Memory

def judge_addr(new_obj):
    if(isinstance(new_obj, Memory)):
        addr = new_obj.addr
        size = new_obj.mementries * new_obj.memwidth / 8
        new_obj.valid_width = math.ceil(math.log2(size))
        new_obj.entry_width = math.ceil(math.log2(new_obj.mementries))
        new_obj.ADDR_WIDTH = new_obj.entry_width
        new_obj.DATA_WIDTH = new_obj.memwidth
    if(addr % int(size)):
        print("%s addr would be subed by %d"%(new_obj.obj, new_obj.addr)) if(new_obj.parent.external is False) else None
        new_obj.addr_sub = 1
    else:
        new_obj.addr_sub = 0

    size_log = math.log2(size)
    if(size_log -int(size_log)):
        print("%s: size isn't pow of 2"%(new_obj.obj))
    else:
        print("%s: addr-wire higher than %d-th bit will be cut"%(new_obj.obj, int(size_log))) if(new_obj.parent.external is False) else None



if __name__ == "__main__":
    new_obj = Memory("inst")
    new_obj.addr = 32
    new_obj.mementries = 2
    new_obj.memwidth = 128
    judge_addr(new_obj)