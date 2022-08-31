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
    regdisp_root_map__regdisp_disp_map__soft_rst,
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
    parameter   FORWARD_NUM = 1;
    parameter   [FORWARD_NUM-1:0]   INSERT_FORWARD_FF = {1'b0};
    parameter   INSERT_BACKWARD_FF = 0;

    input   logic   regdisp_root_map_clk;
    input   logic   regdisp_root_map_rst_n;
    input   logic   upstream__regdisp_root_map__req_vld;
    output  logic   regdisp_root_map__upstream__ack_vld;
    output  logic   regdisp_root_map__upstream__err;
    input   logic   [UPSTREAM_ADDR_WIDTH-1:0]   upstream__regdisp_root_map__addr;
    input   logic   upstream__regdisp_root_map__wr_en;
    input   logic   upstream__regdisp_root_map__rd_en;
    input   logic   [UPSTREAM_DATA_WIDTH-1:0]   upstream__regdisp_root_map__wr_data;
    output  logic   [UPSTREAM_DATA_WIDTH-1:0]   regdisp_root_map__upstream__rd_data;
    input   logic   upstream__regdisp_root_map__soft_rst;
    
    output  logic   regdisp_root_map__regdisp_disp_map__req_vld;
    input   logic   regdisp_disp_map__regdisp_root_map__ack_vld;
    input   logic   regdisp_disp_map__regdisp_root_map__err;
    output  logic   [REGDISP_DISP_MAP_ADDR_WIDTH-1:0] regdisp_root_map__regdisp_disp_map__addr;
    output  logic   regdisp_root_map__regdisp_disp_map__wr_en;
    output  logic   regdisp_root_map__regdisp_disp_map__rd_en;
    output  logic   [REGDISP_DISP_MAP_DATA_WIDTH-1:0] regdisp_root_map__regdisp_disp_map__wr_data;
    input   logic   [REGDISP_DISP_MAP_DATA_WIDTH-1:0] regdisp_disp_map__regdisp_root_map__rd_data;
    output  logic   regdisp_root_map__regdisp_disp_map__soft_rst;

    logic   [FORWARD_NUM-1:0]                           downstream_ack_vld;
    logic   [FORWARD_NUM-1:0]                           downstream_err;
    logic   [FORWARD_NUM-1:0] [UPSTREAM_DATA_WIDTH-1:0] downstream_rd_data;
    logic   [FORWARD_NUM-1:0]                           downstream_soft_rst;
    logic   [FORWARD_NUM-1:0]                           downstream_req_vld_ff;
    logic   [FORWARD_NUM-1:0] [UPSTREAM_ADDR_WIDTH-1:0] downstream_addr_ff;
    logic   [FORWARD_NUM-1:0]                           downstream_wr_en_ff;
    logic   [FORWARD_NUM-1:0]                           downstream_rd_en_ff;
    logic   [FORWARD_NUM-1:0] [UPSTREAM_DATA_WIDTH-1:0] downstream_wr_data_ff;
    logic   [FORWARD_NUM-1:0]                           downstream_soft_rst_ff;
    logic   [FORWARD_NUM-1:0]                           downstream_req_vld_imux;
    logic   [FORWARD_NUM-1:0] [UPSTREAM_ADDR_WIDTH-1:0] downstream_addr_imux;
    logic   [FORWARD_NUM-1:0]                           downstream_wr_en_imux;
    logic   [FORWARD_NUM-1:0]                           downstream_rd_en_imux;
    logic   [FORWARD_NUM-1:0] [UPSTREAM_DATA_WIDTH-1:0] downstream_wr_data_imux;
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
                (DEC_ADDR_REM_BITS'(('h0 + BASE_ADDR) >> DEC_ADDR_TRUNC_BITS))
                <= upstream__regdisp_root_map__addr[UPSTREAM_ADDR_WIDTH-1:DEC_ADDR_TRUNC_BITS] &&
                upstream__regdisp_root_map__addr[UPSTREAM_ADDR_WIDTH-1:DEC_ADDR_TRUNC_BITS] <
                (DEC_ADDR_REM_BITS'(('h10c8 + BASE_ADDR) >> DEC_ADDR_TRUNC_BITS)):
                    dec_if_sel[0] = 1'b1;
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
            downstream_soft_rst_imux[i]     = upstream__regdisp_root_map__soft_rst;

            if (dec_if_sel[i]) begin
                downstream_req_vld_imux[i]  = upstream__regdisp_root_map__req_vld;
                downstream_addr_imux[i]     = upstream__regdisp_root_map__addr;
                downstream_wr_en_imux[i]    = upstream__regdisp_root_map__wr_en;
                downstream_rd_en_imux[i]    = upstream__regdisp_root_map__rd_en;
                downstream_wr_data_imux[i]  = upstream__regdisp_root_map__wr_data;
            end
        end
    end

    // address conversion
    assign  downstream_addr_conv[0] = {{REGDISP_DISP_MAP_ADDR_TRUNC_BITS{1'b0}}, downstream_addr_imux[0][REGDISP_DISP_MAP_ADDR_REM_BITS-1:0]};

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
                        downstream_soft_rst_ff[cnt]     <= 1'b0;
                    end
                    else begin
                        downstream_req_vld_ff[cnt]      <= downstream_req_vld_imux[cnt];
                        downstream_addr_ff[cnt]         <= downstream_addr_conv[cnt];
                        downstream_wr_en_ff[cnt]        <= downstream_wr_en_imux[cnt];
                        downstream_rd_en_ff[cnt]        <= downstream_rd_en_imux[cnt];
                        downstream_wr_data_ff[cnt]      <= downstream_wr_data_imux[cnt];
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
                assign downstream_soft_rst_ff[cnt]      = downstream_soft_rst_imux[cnt];
            end
        end
    endgenerate

    assign  regdisp_root_map__regdisp_disp_map__req_vld              = downstream_req_vld_ff[0];
    assign  regdisp_root_map__regdisp_disp_map__addr                 = downstream_addr_ff[0];
    assign  regdisp_root_map__regdisp_disp_map__wr_en                = downstream_wr_en_ff[0];
    assign  regdisp_root_map__regdisp_disp_map__rd_en                = downstream_rd_en_ff[0];
    assign  regdisp_root_map__regdisp_disp_map__wr_data              = downstream_wr_data_ff[0];
    assign  regdisp_root_map__regdisp_disp_map__soft_rst             = downstream_soft_rst_ff[0];
    assign  downstream_ack_vld[0]     = regdisp_disp_map__regdisp_root_map__ack_vld;
    assign  downstream_err[0]         = regdisp_disp_map__regdisp_root_map__err;
    assign  downstream_rd_data[0]     = regdisp_disp_map__regdisp_root_map__rd_data;

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
        regdisp_root_map__upstream__rd_data_mux = {UPSTREAM_DATA_WIDTH{1'b0}};
        if (!dummy_reg_ack_vld) begin
            for (integer i = 0; i < FORWARD_NUM; i = i + 1) begin
                if (downstream_ack_vld[i]) begin
                    regdisp_root_map__upstream__rd_data_mux    = downstream_rd_data[i];
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