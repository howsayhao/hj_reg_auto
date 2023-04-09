import os
import traceback

import utils.message as message
from systemrdl.node import AddrmapNode

from .generate_graphviz import VIZExporter


def export_viz(top_node:AddrmapNode, out_dir:str):
    """
    Generate RTL code, including regmst, regslv, regdisp and other components

    Parameter
    ---------
    top_node : AddrmapNode
        Top-level address map node
    out_dir : str
        Output directory
    """
    graphviz_dir = os.path.join(out_dir, "graphviz")

    if not os.path.exists(graphviz_dir):
        os.makedirs(graphviz_dir)

    try:
        # print(graphviz_dir)
        VIZExporter().export(top_node, graphviz_dir)
    except Exception:
        message.error(
            "HRDA encounters some unknown errors when generating graphviz\n"
        )
    else:
        message.info("save VIZ in directory: %s" % (graphviz_dir))
