
// This file was autogenerated by PeakRDL-uvm
package uvm_test;
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    
    // Reg - root_map.test_map_1_inst.TEM21
    class root_map__test_map_1_inst__TEM21 extends uvm_reg;
        rand uvm_reg_field FIELD_3;
        rand uvm_reg_field FIELD_2;
        rand uvm_reg_field FIELD_1;

        function new(string name = "root_map__test_map_1_inst__TEM21");
            super.new(name, 32, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
            this.FIELD_3 = new("FIELD_3");
            this.FIELD_3.configure(this, 1, 13, "W1T", 1, 'h1, 1, 1, 0);
            this.FIELD_2 = new("FIELD_2");
            this.FIELD_2.configure(this, 3, 14, "W1S", 1, 'h0, 1, 1, 0);
            this.FIELD_1 = new("FIELD_1");
            this.FIELD_1.configure(this, 1, 17, "RC", 1, 'h0, 1, 1, 0);
        endfunction : build
    endclass : root_map__test_map_1_inst__TEM21

    // Reg - root_map.test_map_1_inst.TEM22
    class root_map__test_map_1_inst__TEM22 extends uvm_reg;
        rand uvm_reg_field FIELD_3;
        rand uvm_reg_field FIELD_2;
        rand uvm_reg_field FIELD_1;

        function new(string name = "root_map__test_map_1_inst__TEM22");
            super.new(name, 32, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
            this.FIELD_3 = new("FIELD_3");
            this.FIELD_3.configure(this, 1, 13, "W1T", 1, 'h1, 1, 1, 0);
            this.FIELD_2 = new("FIELD_2");
            this.FIELD_2.configure(this, 3, 14, "W1S", 1, 'h0, 1, 1, 0);
            this.FIELD_1 = new("FIELD_1");
            this.FIELD_1.configure(this, 1, 17, "RC", 1, 'h0, 1, 1, 0);
        endfunction : build
    endclass : root_map__test_map_1_inst__TEM22

    // Reg - root_map.test_map_1_inst.TEM23
    class root_map__test_map_1_inst__TEM23 extends uvm_reg;
        rand uvm_reg_field FIELD_3;
        rand uvm_reg_field FIELD_2;
        rand uvm_reg_field FIELD_1;

        function new(string name = "root_map__test_map_1_inst__TEM23");
            super.new(name, 32, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
            this.FIELD_3 = new("FIELD_3");
            this.FIELD_3.configure(this, 1, 13, "W1T", 1, 'h1, 1, 1, 0);
            this.FIELD_2 = new("FIELD_2");
            this.FIELD_2.configure(this, 3, 14, "W1S", 1, 'h0, 1, 1, 0);
            this.FIELD_1 = new("FIELD_1");
            this.FIELD_1.configure(this, 1, 17, "RC", 1, 'h0, 1, 1, 0);
        endfunction : build
    endclass : root_map__test_map_1_inst__TEM23

    // Reg - root_map.test_map_1_inst.TEM21_alias
    class root_map__test_map_1_inst__TEM21_alias extends uvm_reg;
        rand uvm_reg_field FIELD_3;
        rand uvm_reg_field FIELD_2;
        rand uvm_reg_field FIELD_1;

        function new(string name = "root_map__test_map_1_inst__TEM21_alias");
            super.new(name, 32, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
            this.FIELD_3 = new("FIELD_3");
            this.FIELD_3.configure(this, 1, 13, "W1T", 1, 'h1, 1, 1, 0);
            this.FIELD_2 = new("FIELD_2");
            this.FIELD_2.configure(this, 3, 14, "W0CRS", 1, 'h0, 1, 1, 0);
            this.FIELD_1 = new("FIELD_1");
            this.FIELD_1.configure(this, 1, 17, "RC", 1, 'h0, 1, 1, 0);
        endfunction : build
    endclass : root_map__test_map_1_inst__TEM21_alias

    // Reg - root_map.test_map_1_inst.TEM22_alias
    class root_map__test_map_1_inst__TEM22_alias extends uvm_reg;
        rand uvm_reg_field FIELD_3;
        rand uvm_reg_field FIELD_2;
        rand uvm_reg_field FIELD_1;

        function new(string name = "root_map__test_map_1_inst__TEM22_alias");
            super.new(name, 32, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
            this.FIELD_3 = new("FIELD_3");
            this.FIELD_3.configure(this, 1, 13, "W1T", 1, 'h1, 1, 1, 0);
            this.FIELD_2 = new("FIELD_2");
            this.FIELD_2.configure(this, 3, 14, "W1S", 1, 'h0, 1, 1, 0);
            this.FIELD_1 = new("FIELD_1");
            this.FIELD_1.configure(this, 1, 17, "RC", 1, 'h0, 1, 1, 0);
        endfunction : build
    endclass : root_map__test_map_1_inst__TEM22_alias

    // Reg - root_map.test_map_1_inst.TEM23_alias
    class root_map__test_map_1_inst__TEM23_alias extends uvm_reg;
        rand uvm_reg_field FIELD_3;
        rand uvm_reg_field FIELD_2;
        rand uvm_reg_field FIELD_1;

        function new(string name = "root_map__test_map_1_inst__TEM23_alias");
            super.new(name, 32, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
            this.FIELD_3 = new("FIELD_3");
            this.FIELD_3.configure(this, 1, 13, "W1T", 1, 'h1, 1, 1, 0);
            this.FIELD_2 = new("FIELD_2");
            this.FIELD_2.configure(this, 3, 14, "W1SRC", 1, 'h0, 1, 1, 0);
            this.FIELD_1 = new("FIELD_1");
            this.FIELD_1.configure(this, 1, 17, "RC", 1, 'h0, 1, 1, 0);
        endfunction : build
    endclass : root_map__test_map_1_inst__TEM23_alias

    // Addrmap - root_map.test_map_1_inst
    class root_map__test_map_1_inst extends uvm_reg_block;
        rand root_map__test_map_1_inst__TEM21 TEM21;
        rand root_map__test_map_1_inst__TEM22 TEM22;
        rand root_map__test_map_1_inst__TEM23 TEM23;
        rand root_map__test_map_1_inst__TEM21_alias TEM21_alias;
        rand root_map__test_map_1_inst__TEM22_alias TEM22_alias;
        rand root_map__test_map_1_inst__TEM23_alias TEM23_alias;

        function new(string name = "root_map__test_map_1_inst");
            super.new(name);
        endfunction : new

        virtual function void build();
            this.default_map = create_map("reg_map", 0, 4, UVM_NO_ENDIAN);
            this.TEM21 = new("TEM21");
            this.TEM21.configure(this);
            TEM21.add_hdl_path_slice("regslv_test_map_1_inst.TEM21", -1, -1);
            this.TEM21.build();
            this.default_map.add_reg(this.TEM21, 'hc);
            this.TEM22 = new("TEM22");
            this.TEM22.configure(this);
            TEM22.add_hdl_path_slice("regslv_test_map_1_inst.TEM22", -1, -1);
            this.TEM22.build();
            this.default_map.add_reg(this.TEM22, 'h10);
            this.TEM23 = new("TEM23");
            this.TEM23.configure(this);
            TEM23.add_hdl_path_slice("regslv_test_map_1_inst.TEM23", -1, -1);
            this.TEM23.build();
            this.default_map.add_reg(this.TEM23, 'h14);
            this.TEM21_alias = new("TEM21_alias");
            this.TEM21_alias.configure(this);
            TEM21_alias.add_hdl_path_slice("regslv_test_map_1_inst.TEM21_alias", -1, -1);
            this.TEM21_alias.build();
            this.default_map.add_reg(this.TEM21_alias, 'h10c);
            this.TEM22_alias = new("TEM22_alias");
            this.TEM22_alias.configure(this);
            TEM22_alias.add_hdl_path_slice("regslv_test_map_1_inst.TEM22_alias", -1, -1);
            this.TEM22_alias.build();
            this.default_map.add_reg(this.TEM22_alias, 'h110);
            this.TEM23_alias = new("TEM23_alias");
            this.TEM23_alias.configure(this);
            TEM23_alias.add_hdl_path_slice("regslv_test_map_1_inst.TEM23_alias", -1, -1);
            this.TEM23_alias.build();
            this.default_map.add_reg(this.TEM23_alias, 'h114);
        endfunction : build
    endclass : root_map__test_map_1_inst

    // Reg - root_map.test_map_2_inst.shared_2
    class root_map__test_map_2_inst__shared_2 extends uvm_reg;
        rand uvm_reg_field FIELD_1;

        function new(string name = "root_map__test_map_2_inst__shared_2");
            super.new(name, 32, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
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
            shared_2.add_hdl_path_slice("test_map_2_inst.shared_2", -1, -1);
            this.shared_2.build();
            this.default_map.add_reg(this.shared_2, 'h0);
        endfunction : build
    endclass : root_map__test_map_2_inst

    // Reg - root_map.test_map_3_inst.shared_3[]
    class root_map__test_map_3_inst__shared_3 extends uvm_reg;
        rand uvm_reg_field FIELD_1;

        function new(string name = "root_map__test_map_3_inst__shared_3");
            super.new(name, 32, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
            this.FIELD_1 = new("FIELD_1");
            this.FIELD_1.configure(this, 3, 14, "RC", 1, 'h0, 1, 1, 0);
        endfunction : build
    endclass : root_map__test_map_3_inst__shared_3

    // Addrmap - root_map.test_map_3_inst
    class root_map__test_map_3_inst extends uvm_reg_block;
        rand root_map__test_map_3_inst__shared_3 shared_3[5];

        function new(string name = "root_map__test_map_3_inst");
            super.new(name);
        endfunction : new

        virtual function void build();
            this.default_map = create_map("reg_map", 0, 4, UVM_NO_ENDIAN);
            foreach(this.shared_3[i0]) begin
                this.shared_3[i0] = new($sformatf("shared_3[%0d]", i0));
                this.shared_3[i0].configure(this);
                shared_3[i0].add_hdl_path_slice("test_map_3_inst.shared_3", -1, -1);
                this.shared_3[i0].build();
                this.default_map.add_reg(this.shared_3[i0], 'h0 + i0*'h4);
            end
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
            reg1.add_hdl_path_slice("ipxact_block_example_inst.reg1", -1, -1);
            this.reg1.build();
            this.default_map.add_reg(this.reg1, 'h0);
            foreach(this.reg_array[i0]) begin
                this.reg_array[i0] = new($sformatf("reg_array[%0d]", i0));
                this.reg_array[i0].configure(this);
                reg_array[i0].add_hdl_path_slice("ipxact_block_example_inst.reg_array", -1, -1);
                this.reg_array[i0].build();
                this.default_map.add_reg(this.reg_array[i0], 'h100 + i0*'h4);
            end
        endfunction : build
    endclass : root_map__ipxact_block_example_inst

    // Addrmap - root_map
    class root_map extends uvm_reg_block;
        rand root_map__test_map_1_inst test_map_1_inst;
        rand root_map__test_map_2_inst test_map_2_inst;
        rand root_map__test_map_3_inst test_map_3_inst;
        rand root_map__ipxact_block_example_inst ipxact_block_example_inst;

        function new(string name = "root_map");
            super.new(name);
        endfunction : new

        virtual function void build();
            this.default_map = create_map("reg_map", 0, 4, UVM_NO_ENDIAN);
            this.test_map_1_inst = new("test_map_1_inst");
            this.test_map_1_inst.configure(this, "test_map_1_inst");
            this.test_map_1_inst.build();
            this.default_map.add_submap(this.test_map_1_inst.default_map, 'h0);
            this.test_map_2_inst = new("test_map_2_inst");
            this.test_map_2_inst.configure(this);
            this.test_map_2_inst.build();
            this.default_map.add_submap(this.test_map_2_inst.default_map, 'h118);
            this.test_map_3_inst = new("test_map_3_inst");
            this.test_map_3_inst.configure(this);
            this.test_map_3_inst.build();
            this.default_map.add_submap(this.test_map_3_inst.default_map, 'h120);
            this.ipxact_block_example_inst = new("ipxact_block_example_inst");
            this.ipxact_block_example_inst.configure(this, "ipxact_block_example");
            this.ipxact_block_example_inst.build();
            this.default_map.add_submap(this.ipxact_block_example_inst.default_map, 'h200);
        endfunction : build
    endclass : root_map

endpackage: uvm_test
