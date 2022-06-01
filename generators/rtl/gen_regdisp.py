import os
import sys
from math import log

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
            'addr_width': 64,
            'data_width': 32,
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
            'get_rtl_name': self._get_rtl_name,
            'get_property': self._get_property
        }

    def export_regdisp(self, top_node: Node, dir: str):
        """
        traverse all addrmap and generate all regdisp modules in pre-order

        Parameter
        ---------
        `top_node` :
        `path` :
        """
        # if it's the root node, skip to the top addrmap
        if isinstance(top_node, RootNode):
            top_node = top_node.top

        for child in top_node.children(unroll=True, skip_not_present=False):
            if isinstance(child, AddrmapNode) and child.get_property("hj_gendisp"):
                update_context = {
                    'disp_node': child
                }
                self.context.update(update_context)

                template = self.jj_env.get_template("regdisp_template.jinja")

                stream = template.stream(self.context)
                stream.dump(os.path.join(dir, self._get_rtl_name(child)))

                self.export_regdisp(child, dir)

    def _get_rtl_name(self, node:Node):
        return node.get_property("rtl_module_name")

    def _get_forward_num(self, node:AddrmapNode):
        # only for regdisp
        if not node.get_property("hj_gendisp") is True:
            message.error("addrmap %s is not recognized as a regdisp module" % (node.get_path()))
            sys.exit(1)

        return node.get_property("forward_num")

    def _use_abs_addr(self, node:Node):
        return node.get_property("hj_use_abs_addr")

    def _get_property(self, node:Node, prop_name):
        return node.get_property(prop_name)

    def _is_aligned(self, node:AddressableNode):
        # whether the forwarding module of regdisp is aligned to its absolute address
        return node.absolute_address % (2 ** int(log(node.total_size, base=2)+1)) == 0

    def _get_comp_addr(self, node:AddressableNode):
        # get compressed address expressions to simplify implementation of decoder in RTL code
        return

    def _dec_addr_bit(self):
        return [
            self.context["addr_width"] - 1,
            int(log(self.context["data_width"] // 8, base=2))
        ]