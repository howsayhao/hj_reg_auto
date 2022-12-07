import os
import traceback

import utils.message as message
from peakrdl.uvm import UVMExporter
from systemrdl.node import AddrmapNode


def export_uvm(top_node:AddrmapNode, out_dir:str):
    """
    Export UVM RAL model package

    Parameters
    ----------
    top_node
        Top-level address map node
    out_dir
        ouput directory to save the generated UVM RAL model package
    """
    exporter = UVMExporter()
    export_file = os.path.join(out_dir, "%s.sv" % (top_node.inst_name))

    try:
        exporter.export(
            top_node,
            export_file,
            reuse_class_definitions=False,
            use_uvm_factory=True
        )
    except:
        message.error(
            "HRDA encounters some unknown errors\n{}\n"
            "UVM RAL exporter aborted due to previous errors".format(
                traceback.format_exc()
            )
        )
    else:
        message.info("save UVM RAL model in: %s" % (export_file))
