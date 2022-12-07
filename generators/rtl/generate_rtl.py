from __future__ import annotations

import os
import fnmatch
from math import ceil, log2

import jinja2 as jj
import utils.message as message
from systemrdl.node import (AddressableNode, AddrmapNode, MemNode, Node,
                            RegfileNode, RegNode, FieldNode, RootNode)
from systemrdl.rdltypes import AccessType, OnReadType, OnWriteType, PrecedenceType


class RTLExporter:
    """
    """
    def __init__(self):
        """
        load jinja environment and basic context
        """
        loader = jj.FileSystemLoader(os.path.join(os.path.dirname(__file__), "templates"))
        self.jj_env = jj.Environment(
            loader=loader,
            undefined=jj.StrictUndefined
        )

        self.top_node = None

        # basic context for all templates
        self.context = {
            'bus_addr_width': 48,
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
            'get_addr_loc_num': self._get_addr_loc_num,
            'get_all_regs': self._get_all_regs,
            'get_add_list': self._get_addr_list,
            'need_snapshot': self._need_snapshot,
            'get_property': self._get_property,
            'skip_reg_mux_dff_0': self._skip_reg_mux_dff_0,
            'skip_reg_mux_dff_1': self._skip_reg_mux_dff_1,
            'reg_mux_size': self._reg_mux_size,
            'use_forward_ff': self._use_forward_ff,
            'use_backward_ff': self._use_backward_ff,
            'valid_bit': self._valid_bit,
            'get_abs_addr': self._get_abs_addr,
            'get_data_width': self._get_data_width,
            'get_addr_width': self._get_addr_width,
            'has_cdc': self._has_cdc,
            'is_3rd_party_ip': self._is_3rd_party_ip,
            'is_regslv': self._is_regslv,
            'is_mem': self._is_mem,
            'is_regdisp': self._is_regdisp,
            'len': len,
            'format_sw_type': self._format_sw_type,
            'format_onread_type': self._format_onread_type,
            'format_onwrite_type': self._format_onwrite_type,
            'format_hw_type': self._format_hw_type,
            'format_precedence_type': self._format_precedence_type,
            'get_alias_num': self._get_alias_num,
            'get_sync_rst': self._get_sync_rst,
            'get_reset_val': self._get_reset_val,
            'is_singlepulse': self._is_singlepulse,
            'has_swmod': self._has_swmod,
            'has_swacc': self._has_swacc,
            'is_hard_wired': self._is_hard_wired,
            'is_intr': self._is_intr,
            'get_ref_prop': self._get_ref_prop,
            'get_field_num': self._get_field_num,
            'need_param_reset': self._need_param_reset
        }

    def export(self, top_node:AddrmapNode, rtl_dir:str, **kwargs):
        """
        Export in-house RTL module files: regmst, regdisp and regslv.

        Parameters
        ----------
        top_node : AddrmapNode
            Top node of the generation boundry.
        rtl_dir : str
            Directory to save the generated RTL files.
        kwargs : dict
            Additional arguments to be passed to the template.
            - without_filelist : bool
            - gen_hier_depth_range : list
        """
        without_filelist = kwargs.pop("without_filelist", False)
        gen_hier_depth_range = kwargs.pop("gen_hier_depth_range", None)
        exclude_pattern = kwargs.pop("filter", None)

        # filelist for all in-house generated RTL files: regmst, regdisp, regslv
        filelist = []

        # specified top-level addrmap instance name
        top_name = top_node.inst_name

        self.top_node = top_node

        # traverse all addrmap to get complete filelist and generate modules in pre-order (top-down)
        for node in top_node.descendants(unroll=True, skip_not_present=False):
            if isinstance(node, AddrmapNode):
                if node.is_array and node.get_property("hj_use_abs_addr"):
                    need_array_suffix = True
                else:
                    need_array_suffix = False

                # if current regmst/regdisp/regslv instance is in array,
                # and it is not the first instance in the array,
                # and it uses address offset,
                # then there is no need to generate duplicate RTL module for it
                if node.is_array and node.current_idx[0] != 0 and \
                    not node.get_property("hj_use_abs_addr"):
                    continue

                # filter out/exclude the addrmap instances that are constrained
                # by --filter option
                if exclude_pattern:
                    if fnmatch.fnmatchcase(node.inst_name, exclude_pattern):
                        continue

                # if hierarchy depth range is specified,
                # then skip generation of nodes which are not in the range
                if gen_hier_depth_range:
                    if gen_hier_depth_range[0] <= self._get_hier_depth(node) <= gen_hier_depth_range[1]:
                        continue

                # if some addrmap is assigned dont_gen_rtl property to true,
                # then skip generation of the addrmap
                if node.get_property("dont_gen_rtl", default=False):
                    continue

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
                    if need_array_suffix:
                        disp_name = "{:s}{:d}".format(node.get_property("rtl_name"), node.current_idx[0])
                    else:
                        disp_name = node.get_property("rtl_name")

                    update_context = {
                        'disp_node': node,
                        'disp_name': disp_name
                    }

                    template = self.jj_env.get_template("regdisp_template.jinja")

                    filename = "{}.v".format(disp_name)
                    dump_file = os.path.join(rtl_dir, filename)

                    # add regdisp to filelist
                    filelist.append(filename)

                elif node.get_property("hj_genslv"):
                    if need_array_suffix:
                        slv_name = "{:s}{:d}".format(node.get_property("rtl_name"), node.current_idx[0])
                    else:
                        slv_name = node.get_property("rtl_name")

                    update_context = {
                        'slv_node': node,
                        'slv_name': slv_name
                    }

                    if node.get_property("is_ras_arch"):
                        template = self.jj_env.get_template("ras_template.jinja")
                    else:
                        template = self.jj_env.get_template("regslv_template.jinja")

                    filename = "{}.v".format(slv_name)
                    dump_file = os.path.join(rtl_dir, filename)

                    # add regslv to filelist
                    filelist.append(filename)
                else:
                    template = None

                if template:
                    self.context.update(update_context)
                    stream = template.stream(self.context)

                    stream.dump(dump_file)

        # after addrmap traversal is done, dump filelist
        if not without_filelist:
            template = self.jj_env.get_template("filelist_template.jinja")
            stream = template.stream(
                {
                    'top_name': top_name,
                    'filelist': filelist
                }
            )

            stream.dump(os.path.join(rtl_dir,"list_{}.mk".format(top_name)))

        message.info(
            "if you need to convert reg_native_if to or from some AMBA protocol bus "
            "(support APB now), bridge components are already available and you can "
            "use them by instantiate apb2reg_native_if/reg_native_if2apb in your design."
        )

    def _get_rtl_name(self, node:Node):
        if isinstance(node, (MemNode, AddrmapNode)):
            if node.is_array:
                return "%s_%d" % (node.get_property("rtl_name"), node.current_idx[0])
            else:
                return node.get_property("rtl_name")
        elif isinstance(node, RegNode):
            reg_name = [
                node.get_path_segment(array_suffix="_{index:d}")
            ]

            while not (isinstance(node.parent, AddrmapNode) and \
                node.parent.get_property("hj_genslv")):
                node = node.parent

                if isinstance(node, RootNode):
                    return reg_name[-1]
                else:
                    reg_name.insert(0, node.get_path_segment(array_suffix="_{index:d}"))

            return "_".join(reg_name)
        else:
            message.error("unsupported node type: %s" % node.__class__.__name__)

    def _get_forward_num(self, node:AddrmapNode):
        # only for regdisp
        return node.get_property("forward_num")

    def _get_abs_addr(self, base_node:AddressableNode, offset=0, byte_step=1, suffix="62'h"):
        return  "%s%x" % (suffix, base_node.absolute_address // byte_step + offset)

    def _use_abs_addr(self, node:Node):
        return node.get_property("hj_use_abs_addr")

    def _is_aligned(self, node:AddressableNode):
        """
        whether the forwarding module of regdisp is aligned to its address
        """
        if node.parent.get_property("hj_use_abs_addr", default=False):
            conv_addr = node.absolute_address
        else:
            conv_addr = node.address_offset

        return conv_addr % (2 ** ceil(log2(node.size))) == 0

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
        return int(node.get_property("hj_use_backward_ff") or 0)

    def _use_forward_ff(self, node:AddrmapNode):
        forward_ff_param = []

        for child in node.children(unroll=True, skip_not_present=False):
            if child.get_property("hj_use_upstream_ff"):
                forward_ff_param.append("1'b1")
            else:
                forward_ff_param.append("1'b0")

        forward_ff_param.reverse()

        return forward_ff_param

    def _valid_bit(self, node:AddressableNode):
        return ceil(log2(node.size))

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
        return int(node.get_property("hj_cdc", default=False))

    def _is_3rd_party_ip(self, node:AddrmapNode|MemNode):
        return node.get_property("hj_3rd_party_ip", default=False)

    def _is_regslv(self, node:AddrmapNode|MemNode):
        return node.get_property("hj_genslv", default=False)

    def _is_regdisp(self, node:AddrmapNode|MemNode):
        return node.get_property("hj_gendisp", default=False)

    def _is_mem(self, node:Node):
        return isinstance(node, MemNode)

    def _get_all_regs(self, node:AddrmapNode):
        reg_list = []

        for child in node.children(unroll=True, skip_not_present=False):
            if isinstance(child, RegNode):
                reg_list.append(child)
            else:
                reg_list.extend(self._get_all_regs(child))

        return reg_list

    def _get_addr_loc_num(self, node:AddrmapNode):
        # only for regslv
        assert node.get_property("hj_genslv")

        return node.get_property("int_reg_addr_loc_num")

    def _get_addr_list(self, node:AddrmapNode):
        # only for regslv
        assert node.get_property("hj_genslv")

        return node.get_property("addr_list")

    def _skip_reg_mux_dff_0(self, node:AddrmapNode):
        return int(node.get_property("hj_skip_reg_mux_dff_0", default=True))

    def _skip_reg_mux_dff_1(self, node:AddrmapNode):
        return int(node.get_property("hj_skip_reg_mux_dff_1", default=True))

    def _reg_mux_size(self, node:AddrmapNode):
        return node.get_property("hj_reg_mux_size", default=128)

    def _get_property(self, node:Node, prop:str):
        return node.get_property(prop, default=None)

    def _need_snapshot(self, node:Node):
        return node.get_property("need_snapshot", default=False)

    def _get_alias_num(self, node:RegNode|FieldNode):
        return len(list(node.aliases(skip_not_present=False)))+1 if node.has_aliases else 1

    def _format_sw_type(self, node:FieldNode):
        sw_type_expr = []

        sw_type_dict = {
            AccessType.rw: "`SW_RW",
            AccessType.r: "`SW_RO",
            AccessType.w: "`SW_WO",
            AccessType.w1: "`SW_W1",
            AccessType.rw1: "`SW_RW1"
        }

        sw_type_expr.append(
            sw_type_dict[node.get_property("sw", default=AccessType.rw)]
        )

        if node.has_aliases:
            for alias_field in node.aliases(skip_not_present=False):
                sw_type_expr.append(
                    sw_type_dict[alias_field.get_property("sw", default=AccessType.rw)]
                )

        return ", ".join(sw_type_expr)

    def _format_onread_type(self, node:FieldNode):
        onread_type_expr = []

        onread_type_dict = {
            OnReadType.rclr: "`RCLR",
            OnReadType.rset: "`RSET",
            OnReadType.ruser: "`NA",
            "NA": "`NA"
        }

        onread_type_expr.append(
            onread_type_dict[node.get_property("onread", default="NA")]
        )

        if node.has_aliases:
            for alias_field in node.aliases(skip_not_present=False):
                onread_type_expr.append(
                    onread_type_dict[alias_field.get_property("onread", default="NA")]
                )

        return ", ".join(onread_type_expr)

    def _format_onwrite_type(self, node:FieldNode):
        onwrite_type_expr = []

        onwrite_type_dict = {
            OnWriteType.woclr: "`WOCLR",
            OnWriteType.woset: "`WOSET",
            OnWriteType.wot: "`WOT",
            OnWriteType.wzs: "`WZS",
            OnWriteType.wzc: "`WZC",
            OnWriteType.wzt: "`WZT",
            OnWriteType.wuser: "`NA",
            "NA": "`NA"
        }

        onwrite_type_expr.append(
            onwrite_type_dict[node.get_property("onwrite", default="NA")]
        )

        if node.has_aliases:
            for alias_field in node.aliases(skip_not_present=False):
                onwrite_type_expr.append(
                    onwrite_type_dict[alias_field.get_property("onwrite", default="NA")]
                )

        return ", ".join(onwrite_type_expr)

    def _format_hw_type(self, node:FieldNode):
        hw_prop = node.get_property("hw", default=AccessType.rw)

        if node.get_property("hwclr"):
            return "`HW_CLR"
        elif node.get_property("hwset"):
            return "`HW_SET"

        if hw_prop == AccessType.rw:
            return "`HW_RW"
        elif hw_prop == AccessType.w:
            return "`HW_WO"
        elif hw_prop == AccessType.r:
            return "`HW_RO"
        elif hw_prop == AccessType.na:
            return "`HW_NA"

    def _format_precedence_type(self, node:FieldNode):
        if node.get_property("precedence", default=PrecedenceType.sw) == PrecedenceType.sw:
            return "`SW"
        else:
            return "`HW"

    def _get_sync_rst(self, node:FieldNode) -> list["str"]:
        if node.get_property("hj_syncresetsignal"):
            return node.get_property("hj_syncresetsignal").split(",")
        else:
            return []

    def _get_reset_val(self, node:FieldNode) -> int:
        return node.get_property("reset", default=0)

    def _is_singlepulse(self, node:FieldNode):
        return int(node.get_property("singlepulse", default=False))

    def _has_swmod(self, node:FieldNode):
        return int(node.get_property("swmod", default=False))

    def _has_swacc(self, node:FieldNode):
        return int(node.get_property("swacc", default=False))

    def _is_hard_wired(self, node:FieldNode):
        return int(node.get_property("hard_wired", default=False))

    def _is_intr(self, node:FieldNode|RegNode):
        return node.get_property("intr", default=False)

    def _get_ref_prop(self, node:FieldNode, ref_prop:str) -> FieldNode:
        assert node.get_property("intr")
        return node.get_property(ref_prop)

    def _get_field_num(self, node:RegNode):
        return len(list(node.fields(skip_not_present=False)))

    def _get_hier_depth(self, node:Node):
        """
        get the hierarchy of a component instance
        which is corresponding to a `Node` object
        """
        if not isinstance(node.parent, RootNode):
            return self._get_hier_depth(node.parent) + 1
        else:
            return 1

    def _need_param_reset(self, node:FieldNode):
        return node.get_property("parameterized_reset", default=False)