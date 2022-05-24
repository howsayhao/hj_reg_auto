import os

import utils.message as message
from peakrdl.uvm import UVMExporter
from systemrdl.node import RootNode

def export_uvm(root:RootNode, out_dir:str):
    """
    Export UVM RAL model package

    Parameter
    ---------
    `root` : `systemrdl.node.RootNode`, the root node of the compiled register model
    `out_dir` : ouput directory to save the generated UVM RAL (.sv) file
    """
    exporter = UVMExporter()
    export_file = os.path.join(out_dir, "%s.sv" % (root.top.inst_name))

    try:
        exporter.export(root, export_file,
                        reuse_class_definitions=False,
                        use_uvm_factory=True)
    except:
        message.error("UVM RAL exporter aborted due to previous errors")
    else:
        message.info("save UVM RAL model in: %s" % (export_file))