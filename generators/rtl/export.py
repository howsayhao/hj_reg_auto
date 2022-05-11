import os

import utils.message as message
from systemrdl.node import RootNode

from .gen_tree import Root_str


def export_rtl(root:RootNode, out_dir:str):
    """
    生成寄存器RTL模型, 包含regmst和regslv

    Parameter
    ---------
    `root` : `systemrdl.node.RootNode` systemrdl-compiler解析完成的寄存器模型根节点
    `out_dir` : 输出RTL的目录, 会在该目录下创建一个`rtl`子目录, 存放输出的RTL模块
    """
    rtl_dir = os.path.join(out_dir, "rtl")
    if not os.path.exists(rtl_dir):
        os.makedirs(rtl_dir)
    try:
        Reg_sub_tree = Root_str(node=root, folder_name=rtl_dir)
        Reg_sub_tree.scan()
    except:
        message.error("rtl export failed due to previous error")
    else:
        message.info("save rtl in directory: %s" % (rtl_dir))
