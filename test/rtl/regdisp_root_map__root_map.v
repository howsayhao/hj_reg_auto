module regdisp_root_map__root_map (
    // reg_native_if forwarding to map_1
    map_1_clk,
    map_1_rst_n,
    map_1_req_vld,
    map_1_ack_vld,
    map_1_err,
    map_1_addr,
    map_1_wr_en,
    map_1_rd_en,
    map_1_wr_data,
    map_1_rd_data,
    map_1_soft_rst,
    // reg_native_if forwarding to shared_map_0
    shared_map_0_clk,
    shared_map_0_rst_n,
    shared_map_0_req_vld,
    shared_map_0_ack_vld,
    shared_map_0_err,
    shared_map_0_addr,
    shared_map_0_wr_en,
    shared_map_0_rd_en,
    shared_map_0_wr_data,
    shared_map_0_rd_data,
    shared_map_0_soft_rst,
    // reg_native_if forwarding to shared_map_1
    shared_map_1_clk,
    shared_map_1_rst_n,
    shared_map_1_req_vld,
    shared_map_1_ack_vld,
    shared_map_1_err,
    shared_map_1_addr,
    shared_map_1_wr_en,
    shared_map_1_rd_en,
    shared_map_1_wr_data,
    shared_map_1_rd_data,
    shared_map_1_soft_rst,
    // reg_native_if forwarding to shared_map_2
    shared_map_2_clk,
    shared_map_2_rst_n,
    shared_map_2_req_vld,
    shared_map_2_ack_vld,
    shared_map_2_err,
    shared_map_2_addr,
    shared_map_2_wr_en,
    shared_map_2_rd_en,
    shared_map_2_wr_data,
    shared_map_2_rd_data,
    shared_map_2_soft_rst,
    // reg_native_if forwarding to shared_map_3
    shared_map_3_clk,
    shared_map_3_rst_n,
    shared_map_3_req_vld,
    shared_map_3_ack_vld,
    shared_map_3_err,
    shared_map_3_addr,
    shared_map_3_wr_en,
    shared_map_3_rd_en,
    shared_map_3_wr_data,
    shared_map_3_rd_data,
    shared_map_3_soft_rst,
    // reg_native_if forwarding to shared_map_4
    shared_map_4_clk,
    shared_map_4_rst_n,
    shared_map_4_req_vld,
    shared_map_4_ack_vld,
    shared_map_4_err,
    shared_map_4_addr,
    shared_map_4_wr_en,
    shared_map_4_rd_en,
    shared_map_4_wr_data,
    shared_map_4_rd_data,
    shared_map_4_soft_rst,
    // reg_native_if forwarding to shared_map_5
    shared_map_5_clk,
    shared_map_5_rst_n,
    shared_map_5_req_vld,
    shared_map_5_ack_vld,
    shared_map_5_err,
    shared_map_5_addr,
    shared_map_5_wr_en,
    shared_map_5_rd_en,
    shared_map_5_wr_data,
    shared_map_5_rd_data,
    shared_map_5_soft_rst,
    // reg_native_if forwarding to shared_map_6
    shared_map_6_clk,
    shared_map_6_rst_n,
    shared_map_6_req_vld,
    shared_map_6_ack_vld,
    shared_map_6_err,
    shared_map_6_addr,
    shared_map_6_wr_en,
    shared_map_6_rd_en,
    shared_map_6_wr_data,
    shared_map_6_rd_data,
    shared_map_6_soft_rst,
    // reg_native_if forwarding to shared_map_7
    shared_map_7_clk,
    shared_map_7_rst_n,
    shared_map_7_req_vld,
    shared_map_7_ack_vld,
    shared_map_7_err,
    shared_map_7_addr,
    shared_map_7_wr_en,
    shared_map_7_rd_en,
    shared_map_7_wr_data,
    shared_map_7_rd_data,
    shared_map_7_soft_rst,
    // reg_native_if forwarding to shared_map_8
    shared_map_8_clk,
    shared_map_8_rst_n,
    shared_map_8_req_vld,
    shared_map_8_ack_vld,
    shared_map_8_err,
    shared_map_8_addr,
    shared_map_8_wr_en,
    shared_map_8_rd_en,
    shared_map_8_wr_data,
    shared_map_8_rd_data,
    shared_map_8_soft_rst,
    // reg_native_if forwarding to shared_map_9
    shared_map_9_clk,
    shared_map_9_rst_n,
    shared_map_9_req_vld,
    shared_map_9_ack_vld,
    shared_map_9_err,
    shared_map_9_addr,
    shared_map_9_wr_en,
    shared_map_9_rd_en,
    shared_map_9_wr_data,
    shared_map_9_rd_data,
    shared_map_9_soft_rst,
    // reg_native_if forwarded by root_map
    root_map_clk,
    root_map_rst_n,
    root_map_req_vld,
    root_map_ack_vld,
    root_map_err,
    root_map_addr,
    root_map_wr_en,
    root_map_rd_en,
    root_map_wr_data,
    root_map_rd_data,
    root_map_soft_rst
);

    parameter                       ADDR_WIDTH          = 64;
    parameter                       DATA_WIDTH          = 32;
    parameter                       FORWARD_NUM         = 11;
    parameter   [0:FORWARD_NUM-1]   INSERT_FORWARD_DFF  = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
    parameter                       INSERT_BACKWARD_FF  = 0;

    input   logic                                       root_map_clk;
    input   logic                                       root_map_rst_n;
    input   logic                                       root_map_req_vld;
    output  logic                                       root_map_ack_vld;
    output  logic                                       root_map_err;
    input   logic   [ADDR_WIDTH-1:0]                    root_map_addr;
    input   logic                                       root_map_wr_en;
    input   logic                                       root_map_rd_en;
    input   logic   [DATA_WIDTH-1:0]                    root_map_wr_data;
    output  logic   [DATA_WIDTH-1:0]                    root_map_rd_data;
    input   logic                                       root_map_soft_rst;

    input   logic                                       map_1_clk;
    input   logic                                       map_1_rst_n;
    output  logic                                       map_1_req_vld;
    input   logic                                       map_1_ack_vld;
    input   logic                                       map_1_err;
    output  logic   [63:0]                              map_1_addr;
    output  logic                                       map_1_wr_en;
    output  logic                                       map_1_rd_en;
    output  logic   [31:0]                              map_1_wr_data;
    input   logic   [31:0]                              map_1_rd_data;
    output  logic                                       map_1_soft_rst;
    
    input   logic                                       shared_map_0_clk;
    input   logic                                       shared_map_0_rst_n;
    output  logic                                       shared_map_0_req_vld;
    input   logic                                       shared_map_0_ack_vld;
    input   logic                                       shared_map_0_err;
    output  logic   [63:0]                              shared_map_0_addr;
    output  logic                                       shared_map_0_wr_en;
    output  logic                                       shared_map_0_rd_en;
    output  logic   [31:0]                              shared_map_0_wr_data;
    input   logic   [31:0]                              shared_map_0_rd_data;
    output  logic                                       shared_map_0_soft_rst;
    
    input   logic                                       shared_map_1_clk;
    input   logic                                       shared_map_1_rst_n;
    output  logic                                       shared_map_1_req_vld;
    input   logic                                       shared_map_1_ack_vld;
    input   logic                                       shared_map_1_err;
    output  logic   [63:0]                              shared_map_1_addr;
    output  logic                                       shared_map_1_wr_en;
    output  logic                                       shared_map_1_rd_en;
    output  logic   [31:0]                              shared_map_1_wr_data;
    input   logic   [31:0]                              shared_map_1_rd_data;
    output  logic                                       shared_map_1_soft_rst;
    
    input   logic                                       shared_map_2_clk;
    input   logic                                       shared_map_2_rst_n;
    output  logic                                       shared_map_2_req_vld;
    input   logic                                       shared_map_2_ack_vld;
    input   logic                                       shared_map_2_err;
    output  logic   [63:0]                              shared_map_2_addr;
    output  logic                                       shared_map_2_wr_en;
    output  logic                                       shared_map_2_rd_en;
    output  logic   [31:0]                              shared_map_2_wr_data;
    input   logic   [31:0]                              shared_map_2_rd_data;
    output  logic                                       shared_map_2_soft_rst;
    
    input   logic                                       shared_map_3_clk;
    input   logic                                       shared_map_3_rst_n;
    output  logic                                       shared_map_3_req_vld;
    input   logic                                       shared_map_3_ack_vld;
    input   logic                                       shared_map_3_err;
    output  logic   [63:0]                              shared_map_3_addr;
    output  logic                                       shared_map_3_wr_en;
    output  logic                                       shared_map_3_rd_en;
    output  logic   [31:0]                              shared_map_3_wr_data;
    input   logic   [31:0]                              shared_map_3_rd_data;
    output  logic                                       shared_map_3_soft_rst;
    
    input   logic                                       shared_map_4_clk;
    input   logic                                       shared_map_4_rst_n;
    output  logic                                       shared_map_4_req_vld;
    input   logic                                       shared_map_4_ack_vld;
    input   logic                                       shared_map_4_err;
    output  logic   [63:0]                              shared_map_4_addr;
    output  logic                                       shared_map_4_wr_en;
    output  logic                                       shared_map_4_rd_en;
    output  logic   [31:0]                              shared_map_4_wr_data;
    input   logic   [31:0]                              shared_map_4_rd_data;
    output  logic                                       shared_map_4_soft_rst;
    
    input   logic                                       shared_map_5_clk;
    input   logic                                       shared_map_5_rst_n;
    output  logic                                       shared_map_5_req_vld;
    input   logic                                       shared_map_5_ack_vld;
    input   logic                                       shared_map_5_err;
    output  logic   [63:0]                              shared_map_5_addr;
    output  logic                                       shared_map_5_wr_en;
    output  logic                                       shared_map_5_rd_en;
    output  logic   [31:0]                              shared_map_5_wr_data;
    input   logic   [31:0]                              shared_map_5_rd_data;
    output  logic                                       shared_map_5_soft_rst;
    
    input   logic                                       shared_map_6_clk;
    input   logic                                       shared_map_6_rst_n;
    output  logic                                       shared_map_6_req_vld;
    input   logic                                       shared_map_6_ack_vld;
    input   logic                                       shared_map_6_err;
    output  logic   [63:0]                              shared_map_6_addr;
    output  logic                                       shared_map_6_wr_en;
    output  logic                                       shared_map_6_rd_en;
    output  logic   [31:0]                              shared_map_6_wr_data;
    input   logic   [31:0]                              shared_map_6_rd_data;
    output  logic                                       shared_map_6_soft_rst;
    
    input   logic                                       shared_map_7_clk;
    input   logic                                       shared_map_7_rst_n;
    output  logic                                       shared_map_7_req_vld;
    input   logic                                       shared_map_7_ack_vld;
    input   logic                                       shared_map_7_err;
    output  logic   [63:0]                              shared_map_7_addr;
    output  logic                                       shared_map_7_wr_en;
    output  logic                                       shared_map_7_rd_en;
    output  logic   [31:0]                              shared_map_7_wr_data;
    input   logic   [31:0]                              shared_map_7_rd_data;
    output  logic                                       shared_map_7_soft_rst;
    
    input   logic                                       shared_map_8_clk;
    input   logic                                       shared_map_8_rst_n;
    output  logic                                       shared_map_8_req_vld;
    input   logic                                       shared_map_8_ack_vld;
    input   logic                                       shared_map_8_err;
    output  logic   [63:0]                              shared_map_8_addr;
    output  logic                                       shared_map_8_wr_en;
    output  logic                                       shared_map_8_rd_en;
    output  logic   [31:0]                              shared_map_8_wr_data;
    input   logic   [31:0]                              shared_map_8_rd_data;
    output  logic                                       shared_map_8_soft_rst;
    
    input   logic                                       shared_map_9_clk;
    input   logic                                       shared_map_9_rst_n;
    output  logic                                       shared_map_9_req_vld;
    input   logic                                       shared_map_9_ack_vld;
    input   logic                                       shared_map_9_err;
    output  logic   [63:0]                              shared_map_9_addr;
    output  logic                                       shared_map_9_wr_en;
    output  logic                                       shared_map_9_rd_en;
    output  logic   [31:0]                              shared_map_9_wr_data;
    input   logic   [31:0]                              shared_map_9_rd_data;
    output  logic                                       shared_map_9_soft_rst;
    
    logic   [FORWARD_NUM-1:0]                           downstream_req_vld;
    logic   [FORWARD_NUM-1:0]                           downstream_ack_vld;
    logic   [FORWARD_NUM-1:0]                           downstream_err;
    logic   [FORWARD_NUM-1:0] [ADDR_WIDTH-1:0]          downstream_addr;
    logic   [FORWARD_NUM-1:0]                           downstream_wr_en;
    logic   [FORWARD_NUM-1:0]                           downstream_rd_en;
    logic   [FORWARD_NUM-1:0] [DATA_WIDTH-1:0]          downstream_wr_data;
    logic   [FORWARD_NUM-1:0] [DATA_WIDTH-1:0]          downstream_rd_data;
    logic   [FORWARD_NUM-1:0]                           downstream_soft_rst;

    logic   [FORWARD_NUM-1:0]                           downstream_req_vld_ff;
    logic   [FORWARD_NUM-1:0] [ADDR_WIDTH-1:0]          downstream_addr_ff;
    logic   [FORWARD_NUM-1:0]                           downstream_wr_en_ff;
    logic   [FORWARD_NUM-1:0]                           downstream_rd_en_ff;
    logic   [FORWARD_NUM-1:0] [DATA_WIDTH-1:0]          downstream_wr_data_ff;

    logic   [FORWARD_NUM-1:0]                           downstream_req_vld_imux;
    logic   [FORWARD_NUM-1:0] [ADDR_WIDTH-1:0]          downstream_addr_imux;
    logic   [FORWARD_NUM-1:0]                           downstream_wr_en_imux;
    logic   [FORWARD_NUM-1:0]                           downstream_rd_en_imux;
    logic   [FORWARD_NUM-1:0] [DATA_WIDTH-1:0]          downstream_wr_data_imux;

    logic   [FORWARD_NUM-1:0] [ADDR_WIDTH-1:0]          downstream_addr_conv;

    logic                                               root_map_ack_vld_mux;
    logic                                               root_map_err_mux;
    logic   [DATA_WIDTH-1:0]                            root_map_rd_data_mux;
    logic   [FORWARD_NUM-1:0]                           dec_if_sel;
    logic                                               dec_dummy_reg_sel;
    logic                                               dummy_reg_ack_vld;
    logic                                               err_acc_dummy;

    /**************************************************************************
    ** forward datapath
    **************************************************************************/

    // decode upstream absolute address
    always_comb begin
        dec_if_sel          = {FORWARD_NUM{1'b0}};
        dec_dummy_reg_sel   = 1'b0;
        unique casez (root_map_addr[63:2])
            62'h0?,62'h1?,62'h2?,62'h3?,62'h40,62'h41,62'h42,62'h43,62'h44,62'h45: dec_if_sel[0] = 1'b1;
            62'h48,62'h49,62'h4a,62'h4b: dec_if_sel[1] = 1'b1;
            62'h4c,62'h4d,62'h4e,62'h4f: dec_if_sel[2] = 1'b1;
            62'h50,62'h51,62'h52,62'h53: dec_if_sel[3] = 1'b1;
            62'h54,62'h55,62'h56,62'h57: dec_if_sel[4] = 1'b1;
            62'h58,62'h59,62'h5a,62'h5b: dec_if_sel[5] = 1'b1;
            62'h5c,62'h5d,62'h5e,62'h5f: dec_if_sel[6] = 1'b1;
            62'h60,62'h61,62'h62,62'h63: dec_if_sel[7] = 1'b1;
            62'h64,62'h65,62'h66,62'h67: dec_if_sel[8] = 1'b1;
            62'h68,62'h69,62'h6a,62'h6b: dec_if_sel[9] = 1'b1;
            62'h6c,62'h6d,62'h6e,62'h6f: dec_if_sel[10] = 1'b1;
            default: dec_dummy_reg_sel  = 1'b1;
        endcase
    end

    assign  err_acc_dummy   = dec_dummy_reg_sel & root_map_req_vld;

    // forward inverse multiplexor for req_vld, addr, wr_en, rd_en, wr_data
    always_comb begin
        for (integer i = 0; i < FORWARD_NUM; i = i + 1) begin
            downstream_req_vld_imux[i]      = 1'b0;
            downstream_addr_imux[i]         = {ADDR_WIDTH{1'b0}};
            downstream_wr_en_imux[i]        = 1'b0;
            downstream_rd_en_imux[i]        = 1'b0;
            downstream_wr_data_imux[i]      = {DATA_WIDTH{1'b0}};

            if (dec_if_sel[i]) begin
                downstream_req_vld_imux[i]  = root_map_req_vld;
                downstream_addr_imux[i]     = root_map_addr;
                downstream_wr_en_imux[i]    = root_map_wr_en;
                downstream_rd_en_imux[i]    = root_map_rd_en;
                downstream_wr_data_imux[i]  = root_map_wr_data;
            end
        end
    end

    // generate address offset and forward other signals
    //      regdisp: absolute address (forced)
    //      regslv: address offset (forced)
    //      3rd party IP: generate absolute address (default)
    //      memory interface: address offset (default)
    // there are two methods to convert absolute address to offset,
    // which depends on the base address alignment:
    //      1. base_addr = N * pow(2, ceil(log2(total_size))):
    //          simply set several higher bits to 0 by slicing
    //      2. otherwise:
    //          subtract base address from absolute address by generating a subtractor
    assign  downstream_addr_conv[0] = {55'b0, downstream_addr_imux[0][8:0]};
    assign  downstream_addr_conv[1] = downstream_addr_imux[1] - 64'h120;
    assign  downstream_addr_conv[2] = downstream_addr_imux[2] - 64'h130;
    assign  downstream_addr_conv[3] = downstream_addr_imux[3] - 64'h140;
    assign  downstream_addr_conv[4] = downstream_addr_imux[4] - 64'h150;
    assign  downstream_addr_conv[5] = downstream_addr_imux[5] - 64'h160;
    assign  downstream_addr_conv[6] = downstream_addr_imux[6] - 64'h170;
    assign  downstream_addr_conv[7] = downstream_addr_imux[7] - 64'h180;
    assign  downstream_addr_conv[8] = downstream_addr_imux[8] - 64'h190;
    assign  downstream_addr_conv[9] = downstream_addr_imux[9] - 64'h1a0;
    assign  downstream_addr_conv[10] = downstream_addr_imux[10] - 64'h1b0;

    // optionally insert forwarding flip-flops,
    // which depends on hj_use_forward_ff in child addrmaps
    genvar cnt;
    generate
        for (cnt = 0; cnt < FORWARD_NUM; cnt = cnt + 1) begin: g_forward_ff_out
            if (INSERT_FORWARD_DFF[cnt]) begin: g_forward_ff_in
                always @(posedge root_map_clk or negedge root_map_rst_n) begin
                    if (!root_map_rst_n) begin
                        downstream_req_vld_ff[cnt]      <= 1'b0;
                        downstream_addr_ff[cnt]         <= {ADDR_WIDTH{1'b0}};
                        downstream_wr_en_ff[cnt]        <= 1'b0;
                        downstream_rd_en_ff[cnt]        <= 1'b0;
                        downstream_wr_data_ff[cnt]      <= {DATA_WIDTH{1'b0}};
                    end
                    else begin
                        downstream_req_vld_ff[cnt]      <= downstream_req_vld_imux[cnt];
                        downstream_addr_ff[cnt]         <= downstream_addr_conv[cnt];
                        downstream_wr_en_ff[cnt]        <= downstream_wr_en_imux[cnt];
                        downstream_rd_en_ff[cnt]        <= downstream_rd_en_imux[cnt];
                        downstream_wr_data_ff[cnt]      <= downstream_wr_data_imux[cnt];
                        downstream_soft_rst[cnt]        <= root_map_soft_rst;
                    end
                end
            end
            else begin: g_no_forward_ff_in
                assign downstream_req_vld_ff[cnt]       = downstream_req_vld_imux[cnt];
                assign downstream_addr_ff[cnt]          = downstream_addr_conv[cnt];
                assign downstream_wr_en_ff[cnt]         = downstream_wr_en_imux[cnt];
                assign downstream_rd_en_ff[cnt]         = downstream_rd_en_imux[cnt];
                assign downstream_wr_data_ff[cnt]       = downstream_wr_data_imux[cnt];
                assign downstream_soft_rst[cnt]         = root_map_soft_rst;
            end
        end
    endgenerate

    assign  map_1_req_vld              = downstream_req_vld_ff[0];
    assign  downstream_ack_vld[0] = map_1_ack_vld;
    assign  downstream_err[0]     = map_1_err;
    assign  map_1_addr                 = downstream_addr_ff[0];
    assign  map_1_wr_en                = downstream_wr_en_ff[0];
    assign  map_1_rd_en                = downstream_rd_en_ff[0];
    assign  map_1_wr_data              = downstream_wr_data_ff[0];
    assign  downstream_rd_data[0] = map_1_rd_data;
    assign  map_1_soft_rst             = downstream_soft_rst[0];
    assign  shared_map_0_req_vld              = downstream_req_vld_ff[1];
    assign  downstream_ack_vld[1] = shared_map_0_ack_vld;
    assign  downstream_err[1]     = shared_map_0_err;
    assign  shared_map_0_addr                 = downstream_addr_ff[1];
    assign  shared_map_0_wr_en                = downstream_wr_en_ff[1];
    assign  shared_map_0_rd_en                = downstream_rd_en_ff[1];
    assign  shared_map_0_wr_data              = downstream_wr_data_ff[1];
    assign  downstream_rd_data[1] = shared_map_0_rd_data;
    assign  shared_map_0_soft_rst             = downstream_soft_rst[1];
    assign  shared_map_1_req_vld              = downstream_req_vld_ff[2];
    assign  downstream_ack_vld[2] = shared_map_1_ack_vld;
    assign  downstream_err[2]     = shared_map_1_err;
    assign  shared_map_1_addr                 = downstream_addr_ff[2];
    assign  shared_map_1_wr_en                = downstream_wr_en_ff[2];
    assign  shared_map_1_rd_en                = downstream_rd_en_ff[2];
    assign  shared_map_1_wr_data              = downstream_wr_data_ff[2];
    assign  downstream_rd_data[2] = shared_map_1_rd_data;
    assign  shared_map_1_soft_rst             = downstream_soft_rst[2];
    assign  shared_map_2_req_vld              = downstream_req_vld_ff[3];
    assign  downstream_ack_vld[3] = shared_map_2_ack_vld;
    assign  downstream_err[3]     = shared_map_2_err;
    assign  shared_map_2_addr                 = downstream_addr_ff[3];
    assign  shared_map_2_wr_en                = downstream_wr_en_ff[3];
    assign  shared_map_2_rd_en                = downstream_rd_en_ff[3];
    assign  shared_map_2_wr_data              = downstream_wr_data_ff[3];
    assign  downstream_rd_data[3] = shared_map_2_rd_data;
    assign  shared_map_2_soft_rst             = downstream_soft_rst[3];
    assign  shared_map_3_req_vld              = downstream_req_vld_ff[4];
    assign  downstream_ack_vld[4] = shared_map_3_ack_vld;
    assign  downstream_err[4]     = shared_map_3_err;
    assign  shared_map_3_addr                 = downstream_addr_ff[4];
    assign  shared_map_3_wr_en                = downstream_wr_en_ff[4];
    assign  shared_map_3_rd_en                = downstream_rd_en_ff[4];
    assign  shared_map_3_wr_data              = downstream_wr_data_ff[4];
    assign  downstream_rd_data[4] = shared_map_3_rd_data;
    assign  shared_map_3_soft_rst             = downstream_soft_rst[4];
    assign  shared_map_4_req_vld              = downstream_req_vld_ff[5];
    assign  downstream_ack_vld[5] = shared_map_4_ack_vld;
    assign  downstream_err[5]     = shared_map_4_err;
    assign  shared_map_4_addr                 = downstream_addr_ff[5];
    assign  shared_map_4_wr_en                = downstream_wr_en_ff[5];
    assign  shared_map_4_rd_en                = downstream_rd_en_ff[5];
    assign  shared_map_4_wr_data              = downstream_wr_data_ff[5];
    assign  downstream_rd_data[5] = shared_map_4_rd_data;
    assign  shared_map_4_soft_rst             = downstream_soft_rst[5];
    assign  shared_map_5_req_vld              = downstream_req_vld_ff[6];
    assign  downstream_ack_vld[6] = shared_map_5_ack_vld;
    assign  downstream_err[6]     = shared_map_5_err;
    assign  shared_map_5_addr                 = downstream_addr_ff[6];
    assign  shared_map_5_wr_en                = downstream_wr_en_ff[6];
    assign  shared_map_5_rd_en                = downstream_rd_en_ff[6];
    assign  shared_map_5_wr_data              = downstream_wr_data_ff[6];
    assign  downstream_rd_data[6] = shared_map_5_rd_data;
    assign  shared_map_5_soft_rst             = downstream_soft_rst[6];
    assign  shared_map_6_req_vld              = downstream_req_vld_ff[7];
    assign  downstream_ack_vld[7] = shared_map_6_ack_vld;
    assign  downstream_err[7]     = shared_map_6_err;
    assign  shared_map_6_addr                 = downstream_addr_ff[7];
    assign  shared_map_6_wr_en                = downstream_wr_en_ff[7];
    assign  shared_map_6_rd_en                = downstream_rd_en_ff[7];
    assign  shared_map_6_wr_data              = downstream_wr_data_ff[7];
    assign  downstream_rd_data[7] = shared_map_6_rd_data;
    assign  shared_map_6_soft_rst             = downstream_soft_rst[7];
    assign  shared_map_7_req_vld              = downstream_req_vld_ff[8];
    assign  downstream_ack_vld[8] = shared_map_7_ack_vld;
    assign  downstream_err[8]     = shared_map_7_err;
    assign  shared_map_7_addr                 = downstream_addr_ff[8];
    assign  shared_map_7_wr_en                = downstream_wr_en_ff[8];
    assign  shared_map_7_rd_en                = downstream_rd_en_ff[8];
    assign  shared_map_7_wr_data              = downstream_wr_data_ff[8];
    assign  downstream_rd_data[8] = shared_map_7_rd_data;
    assign  shared_map_7_soft_rst             = downstream_soft_rst[8];
    assign  shared_map_8_req_vld              = downstream_req_vld_ff[9];
    assign  downstream_ack_vld[9] = shared_map_8_ack_vld;
    assign  downstream_err[9]     = shared_map_8_err;
    assign  shared_map_8_addr                 = downstream_addr_ff[9];
    assign  shared_map_8_wr_en                = downstream_wr_en_ff[9];
    assign  shared_map_8_rd_en                = downstream_rd_en_ff[9];
    assign  shared_map_8_wr_data              = downstream_wr_data_ff[9];
    assign  downstream_rd_data[9] = shared_map_8_rd_data;
    assign  shared_map_8_soft_rst             = downstream_soft_rst[9];
    assign  shared_map_9_req_vld              = downstream_req_vld_ff[10];
    assign  downstream_ack_vld[10] = shared_map_9_ack_vld;
    assign  downstream_err[10]     = shared_map_9_err;
    assign  shared_map_9_addr                 = downstream_addr_ff[10];
    assign  shared_map_9_wr_en                = downstream_wr_en_ff[10];
    assign  shared_map_9_rd_en                = downstream_rd_en_ff[10];
    assign  shared_map_9_wr_data              = downstream_wr_data_ff[10];
    assign  downstream_rd_data[10] = shared_map_9_rd_data;
    assign  shared_map_9_soft_rst             = downstream_soft_rst[10];
    

    /**************************************************************************
    ** backward datapath
    **************************************************************************/

    // backward multiplexor for rd_data, ack_vld and err
    assign  dummy_reg_ack_vld           = dec_dummy_reg_sel & root_map_req_vld;
    assign  root_map_ack_vld_mux = (| downstream_ack_vld) | dummy_reg_ack_vld;
    assign  root_map_err_mux     = (| downstream_err) | err_acc_dummy;

    always_comb begin
        root_map_rd_data_mux = {DATA_WIDTH{1'b0}};
        if (!dummy_reg_ack_vld) begin
            for (integer i = 0; i < FORWARD_NUM; i = i + 1) begin
                if (downstream_ack_vld[i]) begin
                    root_map_rd_data_mux   = downstream_rd_data[i];
                end
            end
        end
    end

    // optionally insert backward flip-flops after data passes through mux
    generate
        if (INSERT_BACKWARD_FF) begin: g_backward_ff
            always @(posedge root_map_clk or negedge root_map_rst_n) begin
                if (!root_map_rst_n) begin
                    root_map_ack_vld     <= 1'b0;
                    root_map_err         <= 1'b0;
                    root_map_rd_data     <= {DATA_WIDTH{1'b0}};
                end
                else begin
                    root_map_ack_vld     <= root_map_ack_vld_mux;
                    root_map_err         <= root_map_err_mux;
                    root_map_rd_data     <= root_map_rd_data_mux;
                end
            end
        end
        else begin: g_wo_backward_ff
            assign  root_map_ack_vld     = root_map_ack_vld_mux;
            assign  root_map_err         = root_map_err_mux;
            assign  root_map_rd_data     = root_map_rd_data_mux;
        end
    endgenerate

endmodule