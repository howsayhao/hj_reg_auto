module regdisp_template_mst__template_disp (
    clk,
    rst_n,
    // upstream reg_native_if
    upstream__req_vld,
    upstream__ack_vld,
    upstream__addr,
    upstream__wr_en,
    upstream__rd_en,
    upstream__wr_data,
    upstream__rd_data,
    // downstream reg_native_if
    downstream__req_vld,
    downstream__ack_vld,
    downstream__addr,
    downstream__wr_en,
    downstream__rd_en,
    downstream__wr_data,
    downstream__rd_data,
    // soft reset signals in and out
    soft_rst_i,
    soft_rst_o
);

    parameter   ADDR_WIDTH                              = 64;
    parameter   DATA_WIDTH                              = 32;
    parameter   FORWARD_NUM                             = 2;
    parameter   [0:FORWARD_NUM-1]   INSERT_FORWARD_DFF  = {1'b0, 1'b0};
    parameter   INSERT_BACKWARD_DFF                     = 0;

    input   logic   clk, rst_n;

    input   logic                                       upstream__req_vld;
    output  logic                                       upstream__ack_vld;
    input   logic   [ADDR_WIDTH-1:0]                    upstream__addr;
    input   logic                                       upstream__wr_en;
    input   logic                                       upstream__rd_en;
    input   logic   [DATA_WIDTH-1:0]                    upstream__wr_data;
    output  logic   [DATA_WIDTH-1:0]                    upstream__rd_data;

    output  logic   [FORWARD_NUM-1:0]                   downstream__req_vld;
    input   logic   [FORWARD_NUM-1:0]                   downstream__ack_vld;
    output  logic   [FORWARD_NUM-1:0] [ADDR_WIDTH-1:0]  downstream__addr;
    output  logic   [FORWARD_NUM-1:0]                   downstream__wr_en;
    output  logic   [FORWARD_NUM-1:0]                   downstream__rd_en;
    output  logic   [FORWARD_NUM-1:0] [DATA_WIDTH-1:0]  downstream__wr_data;
    input   logic   [FORWARD_NUM-1:0] [DATA_WIDTH-1:0]  downstream__rd_data;

    input   logic                                       soft_rst_i;
    output  logic                                       soft_rst_o;

    logic   [FORWARD_NUM-1:0]                           downstream__req_vld_pre;
    logic   [FORWARD_NUM-1:0] [ADDR_WIDTH-1:0]          downstream__addr_pre;
    logic   [FORWARD_NUM-1:0]                           downstream__wr_en_pre;
    logic   [FORWARD_NUM-1:0]                           downstream__rd_en_pre;
    logic   [FORWARD_NUM-1:0] [DATA_WIDTH-1:0]          downstream__wr_data_pre;

    logic   [FORWARD_NUM-1:0]                           downstream__req_vld_imux;
    logic   [FORWARD_NUM-1:0] [ADDR_WIDTH-1:0]          downstream__addr_imux;
    logic   [FORWARD_NUM-1:0]                           downstream__wr_en_imux;
    logic   [FORWARD_NUM-1:0]                           downstream__rd_en_imux;
    logic   [FORWARD_NUM-1:0] [DATA_WIDTH-1:0]          downstream__wr_data_imux;

    logic                                               upstream__ack_vld_pre;
    logic   [DATA_WIDTH-1:0]                            upstream__rd_data_pre;
    logic   [FORWARD_NUM-1:0]                           dec_if_sel;
    logic                                               dec_dummy_reg_sel;

    /**************************************************************************
    ** forward datapath
    **************************************************************************/

    assign  soft_rst_o  = soft_rst_i;

    // decode upstream absolute address
    always_comb begin
        dec_if_sel          = {FORWARD_NUM{1'b0}};
        dec_dummy_reg_sel   = 1'b0;
        unique casez (upstream__addr[63:2])
            62'h0,62'h1: dec_if_sel[0] = 1'b1;
            62'h8000000?,62'h8000001?,62'h8000002?,62'h8000003?,62'h80000040,62'h80000041,62'h80000042,62'h80000043: dec_if_sel[1] = 1'b1;
            default: dec_dummy_reg_sel  = 1'b1;
        endcase
    end

    // forward inverse multiplexor for req_vld, addr, wr_en, rd_en, wr_data
    always_comb begin
        for (integer i = 0; i < FORWARD_NUM; i = i + 1) begin
            downstream__req_vld_imux[i]     = 1'b0;
            downstream__addr_imux[i]        = {ADDR_WIDTH{1'b0}};
            downstream__wr_en_imux[i]       = 1'b0;
            downstream__rd_en_imux[i]       = 1'b0;
            downstream__wr_data_imux[i]     = {DATA_WIDTH{1'b0}};

            if (dec_if_sel[i]) begin
                downstream__req_vld_imux[i]  = upstream__req_vld;
                downstream__addr_imux[i]     = upstream__addr;
                downstream__wr_en_imux[i]    = upstream__wr_en;
                downstream__rd_en_imux[i]    = upstream__rd_en;
                downstream__wr_data_imux[i]  = upstream__wr_data;
            end
        end
    end

    // generate address offset and forward other signals
    //      for regdisp, generate absolute address
    //      for regslv, generate address offset
    //      for 3rd party IP, generate absolute address
    //      for external memory, generate address offset
    // there are two methods to convert absolute address to offset,
    // which depends on the base address alignment:
    //      1. base_addr = N * pow(2, ceil(log2(total_size))):
    //          simply set several higher bits to 0 by wire slicing
    //      2. otherwise:
    //          subtract base address from absolute address by generating a subtractor
    always_comb begin
        for (integer i = 0; i < FORWARD_NUM; i = i + 1) begin
            downstream__req_vld_pre[i]      = downstream__req_vld_imux[i];
            downstream__wr_en_pre[i]        = downstream__wr_en_imux[i];
            downstream__rd_en_pre[i]        = downstream__rd_en_imux[i];
            downstream__wr_data_pre[i]      = downstream__wr_data_imux[i];
        end
    end
    assign  downstream__addr_pre[0] = {61'b0, downstream__addr_imux[0][2:0]};
    assign  downstream__addr_pre[1] = downstream__addr_imux[1];

    // optionally insert forwarding flip-flops
    genvar cnt;
    generate
        for (cnt = 0; cnt < FORWARD_NUM; cnt = cnt + 1) begin: g_forward_dff
            if (INSERT_FORWARD_DFF[cnt]) begin: g_with_out_dff
                always @(posedge clk or negedge rst_n) begin
                    if (!rst_n) begin
                        downstream__req_vld[cnt]    <= 1'b0;
                        downstream__addr[cnt]       <= {ADDR_WIDTH{1'b0}};
                        downstream__wr_en[cnt]      <= 1'b0;
                        downstream__rd_en[cnt]      <= 1'b0;
                        downstream__wr_data[cnt]    <= {DATA_WIDTH{1'b0}};
                    end
                    else begin
                        downstream__req_vld[cnt]    <= downstream__req_vld_pre[0];
                        downstream__addr[cnt]       <= downstream__addr_pre[0];
                        downstream__wr_en[cnt]      <= downstream__wr_en_pre[0];
                        downstream__rd_en[cnt]      <= downstream__rd_en_pre[0];
                        downstream__wr_data[cnt]    <= downstream__wr_data_pre[0];
                    end
                end
            end
            else begin: g_wo_out_dff
                assign downstream__req_vld[cnt]     = downstream__req_vld_pre[cnt];
                assign downstream__addr[cnt]        = downstream__addr_pre[cnt];
                assign downstream__wr_en[cnt]       = downstream__wr_en_pre[cnt];
                assign downstream__rd_en[cnt]       = downstream__rd_en_pre[cnt];
                assign downstream__wr_data[cnt]     = downstream__wr_data_pre[cnt];
            end
        end

    endgenerate


    /**************************************************************************
    ** backward datapath
    **************************************************************************/

    // backward multiplexor for rd_data and ack_vld
    assign upstream__ack_vld_pre = | downstream__ack_vld;
    always_comb begin
        upstream__rd_data_pre = {DATA_WIDTH{1'b0}};
        for (integer i = 0; i < FORWARD_NUM; i = i + 1) begin
            if (downstream__ack_vld[i]) begin
                upstream__rd_data_pre = downstream__rd_data[i];
            end
        end
    end

    // optionally insert backward flip-flops after data passes through mux
    generate
        if (INSERT_BACKWARD_DFF) begin: g_with_in_dff
            always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    upstream__ack_vld   <= 1'b0;
                    upstream__rd_data   <= {DATA_WIDTH{1'b0}};
                end
                else begin
                    upstream__ack_vld   <= upstream__ack_vld_pre;
                    upstream__rd_data   <= upstream__rd_data_pre;
                end
            end
        end
        else begin: g_wo_in_dff
            assign upstream__ack_vld    = upstream__ack_vld_pre;
            assign upstream__rd_data    = upstream__rd_data_pre;
        end
    endgenerate

endmodule