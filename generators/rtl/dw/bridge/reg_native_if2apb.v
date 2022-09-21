module reg_native_if2apb (
    clk, rst_n,
    req_vld, ack_vld, soft_rst, wr_en, rd_en, addr, wr_data, rd_data, err,
    psel, penable, pready, pwrite, paddr, pwdata, prdata, pslverr
);
    parameter   ADDR_WIDTH  = 48;
    parameter   DATA_WIDTH  = 32;

    input   logic                       clk;
    input   logic                       rst_n;

    input   logic                       req_vld;
    output  logic                       ack_vld;
    input   logic                       soft_rst;
    input   logic                       wr_en;
    input   logic                       rd_en;
    input   logic   [ADDR_WIDTH-1:0]    addr;
    input   logic   [DATA_WIDTH-1:0]    wr_data;
    output  logic   [DATA_WIDTH-1:0]    rd_data;
    output  logic                       err;

    output  logic                       psel;
    output  logic                       penable;
    input   logic                       pready;
    output  logic                       pwrite;
    output  logic   [ADDR_WIDTH-1:0]    paddr;
    output  logic   [DATA_WIDTH-1:0]    pwdata;
    input   logic   [DATA_WIDTH-1:0]    prdata;
    input   logic                       pslverr;

    localparam  S_IDLE                  = 2'd0,
                S_SETUP                 = 2'd1,
                S_ACCESS                = 2'd2;

    logic   [1:0]                       state;
    logic   [1:0]                       next_state;

    // state register
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= S_IDLE;
        else if (soft_rst)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    // state transfer
    always_comb begin
        if (soft_rst)
            next_state  = S_IDLE;
        else begin
            case(state)
                S_IDLE: begin
                    if (req_vld)
                        next_state  = S_SETUP;
                    else
                        next_state  = S_IDLE;
                end
                S_SETUP: next_state = S_ACCESS;
                S_ACCESS: begin
                    if (pready && req_vld)
                        next_state  = S_SETUP;
                    else if (pready && !req_vld)
                        next_state  = S_IDLE;
                    else
                        next_state  = S_ACCESS;
                end
                default: next_state = S_IDLE;
            endcase
        end
    end

    // output logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            psel        <=  1'b0;
            pwrite      <=  1'b0;
            paddr       <=  {ADDR_WIDTH{1'b0}};
            pwdata      <=  {DATA_WIDTH{1'b0}};
        end else if (next_state == S_IDLE) begin
            psel        <=  1'b0;
            pwrite      <=  1'b0;
            paddr       <=  {ADDR_WIDTH{1'b0}};
            pwdata      <=  {DATA_WIDTH{1'b0}};
        end else if (next_state == S_SETUP) begin
            psel        <=  req_vld;
            pwrite      <=  wr_en;
            paddr       <=  addr;
            pwdata      <=  wr_data;
        end
    end

    assign  penable     = (state != S_SETUP);
    assign  rd_data     = prdata;
    assign  ack_vld     = (state == S_ACCESS) & pready;
    assign  err         = pslverr;
endmodule