import os

import utils.message as message
from systemrdl.node import RootNode

from .gen_tree import Root_str
from .gen_regdisp import RTLExporter


def export_rtl(root:RootNode, out_dir:str):
    """
    Generate RTL code, including regmst, regslv, regdisp and other components

    Parameter
    ---------
    `root` : `systemrdl.node.RootNode`, compiled by SystemRDL Compiler
    `out_dir` : output directory
    """
    rtl_dir = os.path.join(out_dir, "rtl")
    if not os.path.exists(rtl_dir):
        os.makedirs(rtl_dir)
    try:
        Reg_sub_tree = Root_str(node=root, folder_name=rtl_dir)
        Reg_sub_tree.scan()
        RTLExporter().export_regdisp(root, rtl_dir)
    except:
        message.error("RTL export failed due to previous error")
    else:
        message.info("save RTL in directory: %s" % (rtl_dir))
