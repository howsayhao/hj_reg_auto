`default_nettype none
module regdisp_disp_map (
    // reg_native_if forwarding to regslv_slv_map
    regdisp_disp_map__regslv_slv_map__req_vld,
    regslv_slv_map__regdisp_disp_map__ack_vld,
    regslv_slv_map__regdisp_disp_map__err,
    regdisp_disp_map__regslv_slv_map__addr,
    regdisp_disp_map__regslv_slv_map__wr_en,
    regdisp_disp_map__regslv_slv_map__rd_en,
    regdisp_disp_map__regslv_slv_map__wr_data,
    regslv_slv_map__regdisp_disp_map__rd_data,
    regdisp_disp_map__regslv_slv_map__soft_rst,
    // regdisp is in register native clock and reset domain
    regdisp_disp_map_clk,
    regdisp_disp_map_rst_n,
    // reg_native_if forwarded by upstream module
    upstream__regdisp_disp_map__req_vld,
    regdisp_disp_map__upstream__ack_vld,
    regdisp_disp_map__upstream__err,
    upstream__regdisp_disp_map__addr,
    upstream__regdisp_disp_map__wr_en,
    upstream__regdisp_disp_map__rd_en,
    upstream__regdisp_disp_map__wr_data,
    regdisp_disp_map__upstream__rd_data,
    upstream__regdisp_disp_map__soft_rst
);

    parameter                       ADDR_WIDTH          = 64;
    parameter                       DATA_WIDTH          = 32;
    parameter                       FORWARD_NUM         = 1;
    parameter   [0:FORWARD_NUM-1]   INSERT_FORWARD_DFF  = {1'b0};
    parameter                       INSERT_BACKWARD_FF  = 0;

    input   logic                                       regdisp_disp_map_clk;
    input   logic                                       regdisp_disp_map_rst_n;
    input   logic                                       upstream__regdisp_disp_map__req_vld;
    output  logic                                       regdisp_disp_map__upstream__ack_vld;
    output  logic                                       regdisp_disp_map__upstream__err;
    input   logic   [ADDR_WIDTH-1:0]                    upstream__regdisp_disp_map__addr;
    input   logic                                       upstream__regdisp_disp_map__wr_en;
    input   logic                                       upstream__regdisp_disp_map__rd_en;
    input   logic   [DATA_WIDTH-1:0]                    upstream__regdisp_disp_map__wr_data;
    output  logic   [DATA_WIDTH-1:0]                    regdisp_disp_map__upstream__rd_data;
    input   logic                                       upstream__regdisp_disp_map__soft_rst;

    
    output  logic                                       regdisp_disp_map__regslv_slv_map__req_vld;
    input   logic                                       regslv_slv_map__regdisp_disp_map__ack_vld;
    input   logic                                       regslv_slv_map__regdisp_disp_map__err;
    output  logic   [63:0]                              regdisp_disp_map__regslv_slv_map__addr;
    output  logic                                       regdisp_disp_map__regslv_slv_map__wr_en;
    output  logic                                       regdisp_disp_map__regslv_slv_map__rd_en;
    output  logic   [31:0]                              regdisp_disp_map__regslv_slv_map__wr_data;
    input   logic   [31:0]                              regslv_slv_map__regdisp_disp_map__rd_data;
    output  logic                                       regdisp_disp_map__regslv_slv_map__soft_rst;
    

    logic   [FORWARD_NUM-1:0]                           downstream_ack_vld;
    logic   [FORWARD_NUM-1:0]                           downstream_err;
    logic   [FORWARD_NUM-1:0] [DATA_WIDTH-1:0]          downstream_rd_data;
    logic   [FORWARD_NUM-1:0]                           downstream_soft_rst;

    logic   [FORWARD_NUM-1:0]                           downstream_req_vld_ff;
    logic   [FORWARD_NUM-1:0] [ADDR_WIDTH-1:0]          downstream_addr_ff;
    logic   [FORWARD_NUM-1:0]                           downstream_wr_en_ff;
    logic   [FORWARD_NUM-1:0]                           downstream_rd_en_ff;
    logic   [FORWARD_NUM-1:0] [DATA_WIDTH-1:0]          downstream_wr_data_ff;
    logic   [FORWARD_NUM-1:0]                           downstream_soft_rst_ff;

    logic   [FORWARD_NUM-1:0]                           downstream_req_vld_imux;
    logic   [FORWARD_NUM-1:0] [ADDR_WIDTH-1:0]          downstream_addr_imux;
    logic   [FORWARD_NUM-1:0]                           downstream_wr_en_imux;
    logic   [FORWARD_NUM-1:0]                           downstream_rd_en_imux;
    logic   [FORWARD_NUM-1:0] [DATA_WIDTH-1:0]          downstream_wr_data_imux;
    logic   [FORWARD_NUM-1:0]                           downstream_soft_rst_imux;

    logic   [FORWARD_NUM-1:0] [ADDR_WIDTH-1:0]          downstream_addr_conv;

    logic                                               regdisp_disp_map__upstream__ack_vld_mux;
    logic                                               regdisp_disp_map__upstream__err_mux;
    logic   [DATA_WIDTH-1:0]                            regdisp_disp_map__upstream__rd_data_mux;
    logic   [FORWARD_NUM-1:0]                           dec_if_sel;
    logic                                               dec_dummy_reg_sel;
    logic                                               dummy_reg_ack_vld;

//**************************************FORWARD DATAPATH***********************************************//
    // decode upstream absolute address
    always_comb begin
        dec_if_sel          = {FORWARD_NUM{1'b0}};
        dec_dummy_reg_sel   = 1'b0;

        unique casez (upstream__regdisp_disp_map__addr[63:2])
            62'h80000??,62'h80001??,62'h80002??,62'h80003??,62'h800040?,62'h800041?,62'h800042?,62'h8000430,62'h8000431: dec_if_sel[0] = 1'b1;
            default: dec_dummy_reg_sel  = 1'b1;
        endcase
    end

    // forward inverse multiplexor for req_vld, addr, wr_en, rd_en, wr_data
    always_comb begin
        for (integer i = 0; i < FORWARD_NUM; i = i + 1) begin
            downstream_req_vld_imux[i]      = 1'b0;
            downstream_addr_imux[i]         = {ADDR_WIDTH{1'b0}};
            downstream_wr_en_imux[i]        = 1'b0;
            downstream_rd_en_imux[i]        = 1'b0;
            downstream_wr_data_imux[i]      = {DATA_WIDTH{1'b0}};
            downstream_soft_rst_imux[i]     = upstream__regdisp_disp_map__soft_rst;

            if (dec_if_sel[i]) begin
                downstream_req_vld_imux[i]  = upstream__regdisp_disp_map__req_vld;
                downstream_addr_imux[i]     = upstream__regdisp_disp_map__addr;
                downstream_wr_en_imux[i]    = upstream__regdisp_disp_map__wr_en;
                downstream_rd_en_imux[i]    = upstream__regdisp_disp_map__rd_en;
                downstream_wr_data_imux[i]  = upstream__regdisp_disp_map__wr_data;
            end
        end
    end

    // address conversion
    assign  downstream_addr_conv[0] = {51'b0, downstream_addr_imux[0][12:0]};

    // optionally insert forwarding flip-flops,
    // which depends on hj_use_forward_ff in child addrmaps
    genvar cnt;
    generate
        for (cnt = 0; cnt < FORWARD_NUM; cnt = cnt + 1) begin: g_forward_ff_out
            if (INSERT_FORWARD_DFF[cnt]) begin: g_forward_ff_in
                always @(posedge regdisp_disp_map_clk or negedge regdisp_disp_map_rst_n) begin
                    if (!regdisp_disp_map_rst_n) begin
                        downstream_req_vld_ff[cnt]      <= 1'b0;
                        downstream_addr_ff[cnt]         <= {ADDR_WIDTH{1'b0}};
                        downstream_wr_en_ff[cnt]        <= 1'b0;
                        downstream_rd_en_ff[cnt]        <= 1'b0;
                        downstream_wr_data_ff[cnt]      <= {DATA_WIDTH{1'b0}};
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

    assign  regdisp_disp_map__regslv_slv_map__req_vld              = downstream_req_vld_ff[0];
    assign  regdisp_disp_map__regslv_slv_map__addr                 = downstream_addr_ff[0];
    assign  regdisp_disp_map__regslv_slv_map__wr_en                = downstream_wr_en_ff[0];
    assign  regdisp_disp_map__regslv_slv_map__rd_en                = downstream_rd_en_ff[0];
    assign  regdisp_disp_map__regslv_slv_map__wr_data              = downstream_wr_data_ff[0];
    assign  regdisp_disp_map__regslv_slv_map__soft_rst             = downstream_soft_rst_ff[0];
    assign  downstream_ack_vld[0]     = regslv_slv_map__regdisp_disp_map__ack_vld;
    assign  downstream_err[0]         = regslv_slv_map__regdisp_disp_map__err;
    assign  downstream_rd_data[0]     = regslv_slv_map__regdisp_disp_map__rd_data;
    
//**************************************BACKWARD DATAPATH**********************************************//
    // backward multiplexor for rd_data, ack_vld and err
    assign  dummy_reg_ack_vld               = dec_dummy_reg_sel & upstream__regdisp_disp_map__req_vld;
    assign  regdisp_disp_map__upstream__ack_vld_mux    = (| downstream_ack_vld) | dummy_reg_ack_vld;
    assign  regdisp_disp_map__upstream__err_mux        = | downstream_err;

    always_comb begin
        regdisp_disp_map__upstream__rd_data_mux = {DATA_WIDTH{1'b0}};
        if (!dummy_reg_ack_vld) begin
            for (integer i = 0; i < FORWARD_NUM; i = i + 1) begin
                if (downstream_ack_vld[i]) begin
                    regdisp_disp_map__upstream__rd_data_mux   = downstream_rd_data[i];
                end
            end
        end
    end

    // optionally insert backward flip-flops after data passes through mux
    generate
        if (INSERT_BACKWARD_FF) begin: g_backward_ff
            always @(posedge regdisp_disp_map_clk or negedge regdisp_disp_map_rst_n) begin
                if (!regdisp_disp_map_rst_n) begin
                    regdisp_disp_map__upstream__ack_vld     <= 1'b0;
                    regdisp_disp_map__upstream__err         <= 1'b0;
                    regdisp_disp_map__upstream__rd_data     <= {DATA_WIDTH{1'b0}};
                end
                else begin
                    regdisp_disp_map__upstream__ack_vld     <= regdisp_disp_map__upstream__ack_vld_mux;
                    regdisp_disp_map__upstream__err         <= regdisp_disp_map__upstream__err_mux;
                    regdisp_disp_map__upstream__rd_data     <= regdisp_disp_map__upstream__rd_data_mux;
                end
            end
        end
        else begin: g_wo_backward_ff
            assign  regdisp_disp_map__upstream__ack_vld     = regdisp_disp_map__upstream__ack_vld_mux;
            assign  regdisp_disp_map__upstream__err         = regdisp_disp_map__upstream__err_mux;
            assign  regdisp_disp_map__upstream__rd_data     = regdisp_disp_map__upstream__rd_data_mux;
        end
    endgenerate
endmodule
`default_nettype wire