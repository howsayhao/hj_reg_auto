#!/usr/bin/env python3

from systemrdl import RDLListener
from systemrdl.node import FieldNode

# Define a listener that will print out the register model hierarchy
class MyListener(RDLListener):
    def enter_Addrmap(self, node):
        # print(node.get_path(), "external:", node.external)
        pass

    def exit_Addrmap(self, node):
        pass

    def enter_Reg(self, node):
        print(node.get_path(), "absolute address:", hex(node.absolute_address))

    def exit_Reg(self, node):
        pass

    def enter_Field(self, node):
        pass

    def exit_Field(self, node):
        pass

if __name__ == "__main__":
    import sys
    import os

    from systemrdl import RDLCompiler, RDLCompileError, RDLWalker

    # Collect input files from the command line arguments
    input_files = ["test_map.rdl"]

    # Create an instance of the compiler
    rdlc = RDLCompiler()

    try:
        # Compile all the files provided
        for input_file in input_files:
            rdlc.compile_file(input_file)

        # Elaborate the design
        root = rdlc.elaborate()
    except RDLCompileError:
        # A compilation error occurred. Exit with error code
        sys.exit(1)

    # Traverse the register model!
    walker = RDLWalker(unroll=True)
    listener = MyListener()
    walker.walk(root, listener)
