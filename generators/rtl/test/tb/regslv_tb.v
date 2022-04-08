`timescale 1ns/1ns

module tb_regslv;

parameter ADDR_WIDTH = 64;
parameter DATA_WIDTH = 32;
parameter EXT_MEM_ADDR_WIDTH = 6;   // 2^6 = 64 memory entries
parameter EXT_MEM_NUM = 3;
parameter INT_REG_NUM = 10;

reg clk;
reg rstn;

// upstream reg_native_if definition
reg req_vld;
wire req_rdy;
reg wr_en, rd_en;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] wr_data;
wire ack_vld;
reg ack_rdy;
wire [DATA_WIDTH-1:0] rd_data;

// synchronous reset signals definition
reg global_srst_in;
reg test_21_srst_1, test_21_srst_2;
wire global_srst_out;

// external reg_native_if definition
wire [EXT_MEM_NUM-1:0] ext_req_vld, ext_req_rdy;
wire ext_wr_en, ext_rd_en;
wire [ADDR_WIDTH-1:0] ext_addr;
wire [DATA_WIDTH-1:0] ext_wr_data;
wire [EXT_MEM_NUM-1:0] ext_ack_vld;
wire ext_ack_rdy;
wire [EXT_MEM_NUM-1:0] [DATA_WIDTH-1:0] ext_rd_data;

// instantiate regslv dut
regslv_reg_block_2 #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH))
regslv_dut (
    .clk(clk),
    .rstn(rstn),
    // upstream reg_native_if
    .req_vld(req_vld),
    .req_rdy(req_rdy),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .addr(addr),
    .wr_data(wr_data),
    .ack_vld(ack_vld),
    .ack_rdy(ack_rdy),
    .rd_data(rd_data),
    // synchronous reset signals
    .global_sync_reset_in(global_srst_in),
    .global_sync_reset_out(global_srst_out),
    .test_21_srst_1(test_21_srst_1),
    .test_21_srst_2(test_21_srst_2),
    // external memory reg_native_if
    .ext_req_vld(ext_req_vld),
    .ext_req_rdy(ext_req_rdy),
    .ext_wr_en(ext_wr_en),
    .ext_rd_en(ext_rd_en),
    .ext_addr(ext_addr),
    .ext_wr_data(ext_wr_data),
    .ext_ack_vld(ext_ack_vld),
    .ext_ack_rdy(ext_ack_rdy),
    .ext_rd_data(ext_rd_data),
    // hardware access input ports
    .test_21_REG1_SW_RW__FIELD_8__next_value(2'b0),
    .test_21_REG1_SW_RW__FIELD_8__pulse(1'b0),
    .test_21_REG1_SW_RW__FIELD_7__next_value(2'b0),
    .test_21_REG1_SW_RW__FIELD_7__pulse(1'b0),
    .test_21_REG1_SW_RW__FIELD_6__next_value(2'b0),
    .test_21_REG1_SW_RW__FIELD_6__pulse(1'b0),
    .test_21_REG1_SW_RW__FIELD_5__next_value(2'b0),
    .test_21_REG1_SW_RW__FIELD_5__pulse(1'b0),
    .test_21_REG1_SW_RW__FIELD_4__next_value(2'b0),
    .test_21_REG1_SW_RW__FIELD_4__pulse(1'b0),
    .test_21_REG1_SW_RW__FIELD_3__next_value(2'b0),
    .test_21_REG1_SW_RW__FIELD_3__pulse(1'b0),
    .test_21_REG1_SW_RW__FIELD_2__next_value(2'b0),
    .test_21_REG1_SW_RW__FIELD_2__pulse(1'b0),
    .test_21_REG1_SW_RW__FIELD_1__next_value(2'b0),
    .test_21_REG1_SW_RW__FIELD_1__pulse(1'b0),
    .test_21_REG1_SW_RW__FIELD_0__next_value(2'b0),
    .test_21_REG1_SW_RW__FIELD_0__pulse(1'b0),
    .test_21_REG2_SW_W__FIELD_6__next_value(2'b0),
    .test_21_REG2_SW_W__FIELD_6__pulse(1'b0),
    .test_21_REG2_SW_W__FIELD_5__next_value(2'b0),
    .test_21_REG2_SW_W__FIELD_5__pulse(1'b0),
    .test_21_REG2_SW_W__FIELD_4__next_value(2'b0),
    .test_21_REG2_SW_W__FIELD_4__pulse(1'b0),
    .test_21_REG2_SW_W__FIELD_3__next_value(2'b0),
    .test_21_REG2_SW_W__FIELD_3__pulse(1'b0),
    .test_21_REG2_SW_W__FIELD_2__next_value(2'b0),
    .test_21_REG2_SW_W__FIELD_2__pulse(1'b0),
    .test_21_REG2_SW_W__FIELD_1__next_value(2'b0),
    .test_21_REG2_SW_W__FIELD_1__pulse(1'b0),
    .test_21_REG2_SW_W__FIELD_0__next_value(2'b0),
    .test_21_REG2_SW_W__FIELD_0__pulse(1'b0),
    .test_21_REG3_HW__FIELD_3__next_value(2'b0),
    .test_21_REG3_HW__FIELD_3__pulse(1'b0),
    .test_21_REG3_HW__FIELD_2__next_value(2'b0),
    .test_21_REG3_HW__FIELD_2__pulse(1'b0),
    .test_21_REG3_HW__FIELD_0__next_value(2'b0),
    .test_21_REG3_HW__FIELD_0__pulse(1'b0),
    .test_21_REG4_PRECEDENCE__FIELD_1__next_value(2'b0),
    .test_21_REG4_PRECEDENCE__FIELD_1__pulse(1'b0),
    .test_21_REG4_PRECEDENCE__FIELD_0__next_value(2'b0),
    .test_21_REG4_PRECEDENCE__FIELD_0__pulse(1'b0),
    .test_21_REG5_SINGLEPULSE__FIELD_0__next_value(1'b0),
    .test_21_REG5_SINGLEPULSE__FIELD_0__pulse(1'b0),
    .test_21_REG6_SW_ACC_MOD__FIELD_0__next_value(2'b0),
    .test_21_REG6_SW_ACC_MOD__FIELD_0__pulse(1'b0),
    .test_22_shared_2__FIELD_0__next_value(32'b0),
    .test_22_shared_2__FIELD_0__pulse(1'b0)
);

// instantiate external memory
genvar i;
generate
    for (i = 0; i < EXT_MEM_NUM; i = i + 1) begin: gen_ext_mem
        ext_mem_32_64 #(
            .DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(EXT_MEM_ADDR_WIDTH))
        ext_mem_32_64_inst (
            .clk(clk),
            .req_vld(ext_req_vld[i]),
            .req_rdy(ext_req_rdy[i]),
            .wr_en(ext_wr_en),
            .rd_en(ext_rd_en),
            .addr(ext_addr-64'h200-64'h100*i),
            .wr_data(ext_wr_data),
            .rd_data(ext_rd_data[i]),
            .ack_vld(ext_ack_vld[i]),
            .ack_rdy(ext_ack_rdy)
        );
    end
endgenerate

// dump simulation files
initial begin
    $fsdbDumpfile("tb_regslv.fsdb");
    $fsdbDumpvars(0, tb_regslv);
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
    test_21_srst_1 = 1'b0;
    test_21_srst_2 = 1'b0;

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