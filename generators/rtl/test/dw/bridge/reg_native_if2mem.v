module reg_native_if2mem (
    native_clk, native_rst_n, soft_rst,
    req_vld, ack_vld, err, addr, wr_en, rd_en, wr_data, rd_data,
    // downstream memory interface
    mem_clk, mem_rst_n,
    mem_req_vld, mem_ack_vld, mem_err, mem_addr, mem_wr_en, mem_rd_en, mem_wr_data, mem_rd_data
);
    parameter   CDC_ENABLE                  = 0;
    parameter   BUS_DATA_WIDTH              = 32;
    parameter   BUS_ADDR_WIDTH              = 64;
    parameter   MEM_DATA_WIDTH              = 64;
    parameter   MEM_ADDR_WIDTH              = 5;

    localparam  FORWARD_DELIVER_NUM         = MEM_ADDR_WIDTH + MEM_DATA_WIDTH + 3;
    localparam  BACKWARD_DELIVER_NUM        = MEM_DATA_WIDTH;

    input   logic                           native_clk;
    input   logic                           native_rst_n;
    input   logic                           soft_rst;
    input   logic                           req_vld;
    output  logic                           ack_vld;
    output  logic                           err;
    input   logic   [BUS_ADDR_WIDTH-1:0]    addr;
    input   logic                           wr_en;
    input   logic                           rd_en;
    input   logic   [BUS_DATA_WIDTH-1:0]    wr_data;
    output  logic   [BUS_DATA_WIDTH-1:0]    rd_data;

    input   logic                           mem_clk;
    input   logic                           mem_rst_n;
    output  logic                           mem_req_vld;
    input   logic                           mem_ack_vld;
    input   logic                           mem_err;
    output  logic   [MEM_ADDR_WIDTH-1:0]    mem_addr;
    output  logic                           mem_wr_en;
    output  logic                           mem_rd_en;
    output  logic   [MEM_DATA_WIDTH-1:0]    mem_wr_data;
    input   logic   [MEM_DATA_WIDTH-1:0]    mem_rd_data;

    logic                                   mem_req_vld_snapshot;
    logic                                   mem_ack_vld_snapshot;
    logic                                   mem_err_snapshot;
    logic           [MEM_ADDR_WIDTH-1:0]    mem_addr_snapshot;
    logic                                   mem_wr_en_snapshot;
    logic                                   mem_rd_en_snapshot;
    logic           [MEM_DATA_WIDTH-1:0]    mem_wr_data_snapshot;
    logic           [MEM_DATA_WIDTH-1:0]    mem_rd_data_snapshot;


//****************************************SNAPSHOT MEMORY******************************************//
    snapshot_mem #(
        .BUS_DATA_WIDTH(BUS_DATA_WIDTH), .BUS_ADDR_WIDTH(BUS_ADDR_WIDTH),
        .MEM_DATA_WIDTH(MEM_DATA_WIDTH), .MEM_ADDR_WIDTH(MEM_ADDR_WIDTH)
    )
    snapshot_mem (
        .clk(native_clk),
        .rst_n(native_rst_n),
        .soft_rst(soft_rst),
        .req_vld(req_vld),
        .ack_vld(ack_vld),
        .err(err),
        .addr(addr),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .wr_data(wr_data),
        .rd_data(rd_data),
        .mem_req_vld(mem_req_vld_snapshot),
        .mem_ack_vld(mem_ack_vld_snapshot),
        .mem_err(mem_err_snapshot),
        .mem_addr(mem_addr_snapshot),
        .mem_wr_en(mem_wr_en_snapshot),
        .mem_rd_en(mem_rd_en_snapshot),
        .mem_wr_data(mem_wr_data_snapshot),
        .mem_rd_data(mem_rd_data_snapshot)
    );
//**************************************************************************************************//

//**********************************CLOCK DOMAIN CROSSING*******************************************//
    generate
        if (CDC_ENABLE) begin: g_cdc
            logic                                   reg_native_if__mem__value_deliver_pulse_in;
            logic                                   reg_native_if__mem__value_deliver_pulse_out;
            logic   [FORWARD_DELIVER_NUM-1:0]       reg_native_if__mem__value_deliver_value_in;
            logic   [FORWARD_DELIVER_NUM-1:0]       reg_native_if__mem__value_deliver_value_out;
            logic   [BACKWARD_DELIVER_NUM-1:0]      mem__reg_native_if__pulse_deliver_pulse_in;
            logic   [BACKWARD_DELIVER_NUM-1:0]      mem__reg_native_if__pulse_deliver_pulse_out;
            logic                                   mem_req_vld_snapshot_ff;
            logic                                   mem_req_vld_snapshot_pulse;
            logic   [MEM_DATA_WIDTH-1:0]            mem_rd_data_ff;

            // forward cdc
            always_ff @(posedge native_clk or negedge native_rst_n) begin
                if (!native_rst_n || soft_rst)
                    mem_req_vld_snapshot_ff     <= 1'b0;
                else
                    mem_req_vld_snapshot_ff     <= mem_req_vld_snapshot;
            end
            assign  mem_req_vld_snapshot_pulse  = mem_req_vld_snapshot & ~mem_req_vld_snapshot_ff;

            assign  reg_native_if__mem__value_deliver_pulse_in  = mem_req_vld_snapshot_pulse;
            assign  reg_native_if__mem__value_deliver_value_in  = {
                    mem_req_vld_snapshot, mem_addr_snapshot, mem_wr_en_snapshot,
                    mem_rd_en_snapshot, mem_wr_data_snapshot
            };

            value_deliver #(
                .WIDTH(FORWARD_DELIVER_NUM)
            )
            reg_native_if__mem__value_deliver (
                .scan_enable                (1'b0),
                .clk_a                      (native_clk),
                .clk_b                      (mem_clk),
                .rst_a_n                    (native_rst_n),
                .rst_b_n                    (mem_rst_n),
                .pulse_in                   (reg_native_if__mem__value_deliver_pulse_in),
                .value_in                   (reg_native_if__mem__value_deliver_value_in),
                .pulse_out                  (reg_native_if__mem__value_deliver_pulse_out),
                .value_out                  (reg_native_if__mem__value_deliver_value_out)
            );
            always_ff @(posedge mem_clk or mem_rst_n) begin
                if (!mem_rst_n || mem_ack_vld)
                    {mem_req_vld, mem_addr, mem_wr_en, mem_rd_en, mem_wr_data}  <= {FORWARD_DELIVER_NUM{1'b0}};
                else if (reg_native_if__mem__value_deliver_pulse_out)
                    {mem_req_vld, mem_addr, mem_wr_en, mem_rd_en, mem_wr_data}  <= reg_native_if__mem__value_deliver_value_out;
            end

            // backward cdc
            assign  mem__reg_native_if__pulse_deliver_pulse_in  = {mem_ack_vld, mem_err, mem_rd_data};
            pulse_deliver #(
                .WIDTH(BACKWARD_DELIVER_NUM)
            )
            mem__reg_native_if__pulse_deliver (
                .scan_enable                (1'b0),
                .clk_a                      (mem_clk),
                .clk_b                      (native_clk),
                .rst_a_n                    (mem_rst_n),
                .rst_b_n                    (native_rst_n),
                .pulse_in                   (mem__reg_native_if__pulse_deliver_pulse_in),
                .pulse_out                  (mem__reg_native_if__pulse_deliver_pulse_out)
            );
            assign  {
                mem_ack_vld_snapshot,
                mem_err_snapshot,
                mem_rd_data_snapshot
            }   = mem__reg_native_if__pulse_deliver_pulse_out;

        end else begin: g_no_cdc
            assign  mem_req_vld             = mem_req_vld_snapshot;
            assign  mem_addr                = mem_addr_snapshot;
            assign  mem_wr_en               = mem_wr_en_snapshot;
            assign  mem_rd_en               = mem_rd_en_snapshot;
            assign  mem_wr_data             = mem_wr_data_snapshot;
            assign  mem_ack_vld_snapshot    = mem_ack_vld;
            assign  mem_err_snapshot        = mem_err;
            assign  mem_rd_data_snapshot    = mem_rd_data;
        end
    endgenerate

endmodule