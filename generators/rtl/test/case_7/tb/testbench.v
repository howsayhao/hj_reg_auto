////////////////////////////////////////////////////////////////////////////////
// case 7 testbench:
//      async/sync reset,
//      reset value, swmod, swacc properties
//
// upper bus interface: APB
//      addr width: 32
//      data width: 64
// internal register:
//      entry: 7
//      data width: 32
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps

// clock frequency:
//      clk_1 (bus interface and regslv native): 50MHz
`define CLK_PERIOD 20

module reg_tb;

// bus definition
parameter BUS_ADDR_WIDTH = 64;
parameter BUS_DATA_WIDTH = 32;

// internal register parameters
parameter INT_REG_ENTRY = 7;
parameter INT_REG_DATA_WIDTH = 32;
parameter INT_ACCESS_NUM = 7;

parameter TOTAL_LOGICAL_NUM = 7;

logic [BUS_DATA_WIDTH-1:0] actual_hw_value [0:TOTAL_LOGICAL_NUM-1];

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
//      internal register: 7
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
parameter REGSLV_REG_BLOCK_1_INT_NUM = 7;

logic [BUS_DATA_WIDTH-1:0] reg1_next_value;
logic reg1_pulse;
logic [BUS_DATA_WIDTH-1:0] reg2_next_value;
logic reg2_pulse;
logic [BUS_DATA_WIDTH-1:0] reg3_next_value;
logic reg3_pulse;
logic [BUS_DATA_WIDTH-1:0] reg4_next_value;
logic reg4_pulse;
logic [BUS_DATA_WIDTH-1:0] reg5_next_value;
logic reg5_pulse;
logic [BUS_DATA_WIDTH-1:0] reg6_next_value;
logic reg6_pulse;
logic [BUS_DATA_WIDTH-1:0] reg7_next_value;
logic reg7_pulse;

logic srst_1, srst_2, srst_3, srst_4, srst_5;
logic swmod_out, swacc_out;

regslv_reg_top__reg_block_1 #(
    .ADDR_WIDTH(BUS_ADDR_WIDTH),
    .DATA_WIDTH(BUS_DATA_WIDTH))
regslv_reg_top__reg_block_1_dut (
    // hardware access input ports
    .REG1_SRST__FIELD_0__next_value(reg1_next_value),
	.REG1_SRST__FIELD_0__pulse(reg1_pulse),
	.REG1_SRST__FIELD_0__curr_value(actual_hw_value[0]),
	.REG2_SRST__FIELD_0__next_value(reg2_next_value),
	.REG2_SRST__FIELD_0__pulse(reg2_pulse),
	.REG2_SRST__FIELD_0__curr_value(actual_hw_value[1]),
	.REG3_SRST__FIELD_0__next_value(reg3_next_value),
	.REG3_SRST__FIELD_0__pulse(reg3_pulse),
	.REG3_SRST__FIELD_0__curr_value(actual_hw_value[2]),
	.REG4_SWMOD__FIELD_0__next_value(reg4_next_value),
	.REG4_SWMOD__FIELD_0__pulse(reg4_pulse),
	.REG4_SWMOD__FIELD_0__curr_value(actual_hw_value[3]),
    .REG4_SWMOD__FIELD_0__swmod_out(swmod_out),
	.REG5_SWACC__FIELD_0__next_value(reg5_next_value),
	.REG5_SWACC__FIELD_0__pulse(reg5_pulse),
	.REG5_SWACC__FIELD_0__curr_value(actual_hw_value[4]),
    .REG5_SWACC__FIELD_0__swacc_out(swacc_out),
	.REG6_PRECEDENCE_SW__FIELD_0__next_value(reg6_next_value),
	.REG6_PRECEDENCE_SW__FIELD_0__pulse(reg6_pulse),
	.REG6_PRECEDENCE_SW__FIELD_0__curr_value(actual_hw_value[5]),
	.REG7_PRECEDENCE_HW__FIELD_0__next_value(reg7_next_value),
	.REG7_PRECEDENCE_HW__FIELD_0__pulse(reg7_pulse),
	.REG7_PRECEDENCE_HW__FIELD_0__curr_value(actual_hw_value[6]),
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
	.srst_2(srst_2),
	.srst_3(srst_3),
	.srst_4(srst_4),
	.srst_5(srst_5)
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
***************** test stimulus initialization **********************
*********************************************************************/
reg [BUS_ADDR_WIDTH-1:0] addrs [0:TOTAL_LOGICAL_NUM-1];
reg [BUS_DATA_WIDTH-1:0] expected_hw_value [0:TOTAL_LOGICAL_NUM-1];

initial begin
    // all APB input initialized to 0
    PSEL = 1'b0;
    PENABLE = 1'b0;
    PWRITE = 1'b0;
    PADDR = {BUS_ADDR_WIDTH{1'b0}};
    PWDATA = {BUS_DATA_WIDTH{1'b0}};

    // interrupt clear signal initialized to 0
    bus__reg_top__clear = 1'b0;

    // all synchronous reset signal initialized to 0
    srst_1 = 1'b0;
    srst_2 = 1'b0;
    srst_3 = 1'b0;
    srst_4 = 1'b0;
    srst_5 = 1'b0;

    // hardware access ports initialized to 0
    reg1_next_value = 32'b0;
    reg1_pulse = 1'b0;
    reg2_next_value = 32'b0;
    reg2_pulse = 1'b0;
    reg3_next_value = 32'b0;
    reg3_pulse = 1'b0;
    reg4_next_value = 32'b0;
    reg4_pulse = 1'b0;
    reg5_next_value = 32'b0;
    reg5_pulse = 1'b0;
    reg6_next_value = 32'b0;
    reg6_pulse = 1'b0;
    reg7_next_value = 32'b0;
    reg7_pulse = 1'b0;

    // get addresses and expected hardware value of registers
    $readmemh("tb/access_addr_hex.txt", addrs);
    $readmemh("tb/expected_hw_value_hex.txt", expected_hw_value);
end


/********************************************************************
******** simulate APB transaction and hardware access ***************
*********************************************************************/
integer err_cnt;

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
    // see whether swacc and swmod is asserted and deasserted
    $monitor($time, " swacc=%b, swmod=%b", swacc_out, swmod_out);
end

initial begin
    err_cnt = 0;
    wait(rst_n);
    @(posedge clk); #1;

    // set register values different from reset values by APB interface,
    // and test async reset signals
    for (integer i = 0; i < TOTAL_LOGICAL_NUM; i = i + 1) begin
        // APB write operation
        apb_write(addrs[i], 32'h1234_5678);
        if (PWDATA !== actual_hw_value[i]) begin
            err_cnt = err_cnt + 1;
            $display($time, " error %1d: APB write, addr=%h,  expected=%h, actual=%h",
                     err_cnt, PADDR, PWDATA, actual_hw_value[i]);
        end

        // assert global asynchronous resets
        rst_n = 1'b0; #(`CLK_PERIOD*0.1);
        if (actual_hw_value[i] !== expected_hw_value[i]) begin
            err_cnt = err_cnt + 1;
            $display($time, " error %1d: global async reset, expected=%h, actual=%h",
                     err_cnt, expected_hw_value[i], actual_hw_value[i]);
        end
        @(posedge clk); #(`CLK_PERIOD*0.1);
        rst_n = 1'b1;
    end

    #(`CLK_PERIOD*5);

    // set register values different from reset values by hardware interface,
    // and test sync reset signals
    // REG1_SRST: srst_1
    hw_reg_write(32'h1234_5678, reg1_pulse, reg1_next_value);

    srst_1 = 1'b1;
    @(posedge clk); #(`CLK_PERIOD*0.1);
    srst_1 = 1'b0;
    if (actual_hw_value[0] !== expected_hw_value[0]) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: reg1.srst_1 sync reset, hw value: expected=%h, actual=%h",
                 err_cnt, expected_hw_value[0], actual_hw_value[0]);
    end

    // REG1_SRST: srst_2
    hw_reg_write(32'h1234_5678, reg1_pulse, reg1_next_value);

    srst_2 = 1'b1;
    @(posedge clk); #(`CLK_PERIOD*0.1);
    srst_2 = 1'b0;
    if (actual_hw_value[0] !== expected_hw_value[0]) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: reg1.srst_2 sync reset, hw value: expected=%h, actual=%h",
                 err_cnt, expected_hw_value[0], actual_hw_value[0]);
    end

    // REG1_SRST, REG2_SRST: srst_3
    hw_reg_write(32'h1234_5678, reg1_pulse, reg1_next_value);
    hw_reg_write(32'h1234_5678, reg2_pulse, reg2_next_value);

    srst_3 = 1'b1;
    @(posedge clk); #(`CLK_PERIOD*0.1);
    srst_3 = 1'b0;
    if (actual_hw_value[0] !== expected_hw_value[0]) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: reg1.srst_3 sync reset, hw value: expected=%h, actual=%h",
                 err_cnt, expected_hw_value[0], actual_hw_value[0]);
    end

    if (actual_hw_value[1] !== expected_hw_value[1]) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: reg2.srst_3 sync reset, hw value: expected=%h, actual=%h",
                 err_cnt, expected_hw_value[1], actual_hw_value[1]);
    end

    // REG2_SRST: srst_4
    hw_reg_write(32'h1234_5678, reg2_pulse, reg2_next_value);

    srst_4 = 1'b1;
    @(posedge clk); #(`CLK_PERIOD*0.1);
    srst_4 = 1'b0;
    if (actual_hw_value[1] !== expected_hw_value[1]) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: reg2.srst_4 sync reset, hw value: expected=%h, actual=%h",
                 err_cnt, expected_hw_value[1], actual_hw_value[1]);
    end

    // REG2_SRST: srst_5
    hw_reg_write(32'h1234_5678, reg2_pulse, reg2_next_value);

    srst_5 = 1'b1;
    @(posedge clk); #(`CLK_PERIOD*0.1);
    srst_5 = 1'b0;
    if (actual_hw_value[1] !== expected_hw_value[1]) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: reg2.srst_5 sync reset, hw value: expected=%h, actual=%h",
                 err_cnt, expected_hw_value[1], actual_hw_value[1]);
    end

    #(`CLK_PERIOD*5);

    // assert software and hardware access at the same time
    // to test the precedence property in REG6_PRECEDENCE_SW and REG7_PRECEDENCE_HW
    fork
        // dispatch APB write request
        begin: SW_WRITE
            // point to REG6_PRECEDENCE_SW
            // software write 0x12345678
            apb_write(addrs[5], 32'h1234_5678);
            // point to REG7_PRECEDENCE_HW
            // software write 0x12345678
            apb_write(addrs[6], 32'h1234_5678);
        end
        // wait for the software write enable signal,
        // and then dispatch hardware write request
        begin: HW_WRITE
            wait(regslv_reg_top__reg_block_1_dut.x__REG6_PRECEDENCE_SW__FIELD_0.sw_wr);
            reg6_pulse = 1'b1;
            reg6_next_value = 32'h8765_4321;

            @(posedge clk); #(`CLK_PERIOD*0.1);
            reg6_pulse = 1'b0;
            reg6_next_value = 32'h0;
            if (actual_hw_value[5] !== 32'h1234_5678) begin
                err_cnt = err_cnt + 1;
                $display($time, " error %1d: reg6 hw value, expected=%h, actual=%h",
                         err_cnt, 32'h1234_5678, actual_hw_value[5]);
            end

            wait(regslv_reg_top__reg_block_1_dut.x__REG7_PRECEDENCE_HW__FIELD_0.sw_wr);
            reg7_pulse = 1'b1;
            reg7_next_value = 32'h8765_4321;

            @(posedge clk); #(`CLK_PERIOD*0.1);
            reg7_pulse = 1'b0;
            reg7_next_value = 32'h0;
            if (actual_hw_value[6] !== 32'h8765_4321) begin
                err_cnt = err_cnt + 1;
                $display($time, " error %1d: reg7 hw value, expected=%h, actual=%h",
                         err_cnt, 32'h87654321, actual_hw_value[6]);
            end
        end
    join

    $display("test process done, error count: %1d", err_cnt);
    #(`CLK_PERIOD*2);
    if (err_cnt != 0) begin
        $error("test aborted due to errors");
    end
    $finish;
end

endmodule