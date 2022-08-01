import os
import traceback

import utils.message as message
from peakrdl.html import HTMLExporter
from systemrdl.node import RootNode


def export_html(root:RootNode, out_dir:str):
    """
    Export documentations in HTML format

    Parameter
    ---------
    `root` : `systemrdl.node.RootNode` systemrdl-compiler解析完成的寄存器模型根节点
    `out_dir` : 输出HTML的目录, 会在该目录下创建一个`html`子目录, 存放输出的HTML
    """
    exporter = HTMLExporter()

    # html output directory
    html_dir = os.path.join(out_dir, "html")

    if not os.path.exists(html_dir):
        os.makedirs(html_dir)

    try:
        exporter.export(root, html_dir)
    except:
        message.error(
            "HRDA encounters some unknown errors\n{}\n"
            "HTML export failed due to previous errors".format(
                traceback.format_exc()
            ), raise_err=False
        )
    else:
        message.info("save HTML in directory: %s" % (html_dir))