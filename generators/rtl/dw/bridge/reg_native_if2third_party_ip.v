`default_nettype none
module reg_native_if2third_party_ip (
    // native domain
    native_clk, native_rst_n,
    req_vld, ack_vld, err, addr, wr_en, rd_en, wr_data, rd_data,
    // target domain
    ext_clk, ext_rst_n,
    ext_req_vld, ext_ack_vld, ext_err, ext_addr, ext_wr_en, ext_rd_en, ext_wr_data, ext_rd_data
);
    parameter   CDC_ENABLE                  = 0;
    parameter   BUS_DATA_WIDTH              = 32;
    parameter   BUS_ADDR_WIDTH              = 64;

    input   logic                           native_clk;
    input   logic                           native_rst_n;
    input   logic                           req_vld;
    output  logic                           ack_vld;
    output  logic                           err;
    input   logic   [BUS_ADDR_WIDTH-1:0]    addr;
    input   logic                           wr_en;
    input   logic                           rd_en;
    input   logic   [BUS_DATA_WIDTH-1:0]    wr_data;
    output  logic   [BUS_DATA_WIDTH-1:0]    rd_data;

    input   logic                           ext_clk;
    input   logic                           ext_rst_n;
    output  logic                           ext_req_vld;
    input   logic                           ext_ack_vld;
    input   logic                           ext_err;
    output  logic   [BUS_ADDR_WIDTH-1:0]    ext_addr;
    output  logic                           ext_wr_en;
    output  logic                           ext_rd_en;
    output  logic   [BUS_DATA_WIDTH-1:0]    ext_wr_data;
    input   logic   [BUS_DATA_WIDTH-1:0]    ext_rd_data;

//***************************************************CLOCK DOMAIN CROSSING**************************************************//
    generate
        if (CDC_ENABLE) begin: g_cdc
            logic   [1:0]                   value_deliver_ctrl_o_value_in;
            logic   [1:0]                   value_deliver_ctrl_o_value_out;
            logic                           req_vld_wr_en;

            // deliver reg_native_if control signal (req_vld, wr_en, rd_en)
            // from native to target clock domain
            assign  value_deliver_ctrl_o_value_in = {wr_en, rd_en};
            value_deliver_1cycle #(
                .WIDTH                      (2)
            )
            value_deliver_ctrl_o (
                .scan_enable                (1'b0),
                .clk_a                      (native_clk),
                .rst_a_n                    (native_rst_n),
                .pulse_in                   (req_vld),
                .value_in                   (value_deliver_ctrl_o_value_in),
                .clk_b                      (ext_clk),
                .rst_b_n                    (ext_rst_n),
                .pulse_out                  (ext_req_vld),
                .value_out                  (value_deliver_ctrl_o_value_out)
            );
            assign  {ext_wr_en, ext_rd_en} = value_deliver_ctrl_o_value_out;

            // deliver reg_native_if wr_data
            // from native to target clock domain
            assign  req_vld_wr_en = req_vld & wr_en;
            value_deliver_1cycle #(
                .WIDTH                      (BUS_DATA_WIDTH)
            )
            value_deliver_wr_data_o (
                .scan_enable                (1'b0),
                .clk_a                      (native_clk),
                .rst_a_n                    (native_rst_n),
                .pulse_in                   (req_vld_wr_en),
                .value_in                   (wr_data),
                .clk_b                      (ext_clk),
                .rst_b_n                    (ext_rst_n),
                .pulse_out                  (),
                .value_out                  (ext_wr_data)
            );

            // deliver reg_native_if addr
            // from native to target clock domain
            value_deliver_1cycle #(
                .WIDTH                      (BUS_ADDR_WIDTH)
            )
            value_deliver_addr_o (
                .scan_enable                (1'b0),
                .clk_a                      (native_clk),
                .rst_a_n                    (native_rst_n),
                .pulse_in                   (req_vld),
                .value_in                   (addr),
                .clk_b                      (ext_clk),
                .rst_b_n                    (ext_rst_n),
                .pulse_out                  (),
                .value_out                  (ext_addr)
            );

            // deliver reg_native_if control signal (ext_ack_vld, ext_err)
            // from target to native clock domain
            value_deliver_1cycle #(
                .WIDTH                      (1)
            )
            value_deliver_ctrl_i (
                .scan_enable                (1'b0),
                .clk_a                      (ext_clk),
                .rst_a_n                    (ext_rst_n),
                .pulse_in                   (ext_ack_vld),
                .value_in                   (ext_err),
                .clk_b                      (native_clk),
                .rst_b_n                    (native_rst_n),
                .pulse_out                  (ack_vld),
                .value_out                  (err)
            );

            // deliver reg_native_if ext_rd_data
            // from target to native clock domain
            value_deliver_1cycle #(
                .WIDTH                      (BUS_DATA_WIDTH)
            )
            value_deliver_rd_data_i (
                .scan_enable                (1'b0),
                .clk_a                      (ext_clk),
                .rst_a_n                    (ext_rst_n),
                .pulse_in                   (ext_ack_vld),
                .value_in                   (ext_rd_data),
                .clk_b                      (native_clk),
                .rst_b_n                    (native_rst_n),
                .pulse_out                  (),
                .value_out                  (rd_data)
            );
        end else begin: g_no_cdc
            assign  ext_req_vld             = req_vld;
            assign  ext_addr                = addr;
            assign  ext_wr_en               = wr_en;
            assign  ext_rd_en               = rd_en;
            assign  ext_wr_data             = wr_data;
            assign  ack_vld                 = ext_ack_vld;
            assign  err                     = ext_err;
            assign  rd_data                 = ext_rd_data;
        end
    endgenerate
endmodule
`default_nettype wire