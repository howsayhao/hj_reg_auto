import os
import traceback

import utils.message as message
from systemrdl.node import RootNode

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

    if not os.path.exists(rtl_dir):
        os.makedirs(rtl_dir)
    try:
        RTLExporter().export(root, rtl_dir)
    except Exception:
        message.error(
            "HRDA encounters some unknown errors\n{}\n"
            "RTL export failed due to previous error".format(
                traceback.format_exc()
            ), raise_err=False
        )
    else:
        message.info("save RTL in directory: %s" % (rtl_dir))
