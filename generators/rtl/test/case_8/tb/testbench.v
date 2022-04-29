// testbench for case 8: snapshot register dealing with data width
// mismatch between APB interface and internal registers/external memories
//
// upper bus interface: APB
//      addr width: 32
//      data width: 64
// internal register:
//      entry: 1
//      data width: 64
//      number of bus access: 2
//      number of bus entry in snapshot module: 2
// external memory:
//      addr width: 1
//      entry: 2
//      data width: 128
//      number of bus access: 8
//      number of bus entry in snapshot module: 4
`timescale 1ns/1ns

module reg_tb;

// bus definition
parameter BUS_ADDR_WIDTH = 64;
parameter BUS_DATA_WIDTH = 32;

// internal register definition
parameter INT_REG_ENTRY = 1;
parameter INT_REG_DATA_WIDTH = 64;
parameter INT_ACCESS_NUM = 2;
parameter INT_SNAPSHOT_BUS_ENTRY = INT_ACCESS_NUM / INT_REG_ENTRY;

// external memory definition
parameter EXT_MEM_ADDR_WIDTH = 1;
parameter EXT_MEM_ENTRY = 1 << EXT_MEM_ADDR_WIDTH;
parameter EXT_MEM_DATA_WIDTH = 128;
parameter EXT_ACCESS_NUM = 8;
parameter EXT_MEM_SNAPSHOT_BUS_ENTRY = EXT_ACCESS_NUM / EXT_MEM_ENTRY;

parameter TOTAL_ACCESS_NUM = INT_ACCESS_NUM + EXT_ACCESS_NUM;


logic clk;
logic rstn;

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
// bus interface:
//      APB interface: testbench stimulus <-> regmst_reg_top
//      reg_native_if: regmst_reg_top <-> regslv_reg_top__reg_block_1
// directly connected upstream:
//      APB interface
// directly connected downstream:
//      regslv: regslv_reg_top__reg_block_1
// other signals:
//      interrupt, glb_srst, clear
parameter REGMST_REG_TOP_INT_NUM = 0;
parameter REGMST_REG_TOP_EXT_NUM = 1;

logic reg_top__reg_block_1_req_vld;
logic reg_top__reg_block_1_req_rdy;
logic reg_top__reg_block_1_ack_vld;
logic reg_top__reg_block_1_ack_rdy;
logic reg_top__reg_block_1_wr_en;
logic reg_top__reg_block_1_rd_en;
logic [BUS_ADDR_WIDTH-1:0] reg_top__reg_block_1_addr;
logic [BUS_DATA_WIDTH-1:0] reg_top__reg_block_1_wr_data;
logic [BUS_DATA_WIDTH-1:0] reg_top__reg_block_1_rd_data;

regmst_reg_top #(
    .ADDR_WIDTH(BUS_ADDR_WIDTH),
    .DATA_WIDTH(BUS_DATA_WIDTH))
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
    .interrupt(reg_top__bus__interrupt),
    .clear(bus__reg_top__clear),
    .global_sync_reset_out(reg_top__downstream__glb_srst),
    // clock domain crossing signal
    .cdc_pulse_out(),
    // reg_native_if connected to external memory and downstream regslv
    .reg_block_1_req_vld(reg_top__reg_block_1_req_vld),
    .reg_block_1_req_rdy(reg_top__reg_block_1_req_rdy),
    .reg_block_1_ack_vld(reg_top__reg_block_1_ack_vld),
    .reg_block_1_ack_rdy(reg_top__reg_block_1_ack_rdy),
    .reg_block_1_wr_en(reg_top__reg_block_1_wr_en),
    .reg_block_1_rd_en(reg_top__reg_block_1_rd_en),
    .reg_block_1_addr(reg_top__reg_block_1_addr),
    .reg_block_1_wr_data(reg_top__reg_block_1_wr_data),
    .reg_block_1_rd_data(reg_top__reg_block_1_rd_data)
);


// module: regslv_reg_top__reg_block_1 DUT
// bus interface:
//      reg_native_if: regmst_reg_top <-> regslv_reg_top__reg_block_1
//      reg_native_if: regslv_reg_top__reg_block_1 <-> ext_mem_1
// directly connected upstream:
//      regmst: regmst_reg_top
// directly connected downstream:
//      external memory: ext_mem_1
// other signals:
//      input glb_srst, output glb_srst,
//      hardware access ports for internal registers
parameter REGSLV_REG_BLOCK_1_EXT_NUM = 1;
parameter REGSLV_REG_BLOCK_1_INT_NUM = 1;

logic regslv_reg_top__reg_block_1__ext_mem_1_req_vld;
logic regslv_reg_top__reg_block_1__ext_mem_1_req_rdy;
logic regslv_reg_top__reg_block_1__ext_mem_1_ack_vld;
logic regslv_reg_top__reg_block_1__ext_mem_1_ack_rdy;
logic regslv_reg_top__reg_block_1__ext_mem_1_wr_en;
logic regslv_reg_top__reg_block_1__ext_mem_1_rd_en;
logic [EXT_MEM_ADDR_WIDTH-1:0] regslv_reg_top__reg_block_1__ext__addr;
logic [EXT_MEM_DATA_WIDTH-1:0] regslv_reg_top__reg_block_1__ext__wr_data;
logic [EXT_MEM_DATA_WIDTH-1:0] regslv_reg_top__reg_block_1__ext__rd_data;

logic regslv_reg_top__reg_block_1__ext__glb_srst;

logic [INT_REG_DATA_WIDTH-1:0] REG1__FIELD_0__next_value;
logic REG1__FIELD_0__pulse;
logic [INT_REG_DATA_WIDTH-1:0] REG1__FIELD_0__curr_value;

regslv_reg_top__reg_block_1 #(
    .ADDR_WIDTH(BUS_ADDR_WIDTH),
    .DATA_WIDTH(BUS_DATA_WIDTH))
regslv_reg_top__reg_block_1_dut (
    .clk(clk),
    .rstn(rstn),
    // upstream reg_native_if (from regmst_reg_top)
    .req_vld(reg_top__reg_block_1_req_vld),
    .req_rdy(reg_top__reg_block_1_req_rdy),
    .ack_vld(reg_top__reg_block_1_ack_vld),
    .ack_rdy(reg_top__reg_block_1_ack_rdy),
    .wr_en(reg_top__reg_block_1_wr_en),
    .rd_en(reg_top__reg_block_1_rd_en),
    .addr(reg_top__reg_block_1_addr),
    .wr_data(reg_top__reg_block_1_wr_data),
    .rd_data(reg_top__reg_block_1_rd_data),
    // synchronous reset signals
    .global_sync_reset_in(reg_top__downstream__glb_srst),
    .global_sync_reset_out(regslv_reg_top__reg_block_1__ext__glb_srst),
    // clock domain crossing signal
    .cdc_pulse_out(),
    // external memory reg_native_if
    .ext_mem_1_req_vld(regslv_reg_top__reg_block_1__ext_mem_1_req_vld),
    .ext_mem_1_req_rdy(regslv_reg_top__reg_block_1__ext_mem_1_req_rdy),
    .ext_mem_1_ack_vld(regslv_reg_top__reg_block_1__ext_mem_1_ack_vld),
    .ext_mem_1_ack_rdy(regslv_reg_top__reg_block_1__ext_mem_1_ack_rdy),
    .ext_mem_1_wr_en(regslv_reg_top__reg_block_1__ext_mem_1_wr_en),
    .ext_mem_1_rd_en(regslv_reg_top__reg_block_1__ext_mem_1_rd_en),
    .ext_mem_1_addr(regslv_reg_top__reg_block_1__ext__addr),
    .ext_mem_1_wr_data(regslv_reg_top__reg_block_1__ext__wr_data),
    .ext_mem_1_rd_data(regslv_reg_top__reg_block_1__ext__rd_data),
    // hardware access ports
    .REG1__FIELD_0__next_value(REG1__FIELD_0__next_value),
	.REG1__FIELD_0__pulse(REG1__FIELD_0__pulse),
	.REG1__FIELD_0__curr_value(REG1__FIELD_0__curr_value)
);


// module: ext_mem_1 DUT
// bus interface:
//      reg_native_if: regslv_reg_top__reg_block_1 <-> ext_mem_1
// directly connected upstream:
//      snapshot register: regslv_reg_top__reg_block_1
ext_mem #(
    .DATA_WIDTH(EXT_MEM_DATA_WIDTH),
    .ADDR_WIDTH(EXT_MEM_ADDR_WIDTH))
ext_mem_1 (
    .clk(clk),
    .req_vld(regslv_reg_top__reg_block_1__ext_mem_1_req_vld),
    .req_rdy(regslv_reg_top__reg_block_1__ext_mem_1_req_rdy),
    .ack_vld(regslv_reg_top__reg_block_1__ext_mem_1_ack_vld),
    .ack_rdy(regslv_reg_top__reg_block_1__ext_mem_1_ack_rdy),
    .wr_en(regslv_reg_top__reg_block_1__ext_mem_1_wr_en),
    .rd_en(regslv_reg_top__reg_block_1__ext_mem_1_rd_en),
    .addr(regslv_reg_top__reg_block_1__ext__addr),
    .wr_data(regslv_reg_top__reg_block_1__ext__wr_data),
    .rd_data(regslv_reg_top__reg_block_1__ext__rd_data)
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

reg [BUS_ADDR_WIDTH-1:0] addrs [0:TOTAL_ACCESS_NUM-1];
reg [INT_REG_DATA_WIDTH-1:0] expected_reg_value [0:INT_ACCESS_NUM-1];
reg [EXT_MEM_DATA_WIDTH-1:0] expected_mem_value [0:EXT_ACCESS_NUM-1];
reg [BUS_DATA_WIDTH-1:0] expected_read_value [0:TOTAL_ACCESS_NUM-1];

initial begin
    // all APB input initialized to 0
    PSEL = 1'b0;
    PENABLE = 1'b0;
    PWRITE = 1'b0;
    PADDR = {BUS_ADDR_WIDTH{1'b0}};
    PWDATA = {BUS_DATA_WIDTH{1'b0}};

    // interrupt clear signal initialized to 0
    bus__reg_top__clear = 1'b0;

    // all register hardware ports initialized to 0
    REG1__FIELD_0__next_value = 64'h0;
    REG1__FIELD_0__pulse = 1'b0;

    // get addresses, expected mem/reg values and bus read values
    $readmemh("tb/access_addr_hex.txt", addrs);
    $readmemh("tb/expected_mem_value_hex.txt", expected_mem_value);
    $readmemh("tb/expected_reg_value_hex.txt", expected_reg_value);
    $readmemh("tb/expected_read_value_hex.txt", expected_read_value);
end


/********************************************************************
********************* simulate APB interface ************************
*********************************************************************/
integer err_cnt;

task apb_write (
    input [BUS_ADDR_WIDTH-1:0] wr_addr,
    input [BUS_DATA_WIDTH-1:0] wr_data);

    @(posedge clk); #1;
    PSEL = 1'b1;
    PENABLE = 1'b0;
    PWRITE = 1'b1;
    PADDR = wr_addr;
    PWDATA = wr_data;
    $display($time, " start write operation: addr=%h data=%h", PADDR, PWDATA);

    @(posedge clk); #1;
    PENABLE = 1'b1;

    wait(PREADY);
    @(posedge clk); #1;
    PSEL = 1'b0;
    $display($time, " end write operation");
endtask

task apb_read (
    input [BUS_ADDR_WIDTH-1:0] rd_addr,
    input [BUS_DATA_WIDTH-1:0] expected_val);

    @(posedge clk); #1;
    PSEL = 1'b1;
    PENABLE = 1'b0;
    PWRITE = 1'b0;
    PADDR = rd_addr;
    $display($time, " start read operation: addr=%h", PADDR);

    @(posedge clk); #1;
    PENABLE = 1'b1;

    wait(PREADY);
    #1 $display($time, " read data=%h", PRDATA);
    if (PRDATA != expected_val) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: access addr=%h, expected=%h, actual=%h",
                 err_cnt, PADDR, expected_val, PRDATA);
    end
    @(posedge clk); #1;
    PSEL = 1'b0;
    $display($time, " end read operation");
endtask

task hw_reg_write (
    input [INT_REG_DATA_WIDTH-1:0] val,
    ref pulse,
    ref [INT_REG_DATA_WIDTH-1:0] hw_acc_port);

    @(posedge clk); #1;
    hw_acc_port = val;
    pulse = 1'b1;
    @(posedge clk); #1;
    pulse = 1'b0;
endtask

initial begin
    err_cnt = 0;
    wait(rstn);

    // APB write operations to the internal register: high addr
    apb_write(addrs[1], 32'h1111_1111);
    if (expected_reg_value[0] != REG1__FIELD_0__curr_value) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: access addr=%h, expected=%h, actual=%h",
                 err_cnt, PADDR, expected_reg_value[0],
                 REG1__FIELD_0__curr_value);
    end

    // change register values during two write operations
    hw_reg_write(64'haaaaaaaa_aaaaaaaa, REG1__FIELD_0__pulse, REG1__FIELD_0__next_value);

    // APB write operations to the internal register: low addr
    apb_write(addrs[0], 32'h2222_2222);
    if (expected_reg_value[1] != REG1__FIELD_0__curr_value) begin
        err_cnt = err_cnt + 1;
        $display($time, " error %1d: access addr=%h, expected=%h, actual=%h",
                 err_cnt, PADDR, expected_reg_value[1],
                 REG1__FIELD_0__curr_value);
    end

    // APB read operations to the internal register: low addr
    apb_read(addrs[0], expected_read_value[0]);

    // change register values during two read operations
    hw_reg_write(64'haaaaaaaa_aaaaaaaa, REG1__FIELD_0__pulse, REG1__FIELD_0__next_value);

    // APB read operations to the internal register: high addr
    apb_read(addrs[1], expected_read_value[1]);


    // APB write operations to the external memory
    for (integer i = 0; i < EXT_MEM_ENTRY; i = i + 1) begin
        for (integer j = EXT_MEM_SNAPSHOT_BUS_ENTRY-1; j >= 0; j = j - 1) begin
            // write 0xffffffff to the external memory (ext_mem_1)
            apb_write(addrs[i*EXT_MEM_SNAPSHOT_BUS_ENTRY+j+INT_ACCESS_NUM],
                      {BUS_DATA_WIDTH{1'b1}});

            if (ext_mem_1.mem[i*EXT_MEM_SNAPSHOT_BUS_ENTRY+j] !=
                expected_mem_value[(i+1)*EXT_MEM_SNAPSHOT_BUS_ENTRY-1-j]) begin
                err_cnt = err_cnt + 1;
                $display($time, " error %1d: access addr=%h, mem expected=%h, actual=%h",
                         err_cnt, PADDR, expected_mem_value[(i+1)*EXT_MEM_SNAPSHOT_BUS_ENTRY-1-j],
                         ext_mem_1.mem[i*EXT_MEM_SNAPSHOT_BUS_ENTRY+j]);
            end
            // change memory values before last snapshot write operation
            if (j == 1) begin
               ext_mem_1.mem[i] = 128'haaaaaaaa_aaaaaaaa_aaaaaaaa_aaaaaaaa;
            end
        end
    end

    // NOTE: now all memory entries should be all 1's
    // APB read operations to the external memory
    for (integer i = 0; i < EXT_MEM_ENTRY; i = i + 1) begin
        for (integer j = 0; j <= EXT_MEM_SNAPSHOT_BUS_ENTRY-1; j = j + 1) begin
            apb_read(addrs[i*EXT_MEM_SNAPSHOT_BUS_ENTRY+j+INT_ACCESS_NUM],
                     expected_read_value[i*EXT_MEM_SNAPSHOT_BUS_ENTRY+j+INT_ACCESS_NUM]);

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