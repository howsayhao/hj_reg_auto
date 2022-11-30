module reg_native_if2mem (
    native_clk, native_rst_n, soft_rst,
    req_vld, ack_vld, err, addr, wr_en, rd_en, wr_data, rd_data, non_sec,
    // downstream memory interface
    mem_clk, mem_rst_n,
    mem_req_vld, mem_ack_vld, mem_err, mem_addr, mem_wr_en, mem_rd_en, mem_wr_data, mem_rd_data,
    // side band signal at native clock domain
    domain_is_non_secure,
    error_report_en
);
    parameter   CDC_ENABLE                  = 0;
    parameter   BUS_DATA_WIDTH              = 32;
    parameter   BUS_ADDR_WIDTH              = 64;
    parameter   MEM_DATA_WIDTH              = 64;
    parameter   MEM_ADDR_WIDTH              = 5;
    parameter   SECURE_ACCESS_CHECK         = 1;

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
    input   logic                           non_sec;

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

    input   logic                           domain_is_non_secure;
    input   logic                           error_report_en;

    logic                                   snapshot_mem_soft_rst;
    logic                                   snapshot_mem_req_vld;
    logic                                   snapshot_mem_ack_vld;
    logic                                   snapshot_mem_err;
    logic           [BUS_ADDR_WIDTH-1:0]    snapshot_mem_addr;
    logic                                   snapshot_mem_wr_en;
    logic                                   snapshot_mem_rd_en;
    logic           [BUS_DATA_WIDTH-1:0]    snapshot_mem_wr_data;
    logic           [BUS_DATA_WIDTH-1:0]    snapshot_mem_rd_data;

//**************************************ASYNC BRIDGE************************************************//
    reg_native_if_1to1 #(
        .CDC_ENABLE                 (CDC_ENABLE),
        .BUS_ADDR_WIDTH             (BUS_ADDR_WIDTH),
        .BUS_DATA_WIDTH             (BUS_DATA_WIDTH),
        .SECURE_ACCESS_CHECK        (SECURE_ACCESS_CHECK)
    )
    reg_native_if_1to1 (
        .native_clk                 (native_clk),
        .native_rst_n               (native_rst_n),
        .soft_rst                   (soft_rst),
        .req_vld                    (req_vld),
        .ack_vld                    (ack_vld),
        .err                        (err),
        .addr                       (addr),
        .wr_en                      (wr_en),
        .rd_en                      (rd_en),
        .wr_data                    (wr_data),
        .rd_data                    (rd_data),
        .non_sec                    (non_sec),
        .ext_clk                    (mem_clk),
        .ext_rst_n                  (mem_rst_n),
        .ext_soft_rst               (snapshot_mem_soft_rst),
        .ext_req_vld                (snapshot_mem_req_vld),
        .ext_ack_vld                (snapshot_mem_ack_vld),
        .ext_err                    (snapshot_mem_err),
        .ext_addr                   (snapshot_mem_addr),
        .ext_wr_en                  (snapshot_mem_wr_en),
        .ext_rd_en                  (snapshot_mem_rd_en),
        .ext_wr_data                (snapshot_mem_wr_data),
        .ext_rd_data                (snapshot_mem_rd_data),
        .ext_non_sec                (),
        .domain_is_non_secure       (domain_is_non_secure),
        .error_report_en            (error_report_en)
    );

//********************************MEMORY SNAPSHOT REGISTER******************************************//
    snapshot_mem #(
        .BUS_DATA_WIDTH (BUS_DATA_WIDTH), .BUS_ADDR_WIDTH (BUS_ADDR_WIDTH),
        .MEM_DATA_WIDTH (MEM_DATA_WIDTH), .MEM_ADDR_WIDTH (MEM_ADDR_WIDTH)
    )
    snapshot_mem (
        .clk                        (mem_clk),
        .rst_n                      (mem_rst_n),
        .soft_rst                   (snapshot_mem_soft_rst),
        .req_vld                    (snapshot_mem_req_vld),
        .ack_vld                    (snapshot_mem_ack_vld),
        .err                        (snapshot_mem_err),
        .addr                       (snapshot_mem_addr),
        .wr_en                      (snapshot_mem_wr_en),
        .rd_en                      (snapshot_mem_rd_en),
        .wr_data                    (snapshot_mem_wr_data),
        .rd_data                    (snapshot_mem_rd_data),
        .mem_req_vld                (mem_req_vld),
        .mem_ack_vld                (mem_ack_vld),
        .mem_err                    (mem_err),
        .mem_addr                   (mem_addr),
        .mem_wr_en                  (mem_wr_en),
        .mem_rd_en                  (mem_rd_en),
        .mem_wr_data                (mem_wr_data),
        .mem_rd_data                (mem_rd_data)
    );
//**************************************************************************************************//
endmodule