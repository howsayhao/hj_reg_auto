import os
import traceback

import utils.message as message
from systemrdl.node import AddrmapNode

from .generate_rtl import RTLExporter


def export_rtl(top_node:AddrmapNode, out_dir:str, **kwargs):
    """
    Generate RTL code, including regmst, regslv, regdisp and other components

    Parameter
    ---------
    top_node : AddrmapNode
        Top-level address map node
    out_dir : str
        Output directory
    """
    rtl_dir = os.path.join(out_dir, "rtl")

    if not os.path.exists(rtl_dir):
        os.makedirs(rtl_dir)

    without_filelist = kwargs.pop("without_filelist", False)

    try:
        RTLExporter().export(top_node, rtl_dir, without_filelist=without_filelist)
    except Exception:
        message.error(
            "HRDA encounters some unknown errors\n{}\n"
            "RTL export failed due to previous error".format(
                traceback.format_exc()
            ), raise_err=False
        )
    else:
        message.info("save RTL in directory: %s" % (rtl_dir))
