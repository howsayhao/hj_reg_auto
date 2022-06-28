////////////////////////////////////////////////////////////////////////////////
// case 5 testbench:
//      alias and shared registers
//
// upper bus interface: APB
//      addr width: 32
//      data width: 64
// internal register:
//      entry: 2 physical, 22 logical
//      data width: 32
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps

// clock frequency:
//      clk (bus interface and regslv native): 50MHz
`define CLK_PERIOD 20

module reg_tb;

// bus definition
parameter BUS_ADDR_WIDTH = 64;
parameter BUS_DATA_WIDTH = 32;

// internal register parameters
parameter INT_REG_ENTRY = 2;
parameter INT_REG_DATA_WIDTH = 32;
parameter INT_ACCESS_NUM = 22;

parameter TOTAL_LOGICAL_NUM = 22;
parameter TOTAL_PHYSICAL_NUM = 2;

logic [BUS_DATA_WIDTH-1:0] actual_hw_value [0:TOTAL_PHYSICAL_NUM-1];

logic clk;
logic rst_n;

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
logic srst_1, srst_2;


// module: regmst_reg_top DUT
//      internal register: 0
//      external instance: 1
//      clock: clk
//
// bus interface:
//      APB interface: testbench stimulus <-> regmst
//      reg_native_if: regmst <-> regslv_reg_top__reg_block_1
// directly connected upstream:
//      APB interface
// directly connected downstream:
//      regslv: regslv_reg_top__reg_block_1
// other signals:
//      interrupt, glb_srst, clear
parameter REGMST_REG_TOP_INT_NUM = 0;
parameter REGMST_REG_TOP_EXT_NUM = 1;

logic reg_top__reg_block_1__req_vld;
logic reg_top__reg_block_1__ack_vld;
logic reg_top__reg_block_1__wr_en;
logic reg_top__reg_block_1__rd_en;
logic [BUS_ADDR_WIDTH-1:0] reg_top__reg_block_1__addr;
logic [BUS_DATA_WIDTH-1:0] reg_top__reg_block_1__wr_data;
logic [BUS_DATA_WIDTH-1:0] reg_top__reg_block_1__rd_data;

regmst_reg_top #(
    .ADDR_WIDTH(BUS_ADDR_WIDTH),
    .DATA_WIDTH(BUS_DATA_WIDTH))
regmst_reg_top_dut (
    // reg_native_if connected to the downstream regslv
    .reg_top__reg_block_1_req_vld(reg_top__reg_block_1__req_vld),
    .reg_top__reg_block_1_ack_vld(reg_top__reg_block_1__ack_vld),
    .reg_top__reg_block_1_wr_en(reg_top__reg_block_1__wr_en),
    .reg_top__reg_block_1_rd_en(reg_top__reg_block_1__rd_en),
    .reg_top__reg_block_1_addr(reg_top__reg_block_1__addr),
    .reg_top__reg_block_1_wr_data(reg_top__reg_block_1__wr_data),
    .reg_top__reg_block_1_rd_data(reg_top__reg_block_1__rd_data),
    // APB interface
    .PCLK(clk),
    .PRESETn(rst_n),
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
//      internal register: 2 physical, 22 logical
//      external instance: 0
//      clock: clk
//
// bus interface:
//      reg_native_if: regmst_reg_top <-> regslv_reg_top__reg_block_1
// directly connected upstream:
//      regmst: regmst_reg_top
// other signals:
//      input glb_srst,
//      hardware access ports for internal registers
parameter REGSLV_REG_BLOCK_1_EXT_NUM = 0;
parameter REGSLV_REG_BLOCK_1_INT_NUM = 22;

logic [INT_REG_DATA_WIDTH-1:0] test_2_shared_21__FIELD_0__next_value;
logic test_2_shared_21__FIELD_0__pulse;

regslv_reg_top__reg_block_1 #(
    .ADDR_WIDTH(BUS_ADDR_WIDTH),
    .DATA_WIDTH(BUS_DATA_WIDTH))
regslv_reg_top__reg_block_1_dut (
    // hardware access input ports
    .REG1__FIELD_0__next_value({INT_REG_DATA_WIDTH{1'b0}}),
    .REG1__FIELD_0__pulse(1'b0),
    .REG1__FIELD_0__curr_value(actual_hw_value[0]),
    .test_2_shared_21__FIELD_0__next_value(test_2_shared_21__FIELD_0__next_value),
    .test_2_shared_21__FIELD_0__pulse(test_2_shared_21__FIELD_0__pulse),
    .test_2_shared_21__FIELD_0__curr_value(actual_hw_value[1]),
    // clock and reset
    .fsm_clk(clk),
    .fsm_rstn(rst_n),
    // upstream reg_native_if
    .req_vld(reg_top__reg_block_1__req_vld),
    .ack_vld(reg_top__reg_block_1__ack_vld),
    .wr_en(reg_top__reg_block_1__wr_en),
    .rd_en(reg_top__reg_block_1__rd_en),
    .addr(reg_top__reg_block_1__addr),
    .wr_data(reg_top__reg_block_1__wr_data),
    .rd_data(reg_top__reg_block_1__rd_data),
    // synchronous reset signals
    .soft_rst(reg_top__downstream__glb_srst),
    .soft_rst_o(),
    .srst_1(srst_1),
    .srst_2(srst_2)
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

// generate 50MHz clock
always #(`CLK_PERIOD/2) clk = ~clk;

// generate low-active reset signal
initial begin
    clk = 1'b0;
    rst_n = 1'b0;
    // deassert reset signal after several clock cycles
    #(`CLK_PERIOD*10) rst_n = 1;
end


/********************************************************************
******************* test stimulus initialization ********************
*********************************************************************/
reg [BUS_ADDR_WIDTH-1:0] addrs [0:TOTAL_LOGICAL_NUM-1];
reg [BUS_DATA_WIDTH-1:0] expected_hw_value [0:(TOTAL_LOGICAL_NUM)*3-1+2];
reg [BUS_DATA_WIDTH-1:0] expected_read_value [0:TOTAL_LOGICAL_NUM-1];

initial begin
    // all APB input initialized to 0
    PSEL = 1'b0;
    PENABLE = 1'b0;
    PWRITE = 1'b0;
    PADDR = {BUS_ADDR_WIDTH{1'b0}};
    PWDATA = {BUS_DATA_WIDTH{1'b0}};

    test_2_shared_21__FIELD_0__next_value = {INT_REG_DATA_WIDTH{1'b0}};
    test_2_shared_21__FIELD_0__pulse = 1'b0;

    // interrupt clear signal initialized to 0
    bus__reg_top__clear = 1'b0;
    srst_1 = 1'b0;
    srst_2 = 1'b0;

    // get addresses, expected hardware value and read value of internal registers
    $readmemh("tb/access_addr_hex.txt", addrs);
    $readmemh("tb/expected_hw_value_hex.txt", expected_hw_value);
    $readmemh("tb/expected_read_value_hex.txt", expected_read_value);
end


/********************************************************************
********************* simulate APB interface ************************
*********************************************************************/
integer err_cnt;
integer phy_idx;

task apb_write (
    input [BUS_ADDR_WIDTH-1:0] wr_addr,
    input [BUS_DATA_WIDTH-1:0] wr_data);

    @(posedge clk); #(`CLK_PERIOD*0.1);
    PSEL = 1'b1;
    PENABLE = 1'b0;
    PWRITE = 1'b1;
    PADDR = wr_addr;
    PWDATA = wr_data;
    $display($time, " start write operation: addr=%h data=%h", PADDR, PWDATA);

    @(posedge clk); #(`CLK_PERIOD*0.1);
    PENABLE = 1'b1;

    wait(PREADY);
    @(posedge clk); #(`CLK_PERIOD*0.1);
    PSEL = 1'b0;
    $display($time, " end write operation");
endtask

task apb_read (
    input [BUS_ADDR_WIDTH-1:0] rd_addr,
    input [BUS_DATA_WIDTH-1:0] expected_val);

    @(posedge clk); #(`CLK_PERIOD*0.1);
    PSEL = 1'b1;
    PENABLE = 1'b0;
    PWRITE = 1'b0;
    PADDR = rd_addr;
    $display($time, " start read operation: addr=%h", PADDR);

    @(posedge clk); #(`CLK_PERIOD*0.1);
    PENABLE = 1'b1;

    wait(PREADY);
    #(`CLK_PERIOD*0.1); $display($time, " read data=%h", PRDATA);
    if (PRDATA !== expected_val) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: read(sw) addr=%h, sw expected=%h, actual=%h",
                 err_cnt, PADDR, expected_val, PRDATA);
    end

    @(posedge clk); #(`CLK_PERIOD*0.1);
    PSEL = 1'b0;
    $display($time, " end read operation");
endtask

task hw_reg_write (
    input [INT_REG_DATA_WIDTH-1:0] val,
    ref pulse,
    ref [INT_REG_DATA_WIDTH-1:0] hw_acc_port);

    @(posedge clk); #(`CLK_PERIOD*0.1);
    hw_acc_port = val;
    pulse = 1'b1;

    @(posedge clk); #(`CLK_PERIOD*0.1);
    pulse = 1'b0;
endtask

initial begin
    err_cnt = 0;
    wait(rst_n);
    @(posedge clk); #(`CLK_PERIOD*0.1);

    // APB write and read operations
    for (integer i = 0; i < TOTAL_LOGICAL_NUM; i = i + 1) begin
        if (i < TOTAL_LOGICAL_NUM/TOTAL_PHYSICAL_NUM)
            phy_idx = 0;
        else
            phy_idx = 1;

        // APB write operation
        // all register will be written to 0x00000000
        apb_write(addrs[i], {BUS_DATA_WIDTH{1'b0}});
        if (expected_hw_value[i*3] !== actual_hw_value[phy_idx]) begin
            err_cnt = err_cnt + 1;
            $display($time, " error %1d: write addr=%h, expected=%h, actual=%h",
                     err_cnt, PADDR, expected_hw_value[i*3], actual_hw_value[phy_idx]);
        end

        // APB read operation
        apb_read(addrs[i], expected_read_value[i]);
        if (expected_hw_value[i*3+1] !== actual_hw_value[phy_idx]) begin
            err_cnt = err_cnt + 1;
            $display($time, " error %1d: read(hw) in addr=%h, hw expected=%h, actual=%h",
                     err_cnt, PADDR, expected_hw_value[i*3+1], actual_hw_value[phy_idx]);
        end

        // another APB write operation
        apb_write(addrs[i], {BUS_DATA_WIDTH{1'b1}});
        if (expected_hw_value[i*3+2] !== actual_hw_value[phy_idx]) begin
            err_cnt = err_cnt + 1;
            $display($time, " error %1d: write addr=%h, expected=%h, actual=%h",
                     err_cnt, PADDR, expected_hw_value[i*3+2], actual_hw_value[phy_idx]);
        end
    end

    // test synchronous reset signals
    @(posedge clk); #(`CLK_PERIOD*0.1);
    srst_1 = 1'b1;
    @(posedge clk); #(`CLK_PERIOD*0.1);
    srst_1 = 1'b0;
    if (expected_hw_value[TOTAL_LOGICAL_NUM*3] !== actual_hw_value[1]) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: write addr=%h, expected=%h, actual=%h",
                 err_cnt, PADDR, expected_hw_value[TOTAL_LOGICAL_NUM*3], actual_hw_value[1]);
    end

    hw_reg_write({INT_REG_DATA_WIDTH{1'b0}}, test_2_shared_21__FIELD_0__pulse,
                 test_2_shared_21__FIELD_0__next_value);

    @(posedge clk); #(`CLK_PERIOD*0.1);
    srst_2 = 1'b1;
    @(posedge clk); #(`CLK_PERIOD*0.1);
    srst_2 = 1'b0;
    if (expected_hw_value[TOTAL_LOGICAL_NUM*3+1] !== actual_hw_value[1]) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: write addr=%h, expected=%h, actual=%h",
                 err_cnt, PADDR, expected_hw_value[TOTAL_LOGICAL_NUM*3+1], actual_hw_value[1]);
    end

    hw_reg_write({INT_REG_DATA_WIDTH{1'b0}}, test_2_shared_21__FIELD_0__pulse,
                 test_2_shared_21__FIELD_0__next_value);


    $display("test process done, error count: %1d", err_cnt);
    #(`CLK_PERIOD*2);
    if (err_cnt != 0) begin
        $error("test aborted due to errors");
    end
    $finish;
end

endmodule