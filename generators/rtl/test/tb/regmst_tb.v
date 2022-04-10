`timescale 1ns/1ns

module regmst_tb;

parameter ADDR_WIDTH = 64;
parameter DATA_WIDTH = 32;

parameter EXT_MEM_ADDR_WIDTH = 6;
parameter EXT_MEM_DATA_WIDTH = 32;

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
// bus interface:
//      APB interface: testbench stimulus <-> regmst
//      reg_native_if: regmst <-> downstream regslv/external memory
// directly connected upstream:
//      APB interface
// directly connected downstream:
//      regslv: regslv_reg_block_1, regslv_reg_block_2
//      memory : ext_mem_in_top
// other signals:
//      interrupt, glb_srst, clear
parameter REGMST_REG_TOP_EXT_NUM = 3;

logic [REGMST_REG_TOP_EXT_NUM-1:0] mst__ext__req_vld;
logic [REGMST_REG_TOP_EXT_NUM-1:0] mst__ext__req_rdy;
logic [REGMST_REG_TOP_EXT_NUM-1:0] mst__ext__ack_vld;
logic mst__ext__ack_rdy;
logic mst__ext__wr_en;
logic mst__ext__rd_en;
logic [ADDR_WIDTH-1:0] mst__ext__addr;
logic [DATA_WIDTH-1:0] mst__ext__wr_data;
logic [REGMST_REG_TOP_EXT_NUM-1:0] [DATA_WIDTH-1:0] mst__ext__rd_data;

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
    .interrupt(mst__bus__interrupt),
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
// bus interface:
//      reg_native_if: regmst_reg_top <-if[0]-> regslv_reg_block_1
//      reg_native_if: regslv_reg_block_1 <-> downstream regslv/external memory
// directly connected upstream:
//      regmst: regmst_reg_top
// directly connected downstream:
//      regslv: regslv_test_11
//      memory : ext_mem_11
// other signals:
//      input glb_srst, output glb_srst,
//      hardware access ports for internal registers
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
    .test_12_shared_2__FIELD_0__curr_value()
);


// module: regslv_test_11 DUT
// bus interface:
//      reg_native_if: regslv_reg_block_1 <-(if[0])-> regslv_test_11
// directly connected upstream:
//      regslv: regslv_reg_block_1
// other signals:
//      input glb_srst, field srst signals
parameter REGSLV_TEST_11_EXT_NUM = 0;
parameter REGSLV_TEST_11_INT_NUM = 8;

logic regslv_test_11__srst_1;
logic regslv_test_11__srst_2;

regslv_test_11 #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH))
regslv_test_11_dut (
    .clk(clk),
    .rstn(rstn),
    // synchronous reset signals
    .srst_1(regslv_test_11__srst_1),
    .srst_2(regslv_test_11__srst_2),
    .global_sync_reset_in(regslv_reg_block_1__ext__glb_srst),
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
    .rd_data(regslv_reg_block_1__ext__rd_data[0]),
    // hardware access ports
    .REG1_SW_RW__FIELD_8__next_value(2'b0),
    .REG1_SW_RW__FIELD_8__pulse(1'b0),
    .REG1_SW_RW__FIELD_8__curr_value(),
    .REG1_SW_RW__FIELD_7__next_value(2'b0),
    .REG1_SW_RW__FIELD_7__pulse(1'b0),
    .REG1_SW_RW__FIELD_7__curr_value(),
    .REG1_SW_RW__FIELD_6__next_value(2'b0),
    .REG1_SW_RW__FIELD_6__pulse(1'b0),
    .REG1_SW_RW__FIELD_6__curr_value(),
    .REG1_SW_RW__FIELD_5__next_value(2'b0),
    .REG1_SW_RW__FIELD_5__pulse(1'b0),
    .REG1_SW_RW__FIELD_5__curr_value(),
    .REG1_SW_RW__FIELD_4__next_value(2'b0),
    .REG1_SW_RW__FIELD_4__pulse(1'b0),
    .REG1_SW_RW__FIELD_4__curr_value(),
    .REG1_SW_RW__FIELD_3__next_value(2'b0),
    .REG1_SW_RW__FIELD_3__pulse(1'b0),
    .REG1_SW_RW__FIELD_3__curr_value(),
    .REG1_SW_RW__FIELD_2__next_value(2'b0),
    .REG1_SW_RW__FIELD_2__pulse(1'b0),
    .REG1_SW_RW__FIELD_2__curr_value(),
    .REG1_SW_RW__FIELD_1__next_value(2'b0),
    .REG1_SW_RW__FIELD_1__pulse(1'b0),
    .REG1_SW_RW__FIELD_1__curr_value(),
    .REG1_SW_RW__FIELD_0__next_value(2'b0),
    .REG1_SW_RW__FIELD_0__pulse(1'b0),
    .REG1_SW_RW__FIELD_0__curr_value(),
    .REG2_SW_W__FIELD_6__next_value(2'b0),
    .REG2_SW_W__FIELD_6__pulse(1'b0),
    .REG2_SW_W__FIELD_6__curr_value(),
    .REG2_SW_W__FIELD_5__next_value(2'b0),
    .REG2_SW_W__FIELD_5__pulse(1'b0),
    .REG2_SW_W__FIELD_5__curr_value(),
    .REG2_SW_W__FIELD_4__next_value(2'b0),
    .REG2_SW_W__FIELD_4__pulse(1'b0),
    .REG2_SW_W__FIELD_4__curr_value(),
    .REG2_SW_W__FIELD_3__next_value(2'b0),
    .REG2_SW_W__FIELD_3__pulse(1'b0),
    .REG2_SW_W__FIELD_3__curr_value(),
    .REG2_SW_W__FIELD_2__next_value(2'b0),
    .REG2_SW_W__FIELD_2__pulse(1'b0),
    .REG2_SW_W__FIELD_2__curr_value(),
    .REG2_SW_W__FIELD_1__next_value(2'b0),
    .REG2_SW_W__FIELD_1__pulse(1'b0),
    .REG2_SW_W__FIELD_1__curr_value(),
    .REG2_SW_W__FIELD_0__next_value(2'b0),
    .REG2_SW_W__FIELD_0__pulse(1'b0),
    .REG2_SW_W__FIELD_0__curr_value(),
    .REG3_HW__FIELD_3__next_value(2'b0),
    .REG3_HW__FIELD_3__pulse(1'b0),
    .REG3_HW__FIELD_3__curr_value(),
    .REG3_HW__FIELD_2__next_value(2'b0),
    .REG3_HW__FIELD_2__pulse(1'b0),
    .REG3_HW__FIELD_2__curr_value(),
    .REG3_HW__FIELD_1__curr_value(),
    .REG3_HW__FIELD_0__next_value(2'b0),
    .REG3_HW__FIELD_0__pulse(1'b0),
    .REG3_HW__FIELD_0__curr_value(),
    .REG4_PRECEDENCE__FIELD_1__next_value(2'b0),
    .REG4_PRECEDENCE__FIELD_1__pulse(1'b0),
    .REG4_PRECEDENCE__FIELD_1__curr_value(),
    .REG4_PRECEDENCE__FIELD_0__next_value(2'b0),
    .REG4_PRECEDENCE__FIELD_0__pulse(1'b0),
    .REG4_PRECEDENCE__FIELD_0__curr_value(),
    .REG5_SINGLEPULSE__FIELD_0__next_value(1'b0),
    .REG5_SINGLEPULSE__FIELD_0__pulse(1'b0),
    .REG5_SINGLEPULSE__FIELD_0__curr_value(),
    .REG6_SW_ACC_MOD__FIELD_0__next_value(2'b0),
    .REG6_SW_ACC_MOD__FIELD_0__pulse(1'b0),
    .REG6_SW_ACC_MOD__FIELD_0__curr_value(),
    .REG6_SW_ACC_MOD__FIELD_0__swmod_out(),
    .REG6_SW_ACC_MOD__FIELD_0__swacc_out()
);


// module: ext_mem_11 DUT
// bus interface:
//      reg_native_if: regslv_reg_block_1 <-(if[1])-> ext_mem_11
// directly connected upstream:
//      regslv: regslv_reg_block_1
parameter EXT_MEM_11_DATA_WIDTH = EXT_MEM_DATA_WIDTH;
parameter EXT_MEM_11_ADDR_WIDTH = EXT_MEM_ADDR_WIDTH;
parameter EXT_MEM_11_BASE_ADDR = 64'h200;

// convert bus address to external memory address
logic [ADDR_WIDTH-1:0] ext_mem_11__addr;
assign ext_mem_11__addr = regslv_reg_block_1__ext__addr - EXT_MEM_11_BASE_ADDR;

ext_mem #(
    .DATA_WIDTH(EXT_MEM_11_DATA_WIDTH),
    .ADDR_WIDTH(EXT_MEM_11_ADDR_WIDTH))
ext_mem_11 (
    .clk(clk),
    .req_vld(regslv_reg_block_1__ext__req_vld[1]),
    .req_rdy(regslv_reg_block_1__ext__req_rdy[1]),
    .ack_vld(regslv_reg_block_1__ext__ack_vld[1]),
    .ack_rdy(regslv_reg_block_1__ext__ack_rdy),
    .wr_en(regslv_reg_block_1__ext__wr_en),
    .rd_en(regslv_reg_block_1__ext__rd_en),
    .addr(ext_mem_11__addr[EXT_MEM_11_ADDR_WIDTH-1:0]),
    .wr_data(regslv_reg_block_1__ext__wr_data),
    .rd_data(regslv_reg_block_1__ext__rd_data[1])
);


// module: regslv_reg_block_2
// bus interface:
//      reg_native_if: regmst_reg_top <-if[1]-> regslv_reg_block_2
//      reg_native_if: regslv_reg_block_2 <-> downstream external memories
// directly connected upstream:
//      regmst: regmst_reg_top
// directly connected downstream:
//      memory : ext_mem_21, ext_mem_22, ext_mem_23
// other signals:
//      input glb_srst, field srst signals,
//      hardware access ports for internal registers
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

logic reg_block_2__test_21_srst_1;
logic reg_block_2__test_21_srst_2;

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
    .global_sync_reset_out(),
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
    .test_21_REG3_HW__FIELD_1__curr_value(),
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
    .test_21_REG6_SW_ACC_MOD__FIELD_0__swmod_out(),
    .test_21_REG6_SW_ACC_MOD__FIELD_0__swacc_out(),
    .test_22_shared_2__FIELD_0__next_value(32'b0),
    .test_22_shared_2__FIELD_0__pulse(1'b0),
    .test_22_shared_2__FIELD_0__curr_value()
);


// module: ext_mem_21 DUT
// bus interface:
//      reg_native_if: regslv_reg_block_2 <-(if[0])-> ext_mem_21
// directly connected upstream:
//      regslv: regslv_reg_block_2
parameter EXT_MEM_21_DATA_WIDTH = EXT_MEM_DATA_WIDTH;
parameter EXT_MEM_21_ADDR_WIDTH = EXT_MEM_ADDR_WIDTH;
parameter EXT_MEM_21_BASE_ADDR = 64'ha00;

// convert bus address to external memory address
logic [ADDR_WIDTH-1:0] ext_mem_21__addr;
assign ext_mem_21__addr = regslv_reg_block_2__ext__addr - EXT_MEM_21_BASE_ADDR;

ext_mem #(
    .DATA_WIDTH(EXT_MEM_21_DATA_WIDTH),
    .ADDR_WIDTH(EXT_MEM_21_ADDR_WIDTH))
ext_mem_21 (
    .clk(clk),
    .req_vld(regslv_reg_block_2__ext__req_vld[0]),
    .req_rdy(regslv_reg_block_2__ext__req_rdy[0]),
    .ack_vld(regslv_reg_block_2__ext__ack_vld[0]),
    .ack_rdy(regslv_reg_block_2__ext__ack_rdy),
    .wr_en(regslv_reg_block_2__ext__wr_en),
    .rd_en(regslv_reg_block_2__ext__rd_en),
    .addr(ext_mem_21__addr[EXT_MEM_21_ADDR_WIDTH-1:0]),
    .wr_data(regslv_reg_block_2__ext__wr_data),
    .rd_data(regslv_reg_block_2__ext__rd_data[0])
);


// module: ext_mem_22 DUT
// bus interface:
//      reg_native_if: regslv_reg_block_2 <-(if[1])-> ext_mem_22
// directly connected upstream:
//      regslv: regslv_reg_block_2
parameter EXT_MEM_22_DATA_WIDTH = EXT_MEM_DATA_WIDTH;
parameter EXT_MEM_22_ADDR_WIDTH = EXT_MEM_ADDR_WIDTH;
parameter EXT_MEM_22_BASE_ADDR = 64'hb00;

// convert bus address to external memory address
logic [ADDR_WIDTH-1:0] ext_mem_22__addr;
assign ext_mem_22__addr = regslv_reg_block_2__ext__addr - EXT_MEM_22_BASE_ADDR;

ext_mem #(
    .DATA_WIDTH(EXT_MEM_22_DATA_WIDTH),
    .ADDR_WIDTH(EXT_MEM_22_ADDR_WIDTH))
ext_mem_22 (
    .clk(clk),
    .req_vld(regslv_reg_block_2__ext__req_vld[1]),
    .req_rdy(regslv_reg_block_2__ext__req_rdy[1]),
    .ack_vld(regslv_reg_block_2__ext__ack_vld[1]),
    .ack_rdy(regslv_reg_block_2__ext__ack_rdy),
    .wr_en(regslv_reg_block_2__ext__wr_en),
    .rd_en(regslv_reg_block_2__ext__rd_en),
    .addr(ext_mem_21__addr[EXT_MEM_22_ADDR_WIDTH-1:0]),
    .wr_data(regslv_reg_block_2__ext__wr_data),
    .rd_data(regslv_reg_block_2__ext__rd_data[1])
);


// module: ext_mem_23 DUT
// bus interface:
//      reg_native_if: regslv_reg_block_2 <-(if[2])-> ext_mem_23
// directly connected upstream:
//      regslv: regslv_reg_block_2
parameter EXT_MEM_23_DATA_WIDTH = EXT_MEM_DATA_WIDTH;
parameter EXT_MEM_23_ADDR_WIDTH = EXT_MEM_ADDR_WIDTH;
parameter EXT_MEM_23_BASE_ADDR = 64'hc00;

// convert bus address to external memory address
logic [ADDR_WIDTH-1:0] ext_mem_23__addr;
assign ext_mem_23__addr = regslv_reg_block_2__ext__addr - EXT_MEM_23_BASE_ADDR;

ext_mem #(
    .DATA_WIDTH(EXT_MEM_23_DATA_WIDTH),
    .ADDR_WIDTH(EXT_MEM_23_ADDR_WIDTH))
ext_mem_23 (
    .clk(clk),
    .req_vld(regslv_reg_block_2__ext__req_vld[2]),
    .req_rdy(regslv_reg_block_2__ext__req_rdy[2]),
    .ack_vld(regslv_reg_block_2__ext__ack_vld[2]),
    .ack_rdy(regslv_reg_block_2__ext__ack_rdy),
    .wr_en(regslv_reg_block_2__ext__wr_en),
    .rd_en(regslv_reg_block_2__ext__rd_en),
    .addr(ext_mem_23__addr[EXT_MEM_23_ADDR_WIDTH-1:0]),
    .wr_data(regslv_reg_block_2__ext__wr_data),
    .rd_data(regslv_reg_block_2__ext__rd_data[2])
);


// module: ext_mem_in_top DUT
// bus interface:
//      reg_native_if: regmst_reg_top <-(if[2])-> ext_mem_in_top
// directly connected upstream:
//      regmst: regmst_reg_top
parameter EXT_MEM_IN_TOP_DATA_WIDTH = 32;
parameter EXT_MEM_IN_TOP_ADDR_WIDTH = 6;
parameter EXT_MEM_IN_TOP_BASE_ADDR = 64'hd00;

// convert bus address to external memory address
logic [ADDR_WIDTH-1:0] ext_mem_in_top__addr;
assign ext_mem_in_top__addr = mst__ext__addr - EXT_MEM_IN_TOP_BASE_ADDR;

ext_mem #(
    .DATA_WIDTH(EXT_MEM_IN_TOP_DATA_WIDTH),
    .ADDR_WIDTH(EXT_MEM_IN_TOP_ADDR_WIDTH))
ext_mem_in_top (
    .clk(clk),
    .req_vld(mst__ext__req_vld[2]),
    .req_rdy(mst__ext__req_rdy[2]),
    .wr_en(mst__ext__wr_en),
    .rd_en(mst__ext__rd_en),
    .addr(ext_mem_in_top__addr[EXT_MEM_IN_TOP_ADDR_WIDTH-1:0]),
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
    $fsdbDumpfile("regmst_tb.fsdb");
    $fsdbDumpvars(0, regmst_tb);
    $fsdbDumpMDA();
end

// generate 50MHz clock
localparam CLK_PERIOD = 20;
always #(CLK_PERIOD/2) clk = ~clk;

// generate low-active reset signal
initial begin
    clk = 1'b0;
    rstn = 1'b0;
    // deassert reset signal after several clock cycles
    #(CLK_PERIOD*10) rstn = 1;
end

/********************************************************************
********* test stimulus and external memory initialization **********
*********************************************************************/
parameter TOTAL_ACCESS_NUM = 340;

// all external memory entries initialized to 0
initial begin
    for (integer i = 0; i < (1<<EXT_MEM_ADDR_WIDTH); i = i + 1) begin
        ext_mem_11.mem[i] = {EXT_MEM_DATA_WIDTH{1'b0}};
        ext_mem_21.mem[i] = {EXT_MEM_DATA_WIDTH{1'b0}};
        ext_mem_22.mem[i] = {EXT_MEM_DATA_WIDTH{1'b0}};
        ext_mem_23.mem[i] = {EXT_MEM_DATA_WIDTH{1'b0}};
        ext_mem_in_top.mem[i] = {EXT_MEM_DATA_WIDTH{1'b0}};
    end
end

reg [ADDR_WIDTH-1:0] addrs [0:TOTAL_ACCESS_NUM-1];

initial begin
    // all APB input initialized to 0
    PSEL = 1'b0;
    PENABLE = 1'b0;
    PWRITE = 1'b0;
    PADDR = {ADDR_WIDTH{1'b0}};
    PWDATA = {DATA_WIDTH{1'b0}};

    // interrupt clear signal initialized to invalid(0)
    bus__mst__clear = 1'b0;
    // all field synchronous reset signals initialized to invalid(0)
    regslv_test_11__srst_1 = 1'b0;
    regslv_test_11__srst_2 = 1'b0;
    reg_block_2__test_21_srst_1 = 1'b0;
    reg_block_2__test_21_srst_2 = 1'b0;

    // get addresses of internal registers and external memory entries
    $readmemh("tb/regmst_tb_addr_hex.txt", addrs);
end


/********************************************************************
********************* simulate APB interface ************************
*********************************************************************/
initial begin
    wait(rstn);
    #(CLK_PERIOD*2);

    for (integer i = 0; i < TOTAL_ACCESS_NUM; i = i + 1) begin
        // write operation
        @(posedge clk); #1;
        PSEL = 1'b1;
        PENABLE = 1'b0;
        PWRITE = 1'b1;
        PADDR = addrs[i];
        PWDATA = {DATA_WIDTH{1'b1}};
        $display($time, " start write operation: addr=%h data=%h", PADDR, PWDATA);

        @(posedge clk); #1;
        PENABLE = 1'b1;

        wait(PREADY);
        @(posedge clk); #1;
        PSEL = 1'b0;
        $display($time, " end write operation");

        // read operation
        @(posedge clk); #1;
        PSEL = 1'b1;
        PENABLE = 1'b0;
        PWRITE = 1'b0;
        PADDR = addrs[i];
        $display($time, " start read operation: addr=%h", PADDR);

        @(posedge clk); #1;
        PENABLE = 1'b1;

        wait(PREADY);
        #1 $display($time, " end read operation: data=%h", PRDATA);
        @(posedge clk); #1;
        PSEL = 1'b0;
    end

    #(CLK_PERIOD*10);
    $finish;
end

endmodule