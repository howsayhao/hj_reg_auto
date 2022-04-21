`timescale 1ns/1ns

// testbench for case 7: async/sync reset and reset value, swmod, swacc properties
module reg_tb;

parameter TOTAL_ACCESS_NUM = 7;
parameter ADDR_WIDTH = 64;
parameter DATA_WIDTH = 32;

logic [DATA_WIDTH-1:0] actual_hw_value [0:TOTAL_ACCESS_NUM-1];

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
//      reg_native_if: regmst <-> regslv_reg_top__reg_block_1
// directly connected upstream:
//      APB interface
// directly connected downstream:
//      regslv: regslv_reg_top__reg_block_1
// other signals:
//      interrupt, glb_srst, clear
parameter REGMST_REG_TOP_EXT_NUM = 1;

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
    // clock domain crossing signal
    .cdc_pulse_out(),
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


// module: regslv_reg_top__reg_block_1 DUT
// bus interface:
//      reg_native_if: regmst_reg_top <-> regslv_reg_top__reg_block_1
// directly connected upstream:
//      regmst: regmst_reg_top
// other signals:
//      input glb_srst,
//      hardware access ports for internal registers
parameter REGSLV_REG_BLOCK_1_EXT_NUM = 0;
parameter REGSLV_REG_BLOCK_1_INT_NUM = 7;

logic [DATA_WIDTH-1:0] reg1_next_value;
logic reg1_pulse;
logic [DATA_WIDTH-1:0] reg2_next_value;
logic reg2_pulse;
logic [DATA_WIDTH-1:0] reg3_next_value;
logic reg3_pulse;
logic [DATA_WIDTH-1:0] reg4_next_value;
logic reg4_pulse;
logic [DATA_WIDTH-1:0] reg5_next_value;
logic reg5_pulse;
logic [DATA_WIDTH-1:0] reg6_next_value;
logic reg6_pulse;
logic [DATA_WIDTH-1:0] reg7_next_value;
logic reg7_pulse;

logic srst_1, srst_2, srst_3, srst_4, srst_5;
logic swmod_out, swacc_out;

regslv_reg_top__reg_block_1 #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH))
regslv_reg_top__reg_block_1_dut (
    .clk(clk),
    .rstn(rstn),
    // upstream reg_native_if
    .req_vld(mst__ext__req_vld),
    .req_rdy(mst__ext__req_rdy),
    .ack_vld(mst__ext__ack_vld),
    .ack_rdy(mst__ext__ack_rdy),
    .wr_en(mst__ext__wr_en),
    .rd_en(mst__ext__rd_en),
    .addr(mst__ext__addr),
    .wr_data(mst__ext__wr_data),
    .rd_data(mst__ext__rd_data),
    // synchronous reset signals
    .global_sync_reset_in(mst__ext__glb_srst),
    .global_sync_reset_out(),
    .srst_1(srst_1),
	.srst_2(srst_2),
	.srst_3(srst_3),
	.srst_4(srst_4),
	.srst_5(srst_5),
    // clock domain crossing signal
    .cdc_pulse_out(),
    // external memory reg_native_if
    .ext_req_vld(),
    .ext_req_rdy(1'b0),
    .ext_ack_vld(1'b0),
    .ext_ack_rdy(),
    .ext_wr_en(),
    .ext_rd_en(),
    .ext_addr(),
    .ext_wr_data(),
    .ext_rd_data({DATA_WIDTH{1'b0}}),
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
	.REG7_PRECEDENCE_HW__FIELD_0__curr_value(actual_hw_value[6])
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
***************** test stimulus initialization **********************
*********************************************************************/
reg [ADDR_WIDTH-1:0] addrs [0:TOTAL_ACCESS_NUM-1];
reg [DATA_WIDTH-1:0] expected_hw_value [0:TOTAL_ACCESS_NUM-1];

initial begin
    // all APB input initialized to 0
    PSEL = 1'b0;
    PENABLE = 1'b0;
    PWRITE = 1'b0;
    PADDR = {ADDR_WIDTH{1'b0}};
    PWDATA = {DATA_WIDTH{1'b0}};

    // interrupt clear signal initialized to 0
    bus__mst__clear = 1'b0;

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

initial begin
    // see whether swacc and swmod is asserted and deasserted
    $monitor($time, " swacc=%b, swmod=%b", swacc_out, swmod_out);
end

initial begin
    err_cnt = 0;
    wait(rstn);
    @(posedge clk); #1;

    // set register values different from reset values by APB interface,
    // and test async reset signals
    for (integer i = 0; i < TOTAL_ACCESS_NUM; i = i + 1) begin
        // APB write operation
        @(posedge clk); #1;
        PSEL = 1'b1;
        PENABLE = 1'b0;
        PWRITE = 1'b1;
        PADDR = addrs[i];
        // all register will be written to 0x12345678
        PWDATA = 32'h12345678;
        $display($time, " start write operation: addr=%h data=%h", PADDR, PWDATA);

        @(posedge clk); #1;
        PENABLE = 1'b1;

        wait(PREADY);
        @(posedge clk); #1;
        PSEL = 1'b0;
        $display($time, " end write operation");

        if (PWDATA != actual_hw_value[i]) begin
            err_cnt = err_cnt + 1;
            $display($time, " error %1d: APB write, addr=%h,  expected=%h, actual=%h",
                     err_cnt, PADDR, PWDATA, actual_hw_value[i]);
        end

        // assert global asynchronous resets
        rstn = 1'b0; #1;
        if (actual_hw_value[i] != expected_hw_value[i]) begin
            err_cnt = err_cnt + 1;
            $display($time, " error %1d: global async reset, expected=%h, actual=%h",
                     err_cnt, expected_hw_value[i], actual_hw_value[i]);
        end
        @(posedge clk); #1;
        rstn = 1'b1;
    end

    #(CLK_PERIOD*5);

    // set register values different from reset values by hardware interface,
    // and test sync reset signals
    // REG1_SRST: srst_1
    @(posedge clk); #1;
    reg1_pulse = 1'b1;
    reg1_next_value = 32'h12345678;

    @(posedge clk); #1;
    reg1_pulse = 1'b0;
    reg1_next_value = 32'h0;
    srst_1 = 1'b1;
    @(posedge clk); #1;
    srst_1 = 1'b0;
    if (actual_hw_value[0] != expected_hw_value[0]) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: reg1.srst_1 sync reset, hw value: expected=%h, actual=%h",
                 err_cnt, expected_hw_value[0], actual_hw_value[0]);
    end

    // REG1_SRST: srst_2
    @(posedge clk); #1;
    reg1_pulse = 1'b1;
    reg1_next_value = 32'h12345678;

    @(posedge clk); #1;
    reg1_pulse = 1'b0;
    reg1_next_value = 32'h0;
    srst_2 = 1'b1;
    @(posedge clk); #1;
    srst_2 = 1'b0;
    if (actual_hw_value[0] != expected_hw_value[0]) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: reg1.srst_2 sync reset, hw value: expected=%h, actual=%h",
                 err_cnt, expected_hw_value[0], actual_hw_value[0]);
    end

    // REG1_SRST, REG2_SRST: srst_3
    @(posedge clk); #1;
    reg1_pulse = 1'b1;
    reg1_next_value = 32'h12345678;
    reg2_pulse = 1'b1;
    reg2_next_value = 32'h12345678;

    @(posedge clk); #1;
    reg1_pulse = 1'b0;
    reg1_next_value = 32'h0;
    reg2_pulse = 1'b0;
    reg2_next_value = 32'h0;
    srst_3 = 1'b1;
    @(posedge clk); #1;
    srst_3 = 1'b0;
    if (actual_hw_value[0] != expected_hw_value[0]) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: reg1.srst_3 sync reset, hw value: expected=%h, actual=%h",
                 err_cnt, expected_hw_value[0], actual_hw_value[0]);
    end

    if (actual_hw_value[1] != expected_hw_value[1]) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: reg2.srst_3 sync reset, hw value: expected=%h, actual=%h",
                 err_cnt, expected_hw_value[1], actual_hw_value[1]);
    end

    // REG2_SRST: srst_4
    @(posedge clk); #1;
    reg2_pulse = 1'b1;
    reg2_next_value = 32'h12345678;

    @(posedge clk); #1;
    reg2_pulse = 1'b0;
    reg2_next_value = 32'h0;
    srst_4 = 1'b1;
    @(posedge clk); #1;
    srst_4 = 1'b0;
    if (actual_hw_value[0] != expected_hw_value[0]) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: reg2.srst_4 sync reset, hw value: expected=%h, actual=%h",
                 err_cnt, expected_hw_value[1], actual_hw_value[1]);
    end

    // REG2_SRST: srst_5
    @(posedge clk); #1;
    reg2_pulse = 1'b1;
    reg2_next_value = 32'h12345678;

    @(posedge clk); #1;
    reg2_pulse = 1'b0;
    reg2_next_value = 32'h0;
    srst_5 = 1'b1;
    @(posedge clk); #1;
    srst_5 = 1'b0;
    if (actual_hw_value[1] != expected_hw_value[1]) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: reg2.srst_5 sync reset, hw value: expected=%h, actual=%h",
                 err_cnt, expected_hw_value[1], actual_hw_value[1]);
    end

    #(CLK_PERIOD*5);

    // assert software and hardware access at the same time
    // to test the precedence property in REG6_PRECEDENCE_SW and REG7_PRECEDENCE_HW
    // firstly dispatch APB write request
    fork
        begin: SW_WRITE
            @(posedge clk); #1;
            PSEL = 1'b1;
            PENABLE = 1'b0;
            PWRITE = 1'b1;
            PADDR = addrs[5];   // point to REG6_PRECEDENCE_SW
            // software write 0x12345678
            PWDATA = 32'h12345678;
            $display($time, " start write operation: addr=%h data=%h", PADDR, PWDATA);

            @(posedge clk); #1;
            PENABLE = 1'b1;

            wait(PREADY);
            @(posedge clk); #1;
            PSEL = 1'b0;
            $display($time, " end write operation");

            @(posedge clk); #1;
            PSEL = 1'b1;
            PENABLE = 1'b0;
            PWRITE = 1'b1;
            PADDR = addrs[6];   // point to REG7_PRECEDENCE_HW
            // software write 0x12345678
            PWDATA = 32'h12345678;
            $display($time, " start write operation: addr=%h data=%h", PADDR, PWDATA);

            @(posedge clk); #1;
            PENABLE = 1'b1;

            wait(PREADY);
            @(posedge clk); #1;
            PSEL = 1'b0;
            $display($time, " end write operation");
        end

        begin: HW_WRITE
            wait(regslv_reg_top__reg_block_1_dut.x__REG6_PRECEDENCE_SW__FIELD_0.sw_wr);
            reg6_pulse = 1'b1;
            reg6_next_value = 32'h87654321;

            @(posedge clk); #1;
            reg6_pulse = 1'b0;
            reg6_next_value = 32'h0;
            if (actual_hw_value[5] != 32'h12345678) begin
                err_cnt = err_cnt + 1;
                $display($time, " error %1d: reg6 hw value, expected=%h, actual=%h",
                         err_cnt, 32'h12345678, actual_hw_value[5]);
            end

            wait(regslv_reg_top__reg_block_1_dut.x__REG7_PRECEDENCE_HW__FIELD_0.sw_wr);
            reg7_pulse = 1'b1;
            reg7_next_value = 32'h87654321;

            @(posedge clk); #1;
            reg7_pulse = 1'b0;
            reg7_next_value = 32'h0;
            if (actual_hw_value[6] != 32'h87654321) begin
                err_cnt = err_cnt + 1;
                $display($time, " error %1d: reg7 hw value, expected=%h, actual=%h",
                         err_cnt, 32'h87654321, actual_hw_value[6]);
            end
        end
    join

    $display("test process done, error count: %1d", err_cnt);
    #(CLK_PERIOD*2);
    $finish;
end

endmodule