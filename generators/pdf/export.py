import os
import sys
import traceback

import jinja2 as jj
import utils.message as message
from systemrdl.node import (AddressableNode, AddrmapNode, MemNode, Node,
                            RegfileNode, RegNode, RootNode)


class ORGExporter:

    def __init__(self):

        # Top-level node
        self.top_node = None

        loader = jj.FileSystemLoader(os.path.join(os.path.dirname(__file__), "templates"))
        self.jj_env = jj.Environment(
            loader=loader,
            undefined=jj.StrictUndefined
        )

    def export(self, top_node: Node, path: str):
        """
        Parameter
        ---------
        `top_node` :
        `path` :
        """
        # If it is the root node, skip to the top addrmap
        if isinstance(top_node, RootNode):
            top_node = top_node.top
        self.top_node = top_node

        context = {
            'top_node': top_node,
            'RegNode': RegNode,
            'RegfileNode': RegfileNode,
            'AddrmapNode': AddrmapNode,
            'MemNode': MemNode,
            'isinstance': isinstance,
            'get_hier_depth': self._get_hier_depth,
            'get_hier_name': self._get_hier_name,
            'get_abs_addr': self._get_abs_addr,
            'get_offset': self._get_offset,
            'get_end_addr': self._get_end_addr,
            'get_size': self._get_size,
            'get_total_size': self._get_total_size,
            'get_inst_name': self._get_inst_name,
            'get_property': self._get_property
        }

        template = self.jj_env.get_template("org.jinja")
        stream = template.stream(context)
        stream.dump(path)

    def _get_hier_depth(self, node:Node):
        """
        get the hierarchy of a component instance
        which is corresponding to a `Node` object
        """
        if not isinstance(node.parent, RootNode):
            return self._get_hier_depth(node.parent) + 1
        else:
            return 1

    def _get_hier_name(self, node:Node):
        return node.get_path()

    def _get_abs_addr(self, node:AddressableNode):
        return hex(node.absolute_address)

    def _get_offset(self, node:AddressableNode):
        return hex(node.address_offset)

    def _get_end_addr(self, node:AddressableNode):
        return hex(node.absolute_address+node.size-1)

    def _get_size(self, node:AddressableNode):
        return hex(node.size)

    def _get_total_size(self, node:AddressableNode):
        return hex(node.total_size)

    def _get_inst_name(self, node:Node):
        # avoid to call `node.inst_name` property because of array suffix
        return node.get_path_segment()

    def _get_property(self, node:Node, prop_name):
        if prop_name in ("sw", "hw"):
            return node.get_property(prop_name).name
        elif prop_name in ("onread", "onwrite"):
            acc_type = node.get_property(prop_name)
            return "-" if acc_type is None else acc_type.name
        elif prop_name == "reset":
            rst_val = node.get_property("reset")
            return "0x0" if rst_val is None else hex(rst_val)
        else:
            return node.get_property(prop_name, default=None)

class MDExporter:
    pass

class PDFExporter(ORGExporter):

    def __init__(self):
        pass

    def export(self, top_node: Node, path: str):
        """
        Parameter
        ---------
        `top_node` :
        `path` :
        """
        super().export(top_node, path)
        pass


def export_org(root:RootNode, out_dir:str):
    """
    Export UVM RAL model package

    Parameter
    ---------
    `root` : `systemrdl.node.RootNode`, the root node of the compiled register model
    `out_dir` : ouput directory to save the generated org mode file
    """
    exporter = ORGExporter()
    export_file = os.path.join(out_dir, "%s.org" % (root.top.inst_name))

    try:
        exporter.export(root, export_file)
    except:
        message.error("HRDA encounters some unknown errors")
        message.error(traceback.format_exc())
        message.error("org exporter aborted due to previous errors")
        sys.exit(1)
    else:
        message.info("save the org mode documentation in: %s" % (export_file))

def export_pdf(root:RootNode, out_dir:str):
    """
    Export UVM RAL model package

    Parameter
    ---------
    `root` : `systemrdl.node.RootNode`, the root node of the compiled register model
    `out_dir` : ouput directory to save the generated PDF file
    """
    exporter = PDFExporter()
    export_file = os.path.join(out_dir, "%s.org" % (root.top.inst_name))

    try:
        exporter.export(root, export_file)
    except:
        message.error("HRDA encounters some unknown errors")
        message.error(traceback.format_exc())
        message.error("pdf exporter aborted due to previous errors")
        sys.exit(1)
    else:
        message.info("save the pdf documentation in: %s" % (export_file))


