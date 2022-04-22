`timescale 1ns/1ns

// testbench for case 8: snapshot register dealing with data width
// mismatch between APB interface and external memories
module reg_tb;

// only access external memory block, ignore internal registers
parameter EXT_ACCESS_NUM = 8;
parameter ADDR_WIDTH = 64;
parameter DATA_WIDTH = 32;

parameter EXT_MEM_ADDR_WIDTH = 1;
parameter EXT_MEM_DATA_WIDTH = 128;
parameter EXT_MEM_ENTRY = 1 << EXT_MEM_ADDR_WIDTH;
parameter SNAPSHOT_ENTRY_NUM = EXT_ACCESS_NUM / EXT_MEM_ENTRY;

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
//      reg_native_if: regmst <-> downstream regslv
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
//      reg_native_if: regslv_reg_top__reg_block_1 <-> snapshot_reg_mem_1
// directly connected upstream:
//      regmst: regmst_reg_top
// directly connected downstream:
//      snapshot register: snapshot_reg_mem_1
// other signals:
//      input glb_srst, output glb_srst,
//      hardware access ports for internal registers
parameter REGSLV_REG_BLOCK_1_EXT_NUM = 1;
parameter REGSLV_REG_BLOCK_1_INT_NUM = 1;

logic [REGSLV_REG_BLOCK_1_EXT_NUM-1:0] regslv_reg_top__reg_block_1__ext__req_vld;
logic [REGSLV_REG_BLOCK_1_EXT_NUM-1:0] regslv_reg_top__reg_block_1__ext__req_rdy;
logic [REGSLV_REG_BLOCK_1_EXT_NUM-1:0] regslv_reg_top__reg_block_1__ext__ack_vld;
logic regslv_reg_top__reg_block_1__ext__ack_rdy;
logic regslv_reg_top__reg_block_1__ext__wr_en;
logic regslv_reg_top__reg_block_1__ext__rd_en;
logic [ADDR_WIDTH-1:0] regslv_reg_top__reg_block_1__ext__addr;
logic [DATA_WIDTH-1:0] regslv_reg_top__reg_block_1__ext__wr_data;
logic [REGSLV_REG_BLOCK_1_EXT_NUM-1:0] [DATA_WIDTH-1:0] regslv_reg_top__reg_block_1__ext__rd_data;

logic regslv_reg_top__reg_block_1__ext__glb_srst;

regslv_reg_top__reg_block_1 #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH))
regslv_reg_top__reg_block_1_dut (
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
    .global_sync_reset_out(regslv_reg_top__reg_block_1__ext__glb_srst),
    // clock domain crossing signal
    .cdc_pulse_out(),
    // external memory reg_native_if
    .ext_req_vld(regslv_reg_top__reg_block_1__ext__req_vld),
    .ext_req_rdy(regslv_reg_top__reg_block_1__ext__req_rdy),
    .ext_ack_vld(regslv_reg_top__reg_block_1__ext__ack_vld),
    .ext_ack_rdy(regslv_reg_top__reg_block_1__ext__ack_rdy),
    .ext_wr_en(regslv_reg_top__reg_block_1__ext__wr_en),
    .ext_rd_en(regslv_reg_top__reg_block_1__ext__rd_en),
    .ext_addr(regslv_reg_top__reg_block_1__ext__addr),
    .ext_wr_data(regslv_reg_top__reg_block_1__ext__wr_data),
    .ext_rd_data(regslv_reg_top__reg_block_1__ext__rd_data),
    // hardware access input ports
    .REG1__FIELD_0__next_value(32'b0),
	.REG1__FIELD_0__pulse(1'b0),
	.REG1__FIELD_0__curr_value()
);


// module: snapshot_reg_mem DUT
// bus interface:
//      reg_native_if: regslv_reg_top__reg_block_1 <-> snapshot_reg_mem
//      reg_native_if: snapshot_reg_mem <-> ext_mem_1
parameter EXT_MEM_1_DATA_WIDTH = EXT_MEM_DATA_WIDTH;
parameter EXT_MEM_1_ADDR_WIDTH = EXT_MEM_ADDR_WIDTH;

logic snapshot_reg_mem_1__ext_mem_1__req_vld;
logic snapshot_reg_mem_1__ext_mem_1__req_rdy;
logic snapshot_reg_mem_1__ext_mem_1__ack_vld;
logic snapshot_reg_mem_1__ext_mem_1__wr_en;
logic snapshot_reg_mem_1__ext_mem_1__rd_en;
logic [ADDR_WIDTH-1:0] snapshot_reg_mem_1__ext_mem_1__addr;
logic [EXT_MEM_1_DATA_WIDTH-1:0] snapshot_reg_mem_1__ext_mem_1__wr_data;
logic [EXT_MEM_1_DATA_WIDTH-1:0] snapshot_reg_mem_1__ext_mem_1__rd_data;

snap_reg #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH),
    .MEM_WIDTH(EXT_MEM_1_DATA_WIDTH))
snapshot_reg_mem_1 (
    .clk(clk),
    .rst_n(rstn),
    .req_vld(regslv_reg_top__reg_block_1__ext__req_vld[0]),
    .req_rdy(regslv_reg_top__reg_block_1__ext__req_rdy[0]),
    .ack_vld(regslv_reg_top__reg_block_1__ext__ack_vld[0]),
    .wr_en(regslv_reg_top__reg_block_1__ext__wr_en),
    .rd_en(regslv_reg_top__reg_block_1__ext__rd_en),
    .addr(regslv_reg_top__reg_block_1__ext__addr),
    .wr_data(regslv_reg_top__reg_block_1__ext__wr_data),
    .rd_data(regslv_reg_top__reg_block_1__ext__rd_data[0]),
    .entry_write_protect_en(1'b0),
    .entry_vld(1'b1),
    .entry_vld_nxt(),
    .mem_req_vld(snapshot_reg_mem_1__ext_mem_1__req_vld),
    .mem_req_rdy(snapshot_reg_mem_1__ext_mem_1__req_rdy),
    .mem_ack_vld(snapshot_reg_mem_1__ext_mem_1__ack_vld),
    .mem_wr_en(snapshot_reg_mem_1__ext_mem_1__wr_en),
    .mem_rd_en(snapshot_reg_mem_1__ext_mem_1__rd_en),
    .mem_addr(snapshot_reg_mem_1__ext_mem_1__addr),
    .mem_wr_data(snapshot_reg_mem_1__ext_mem_1__wr_data),
    .mem_rd_data(snapshot_reg_mem_1__ext_mem_1__rd_data)
);


// module: ext_mem_1 DUT
// bus interface:
//      reg_native_if: snapshot_reg_mem_1 <-> ext_mem_1
// directly connected upstream:
//      snapshot register: snapshot_reg_mem_1
parameter EXT_MEM_1_BASE_ADDR = 64'h20;

// convert bus address to external memory address
logic [ADDR_WIDTH-1:0] ext_mem_1__addr;
assign ext_mem_1__addr = snapshot_reg_mem_1__ext_mem_1__addr - EXT_MEM_1_BASE_ADDR;

ext_mem #(
    .DATA_WIDTH(EXT_MEM_1_DATA_WIDTH),
    .ADDR_WIDTH(EXT_MEM_1_ADDR_WIDTH))
ext_mem_1 (
    .clk(clk),
    .req_vld(snapshot_reg_mem_1__ext_mem_1__req_vld),
    .req_rdy(snapshot_reg_mem_1__ext_mem_1__req_rdy),
    .ack_vld(snapshot_reg_mem_1__ext_mem_1__ack_vld),
    .ack_rdy(1'b1),
    .wr_en(snapshot_reg_mem_1__ext_mem_1__wr_en),
    .rd_en(snapshot_reg_mem_1__ext_mem_1__rd_en),
    .addr(ext_mem_1__addr[4+EXT_MEM_1_ADDR_WIDTH-1:4]),
    .wr_data(snapshot_reg_mem_1__ext_mem_1__wr_data),
    .rd_data(snapshot_reg_mem_1__ext_mem_1__rd_data)
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
// all external memory entries initialized to 0
initial begin
    for (integer i = 0; i < EXT_MEM_ENTRY; i = i + 1) begin
        ext_mem_1.mem[i] = {EXT_MEM_DATA_WIDTH{1'b0}};
    end
end

reg [ADDR_WIDTH-1:0] addrs [0:EXT_ACCESS_NUM-1];
reg [EXT_MEM_DATA_WIDTH-1:0] expected_mem_value [0:EXT_ACCESS_NUM-1];
reg [DATA_WIDTH-1:0] expected_read_value [0:EXT_ACCESS_NUM-1];

initial begin
    // all APB input initialized to 0
    PSEL = 1'b0;
    PENABLE = 1'b0;
    PWRITE = 1'b0;
    PADDR = {ADDR_WIDTH{1'b0}};
    PWDATA = {DATA_WIDTH{1'b0}};

    // interrupt clear signal initialized to invalid(0)
    bus__mst__clear = 1'b0;

    // get external memory access addresses and expected values
    $readmemh("tb/access_addr_hex.txt", addrs);
    $readmemh("tb/expected_mem_value_hex.txt", expected_mem_value);
    $readmemh("tb/expected_read_value_hex.txt", expected_read_value);
end


/********************************************************************
********************* simulate APB interface ************************
*********************************************************************/
integer err_cnt;

initial begin
    err_cnt = 0;
    wait(rstn);

    // APB write operations to the external memory
    for (integer i = 0; i < EXT_MEM_ENTRY; i = i + 1) begin
        for (integer j = SNAPSHOT_ENTRY_NUM-1; j >= 0; j = j - 1) begin
            @(posedge clk); #1;
            PSEL = 1'b1;
            PENABLE = 1'b0;
            PWRITE = 1'b1;
            PADDR = addrs[i*SNAPSHOT_ENTRY_NUM+j];
            // write 0xffffffff to the external memory (ext_mem_1)
            PWDATA = {DATA_WIDTH{1'b1}};
            $display($time, " start write operation: addr=%h data=%h", PADDR, PWDATA);

            @(posedge clk); #1;
            PENABLE = 1'b1;

            wait(PREADY);
            @(posedge clk); #1;
            PSEL = 1'b0;
            $display($time, " end write operation");

            if (ext_mem_1.mem[i*SNAPSHOT_ENTRY_NUM+j] !=
                expected_mem_value[(i+1)*SNAPSHOT_ENTRY_NUM-1-j]) begin
                err_cnt = err_cnt + 1;
                $display($time, " error %1d: access addr=%h, mem expected=%h, actual=%h",
                         err_cnt, PADDR, expected_mem_value[(i+1)*SNAPSHOT_ENTRY_NUM-1-j],
                         ext_mem_1.mem[i*SNAPSHOT_ENTRY_NUM+j]);
            end
            // change memory values before last snapshot write operation
            if (j == 1) begin
               ext_mem_1.mem[i] = 128'haaaaaaaa_aaaaaaaa_aaaaaaaa_aaaaaaaa;
            end
        end
    end

    // NOTE: now all memory entries should be all 1s
    // APB read operations to the external memory
    for (integer i = 0; i < EXT_MEM_ENTRY; i = i + 1) begin
        for (integer j = 0; j <= SNAPSHOT_ENTRY_NUM-1; j = j + 1) begin
            @(posedge clk); #1;
            PSEL = 1'b1;
            PENABLE = 1'b0;
            PWRITE = 1'b0;
            PADDR = addrs[i*SNAPSHOT_ENTRY_NUM+j];
            $display($time, " start read operation: addr=%h", PADDR);

            @(posedge clk); #1;
            PENABLE = 1'b1;

            wait(PREADY);
            #0 $display($time, " read data=%h", PRDATA);
            if (PRDATA != expected_read_value[i*SNAPSHOT_ENTRY_NUM+j]) begin
                err_cnt = err_cnt + 1;
                $display($time, " error %1d: access addr=%h, mem expected=%h, actual=%h",
                         err_cnt, PADDR, expected_read_value[i*SNAPSHOT_ENTRY_NUM+j],
                         PRDATA);
            end

            @(posedge clk); #1;
            PSEL = 1'b0;
            $display($time, " end read operation");

            // change memory values after first snapshot read operation
            if (j == 0) begin
                ext_mem_1.mem[i] = 128'haaaaaaaa_aaaaaaaa_aaaaaaaa_aaaaaaaa;
            end
        end
    end

    $display("test process done, error count: %1d", err_cnt);
    #(CLK_PERIOD*2);
    $finish;
end

endmodule