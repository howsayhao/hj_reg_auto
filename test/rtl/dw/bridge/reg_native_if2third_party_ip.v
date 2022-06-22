`default_nettype none
module reg_native_if2third_party_ip (
    // reg_native_if inside regdisp
    native_clk, native_rst_n,
    req_vld, ack_vld, addr, wr_en, rd_en, wr_data, rd_data,
    // reg_native_if forwarding to external 3rd party IP
    ext_clk, ext_rst_n,
    ext_req_vld, ext ack vid, ext_addr, ext_wr_en, ext_rd_en, ext_wr_data, ext_rd_data
);

    parameter   CDC_ENABLE                  = 0;
    parameter   BUS_DATA_WIDTH              = 32;
    parameter   BUS_ADDR_WIDTH              = 64;

    parameter   FORWARD_DELIVER_NUM         = BUS_ADDR_WIDTH + BUS_DATA_WIDTH + 3;
    parameter   BACKWARD_DELIVER_NUM        = BUS_DATA_WIDTH + 1;

    input   logic                           native_clk;
    input   logic                           native_rst_n;
    input   logic                           req_vld;
    output  logic                           ack_vld;
    input   logic   [BUS_ADDR_WIDTH-1:0]    addr;
    input   logic                           wr_en;
    input   logic                           rd_en;
    input   logic   [BUS_DATA_WIDTH-1:0]    wr_data;
    output  logic   [BUS_DATA_WIDTH-1:0]    rd_data;

    input   logic                           ext_clk;
    input   logic                           ext_rst_n;
    output  logic                           ext_req_vld;
    input   logic                           ext_ack_vld;
    output  logic   [BUS_ADDR_WIDTH-1:0]    ext_addr;
    output  logic                           ext_wr_en;
    output  logic                           ext_rd_en;
    output  logic   [BUS_DATA_WIDTH-1:0]    ext_wr_data;
    input   logic   [BUS_DATA_WIDTH-1:0]    ext_rd_data;

//***************************************************CLOCK DOMAIN CROSSING**************************************************//
    generate
        if (CDC_ENABLE) begin: g_cdc
            logic   [FORWARD_DELIVER_NUM-1:0]       pulse_deliver_o_pulse_in;
            logic   [FORWARD_DELIVER_NUM-1:0]       pulse_deliver_o_pulse_out;
            logic   [BACKWARD_DELIVER_NUM-1:0]      pulse_deliver_i_pulse_in;
            logic   [BACKWARD_DELIVER_NUM-1:0]      pulse_deliver_i_pulse_out;

            // deliver reg_native_if pulse from native to 3rd party IP clock domain
            assign  pulse_deliver_o_pulse_in        = {req_vld, addr, wr_en, rd_en, wr_data};
            pulse_deliver #(
                .WIDTH(FORWARD_DELIVER_NUM)
            )
            pulse_deliver_o (
                .scan_enable                (1'b0),
                .clk_a                      (native_clk),
                .rst_a_n                    (native_rst_n),
                .pulse_in                   (pulse_deliver_o_pulse_in),
                .clk_b                      (ext_clk),
                .rst_b_n                    (ext_rst_n),
                .pulse_out                  (pulse_deliver_o_pulse_out)
            );
            assign  {ext_req_vld, ext_addr, ext_wr_en, ext_rd_en, ext_wr_data}  = pulse_deliver_o_pulse_out;

            // deliver reg_native_if pulse from 3rd party IP to native clock domain
            assign  pulse_deliver_i_pulse_in    = {ext_ack_vld, ext_rd_data};
            pulse_deliver #(
                .WIDTH(FORWARD_DELIVER_NUM)
            )
            pulse_deliver_i (
                .scan_enable                (1'b0),
                .clk_a                      (ext_clk),
                .rst_a_n                    (ext_rst_n),
                .pulse_in                   (pulse_deliver_i_pulse_in),
                .clk_b                      (native_clk),
                .rst_b_n                    (native_rst_n),
                .pulse_out                  (pulse_deliver_i_pulse_out)
            );
            assign  {ack_vld, rd_data}      = pulse_deliver_i_pulse_out;

        end else begin: g_no_cdc
            assign  ext_req_vld             = req_vld;
            assign  ext_addr                = addr;
            assign  ext_wr_en               = wr_en;
            assign  ext_rd_en               = rd_en;
            assign  ext_wr_data             = wr_data;
            assign  ack_vld                 = ext_ack_vld;
            assign  rd_data                 = ext_rd_data;
        end
    endgenerate
//**************************************************************************************************************************//
endmodule
`default_nettype wire