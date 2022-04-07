import os

import utils.message as message
from peakrdl.html import HTMLExporter
from systemrdl.node import RootNode


def export_html(root:RootNode, out_dir:str):
    """
    输出HTML形式的寄存器说明文档

    Parameter
    ---------
    `root` : `systemrdl.node.RootNode` systemrdl-compiler解析完成的寄存器模型根节点
    `out_dir` : 输出HTML的目录, 会在该目录下创建一个`html`子目录, 存放输出的HTML
    """
    exporter = HTMLExporter()

    html_dir = os.path.join(out_dir, "html")
    if not os.path.exists(html_dir):
        os.makedirs(html_dir)
    try:
        exporter.export(root, html_dir)
    except:
        message.error("html export failed")
    else:
        message.info("save html in directory: %s" % (html_dir))