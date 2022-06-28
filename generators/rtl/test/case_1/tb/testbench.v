////////////////////////////////////////////////////////////////////////////////
// case 1 testbench:
//      1. APB write and read for multi-layer register tree topology
//      2. clock domain crossing (CDC)
//
// upper bus interface: APB
//      addr width: 32
//      data width: 64
// internal register:
//      entry: 24
//      data width: 32
// 5 external memories:
//      addr width: 6
//      entry: 64
//      data width: 32
//      number of bus access: 64
//  total number of entries: 344
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps

// clock frequency:
//      clk_1 (bus interface and regslv native): 50MHz
//      clk_2 (internal registers): 400MHz
//      clk_3 (external memory): 200MHz
`define CLK_1_PERIOD 20
`define CLK_2_PERIOD 2.5
`define CLK_3_PERIOD 5

module reg_tb;

// bus definition
parameter BUS_ADDR_WIDTH = 64;
parameter BUS_DATA_WIDTH = 32;

// internal register parameters
parameter INT_REG_ENTRY = 24;
parameter INT_REG_DATA_WIDTH = 32;
parameter INT_ACCESS_NUM = 24;

// external memory parameters
parameter EXT_MEM_BLOCK_NUM = 5;
parameter EXT_MEM_ADDR_WIDTH = 6;
parameter EXT_MEM_ENTRY = 1 << EXT_MEM_ADDR_WIDTH;
parameter EXT_MEM_DATA_WIDTH = 32;
parameter EXT_ACCESS_NUM = EXT_MEM_BLOCK_NUM * EXT_MEM_ENTRY;

parameter EXT_MEM_IN_TOP_DATA_WIDTH = EXT_MEM_DATA_WIDTH;
parameter EXT_MEM_IN_TOP_ADDR_WIDTH = EXT_MEM_ADDR_WIDTH;
parameter EXT_MEM_11_DATA_WIDTH = EXT_MEM_DATA_WIDTH;
parameter EXT_MEM_11_ADDR_WIDTH = EXT_MEM_ADDR_WIDTH;
parameter EXT_MEM_21_DATA_WIDTH = EXT_MEM_DATA_WIDTH;
parameter EXT_MEM_21_ADDR_WIDTH = EXT_MEM_ADDR_WIDTH;
parameter EXT_MEM_22_DATA_WIDTH = EXT_MEM_DATA_WIDTH;
parameter EXT_MEM_22_ADDR_WIDTH = EXT_MEM_ADDR_WIDTH;
parameter EXT_MEM_23_DATA_WIDTH = EXT_MEM_DATA_WIDTH;
parameter EXT_MEM_23_ADDR_WIDTH = EXT_MEM_ADDR_WIDTH;

parameter TOTAL_LOGICAL_NUM = INT_ACCESS_NUM + EXT_ACCESS_NUM;

logic [BUS_DATA_WIDTH-1:0] actual_hw_value [0:TOTAL_LOGICAL_NUM-1];

logic clk_1;
logic clk_2;
logic clk_3;
logic rst_1_n;
logic rst_2_n;
logic rst_3_n;

// APB interface
logic PSEL;
logic PENABLE;
logic PREADY;
logic PWRITE;
logic PSLVERR;
logic [BUS_ADDR_WIDTH-1:0] PADDR;
logic [BUS_DATA_WIDTH-1:0] PWDATA;
logic [BUS_DATA_WIDTH-1:0] PRDATA;

// interrupt, clear and sync reset
logic reg_top__bus__interrupt;
logic reg_top__downstream__glb_srst;
logic bus__reg_top__clear;


// module: regmst_reg_top DUT
//      internal register: 0
//      external instance: 3
//      clock: clk_1, clk_3
//
// bus interface:
//      APB interface: testbench stimulus <-> regmst
//      reg_native_if: regmst <-> downstream regslv/external memory
// directly connected upstream:
//      APB interface
// directly connected downstream:
//      regslv: regslv_reg_top__reg_block_1, regslv_reg_top__reg_block_2
//      memory : ext_mem_in_top
// other signals:
//      interrupt, glb_srst, clear
parameter REGMST_REG_TOP_INT_NUM = 0;
parameter REGMST_REG_TOP_EXT_NUM = 3;

logic reg_top__reg_block_1__req_vld;
logic reg_top__reg_block_1__ack_vld;
logic reg_top__reg_block_1__wr_en;
logic reg_top__reg_block_1__rd_en;
logic [BUS_ADDR_WIDTH-1:0] reg_top__reg_block_1__addr;
logic [BUS_DATA_WIDTH-1:0] reg_top__reg_block_1__wr_data;
logic [BUS_DATA_WIDTH-1:0] reg_top__reg_block_1__rd_data;

logic reg_top__reg_block_2__req_vld;
logic reg_top__reg_block_2__ack_vld;
logic reg_top__reg_block_2__wr_en;
logic reg_top__reg_block_2__rd_en;
logic [BUS_ADDR_WIDTH-1:0] reg_top__reg_block_2__addr;
logic [BUS_DATA_WIDTH-1:0] reg_top__reg_block_2__wr_data;
logic [BUS_DATA_WIDTH-1:0] reg_top__reg_block_2__rd_data;

logic reg_top__mem_in_top__req_vld;
logic reg_top__mem_in_top__ack_vld;
logic reg_top__mem_in_top__wr_en;
logic reg_top__mem_in_top__rd_en;
logic [EXT_MEM_IN_TOP_ADDR_WIDTH-1:0] reg_top__mem_in_top__addr;
logic [BUS_DATA_WIDTH-1:0] reg_top__mem_in_top__wr_data;
logic [BUS_DATA_WIDTH-1:0] reg_top__mem_in_top__rd_data;

regmst_reg_top #(
    .ADDR_WIDTH(BUS_ADDR_WIDTH),
    .DATA_WIDTH(BUS_DATA_WIDTH))
regmst_reg_top_dut (
    // downstream ports of reg_block_1
    .reg_top__reg_block_1_req_vld(reg_top__reg_block_1__req_vld),
    .reg_top__reg_block_1_ack_vld(reg_top__reg_block_1__ack_vld),
    .reg_top__reg_block_1_wr_en(reg_top__reg_block_1__wr_en),
    .reg_top__reg_block_1_rd_en(reg_top__reg_block_1__rd_en),
    .reg_top__reg_block_1_addr(reg_top__reg_block_1__addr),
    .reg_top__reg_block_1_wr_data(reg_top__reg_block_1__wr_data),
    .reg_top__reg_block_1_rd_data(reg_top__reg_block_1__rd_data),
    // downstream ports of reg_block_2
    .reg_top__reg_block_2_req_vld(reg_top__reg_block_2__req_vld),
    .reg_top__reg_block_2_ack_vld(reg_top__reg_block_2__ack_vld),
    .reg_top__reg_block_2_wr_en(reg_top__reg_block_2__wr_en),
    .reg_top__reg_block_2_rd_en(reg_top__reg_block_2__rd_en),
    .reg_top__reg_block_2_addr(reg_top__reg_block_2__addr),
    .reg_top__reg_block_2_wr_data(reg_top__reg_block_2__wr_data),
    .reg_top__reg_block_2_rd_data(reg_top__reg_block_2__rd_data),
    // downstream ports of ext_mem_in_top
    .reg_top__ext_mem_in_top_clk(clk_3),
    .reg_top__ext_mem_in_top_rstn(rst_3_n),
    .reg_top__ext_mem_in_top_req_vld(reg_top__mem_in_top__req_vld),
    .reg_top__ext_mem_in_top_ack_vld(reg_top__mem_in_top__ack_vld),
    .reg_top__ext_mem_in_top_wr_en(reg_top__mem_in_top__wr_en),
    .reg_top__ext_mem_in_top_rd_en(reg_top__mem_in_top__rd_en),
    .reg_top__ext_mem_in_top_addr(reg_top__mem_in_top__addr),
    .reg_top__ext_mem_in_top_wr_data(reg_top__mem_in_top__wr_data),
    .reg_top__ext_mem_in_top_rd_data(reg_top__mem_in_top__rd_data),
    // APB interface
    .PCLK(clk_1),
    .PRESETn(rst_1_n),
    .PSEL(PSEL),
    .PENABLE(PENABLE),
    .PREADY(PREADY),
    .PWRITE(PWRITE),
    .PSLVERR(PSLVERR),
    .PADDR(PADDR),
    .PWDATA(PWDATA),
    .PRDATA(PRDATA),
    // interrupt, clear and synchronous reset signals
    .clear(bus__reg_top__clear),
    .interrupt(reg_top__bus__interrupt),
    .soft_rst_o(reg_top__downstream__glb_srst)
);


// module: regslv_reg_top__reg_block_1 DUT
//      internal register: 2
//      external instance: 8
//      clock: clk_1, clk_3
//
// bus interface:
//      reg_native_if: regmst_reg_top <-if[0]-> regslv_reg_top__reg_block_1
//      reg_native_if: regslv_reg_top__reg_block_1 <-> downstream regslv/external memory
// directly connected upstream:
//      regmst: regmst_reg_top
// directly connected downstream:
//      regslv: regslv_reg_top__reg_block_1__test_11
//      memory : ext_mem_11
// other signals:
//      input glb_srst, output glb_srst,
//      hardware access ports for internal registers
parameter REGSLV_REG_BLOCK_1_EXT_NUM = 2;
parameter REGSLV_REG_BLOCK_1_INT_NUM = 8;

logic [REGSLV_REG_BLOCK_1_EXT_NUM-1:0] regslv_reg_top__reg_block_1__ext__req_vld;
logic [REGSLV_REG_BLOCK_1_EXT_NUM-1:0] regslv_reg_top__reg_block_1__ext__ack_vld;
logic [REGSLV_REG_BLOCK_1_EXT_NUM-1:0] regslv_reg_top__reg_block_1__ext__wr_en;
logic [REGSLV_REG_BLOCK_1_EXT_NUM-1:0] regslv_reg_top__reg_block_1__ext__rd_en;
logic [REGSLV_REG_BLOCK_1_EXT_NUM-1:0] [BUS_ADDR_WIDTH-1:0] regslv_reg_top__reg_block_1__ext__addr;
logic [REGSLV_REG_BLOCK_1_EXT_NUM-1:0] [BUS_DATA_WIDTH-1:0] regslv_reg_top__reg_block_1__ext__wr_data;
logic [REGSLV_REG_BLOCK_1_EXT_NUM-1:0] [BUS_DATA_WIDTH-1:0] regslv_reg_top__reg_block_1__ext__rd_data;

logic regslv_reg_top__reg_block_1__ext__glb_srst;

regslv_reg_top__reg_block_1 #(
    .ADDR_WIDTH(BUS_ADDR_WIDTH),
    .DATA_WIDTH(BUS_DATA_WIDTH))
regslv_reg_top__reg_block_1_dut (
    // downstream ports of test_11
    .reg_top__reg_block_1__test_11_req_vld(regslv_reg_top__reg_block_1__ext__req_vld[0]),
    .reg_top__reg_block_1__test_11_ack_vld(regslv_reg_top__reg_block_1__ext__ack_vld[0]),
    .reg_top__reg_block_1__test_11_wr_en(regslv_reg_top__reg_block_1__ext__wr_en[0]),
    .reg_top__reg_block_1__test_11_rd_en(regslv_reg_top__reg_block_1__ext__rd_en[0]),
    .reg_top__reg_block_1__test_11_addr(regslv_reg_top__reg_block_1__ext__addr[0]),
    .reg_top__reg_block_1__test_11_wr_data(regslv_reg_top__reg_block_1__ext__wr_data[0]),
    .reg_top__reg_block_1__test_11_rd_data(regslv_reg_top__reg_block_1__ext__rd_data[0]),
    // downstream ports of ext_mem_11
    .reg_top__reg_block_1__ext_mem_11_clk(clk_3),
    .reg_top__reg_block_1__ext_mem_11_rstn(rst_3_n),
    .reg_top__reg_block_1__ext_mem_11_req_vld(regslv_reg_top__reg_block_1__ext__req_vld[1]),
    .reg_top__reg_block_1__ext_mem_11_ack_vld(regslv_reg_top__reg_block_1__ext__ack_vld[1]),
    .reg_top__reg_block_1__ext_mem_11_wr_en(regslv_reg_top__reg_block_1__ext__wr_en[1]),
    .reg_top__reg_block_1__ext_mem_11_rd_en(regslv_reg_top__reg_block_1__ext__rd_en[1]),
    .reg_top__reg_block_1__ext_mem_11_addr(regslv_reg_top__reg_block_1__ext__addr[1][EXT_MEM_11_ADDR_WIDTH-1:0]),
    .reg_top__reg_block_1__ext_mem_11_wr_data(regslv_reg_top__reg_block_1__ext__wr_data[1]),
    .reg_top__reg_block_1__ext_mem_11_rd_data(regslv_reg_top__reg_block_1__ext__rd_data[1]),
    // hardware access input ports
    .regfile_clk(clk_2),
    .regfile_rstn(rst_2_n),
    .test_12_REG1__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_12_REG1__FIELD_0__pulse(1'b0),
    .test_12_REG1__FIELD_0__curr_value(actual_hw_value[4]),
    .test_12_REG2__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_12_REG2__FIELD_0__pulse(1'b0),
    .test_12_REG2__FIELD_0__curr_value(actual_hw_value[5]),
    .test_12_REG3__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_12_REG3__FIELD_0__pulse(1'b0),
    .test_12_REG3__FIELD_0__curr_value(actual_hw_value[6]),
    .test_12_REG4__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_12_REG4__FIELD_0__pulse(1'b0),
    .test_12_REG4__FIELD_0__curr_value(actual_hw_value[7]),
    .test_13_REG1__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_13_REG1__FIELD_0__pulse(1'b0),
    .test_13_REG1__FIELD_0__curr_value(actual_hw_value[8]),
    .test_13_REG2__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_13_REG2__FIELD_0__pulse(1'b0),
    .test_13_REG2__FIELD_0__curr_value(actual_hw_value[9]),
    .test_13_REG3__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_13_REG3__FIELD_0__pulse(1'b0),
    .test_13_REG3__FIELD_0__curr_value(actual_hw_value[10]),
    .test_13_REG4__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_13_REG4__FIELD_0__pulse(1'b0),
    .test_13_REG4__FIELD_0__curr_value(actual_hw_value[11]),
    // upstream reg_native_if (from regmst_reg_top)
    .fsm_clk(clk_1),
    .fsm_rstn(rst_1_n),
    .req_vld(reg_top__reg_block_1__req_vld),
    .ack_vld(reg_top__reg_block_1__ack_vld),
    .wr_en(reg_top__reg_block_1__wr_en),
    .rd_en(reg_top__reg_block_1__rd_en),
    .addr(reg_top__reg_block_1__addr),
    .wr_data(reg_top__reg_block_1__wr_data),
    .rd_data(reg_top__reg_block_1__rd_data),
    // synchronous reset signals
    .soft_rst(reg_top__downstream__glb_srst),
    .soft_rst_o(regslv_reg_top__reg_block_1__ext__glb_srst)
);


// module: regslv_reg_top__reg_block_1__test_11 DUT
//      internal register: 4
//      external instance: 0
//      clock: clk_1, clk_3
//
// bus interface:
//      reg_native_if: regslv_reg_top__reg_block_1 <-(if[0])-> regslv_reg_top__reg_block_1__test_11
// directly connected upstream:
//      regslv: regslv_reg_top__reg_block_1
// other signals:
//      input glb_srst, field srst signals
parameter REGSLV_TEST_11_EXT_NUM = 0;
parameter REGSLV_TEST_11_INT_NUM = 4;

regslv_reg_top__reg_block_1__test_11 #(
    .ADDR_WIDTH(BUS_ADDR_WIDTH),
    .DATA_WIDTH(BUS_DATA_WIDTH))
regslv_reg_top__reg_block_1__test_11_dut (
    .regfile_clk(clk_2),
    .regfile_rstn(rst_2_n),
    // hardware access ports
    .REG1__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .REG1__FIELD_0__pulse(1'b0),
    .REG1__FIELD_0__curr_value(actual_hw_value[0]),
    .REG2__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .REG2__FIELD_0__pulse(1'b0),
    .REG2__FIELD_0__curr_value(actual_hw_value[1]),
    .REG3__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .REG3__FIELD_0__pulse(1'b0),
    .REG3__FIELD_0__curr_value(actual_hw_value[2]),
    .REG4__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .REG4__FIELD_0__pulse(1'b0),
    .REG4__FIELD_0__curr_value(actual_hw_value[3]),
    // upstream reg_native_if
    .fsm_clk(clk_1),
    .fsm_rstn(rst_1_n),
    .req_vld(regslv_reg_top__reg_block_1__ext__req_vld[0]),
    .ack_vld(regslv_reg_top__reg_block_1__ext__ack_vld[0]),
    .wr_en(regslv_reg_top__reg_block_1__ext__wr_en[0]),
    .rd_en(regslv_reg_top__reg_block_1__ext__rd_en[0]),
    .addr(regslv_reg_top__reg_block_1__ext__addr[0]),
    .wr_data(regslv_reg_top__reg_block_1__ext__wr_data[0]),
    .rd_data(regslv_reg_top__reg_block_1__ext__rd_data[0]),
    // synchronous reset signals
    .soft_rst(regslv_reg_top__reg_block_1__ext__glb_srst),
    .soft_rst_o()
);


// module: ext_mem_11 DUT
//      entry: 64
//      width: 32
//      clk: clk_3
//
// bus interface:
//      reg_native_if: regslv_reg_top__reg_block_1 <-(if[1])-> ext_mem_11
// directly connected upstream:
//      regslv: regslv_reg_top__reg_block_1
ext_mem #(
    .DATA_WIDTH(EXT_MEM_11_DATA_WIDTH),
    .ADDR_WIDTH(EXT_MEM_11_ADDR_WIDTH))
ext_mem_11 (
    .clk(clk_3),
    .req_vld(regslv_reg_top__reg_block_1__ext__req_vld[1]),
    .ack_vld(regslv_reg_top__reg_block_1__ext__ack_vld[1]),
    .wr_en(regslv_reg_top__reg_block_1__ext__wr_en[1]),
    .rd_en(regslv_reg_top__reg_block_1__ext__rd_en[1]),
    .addr(regslv_reg_top__reg_block_1__ext__addr[1][EXT_MEM_11_ADDR_WIDTH-1:0]),
    .wr_data(regslv_reg_top__reg_block_1__ext__wr_data[1]),
    .rd_data(regslv_reg_top__reg_block_1__ext__rd_data[1])
);


// module: regslv_reg_top__reg_block_2
//      internal register: 12
//      external instance: 3
//      clock: clk_1, clk_3
//
// bus interface:
//      reg_native_if: regmst_reg_top <-if[1]-> regslv_reg_top__reg_block_2
//      reg_native_if: regslv_reg_top__reg_block_2 <-> downstream external memories
// directly connected upstream:
//      regmst: regmst_reg_top
// directly connected downstream:
//      memory : ext_mem_21, ext_mem_22, ext_mem_23
// other signals:
//      input glb_srst, field srst signals,
//      hardware access ports for internal registers
parameter REG_BLOCK_2_EXT_NUM = 3;
parameter REG_BLOCK_2_INT_NUM = 12;

logic [REG_BLOCK_2_EXT_NUM-1:0] regslv_reg_top__reg_block_2__ext__req_vld;
logic [REG_BLOCK_2_EXT_NUM-1:0] regslv_reg_top__reg_block_2__ext__ack_vld;
logic [REG_BLOCK_2_EXT_NUM-1:0] regslv_reg_top__reg_block_2__ext__wr_en;
logic [REG_BLOCK_2_EXT_NUM-1:0] regslv_reg_top__reg_block_2__ext__rd_en;
logic [REG_BLOCK_2_EXT_NUM-1:0] [BUS_ADDR_WIDTH-1:0] regslv_reg_top__reg_block_2__ext__addr;
logic [REG_BLOCK_2_EXT_NUM-1:0] [BUS_DATA_WIDTH-1:0] regslv_reg_top__reg_block_2__ext__wr_data;
logic [REG_BLOCK_2_EXT_NUM-1:0] [BUS_DATA_WIDTH-1:0] regslv_reg_top__reg_block_2__ext__rd_data;

regslv_reg_top__reg_block_2 #(
    .ADDR_WIDTH(BUS_ADDR_WIDTH),
    .DATA_WIDTH(BUS_DATA_WIDTH))
regslv_reg_top__reg_block_2_dut (
    // external memory reg_native_if with CDC done
    // ports of ext_mem_21
    .reg_top__reg_block_2__ext_mem_21_clk(clk_3),
    .reg_top__reg_block_2__ext_mem_21_rstn(rst_3_n),
    .reg_top__reg_block_2__ext_mem_21_req_vld(regslv_reg_top__reg_block_2__ext__req_vld[0]),
    .reg_top__reg_block_2__ext_mem_21_ack_vld(regslv_reg_top__reg_block_2__ext__ack_vld[0]),
    .reg_top__reg_block_2__ext_mem_21_wr_en(regslv_reg_top__reg_block_2__ext__wr_en[0]),
    .reg_top__reg_block_2__ext_mem_21_rd_en(regslv_reg_top__reg_block_2__ext__rd_en[0]),
    .reg_top__reg_block_2__ext_mem_21_addr(regslv_reg_top__reg_block_2__ext__addr[0][EXT_MEM_21_ADDR_WIDTH-1:0]),
    .reg_top__reg_block_2__ext_mem_21_wr_data(regslv_reg_top__reg_block_2__ext__wr_data[0]),
    .reg_top__reg_block_2__ext_mem_21_rd_data(regslv_reg_top__reg_block_2__ext__rd_data[0]),
    // ports of ext_mem_22
    .reg_top__reg_block_2__ext_mem_22_clk(clk_3),
    .reg_top__reg_block_2__ext_mem_22_rstn(rst_3_n),
    .reg_top__reg_block_2__ext_mem_22_req_vld(regslv_reg_top__reg_block_2__ext__req_vld[1]),
    .reg_top__reg_block_2__ext_mem_22_ack_vld(regslv_reg_top__reg_block_2__ext__ack_vld[1]),
    .reg_top__reg_block_2__ext_mem_22_wr_en(regslv_reg_top__reg_block_2__ext__wr_en[1]),
    .reg_top__reg_block_2__ext_mem_22_rd_en(regslv_reg_top__reg_block_2__ext__rd_en[1]),
    .reg_top__reg_block_2__ext_mem_22_addr(regslv_reg_top__reg_block_2__ext__addr[1][EXT_MEM_22_ADDR_WIDTH-1:0]),
    .reg_top__reg_block_2__ext_mem_22_wr_data(regslv_reg_top__reg_block_2__ext__wr_data[1]),
    .reg_top__reg_block_2__ext_mem_22_rd_data(regslv_reg_top__reg_block_2__ext__rd_data[1]),
    // ports of ext_mem_23
    .reg_top__reg_block_2__ext_mem_23_clk(clk_3),
    .reg_top__reg_block_2__ext_mem_23_rstn(rst_3_n),
    .reg_top__reg_block_2__ext_mem_23_req_vld(regslv_reg_top__reg_block_2__ext__req_vld[2]),
    .reg_top__reg_block_2__ext_mem_23_ack_vld(regslv_reg_top__reg_block_2__ext__ack_vld[2]),
    .reg_top__reg_block_2__ext_mem_23_wr_en(regslv_reg_top__reg_block_2__ext__wr_en[2]),
    .reg_top__reg_block_2__ext_mem_23_rd_en(regslv_reg_top__reg_block_2__ext__rd_en[2]),
    .reg_top__reg_block_2__ext_mem_23_addr(regslv_reg_top__reg_block_2__ext__addr[2][EXT_MEM_23_ADDR_WIDTH-1:0]),
    .reg_top__reg_block_2__ext_mem_23_wr_data(regslv_reg_top__reg_block_2__ext__wr_data[2]),
    .reg_top__reg_block_2__ext_mem_23_rd_data(regslv_reg_top__reg_block_2__ext__rd_data[2]),
    // hardware access input ports
    .regfile_clk(clk_2),
    .regfile_rstn(rst_2_n),
    .test_21_REG1__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_21_REG1__FIELD_0__pulse(1'b0),
    .test_21_REG1__FIELD_0__curr_value(actual_hw_value[76]),
    .test_21_REG2__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_21_REG2__FIELD_0__pulse(1'b0),
    .test_21_REG2__FIELD_0__curr_value(actual_hw_value[77]),
    .test_21_REG3__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_21_REG3__FIELD_0__pulse(1'b0),
    .test_21_REG3__FIELD_0__curr_value(actual_hw_value[78]),
    .test_21_REG4__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_21_REG4__FIELD_0__pulse(1'b0),
    .test_21_REG4__FIELD_0__curr_value(actual_hw_value[79]),
    .test_22_REG1__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_22_REG1__FIELD_0__pulse(1'b0),
    .test_22_REG1__FIELD_0__curr_value(actual_hw_value[80]),
    .test_22_REG2__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_22_REG2__FIELD_0__pulse(1'b0),
    .test_22_REG2__FIELD_0__curr_value(actual_hw_value[81]),
    .test_22_REG3__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_22_REG3__FIELD_0__pulse(1'b0),
    .test_22_REG3__FIELD_0__curr_value(actual_hw_value[82]),
    .test_22_REG4__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_22_REG4__FIELD_0__pulse(1'b0),
    .test_22_REG4__FIELD_0__curr_value(actual_hw_value[83]),
    .test_23_REG1__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_23_REG1__FIELD_0__pulse(1'b0),
    .test_23_REG1__FIELD_0__curr_value(actual_hw_value[84]),
    .test_23_REG2__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_23_REG2__FIELD_0__pulse(1'b0),
    .test_23_REG2__FIELD_0__curr_value(actual_hw_value[85]),
    .test_23_REG3__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_23_REG3__FIELD_0__pulse(1'b0),
    .test_23_REG3__FIELD_0__curr_value(actual_hw_value[86]),
    .test_23_REG4__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .test_23_REG4__FIELD_0__pulse(1'b0),
    .test_23_REG4__FIELD_0__curr_value(actual_hw_value[87]),
    // upstream reg_native_if (from regmst_reg_top)
    .fsm_clk(clk_1),
    .fsm_rstn(rst_1_n),
    .req_vld(reg_top__reg_block_2__req_vld),
    .ack_vld(reg_top__reg_block_2__ack_vld),
    .wr_en(reg_top__reg_block_2__wr_en),
    .rd_en(reg_top__reg_block_2__rd_en),
    .addr(reg_top__reg_block_2__addr),
    .wr_data(reg_top__reg_block_2__wr_data),
    .rd_data(reg_top__reg_block_2__rd_data),
    // synchronous reset signals
    .soft_rst(reg_top__downstream__glb_srst),
    .soft_rst_o()
);


// module: ext_mem_21 DUT
//      entry: 64
//      width: 32
//      clk: clk_3
//
// bus interface:
//      reg_native_if: regslv_reg_top__reg_block_2 <-(if[0])-> ext_mem_21
// directly connected upstream:
//      regslv: regslv_reg_top__reg_block_2
ext_mem #(
    .DATA_WIDTH(EXT_MEM_21_DATA_WIDTH),
    .ADDR_WIDTH(EXT_MEM_21_ADDR_WIDTH))
ext_mem_21 (
    .clk(clk_3),
    .req_vld(regslv_reg_top__reg_block_2__ext__req_vld[0]),
    .ack_vld(regslv_reg_top__reg_block_2__ext__ack_vld[0]),
    .wr_en(regslv_reg_top__reg_block_2__ext__wr_en[0]),
    .rd_en(regslv_reg_top__reg_block_2__ext__rd_en[0]),
    .addr(regslv_reg_top__reg_block_2__ext__addr[0][EXT_MEM_21_ADDR_WIDTH-1:0]),
    .wr_data(regslv_reg_top__reg_block_2__ext__wr_data[0]),
    .rd_data(regslv_reg_top__reg_block_2__ext__rd_data[0])
);


// module: ext_mem_22 DUT
//      entry: 64
//      width: 32
//      clk: clk_3
//
// bus interface:
//      reg_native_if: regslv_reg_top__reg_block_2 <-(if[1])-> ext_mem_22
// directly connected upstream:
//      regslv: regslv_reg_top__reg_block_2
ext_mem #(
    .DATA_WIDTH(EXT_MEM_22_DATA_WIDTH),
    .ADDR_WIDTH(EXT_MEM_22_ADDR_WIDTH))
ext_mem_22 (
    .clk(clk_3),
    .req_vld(regslv_reg_top__reg_block_2__ext__req_vld[1]),
    .ack_vld(regslv_reg_top__reg_block_2__ext__ack_vld[1]),
    .wr_en(regslv_reg_top__reg_block_2__ext__wr_en[1]),
    .rd_en(regslv_reg_top__reg_block_2__ext__rd_en[1]),
    .addr(regslv_reg_top__reg_block_2__ext__addr[1][EXT_MEM_22_ADDR_WIDTH-1:0]),
    .wr_data(regslv_reg_top__reg_block_2__ext__wr_data[1]),
    .rd_data(regslv_reg_top__reg_block_2__ext__rd_data[1])
);


// module: ext_mem_23 DUT
//      entry: 64
//      width: 32
//      clk: clk_3
//
// bus interface:
//      reg_native_if: regslv_reg_top__reg_block_2 <-(if[2])-> ext_mem_23
// directly connected upstream:
//      regslv: regslv_reg_top__reg_block_2
// NOTE: this memory never asserts ack_vld, thus cause timeout error
ext_mem #(
    .DATA_WIDTH(EXT_MEM_23_DATA_WIDTH),
    .ADDR_WIDTH(EXT_MEM_23_ADDR_WIDTH),
    .DEBUG_ERR(1))
ext_mem_23 (
    .clk(clk_3),
    .req_vld(regslv_reg_top__reg_block_2__ext__req_vld[2]),
    .ack_vld(regslv_reg_top__reg_block_2__ext__ack_vld[2]),
    .wr_en(regslv_reg_top__reg_block_2__ext__wr_en[2]),
    .rd_en(regslv_reg_top__reg_block_2__ext__rd_en[2]),
    .addr(regslv_reg_top__reg_block_2__ext__addr[2][EXT_MEM_23_ADDR_WIDTH-1:0]),
    .wr_data(regslv_reg_top__reg_block_2__ext__wr_data[2]),
    .rd_data(regslv_reg_top__reg_block_2__ext__rd_data[2])
);


// module: ext_mem_in_top DUT
//      entry: 64
//      width: 32
//      clk: clk_3
//
// bus interface:
//      reg_native_if: regmst_reg_top <-(if[2])-> ext_mem_in_top
// directly connected upstream:
//      regmst: regmst_reg_top
ext_mem #(
    .DATA_WIDTH(EXT_MEM_IN_TOP_DATA_WIDTH),
    .ADDR_WIDTH(EXT_MEM_IN_TOP_ADDR_WIDTH))
ext_mem_in_top (
    .clk(clk_3),
    .req_vld(reg_top__mem_in_top__req_vld),
    .ack_vld(reg_top__mem_in_top__ack_vld),
    .wr_en(reg_top__mem_in_top__wr_en),
    .rd_en(reg_top__mem_in_top__rd_en),
    .addr(reg_top__mem_in_top__addr),
    .wr_data(reg_top__mem_in_top__wr_data),
    .rd_data(reg_top__mem_in_top__rd_data)
);



/********************************************************************
*********************** simulation process **************************
*********************************************************************/

// dump simulation files
initial begin
    $fsdbDumpfile("reg_tb.fsdb");
    $fsdbDumpvars(0, reg_tb);
    $fsdbDumpMDA();
end

// generate different clock domains
always #(`CLK_1_PERIOD/2) clk_1 = ~clk_1;
always #(`CLK_2_PERIOD/2) clk_2 = ~clk_2;
always #(`CLK_3_PERIOD/2) clk_3 = ~clk_3;

// generate low-active asynchronous reset signals
initial begin
    clk_1 = 1'b0;
    clk_2 = 1'b0;
    clk_3 = 1'b0;
    rst_1_n = 1'b0;
    rst_2_n = 1'b0;
    rst_3_n = 1'b0;
    // deassert reset signals after several clk_1 cycles
    #(`CLK_1_PERIOD*10);
    rst_1_n = 1'b1;
    rst_2_n = 1'b1;
    rst_3_n = 1'b1;
end

/********************************************************************
********* test stimulus and external memory initialization **********
*********************************************************************/
// all external memory entries initialized to 0
initial begin
    for (integer i = 0; i < EXT_MEM_ENTRY; i = i + 1) begin
        ext_mem_11.mem[i] = {EXT_MEM_DATA_WIDTH{1'b0}};
        ext_mem_21.mem[i] = {EXT_MEM_DATA_WIDTH{1'b0}};
        ext_mem_22.mem[i] = {EXT_MEM_DATA_WIDTH{1'b0}};
        ext_mem_23.mem[i] = {EXT_MEM_DATA_WIDTH{1'b0}};
        ext_mem_in_top.mem[i] = {EXT_MEM_DATA_WIDTH{1'b0}};
    end
end

always @(*) begin
    for (integer i = 0; i < EXT_MEM_ENTRY; i = i + 1) begin
        actual_hw_value[12+i] = ext_mem_11.mem[i];
        actual_hw_value[88+i] = ext_mem_21.mem[i];
        actual_hw_value[152+i] = ext_mem_22.mem[i];
        actual_hw_value[216+i] = ext_mem_23.mem[i];
        actual_hw_value[280+i] = ext_mem_in_top.mem[i];
    end
end

reg [BUS_ADDR_WIDTH-1:0] addrs [0:TOTAL_LOGICAL_NUM-1];
reg [BUS_DATA_WIDTH-1:0] expected_hw_value [0:TOTAL_LOGICAL_NUM-1];
reg [BUS_DATA_WIDTH-1:0] expected_read_value [0:TOTAL_LOGICAL_NUM-1];

initial begin
    // all APB input initialized to 0
    PSEL = 1'b0;
    PENABLE = 1'b0;
    PWRITE = 1'b0;
    PADDR = {BUS_ADDR_WIDTH{1'b0}};
    PWDATA = {BUS_DATA_WIDTH{1'b0}};

    // interrupt clear signal initialized to invalid(0)
    bus__reg_top__clear = 1'b0;

    // get addresses, expected hardware value and read value of internal registers
    $readmemh("tb/access_addr_hex.txt", addrs);
    $readmemh("tb/expected_hw_value_hex.txt", expected_hw_value);
    $readmemh("tb/expected_read_value_hex.txt", expected_read_value);
end


/********************************************************************
********************* simulate APB interface ************************
*********************************************************************/
integer err_cnt;

task apb_write_no_gap (
    input [BUS_ADDR_WIDTH-1:0] wr_addr,
    input [BUS_DATA_WIDTH-1:0] wr_data);

    PSEL = 1'b1;
    PENABLE = 1'b0;
    PWRITE = 1'b1;
    PADDR = wr_addr;
    PWDATA = wr_data;
    $display($time, " start write operation: addr=%h data=%h", PADDR, PWDATA);

    @(posedge clk_1); #(`CLK_1_PERIOD*0.1);
    PENABLE = 1'b1;

    wait(PREADY);
    @(posedge clk_1); #(`CLK_1_PERIOD*0.1);
    PSEL = 1'b0;
    $display($time, " end write operation");
endtask

task apb_read_no_gap (
    input [BUS_ADDR_WIDTH-1:0] rd_addr,
    input [BUS_DATA_WIDTH-1:0] expected_val);

    PSEL = 1'b1;
    PENABLE = 1'b0;
    PWRITE = 1'b0;
    PADDR = rd_addr;
    $display($time, " start read operation: addr=%h", PADDR);

    @(posedge clk_1); #(`CLK_1_PERIOD*0.1);
    PENABLE = 1'b1;

    wait(PREADY);
    #(`CLK_1_PERIOD*0.1); $display($time, " read data=%h", PRDATA);
    if (PRDATA !== expected_val) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: access addr=%h, expected=%h, actual=%h",
                 err_cnt, PADDR, expected_val, PRDATA);
    end

    @(posedge clk_1); #(`CLK_1_PERIOD*0.1);
    PSEL = 1'b0;
    $display($time, " end read operation");
endtask

task hw_reg_write (
    input [INT_REG_DATA_WIDTH-1:0] val,
    ref pulse,
    ref [INT_REG_DATA_WIDTH-1:0] hw_acc_port);

    @(posedge clk_2); #(`CLK_2_PERIOD*0.1);
    hw_acc_port = val;
    pulse = 1'b1;

    @(posedge clk_2); #(`CLK_2_PERIOD*0.1);
    pulse = 1'b0;
endtask

initial begin: APB_OPS
    err_cnt = 0;
    wait(rst_1_n);
    wait(rst_2_n);
    wait(rst_3_n);

    @(posedge clk_1); #(`CLK_1_PERIOD*0.1);

    // continous APB write and read operations
    $display($time, " start continous APB operations");
    for (integer i = 0; i < TOTAL_LOGICAL_NUM; i = i + 1) begin
        // APB write operation
        // NOTE: test write data can be arbitrary
        apb_write_no_gap(addrs[i], addrs[i][BUS_DATA_WIDTH-1:0]);
        if (expected_hw_value[i] !== actual_hw_value[i]) begin
            err_cnt = err_cnt + 1;
            $display($time, " error %1d: write addr=%h, expected=%h, actual=%h",
                     err_cnt, PADDR, expected_hw_value[i], actual_hw_value[i]);
        end

        // APB read operation
        // NOTE: there is no gap between write and read operation
        apb_read_no_gap(addrs[i], expected_read_value[i]);
    end


    $display("test process done, error count: %1d", err_cnt);
    #(`CLK_1_PERIOD*2);
    if (err_cnt != 0) begin
        $error("test aborted due to errors");
    end
    $finish;
end

always begin: TIMEOUT_HANDLE
    wait(PSLVERR);
    $display($time, " timeout event occurs, pslverr asserted");
    wait(reg_top__bus__interrupt);
    $display($time, " interrupt signal asserted");

    #(`CLK_1_PERIOD*5);
    @(posedge clk_1); #(`CLK_1_PERIOD*0.1);
    bus__reg_top__clear = 1'b1;

    @(posedge clk_1); #(`CLK_1_PERIOD*0.1);
    bus__reg_top__clear = 1'b0;

    if (reg_top__bus__interrupt) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: interrupt signal is not cleared",
                 err_cnt);
    end
end

endmodule