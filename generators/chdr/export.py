import os
import sys
import traceback

import jinja2 as jj
import utils.message as message
from systemrdl.node import (AddressableNode, AddrmapNode, MemNode, Node,
                            RegfileNode, RegNode, RootNode)


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
            undefined=jj.StrictUndefined
        )

        self.context = {
            'addr_width': 64,
            'data_width': 32,
            'RegNode': RegNode,
            'RegfileNode': RegfileNode,
            'AddrmapNode': AddrmapNode,
            'MemNode': MemNode,
            'isinstance': isinstance,
            'get_inst_name': self._get_inst_name,
            'get_property': self._get_property,
            'get_base_addr': self._get_base_addr,
            'get_addr_offset': self._get_addr_offset,
            'get_all_fields' : self._get_all_fields,
            'get_hier_name': self._get_hier_name
        }

    def export(self, top_node: Node, curr_node: Node, dir: str):
        """
        traverse all addrmap and generate all c header files in pre-order

        Parameter
        ---------
        `top_node` :
        `curr_node` :
        `dir` :
        """
        for node in curr_node.children(unroll=True, skip_not_present=False):
            if isinstance(node, AddrmapNode):
                if node.get_property("hj_genslv") or node.get_property("hj_3rd_party_IP"):
                    update_context = {
                        'node': node
                    }
                    self.context.update(update_context)

                    template = self.jj_env.get_template("chdr.jinja")

                    stream = template.stream(self.context)
                    stream.dump(os.path.join(dir, "%s.h" % (node.get_path_segment())))

                self.export(top_node, node, dir)

    def _get_property(self, node:Node, prop_name):
        return node.get_property(prop_name)

    def _get_base_addr(self, node:AddressableNode, step:int = 1):
        return hex(node.absolute_address // step)

    def _get_addr_offset(self, node:AddressableNode):
        return hex(node.address_offset)

    def _get_inst_name(self, node:Node):
        return node.get_path_segment()

    def _get_hier_name(self, node:Node):
        return node.get_rel_path(self.context.get('node').parent,
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
            all_flds.append((orig_flds[index].inst_name, orig_flds[index].width))

            if index == len(orig_flds) - 1:
                if orig_flds[index].high < node.size * 8 - 1:
                    rsvd_width = node.size * 8 - 1 - orig_flds[index].high
                    all_flds.append(("reserved_{}".format(rsvd_cnt), rsvd_width))
            else:
                if orig_flds[index].high < orig_flds[index+1].low - 1:
                    rsvd_width = orig_flds[index+1].low - 1 - orig_flds[index].high
                    all_flds.append(("reserved_{}".format(rsvd_cnt), rsvd_width))
                    rsvd_cnt += 1

        return all_flds

def export_chdr(root:RootNode, out_dir:str):
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
        exporter.export(root, root, chdr_dir)
    except Exception:
        message.error(
            "HRDA encounters some unknown errors\n{}\n"
            "C header exporter aborted due to previous errors".format(
                traceback.format_exc()
            )
        )
    else:
        message.info("save C header files in directory: %s" % (chdr_dir))
