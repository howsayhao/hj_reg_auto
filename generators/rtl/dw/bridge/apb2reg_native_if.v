`default_nettype none
module apb2reg_native_if (
    pclk, presetn,
    psel, penable, pready, pwrite, paddr, pwdata, prdata, pslverr, pprot,
    native_clk, native_rst_n,
    req_vld, ack_vld, wr_en, rd_en, addr, wr_data, rd_data, err, non_sec,
    domain_is_non_secure, error_report_en
);
    parameter       CDC_ENABLE          = 0;
    parameter       ADDR_WIDTH          = 48;
    parameter       DATA_WIDTH          = 32;
    parameter       SECURE_ACCESS_CHECK = 1;

    input   logic                       pclk;
    input   logic                       presetn;
    input   logic                       psel;
    input   logic                       penable;
    output  logic                       pready;
    input   logic                       pwrite;
    input   logic   [ADDR_WIDTH-1:0]    paddr;
    input   logic   [DATA_WIDTH-1:0]    pwdata;
    output  logic   [DATA_WIDTH-1:0]    prdata;
    output  logic                       pslverr;
    input   logic   [2:0]               pprot;

    input   logic                       native_clk;
    input   logic                       native_rst_n;
    output  logic                       req_vld;
    input   logic                       ack_vld;
    output  logic                       wr_en;
    output  logic                       rd_en;
    output  logic   [ADDR_WIDTH-1:0]    addr;
    output  logic   [DATA_WIDTH-1:0]    wr_data;
    input   logic   [DATA_WIDTH-1:0]    rd_data;
    input   logic                       err;
    output  logic                       non_sec;

    input   logic                       domain_is_non_secure;
    input   logic                       error_report_en;

    logic                               req_vld_i0;
    logic                               ack_vld_i0;
    logic                               wr_en_i0;
    logic                               rd_en_i0;
    logic           [ADDR_WIDTH-1:0]    addr_i0;
    logic           [DATA_WIDTH-1:0]    wr_data_i0;
    logic           [DATA_WIDTH-1:0]    rd_data_i0;
    logic           [DATA_WIDTH-1:0]    rd_data_i0_ff;
    logic                               err_i0;
    logic                               err_i0_ff;
    logic                               non_sec_i0;
    logic           [1:0]               state;
    logic           [1:0]               next_state;

    localparam      S_IDLE              = 2'd0,
                    S_WAIT              = 2'd1,
                    S_ACK               = 2'd2;

    always_ff @(posedge pclk or negedge presetn) begin
        if (~presetn)
            state   <= S_IDLE;
        else
            state   <= next_state;
    end

    always_comb begin
        case (state)
            S_IDLE:
                if (psel & ~penable)
                    if (ack_vld_i0)
                        next_state  = S_ACK;
                    else
                        next_state  = S_WAIT;
                else
                    next_state      = S_IDLE;
            S_WAIT:
                if (ack_vld_i0)
                    next_state  = S_IDLE;
                else
                    next_state  = S_WAIT;
            S_ACK:
                next_state      = S_IDLE;
            default:
                next_state      = S_IDLE;
        endcase
    end

    always_ff @(posedge pclk or negedge presetn) begin
        if (~presetn) begin
            rd_data_i0_ff   <= {DATA_WIDTH{1'b0}};
            err_i0_ff       <= 1'b0;
        end else begin
            rd_data_i0_ff   <= rd_data_i0;
            err_i0_ff       <= err_i0;
        end
    end

    assign  req_vld_i0      = psel & ~penable;
    assign  wr_en_i0        = psel & ~penable & pwrite;
    assign  rd_en_i0        = psel & ~penable & ~pwrite;
    assign  addr_i0         = (psel & ~penable) ? paddr : {ADDR_WIDTH{1'b0}};
    assign  wr_data_i0      = (psel & ~penable) ? pwdata : {DATA_WIDTH{1'b0}};
    assign  pready          = (state == S_IDLE) || (state == S_ACK) || (state == S_WAIT && next_state == S_IDLE);
    assign  prdata          = (state == S_ACK) ? rd_data_i0_ff : ((state == S_WAIT && next_state == S_IDLE) ? rd_data_i0 : {DATA_WIDTH{1'b0}});
    assign  pslverr         = (state == S_ACK) ? err_i0_ff : ((state == S_WAIT && next_state == S_IDLE) ? err_i0 : 1'b0);
    assign  non_sec_i0      = psel & ~penable & pprot[1];

//************************************SECURE_ACCESS_CHECK*********************************************//
//***********************************CLOCK DOMAIN CROSSING********************************************//
    reg_native_if_1to1 #(
        .CDC_ENABLE                             (CDC_ENABLE),
        .BUS_ADDR_WIDTH                         (ADDR_WIDTH),
        .BUS_DATA_WIDTH                         (DATA_WIDTH),
        .SECURE_ACCESS_CHECK                    (SECURE_ACCESS_CHECK)
    )
    reg_native_if_1to1 (
        .native_clk                             (pclk),
        .native_rst_n                           (presetn),
        .soft_rst                               (1'b0),
        .req_vld                                (req_vld_i0),
        .ack_vld                                (ack_vld_i0),
        .err                                    (err_i0),
        .addr                                   (addr_i0),
        .wr_en                                  (wr_en_i0),
        .rd_en                                  (rd_en_i0),
        .wr_data                                (wr_data_i0),
        .rd_data                                (rd_data_i0),
        .non_sec                                (non_sec_i0),
        .ext_clk                                (native_clk),
        .ext_rst_n                              (native_rst_n),
        .ext_soft_rst                           (),
        .ext_req_vld                            (req_vld),
        .ext_ack_vld                            (ack_vld),
        .ext_err                                (err),
        .ext_addr                               (addr),
        .ext_wr_en                              (wr_en),
        .ext_rd_en                              (rd_en),
        .ext_wr_data                            (wr_data),
        .ext_rd_data                            (rd_data),
        .ext_non_sec                            (non_sec),
        .domain_is_non_secure                   (domain_is_non_secure),
        .error_report_en                        (error_report_en)
    );
endmodule
`default_nettype wire