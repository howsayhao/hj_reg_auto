import os
import sys
import traceback

import utils.message as message
from systemrdl.node import RootNode

from .gen_tree import root_str
from .gen_rtl_new import RTLExporter


def export_rtl(root:RootNode, out_dir:str):
    """
    Generate RTL code, including regmst, regslv, regdisp and other components

    Parameter
    ---------
    `root` : `systemrdl.node.RootNode`, compiled by SystemRDL Compiler
    `out_dir` : output directory
    """
    rtl_dir = os.path.join(out_dir, "rtl")
    os_env = "{}_DIR".format(root.top.inst_name.upper())
    os.environ[os_env] = os.path.realpath(rtl_dir)

    if not os.path.exists(rtl_dir):
        os.makedirs(rtl_dir)
    try:
        reg_tree = root_str(node=root, folder_name=rtl_dir)
        reg_tree.scan()
        RTLExporter().export_all(root, rtl_dir, os_env)
    except Exception:
        message.error(
            "HRDA encounters some unknown errors\n{}\n"
            "RTL export failed due to previous error".format(
                traceback.format_exc()
            )
        )
    else:
        message.info("save RTL in directory: %s" % (rtl_dir))
