from __future__ import annotations

import os
import traceback
import markdown
import subprocess
import multiprocessing

import jinja2 as jj
import utils.message as message
from systemrdl.node import (AddressableNode, AddrmapNode, MemNode, Node,
                            RegfileNode, RegNode)
from utils.misc import convert_size


class DocExporter:
    def __init__(self, top_node:AddrmapNode):
        # top-level node
        self.top_node = top_node

        loader = jj.FileSystemLoader(
            os.path.join(os.path.dirname(__file__), "templates"))

        self.jj_env = jj.Environment(
            loader=loader,
            undefined=jj.StrictUndefined)

        self.context = {
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
            'get_base_node': self._get_base_node
        }

    def export(self, out_dir:str,
               format_list:list[str],
               with_toc:bool,
               pdf_engine:str,
               split_by_sub_sys:bool,
               max_reg_count:int,
               only_simplified_org:bool,
               with_simplified_org:bool,
               max_proc_count:int):
        """
        Parameter
        ---------
        """
        cpu_count = multiprocessing.cpu_count()

        if cpu_count < max_proc_count:
            max_proc_count = cpu_count

        proc_pool = multiprocessing.Pool(processes=max_proc_count)

        # create output directory
        out_dir = os.path.join(out_dir, "docs")
        if not os.path.exists(out_dir):
            os.makedirs(out_dir)


        # generate doc for each sub-system if split_by_sub_sys is set
        top_nodes = []
        if split_by_sub_sys:
            for node in self.top_node.descendants(unroll=True, skip_not_present=False):
                # split nodes by sub-system since every sub-system has its own root node
                # specified by set_as_subsys_root property
                # note that the top node is not included in the list
                if isinstance(node, AddrmapNode) and \
                    node.get_property("set_as_subsys_root", default=False):
                    top_nodes.append(node)
        else:
            top_nodes.append(self.top_node)

        # update context with additional parameters
        self.context.update({
            'with_toc': with_toc
        })

        # org, markdown and txt doc are going to be generated from jinja2 templates
        template_dict = {}
        for format in format_list:
            if format == "org":
                if only_simplified_org:
                    template_dict["org_simplified"] = format
                    continue

                if with_simplified_org:
                    template_dict["org_simplified"] = format

                template_dict["org_detailed"] = format

            elif format == "txt":
                template_dict["plain_text"] = format

            # html and pdf doc are based on markdown doc rendered by jinja2 template
            elif format in ("md", "html", "pdf"):
                template_dict["md"] = format

        if "org" in format_list:
            if only_simplified_org:
                template_dict["org_simplified"] = "org"
            else:
                if with_simplified_org:
                    template_dict["org_simplified"] = "org"

                template_dict["org_detailed"] = "org"

        if "txt" in format_list:
            template_dict["plain_text"] = "txt"

        # html and pdf doc are based on markdown doc rendered by jinja2 template
        if "md" in format_list or "html" in format_list or "pdf" in format_list:
            template_dict["md"] = "md"

        tmp_files = []
        all_files = []

        for top_node in top_nodes:
            top_inst_name = top_node.get_path_segment(array_suffix="_{index:d}")

            for template_name, format in template_dict.items():

                if template_name == "org_simplified":
                    file_prefix = top_inst_name + "_simplified"
                elif template_name == "org_detailed":
                    file_prefix = top_inst_name + "_detailed"
                else:
                    file_prefix = top_inst_name

                nodes, files = [], []
                reg_num, file_num = 0, 0
                last_reg_addr = 0

                # use corresponding format of jinja2 templates to dump
                jj_template = self.jj_env.get_template("%s.jinja" % template_name)

                for node in top_node.descendants(unroll=True, skip_not_present=False):
                    if isinstance(node, (RegNode, RegfileNode, MemNode, AddrmapNode)):
                        if len(nodes) == 0:
                            # insert current top node into context to be generated for
                            # the first file, or nodes are continued from the last
                            # node of last file, try to capture the entire hierarchy
                            # of the current first node
                            curr_node = node

                            while not curr_node.parent == top_node:
                                nodes.insert(0, curr_node.parent)
                                curr_node = curr_node.parent

                            nodes.insert(0, top_node)

                        nodes.append(node)

                        if isinstance(node, RegNode):
                            reg_num += 1

                        # split all registers into multiple groups to dump
                        # max_reg_count = 0 means no split
                        if max_reg_count != 0 and reg_num >= max_reg_count:
                            self.context.update({
                                "nodes": nodes
                            })

                            if file_num > 0:
                                file_suffix = "_cond_%d_%s_%s" % (
                                    file_num,
                                    hex(last_reg_addr),
                                    hex(nodes[-1].absolute_address))
                            else:
                                file_suffix = ""
                            last_reg_addr = nodes[-1].absolute_address + nodes[-1].size

                            export_file = os.path.join(
                                out_dir,
                                "%s%s.%s" % (file_prefix, file_suffix, format))

                            jj_template.stream(self.context).dump(export_file)

                            # add to file list
                            files.append(export_file)

                            nodes = []
                            reg_num = 0
                            file_num += 1

                # dump the last group of registers, if any
                # or the total number of registers is less than max_reg_count
                self.context.update({
                    "nodes": nodes
                })

                if file_num > 0:
                    file_suffix = "_cond_%d_%s_%s" % (
                        file_num,
                        hex(last_reg_addr),
                        hex(nodes[-1].absolute_address)
                    )
                else:
                    file_suffix = ""

                export_file = os.path.join(
                    out_dir,
                    "%s%s.%s" % (file_prefix, file_suffix, format))
                jj_template.stream(self.context).dump(export_file)

                # add to file list
                files.append(export_file)

                message.info(
                    "save %s documentation of %s (total %d files)" % (
                        template_name, top_inst_name, len(files)))

            # filenames without file type extension
            common_files = [os.path.splitext(f)[0] for f in files]
            all_files.extend(common_files)

            # markdown extensions used
            md_exts = ["tables", "nl2br", "toc"]

            # use markdown util to generate html from markdown
            if "html" in format_list:
                if not "md" in format_list:
                    # temporary markdown files are going to be removed later
                    tmp_files.extend([f + ".md" for f in common_files])

                # since conversion from markdown to html is a time-consuming task,
                # we use multiprocessing to speed up the process
                for file in common_files:
                    proc_pool.apply_async(
                        markdown.markdownFromFile,
                        kwds={
                            'input': file + ".md",
                            'output': file + ".html",
                            'extensions': md_exts
                        },
                        error_callback=self.export_error_handler
                    )

                message.info(
                    "save html documentation of %s (total %d files)" %
                    (top_inst_name, len(common_files))
                )

            # use optional pdf engines to convert html to pdf
            # actually the conversion is not implemented here but later
            # when all html files are prepared to boost the performance
            # of the conversion process by multiprocessing
            if "pdf" in format_list:
                # when html files do not exist, generate it first
                if not "html" in format_list:
                    # when markdown files do not exist, generate it first
                    if not "md" in format_list:
                        # temporary markdown files are going to be removed later
                        tmp_files.extend([f + ".md" for f in common_files])

                    for file in common_files:
                        proc_pool.apply_async(
                            markdown.markdownFromFile,
                            kwds={
                                'input': file + ".md",
                                'output': file + ".html",
                                'extensions': md_exts
                            },
                            error_callback=self.export_error_handler
                        )

                    # temporary html files are going to be removed later
                    tmp_files.extend([f + ".html" for f in common_files])

        # wait for all tasks to finish: markdown and html generation
        proc_pool.close()
        proc_pool.join()

        # convert html to pdf by specified engine
        if "pdf" in format_list:
            message.info(
                "generate pdf using {}, it may take long long long time "
                "if there are a large number of registers, so keep patient please".format(pdf_engine))

            cmds = {
                'wkhtmltopdf': [
                    'wkhtmltopdf',
                    '{html}',
                    '{pdf}'
                ],
                'google-chrome': [
                    'google-chrome',
                    '--headless',   # no UI
                    '--disable-gpu',
                    '--print-to-pdf-no-header',
                    '--print-to-pdf={pdf}',
                    '{html}'
                ]
            }

            proc_pool = multiprocessing.Pool(processes=max_proc_count)

            for file in all_files:
                cmd = [
                    c.format(html = file+".html", pdf = file+".pdf") for c in cmds[pdf_engine]
                ]

                proc_pool.apply_async(
                    subprocess.call, args=(cmd,),
                    kwds={'stdout': subprocess.DEVNULL, 'stderr': subprocess.DEVNULL},
                    error_callback=self.export_error_handler,
                    callback=self.export_info_handler)

            proc_pool.close()
            proc_pool.join()

        # delete all temporary files
        for file in tmp_files:
            os.remove(file)

    def export_info_handler(self, result):
        message.info("pdf generation finished")

    def export_error_handler(self, e:BaseException):
        # TODO: add error handling
        message.error(
            "doc exporter encounters some error: %s" % e,
            raise_err=False)

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