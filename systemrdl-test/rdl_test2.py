#!/usr/bin/env python3

from systemrdl import RDLListener
from systemrdl.node import RootNode

# Define a listener that will print out the register model hierarchy
class MyListener(RDLListener):
    def enter_Addrmap(self, node):
        print("Entering addrmap", node.get_path())

    def exit_Addrmap(self, node):
        print("Exiting addrmap", node.get_path())

    def enter_Reg(self, node):
        print("Entering register", node.get_path())

    def exit_Reg(self, node):
        print("Exiting register", node.get_path())

    def enter_Field(self, node):
        print("Entering field", node.get_path())

    def exit_Field(self, node):
        print("Exiting field", node.get_path())

if __name__ == "__main__":
    import sys
    import os

    from systemrdl import RDLCompiler, RDLCompileError, RDLWalker
    from systemrdl.component import Component, Root, Addrmap, Regfile, Reg, Field, Signal
    root = Root()
    map1 = Addrmap()
    breakpoint
    