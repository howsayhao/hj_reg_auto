module snapshot_reg (
    clk, rst_n, soft_rst,
    // upstream control signal from fsm
    snap_rd_en, snap_wr_en,
    snap_rd_data, snap_wr_data,
    // downstream control signal to registers
    reg_rd_en, reg_wr_en,
    reg_rd_data, reg_wr_data
);

    `include "common_funcs.vh"

    parameter   DATA_WIDTH                  = 32;
    parameter   REG_WIDTH                   = 64;
    parameter   PARTITION_CNT               = REG_WIDTH / DATA_WIDTH;
    parameter   RST_VALUE                   = {REG_WIDTH{1'b0}};

    localparam  BYTE_WIDTH                  = 8;
    localparam  RESERVERD_BITS              = log2(REG_WIDTH) - log2(BYTE_WIDTH);

    input   logic                           clk;
    input   logic                           rst_n;
    input   logic                           soft_rst;
    input   logic   [PARTITION_CNT-1:0]     snap_rd_en;
    input   logic   [PARTITION_CNT-1:0]     snap_wr_en;
    output  logic   [REG_WIDTH-1:0]         snap_rd_data;
    input   logic   [REG_WIDTH-1:0]         snap_wr_data;

    output  logic                           reg_rd_en;
    output  logic                           reg_wr_en;
    input   logic   [REG_WIDTH-1:0]         reg_rd_data;
    output  logic   [REG_WIDTH-1:0]         reg_wr_data;

    logic           [REG_WIDTH-1:0]         snapshot_ff;

    // snapshot register
    genvar  i;
    generate
        for (i = 0; i < PARTITION_CNT; i = i + 1)
            always @(posedge clk or negedge rst_n)
                if (!rst_n)
                    snapshot_ff[i * DATA_WIDTH +: DATA_WIDTH]   <= {DATA_WIDTH{1'b0}};
                else if (soft_rst)
                    snapshot_ff[i * DATA_WIDTH +: DATA_WIDTH]   <= {DATA_WIDTH{1'b0}};
                else if (snap_rd_en[0])
                    snapshot_ff[i * DATA_WIDTH +: DATA_WIDTH]   <= reg_rd_data[i * DATA_WIDTH +: DATA_WIDTH];
                else if (snap_wr_en[i])
                    snapshot_ff[i * DATA_WIDTH +: DATA_WIDTH]   <= snap_wr_data[i * DATA_WIDTH +: DATA_WIDTH];
                else
                    snapshot_ff[i * DATA_WIDTH +: DATA_WIDTH]   <= snapshot_ff[i * DATA_WIDTH +: DATA_WIDTH];
    endgenerate

    assign  snap_rd_data    = snap_rd_en[0] ? reg_rd_data : snapshot_ff;
    assign  reg_rd_en       = snap_rd_en[0];
    assign  reg_wr_en       = snap_wr_en[0];

    generate
        if (REG_WIDTH > DATA_WIDTH)
            assign  reg_wr_data = {snapshot_ff[REG_WIDTH-1:DATA_WIDTH], snap_wr_data[DATA_WIDTH-1:0]};
        else
            assign  reg_wr_data = snap_wr_data[REG_WIDTH-1:0];
    endgenerate
endmodule
