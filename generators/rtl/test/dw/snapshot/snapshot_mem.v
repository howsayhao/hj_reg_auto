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
    logic   [PARTITION_CNT-1:0]                 snap_rd_en;
    logic   [PARTITION_CNT-1:0]                 snap_wr_en;
    logic   [PARTITION_CNT-1:0]                 snap_wr_en_ff;
    logic   [PARTITION_CNT-1:0]                 snap_rd_en_ff;
    logic   [BUS_ADDR_WIDTH-1:0]                addr_ff;
    logic   [BUS_DATA_WIDTH-1:0]                wr_data_ff;
    logic   [MEM_DATA_WIDTH-1:0]                mem_rd_data_int;
    logic   [MEM_DATA_WIDTH-1:0]                snapshot_ff;
    logic                                       mem_access;

    logic                                       snap_rd_vld;
    logic                                       snap_wr_vld;
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
            req_vld_ff      <= 1'b0;
            wr_en_ff        <= 1'b0;
            rd_en_ff        <= 1'b0;
        end
        else if (req_vld & (wr_en | rd_en)) begin
            req_vld_ff      <= req_vld;
            wr_en_ff        <= wr_en;
            rd_en_ff        <= rd_en;
        end
        else if (ack_vld) begin
            req_vld_ff      <= 1'b0;
            wr_en_ff        <= 1'b0;
            rd_en_ff        <= 1'b0;
        end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n | soft_rst) begin
            snap_rd_en_ff       <= {PARTITION_CNT{1'b0}};
            snap_wr_en_ff       <= {PARTITION_CNT{1'b0}};
            addr_ff             <= {BUS_ADDR_WIDTH{1'b0}};
        end
        else if (req_vld & (wr_en | rd_en)) begin
            snap_rd_en_ff       <= snap_rd_en;
            snap_wr_en_ff       <= snap_wr_en;
            addr_ff             <= addr;
        end
        else if (state != S_IDLE && next_state == S_IDLE) begin
            snap_rd_en_ff       <= {PARTITION_CNT{1'b0}};
            snap_wr_en_ff       <= {PARTITION_CNT{1'b0}};
            addr_ff             <= {BUS_ADDR_WIDTH{1'b0}};
        end
    end

    genvar i;
    generate
        for (i = 0; i < PARTITION_CNT; i = i + 1) begin: g_operation_decoder
            assign snap_wr_en[i] = addr[RESERVERD_BITS-1:0] == i * (BUS_DATA_WIDTH / BYTE_WIDTH) ? wr_en : 1'b0;
            assign snap_rd_en[i] = addr[RESERVERD_BITS-1:0] == i * (BUS_DATA_WIDTH / BYTE_WIDTH) ? rd_en : 1'b0;
        end

        for (i = 0; i < PARTITION_CNT; i = i + 1) begin: g_snapshot_register
            always @(posedge clk or negedge rst_n) begin
                if (!rst_n)
                    snapshot_ff[i*BUS_DATA_WIDTH +: BUS_DATA_WIDTH] <= {BUS_DATA_WIDTH{1'b0}};
                else if (next_state == S_ACC_MEM & rd_en_ff)
                    snapshot_ff[i*BUS_DATA_WIDTH +: BUS_DATA_WIDTH] <= mem_rd_data[i*BUS_DATA_WIDTH +: BUS_DATA_WIDTH];
                else if (snap_wr_en[i])
                    snapshot_ff[i*BUS_DATA_WIDTH +: BUS_DATA_WIDTH] <= wr_data[0 +: BUS_DATA_WIDTH];
            end
        end

        if (MEM_DATA_WIDTH > BUS_DATA_WIDTH) begin: g_snapshot
            assign mem_wr_data = {snapshot_ff[MEM_DATA_WIDTH-1:BUS_DATA_WIDTH], wr_data_ff[BUS_DATA_WIDTH-1:0]};
        end
        else begin: g_no_snapshot
            assign mem_wr_data = wr_data_ff;
        end
    endgenerate

    one_hot_mux #(
        .WIDTH (BUS_DATA_WIDTH), .CNT (PARTITION_CNT)
    )
    x_mux_rd_data (
        .din (snapshot_ff),
        .sel (snap_rd_en_ff),
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

    // access to the lowest address location triggers a real memory access
    assign mem_access       = snap_rd_en[0] | snap_wr_en[0];

    // state transition logic
    always_comb begin
        if (soft_rst)
            next_state = S_IDLE;
        else begin
            case (state)
                S_IDLE:
                    if (req_vld & (wr_en | rd_en))
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
    // one cycle delay for locking data from reading memory
    assign snap_rd_vld      = snap_rd_en_ff[0] ? mem_ack_vld_ff : state[_S_ACC_SNAPSHOT_] & rd_en_ff;
    assign snap_wr_vld      = snap_wr_en_ff[0] ? mem_ack_vld_ff : state[_S_ACC_SNAPSHOT_] & wr_en_ff;
    assign ack_vld          = snap_rd_vld | snap_wr_vld;
    assign mem_req_vld      = state == S_ACC_MEM;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n | soft_rst)
            wr_data_ff  <= {BUS_DATA_WIDTH{1'b0}};
        else
            wr_data_ff  <= wr_data;
    end

    assign mem_addr  = (state == S_IDLE) ? addr[BUS_ADDR_WIDTH-1:BUS_ADDR_WIDTH-MEM_ADDR_WIDTH] : addr_ff[BUS_ADDR_WIDTH-1:BUS_ADDR_WIDTH-MEM_ADDR_WIDTH];
    assign mem_rd_en = snap_rd_en_ff[0] & ((state[_S_IDLE_] & next_state[_S_ACC_MEM_]) | state[_S_ACC_MEM_]);
    assign mem_wr_en = snap_wr_en_ff[0] & (state[_S_IDLE_] & next_state[_S_ACC_MEM_] | state[_S_ACC_MEM_]);
endmodule
`default_nettype wire