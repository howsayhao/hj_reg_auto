from peakrdl.html import HTMLExporter
from systemrdl.node import RootNode

def export_html(root:RootNode, out_dir:str):
    """
    输出HTML
    """
    exporter = HTMLExporter()
    exporter.export(root, out_dir)