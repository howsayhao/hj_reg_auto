import os
import traceback

import jinja2 as jj
import utils.message as message
from systemrdl.node import (AddressableNode, AddrmapNode, MemNode, Node,
                            RegfileNode, RegNode, FieldNode)
from systemrdl.rdltypes import AccessType, OnReadType, OnWriteType

class CHdrExporter:
    """
    Export C header files
    """
    def __init__(self):
        """
        load jinja environment and basic context
        """
        loader = jj.FileSystemLoader(os.path.join(os.path.dirname(__file__), "templates"))
        self.jj_env = jj.Environment(
            loader=loader,
            undefined=jj.StrictUndefined)

        self.context = {
            'addr_width': 64,
            'data_width': 32,
            'RegNode': RegNode,
            'RegfileNode': RegfileNode,
            'AddrmapNode': AddrmapNode,
            'MemNode': MemNode,
            'isinstance': isinstance,
            'get_inst_name': self._get_inst_name,
            'get_reset_val': self._get_reset_val,
            'get_base_addr': self._get_base_addr,
            'get_addr_offset': self._get_addr_offset,
            'get_all_fields' : self._get_all_fields,
            'get_hier_name': self._get_hier_name,
            'get_acc_bit_vec': self._get_acc_bit_vec
        }

    def export(self, top_node: AddrmapNode, out_dir: str, include_top: bool = True):
        """
        traverse all addrmap and generate all c header files in pre-order

        Parameter
        ---------
        """
        nodes = []
        if include_top:
            nodes.append(top_node)

        nodes.extend(top_node.children(unroll=True, skip_not_present=False))

        for node in nodes:
            if isinstance(node, AddrmapNode):
                # generate independent c header files
                if node.get_property("hj_genslv") or \
                    node.get_property("hj_3rd_party_ip") or \
                    node.get_property("set_as_subsys_root", default=False):
                    update_context = {
                        'node': node
                    }
                    self.context.update(update_context)

                    # dump header
                    template = self.jj_env.get_template("h.jinja")

                    stream = template.stream(self.context)
                    stream.dump(os.path.join(
                        out_dir,
                        "%s.h" % (
                            node.get_path_segment(array_suffix="_{index:d}")
                        )))

                    # dump c test
                    template = self.jj_env.get_template("testc.jinja")

                    stream = template.stream(self.context)
                    stream.dump(os.path.join(
                        out_dir,
                        "%s_test.c" % (
                            node.get_path_segment(array_suffix="_{index:d}")
                        )
                    ))

                    # dump c test header
                    template = self.jj_env.get_template("testh.jinja")

                    stream = template.stream(self.context)
                    stream.dump(os.path.join(
                        out_dir,
                        "%s_test.h" % (
                            node.get_path_segment(array_suffix="_{index:d}")
                        )
                    ))

                self.export(node, out_dir, include_top=False)

    def _get_reset_val(self, node:RegNode):
        """
        concatenate all fields' reset value to get the reset value of a register
        """
        sum = 0

        for field in node.fields(skip_not_present=False):
            sum += field.get_property("reset", default=0) << field.low

        return "{0:#0{1}X}".format(sum, 2 + node.size * 2)

    def _get_base_addr(self, node:AddressableNode, step:int = 1):
        return hex(node.absolute_address // step)

    def _get_addr_offset(self, node:AddressableNode):
        return hex(
            node.absolute_address - self.context.get('node').absolute_address
        )

    def _get_inst_name(self, node:Node):
        return node.get_path_segment(array_suffix="_{index:d}")

    def _get_hier_name(self, node:Node):
        return node.get_rel_path(
            self.context.get('node').parent,
            hier_separator="_",
            array_suffix="_{index:d}")

    def _get_all_fields(self, node:RegNode):
        """
        get all fields including reserved.
        """
        orig_flds = list(node.fields(skip_not_present=False))
        orig_flds.sort(key=lambda x: x.low)

        all_flds = []
        rsvd_cnt = 0

        for index in range(len(orig_flds)):
            all_flds.append(
                (
                    orig_flds[index].inst_name,
                    orig_flds[index].width,
                    orig_flds[index].get_property("reset", default=0)
                )
            )

            if index == 0:
                if orig_flds[index].low > 0:
                    rsvd_width = orig_flds[index].low
                    all_flds.append(("reserved_{}".format(rsvd_cnt), rsvd_width, 0))
                    rsvd_cnt += 1
            elif index == len(orig_flds) - 1:
                if orig_flds[index].high < node.size * 8 - 1:
                    rsvd_width = node.size * 8 - 1 - orig_flds[index].high
                    all_flds.append(("reserved_{}".format(rsvd_cnt), rsvd_width, 0))
                    rsvd_cnt += 1
            else:
                if orig_flds[index].high < orig_flds[index+1].low - 1:
                    rsvd_width = orig_flds[index+1].low - 1 - orig_flds[index].high
                    all_flds.append(("reserved_{}".format(rsvd_cnt), rsvd_width, 0))
                    rsvd_cnt += 1

        return all_flds

    def _get_acc_bit_vec(self, node:RegNode, attr:str):
        """
        get access attribute bit vector for a register
        """
        d = {
            "r": 0,
            "rclr": 0,
            "rset": 0,
            "w": 0,
            "woclr": 0,
            "woset": 0,
            "wot": 0,
            "wzc": 0,
            "wzs": 0,
            "wzt": 0,
            "singlepulse": 0
        }

        for field in node.fields(skip_not_present=False):
            keys = []

            if field.is_sw_readable:
                keys.append("r")

                if field.get_property("onread") == OnReadType.rclr:
                    keys.append("rclr")
                elif field.get_property("onread") == OnReadType.rset:
                    keys.append("rset")

            if field.is_sw_writable:
                keys.append("w")

                if field.get_property("onwrite") == OnWriteType.woclr:
                    keys.append("woclr")
                elif field.get_property("onwrite") == OnWriteType.woset:
                    keys.append("woset")
                elif field.get_property("onwrite") == OnWriteType.wot:
                    keys.append("wot")
                elif field.get_property("onwrite") == OnWriteType.wzc:
                    keys.append("wzc")
                elif field.get_property("onwrite") == OnWriteType.wzs:
                    keys.append("wzs")
                elif field.get_property("onwrite") == OnWriteType.wzt:
                    keys.append("wzt")

            if field.get_property("singlepulse"):
                keys.append("singlepulse")

            for k in keys:
                d[k] = d[k] | (((1 << field.width) - 1) << field.low)

        return "{0:#0{1}X}".format(d.get(attr, 0), 2 + node.size * 2) # pad to 2 + node.size * 2

def export_chdr(top_node:AddrmapNode, out_dir:str):
    """
    Export C header files.

    Parameter
    ---------
    `root` : `systemrdl.node.RootNode`, the root node of the compiled register model
    `out_dir` : ouput directory to save the generated C header files (.h)
    """
    exporter = CHdrExporter()

    chdr_dir = os.path.join(out_dir, "chdr")
    if not os.path.exists(chdr_dir):
        os.makedirs(chdr_dir)

    try:
        exporter.export(top_node, chdr_dir)
    except Exception:
        message.error(
            "HRDA encounters some unknown errors\n{}\n"
            "C header exporter aborted due to previous errors".format(
                traceback.format_exc()
            ), raise_err=False)
    else:
        message.info("save C header files in directory: %s" % (chdr_dir))
