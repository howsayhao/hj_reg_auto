import os
import sys
from math import ceil, log2
from turtle import update

import jinja2 as jj
import utils.message as message
from systemrdl.node import (AddressableNode, AddrmapNode, MemNode, Node,
                            RegfileNode, RegNode, RootNode)


class RTLExporter:

    def __init__(self):
        """
        load jinja environment and basic context
        """
        loader = jj.FileSystemLoader(os.path.join(os.path.dirname(__file__), "templates"))
        self.jj_env = jj.Environment(
            loader=loader,
            undefined=jj.StrictUndefined
        )

        self.context = {
            'bus_addr_width': 64,
            'bus_data_width': 32,
            'RegNode': RegNode,
            'RegfileNode': RegfileNode,
            'AddrmapNode': AddrmapNode,
            'MemNode': MemNode,
            'isinstance': isinstance,
            'log2': log2,
            'get_comp_addr': self._get_comp_addr,
            'use_abs_addr': self._use_abs_addr,
            'dec_addr_bit': self._dec_addr_bit,
            'is_aligned': self._is_aligned,
            'get_forward_num': self._get_forward_num,
            'get_inst_name': self._get_inst_name,
            'get_rtl_name': self._get_rtl_name,
            'use_forward_ff': self._use_forward_ff,
            'use_backward_ff': self._use_backward_ff,
            'valid_bit': self._valid_bit,
            'get_property': self._get_property,
            'get_abs_addr': self._get_abs_addr,
            'get_data_width': self._get_data_width,
            'get_addr_width': self._get_addr_width,
            'has_cdc': self._has_cdc,
            'is_3rd_party_ip': self._is_3rd_party_ip,
            'is_regslv': self._is_regslv,
            'is_mem': self._is_mem
        }

        # filelist for all generated RTL module files: regmst, regdisp, regslv
        self.filelist = []

    def export_all(self, top_node: Node, rtl_dir: str, os_env: str):
        """
        export all files related to RTL modules
        """
        # if it's the root node, skip to the top addrmap
        if isinstance(top_node, RootNode):
            top_node = top_node.top

        self.export_rtl_new(top_node, rtl_dir)

        update_context = {
            'top_name': top_node.inst_name,
            'filelist': self.filelist,
            'os_env': os_env
        }
        self.context.update(update_context)

        template = self.jj_env.get_template("filelist_template.jinja")
        filename = "list_%s.mk" % (top_node.inst_name)

        stream = template.stream(self.context)
        stream.dump(os.path.join(rtl_dir, filename))

        message.info("if you need to convert reg_native_if to or from some AMBA protocol bus "
                     "(support APB now), bridge components are already avaliable and you can "
                     "use them by instantiate apb2reg_native_if/reg_native_if2apb in your design.")

    def export_rtl_new(self, top_node: Node, rtl_dir: str):
        """
        traverse all addrmap, generate modules in pre-order

        - regmst
        - regdisp
        - filelist

        and copy necessary files to dw directory

        Parameter
        ---------
        `top_node` :
        `path` :
        """
        # if it's the top addrmap, generate a regmst module
        if isinstance(top_node, AddrmapNode) and top_node.get_property("hj_genmst"):
            for child in top_node.children(unroll=True, skip_not_present=False):
                if isinstance(child, AddrmapNode) and child.get_property("hj_gendisp"):
                    top_disp_node = child
            update_context = {
                'mst_node': top_node,
                'disp_node': top_disp_node,
            }
            self.context.update(update_context)

            template = self.jj_env.get_template("regmst_template.jinja")
            stream = template.stream(self.context)
            filename = "%s.v" % (self._get_rtl_name(top_node))

            stream.dump(os.path.join(rtl_dir, filename))
            self.filelist.append(filename)

        for child in top_node.children(unroll=True, skip_not_present=False):
            if isinstance(child, AddrmapNode):
                if child.get_property("hj_gendisp"):
                    # generate regdisp rtl module and add it to filelist
                    update_context = {
                        'disp_node': child
                    }
                    self.context.update(update_context)

                    template = self.jj_env.get_template("regdisp_template.jinja")
                    stream = template.stream(self.context)
                    filename = "%s.v" % (self._get_rtl_name(child))

                    stream.dump(os.path.join(rtl_dir, filename))
                    self.filelist.append(filename)

                elif child.get_property("hj_genslv"):
                    # generate regslv rtl module and add it to filelist
                    # regslv rtl generation now uses legacy code
                    filename = "%s.v" % (self._get_rtl_name(child))
                    self.filelist.append(filename)

            self.export_rtl_new(child, rtl_dir)

    def _get_rtl_name(self, node:AddrmapNode):
        return node.get_property("rtl_module_name") if not node.is_array else \
            "%s_%d" % (node.get_property("rtl_module_name"), node.current_idx[0])

    def _get_forward_num(self, node:AddrmapNode):
        # only for regdisp
        if not node.get_property("hj_gendisp") is True:
            message.error("addrmap %s is not recognized as a regdisp module" % (node.get_path()))
            sys.exit(1)

        return node.get_property("forward_num")

    def _get_abs_addr(self, base_node:AddressableNode, offset=0, byte_step=1, suffix="62'h"):
        return  "%s%x" % (suffix, base_node.absolute_address // byte_step + offset)

    def _use_abs_addr(self, node:Node):
        return node.get_property("hj_use_abs_addr")

    def _get_property(self, node:Node, prop_name):
        return node.get_property(prop_name)

    def _is_aligned(self, node:AddressableNode):
        # whether the forwarding module of regdisp is aligned to its absolute address
        return node.absolute_address % (2 ** ceil(log2(node.total_size))) == 0

    def _get_comp_addr(self, node:AddressableNode):
        """
        get compressed address expressions to simplify implementation of decoder
        case statement in RTL code.
        example: 62'h130, 62'h131, ..., 62'h13f -> 62'h13?
        """
        start_addr = node.absolute_address // (self.context["bus_data_width"] // 8)
        end_addr = (node.absolute_address + node.size) // (self.context["bus_data_width"] // 8)

        ptr_addr = start_addr
        comp_addr_expr = []
        prefix = "{}'h".format(self.context["bus_addr_width"] - int(log2(self.context["bus_data_width"] // 8)))

        while ptr_addr < end_addr:
            step = 1

            while ptr_addr % (16 ** step) == 0 and ptr_addr + (16 ** step) <= end_addr:
                step += 1

            temp = ptr_addr + 16 ** step - ptr_addr % (16 ** step) - 1

            while ptr_addr <= temp:
                comp_addr_expr.append("%s%x%s" % (prefix, ptr_addr >> (4 * (step - 1)), "?" * (step - 1)))
                ptr_addr += 16 ** (step - 1)
                if ptr_addr + (16 ** (step - 1)) > end_addr:
                    break

        return comp_addr_expr

    def _dec_addr_bit(self):
        # return list with 2 elements: msb, lsb
        return [
            self.context["bus_addr_width"] - 1,
            int(log2(self.context["bus_data_width"] // 8))
        ]

    def _use_backward_ff(self, node:AddrmapNode):
        return 1 if node.get_property("hj_use_backward_ff") else 0

    def _use_forward_ff(self, node:AddrmapNode):
        forward_ff_param = []

        for child in node.children(unroll=True, skip_not_present=False):
            if child.get_property("hj_use_upstream_ff"):
                forward_ff_param.append("1'b1")
            else:
                forward_ff_param.append("1'b0")

        return forward_ff_param

    def _valid_bit(self, node:AddressableNode):
        return ceil(log2(node.total_size))

    def _get_inst_name(self, node:AddressableNode):
        return node.get_path_segment(array_suffix="_{index:d}")

    def _get_data_width(self, node:AddressableNode):
        if isinstance(node, MemNode):
            return node.get_property("memwidth", default=32)
        elif isinstance(node, AddrmapNode):
            return self.context.get("bus_data_width")

    def _get_addr_width(self, node:AddressableNode):
        if isinstance(node, MemNode):
            return ceil(log2(node.get_property("mementries", default=2)))
        elif isinstance(node, AddrmapNode):
            return self.context.get("bus_addr_width")

    def _has_cdc(self, node:AddressableNode):
        return 1 if node.get_property("hj_cdc", default=False) else 0

    def _is_3rd_party_ip(self, node:AddrmapNode):
        return node.get_property("hj_3rd_party_IP", default=False)

    def _is_regslv(self, node:AddrmapNode):
        return node.get_property("hj_genslv", default=False)

    def _is_mem(self, node:Node):
        return isinstance(node, MemNode)
