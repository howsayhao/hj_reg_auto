module reg_native_if2apb (
    native_clk, native_rst_n,
    req_vld, ack_vld, soft_rst, wr_en, rd_en, addr, wr_data, rd_data, err, non_sec,
    pclk, presetn,
    psel, penable, pready, pwrite, paddr, pwdata, prdata, pslverr, pprot,
    domain_is_non_secure, error_report_en
);
    parameter       CDC_ENABLE          = 0;
    parameter       ADDR_WIDTH          = 48;
    parameter       DATA_WIDTH          = 32;
    parameter       SECURE_ACCESS_CHECK = 1;

    input   logic                       native_clk;
    input   logic                       native_rst_n;
    input   logic                       req_vld;
    output  logic                       ack_vld;
    input   logic                       soft_rst;
    input   logic                       wr_en;
    input   logic                       rd_en;
    input   logic   [ADDR_WIDTH-1:0]    addr;
    input   logic   [DATA_WIDTH-1:0]    wr_data;
    output  logic   [DATA_WIDTH-1:0]    rd_data;
    output  logic                       err;
    input   logic                       non_sec;

    input   logic                       pclk;
    input   logic                       presetn;
    output  logic                       psel;
    output  logic                       penable;
    input   logic                       pready;
    output  logic                       pwrite;
    output  logic   [ADDR_WIDTH-1:0]    paddr;
    output  logic   [DATA_WIDTH-1:0]    pwdata;
    input   logic   [DATA_WIDTH-1:0]    prdata;
    input   logic                       pslverr;
    output  logic   [2:0]               pprot;

    input   logic                       domain_is_non_secure;
    input   logic                       error_report_en;

    localparam      S_IDLE              = 2'd0,
                    S_SETUP             = 2'd1,
                    S_ACCESS            = 2'd2;

    logic                               req_vld_i0;
    logic                               ack_vld_i0;
    logic                               soft_rst_i0;
    logic                               wr_en_i0;
    logic                               rd_en_i0;
    logic           [ADDR_WIDTH-1:0]    addr_i0;
    logic           [DATA_WIDTH-1:0]    wr_data_i0;
    logic           [DATA_WIDTH-1:0]    rd_data_i0;
    logic                               err_i0;
    logic                               non_sec_i0;
    logic           [1:0]               state;
    logic           [1:0]               next_state;

//************************************SECURE_ACCESS_CHECK*********************************************//
//***********************************CLOCK DOMAIN CROSSING********************************************//
    reg_native_if_1to1 #(
        .CDC_ENABLE                             (CDC_ENABLE),
        .BUS_ADDR_WIDTH                         (ADDR_WIDTH),
        .BUS_DATA_WIDTH                         (DATA_WIDTH),
        .SECURE_ACCESS_CHECK                    (SECURE_ACCESS_CHECK)
    )
    reg_native_if_1to1 (
        .native_clk                             (native_clk),
        .native_rst_n                           (native_rst_n),
        .soft_rst                               (1'b0),
        .req_vld                                (req_vld),
        .ack_vld                                (ack_vld),
        .err                                    (err),
        .addr                                   (addr),
        .wr_en                                  (wr_en),
        .rd_en                                  (rd_en),
        .wr_data                                (wr_data),
        .rd_data                                (rd_data),
        .non_sec                                (non_sec),
        .ext_clk                                (pclk),
        .ext_rst_n                              (presetn),
        .ext_soft_rst                           (soft_rst_i0),
        .ext_req_vld                            (req_vld_i0),
        .ext_ack_vld                            (ack_vld_i0),
        .ext_err                                (err_i0),
        .ext_addr                               (addr_i0),
        .ext_wr_en                              (wr_en_i0),
        .ext_rd_en                              (rd_en_i0),
        .ext_wr_data                            (wr_data_i0),
        .ext_rd_data                            (rd_data_i0),
        .ext_non_sec                            (non_sec_i0),
        .domain_is_non_secure                   (domain_is_non_secure),
        .error_report_en                        (error_report_en)
    );

    always_ff @(posedge pclk or negedge presetn) begin
        if (~presetn)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    always_comb begin
        if (soft_rst)
            next_state  = S_IDLE;
        else begin
            case(state)
                S_IDLE: begin
                    if (req_vld_i0)
                        next_state  = S_SETUP;
                    else
                        next_state  = S_IDLE;
                end
                S_SETUP: next_state = S_ACCESS;
                S_ACCESS: begin
                    if (pready && req_vld_i0)
                        next_state  = S_SETUP;
                    else if (pready & ~req_vld_i0)
                        next_state  = S_IDLE;
                    else
                        next_state  = S_ACCESS;
                end
                default: next_state = S_IDLE;
            endcase
        end
    end

    always_ff @(posedge pclk or negedge presetn) begin
        if (~presetn) begin
            psel        <=  1'b0;
            pwrite      <=  1'b0;
            paddr       <=  {ADDR_WIDTH{1'b0}};
            pwdata      <=  {DATA_WIDTH{1'b0}};
            pprot       <=  3'b0;
        end else if (next_state == S_IDLE) begin
            psel        <=  1'b0;
            pwrite      <=  1'b0;
            paddr       <=  {ADDR_WIDTH{1'b0}};
            pwdata      <=  {DATA_WIDTH{1'b0}};
            pprot       <=  3'b0;
        end else if (next_state == S_SETUP) begin
            psel        <=  req_vld_i0;
            pwrite      <=  wr_en_i0;
            paddr       <=  addr_i0;
            pwdata      <=  wr_data_i0;
            pprot       <=  {1'b0, non_sec_i0, 1'b0};
        end
    end

    assign  penable     = (state != S_SETUP);
    assign  rd_data_i0  = prdata;
    assign  ack_vld_i0  = (state == S_ACCESS) & pready;
    assign  err_i0      = pslverr;
endmodule