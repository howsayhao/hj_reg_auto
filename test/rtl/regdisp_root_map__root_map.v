module regdisp_root_map__root_map (
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
    downstream__rd_data
);

    parameter   ADDR_WIDTH                              = 64;
    parameter   DATA_WIDTH                              = 32;
    parameter   FORWARD_NUM                             = 3;
    parameter   [0:FORWARD_NUM-1]   INSERT_FORWARD_DFF  = {1'b0,1'b0,1'b0};
    parameter   INSERT_BACKWARD_DFF                     = 0;

    input   logic   clk, rst_n;

    input   logic   upstream__req_vld;
    output  logic   upstream__ack_vld;
    input   logic   [ADDR_WIDTH-1:0]    upstream__addr;
    input   logic   upstream__wr_en;
    input   logic   upstream__rd_en;
    input   logic   [DATA_WIDTH-1:0]    upstream__wr_data;
    output  logic   [DATA_WIDTH-1:0]    upstream__rd_data;

    output  logic   [FORWARD_NUM-1:0]   downstream__req_vld;
    input   logic   [FORWARD_NUM-1:0]   downstream__ack_vld;
    output  logic   [FORWARD_NUM-1:0] [ADDR_WIDTH-1:0]  downstream__addr;
    output  logic   [FORWARD_NUM-1:0]   downstream__wr_en;
    output  logic   [FORWARD_NUM-1:0]   downstream__rd_en;
    output  logic   [FORWARD_NUM-1:0] [DATA_WIDTH-1:0]  downstream__wr_data;
    input   logic   [FORWARD_NUM-1:0] [DATA_WIDTH-1:0]  downstream__rd_data;

    logic   [FORWARD_NUM-1:0]   downstream__req_vld_pre;
    logic   [FORWARD_NUM-1:0] [ADDR_WIDTH-1:0]  downstream__addr_pre;
    logic   [FORWARD_NUM-1:0]   downstream__wr_en_pre;
    logic   [FORWARD_NUM-1:0]   downstream__rd_en_pre;
    logic   [FORWARD_NUM-1:0] [DATA_WIDTH-1:0]  downstream__wr_data_pre;

    logic   [FORWARD_NUM-1:0]   downstream__req_vld_imux;
    logic   [FORWARD_NUM-1:0] [ADDR_WIDTH-1:0]  downstream__addr_imux;
    logic   [FORWARD_NUM-1:0]   downstream__wr_en_imux;
    logic   [FORWARD_NUM-1:0]   downstream__rd_en_imux;
    logic   [FORWARD_NUM-1:0]   downstream__wr_data_imux;

    logic   upstream__ack_vld_pre;
    logic   [DATA_WIDTH-1:0]    upstream__rd_data_pre;

    logic   [FORWARD_NUM-1:0]   if_sel;
    logic   no_sel;

    /**************************************************************************
    ** forward datapath
    **************************************************************************/

    // decode upstream absolute address
    always_comb begin
        if_sel = {FORWARD_NUM{1'b0}};
        no_sel = 1'b0;
        unique casez (upstream__addr[63:2])
            62'h0?,62'h1?,62'h2?,62'h3?,62'h40,62'h41,62'h42,62'h43,62'h44,62'h45: if_sel[0] = 1'b1;
            62'h46,62'h47: if_sel[1] = 1'b1;
            62'h8?,62'h9?,62'ha?,62'hb?,62'hc0,62'hc1,62'hc2,62'hc3: if_sel[2] = 1'b1;
            default: no_sel = 1'b1;
        endcase
    end

    // forward inverse multiplexor for req_vld, addr, wr_en, rd_en, wr_data
    always_comb begin
        for (integer i = 0; i < FORWARD_NUM; i = i + 1) begin
            downstream__req_vld_imux[i]  = 1'b0;
            downstream__addr_imux[i]     = {ADDR_WIDTH{1'b0}};
            downstream__wr_en_imux[i]    = 1'b0;
            downstream__rd_en_imux[i]    = 1'b0;
            downstream__wr_data_imux[i]  = {DATA_WIDTH{1'b0}};

            if (if_sel[i]) begin
                downstream__req_vld_imux[i]  = upstream__req_vld;
                downstream__addr_imux[i]     = upstream__addr;
                downstream__wr_en_imux[i]    = upstream__wr_en;
                downstream__rd_en_imux[i]    = upstream__rd_en;
                downstream__wr_data_imux[i]  = upstream__wr_data;
            end
        end
    end

    // generate address offset
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
    assign  downstream__addr_pre[0] = {55'b0, downstream__addr_imux[0][8:0]};
    assign  downstream__addr_pre[1] = {61'b0, downstream__addr_imux[1][2:0]};
    assign  downstream__addr_pre[2] = downstream__addr_imux[2];

    // insert forwarding flip-flops
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
                assign downstream__req_vld[cnt]  = downstream__req_vld_pre[cnt];
                assign downstream__addr[cnt]     = downstream__addr_pre[cnt];
                assign downstream__wr_en[cnt]    = downstream__wr_en_pre[cnt];
                assign downstream__rd_en[cnt]    = downstream__rd_en_pre[cnt];
                assign downstream__wr_data[cnt]  = downstream__wr_data_pre[cnt];
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

    // insert backward flip-flops after data passes through mux
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