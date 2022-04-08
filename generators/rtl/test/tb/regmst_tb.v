`timescale 1ns/1ns

module tb_regmst_test;

parameter ADDR_WIDTH = 64;
parameter DATA_WIDTH = 32;

logic clk;
logic rstn;

// APB interface
logic PSEL;
logic PENABLE;
logic PREADY;
logic PWRITE;
logic PSLVERR;
logic [ADDR_WIDTH-1:0] PADDR;
logic [DATA_WIDTH-1:0] PWDATA;
logic [DATA_WIDTH-1:0] PRDATA;

// interrupt, clear and sync reset
logic mst__bus__interrupt;
logic mst__ext__glb_srst;
logic bus__mst__clear;


// module: regmst_reg_top DUT
// reg_native_if between regmst <-> downstream regslv/external memory
// directly connected upstream:
//      APB interface
// directly connected downstream:
//      regslv: regslv_reg_block_1, regslv_reg_block_2
//      memory : ext_mem_in_top
parameter MST_EXT_NUM = 3;

logic [MST_EXT_NUM-1:0] mst__ext__req_vld;
logic [MST_EXT_NUM-1:0] mst__ext__req_rdy;
logic [MST_EXT_NUM-1:0] mst__ext__ack_vld;
logic mst__ext__ack_rdy;
logic mst__ext__wr_en;
logic mst__ext__rd_en;
logic [ADDR_WIDTH-1:0] mst__ext__addr;
logic [DATA_WIDTH-1:0] mst__ext__wr_data;
logic [MST_EXT_NUM-1:0] [DATA_WIDTH-1:0] mst__ext__rd_data;

regmst_reg_top #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH))
regmst_reg_top_dut (
    .clk(clk),
    .rstn(rstn),
    // APB interface
    .PSEL(PSEL),
    .PENABLE(PENABLE),
    .PREADY(PREADY),
    .PWRITE(PWRITE),
    .PSLVERR(PSLVERR),
    .PADDR(PADDR),
    .PWDATA(PWDATA),
    .PRDATA(PRDATA),
    // interrupt and clear
    .interrput(mst__bus__interrupt),
    .clear(bus__mst__clear),
    .global_sync_reset_out(mst__ext__glb_srst),
    // reg_native_if connected to external memory and downstream regslv
    .ext_req_vld(mst__ext__req_vld),
    .ext_req_rdy(mst__ext__req_rdy),
    .ext_ack_vld(mst__ext__ack_vld),
    .ext_ack_rdy(mst__ext__ack_rdy),
    .ext_wr_en(mst__ext__wr_en),
    .ext_rd_en(mst__ext__rd_en),
    .ext_addr(mst__ext__addr),
    .ext_wr_data(mst__ext__wr_data),
    .ext_rd_data(mst__ext__rd_data)
);


// module: regslv_reg_block_1 DUT
// reg_native_if between regslv_reg_block_1 <-> downstream regslv/external memory
// directly connected downstream:
//      regslv: regslv_test_11
//      memory : ext_mem_11
parameter REGSLV_REG_BLOCK_1_EXT_NUM = 2;
parameter REGSLV_REG_BLOCK_1_INT_NUM = 2;

logic [REGSLV_REG_BLOCK_1_EXT_NUM-1:0] regslv_reg_block_1__ext__req_vld;
logic [REGSLV_REG_BLOCK_1_EXT_NUM-1:0] regslv_reg_block_1__ext__req_rdy;
logic [REGSLV_REG_BLOCK_1_EXT_NUM-1:0] regslv_reg_block_1__ext__ack_vld;
logic regslv_reg_block_1__ext__ack_rdy;
logic regslv_reg_block_1__ext__wr_en;
logic regslv_reg_block_1__ext__rd_en;
logic [ADDR_WIDTH-1:0] regslv_reg_block_1__ext__addr;
logic [DATA_WIDTH-1:0] regslv_reg_block_1__ext__wr_data;
logic [REGSLV_REG_BLOCK_1_EXT_NUM-1:0] [DATA_WIDTH-1:0] regslv_reg_block_1__ext__rd_data;

logic regslv_reg_block_1__ext__glb_srst;

regslv_reg_block_1 #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH))
regslv_reg_block_1_dut (
    .clk(clk),
    .rstn(rstn),
    // upstream reg_native_if
    .req_vld(mst__ext__req_vld[0]),
    .req_rdy(mst__ext__req_rdy[0]),
    .ack_vld(mst__ext__ack_vld[0]),
    .ack_rdy(mst__ext__ack_rdy),
    .wr_en(mst__ext__wr_en),
    .rd_en(mst__ext__rd_en),
    .addr(mst__ext__addr),
    .wr_data(mst__ext__wr_data),
    .rd_data(mst__ext__rd_data[0]),
    // synchronous reset signals
    .global_sync_reset_in(mst__ext__glb_srst),
    .global_sync_reset_out(regslv_reg_block_1__ext__glb_srst),
    // external memory reg_native_if
    .ext_req_vld(regslv_reg_block_1__ext__req_vld),
    .ext_req_rdy(regslv_reg_block_1__ext__req_rdy),
    .ext_ack_vld(regslv_reg_block_1__ext__ack_vld),
    .ext_ack_rdy(regslv_reg_block_1__ext__ack_rdy),
    .ext_wr_en(regslv_reg_block_1__ext__wr_en),
    .ext_rd_en(regslv_reg_block_1__ext__rd_en),
    .ext_addr(regslv_reg_block_1__ext__addr),
    .ext_wr_data(regslv_reg_block_1__ext__wr_data),
    .ext_rd_data(regslv_reg_block_1__ext__rd_data),
    // hardware access input ports
    .test_12_shared_2__FIELD_0__next_value(32'b0),
    .test_12_shared_2__FIELD_0__pulse(1'b0),
    .test_12_shared_2__FIELD_0__curr_value(),
);


// module: regslv_test_11 DUT
// upstream module: regslv_reg_block_1
// connected to:
//      regslv_reg_block_1__reg_native_if[0]
parameter REGSLV_TEST_11_EXT_NUM = 0;
parameter REGSLV_TEST_11_INT_NUM = 8;

logic regslv_test_11__srst_1;
logic regslv_test_11__srst_2;

regslv_test_11 #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH))
regslv_test_11_dut #(
    .clk(clk),
    .rstn(rstn),
    // synchronous reset signals
    .srst_1(regslv_test_11__srst_1),
    .srst_2(regslv_test_11__srst_2),
    .global_sync_reset_in(),
    .global_sync_reset_out(),
    // upstream reg_native_if
    .req_vld(regslv_reg_block_1__ext__req_vld[0]),
    .req_rdy(regslv_reg_block_1__ext__req_rdy[0]),
    .ack_vld(regslv_reg_block_1__ext__ack_vld[0]),
    .ack_rdy(regslv_reg_block_1__ext__ack_rdy),
    .wr_en(regslv_reg_block_1__ext__wr_en),
    .rd_en(regslv_reg_block_1__ext__rd_en),
    .addr(regslv_reg_block_1__ext__addr),
    .wr_data(regslv_reg_block_1__ext__wr_data),
    .rd_data(regslv_reg_block_1__ext__rd_data[0])
);


// module: ext_mem_11_DUT
// upstream module: regslv_reg_block_1
// connected to:
//      regslv_reg_block_1__reg_native_if[1]

// instantiate regslv_test_11



// reg_native_if between regslv_reg_block_2 <-> downstream external memories
// directly connected downstream:
//      memory : ext_mem_21, ext_mem_22, ext_mem_23
parameter REG_BLOCK_2_EXT_NUM = 3;
parameter REG_BLOCK_2_INT_NUM = 10;

logic [REG_BLOCK_2_EXT_NUM-1:0] regslv_reg_block_2__ext__req_vld;
logic [REG_BLOCK_2_EXT_NUM-1:0] regslv_reg_block_2__ext__req_rdy;
logic [REG_BLOCK_2_EXT_NUM-1:0] regslv_reg_block_2__ext__ack_vld;
logic regslv_reg_block_2__ext__ack_rdy;
logic regslv_reg_block_2__ext__wr_en;
logic regslv_reg_block_2__ext__rd_en;
logic [ADDR_WIDTH-1:0] regslv_reg_block_2__ext__addr;
logic [DATA_WIDTH-1:0] regslv_reg_block_2__ext__wr_data;
logic [REG_BLOCK_2_EXT_NUM-1:0] [DATA_WIDTH-1:0] regslv_reg_block_2__ext__rd_data;

logic regslv_reg_block_2__ext__glb_srst;
logic reg_block_2__test_21_srst_1;
logic reg_block_2__test_21_srst_2;

// instantiate regslv_reg_block_2
regslv_reg_block_2 #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH))
regslv_reg_block_2_dut (
    .clk(clk),
    .rstn(rstn),
    // upstream reg_native_if
    .req_vld(mst__ext__req_vld[1]),
    .req_rdy(mst__ext__req_rdy[1]),
    .ack_vld(mst__ext__ack_vld[1]),
    .ack_rdy(mst__ext__ack_rdy),
    .wr_en(mst__ext__wr_en),
    .rd_en(mst__ext__rd_en),
    .addr(mst__ext__addr),
    .wr_data(mst__ext__wr_data),
    .rd_data(mst__ext__rd_data[1]),
    // synchronous reset signals
    .global_sync_reset_in(mst__ext__glb_srst),
    .global_sync_reset_out(regslv_reg_block_2__ext__glb_srst),
    .test_21_srst_1(reg_block_2__test_21_srst_1),
    .test_21_srst_2(reg_block_2__test_21_srst_2),
    // external memory reg_native_if
    .ext_req_vld(regslv_reg_block_2__ext__req_vld),
    .ext_req_rdy(regslv_reg_block_2__ext__req_rdy),
    .ext_ack_vld(regslv_reg_block_2__ext__ack_vld),
    .ext_ack_rdy(regslv_reg_block_2__ext__ack_rdy),
    .ext_wr_en(regslv_reg_block_2__ext__wr_en),
    .ext_rd_en(regslv_reg_block_2__ext__rd_en),
    .ext_addr(regslv_reg_block_2__ext__addr),
    .ext_wr_data(regslv_reg_block_2__ext__wr_data),
    .ext_rd_data(regslv_reg_block_2__ext__rd_data),
    // hardware access input ports
    .test_21_REG1_SW_RW__FIELD_8__next_value(2'b0),
    .test_21_REG1_SW_RW__FIELD_8__pulse(1'b0),
    .test_21_REG1_SW_RW__FIELD_8__curr_value(),
    .test_21_REG1_SW_RW__FIELD_7__next_value(2'b0),
    .test_21_REG1_SW_RW__FIELD_7__pulse(1'b0),
    .test_21_REG1_SW_RW__FIELD_7__curr_value(),
    .test_21_REG1_SW_RW__FIELD_6__next_value(2'b0),
    .test_21_REG1_SW_RW__FIELD_6__pulse(1'b0),
    .test_21_REG1_SW_RW__FIELD_6__curr_value(),
    .test_21_REG1_SW_RW__FIELD_5__next_value(2'b0),
    .test_21_REG1_SW_RW__FIELD_5__pulse(1'b0),
    .test_21_REG1_SW_RW__FIELD_5__curr_value(),
    .test_21_REG1_SW_RW__FIELD_4__next_value(2'b0),
    .test_21_REG1_SW_RW__FIELD_4__pulse(1'b0),
    .test_21_REG1_SW_RW__FIELD_4__curr_value(),
    .test_21_REG1_SW_RW__FIELD_3__next_value(2'b0),
    .test_21_REG1_SW_RW__FIELD_3__pulse(1'b0),
    .test_21_REG1_SW_RW__FIELD_3__curr_value(),
    .test_21_REG1_SW_RW__FIELD_2__next_value(2'b0),
    .test_21_REG1_SW_RW__FIELD_2__pulse(1'b0),
    .test_21_REG1_SW_RW__FIELD_2__curr_value(),
    .test_21_REG1_SW_RW__FIELD_1__next_value(2'b0),
    .test_21_REG1_SW_RW__FIELD_1__pulse(1'b0),
    .test_21_REG1_SW_RW__FIELD_1__curr_value(),
    .test_21_REG1_SW_RW__FIELD_0__next_value(2'b0),
    .test_21_REG1_SW_RW__FIELD_0__pulse(1'b0),
    .test_21_REG1_SW_RW__FIELD_0__curr_value(),
    .test_21_REG2_SW_W__FIELD_6__next_value(2'b0),
    .test_21_REG2_SW_W__FIELD_6__pulse(1'b0),
    .test_21_REG2_SW_W__FIELD_6__curr_value(),
    .test_21_REG2_SW_W__FIELD_5__next_value(2'b0),
    .test_21_REG2_SW_W__FIELD_5__pulse(1'b0),
    .test_21_REG2_SW_W__FIELD_5__curr_value(),
    .test_21_REG2_SW_W__FIELD_4__next_value(2'b0),
    .test_21_REG2_SW_W__FIELD_4__pulse(1'b0),
    .test_21_REG2_SW_W__FIELD_4__curr_value(),
    .test_21_REG2_SW_W__FIELD_3__next_value(2'b0),
    .test_21_REG2_SW_W__FIELD_3__pulse(1'b0),
    .test_21_REG2_SW_W__FIELD_3__curr_value(),
    .test_21_REG2_SW_W__FIELD_2__next_value(2'b0),
    .test_21_REG2_SW_W__FIELD_2__pulse(1'b0),
    .test_21_REG2_SW_W__FIELD_2__curr_value(),
    .test_21_REG2_SW_W__FIELD_1__next_value(2'b0),
    .test_21_REG2_SW_W__FIELD_1__pulse(1'b0),
    .test_21_REG2_SW_W__FIELD_1__curr_value(),
    .test_21_REG2_SW_W__FIELD_0__next_value(2'b0),
    .test_21_REG2_SW_W__FIELD_0__pulse(1'b0),
    .test_21_REG2_SW_W__FIELD_0__curr_value(),
    .test_21_REG3_HW__FIELD_3__next_value(2'b0),
    .test_21_REG3_HW__FIELD_3__pulse(1'b0),
    .test_21_REG3_HW__FIELD_3__curr_value(),
    .test_21_REG3_HW__FIELD_2__next_value(2'b0),
    .test_21_REG3_HW__FIELD_2__pulse(1'b0),
    .test_21_REG3_HW__FIELD_2__curr_value(),
    .test_21_REG3_HW__FIELD_0__next_value(2'b0),
    .test_21_REG3_HW__FIELD_0__pulse(1'b0),
    .test_21_REG3_HW__FIELD_0__curr_value(),
    .test_21_REG4_PRECEDENCE__FIELD_1__next_value(2'b0),
    .test_21_REG4_PRECEDENCE__FIELD_1__pulse(1'b0),
    .test_21_REG4_PRECEDENCE__FIELD_1__curr_value(),
    .test_21_REG4_PRECEDENCE__FIELD_0__next_value(2'b0),
    .test_21_REG4_PRECEDENCE__FIELD_0__pulse(1'b0),
    .test_21_REG4_PRECEDENCE__FIELD_0__curr_value(),
    .test_21_REG5_SINGLEPULSE__FIELD_0__next_value(1'b0),
    .test_21_REG5_SINGLEPULSE__FIELD_0__pulse(1'b0),
    .test_21_REG5_SINGLEPULSE__FIELD_0__curr_value(),
    .test_21_REG6_SW_ACC_MOD__FIELD_0__next_value(2'b0),
    .test_21_REG6_SW_ACC_MOD__FIELD_0__pulse(1'b0),
    .test_21_REG6_SW_ACC_MOD__FIELD_0__curr_value(),
    .test_22_shared_2__FIELD_0__next_value(32'b0),
    .test_22_shared_2__FIELD_0__pulse(1'b0),
    .test_22_shared_2__FIELD_0__curr_value()
);


parameter EXT_MEM_IN_TOP_DATA_WIDTH = 32;
parameter EXT_MEM_IN_TOP_ADDR_WIDTH = 6;

// convert bus address to external memory address
logic [ADDR_WIDTH-1:0] mem_in_top__addr;
assign mem_in_top__addr = mst__ext__addr - 64'hd00;

// instantiate ext_mem_in_top which is directly under regmst
ext_mem #(
    .DATA_WIDTH(EXT_MEM_IN_TOP_DATA_WIDTH),
    .ADDR_WIDTH(EXT_MEM_IN_TOP_ADDR_WIDTH))
ext_mem_in_top (
    .clk(clk),
    .req_vld(mst__ext__req_vld[2]),
    .req_rdy(mst__ext__req_rdy[2]),
    .wr_en(mst__ext__wr_en),
    .rd_en(mst__ext__rd_en),
    .addr(mem_in_top__addr),
    .wr_data(mst__ext__wr_data),
    .rd_data(mst__ext__rd_data[2]),
    .ack_vld(mst__ext__ack_vld[2]),
    .ack_rdy(mst__ext__ack_rdy)
);



/********************************************************************
*********************** simulation process **************************
*********************************************************************/

// dump simulation files
initial begin
    $fsdbDumpfile("tb_regmst_test.fsdb");
    $fsdbDumpvars(0, tb_regmst_test);
    $fsdbDumpMDA();
end

// generate 50MHz clock
localparam CLK_PERIOD = 20;
always #(CLK_PERIOD/2) clk = ~clk;

// generate low-active reset signal
initial begin
    clk = 1'b0;
    rstn = 1'b0;
    // deassert reset signal after 10 clock cycles
    #(CLK_PERIOD*10) rstn = 1;
end

/********************************************************************
********* test stimulus and external memory initialization **********
*********************************************************************/

// all external memory entries initialized to 0
generate
    genvar i;
    for (i = 0; i < EXT_MEM_NUM; i = i + 1) begin: init_ext_mem
        initial begin
            for (integer j = 0; j < (1<<EXT_MEM_ADDR_WIDTH); j = j + 1) begin
                gen_ext_mem[i].ext_mem_32_64_inst.mem[j] = {DATA_WIDTH{1'b0}};
            end
        end
    end
endgenerate

reg [ADDR_WIDTH-1:0] internal_addrs [0:INT_REG_NUM-1];
reg [ADDR_WIDTH-1:0] external_addrs [0:EXT_MEM_NUM*(1<<EXT_MEM_ADDR_WIDTH)];

initial begin
    // all upstream reg_native_if input initialized to 0
    req_vld = 1'b0;
    wr_en = 1'b0;
    rd_en = 1'b0;
    addr = {ADDR_WIDTH{1'b0}};
    wr_data = {DATA_WIDTH{1'b0}};
    ack_rdy = 1'b0;

    // all synchronous reset signals initialized to invalid
    global_srst_in = 1'b0;
    test_1_inst_srst_1 = 1'b0;
    test_1_inst_srst_2 = 1'b0;

    // get addresses of internal registers and external memory entries
    $readmemh("internal_addr_hex.txt", internal_addrs);
    $readmemh("external_addr_hex.txt", external_addrs);
end

/********************************************************************
******************* mimic upstream reg_native_if ********************
*********************************************************************/
initial begin
    wait(rstn);
    #(CLK_PERIOD*2);

    // access internal registers
    $display($time, " access internal registers");
    for (integer i = 0; i < INT_REG_NUM; i = i + 1) begin
        // write operation
        @(posedge clk); #0;
        req_vld = 1'b1;
        wr_en = 1'b1;
        addr = internal_addrs[i];
        wr_data = {DATA_WIDTH{1'b1}};
        $display($time, " start write operation: addr=%h data=%h", addr, wr_data);

        wait(req_rdy);
        ack_rdy = 1'b1;
        @(posedge clk); #0;
        req_vld = 1'b0;
        wr_en = 1'b0;

        wait(ack_vld);
        @(posedge clk); #0;
        ack_rdy = 1'b0;
        $display($time, " end write operation");

        // read operation
        @(posedge clk); #0;
        req_vld = 1'b1;
        rd_en = 1'b1;
        addr = internal_addrs[i];
        $display($time, " start read operation: addr=%h", addr);

        wait(req_rdy);
        ack_rdy = 1'b1;
        @(posedge clk); #0;
        req_vld = 1'b0;
        rd_en = 1'b0;

        wait(ack_vld);
        @(posedge clk); #0;
        ack_rdy = 1'b0;
        $display($time, " end read operation: data=%h", rd_data);
    end

    @(posedge clk);
    #(CLK_PERIOD*10);

    // access external memories
    $display($time, " access external memories");
    for (integer i = 0; i < EXT_MEM_NUM; i = i + 1) begin
        for (integer j = 0; j < (1<<EXT_MEM_ADDR_WIDTH); j = j + 1) begin
            @(posedge clk); #0;
            // write operation
            req_vld = 1'b1;
            wr_en = 1'b1;
            addr = external_addrs[(i*(1<<EXT_MEM_ADDR_WIDTH))+j];
            wr_data = {DATA_WIDTH{1'b1}};
            $display($time, " start write operation: addr=%h data=%h", addr, wr_data);

            wait(req_rdy);
            @(posedge clk); #0;
            req_vld = 1'b0;

            wait(ack_vld);
            @(posedge clk); #0;
            ack_rdy = 1'b1;
            wr_en = 1'b0;
            @(posedge clk); #0;
            ack_rdy = 1'b0;
            $display($time, " end write operation");

            #(CLK_PERIOD*2);
            @(posedge clk); #0;

            // read operation
            req_vld = 1'b1;
            rd_en = 1'b1;
            addr = external_addrs[(i*(1<<EXT_MEM_ADDR_WIDTH))+j];
            $display($time, " start read operation: addr=%h", addr);

            wait(req_rdy);
            @(posedge clk); #0;
            req_vld = 1'b0;

            wait(ack_vld);
            @(posedge clk); #0;
            ack_rdy = 1'b1;
            rd_en = 1'b0;
            @(posedge clk); #0;
            ack_rdy = 1'b0;
            $display($time, " end read operation: data=%h", rd_data);
        end
    end

    #(CLK_PERIOD*10);
    $finish;
end

endmodule