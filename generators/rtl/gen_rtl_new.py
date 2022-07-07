import os
from math import ceil, log2

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

        # basic context for all templates
        self.context = {
            'bus_addr_width': 64,
            'bus_data_width': 32,
            'RegNode': RegNode,
            'RegfileNode': RegfileNode,
            'AddrmapNode': AddrmapNode,
            'MemNode': MemNode,
            'isinstance': isinstance,
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
            'get_abs_addr': self._get_abs_addr,
            'get_data_width': self._get_data_width,
            'get_addr_width': self._get_addr_width,
            'has_cdc': self._has_cdc,
            'is_3rd_party_ip': self._is_3rd_party_ip,
            'is_regslv': self._is_regslv,
            'is_mem': self._is_mem
        }

    def export(self, root:RootNode, rtl_dir:str):
        """
        Export inhouse RTL module files: regmst, regdisp and regslv.

        Parameters
        ----------
        root : RootNode
            root node of the design
        rtl_dir : str
            directory to save RTL modules
        """
        # filelist for all inhouse generated RTL files: regmst, regdisp, regslv
        filelist = []

        # top-level (root) addrmap instance name (not the RootNode)
        top_name = root.top.inst_name

        # traverse all addrmap to get complete filelist and generate modules in pre-order
        for node in root.descendants(unroll=True, skip_not_present=False):
            if isinstance(node, AddrmapNode):
                if node.get_property("hj_genmst"):
                    update_context = {
                        'mst_node': node,
                        'disp_node': next(node.children(unroll=True, skip_not_present=False))
                    }

                    template = self.jj_env.get_template("regmst_template.jinja")

                    filename = "{}.v".format(self._get_rtl_name(node))
                    dump_file = os.path.join(rtl_dir, filename)

                    # add regmst to filelist
                    filelist.append(filename)

                elif node.get_property("hj_gendisp"):
                    update_context = {
                        'disp_node': node
                    }

                    template = self.jj_env.get_template("regdisp_template.jinja")

                    filename = "{}.v".format(self._get_rtl_name(node))
                    dump_file = os.path.join(rtl_dir, filename)

                    # add regdisp to filelist
                    filelist.append(filename)

                elif node.get_property("hj_genslv"):
                    update_context = {
                        'slv_node': node
                    }

                    template = None

                    filename = "{}.v".format(self._get_rtl_name(node))
                    dump_file = os.path.join(rtl_dir, filename)

                    # add regslv to filelist
                    filelist.append(filename)
                else:
                    template = None

            # dump generated RTL module files
            # TODO: regslv rtl generation now uses legacy method without Jinja2
            # need to refactor regslv generation code
            if template:
                self.context.update(update_context)

                stream = template.stream(self.context)

                stream.dump(dump_file)

        # after addrmap traversal is done, dump filelist
        template = self.jj_env.get_template("filelist_template.jinja")
        stream = template.stream(
            {
                'top_name': top_name,
                'filelist': filelist
            }
        )

        stream.dump(
            os.path.join(
                rtl_dir,
                "list_{}.mk".format(top_name)
            )
        )

        message.info(
            "if you need to convert reg_native_if to or from some AMBA protocol bus "
            "(support APB now), bridge components are already avaliable and you can "
            "use them by instantiate apb2reg_native_if/reg_native_if2apb in your design."
        )

    def _get_rtl_name(self, node:AddrmapNode):
        return node.get_property("rtl_mod_name") if not node.is_array else \
            "%s_%d" % (node.get_property("rtl_mod_name"), node.current_idx[0])

    def _get_forward_num(self, node:AddrmapNode):
        # only for regdisp
        return node.get_property("forward_num")

    def _get_abs_addr(self, base_node:AddressableNode, offset=0, byte_step=1, suffix="62'h"):
        return  "%s%x" % (suffix, base_node.absolute_address // byte_step + offset)

    def _use_abs_addr(self, node:Node):
        return node.get_property("hj_use_abs_addr")

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
        return node.get_property("hj_3rd_party_ip", default=False)

    def _is_regslv(self, node:AddrmapNode):
        return node.get_property("hj_genslv", default=False)

    def _is_mem(self, node:Node):
        return isinstance(node, MemNode)
