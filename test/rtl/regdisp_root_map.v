`default_nettype none
module regdisp_root_map (
    // reg_native_if forwarding to regdisp_disp_map
    regdisp_root_map__regdisp_disp_map__req_vld,
    regdisp_disp_map__regdisp_root_map__ack_vld,
    regdisp_disp_map__regdisp_root_map__err,
    regdisp_root_map__regdisp_disp_map__addr,
    regdisp_root_map__regdisp_disp_map__wr_en,
    regdisp_root_map__regdisp_disp_map__rd_en,
    regdisp_root_map__regdisp_disp_map__wr_data,
    regdisp_disp_map__regdisp_root_map__rd_data,
    regdisp_root_map__regdisp_disp_map__non_sec,
    regdisp_root_map__regdisp_disp_map__soft_rst,
    // reg_native_if forwarding to regdisp_disp1_map
    regdisp_root_map__regdisp_disp1_map__req_vld,
    regdisp_disp1_map__regdisp_root_map__ack_vld,
    regdisp_disp1_map__regdisp_root_map__err,
    regdisp_root_map__regdisp_disp1_map__addr,
    regdisp_root_map__regdisp_disp1_map__wr_en,
    regdisp_root_map__regdisp_disp1_map__rd_en,
    regdisp_root_map__regdisp_disp1_map__wr_data,
    regdisp_disp1_map__regdisp_root_map__rd_data,
    regdisp_root_map__regdisp_disp1_map__non_sec,
    regdisp_root_map__regdisp_disp1_map__soft_rst,
    // reg_native_if forwarding to regdisp_disp2_map
    regdisp_root_map__regdisp_disp2_map__req_vld,
    regdisp_disp2_map__regdisp_root_map__ack_vld,
    regdisp_disp2_map__regdisp_root_map__err,
    regdisp_root_map__regdisp_disp2_map__addr,
    regdisp_root_map__regdisp_disp2_map__wr_en,
    regdisp_root_map__regdisp_disp2_map__rd_en,
    regdisp_root_map__regdisp_disp2_map__wr_data,
    regdisp_disp2_map__regdisp_root_map__rd_data,
    regdisp_root_map__regdisp_disp2_map__non_sec,
    regdisp_root_map__regdisp_disp2_map__soft_rst,
    // reg_native_if forwarding to regdisp_disp3_map
    regdisp_root_map__regdisp_disp3_map__req_vld,
    regdisp_disp3_map__regdisp_root_map__ack_vld,
    regdisp_disp3_map__regdisp_root_map__err,
    regdisp_root_map__regdisp_disp3_map__addr,
    regdisp_root_map__regdisp_disp3_map__wr_en,
    regdisp_root_map__regdisp_disp3_map__rd_en,
    regdisp_root_map__regdisp_disp3_map__wr_data,
    regdisp_disp3_map__regdisp_root_map__rd_data,
    regdisp_root_map__regdisp_disp3_map__non_sec,
    regdisp_root_map__regdisp_disp3_map__soft_rst,
    // reg_native_if forwarding to regslv_slv5_map
    regdisp_root_map__regslv_slv5_map__req_vld,
    regslv_slv5_map__regdisp_root_map__ack_vld,
    regslv_slv5_map__regdisp_root_map__err,
    regdisp_root_map__regslv_slv5_map__addr,
    regdisp_root_map__regslv_slv5_map__wr_en,
    regdisp_root_map__regslv_slv5_map__rd_en,
    regdisp_root_map__regslv_slv5_map__wr_data,
    regslv_slv5_map__regdisp_root_map__rd_data,
    regdisp_root_map__regslv_slv5_map__non_sec,
    regdisp_root_map__regslv_slv5_map__soft_rst,
    // regdisp is in register native clock and reset domain
    regdisp_root_map_clk,
    regdisp_root_map_rst_n,
    // reg_native_if forwarded by upstream module
    upstream__regdisp_root_map__req_vld,
    regdisp_root_map__upstream__ack_vld,
    regdisp_root_map__upstream__err,
    upstream__regdisp_root_map__addr,
    upstream__regdisp_root_map__wr_en,
    upstream__regdisp_root_map__rd_en,
    upstream__regdisp_root_map__wr_data,
    regdisp_root_map__upstream__rd_data,
    upstream__regdisp_root_map__non_sec,
    upstream__regdisp_root_map__soft_rst
);
    `include "common_funcs.vh"

    parameter   BASE_ADDR = 64'h0;
    parameter   UPSTREAM_ADDR_WIDTH = 48;
    parameter   UPSTREAM_DATA_WIDTH = 32;
    parameter   REGDISP_DISP_MAP_ADDR_WIDTH = 48;
    parameter   REGDISP_DISP_MAP_DATA_WIDTH = 32;
    parameter   REGDISP_DISP_MAP_ADDR_REM_BITS = 13;
    parameter   REGDISP_DISP_MAP_ADDR_TRUNC_BITS = UPSTREAM_ADDR_WIDTH - REGDISP_DISP_MAP_ADDR_REM_BITS;
    parameter   REGDISP_DISP1_MAP_ADDR_WIDTH = 48;
    parameter   REGDISP_DISP1_MAP_DATA_WIDTH = 32;
    parameter   REGDISP_DISP1_MAP_ADDR_REM_BITS = 14;
    parameter   REGDISP_DISP1_MAP_ADDR_TRUNC_BITS = UPSTREAM_ADDR_WIDTH - REGDISP_DISP1_MAP_ADDR_REM_BITS;
    parameter   REGDISP_DISP2_MAP_ADDR_WIDTH = 48;
    parameter   REGDISP_DISP2_MAP_DATA_WIDTH = 32;
    parameter   REGDISP_DISP2_MAP_ADDR_REM_BITS = 13;
    parameter   REGDISP_DISP2_MAP_ADDR_TRUNC_BITS = UPSTREAM_ADDR_WIDTH - REGDISP_DISP2_MAP_ADDR_REM_BITS;
    parameter   REGDISP_DISP3_MAP_ADDR_WIDTH = 48;
    parameter   REGDISP_DISP3_MAP_DATA_WIDTH = 32;
    parameter   REGDISP_DISP3_MAP_ADDR_REM_BITS = 13;
    parameter   REGDISP_DISP3_MAP_ADDR_TRUNC_BITS = UPSTREAM_ADDR_WIDTH - REGDISP_DISP3_MAP_ADDR_REM_BITS;
    parameter   REGSLV_SLV5_MAP_ADDR_WIDTH = 48;
    parameter   REGSLV_SLV5_MAP_DATA_WIDTH = 32;
    parameter   REGSLV_SLV5_MAP_ADDR_REM_BITS = 13;
    parameter   REGSLV_SLV5_MAP_ADDR_TRUNC_BITS = UPSTREAM_ADDR_WIDTH - REGSLV_SLV5_MAP_ADDR_REM_BITS;
    parameter   FORWARD_NUM = 5;
    parameter   [FORWARD_NUM-1:0]   INSERT_FORWARD_FF = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
    parameter   INSERT_BACKWARD_FF = 0;
    parameter   DUMMY_READ_DATA = 0;

    input   logic                               regdisp_root_map_clk;
    input   logic                               regdisp_root_map_rst_n;
    input   logic                               upstream__regdisp_root_map__req_vld;
    output  logic                               regdisp_root_map__upstream__ack_vld;
    output  logic                               regdisp_root_map__upstream__err;
    input   logic   [UPSTREAM_ADDR_WIDTH-1:0]   upstream__regdisp_root_map__addr;
    input   logic                               upstream__regdisp_root_map__wr_en;
    input   logic                               upstream__regdisp_root_map__rd_en;
    input   logic   [UPSTREAM_DATA_WIDTH-1:0]   upstream__regdisp_root_map__wr_data;
    output  logic   [UPSTREAM_DATA_WIDTH-1:0]   regdisp_root_map__upstream__rd_data;
    input   logic                               upstream__regdisp_root_map__non_sec;
    input   logic                               upstream__regdisp_root_map__soft_rst;
    
    output  logic                               regdisp_root_map__regdisp_disp_map__req_vld;
    input   logic                               regdisp_disp_map__regdisp_root_map__ack_vld;
    input   logic                               regdisp_disp_map__regdisp_root_map__err;
    output  logic   [REGDISP_DISP_MAP_ADDR_WIDTH-1:0] regdisp_root_map__regdisp_disp_map__addr;
    output  logic                               regdisp_root_map__regdisp_disp_map__wr_en;
    output  logic                               regdisp_root_map__regdisp_disp_map__rd_en;
    output  logic   [REGDISP_DISP_MAP_DATA_WIDTH-1:0] regdisp_root_map__regdisp_disp_map__wr_data;
    input   logic   [REGDISP_DISP_MAP_DATA_WIDTH-1:0] regdisp_disp_map__regdisp_root_map__rd_data;
    output  logic                               regdisp_root_map__regdisp_disp_map__non_sec;
    output  logic                               regdisp_root_map__regdisp_disp_map__soft_rst;
    output  logic                               regdisp_root_map__regdisp_disp1_map__req_vld;
    input   logic                               regdisp_disp1_map__regdisp_root_map__ack_vld;
    input   logic                               regdisp_disp1_map__regdisp_root_map__err;
    output  logic   [REGDISP_DISP1_MAP_ADDR_WIDTH-1:0] regdisp_root_map__regdisp_disp1_map__addr;
    output  logic                               regdisp_root_map__regdisp_disp1_map__wr_en;
    output  logic                               regdisp_root_map__regdisp_disp1_map__rd_en;
    output  logic   [REGDISP_DISP1_MAP_DATA_WIDTH-1:0] regdisp_root_map__regdisp_disp1_map__wr_data;
    input   logic   [REGDISP_DISP1_MAP_DATA_WIDTH-1:0] regdisp_disp1_map__regdisp_root_map__rd_data;
    output  logic                               regdisp_root_map__regdisp_disp1_map__non_sec;
    output  logic                               regdisp_root_map__regdisp_disp1_map__soft_rst;
    output  logic                               regdisp_root_map__regdisp_disp2_map__req_vld;
    input   logic                               regdisp_disp2_map__regdisp_root_map__ack_vld;
    input   logic                               regdisp_disp2_map__regdisp_root_map__err;
    output  logic   [REGDISP_DISP2_MAP_ADDR_WIDTH-1:0] regdisp_root_map__regdisp_disp2_map__addr;
    output  logic                               regdisp_root_map__regdisp_disp2_map__wr_en;
    output  logic                               regdisp_root_map__regdisp_disp2_map__rd_en;
    output  logic   [REGDISP_DISP2_MAP_DATA_WIDTH-1:0] regdisp_root_map__regdisp_disp2_map__wr_data;
    input   logic   [REGDISP_DISP2_MAP_DATA_WIDTH-1:0] regdisp_disp2_map__regdisp_root_map__rd_data;
    output  logic                               regdisp_root_map__regdisp_disp2_map__non_sec;
    output  logic                               regdisp_root_map__regdisp_disp2_map__soft_rst;
    output  logic                               regdisp_root_map__regdisp_disp3_map__req_vld;
    input   logic                               regdisp_disp3_map__regdisp_root_map__ack_vld;
    input   logic                               regdisp_disp3_map__regdisp_root_map__err;
    output  logic   [REGDISP_DISP3_MAP_ADDR_WIDTH-1:0] regdisp_root_map__regdisp_disp3_map__addr;
    output  logic                               regdisp_root_map__regdisp_disp3_map__wr_en;
    output  logic                               regdisp_root_map__regdisp_disp3_map__rd_en;
    output  logic   [REGDISP_DISP3_MAP_DATA_WIDTH-1:0] regdisp_root_map__regdisp_disp3_map__wr_data;
    input   logic   [REGDISP_DISP3_MAP_DATA_WIDTH-1:0] regdisp_disp3_map__regdisp_root_map__rd_data;
    output  logic                               regdisp_root_map__regdisp_disp3_map__non_sec;
    output  logic                               regdisp_root_map__regdisp_disp3_map__soft_rst;
    output  logic                               regdisp_root_map__regslv_slv5_map__req_vld;
    input   logic                               regslv_slv5_map__regdisp_root_map__ack_vld;
    input   logic                               regslv_slv5_map__regdisp_root_map__err;
    output  logic   [REGSLV_SLV5_MAP_ADDR_WIDTH-1:0] regdisp_root_map__regslv_slv5_map__addr;
    output  logic                               regdisp_root_map__regslv_slv5_map__wr_en;
    output  logic                               regdisp_root_map__regslv_slv5_map__rd_en;
    output  logic   [REGSLV_SLV5_MAP_DATA_WIDTH-1:0] regdisp_root_map__regslv_slv5_map__wr_data;
    input   logic   [REGSLV_SLV5_MAP_DATA_WIDTH-1:0] regslv_slv5_map__regdisp_root_map__rd_data;
    output  logic                               regdisp_root_map__regslv_slv5_map__non_sec;
    output  logic                               regdisp_root_map__regslv_slv5_map__soft_rst;

    logic   [FORWARD_NUM-1:0]                           downstream_ack_vld;
    logic   [FORWARD_NUM-1:0]                           downstream_err;
    logic   [FORWARD_NUM-1:0] [UPSTREAM_DATA_WIDTH-1:0] downstream_rd_data;
    logic   [FORWARD_NUM-1:0]                           downstream_soft_rst;
    logic   [FORWARD_NUM-1:0]                           downstream_req_vld_ff;
    logic   [FORWARD_NUM-1:0] [UPSTREAM_ADDR_WIDTH-1:0] downstream_addr_ff;
    logic   [FORWARD_NUM-1:0]                           downstream_wr_en_ff;
    logic   [FORWARD_NUM-1:0]                           downstream_rd_en_ff;
    logic   [FORWARD_NUM-1:0] [UPSTREAM_DATA_WIDTH-1:0] downstream_wr_data_ff;
    logic   [FORWARD_NUM-1:0]                           downstream_non_sec_ff;
    logic   [FORWARD_NUM-1:0]                           downstream_soft_rst_ff;
    logic   [FORWARD_NUM-1:0]                           downstream_req_vld_imux;
    logic   [FORWARD_NUM-1:0] [UPSTREAM_ADDR_WIDTH-1:0] downstream_addr_imux;
    logic   [FORWARD_NUM-1:0]                           downstream_wr_en_imux;
    logic   [FORWARD_NUM-1:0]                           downstream_rd_en_imux;
    logic   [FORWARD_NUM-1:0] [UPSTREAM_DATA_WIDTH-1:0] downstream_wr_data_imux;
    logic   [FORWARD_NUM-1:0]                           downstream_non_sec_imux;
    logic   [FORWARD_NUM-1:0]                           downstream_soft_rst_imux;
    logic   [FORWARD_NUM-1:0] [UPSTREAM_ADDR_WIDTH-1:0] downstream_addr_conv;
    logic                                               regdisp_root_map__upstream__ack_vld_mux;
    logic                                               regdisp_root_map__upstream__err_mux;
    logic   [UPSTREAM_DATA_WIDTH-1:0]                   regdisp_root_map__upstream__rd_data_mux;
    logic   [FORWARD_NUM-1:0]                           dec_if_sel;
    logic                                               dec_dummy_reg_sel;
    logic                                               dummy_reg_ack_vld;

//**************************************FORWARD DATAPATH***********************************************//
    // decode upstream absolute address
    localparam  DEC_ADDR_TRUNC_BITS = log2(UPSTREAM_DATA_WIDTH / 8);
    localparam  DEC_ADDR_REM_BITS = UPSTREAM_ADDR_WIDTH - DEC_ADDR_TRUNC_BITS;

    always_comb begin
        dec_if_sel          = {FORWARD_NUM{1'b0}};
        dec_dummy_reg_sel   = 1'b0;

        if (upstream__regdisp_root_map__req_vld) begin
            unique case (1'b1)
                ((DEC_ADDR_REM_BITS'((64'h0 + BASE_ADDR) >> DEC_ADDR_TRUNC_BITS))
                <= upstream__regdisp_root_map__addr[UPSTREAM_ADDR_WIDTH-1:DEC_ADDR_TRUNC_BITS] &&
                upstream__regdisp_root_map__addr[UPSTREAM_ADDR_WIDTH-1:DEC_ADDR_TRUNC_BITS] <
                (DEC_ADDR_REM_BITS'((64'h12c8 + BASE_ADDR) >> DEC_ADDR_TRUNC_BITS))):
                    dec_if_sel[0] = 1'b1;
                ((DEC_ADDR_REM_BITS'((64'h4000 + BASE_ADDR) >> DEC_ADDR_TRUNC_BITS))
                <= upstream__regdisp_root_map__addr[UPSTREAM_ADDR_WIDTH-1:DEC_ADDR_TRUNC_BITS] &&
                upstream__regdisp_root_map__addr[UPSTREAM_ADDR_WIDTH-1:DEC_ADDR_TRUNC_BITS] <
                (DEC_ADDR_REM_BITS'((64'h72c8 + BASE_ADDR) >> DEC_ADDR_TRUNC_BITS))):
                    dec_if_sel[1] = 1'b1;
                ((DEC_ADDR_REM_BITS'((64'h8000 + BASE_ADDR) >> DEC_ADDR_TRUNC_BITS))
                <= upstream__regdisp_root_map__addr[UPSTREAM_ADDR_WIDTH-1:DEC_ADDR_TRUNC_BITS] &&
                upstream__regdisp_root_map__addr[UPSTREAM_ADDR_WIDTH-1:DEC_ADDR_TRUNC_BITS] <
                (DEC_ADDR_REM_BITS'((64'h92c8 + BASE_ADDR) >> DEC_ADDR_TRUNC_BITS))):
                    dec_if_sel[2] = 1'b1;
                ((DEC_ADDR_REM_BITS'((64'ha000 + BASE_ADDR) >> DEC_ADDR_TRUNC_BITS))
                <= upstream__regdisp_root_map__addr[UPSTREAM_ADDR_WIDTH-1:DEC_ADDR_TRUNC_BITS] &&
                upstream__regdisp_root_map__addr[UPSTREAM_ADDR_WIDTH-1:DEC_ADDR_TRUNC_BITS] <
                (DEC_ADDR_REM_BITS'((64'hb2c8 + BASE_ADDR) >> DEC_ADDR_TRUNC_BITS))):
                    dec_if_sel[3] = 1'b1;
                ((DEC_ADDR_REM_BITS'((64'hc000 + BASE_ADDR) >> DEC_ADDR_TRUNC_BITS))
                <= upstream__regdisp_root_map__addr[UPSTREAM_ADDR_WIDTH-1:DEC_ADDR_TRUNC_BITS] &&
                upstream__regdisp_root_map__addr[UPSTREAM_ADDR_WIDTH-1:DEC_ADDR_TRUNC_BITS] <
                (DEC_ADDR_REM_BITS'((64'hd2c8 + BASE_ADDR) >> DEC_ADDR_TRUNC_BITS))):
                    dec_if_sel[4] = 1'b1;
                default: dec_dummy_reg_sel  = 1'b1;
            endcase
        end
    end

    // forward inverse multiplexor for req_vld, addr, wr_en, rd_en, wr_data
    always_comb begin
        for (integer i = 0; i < FORWARD_NUM; i = i + 1) begin
            downstream_req_vld_imux[i]      = 1'b0;
            downstream_addr_imux[i]         = {UPSTREAM_ADDR_WIDTH{1'b0}};
            downstream_wr_en_imux[i]        = 1'b0;
            downstream_rd_en_imux[i]        = 1'b0;
            downstream_wr_data_imux[i]      = {UPSTREAM_DATA_WIDTH{1'b0}};
            downstream_non_sec_imux[i]      = 1'b0;
            downstream_soft_rst_imux[i]     = upstream__regdisp_root_map__soft_rst;

            if (dec_if_sel[i]) begin
                downstream_req_vld_imux[i]  = upstream__regdisp_root_map__req_vld;
                downstream_addr_imux[i]     = upstream__regdisp_root_map__addr;
                downstream_wr_en_imux[i]    = upstream__regdisp_root_map__wr_en;
                downstream_rd_en_imux[i]    = upstream__regdisp_root_map__rd_en;
                downstream_wr_data_imux[i]  = upstream__regdisp_root_map__wr_data;
                downstream_non_sec_imux[i]  = upstream__regdisp_root_map__non_sec;
            end
        end
    end

    // address conversion
    assign  downstream_addr_conv[0] = {{REGDISP_DISP_MAP_ADDR_TRUNC_BITS{1'b0}}, downstream_addr_imux[0][REGDISP_DISP_MAP_ADDR_REM_BITS-1:0]};
    assign  downstream_addr_conv[1] = {{REGDISP_DISP1_MAP_ADDR_TRUNC_BITS{1'b0}}, downstream_addr_imux[1][REGDISP_DISP1_MAP_ADDR_REM_BITS-1:0]};
    assign  downstream_addr_conv[2] = {{REGDISP_DISP2_MAP_ADDR_TRUNC_BITS{1'b0}}, downstream_addr_imux[2][REGDISP_DISP2_MAP_ADDR_REM_BITS-1:0]};
    assign  downstream_addr_conv[3] = {{REGDISP_DISP3_MAP_ADDR_TRUNC_BITS{1'b0}}, downstream_addr_imux[3][REGDISP_DISP3_MAP_ADDR_REM_BITS-1:0]};
    assign  downstream_addr_conv[4] = {{REGSLV_SLV5_MAP_ADDR_TRUNC_BITS{1'b0}}, downstream_addr_imux[4][REGSLV_SLV5_MAP_ADDR_REM_BITS-1:0]};

    // optionally insert forwarding flip-flops,
    // which depends on hj_use_forward_ff in child addrmaps
    genvar cnt;
    generate
        for (cnt = 0; cnt < FORWARD_NUM; cnt = cnt + 1) begin: g_forward_ff_out
            if (INSERT_FORWARD_FF[cnt]) begin: g_forward_ff_in
                always @(posedge regdisp_root_map_clk or negedge regdisp_root_map_rst_n) begin
                    if (!regdisp_root_map_rst_n) begin
                        downstream_req_vld_ff[cnt]      <= 1'b0;
                        downstream_addr_ff[cnt]         <= {UPSTREAM_ADDR_WIDTH{1'b0}};
                        downstream_wr_en_ff[cnt]        <= 1'b0;
                        downstream_rd_en_ff[cnt]        <= 1'b0;
                        downstream_wr_data_ff[cnt]      <= {UPSTREAM_DATA_WIDTH{1'b0}};
                        downstream_non_sec_ff[cnt]      <= 1'b0;
                        downstream_soft_rst_ff[cnt]     <= 1'b0;
                    end
                    else begin
                        downstream_req_vld_ff[cnt]      <= downstream_req_vld_imux[cnt];
                        downstream_addr_ff[cnt]         <= downstream_addr_conv[cnt];
                        downstream_wr_en_ff[cnt]        <= downstream_wr_en_imux[cnt];
                        downstream_rd_en_ff[cnt]        <= downstream_rd_en_imux[cnt];
                        downstream_wr_data_ff[cnt]      <= downstream_wr_data_imux[cnt];
                        downstream_non_sec_ff[cnt]      <= downstream_non_sec_imux[cnt];
                        downstream_soft_rst_ff[cnt]     <= downstream_soft_rst_imux[cnt];
                    end
                end
            end
            else begin: g_no_forward_ff_in
                assign downstream_req_vld_ff[cnt]       = downstream_req_vld_imux[cnt];
                assign downstream_addr_ff[cnt]          = downstream_addr_conv[cnt];
                assign downstream_wr_en_ff[cnt]         = downstream_wr_en_imux[cnt];
                assign downstream_rd_en_ff[cnt]         = downstream_rd_en_imux[cnt];
                assign downstream_wr_data_ff[cnt]       = downstream_wr_data_imux[cnt];
                assign downstream_non_sec_ff[cnt]       = downstream_non_sec_imux[cnt];
                assign downstream_soft_rst_ff[cnt]      = downstream_soft_rst_imux[cnt];
            end
        end
    endgenerate

    assign  regdisp_root_map__regdisp_disp_map__req_vld      = downstream_req_vld_ff[0];
    assign  regdisp_root_map__regdisp_disp_map__addr         = downstream_addr_ff[0];
    assign  regdisp_root_map__regdisp_disp_map__wr_en        = downstream_wr_en_ff[0];
    assign  regdisp_root_map__regdisp_disp_map__rd_en        = downstream_rd_en_ff[0];
    assign  regdisp_root_map__regdisp_disp_map__wr_data      = downstream_wr_data_ff[0];
    assign  regdisp_root_map__regdisp_disp_map__non_sec      = downstream_non_sec_ff[0];
    assign  regdisp_root_map__regdisp_disp_map__soft_rst     = downstream_soft_rst_ff[0];
    assign  downstream_ack_vld[0]     = regdisp_disp_map__regdisp_root_map__ack_vld;
    assign  downstream_err[0]         = regdisp_disp_map__regdisp_root_map__err;
    assign  downstream_rd_data[0]     = regdisp_disp_map__regdisp_root_map__rd_data;

    assign  regdisp_root_map__regdisp_disp1_map__req_vld      = downstream_req_vld_ff[1];
    assign  regdisp_root_map__regdisp_disp1_map__addr         = downstream_addr_ff[1];
    assign  regdisp_root_map__regdisp_disp1_map__wr_en        = downstream_wr_en_ff[1];
    assign  regdisp_root_map__regdisp_disp1_map__rd_en        = downstream_rd_en_ff[1];
    assign  regdisp_root_map__regdisp_disp1_map__wr_data      = downstream_wr_data_ff[1];
    assign  regdisp_root_map__regdisp_disp1_map__non_sec      = downstream_non_sec_ff[1];
    assign  regdisp_root_map__regdisp_disp1_map__soft_rst     = downstream_soft_rst_ff[1];
    assign  downstream_ack_vld[1]     = regdisp_disp1_map__regdisp_root_map__ack_vld;
    assign  downstream_err[1]         = regdisp_disp1_map__regdisp_root_map__err;
    assign  downstream_rd_data[1]     = regdisp_disp1_map__regdisp_root_map__rd_data;

    assign  regdisp_root_map__regdisp_disp2_map__req_vld      = downstream_req_vld_ff[2];
    assign  regdisp_root_map__regdisp_disp2_map__addr         = downstream_addr_ff[2];
    assign  regdisp_root_map__regdisp_disp2_map__wr_en        = downstream_wr_en_ff[2];
    assign  regdisp_root_map__regdisp_disp2_map__rd_en        = downstream_rd_en_ff[2];
    assign  regdisp_root_map__regdisp_disp2_map__wr_data      = downstream_wr_data_ff[2];
    assign  regdisp_root_map__regdisp_disp2_map__non_sec      = downstream_non_sec_ff[2];
    assign  regdisp_root_map__regdisp_disp2_map__soft_rst     = downstream_soft_rst_ff[2];
    assign  downstream_ack_vld[2]     = regdisp_disp2_map__regdisp_root_map__ack_vld;
    assign  downstream_err[2]         = regdisp_disp2_map__regdisp_root_map__err;
    assign  downstream_rd_data[2]     = regdisp_disp2_map__regdisp_root_map__rd_data;

    assign  regdisp_root_map__regdisp_disp3_map__req_vld      = downstream_req_vld_ff[3];
    assign  regdisp_root_map__regdisp_disp3_map__addr         = downstream_addr_ff[3];
    assign  regdisp_root_map__regdisp_disp3_map__wr_en        = downstream_wr_en_ff[3];
    assign  regdisp_root_map__regdisp_disp3_map__rd_en        = downstream_rd_en_ff[3];
    assign  regdisp_root_map__regdisp_disp3_map__wr_data      = downstream_wr_data_ff[3];
    assign  regdisp_root_map__regdisp_disp3_map__non_sec      = downstream_non_sec_ff[3];
    assign  regdisp_root_map__regdisp_disp3_map__soft_rst     = downstream_soft_rst_ff[3];
    assign  downstream_ack_vld[3]     = regdisp_disp3_map__regdisp_root_map__ack_vld;
    assign  downstream_err[3]         = regdisp_disp3_map__regdisp_root_map__err;
    assign  downstream_rd_data[3]     = regdisp_disp3_map__regdisp_root_map__rd_data;

    assign  regdisp_root_map__regslv_slv5_map__req_vld      = downstream_req_vld_ff[4];
    assign  regdisp_root_map__regslv_slv5_map__addr         = downstream_addr_ff[4];
    assign  regdisp_root_map__regslv_slv5_map__wr_en        = downstream_wr_en_ff[4];
    assign  regdisp_root_map__regslv_slv5_map__rd_en        = downstream_rd_en_ff[4];
    assign  regdisp_root_map__regslv_slv5_map__wr_data      = downstream_wr_data_ff[4];
    assign  regdisp_root_map__regslv_slv5_map__non_sec      = downstream_non_sec_ff[4];
    assign  regdisp_root_map__regslv_slv5_map__soft_rst     = downstream_soft_rst_ff[4];
    assign  downstream_ack_vld[4]     = regslv_slv5_map__regdisp_root_map__ack_vld;
    assign  downstream_err[4]         = regslv_slv5_map__regdisp_root_map__err;
    assign  downstream_rd_data[4]     = regslv_slv5_map__regdisp_root_map__rd_data;

//**************************************BACKWARD DATAPATH**********************************************//
    // backward multiplexor for rd_data, ack_vld and err
    always_ff @(posedge regdisp_root_map_clk or negedge regdisp_root_map_rst_n) begin
        if (!regdisp_root_map_rst_n)
            dummy_reg_ack_vld   <= 1'b0;
        else
            dummy_reg_ack_vld   <= dec_dummy_reg_sel;
    end
    assign  regdisp_root_map__upstream__ack_vld_mux = (| downstream_ack_vld) | dummy_reg_ack_vld;
    assign  regdisp_root_map__upstream__err_mux = | downstream_err;

    always_comb begin
        regdisp_root_map__upstream__rd_data_mux = DUMMY_READ_DATA;
        if (!dummy_reg_ack_vld) begin
            for (integer i = 0; i < FORWARD_NUM; i = i + 1) begin
                if (downstream_ack_vld[i]) begin
                    regdisp_root_map__upstream__rd_data_mux = downstream_rd_data[i];
                end
            end
        end
    end

    // optionally insert backward flip-flops after data passes through mux
    generate
        if (INSERT_BACKWARD_FF) begin: g_backward_ff
            always_ff @(posedge regdisp_root_map_clk or negedge regdisp_root_map_rst_n) begin
                if (!regdisp_root_map_rst_n) begin
                    regdisp_root_map__upstream__ack_vld    <= 1'b0;
                    regdisp_root_map__upstream__err        <= 1'b0;
                    regdisp_root_map__upstream__rd_data    <= {UPSTREAM_DATA_WIDTH{1'b0}};
                end
                else begin
                    regdisp_root_map__upstream__ack_vld    <= regdisp_root_map__upstream__ack_vld_mux;
                    regdisp_root_map__upstream__err        <= regdisp_root_map__upstream__err_mux;
                    regdisp_root_map__upstream__rd_data    <= regdisp_root_map__upstream__rd_data_mux;
                end
            end
        end
        else begin: g_wo_backward_ff
            assign  regdisp_root_map__upstream__ack_vld    = regdisp_root_map__upstream__ack_vld_mux;
            assign  regdisp_root_map__upstream__err        = regdisp_root_map__upstream__err_mux;
            assign  regdisp_root_map__upstream__rd_data    = regdisp_root_map__upstream__rd_data_mux;
        end
    endgenerate
endmodule
`default_nettype wire