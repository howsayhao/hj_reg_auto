`default_nettype none
module snapshot_mem (
    clk, rst_n, soft_rst,
    // upstream reg_native_if
    req_vld, ack_vld, err, addr, wr_en, rd_en, wr_data, rd_data,
    // downstream memory interface
    mem_req_vld, mem_ack_vld, mem_err, mem_addr, mem_wr_en, mem_rd_en, mem_wr_data, mem_rd_data
);

    `include "common_funcs.vh"

    parameter   BUS_DATA_WIDTH                  = 32;
    parameter   BUS_ADDR_WIDTH                  = 64;
    parameter   MEM_DATA_WIDTH                  = 64;
    parameter   MEM_ADDR_WIDTH                  = 32;
    parameter   RST_VALUE                       = {MEM_DATA_WIDTH{1'b0}};

    localparam  PARTITION_CNT                   = MEM_DATA_WIDTH / BUS_DATA_WIDTH;
    localparam  BYTE_WIDTH                      = 8;
    localparam  RESERVERD_BITS                  = log2(MEM_DATA_WIDTH / BYTE_WIDTH);

    localparam  S_IDLE                          = 3'b001;
    localparam  S_ACC_MEM                       = 3'b010;
    localparam  S_READ_SS                       = 3'b100;

    input   logic                               clk;
    input   logic                               rst_n;
    input   logic                               soft_rst;
    input   logic                               req_vld;
    output  logic                               ack_vld;
    output  logic                               err;
    input   logic   [BUS_ADDR_WIDTH-1:0]        addr;
    input   logic                               wr_en;
    input   logic                               rd_en;
    input   logic   [BUS_DATA_WIDTH-1:0]        wr_data;
    output  logic   [BUS_DATA_WIDTH-1:0]        rd_data;

    output  logic                               mem_req_vld;
    input   logic                               mem_ack_vld;
    input   logic                               mem_err;
    output  logic   [MEM_ADDR_WIDTH-1:0]        mem_addr;
    output  logic                               mem_wr_en;
    output  logic                               mem_rd_en;
    output  logic   [MEM_DATA_WIDTH-1:0]        mem_wr_data;
    input   logic   [MEM_DATA_WIDTH-1:0]        mem_rd_data;

    logic   [PARTITION_CNT-1:0]                 ss_rd_en;
    logic   [PARTITION_CNT-1:0]                 ss_wr_en;
    logic   [PARTITION_CNT-1:0]                 ss_rd_en_ff;
    logic   [MEM_DATA_WIDTH-1:0]                ss_reg;
    logic                                       ss_acc_wr;
    logic                                       ss_acc_rd;
    logic   [BUS_DATA_WIDTH-1:0]                ss_rd_data;
    logic                                       mem_acc_wr;
    logic                                       mem_acc_rd;
    logic                                       mem_acc;

    logic   [2:0]                               state;
    logic   [2:0]                               next_state;

    genvar                                      i, j;

    generate
        for (i = 0; i < PARTITION_CNT; i = i + 1) begin: g_ss_dec
            assign ss_wr_en[i]      = (addr[RESERVERD_BITS-1:0] == i * (BUS_DATA_WIDTH / BYTE_WIDTH)) ? (req_vld & wr_en) : 1'b0;
            assign ss_rd_en[i]      = (addr[RESERVERD_BITS-1:0] == i * (BUS_DATA_WIDTH / BYTE_WIDTH)) ? (req_vld & rd_en) : 1'b0;
        end

        if (PARTITION_CNT > 1) begin: g_ss_acc
            assign  ss_acc_wr           = |ss_wr_en[PARTITION_CNT-1:1];
            assign  ss_acc_rd           = |ss_rd_en[PARTITION_CNT-1:1];
        end else begin : g_no_ss_acc
            assign  ss_acc_wr           = 1'b0;
            assign  ss_acc_rd           = 1'b0;
        end
    endgenerate

    assign  mem_acc_wr              = ss_wr_en[0];
    assign  mem_acc_rd              = ss_rd_en[0];
    assign  mem_acc                 = mem_acc_wr | mem_acc_rd;

    // state register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state   <= S_IDLE;
        else if (soft_rst)
            state   <= S_IDLE;
        else
            state   <= next_state;
    end

    // state transition logic
    always_comb begin
        if (soft_rst)
            next_state = S_IDLE;
        else begin
            case (state)
                S_IDLE:
                    if (mem_acc)
                        next_state = S_ACC_MEM;
                    else if (ss_acc_rd)
                        next_state = S_READ_SS;
                    else    // snapshot write finishes immediately
                        next_state = S_IDLE;
                S_ACC_MEM:
                    if (mem_ack_vld)
                        next_state = S_IDLE;
                    else
                        next_state = S_ACC_MEM;
                S_READ_SS:
                    next_state = S_IDLE;
                default:
                    next_state = S_IDLE;
            endcase
        end
    end

    // snapshot register
    generate
        for (j = 0; j < PARTITION_CNT; j = j + 1) begin: g_ss_reg
            always @(posedge clk or negedge rst_n) begin
                if (!rst_n)
                    ss_reg[j*BUS_DATA_WIDTH +: BUS_DATA_WIDTH]  <= {BUS_DATA_WIDTH{1'b0}};
                else if (state == S_ACC_MEM && mem_ack_vld)    // read from memory
                    ss_reg[j*BUS_DATA_WIDTH +: BUS_DATA_WIDTH]  <= mem_rd_data[j*BUS_DATA_WIDTH +: BUS_DATA_WIDTH];
                else if (ss_wr_en[j])           // write to snapshot register
                    ss_reg[j*BUS_DATA_WIDTH +: BUS_DATA_WIDTH]  <= wr_data[0 +: BUS_DATA_WIDTH];
            end
        end
    endgenerate

    // output

    // convert reg_native_if to memory interface: write and read memory
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mem_req_vld             <= 1'b0;
            mem_wr_en               <= 1'b0;
            mem_rd_en               <= 1'b0;
            mem_addr                <= {MEM_ADDR_WIDTH{1'b0}};
        end else if (soft_rst) begin
            mem_req_vld             <= 1'b0;
            mem_wr_en               <= 1'b0;
            mem_rd_en               <= 1'b0;
            mem_addr                <= {MEM_ADDR_WIDTH{1'b0}};
        end else if (state == S_IDLE && next_state == S_ACC_MEM) begin
            mem_req_vld             <= 1'b1;
            if (mem_acc_wr)
                mem_wr_en           <= 1'b1;
            if (mem_acc_rd)
                mem_rd_en           <= 1'b1;
            mem_addr                <= addr[RESERVERD_BITS+MEM_ADDR_WIDTH-1:RESERVERD_BITS];
        end else if (state == S_ACC_MEM && next_state == S_IDLE) begin
            mem_req_vld             <= 1'b0;
            mem_wr_en               <= 1'b0;
            mem_rd_en               <= 1'b0;
            mem_addr                <= {MEM_ADDR_WIDTH{1'b0}};
        end
    end
    assign  mem_wr_data             = (state == S_ACC_MEM) ? ss_reg : {MEM_DATA_WIDTH{1'b0}};

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            ss_rd_en_ff <= {PARTITION_CNT{1'b0}};
        else if (soft_rst)
            ss_rd_en_ff <= {PARTITION_CNT{1'b0}};
        else
            ss_rd_en_ff <= ss_rd_en;
    end

    one_hot_mux #(
        .WIDTH (BUS_DATA_WIDTH), .CNT (PARTITION_CNT)
    ) ss_rd_data_mux (
        .din (ss_reg),
        .sel (ss_rd_en_ff),
        .dout (ss_rd_data),
        .err ()
    );

    // ack_vld, err, rd_data to upstream reg_native_if
    always_comb begin
        ack_vld                 = 1'b0;
        err                     = 1'b0;
        rd_data                 = {BUS_DATA_WIDTH{1'b0}};
        case (state)
            S_IDLE:
                if (ss_acc_wr)
                    ack_vld     = 1'b1;
            S_READ_SS: begin    // snapshot does not raise error
                ack_vld         = 1'b1;
                rd_data         = ss_rd_data;
            end
            S_ACC_MEM:
                if (mem_ack_vld) begin
                    ack_vld     = 1'b1;
                    if (mem_err)
                        err     = 1'b1;
                    rd_data     = mem_rd_data[BUS_DATA_WIDTH-1:0];
                end
            default: begin
                ack_vld         = 1'b0;
                err             = 1'b0;
                rd_data         = {BUS_DATA_WIDTH{1'b0}};
            end
        endcase
    end
endmodule
`default_nettype wire