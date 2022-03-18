import os

import utils.message as message
from peakrdl.uvm import UVMExporter
from systemrdl.node import RootNode

def export_uvm(root:RootNode, out_dir:str):
    """
    输出HTML形式的寄存器说明文档

    Parameter
    ---------
    `root` : `systemrdl.node.RootNode` systemrdl-compiler解析完以后的寄存器模型根节点
    `out_dir` : 输出HTML的目录, 会在该目录下创建一个`html`子目录, 存放输出的HTML
    """
    exporter = UVMExporter()
    export_file = os.path.join(out_dir, "uvm_test.sv")

    try:
        exporter.export(root, export_file, reuse_class_definitions=False)
    except:
        message.error("uvm export failed!")
    else:
        message.info("save in: %s" % (export_file))