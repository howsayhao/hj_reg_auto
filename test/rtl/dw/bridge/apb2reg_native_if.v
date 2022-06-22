module apb2reg_native_if (
    PSEL, PENABLE, PREADY, PWRITE, PADDR, PWDATA, PRDATA,
    req_vld, ack_vld, wr_en, rd_en, addr, wr_data, rd_data
);
    parameter   ADDR_WIDTH  = 64;
    parameter   DATA_WIDTH  = 32;

    input   logic   clk;
    input   logic   rst_n;

    output  logic   req_vld;
    input   logic   ack_vld;
    output  logic   wr_en;
    output  logic   rd_en;
    output  logic   [ADDR_WIDTH-1:0]    addr;
    output  logic   [DATA_WIDTH-1:0]    wr_data;
    input   logic   [DATA_WIDTH-1:0]    rd_data;

    input   logic   PSEL;
    input   logic   PENABLE;
    output  logic   PREADY;
    input   logic   PWRITE;
    input   logic   [ADDR_WIDTH-1:0]    PADDR;
    input   logic   [DATA_WIDTH-1:0]    PWDATA;
    output  logic   [DATA_WIDTH-1:0]    PRDATA;


    assign  req_vld = PSEL & ~PENABLE;
    assign  wr_en   = PSEL & ~PENABLE & PWRITE;
    assign  rd_en   = PSEL & ~PENABLE & ~PWRITE;
    assign  addr    = (PSEL & ~PENABLE) ? PADDR : {ADDR_WIDTH{1'b0}};
    assign  wr_data = (PSEL & ~PENABLE) ? PWDATA : {DATA_WIDTH{1'b0}};
    assign  PREADY  = ack_vld;
    assign  PRDATA  = rd_data;

endmodule