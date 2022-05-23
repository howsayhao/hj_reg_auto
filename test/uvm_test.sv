
// This file was autogenerated by PeakRDL-uvm
package uvm_test;
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    
    // Reg - root_map.test_map_2_inst.shared_2
    class root_map__test_map_2_inst__shared_2 extends uvm_reg;
        rand uvm_reg_field FIELD_2;
        rand uvm_reg_field FIELD_1;

        function new(string name = "root_map__test_map_2_inst__shared_2");
            super.new(name, 32, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
            this.FIELD_2 = new("FIELD_2");
            this.FIELD_2.configure(this, 2, 12, "RW", 1, 'h0, 1, 1, 0);
            this.FIELD_1 = new("FIELD_1");
            this.FIELD_1.configure(this, 3, 14, "W0T", 1, 'h0, 1, 1, 0);
        endfunction : build
    endclass : root_map__test_map_2_inst__shared_2

    // Addrmap - root_map.test_map_2_inst
    class root_map__test_map_2_inst extends uvm_reg_block;
        rand root_map__test_map_2_inst__shared_2 shared_2;

        function new(string name = "root_map__test_map_2_inst");
            super.new(name);
        endfunction : new

        virtual function void build();
            this.default_map = create_map("reg_map", 0, 4, UVM_NO_ENDIAN);
            this.shared_2 = new("shared_2");
            this.shared_2.configure(this);
            shared_2.add_hdl_path_slice("x__test_map_2_inst_shared_2__FIELD_2.field_value", 12, 2);
            shared_2.add_hdl_path_slice("x__test_map_2_inst_shared_2__FIELD_1.field_value", 14, 3);
            this.shared_2.build();
            this.default_map.add_reg(this.shared_2, 'h0);
        endfunction : build
    endclass : root_map__test_map_2_inst

    // Reg - root_map.test_map_3_inst.shared_3
    class root_map__test_map_3_inst__shared_3 extends uvm_reg;
        rand uvm_reg_field FIELD_2;
        rand uvm_reg_field FIELD_1;

        function new(string name = "root_map__test_map_3_inst__shared_3");
            super.new(name, 32, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
            this.FIELD_2 = new("FIELD_2");
            this.FIELD_2.configure(this, 2, 12, "RW", 1, 'h0, 1, 1, 0);
            this.FIELD_1 = new("FIELD_1");
            this.FIELD_1.configure(this, 3, 14, "RC", 1, 'h0, 1, 1, 0);
        endfunction : build
    endclass : root_map__test_map_3_inst__shared_3

    // Addrmap - root_map.test_map_3_inst
    class root_map__test_map_3_inst extends uvm_reg_block;
        rand root_map__test_map_3_inst__shared_3 shared_3;

        function new(string name = "root_map__test_map_3_inst");
            super.new(name);
        endfunction : new

        virtual function void build();
            this.default_map = create_map("reg_map", 0, 4, UVM_NO_ENDIAN);
            this.shared_3 = new("shared_3");
            this.shared_3.configure(this);
            shared_3.add_hdl_path_slice("x__test_map_2_inst_test_map_3_inst_shared_3__FIELD_2.field_value", 12, 2);
            shared_3.add_hdl_path_slice("x__test_map_2_inst_test_map_3_inst_shared_3__FIELD_1.field_value", 14, 3);
            this.shared_3.build();
            this.default_map.add_reg(this.shared_3, 'h0);
        endfunction : build
    endclass : root_map__test_map_3_inst

    // Reg - root_map.ipxact_block_example_inst.reg1
    class root_map__ipxact_block_example_inst__reg1 extends uvm_reg;
        rand uvm_reg_field f1;
        rand uvm_reg_field f2;

        function new(string name = "root_map__ipxact_block_example_inst__reg1");
            super.new(name, 32, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
            this.f1 = new("f1");
            this.f1.configure(this, 1, 0, "RW", 1, 'h0, 1, 1, 0);
            this.f2 = new("f2");
            this.f2.configure(this, 8, 8, "RW", 1, 'h7b, 1, 1, 0);
        endfunction : build
    endclass : root_map__ipxact_block_example_inst__reg1

    // Reg - root_map.ipxact_block_example_inst.reg_array[]
    class root_map__ipxact_block_example_inst__reg_array extends uvm_reg;
        rand uvm_reg_field x;

        function new(string name = "root_map__ipxact_block_example_inst__reg_array");
            super.new(name, 32, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
            this.x = new("x");
            this.x.configure(this, 1, 0, "RW", 1, 'h0, 1, 1, 0);
        endfunction : build
    endclass : root_map__ipxact_block_example_inst__reg_array

    // Addrmap - root_map.ipxact_block_example_inst
    class root_map__ipxact_block_example_inst extends uvm_reg_block;
        rand root_map__ipxact_block_example_inst__reg1 reg1;
        rand root_map__ipxact_block_example_inst__reg_array reg_array[4];

        function new(string name = "root_map__ipxact_block_example_inst");
            super.new(name);
        endfunction : new

        virtual function void build();
            this.default_map = create_map("reg_map", 0, 4, UVM_NO_ENDIAN);
            this.reg1 = new("reg1");
            this.reg1.configure(this);

            this.reg1.build();
            this.default_map.add_reg(this.reg1, 'h0);
            foreach(this.reg_array[i0]) begin
                this.reg_array[i0] = new($sformatf("reg_array[%0d]", i0));
                this.reg_array[i0].configure(this);
                
                this.reg_array[i0].build();
                this.default_map.add_reg(this.reg_array[i0], 'h100 + i0*'h4);
            end
        endfunction : build
    endclass : root_map__ipxact_block_example_inst

    // Addrmap - root_map
    class root_map extends uvm_reg_block;
        rand root_map__test_map_2_inst test_map_2_inst;
        rand root_map__test_map_3_inst test_map_3_inst;
        rand root_map__ipxact_block_example_inst ipxact_block_example_inst;

        function new(string name = "root_map");
            super.new(name);
        endfunction : new

        virtual function void build();
            this.default_map = create_map("reg_map", 0, 4, UVM_NO_ENDIAN);
            this.test_map_2_inst = new("test_map_2_inst");
            this.test_map_2_inst.configure(this);
            this.test_map_2_inst.build();
            this.default_map.add_submap(this.test_map_2_inst.default_map, 'h118);
            this.test_map_3_inst = new("test_map_3_inst");
            this.test_map_3_inst.configure(this);
            this.test_map_3_inst.build();
            this.default_map.add_submap(this.test_map_3_inst.default_map, 'h11c);
            this.ipxact_block_example_inst = new("ipxact_block_example_inst");
            this.ipxact_block_example_inst.configure(this);
            this.ipxact_block_example_inst.build();
            this.default_map.add_submap(this.ipxact_block_example_inst.default_map, 'h200);
        endfunction : build
    endclass : root_map

endpackage: uvm_test
