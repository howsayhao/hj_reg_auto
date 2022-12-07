from __future__ import annotations

import os
import traceback
import markdown
import subprocess

import jinja2 as jj
import utils.message as message
from systemrdl.node import (AddressableNode, AddrmapNode, MemNode, Node,
                            RegfileNode, RegNode)
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

    def export(self, top_node:AddrmapNode, export_file:str,
               template_name:str, with_toc:bool=False):
        """
        Parameter
        ---------
        top_node : AddrmapNode
            top-level address map node
        export_file : str
            output file path
        template_name : str
            jinja2 template name used to generate the output file
        with_toc : bool
            whether to generate a table of contents
        """
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
            'get_all_blocks': self._get_all_blocks,
            'get_secure_attr': self._get_secure_attr,
            'get_base_node': self._get_base_node,
            'with_toc': with_toc
        }

        template = self.jj_env.get_template("%s.jinja" % template_name)
        template.stream(context).dump(export_file)

    def _get_hier_depth(self, node:Node):
        """
        Get the hierarchy depth of the node
        """
        if node == self.top_node:
            return 1
        else:
            return self._get_hier_depth(node.parent) + 1

    def _get_hier_name(self, node:Node):
        return node.get_path(array_suffix="_{index:d}")

    def _get_abs_addr(self, node:AddressableNode):
        return hex(node.absolute_address)

    def _get_base_node(self, node:Node):
        if node == self.top_node or \
            node.get_property("set_as_subsys_root", default=False):
            return node
        else:
            return self._get_base_node(node.parent)

    def _get_offset(self, node:AddressableNode, ref_node:AddressableNode):
        return hex(node.absolute_address - ref_node.absolute_address)

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
        elif prop_name == "hwsc":
            if node.get_property("hwclr"):
                return "hwclr"
            elif node.get_property("hwset"):
                return "hwset"
            else:
                return "-"
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

    def _get_secure_attr(self, node:AddrmapNode|MemNode):
        secure_attr = node.get_property("secure_attr", default=None)
        if secure_attr is None:
            return "-"
        elif secure_attr == 0:
            return "secure"
        elif secure_attr == 1:
            return "non-secure"
        elif secure_attr == 2:
            ref_str = node.get_property("secure_config_ref", default=None)

            if ref_str:
                ref_node = node.find_by_path(ref_str)
                if ref_node:
                    sec_cfg_default_val = ref_node.get_property("reset")
                else:
                    sec_cfg_default_val = 0
            else:
                sec_cfg_default_val = 0

            return "configured by register (default %s)" % (
                "secure" if sec_cfg_default_val == 0 else "non-secure"
            )

def export_doc(top_node:AddrmapNode, out_dir:str, format_list:list[str], **kwargs):
    """
    Export documentation with optional file formats

    Parameters
    ----------
    `top_node` : AddrmapNode
        top-level address map node
    `out_dir` : str
        Output directory
    `format_list` : list[str]
        List of file formats to export
    `kwargs` :
        Additional arguments for each file format
    """
    exporter = DocExporter()
    error_occur = False

    template_dict = {}

    with_toc = kwargs.pop("with_toc")
    exclude_pattern = kwargs.pop("filter")

    # org, markdown and txt doc are going to be generated by jinja2 engine
    for format in format_list:
        if format == "org":
            if kwargs.pop("only_simplified_org"):
                template_dict["org_simplified"] = format
                continue

            if kwargs.pop("with_simplified_org"):
                template_dict["org"] = format

            template_dict["org_detailed"] = format

        elif format == "md":
            template_dict["md"] = format

        elif format == "txt":
            template_dict["plain_text"] = format

    out_dir = os.path.join(out_dir, "docs")

    if not os.path.exists(out_dir):
        os.makedirs(out_dir)

    md_already_exported = False
    html_already_generated = False

    # indicate whether there are temporal files
    md_tmp_exported = False
    html_tmp_exported = False

    for template_name, format in template_dict.items():
        export_file = os.path.join(out_dir, "%s.%s" % (top_node.inst_name, format))

        try:
            exporter.export(top_node, export_file, template_name, with_toc)
        except:
            message.error(
                "failed to export %s documentation" % format,
                raise_err=False
            )
            error_occur = True
        else:
            if format == "md":
                md_already_exported = True
                md_file = export_file

            message.info("save %s documentation in %s" % (format, export_file))

    html_file = os.path.join(out_dir, "%s.html" % top_node.inst_name)

    # markdown extensions used
    md_exts = ["tables", "nl2br"]
    if with_toc:
        md_exts.append("toc")

    # for html, we use markdown library to generate html from markdown
    if "html" in format_list:
        try:
            # when markdown file is not generated, we generate it first
            if not md_already_exported:
                md_file = os.path.join(out_dir, "%s.md" % top_node.inst_name)
                exporter.export(top_node, md_file, "md", with_toc)

            markdown.markdownFromFile(
                input=md_file,
                output=html_file,
                extensions=md_exts
            )
        except:
            message.error(
                "failed to export html documentation",
                raise_err=False
            )
            error_occur = True
        else:
            if not md_already_exported:
                md_tmp_exported = True

            html_already_generated = True

            message.info("save html documentation in %s" % html_file)

    # for pdf, we use google-chrome to convert html to pdf
    if "pdf" in format_list:
        pdf_file = os.path.join(out_dir, "%s.pdf" % top_node.inst_name)

        # when html file is not generated, we generate it first
        if not html_already_generated:
            try:
                # when markdown file is not generated, we generate it first
                if not md_already_exported:
                    md_file = os.path.join(out_dir, "%s.md" % top_node.inst_name)
                    exporter.export(top_node, md_file, "md", with_toc)

                markdown.markdownFromFile(
                    input=md_file,
                    output=html_file,
                    extensions=md_exts
                )
            except:
                message.error(
                    "failed to export intermediate html file",
                    raise_err=False
                )
                error_occur = True
            else:
                if not md_already_exported:
                    md_already_exported = True

                html_tmp_exported = True
        else:
            # convert html to pdf by Google Chrome
            message.info("generate PDF file by Google Chrome, it may take a while")

            try:
                subprocess.call(
                    [
                        'google-chrome',
                        '--headless',
                        '--disable-gpu',
                        '--print-to-pdf-no-header',
                        '--print-to-pdf={}'.format(export_file), html_file
                    ])
            except:
                message.error(
                    "failed to generate PDF by Google Chrome",
                    raise_err=False
                )
            else:
                message.info("save pdf documentation in %s" % pdf_file)

    # delete intermediate files after all generation work is done
    if md_tmp_exported:
        os.remove(md_file)

    if html_tmp_exported:
        os.remove(html_file)

    # raise error ultimately to trace back
    # TODO: provide more accurate trace information
    if error_occur:
        message.error(
            "HRDA encounters some unknown errors,\n{}\n"
            "doc exporter does not finish all work and exits incorrectly".format(
                traceback.format_exc()
            )
        )