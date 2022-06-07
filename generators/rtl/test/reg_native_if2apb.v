module reg_native_if2apb (
    clk, rst_n,
    req_vld, ack_vld, wr_en, rd_en, addr, wr_data, rd_data,
    PSEL, PENABLE, PREADY, PWRITE, PADDR, PWDATA, PRDATA
);
    parameter   ADDR_WIDTH  = 64;
    parameter   DATA_WIDTH  = 32;
    parameter   INSERT_FF   = 0;

    input   logic   clk;
    input   logic   rst_n;

    input   logic   req_vld;
    output  logic   ack_vld;
    input   logic   wr_en;
    input   logic   rd_en;
    input   logic   [ADDR_WIDTH-1:0]    addr;
    input   logic   [DATA_WIDTH-1:0]    wr_data;
    output  logic   [DATA_WIDTH-1:0]    rd_data;

    output  logic   PSEL;
    output  logic   PENABLE;
    input   logic   PREADY;
    output  logic   PWRITE;
    output  logic   [ADDR_WIDTH-1:0]    PADDR;
    output  logic   [DATA_WIDTH-1:0]    PWDATA;
    input   logic   [DATA_WIDTH-1:0]    PRDATA;

    localparam  S_IDLE      = 2'd0,
                S_SETUP     = 2'd1,
                S_ACCESS    = 2'd2;

    logic   [1:0]   state;
    logic   [1:0]   next_state;

    // state register
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end

    // state transfer
    always_comb begin
        case(state)
            S_IDLE: begin
                if (req_vld)
                    next_state = S_SETUP;
                else
                    next_state = S_IDLE;
            end
            S_SETUP: next_state = S_ACCESS;
            S_ACCESS: begin
                if (PREADY && req_vld)
                    next_state = S_SETUP;
                else if (PREADY && !req_vld)
                    next_state = S_IDLE;
                else
                    next_state = S_ACCESS;
            end
            default: next_state = S_IDLE;
        endcase
    end

    // output logic

    // convert wr_en, rd_en, wr_data, rd_data to
    // PWRITE, PWDATA, PRDATA
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            PSEL    <=  1'b0;
            PWRITE  <=  1'b0;
            PADDR   <=  {ADDR_WIDTH{1'b0}};
            PWDATA  <=  {DATA_WIDTH{1'b0}};
        end else if (next_state == S_SETUP) begin
            PSEL    <=  req_vld;
            PWRITE  <=  wr_en;
            PADDR   <=  addr;
            PWDATA  <=  wr_data;
        end
    end

    assign PENABLE = (state == S_ACCESS);
    assign rd_data = PRDATA;
    assign ack_vld = PREADY;

endmodule