`default_nettype none
module reg_native_if_1to1 (
    // native clock domain
    native_clk, native_rst_n, soft_rst,
    req_vld, ack_vld, err, addr, wr_en, rd_en, wr_data, rd_data, non_sec,
    // target clock domain
    ext_clk, ext_rst_n, ext_soft_rst,
    ext_req_vld, ext_ack_vld, ext_err, ext_addr, ext_wr_en, ext_rd_en, ext_wr_data, ext_rd_data, ext_non_sec,
    // side band signal at native clock domain
    domain_is_non_secure,   // whether downstream space is non-secure, at native clock domain
    error_report_en         // whether downstream error can be delivered to upstream, at native clock domain
);
    parameter   CDC_ENABLE                  = 0;
    parameter   BUS_DATA_WIDTH              = 32;
    parameter   BUS_ADDR_WIDTH              = 48;
    parameter   SECURE_ACCESS_CHECK         = 1;

    input   logic                           native_clk;
    input   logic                           native_rst_n;
    input   logic                           soft_rst;
    input   logic                           req_vld;
    output  logic                           ack_vld;
    output  logic                           err;
    input   logic   [BUS_ADDR_WIDTH-1:0]    addr;
    input   logic                           wr_en;
    input   logic                           rd_en;
    input   logic   [BUS_DATA_WIDTH-1:0]    wr_data;
    output  logic   [BUS_DATA_WIDTH-1:0]    rd_data;
    input   logic                           non_sec;

    input   logic                           ext_clk;
    input   logic                           ext_rst_n;
    output  logic                           ext_soft_rst;
    output  logic                           ext_req_vld;
    input   logic                           ext_ack_vld;
    input   logic                           ext_err;
    output  logic   [BUS_ADDR_WIDTH-1:0]    ext_addr;
    output  logic                           ext_wr_en;
    output  logic                           ext_rd_en;
    output  logic   [BUS_DATA_WIDTH-1:0]    ext_wr_data;
    input   logic   [BUS_DATA_WIDTH-1:0]    ext_rd_data;
    output  logic                           ext_non_sec;

    input   logic                           domain_is_non_secure;
    input   logic                           error_report_en;

    logic                                   req_vld_i0;
    logic                                   wr_en_i0;
    logic                                   rd_en_i0;
    logic                                   non_sec_i0;
    logic                                   ack_vld_i0;
    logic                                   err_i0;
    logic                                   err_i1;
    logic           [BUS_DATA_WIDTH-1:0]    rd_data_i0;

    assign  err = err_i1 & error_report_en;

//****************************************************SECURE ACCESS CHECK***************************************************//
    generate
        if (SECURE_ACCESS_CHECK) begin: g_sec_acc_check
            always_comb begin
                if (req_vld & ~domain_is_non_secure & non_sec) begin
                    req_vld_i0  = 1'b0;
                    wr_en_i0    = 1'b0;
                    rd_en_i0    = 1'b0;
                    non_sec_i0  = 1'b0;
                    ack_vld     = 1'b1;
                    err_i1      = 1'b1;
                    rd_data     = {BUS_DATA_WIDTH{1'b0}};
                end
                else begin
                    req_vld_i0  = req_vld;
                    wr_en_i0    = wr_en;
                    rd_en_i0    = rd_en;
                    non_sec_i0  = non_sec;
                    ack_vld     = ack_vld_i0;
                    err_i1      = err_i0;
                    rd_data     = rd_data_i0;
                end
            end
        end
        else begin: g_no_sec_acc_check
            assign  req_vld_i0  = req_vld;
            assign  wr_en_i0    = wr_en;
            assign  rd_en_i0    = rd_en;
            assign  non_sec_i0  = non_sec;
            assign  ack_vld     = ack_vld_i0;
            assign  err_i1      = err_i0;
            assign  rd_data     = rd_data_i0;
        end
    endgenerate

//***************************************************CLOCK DOMAIN CROSSING**************************************************//
    generate
        if (CDC_ENABLE) begin: g_cdc
            localparam  VD_FORWARD_WIDTH    = BUS_ADDR_WIDTH + BUS_DATA_WIDTH + 3;
            localparam  VD_BACKWARD_WIDTH   = BUS_DATA_WIDTH + 1;

            logic   [VD_FORWARD_WIDTH-1:0]  value_deliver_o_value_in;
            logic   [VD_FORWARD_WIDTH-1:0]  value_deliver_o_value_out;
            logic   [VD_BACKWARD_WIDTH-1:0] value_deliver_i_value_in;
            logic   [VD_BACKWARD_WIDTH-1:0] value_deliver_i_value_out;

            // deliver soft_rst independently
            pulse_deliver_1bit pulse_deliver_soft_rst (
                .scan_enable                (1'b0),
                .clk_a                      (native_clk),
                .rst_a_n                    (native_rst_n),
                .pulse_in                   (soft_rst),
                .clk_b                      (ext_clk),
                .rst_b_n                    (ext_rst_n),
                .pulse_out                  (ext_soft_rst)
            );

            // deliver reg_native_if request control, write data and addr
            // from native to target clock domain
            assign  value_deliver_o_value_in = {wr_en_i0, rd_en_i0, non_sec_i0, wr_data, addr};
            value_deliver_1cycle #(
                .WIDTH                      (VD_FORWARD_WIDTH)
            ) value_deliver_o (
                .scan_enable                (1'b0),
                .clk_a                      (native_clk),
                .rst_a_n                    (native_rst_n),
                .pulse_in                   (req_vld_i0),
                .value_in                   (value_deliver_o_value_in),
                .clk_b                      (ext_clk),
                .rst_b_n                    (ext_rst_n),
                .pulse_out                  (ext_req_vld),
                .value_out                  (value_deliver_o_value_out)
            );
            assign  {ext_wr_en, ext_rd_en, ext_non_sec, ext_wr_data, ext_addr} = value_deliver_o_value_out;

            // deliver reg_native_if ack control and read data
            // from target to native clock domain
            assign  value_deliver_i_value_in = {ext_err, ext_rd_data};
            value_deliver_1cycle #(
                .WIDTH                      (VD_BACKWARD_WIDTH)
            ) value_deliver_i (
                .scan_enable                (1'b0),
                .clk_a                      (ext_clk),
                .rst_a_n                    (ext_rst_n),
                .pulse_in                   (ext_ack_vld),
                .value_in                   (value_deliver_i_value_in),
                .clk_b                      (native_clk),
                .rst_b_n                    (native_rst_n),
                .pulse_out                  (ack_vld_i0),
                .value_out                  (value_deliver_i_value_out)
            );
            assign  {err_i0, rd_data} = value_deliver_i_value_out;

        end else begin: g_no_cdc
            assign  ext_soft_rst            = soft_rst;
            assign  ext_req_vld             = req_vld_i0;
            assign  ext_wr_en               = wr_en_i0;
            assign  ext_rd_en               = rd_en_i0;
            assign  ext_non_sec             = non_sec_i0;
            assign  ext_addr                = addr;
            assign  ext_wr_data             = wr_data;
            assign  ack_vld_i0              = ext_ack_vld;
            assign  err_i0                  = ext_err;
            assign  rd_data_i0              = ext_rd_data;
        end
    endgenerate
endmodule
`default_nettype wire