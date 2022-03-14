from peakrdl.html import HTMLExporter
from systemrdl.node import RootNode
from ...utils.message import info

def export_html(root:RootNode, out_dir:str):
    """
    输出HTML
    """
    exporter = HTMLExporter()
    exporter.export(root, out_dir)