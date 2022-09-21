import os
import traceback
import markdown

import jinja2 as jj
import utils.message as message
from systemrdl.node import (AddressableNode, AddrmapNode, MemNode, Node,
                            RegfileNode, RegNode, RootNode)
from utils.misc import convert_size


class DocExporter:
    def __init__(self):
        # top-level node
        self.top_node = None

        loader = jj.FileSystemLoader(os.path.join(os.path.dirname(__file__), "templates"))
        self.jj_env = jj.Environment(
            loader=loader,
            undefined=jj.StrictUndefined
        )

    def export(self, top_node:AddrmapNode, path:str, template_name:str):
        """
        Parameter
        ---------
        `top_node` :
        `path` :
        """
        assert template_name in ("org", "org_simplified", "md")

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
            'get_property': self._get_property,
            'convert_size': convert_size,
            'get_all_blocks': self._get_all_blocks
        }

        template = self.jj_env.get_template("%s.jinja" % template_name)
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
        return node.get_path(array_suffix="_{index:d}")

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
        return node.get_path_segment(array_suffix="_{index:d}")

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

    def _get_all_blocks(self, node:Node):
        def _get_all_sub_blocks(node:Node):
            for child in node.children(unroll=True, skip_not_present=False):
                if isinstance(child, (AddrmapNode, MemNode)):
                    yield child

                    yield from _get_all_sub_blocks(child)

        yield node
        yield from _get_all_sub_blocks(node)


def export_org(root:RootNode, out_dir:str, simplified=False):
    """
    """
    exporter = DocExporter()
    if simplified:
        name = root.top.inst_name + "_simplified"
        typ = "org_simplified"
    else:
        name = root.top.inst_name + "_detailed"
        typ = "org"

    export_file = os.path.join(out_dir, "%s.org" % name)

    try:
        exporter.export(root, export_file, typ)
    except:
        message.error(
            "HRDA encounters some unknown errors\n{}\n"
            "org exporter aborted due to previous errors".format(
                traceback.format_exc()
            ), raise_err=False
        )
    else:
        message.info("save the org documentation in: %s" % (export_file))

def export_md(root:RootNode, out_dir:str):
    exporter = DocExporter()
    export_file = os.path.join(out_dir, "%s.md" % (root.top.inst_name))

    try:
        exporter.export(root, export_file, "md")
    except:
        message.error(
            "HRDA encounters some unknown errors\n{}\n"
            "markdown exporter aborted due to previous errors".format(
                traceback.format_exc()
            ), raise_err=False
        )
    else:
        message.info("save the markdown documentation in: %s" % (export_file))

def export_pdf(root:RootNode, out_dir:str):
    """
    """
    exporter = DocExporter()
    export_file = os.path.join(out_dir, "%s.pdf" % (root.top.inst_name))

    md_tmp_file = os.path.join(out_dir, "%s.tmp.md" % (root.top.inst_name))
    html_tmp_file = os.path.join(out_dir, "%s.tmp.html" % (root.top.inst_name))

    try:
        exporter.export(root, md_tmp_file, "md")

        with open(md_tmp_file, "r") as f:
            text = f.read()
            html = markdown.markdown(text, extensions=["tables", "nl2br"])

        with open(html_tmp_file, "w") as f:
            f.write(html)
    except:
        message.error(
            "HRDA encounters some unknown errors\n{}\n"
            "pdf exporter aborted due to previous errors".format(
                traceback.format_exc()
            ), raise_err=False
        )
    else:
        # TODO
        message.warning(
            "PDF exporter is not implemented completely because of some dependencies, "
            "and now it is able to export temporary markdown and html files only, "
            "you can use the markdown and org exporter instead"
        )