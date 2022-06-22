`default_nettype none
module snapshot_mem (
    clk, rst_n, soft_rst,
    // upstream reg_native_if
    req_vld, ack_vld, addr, wr_en, rd_en, wr_data, rd_data,
    // downstream memory interface
    mem_req_vld, mem_ack_vld, mem_addr, mem_wr_en, mem_rd_en, mem_wr_data, mem_rd_data
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
    localparam  S_ACC_SNAPSHOT                  = 3'b100;

    localparam  _S_IDLE_                        = 0;
    localparam  _S_ACC_MEM_                     = 1;
    localparam  _S_ACC_SNAPSHOT_                = 2;

    input   logic                               clk;
    input   logic                               rst_n;
    input   logic   [BUS_ADDR_WIDTH-1:0]        addr;
    input   logic   [BUS_DATA_WIDTH-1:0]        wr_data;
    output  logic   [BUS_DATA_WIDTH-1:0]        rd_data;
    input   logic                               req_vld;
    output  logic                               ack_vld;
    input                                       wr_en,rd_en;
    input                                       soft_rst;

    output  logic                               mem_req_vld;
    input   logic                               mem_ack_vld;
    output  logic   [MEM_ADDR_WIDTH-1:0]        mem_addr;
    output  logic                               mem_rd_en;
    output  logic                               mem_wr_en;
    output  logic   [MEM_DATA_WIDTH-1:0]        mem_wr_data;
    input   logic   [MEM_DATA_WIDTH-1:0]        mem_rd_data;

    logic                                       req_vld_ff;
    logic                                       wr_en_ff;
    logic                                       rd_en_ff;
    logic   [PARTITION_CNT-1:0]                 snapshot_rd_en;
    logic   [PARTITION_CNT-1:0]                 snapshot_wr_en;
    logic   [PARTITION_CNT-1:0]                 snapshot_wr_en_ff;
    logic   [PARTITION_CNT-1:0]                 snapshot_rd_en_ff;
    logic   [BUS_ADDR_WIDTH-1:0]                addr_ff;
    logic   [BUS_DATA_WIDTH-1:0]                wr_data_ff;
    logic   [MEM_DATA_WIDTH-1:0]                mem_rd_data_int;
    logic   [MEM_DATA_WIDTH-1:0]                snapshot_reg;
    logic                                       mem_access;

    logic                                       ack_vld_rd;
    logic                                       ack_vld_wr;
    logic                                       mem_ack_vld_ff;

    logic   [2:0]                               state;
    logic   [2:0]                               next_state;

    always @(posedge clk or negedge rst_n)
        if (!rst_n | soft_rst)
            mem_ack_vld_ff  <= 1'b0;
        else
            mem_ack_vld_ff  <= mem_ack_vld;

    always @(posedge clk or negedge rst_n)
        if (!rst_n | soft_rst) begin
            req_vld_ff              <= 1'b0;
            wr_en_ff                <= 1'b0;
            rd_en_ff                <= 1'b0;
            addr_ff                 <= {BUS_ADDR_WIDTH{1'b0}};
        end else if (has_access) begin
            req_vld_ff              <= req_vld;
            wr_en_ff                <= wr_en;
            rd_en_ff                <= rd_en;
            addr_ff                 <= {BUS_ADDR_WIDTH{1'b0}};
        end else if (ack_vld) begin
            req_vld_ff              <= 1'b0;
            wr_en_ff                <= 1'b0;
            rd_en_ff                <= 1'b0;
            addr_ff                 <= {BUS_ADDR_WIDTH{1'b0}};
        end

    genvar i;
    generate
        if (MEM_DATA_WIDTH > BUS_DATA_WIDTH) begin: g_snapshot
            for (i = 0; i < PARTITION_CNT; i = i + 1) begin: g_snapshot_dec
                assign snapshot_wr_en[i]    = (addr[RESERVERD_BITS-1:0] == i * (BUS_DATA_WIDTH / BYTE_WIDTH)) ? (req_vld & wr_en) : 1'b0;
                assign snapshot_rd_en[i]    = (addr[RESERVERD_BITS-1:0] == i * (BUS_DATA_WIDTH / BYTE_WIDTH)) ? (req_vld & rd_en) : 1'b0;
            end

            assign mem_access           = snapshot_rd_en[0] | snapshot_wr_en[0];
            assign snapshot_access      = (| snapshot_rd_en[3:1]) | (| snapshot_wr_en[3:1]);
            assign has_access           = mem_access | snapshot_access;

            for (i = 0; i < PARTITION_CNT; i = i + 1) begin: g_snapshot_reg
                always @(posedge clk or negedge rst_n) begin
                    if (!rst_n)
                        snapshot_reg[i*BUS_DATA_WIDTH +: BUS_DATA_WIDTH] <= {BUS_DATA_WIDTH{1'b0}};
                    else if (next_state == S_ACC_MEM & rd_en_ff)
                        snapshot_reg[i*BUS_DATA_WIDTH +: BUS_DATA_WIDTH] <= mem_rd_data[i*BUS_DATA_WIDTH +: BUS_DATA_WIDTH];
                    else if (snapshot_wr_en[i])
                        snapshot_reg[i*BUS_DATA_WIDTH +: BUS_DATA_WIDTH] <= wr_data[0 +: BUS_DATA_WIDTH];
                end
            end

            assign mem_wr_data = snapshot_reg;
        end
        else begin: g_no_snapshot
            assign mem_wr_data = wr_data_ff;
        end
    endgenerate

    one_hot_mux #(
        .WIDTH (BUS_DATA_WIDTH), .CNT (PARTITION_CNT)
    )
    x_mux_rd_data (
        .din (snapshot_reg),
        .sel (snapshot_rd_en_ff),
        .dout (rd_data),
        .err ()
    );

    // state register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n | soft_rst)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    assign ack_vld_rd      = snapshot_rd_en_ff[0] ? mem_ack_vld : (state == S_ACC_SNAPSHOT) & rd_en_ff;
    assign ack_vld_wr      = snapshot_wr_en_ff[0] ? mem_ack_vld : (state == S_ACC_SNAPSHOT) & wr_en_ff;

    // state transition logic
    always_comb begin
        if (soft_rst)
            next_state = S_IDLE;
        else begin
            case (state)
                S_IDLE:
                    if (has_access)
                        if (mem_access)
                            next_state = S_ACC_MEM;
                        else
                            next_state = S_ACC_SNAPSHOT;
                    else
                        next_state = S_IDLE;
                S_ACC_MEM:
                    if (mem_ack_vld)
                        next_state = S_IDLE;
                    else
                        next_state = S_ACC_MEM;
                S_ACC_SNAPSHOT:
                    next_state = S_IDLE;
                default:
                    next_state = S_IDLE;
            endcase
        end
    end

    // output
    assign ack_vld          = ack_vld_rd | ack_vld_wr;
    assign mem_req_vld      = (state == S_ACC_MEM);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n | soft_rst)
            wr_data_ff  <= {BUS_DATA_WIDTH{1'b0}};
        else if (has_access) begin
            wr_data_ff  <= wr_data;
        end
    end

    assign mem_addr  = (state == S_IDLE) ? addr[BUS_ADDR_WIDTH-1:BUS_ADDR_WIDTH-MEM_ADDR_WIDTH] : addr_ff[BUS_ADDR_WIDTH-1:BUS_ADDR_WIDTH-MEM_ADDR_WIDTH];
    assign mem_rd_en = snapshot_rd_en_ff[0] &  (state == S_ACC_MEM);
    assign mem_wr_en = snapshot_wr_en_ff[0] &  (state == S_ACC_MEM);
endmodule
`default_nettype wire