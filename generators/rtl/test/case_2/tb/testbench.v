`timescale 1ns/1ns

// testbench for case 2: software access properties: sw=r/rw/rw1/w/w1
module reg_tb;

parameter TOTAL_ACCESS_NUM = 5;
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
parameter REGSLV_REG_BLOCK_1_INT_NUM = 5;

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
	.REG1_SW_RO__FIELD_0__next_value(32'b0),
	.REG1_SW_RO__FIELD_0__pulse(1'b0),
	.REG1_SW_RO__FIELD_0__curr_value(actual_hw_value[0]),
	.REG2_SW_RW__FIELD_0__next_value(32'b0),
	.REG2_SW_RW__FIELD_0__pulse(1'b0),
	.REG2_SW_RW__FIELD_0__curr_value(actual_hw_value[1]),
	.REG3_SW_RW1__FIELD_0__next_value(32'b0),
	.REG3_SW_RW1__FIELD_0__pulse(1'b0),
	.REG3_SW_RW1__FIELD_0__curr_value(actual_hw_value[2]),
	.REG4_SW_WO__FIELD_0__next_value(32'b0),
	.REG4_SW_WO__FIELD_0__pulse(1'b0),
	.REG4_SW_WO__FIELD_0__curr_value(actual_hw_value[3]),
	.REG5_SW_W1__FIELD_0__next_value(32'b0),
	.REG5_SW_W1__FIELD_0__pulse(1'b0),
	.REG5_SW_W1__FIELD_0__curr_value(actual_hw_value[4])
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
********* test stimulus and external memory initialization **********
*********************************************************************/
reg [ADDR_WIDTH-1:0] addrs [0:TOTAL_ACCESS_NUM-1];
reg [DATA_WIDTH-1:0] expected_hw_value [0:(TOTAL_ACCESS_NUM)*3-1];
reg [DATA_WIDTH-1:0] expected_read_value [0:TOTAL_ACCESS_NUM-1];

initial begin
    // all APB input initialized to 0
    PSEL = 1'b0;
    PENABLE = 1'b0;
    PWRITE = 1'b0;
    PADDR = {ADDR_WIDTH{1'b0}};
    PWDATA = {DATA_WIDTH{1'b0}};

    // interrupt clear signal initialized to invalid(0)
    bus__mst__clear = 1'b0;

    // get addresses of internal registers and external memory entries
    $readmemh("tb/access_addr_hex.txt", addrs);
    $readmemh("tb/expected_hw_value_hex.txt", expected_hw_value);
    $readmemh("tb/expected_read_value_hex.txt", expected_read_value);
end


/********************************************************************
********************* simulate APB interface ************************
*********************************************************************/
integer err_cnt;

initial begin
    err_cnt = 0;
    wait(rstn);
    @(posedge clk); #1;

    // continous APB write and read operations
    $display($time, " start continous APB operations");
    for (integer i = 0; i < TOTAL_ACCESS_NUM; i = i + 1) begin
        // write operation
        @(posedge clk); #1;
        PSEL = 1'b1;
        PENABLE = 1'b0;
        PWRITE = 1'b1;
        PADDR = addrs[i];
        // all register will be written to 0xffffffff
        PWDATA = {DATA_WIDTH{1'b1}};
        $display($time, " start write operation: addr=%h data=%h", PADDR, PWDATA);

        @(posedge clk); #1;
        PENABLE = 1'b1;

        wait(PREADY);
        @(posedge clk); #1;
        PSEL = 1'b0;
        $display($time, " end write operation");
        if (expected_hw_value[i*3] != actual_hw_value[i]) begin
            err_cnt = err_cnt + 1;
            $display("write error occurs, expected=%h, actual=%h",
                     expected_hw_value[i*3], actual_hw_value[i]);
        end

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
        #0 $display($time, " read data=%h", PRDATA);
        if (PRDATA != expected_read_value[i]) begin
            err_cnt = err_cnt + 1;
            $display("read sw error occurs, expected=%h, PRDATA=%h",
                     expected_read_value[i], PRDATA);
        end
        @(posedge clk); #1;
        PSEL = 1'b0;
        $display($time, " end read operation");
        if (expected_hw_value[i*3+1] != actual_hw_value[i]) begin
            err_cnt = err_cnt + 1;
            $display("read hw error occurs, expected=%h, actual=%h",
                     expected_hw_value[i*3+1], actual_hw_value[i]);
        end

        // another write operation to test sw=rw1/w1 properties
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
        if (expected_hw_value[i*3+2] != actual_hw_value[i]) begin
            err_cnt = err_cnt + 1;
            $display("write error occurs, expected=%h, actual=%h",
                     expected_hw_value[i*3+2], actual_hw_value[i]);
        end
    end

    $display("test process done, error count: %d", err_cnt);
    #(CLK_PERIOD*2);
    $finish;
end

endmodule