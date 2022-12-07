`include "field_attr.vh"
`default_nettype none

module regslv_slv_map (
    TEM__FIELD_0__curr_value,
    TEM__FIELD_0__pulse,
    TEM__FIELD_0__next_value,
    map_11_0_TEM21__FIELD_3__pulse,
    map_11_0_TEM21__FIELD_3__next_value,
    map_11_0_TEM21__FIELD_2__pulse,
    map_11_0_TEM21__FIELD_2__next_value,
    map_11_0_TEM21__FIELD_1__pulse,
    map_11_0_TEM21__FIELD_1__next_value,
    map_11_0_TEM22__FIELD_1__curr_value,
    map_11_1_TEM21__FIELD_3__pulse,
    map_11_1_TEM21__FIELD_3__next_value,
    map_11_1_TEM21__FIELD_2__pulse,
    map_11_1_TEM21__FIELD_2__next_value,
    map_11_1_TEM21__FIELD_1__pulse,
    map_11_1_TEM21__FIELD_1__next_value,
    map_11_1_TEM22__FIELD_1__curr_value,
    map_11_2_TEM21__FIELD_3__pulse,
    map_11_2_TEM21__FIELD_3__next_value,
    map_11_2_TEM21__FIELD_2__pulse,
    map_11_2_TEM21__FIELD_2__next_value,
    map_11_2_TEM21__FIELD_1__pulse,
    map_11_2_TEM21__FIELD_1__next_value,
    map_11_2_TEM22__FIELD_1__curr_value,
    map_11_3_TEM21__FIELD_3__pulse,
    map_11_3_TEM21__FIELD_3__next_value,
    map_11_3_TEM21__FIELD_2__pulse,
    map_11_3_TEM21__FIELD_2__next_value,
    map_11_3_TEM21__FIELD_1__pulse,
    map_11_3_TEM21__FIELD_1__next_value,
    map_11_3_TEM22__FIELD_1__curr_value,
    map_11_4_TEM21__FIELD_3__pulse,
    map_11_4_TEM21__FIELD_3__next_value,
    map_11_4_TEM21__FIELD_2__pulse,
    map_11_4_TEM21__FIELD_2__next_value,
    map_11_4_TEM21__FIELD_1__pulse,
    map_11_4_TEM21__FIELD_1__next_value,
    map_11_4_TEM22__FIELD_1__curr_value,
    map_12_0_TEM21__FIELD_3__pulse,
    map_12_0_TEM21__FIELD_3__next_value,
    map_12_0_TEM21__FIELD_2__pulse,
    map_12_0_TEM21__FIELD_2__next_value,
    map_12_0_TEM21__FIELD_1__pulse,
    map_12_0_TEM21__FIELD_1__next_value,
    map_12_0_TEM22__FIELD_1__curr_value,
    map_12_1_TEM21__FIELD_3__pulse,
    map_12_1_TEM21__FIELD_3__next_value,
    map_12_1_TEM21__FIELD_2__pulse,
    map_12_1_TEM21__FIELD_2__next_value,
    map_12_1_TEM21__FIELD_1__pulse,
    map_12_1_TEM21__FIELD_1__next_value,
    map_12_1_TEM22__FIELD_1__curr_value,
    map_12_2_TEM21__FIELD_3__pulse,
    map_12_2_TEM21__FIELD_3__next_value,
    map_12_2_TEM21__FIELD_2__pulse,
    map_12_2_TEM21__FIELD_2__next_value,
    map_12_2_TEM21__FIELD_1__pulse,
    map_12_2_TEM21__FIELD_1__next_value,
    map_12_2_TEM22__FIELD_1__curr_value,
    map_12_3_TEM21__FIELD_3__pulse,
    map_12_3_TEM21__FIELD_3__next_value,
    map_12_3_TEM21__FIELD_2__pulse,
    map_12_3_TEM21__FIELD_2__next_value,
    map_12_3_TEM21__FIELD_1__pulse,
    map_12_3_TEM21__FIELD_1__next_value,
    map_12_3_TEM22__FIELD_1__curr_value,
    map_12_4_TEM21__FIELD_3__pulse,
    map_12_4_TEM21__FIELD_3__next_value,
    map_12_4_TEM21__FIELD_2__pulse,
    map_12_4_TEM21__FIELD_2__next_value,
    map_12_4_TEM21__FIELD_1__pulse,
    map_12_4_TEM21__FIELD_1__next_value,
    map_12_4_TEM22__FIELD_1__curr_value,
    map_12_5_TEM21__FIELD_3__pulse,
    map_12_5_TEM21__FIELD_3__next_value,
    map_12_5_TEM21__FIELD_2__pulse,
    map_12_5_TEM21__FIELD_2__next_value,
    map_12_5_TEM21__FIELD_1__pulse,
    map_12_5_TEM21__FIELD_1__next_value,
    map_12_5_TEM22__FIELD_1__curr_value,
    map_12_6_TEM21__FIELD_3__pulse,
    map_12_6_TEM21__FIELD_3__next_value,
    map_12_6_TEM21__FIELD_2__pulse,
    map_12_6_TEM21__FIELD_2__next_value,
    map_12_6_TEM21__FIELD_1__pulse,
    map_12_6_TEM21__FIELD_1__next_value,
    map_12_6_TEM22__FIELD_1__curr_value,
    map_12_7_TEM21__FIELD_3__pulse,
    map_12_7_TEM21__FIELD_3__next_value,
    map_12_7_TEM21__FIELD_2__pulse,
    map_12_7_TEM21__FIELD_2__next_value,
    map_12_7_TEM21__FIELD_1__pulse,
    map_12_7_TEM21__FIELD_1__next_value,
    map_12_7_TEM22__FIELD_1__curr_value,
    map_12_8_TEM21__FIELD_3__pulse,
    map_12_8_TEM21__FIELD_3__next_value,
    map_12_8_TEM21__FIELD_2__pulse,
    map_12_8_TEM21__FIELD_2__next_value,
    map_12_8_TEM21__FIELD_1__pulse,
    map_12_8_TEM21__FIELD_1__next_value,
    map_12_8_TEM22__FIELD_1__curr_value,
    map_12_9_TEM21__FIELD_3__pulse,
    map_12_9_TEM21__FIELD_3__next_value,
    map_12_9_TEM21__FIELD_2__pulse,
    map_12_9_TEM21__FIELD_2__next_value,
    map_12_9_TEM21__FIELD_1__pulse,
    map_12_9_TEM21__FIELD_1__next_value,
    map_12_9_TEM22__FIELD_1__curr_value,
    clk,
    rst_n,
    soft_rst,
    req_vld,
    wr_en,
    rd_en,
    addr,
    wr_data,
    rd_data,
    non_sec,
    ack_vld,
    err,
    regslv_clk,
    regslv_rst_n,
    // indicate whether to report error when accessing undefined empty address space,
    // or non-secure access, at native clock domain (clk)
    error_report_en,
    // indicate whether this regslv is in secure space, at native clock domain (clk)
    domain_is_non_secure
);
    `include "common_funcs.vh"

    parameter       CDC_ENABLE                  = 1;
    parameter       SECURE_ACCESS_CHECK         = 1;
    parameter       ADDR_WIDTH                  = 48;
    parameter       DATA_WIDTH                  = 32;
    parameter       INSERT_REG_FF               = 1;
    parameter       REG_NUM                     = 61;


    parameter       TEM__FIELD_0__ARST_VALUE = 32'hffff;


    output  logic   [31:0]                      TEM__FIELD_0__curr_value;
    input   logic                               TEM__FIELD_0__pulse;
    input   logic   [31:0]                      TEM__FIELD_0__next_value;
    input   logic                               map_11_0_TEM21__FIELD_3__pulse;
    input   logic   [ 0:0]                      map_11_0_TEM21__FIELD_3__next_value;
    input   logic                               map_11_0_TEM21__FIELD_2__pulse;
    input   logic   [ 2:0]                      map_11_0_TEM21__FIELD_2__next_value;
    input   logic                               map_11_0_TEM21__FIELD_1__pulse;
    input   logic   [ 0:0]                      map_11_0_TEM21__FIELD_1__next_value;
    output  logic   [31:0]                      map_11_0_TEM22__FIELD_1__curr_value;
    input   logic                               map_11_1_TEM21__FIELD_3__pulse;
    input   logic   [ 0:0]                      map_11_1_TEM21__FIELD_3__next_value;
    input   logic                               map_11_1_TEM21__FIELD_2__pulse;
    input   logic   [ 2:0]                      map_11_1_TEM21__FIELD_2__next_value;
    input   logic                               map_11_1_TEM21__FIELD_1__pulse;
    input   logic   [ 0:0]                      map_11_1_TEM21__FIELD_1__next_value;
    output  logic   [31:0]                      map_11_1_TEM22__FIELD_1__curr_value;
    input   logic                               map_11_2_TEM21__FIELD_3__pulse;
    input   logic   [ 0:0]                      map_11_2_TEM21__FIELD_3__next_value;
    input   logic                               map_11_2_TEM21__FIELD_2__pulse;
    input   logic   [ 2:0]                      map_11_2_TEM21__FIELD_2__next_value;
    input   logic                               map_11_2_TEM21__FIELD_1__pulse;
    input   logic   [ 0:0]                      map_11_2_TEM21__FIELD_1__next_value;
    output  logic   [31:0]                      map_11_2_TEM22__FIELD_1__curr_value;
    input   logic                               map_11_3_TEM21__FIELD_3__pulse;
    input   logic   [ 0:0]                      map_11_3_TEM21__FIELD_3__next_value;
    input   logic                               map_11_3_TEM21__FIELD_2__pulse;
    input   logic   [ 2:0]                      map_11_3_TEM21__FIELD_2__next_value;
    input   logic                               map_11_3_TEM21__FIELD_1__pulse;
    input   logic   [ 0:0]                      map_11_3_TEM21__FIELD_1__next_value;
    output  logic   [31:0]                      map_11_3_TEM22__FIELD_1__curr_value;
    input   logic                               map_11_4_TEM21__FIELD_3__pulse;
    input   logic   [ 0:0]                      map_11_4_TEM21__FIELD_3__next_value;
    input   logic                               map_11_4_TEM21__FIELD_2__pulse;
    input   logic   [ 2:0]                      map_11_4_TEM21__FIELD_2__next_value;
    input   logic                               map_11_4_TEM21__FIELD_1__pulse;
    input   logic   [ 0:0]                      map_11_4_TEM21__FIELD_1__next_value;
    output  logic   [31:0]                      map_11_4_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_0_TEM21__FIELD_3__pulse;
    input   logic   [ 0:0]                      map_12_0_TEM21__FIELD_3__next_value;
    input   logic                               map_12_0_TEM21__FIELD_2__pulse;
    input   logic   [ 2:0]                      map_12_0_TEM21__FIELD_2__next_value;
    input   logic                               map_12_0_TEM21__FIELD_1__pulse;
    input   logic   [ 0:0]                      map_12_0_TEM21__FIELD_1__next_value;
    output  logic   [31:0]                      map_12_0_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_1_TEM21__FIELD_3__pulse;
    input   logic   [ 0:0]                      map_12_1_TEM21__FIELD_3__next_value;
    input   logic                               map_12_1_TEM21__FIELD_2__pulse;
    input   logic   [ 2:0]                      map_12_1_TEM21__FIELD_2__next_value;
    input   logic                               map_12_1_TEM21__FIELD_1__pulse;
    input   logic   [ 0:0]                      map_12_1_TEM21__FIELD_1__next_value;
    output  logic   [31:0]                      map_12_1_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_2_TEM21__FIELD_3__pulse;
    input   logic   [ 0:0]                      map_12_2_TEM21__FIELD_3__next_value;
    input   logic                               map_12_2_TEM21__FIELD_2__pulse;
    input   logic   [ 2:0]                      map_12_2_TEM21__FIELD_2__next_value;
    input   logic                               map_12_2_TEM21__FIELD_1__pulse;
    input   logic   [ 0:0]                      map_12_2_TEM21__FIELD_1__next_value;
    output  logic   [31:0]                      map_12_2_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_3_TEM21__FIELD_3__pulse;
    input   logic   [ 0:0]                      map_12_3_TEM21__FIELD_3__next_value;
    input   logic                               map_12_3_TEM21__FIELD_2__pulse;
    input   logic   [ 2:0]                      map_12_3_TEM21__FIELD_2__next_value;
    input   logic                               map_12_3_TEM21__FIELD_1__pulse;
    input   logic   [ 0:0]                      map_12_3_TEM21__FIELD_1__next_value;
    output  logic   [31:0]                      map_12_3_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_4_TEM21__FIELD_3__pulse;
    input   logic   [ 0:0]                      map_12_4_TEM21__FIELD_3__next_value;
    input   logic                               map_12_4_TEM21__FIELD_2__pulse;
    input   logic   [ 2:0]                      map_12_4_TEM21__FIELD_2__next_value;
    input   logic                               map_12_4_TEM21__FIELD_1__pulse;
    input   logic   [ 0:0]                      map_12_4_TEM21__FIELD_1__next_value;
    output  logic   [31:0]                      map_12_4_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_5_TEM21__FIELD_3__pulse;
    input   logic   [ 0:0]                      map_12_5_TEM21__FIELD_3__next_value;
    input   logic                               map_12_5_TEM21__FIELD_2__pulse;
    input   logic   [ 2:0]                      map_12_5_TEM21__FIELD_2__next_value;
    input   logic                               map_12_5_TEM21__FIELD_1__pulse;
    input   logic   [ 0:0]                      map_12_5_TEM21__FIELD_1__next_value;
    output  logic   [31:0]                      map_12_5_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_6_TEM21__FIELD_3__pulse;
    input   logic   [ 0:0]                      map_12_6_TEM21__FIELD_3__next_value;
    input   logic                               map_12_6_TEM21__FIELD_2__pulse;
    input   logic   [ 2:0]                      map_12_6_TEM21__FIELD_2__next_value;
    input   logic                               map_12_6_TEM21__FIELD_1__pulse;
    input   logic   [ 0:0]                      map_12_6_TEM21__FIELD_1__next_value;
    output  logic   [31:0]                      map_12_6_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_7_TEM21__FIELD_3__pulse;
    input   logic   [ 0:0]                      map_12_7_TEM21__FIELD_3__next_value;
    input   logic                               map_12_7_TEM21__FIELD_2__pulse;
    input   logic   [ 2:0]                      map_12_7_TEM21__FIELD_2__next_value;
    input   logic                               map_12_7_TEM21__FIELD_1__pulse;
    input   logic   [ 0:0]                      map_12_7_TEM21__FIELD_1__next_value;
    output  logic   [31:0]                      map_12_7_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_8_TEM21__FIELD_3__pulse;
    input   logic   [ 0:0]                      map_12_8_TEM21__FIELD_3__next_value;
    input   logic                               map_12_8_TEM21__FIELD_2__pulse;
    input   logic   [ 2:0]                      map_12_8_TEM21__FIELD_2__next_value;
    input   logic                               map_12_8_TEM21__FIELD_1__pulse;
    input   logic   [ 0:0]                      map_12_8_TEM21__FIELD_1__next_value;
    output  logic   [31:0]                      map_12_8_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_9_TEM21__FIELD_3__pulse;
    input   logic   [ 0:0]                      map_12_9_TEM21__FIELD_3__next_value;
    input   logic                               map_12_9_TEM21__FIELD_2__pulse;
    input   logic   [ 2:0]                      map_12_9_TEM21__FIELD_2__next_value;
    input   logic                               map_12_9_TEM21__FIELD_1__pulse;
    input   logic   [ 0:0]                      map_12_9_TEM21__FIELD_1__next_value;
    output  logic   [31:0]                      map_12_9_TEM22__FIELD_1__curr_value;
    input   logic                               clk;
    input   logic                               rst_n;
    input   logic                               req_vld;
    input   logic                               wr_en;
    input   logic                               rd_en;
    input   logic   [ADDR_WIDTH-1:0]            addr;
    input   logic   [DATA_WIDTH-1:0]            wr_data;
    input   logic                               soft_rst;
    output  logic   [DATA_WIDTH-1:0]            rd_data;
    input   logic                               non_sec;
    output  logic                               ack_vld;
    output  logic                               err;
    input   logic                               regslv_clk;
    input   logic                               regslv_rst_n;
    input   logic                               error_report_en;
    input   logic                               domain_is_non_secure;

    logic                                       req_vld_i0;
    logic                                       wr_en_i0;
    logic                                       rd_en_i0;
    logic   [ADDR_WIDTH-1:0]                    addr_i0;
    logic   [DATA_WIDTH-1:0]                    wr_data_i0;
    logic                                       soft_rst_i0;
    logic   [DATA_WIDTH-1:0]                    rd_data_i0;
    logic                                       ack_vld_i0;
    logic                                       err_i0;
    logic   [REG_NUM-1:0] [DATA_WIDTH-1:0]      reg_sw_rd_data;
    logic   [REG_NUM-1:0] [DATA_WIDTH-1:0]      reg_rd_data_mux_din;
    logic   [REG_NUM-1:0]                       reg_rd_data_mux_sel;
    logic   [DATA_WIDTH-1:0]                    reg_rd_data_mux_dout;
    logic                                       reg_rd_data_mux_dout_vld;
    logic                                       reg_rd_data_vld;
    logic   [DATA_WIDTH-1:0]                    reg_rd_data;

//************************************SECURE_ACCESS_CHECK*********************************************//
//***********************************CLOCK DOMAIN CROSSING********************************************//
    reg_native_if_1to1 #(
        .CDC_ENABLE                             (CDC_ENABLE),
        .BUS_ADDR_WIDTH                         (ADDR_WIDTH),
        .BUS_DATA_WIDTH                         (DATA_WIDTH),
        .SECURE_ACCESS_CHECK                    (SECURE_ACCESS_CHECK)
    )
    reg_native_if_1to1 (
        .native_clk                             (clk),
        .native_rst_n                           (rst_n),
        .soft_rst                               (soft_rst),
        .req_vld                                (req_vld),
        .ack_vld                                (ack_vld),
        .err                                    (err),
        .addr                                   (addr),
        .wr_en                                  (wr_en),
        .rd_en                                  (rd_en),
        .wr_data                                (wr_data),
        .rd_data                                (rd_data),
        .non_sec                                (non_sec),
        .ext_clk                                (regslv_clk),
        .ext_rst_n                              (regslv_rst_n),
        .ext_soft_rst                           (soft_rst_i0),
        .ext_req_vld                            (req_vld_i0),
        .ext_ack_vld                            (ack_vld_i0),
        .ext_err                                (err_i0),
        .ext_addr                               (addr_i0),
        .ext_wr_en                              (wr_en_i0),
        .ext_rd_en                              (rd_en_i0),
        .ext_wr_data                            (wr_data_i0),
        .ext_rd_data                            (rd_data_i0),
        .ext_non_sec                            (),
        .domain_is_non_secure                   (domain_is_non_secure),
        .error_report_en                        (error_report_en)
    );

//**************************************ADDRESS DECODER***********************************************//
    localparam  ADDR_TRUNC_BITS                 = log2(DATA_WIDTH / 8);
    localparam  ADDR_REM_BITS                   = ADDR_WIDTH - ADDR_TRUNC_BITS;

    logic   [REG_NUM-1:0]                       dec_reg_sel;
    logic                                       dec_dummy_sel;
    logic                                       reg_acc;
    logic                                       dummy_acc;
    logic   [REG_NUM-1:0]                       reg_sw_wr_sel;
    logic   [REG_NUM-1:0]                       reg_sw_rd_sel;
    logic   [DATA_WIDTH-1:0]                    reg_sw_wr_data;

    always_comb begin
        if (req_vld_i0 & ~soft_rst_i0) begin
            dec_reg_sel = {REG_NUM{1'b0}};
            dec_dummy_sel = 1'b0;

            unique case (addr_i0[ADDR_WIDTH-1:ADDR_TRUNC_BITS])
                (ADDR_REM_BITS'(64'h0 >> ADDR_TRUNC_BITS)): dec_reg_sel[0] = 1'b1;
                (ADDR_REM_BITS'(64'h20c >> ADDR_TRUNC_BITS)): dec_reg_sel[1] = 1'b1;
                (ADDR_REM_BITS'(64'h210 >> ADDR_TRUNC_BITS)): dec_reg_sel[2] = 1'b1;
                (ADDR_REM_BITS'(64'h30c >> ADDR_TRUNC_BITS)): dec_reg_sel[3] = 1'b1;
                (ADDR_REM_BITS'(64'h310 >> ADDR_TRUNC_BITS)): dec_reg_sel[4] = 1'b1;
                (ADDR_REM_BITS'(64'h320 >> ADDR_TRUNC_BITS)): dec_reg_sel[5] = 1'b1;
                (ADDR_REM_BITS'(64'h324 >> ADDR_TRUNC_BITS)): dec_reg_sel[6] = 1'b1;
                (ADDR_REM_BITS'(64'h420 >> ADDR_TRUNC_BITS)): dec_reg_sel[7] = 1'b1;
                (ADDR_REM_BITS'(64'h424 >> ADDR_TRUNC_BITS)): dec_reg_sel[8] = 1'b1;
                (ADDR_REM_BITS'(64'h434 >> ADDR_TRUNC_BITS)): dec_reg_sel[9] = 1'b1;
                (ADDR_REM_BITS'(64'h438 >> ADDR_TRUNC_BITS)): dec_reg_sel[10] = 1'b1;
                (ADDR_REM_BITS'(64'h534 >> ADDR_TRUNC_BITS)): dec_reg_sel[11] = 1'b1;
                (ADDR_REM_BITS'(64'h538 >> ADDR_TRUNC_BITS)): dec_reg_sel[12] = 1'b1;
                (ADDR_REM_BITS'(64'h548 >> ADDR_TRUNC_BITS)): dec_reg_sel[13] = 1'b1;
                (ADDR_REM_BITS'(64'h54c >> ADDR_TRUNC_BITS)): dec_reg_sel[14] = 1'b1;
                (ADDR_REM_BITS'(64'h648 >> ADDR_TRUNC_BITS)): dec_reg_sel[15] = 1'b1;
                (ADDR_REM_BITS'(64'h64c >> ADDR_TRUNC_BITS)): dec_reg_sel[16] = 1'b1;
                (ADDR_REM_BITS'(64'h65c >> ADDR_TRUNC_BITS)): dec_reg_sel[17] = 1'b1;
                (ADDR_REM_BITS'(64'h660 >> ADDR_TRUNC_BITS)): dec_reg_sel[18] = 1'b1;
                (ADDR_REM_BITS'(64'h75c >> ADDR_TRUNC_BITS)): dec_reg_sel[19] = 1'b1;
                (ADDR_REM_BITS'(64'h760 >> ADDR_TRUNC_BITS)): dec_reg_sel[20] = 1'b1;
                (ADDR_REM_BITS'(64'h80c >> ADDR_TRUNC_BITS)): dec_reg_sel[21] = 1'b1;
                (ADDR_REM_BITS'(64'h810 >> ADDR_TRUNC_BITS)): dec_reg_sel[22] = 1'b1;
                (ADDR_REM_BITS'(64'h90c >> ADDR_TRUNC_BITS)): dec_reg_sel[23] = 1'b1;
                (ADDR_REM_BITS'(64'h910 >> ADDR_TRUNC_BITS)): dec_reg_sel[24] = 1'b1;
                (ADDR_REM_BITS'(64'h920 >> ADDR_TRUNC_BITS)): dec_reg_sel[25] = 1'b1;
                (ADDR_REM_BITS'(64'h924 >> ADDR_TRUNC_BITS)): dec_reg_sel[26] = 1'b1;
                (ADDR_REM_BITS'(64'ha20 >> ADDR_TRUNC_BITS)): dec_reg_sel[27] = 1'b1;
                (ADDR_REM_BITS'(64'ha24 >> ADDR_TRUNC_BITS)): dec_reg_sel[28] = 1'b1;
                (ADDR_REM_BITS'(64'ha34 >> ADDR_TRUNC_BITS)): dec_reg_sel[29] = 1'b1;
                (ADDR_REM_BITS'(64'ha38 >> ADDR_TRUNC_BITS)): dec_reg_sel[30] = 1'b1;
                (ADDR_REM_BITS'(64'hb34 >> ADDR_TRUNC_BITS)): dec_reg_sel[31] = 1'b1;
                (ADDR_REM_BITS'(64'hb38 >> ADDR_TRUNC_BITS)): dec_reg_sel[32] = 1'b1;
                (ADDR_REM_BITS'(64'hb48 >> ADDR_TRUNC_BITS)): dec_reg_sel[33] = 1'b1;
                (ADDR_REM_BITS'(64'hb4c >> ADDR_TRUNC_BITS)): dec_reg_sel[34] = 1'b1;
                (ADDR_REM_BITS'(64'hc48 >> ADDR_TRUNC_BITS)): dec_reg_sel[35] = 1'b1;
                (ADDR_REM_BITS'(64'hc4c >> ADDR_TRUNC_BITS)): dec_reg_sel[36] = 1'b1;
                (ADDR_REM_BITS'(64'hc5c >> ADDR_TRUNC_BITS)): dec_reg_sel[37] = 1'b1;
                (ADDR_REM_BITS'(64'hc60 >> ADDR_TRUNC_BITS)): dec_reg_sel[38] = 1'b1;
                (ADDR_REM_BITS'(64'hd5c >> ADDR_TRUNC_BITS)): dec_reg_sel[39] = 1'b1;
                (ADDR_REM_BITS'(64'hd60 >> ADDR_TRUNC_BITS)): dec_reg_sel[40] = 1'b1;
                (ADDR_REM_BITS'(64'hd70 >> ADDR_TRUNC_BITS)): dec_reg_sel[41] = 1'b1;
                (ADDR_REM_BITS'(64'hd74 >> ADDR_TRUNC_BITS)): dec_reg_sel[42] = 1'b1;
                (ADDR_REM_BITS'(64'he70 >> ADDR_TRUNC_BITS)): dec_reg_sel[43] = 1'b1;
                (ADDR_REM_BITS'(64'he74 >> ADDR_TRUNC_BITS)): dec_reg_sel[44] = 1'b1;
                (ADDR_REM_BITS'(64'he84 >> ADDR_TRUNC_BITS)): dec_reg_sel[45] = 1'b1;
                (ADDR_REM_BITS'(64'he88 >> ADDR_TRUNC_BITS)): dec_reg_sel[46] = 1'b1;
                (ADDR_REM_BITS'(64'hf84 >> ADDR_TRUNC_BITS)): dec_reg_sel[47] = 1'b1;
                (ADDR_REM_BITS'(64'hf88 >> ADDR_TRUNC_BITS)): dec_reg_sel[48] = 1'b1;
                (ADDR_REM_BITS'(64'hf98 >> ADDR_TRUNC_BITS)): dec_reg_sel[49] = 1'b1;
                (ADDR_REM_BITS'(64'hf9c >> ADDR_TRUNC_BITS)): dec_reg_sel[50] = 1'b1;
                (ADDR_REM_BITS'(64'h1098 >> ADDR_TRUNC_BITS)): dec_reg_sel[51] = 1'b1;
                (ADDR_REM_BITS'(64'h109c >> ADDR_TRUNC_BITS)): dec_reg_sel[52] = 1'b1;
                (ADDR_REM_BITS'(64'h10ac >> ADDR_TRUNC_BITS)): dec_reg_sel[53] = 1'b1;
                (ADDR_REM_BITS'(64'h10b0 >> ADDR_TRUNC_BITS)): dec_reg_sel[54] = 1'b1;
                (ADDR_REM_BITS'(64'h11ac >> ADDR_TRUNC_BITS)): dec_reg_sel[55] = 1'b1;
                (ADDR_REM_BITS'(64'h11b0 >> ADDR_TRUNC_BITS)): dec_reg_sel[56] = 1'b1;
                (ADDR_REM_BITS'(64'h11c0 >> ADDR_TRUNC_BITS)): dec_reg_sel[57] = 1'b1;
                (ADDR_REM_BITS'(64'h11c4 >> ADDR_TRUNC_BITS)): dec_reg_sel[58] = 1'b1;
                (ADDR_REM_BITS'(64'h12c0 >> ADDR_TRUNC_BITS)): dec_reg_sel[59] = 1'b1;
                (ADDR_REM_BITS'(64'h12c4 >> ADDR_TRUNC_BITS)): dec_reg_sel[60] = 1'b1;
                default: dec_dummy_sel = 1'b1;
            endcase
        end
        else begin
            dec_reg_sel = {REG_NUM{1'b0}};
            dec_dummy_sel = 1'b0;
        end
    end

    generate
        if (INSERT_REG_FF) begin: g_reg_ff
            always_ff @(posedge regslv_clk or negedge regslv_rst_n) begin
                if (!regslv_rst_n) begin
                    reg_sw_wr_sel               <= {REG_NUM{1'b0}};
                    reg_sw_rd_sel               <= {REG_NUM{1'b0}};
                    reg_sw_wr_data              <= {DATA_WIDTH{1'b0}};
                    dummy_acc                   <= 1'b0;
                end
                else if (soft_rst_i0) begin
                    reg_sw_wr_sel               <= {REG_NUM{1'b0}};
                    reg_sw_rd_sel               <= {REG_NUM{1'b0}};
                    reg_sw_wr_data              <= {DATA_WIDTH{1'b0}};
                    dummy_acc                   <= 1'b0;
                end
                else begin
                    reg_sw_wr_sel               <= {REG_NUM{wr_en_i0}} & dec_reg_sel;
                    reg_sw_rd_sel               <= {REG_NUM{rd_en_i0}} & dec_reg_sel;
                    reg_sw_wr_data              <= wr_data_i0;
                    dummy_acc                   <= dec_dummy_sel;
                end
            end
        end
        else begin: g_no_reg_ff
            assign  reg_sw_wr_sel               = {REG_NUM{wr_en_i0}} & dec_reg_sel;
            assign  reg_sw_rd_sel               = {REG_NUM{rd_en_i0}} & dec_reg_sel;
            assign  reg_sw_wr_data              = wr_data_i0;
            assign  dummy_acc                   = dec_dummy_sel;
        end
    endgenerate

    assign  reg_acc                             = (|reg_sw_wr_sel) | (|reg_sw_rd_sel);

//*******************************************FSM******************************************************//
    slv_fsm #(
        .DATA_WIDTH (DATA_WIDTH)
    )
    slv_fsm (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .if_soft_rst                            (soft_rst_i0),
        .if_req_vld                             (req_vld_i0),
        .if_ack_vld                             (ack_vld_i0),
        .if_rd_data                             (rd_data_i0),
        .if_err                                 (err_i0),
        .if_wr_en                               (wr_en_i0),
        .if_rd_en                               (rd_en_i0),
        .dummy_acc                              (dummy_acc),
        .reg_acc                                (reg_acc),
        .reg_rd_data                            (reg_rd_data),
        .reg_rd_data_vld                        (reg_rd_data_vld)
    );

//***********************************FIELDS AND REGISTERS*********************************************//
    logic                                       TEM__sw_wr_en;
    logic                                       TEM__sw_rd_en;
    logic   [31:0]                              TEM__sw_wr_data;
    logic   [31:0]                              TEM__sw_rd_data;
    logic                                       map_11_0_TEM21__sw_wr_en;
    logic                                       map_11_0_TEM21__sw_rd_en;
    logic   [31:0]                              map_11_0_TEM21__sw_wr_data;
    logic   [31:0]                              map_11_0_TEM21__sw_rd_data;
    logic   [ 0:0]                              map_11_0_TEM21__FIELD_3__curr_value;
    logic   [ 2:0]                              map_11_0_TEM21__FIELD_2__curr_value;
    logic   [ 0:0]                              map_11_0_TEM21__FIELD_1__curr_value;
    logic                                       map_11_0_TEM22__sw_wr_en;
    logic                                       map_11_0_TEM22__sw_rd_en;
    logic   [31:0]                              map_11_0_TEM22__sw_wr_data;
    logic   [31:0]                              map_11_0_TEM22__sw_rd_data;
    logic                                       map_11_0_TEM21_alias__sw_wr_en;
    logic                                       map_11_0_TEM21_alias__sw_rd_en;
    logic   [31:0]                              map_11_0_TEM21_alias__sw_wr_data;
    logic   [31:0]                              map_11_0_TEM21_alias__sw_rd_data;
    logic                                       map_11_0_TEM22_alias__sw_wr_en;
    logic                                       map_11_0_TEM22_alias__sw_rd_en;
    logic   [31:0]                              map_11_0_TEM22_alias__sw_wr_data;
    logic   [31:0]                              map_11_0_TEM22_alias__sw_rd_data;
    logic                                       map_11_1_TEM21__sw_wr_en;
    logic                                       map_11_1_TEM21__sw_rd_en;
    logic   [31:0]                              map_11_1_TEM21__sw_wr_data;
    logic   [31:0]                              map_11_1_TEM21__sw_rd_data;
    logic   [ 0:0]                              map_11_1_TEM21__FIELD_3__curr_value;
    logic   [ 2:0]                              map_11_1_TEM21__FIELD_2__curr_value;
    logic   [ 0:0]                              map_11_1_TEM21__FIELD_1__curr_value;
    logic                                       map_11_1_TEM22__sw_wr_en;
    logic                                       map_11_1_TEM22__sw_rd_en;
    logic   [31:0]                              map_11_1_TEM22__sw_wr_data;
    logic   [31:0]                              map_11_1_TEM22__sw_rd_data;
    logic                                       map_11_1_TEM21_alias__sw_wr_en;
    logic                                       map_11_1_TEM21_alias__sw_rd_en;
    logic   [31:0]                              map_11_1_TEM21_alias__sw_wr_data;
    logic   [31:0]                              map_11_1_TEM21_alias__sw_rd_data;
    logic                                       map_11_1_TEM22_alias__sw_wr_en;
    logic                                       map_11_1_TEM22_alias__sw_rd_en;
    logic   [31:0]                              map_11_1_TEM22_alias__sw_wr_data;
    logic   [31:0]                              map_11_1_TEM22_alias__sw_rd_data;
    logic                                       map_11_2_TEM21__sw_wr_en;
    logic                                       map_11_2_TEM21__sw_rd_en;
    logic   [31:0]                              map_11_2_TEM21__sw_wr_data;
    logic   [31:0]                              map_11_2_TEM21__sw_rd_data;
    logic   [ 0:0]                              map_11_2_TEM21__FIELD_3__curr_value;
    logic   [ 2:0]                              map_11_2_TEM21__FIELD_2__curr_value;
    logic   [ 0:0]                              map_11_2_TEM21__FIELD_1__curr_value;
    logic                                       map_11_2_TEM22__sw_wr_en;
    logic                                       map_11_2_TEM22__sw_rd_en;
    logic   [31:0]                              map_11_2_TEM22__sw_wr_data;
    logic   [31:0]                              map_11_2_TEM22__sw_rd_data;
    logic                                       map_11_2_TEM21_alias__sw_wr_en;
    logic                                       map_11_2_TEM21_alias__sw_rd_en;
    logic   [31:0]                              map_11_2_TEM21_alias__sw_wr_data;
    logic   [31:0]                              map_11_2_TEM21_alias__sw_rd_data;
    logic                                       map_11_2_TEM22_alias__sw_wr_en;
    logic                                       map_11_2_TEM22_alias__sw_rd_en;
    logic   [31:0]                              map_11_2_TEM22_alias__sw_wr_data;
    logic   [31:0]                              map_11_2_TEM22_alias__sw_rd_data;
    logic                                       map_11_3_TEM21__sw_wr_en;
    logic                                       map_11_3_TEM21__sw_rd_en;
    logic   [31:0]                              map_11_3_TEM21__sw_wr_data;
    logic   [31:0]                              map_11_3_TEM21__sw_rd_data;
    logic   [ 0:0]                              map_11_3_TEM21__FIELD_3__curr_value;
    logic   [ 2:0]                              map_11_3_TEM21__FIELD_2__curr_value;
    logic   [ 0:0]                              map_11_3_TEM21__FIELD_1__curr_value;
    logic                                       map_11_3_TEM22__sw_wr_en;
    logic                                       map_11_3_TEM22__sw_rd_en;
    logic   [31:0]                              map_11_3_TEM22__sw_wr_data;
    logic   [31:0]                              map_11_3_TEM22__sw_rd_data;
    logic                                       map_11_3_TEM21_alias__sw_wr_en;
    logic                                       map_11_3_TEM21_alias__sw_rd_en;
    logic   [31:0]                              map_11_3_TEM21_alias__sw_wr_data;
    logic   [31:0]                              map_11_3_TEM21_alias__sw_rd_data;
    logic                                       map_11_3_TEM22_alias__sw_wr_en;
    logic                                       map_11_3_TEM22_alias__sw_rd_en;
    logic   [31:0]                              map_11_3_TEM22_alias__sw_wr_data;
    logic   [31:0]                              map_11_3_TEM22_alias__sw_rd_data;
    logic                                       map_11_4_TEM21__sw_wr_en;
    logic                                       map_11_4_TEM21__sw_rd_en;
    logic   [31:0]                              map_11_4_TEM21__sw_wr_data;
    logic   [31:0]                              map_11_4_TEM21__sw_rd_data;
    logic   [ 0:0]                              map_11_4_TEM21__FIELD_3__curr_value;
    logic   [ 2:0]                              map_11_4_TEM21__FIELD_2__curr_value;
    logic   [ 0:0]                              map_11_4_TEM21__FIELD_1__curr_value;
    logic                                       map_11_4_TEM22__sw_wr_en;
    logic                                       map_11_4_TEM22__sw_rd_en;
    logic   [31:0]                              map_11_4_TEM22__sw_wr_data;
    logic   [31:0]                              map_11_4_TEM22__sw_rd_data;
    logic                                       map_11_4_TEM21_alias__sw_wr_en;
    logic                                       map_11_4_TEM21_alias__sw_rd_en;
    logic   [31:0]                              map_11_4_TEM21_alias__sw_wr_data;
    logic   [31:0]                              map_11_4_TEM21_alias__sw_rd_data;
    logic                                       map_11_4_TEM22_alias__sw_wr_en;
    logic                                       map_11_4_TEM22_alias__sw_rd_en;
    logic   [31:0]                              map_11_4_TEM22_alias__sw_wr_data;
    logic   [31:0]                              map_11_4_TEM22_alias__sw_rd_data;
    logic                                       map_12_0_TEM21__sw_wr_en;
    logic                                       map_12_0_TEM21__sw_rd_en;
    logic   [31:0]                              map_12_0_TEM21__sw_wr_data;
    logic   [31:0]                              map_12_0_TEM21__sw_rd_data;
    logic   [ 0:0]                              map_12_0_TEM21__FIELD_3__curr_value;
    logic   [ 2:0]                              map_12_0_TEM21__FIELD_2__curr_value;
    logic   [ 0:0]                              map_12_0_TEM21__FIELD_1__curr_value;
    logic                                       map_12_0_TEM22__sw_wr_en;
    logic                                       map_12_0_TEM22__sw_rd_en;
    logic   [31:0]                              map_12_0_TEM22__sw_wr_data;
    logic   [31:0]                              map_12_0_TEM22__sw_rd_data;
    logic                                       map_12_0_TEM21_alias__sw_wr_en;
    logic                                       map_12_0_TEM21_alias__sw_rd_en;
    logic   [31:0]                              map_12_0_TEM21_alias__sw_wr_data;
    logic   [31:0]                              map_12_0_TEM21_alias__sw_rd_data;
    logic                                       map_12_0_TEM22_alias__sw_wr_en;
    logic                                       map_12_0_TEM22_alias__sw_rd_en;
    logic   [31:0]                              map_12_0_TEM22_alias__sw_wr_data;
    logic   [31:0]                              map_12_0_TEM22_alias__sw_rd_data;
    logic                                       map_12_1_TEM21__sw_wr_en;
    logic                                       map_12_1_TEM21__sw_rd_en;
    logic   [31:0]                              map_12_1_TEM21__sw_wr_data;
    logic   [31:0]                              map_12_1_TEM21__sw_rd_data;
    logic   [ 0:0]                              map_12_1_TEM21__FIELD_3__curr_value;
    logic   [ 2:0]                              map_12_1_TEM21__FIELD_2__curr_value;
    logic   [ 0:0]                              map_12_1_TEM21__FIELD_1__curr_value;
    logic                                       map_12_1_TEM22__sw_wr_en;
    logic                                       map_12_1_TEM22__sw_rd_en;
    logic   [31:0]                              map_12_1_TEM22__sw_wr_data;
    logic   [31:0]                              map_12_1_TEM22__sw_rd_data;
    logic                                       map_12_1_TEM21_alias__sw_wr_en;
    logic                                       map_12_1_TEM21_alias__sw_rd_en;
    logic   [31:0]                              map_12_1_TEM21_alias__sw_wr_data;
    logic   [31:0]                              map_12_1_TEM21_alias__sw_rd_data;
    logic                                       map_12_1_TEM22_alias__sw_wr_en;
    logic                                       map_12_1_TEM22_alias__sw_rd_en;
    logic   [31:0]                              map_12_1_TEM22_alias__sw_wr_data;
    logic   [31:0]                              map_12_1_TEM22_alias__sw_rd_data;
    logic                                       map_12_2_TEM21__sw_wr_en;
    logic                                       map_12_2_TEM21__sw_rd_en;
    logic   [31:0]                              map_12_2_TEM21__sw_wr_data;
    logic   [31:0]                              map_12_2_TEM21__sw_rd_data;
    logic   [ 0:0]                              map_12_2_TEM21__FIELD_3__curr_value;
    logic   [ 2:0]                              map_12_2_TEM21__FIELD_2__curr_value;
    logic   [ 0:0]                              map_12_2_TEM21__FIELD_1__curr_value;
    logic                                       map_12_2_TEM22__sw_wr_en;
    logic                                       map_12_2_TEM22__sw_rd_en;
    logic   [31:0]                              map_12_2_TEM22__sw_wr_data;
    logic   [31:0]                              map_12_2_TEM22__sw_rd_data;
    logic                                       map_12_2_TEM21_alias__sw_wr_en;
    logic                                       map_12_2_TEM21_alias__sw_rd_en;
    logic   [31:0]                              map_12_2_TEM21_alias__sw_wr_data;
    logic   [31:0]                              map_12_2_TEM21_alias__sw_rd_data;
    logic                                       map_12_2_TEM22_alias__sw_wr_en;
    logic                                       map_12_2_TEM22_alias__sw_rd_en;
    logic   [31:0]                              map_12_2_TEM22_alias__sw_wr_data;
    logic   [31:0]                              map_12_2_TEM22_alias__sw_rd_data;
    logic                                       map_12_3_TEM21__sw_wr_en;
    logic                                       map_12_3_TEM21__sw_rd_en;
    logic   [31:0]                              map_12_3_TEM21__sw_wr_data;
    logic   [31:0]                              map_12_3_TEM21__sw_rd_data;
    logic   [ 0:0]                              map_12_3_TEM21__FIELD_3__curr_value;
    logic   [ 2:0]                              map_12_3_TEM21__FIELD_2__curr_value;
    logic   [ 0:0]                              map_12_3_TEM21__FIELD_1__curr_value;
    logic                                       map_12_3_TEM22__sw_wr_en;
    logic                                       map_12_3_TEM22__sw_rd_en;
    logic   [31:0]                              map_12_3_TEM22__sw_wr_data;
    logic   [31:0]                              map_12_3_TEM22__sw_rd_data;
    logic                                       map_12_3_TEM21_alias__sw_wr_en;
    logic                                       map_12_3_TEM21_alias__sw_rd_en;
    logic   [31:0]                              map_12_3_TEM21_alias__sw_wr_data;
    logic   [31:0]                              map_12_3_TEM21_alias__sw_rd_data;
    logic                                       map_12_3_TEM22_alias__sw_wr_en;
    logic                                       map_12_3_TEM22_alias__sw_rd_en;
    logic   [31:0]                              map_12_3_TEM22_alias__sw_wr_data;
    logic   [31:0]                              map_12_3_TEM22_alias__sw_rd_data;
    logic                                       map_12_4_TEM21__sw_wr_en;
    logic                                       map_12_4_TEM21__sw_rd_en;
    logic   [31:0]                              map_12_4_TEM21__sw_wr_data;
    logic   [31:0]                              map_12_4_TEM21__sw_rd_data;
    logic   [ 0:0]                              map_12_4_TEM21__FIELD_3__curr_value;
    logic   [ 2:0]                              map_12_4_TEM21__FIELD_2__curr_value;
    logic   [ 0:0]                              map_12_4_TEM21__FIELD_1__curr_value;
    logic                                       map_12_4_TEM22__sw_wr_en;
    logic                                       map_12_4_TEM22__sw_rd_en;
    logic   [31:0]                              map_12_4_TEM22__sw_wr_data;
    logic   [31:0]                              map_12_4_TEM22__sw_rd_data;
    logic                                       map_12_4_TEM21_alias__sw_wr_en;
    logic                                       map_12_4_TEM21_alias__sw_rd_en;
    logic   [31:0]                              map_12_4_TEM21_alias__sw_wr_data;
    logic   [31:0]                              map_12_4_TEM21_alias__sw_rd_data;
    logic                                       map_12_4_TEM22_alias__sw_wr_en;
    logic                                       map_12_4_TEM22_alias__sw_rd_en;
    logic   [31:0]                              map_12_4_TEM22_alias__sw_wr_data;
    logic   [31:0]                              map_12_4_TEM22_alias__sw_rd_data;
    logic                                       map_12_5_TEM21__sw_wr_en;
    logic                                       map_12_5_TEM21__sw_rd_en;
    logic   [31:0]                              map_12_5_TEM21__sw_wr_data;
    logic   [31:0]                              map_12_5_TEM21__sw_rd_data;
    logic   [ 0:0]                              map_12_5_TEM21__FIELD_3__curr_value;
    logic   [ 2:0]                              map_12_5_TEM21__FIELD_2__curr_value;
    logic   [ 0:0]                              map_12_5_TEM21__FIELD_1__curr_value;
    logic                                       map_12_5_TEM22__sw_wr_en;
    logic                                       map_12_5_TEM22__sw_rd_en;
    logic   [31:0]                              map_12_5_TEM22__sw_wr_data;
    logic   [31:0]                              map_12_5_TEM22__sw_rd_data;
    logic                                       map_12_5_TEM21_alias__sw_wr_en;
    logic                                       map_12_5_TEM21_alias__sw_rd_en;
    logic   [31:0]                              map_12_5_TEM21_alias__sw_wr_data;
    logic   [31:0]                              map_12_5_TEM21_alias__sw_rd_data;
    logic                                       map_12_5_TEM22_alias__sw_wr_en;
    logic                                       map_12_5_TEM22_alias__sw_rd_en;
    logic   [31:0]                              map_12_5_TEM22_alias__sw_wr_data;
    logic   [31:0]                              map_12_5_TEM22_alias__sw_rd_data;
    logic                                       map_12_6_TEM21__sw_wr_en;
    logic                                       map_12_6_TEM21__sw_rd_en;
    logic   [31:0]                              map_12_6_TEM21__sw_wr_data;
    logic   [31:0]                              map_12_6_TEM21__sw_rd_data;
    logic   [ 0:0]                              map_12_6_TEM21__FIELD_3__curr_value;
    logic   [ 2:0]                              map_12_6_TEM21__FIELD_2__curr_value;
    logic   [ 0:0]                              map_12_6_TEM21__FIELD_1__curr_value;
    logic                                       map_12_6_TEM22__sw_wr_en;
    logic                                       map_12_6_TEM22__sw_rd_en;
    logic   [31:0]                              map_12_6_TEM22__sw_wr_data;
    logic   [31:0]                              map_12_6_TEM22__sw_rd_data;
    logic                                       map_12_6_TEM21_alias__sw_wr_en;
    logic                                       map_12_6_TEM21_alias__sw_rd_en;
    logic   [31:0]                              map_12_6_TEM21_alias__sw_wr_data;
    logic   [31:0]                              map_12_6_TEM21_alias__sw_rd_data;
    logic                                       map_12_6_TEM22_alias__sw_wr_en;
    logic                                       map_12_6_TEM22_alias__sw_rd_en;
    logic   [31:0]                              map_12_6_TEM22_alias__sw_wr_data;
    logic   [31:0]                              map_12_6_TEM22_alias__sw_rd_data;
    logic                                       map_12_7_TEM21__sw_wr_en;
    logic                                       map_12_7_TEM21__sw_rd_en;
    logic   [31:0]                              map_12_7_TEM21__sw_wr_data;
    logic   [31:0]                              map_12_7_TEM21__sw_rd_data;
    logic   [ 0:0]                              map_12_7_TEM21__FIELD_3__curr_value;
    logic   [ 2:0]                              map_12_7_TEM21__FIELD_2__curr_value;
    logic   [ 0:0]                              map_12_7_TEM21__FIELD_1__curr_value;
    logic                                       map_12_7_TEM22__sw_wr_en;
    logic                                       map_12_7_TEM22__sw_rd_en;
    logic   [31:0]                              map_12_7_TEM22__sw_wr_data;
    logic   [31:0]                              map_12_7_TEM22__sw_rd_data;
    logic                                       map_12_7_TEM21_alias__sw_wr_en;
    logic                                       map_12_7_TEM21_alias__sw_rd_en;
    logic   [31:0]                              map_12_7_TEM21_alias__sw_wr_data;
    logic   [31:0]                              map_12_7_TEM21_alias__sw_rd_data;
    logic                                       map_12_7_TEM22_alias__sw_wr_en;
    logic                                       map_12_7_TEM22_alias__sw_rd_en;
    logic   [31:0]                              map_12_7_TEM22_alias__sw_wr_data;
    logic   [31:0]                              map_12_7_TEM22_alias__sw_rd_data;
    logic                                       map_12_8_TEM21__sw_wr_en;
    logic                                       map_12_8_TEM21__sw_rd_en;
    logic   [31:0]                              map_12_8_TEM21__sw_wr_data;
    logic   [31:0]                              map_12_8_TEM21__sw_rd_data;
    logic   [ 0:0]                              map_12_8_TEM21__FIELD_3__curr_value;
    logic   [ 2:0]                              map_12_8_TEM21__FIELD_2__curr_value;
    logic   [ 0:0]                              map_12_8_TEM21__FIELD_1__curr_value;
    logic                                       map_12_8_TEM22__sw_wr_en;
    logic                                       map_12_8_TEM22__sw_rd_en;
    logic   [31:0]                              map_12_8_TEM22__sw_wr_data;
    logic   [31:0]                              map_12_8_TEM22__sw_rd_data;
    logic                                       map_12_8_TEM21_alias__sw_wr_en;
    logic                                       map_12_8_TEM21_alias__sw_rd_en;
    logic   [31:0]                              map_12_8_TEM21_alias__sw_wr_data;
    logic   [31:0]                              map_12_8_TEM21_alias__sw_rd_data;
    logic                                       map_12_8_TEM22_alias__sw_wr_en;
    logic                                       map_12_8_TEM22_alias__sw_rd_en;
    logic   [31:0]                              map_12_8_TEM22_alias__sw_wr_data;
    logic   [31:0]                              map_12_8_TEM22_alias__sw_rd_data;
    logic                                       map_12_9_TEM21__sw_wr_en;
    logic                                       map_12_9_TEM21__sw_rd_en;
    logic   [31:0]                              map_12_9_TEM21__sw_wr_data;
    logic   [31:0]                              map_12_9_TEM21__sw_rd_data;
    logic   [ 0:0]                              map_12_9_TEM21__FIELD_3__curr_value;
    logic   [ 2:0]                              map_12_9_TEM21__FIELD_2__curr_value;
    logic   [ 0:0]                              map_12_9_TEM21__FIELD_1__curr_value;
    logic                                       map_12_9_TEM22__sw_wr_en;
    logic                                       map_12_9_TEM22__sw_rd_en;
    logic   [31:0]                              map_12_9_TEM22__sw_wr_data;
    logic   [31:0]                              map_12_9_TEM22__sw_rd_data;
    logic                                       map_12_9_TEM21_alias__sw_wr_en;
    logic                                       map_12_9_TEM21_alias__sw_rd_en;
    logic   [31:0]                              map_12_9_TEM21_alias__sw_wr_data;
    logic   [31:0]                              map_12_9_TEM21_alias__sw_rd_data;
    logic                                       map_12_9_TEM22_alias__sw_wr_en;
    logic                                       map_12_9_TEM22_alias__sw_rd_en;
    logic   [31:0]                              map_12_9_TEM22_alias__sw_wr_data;
    logic   [31:0]                              map_12_9_TEM22_alias__sw_rd_data;

    assign  TEM__sw_wr_en      = reg_sw_wr_sel[0];
    assign  TEM__sw_rd_en      = reg_sw_rd_sel[0];
    assign  TEM__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[0]  = TEM__sw_rd_data;

    field #(
        .F_WIDTH                                (32),
        .ARST_VALUE                             (TEM__FIELD_0__ARST_VALUE),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__TEM__FIELD_0 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({TEM__sw_wr_data[31:0]}),
        .sw_rd                                  ({TEM__sw_rd_en}),
        .sw_wr                                  ({TEM__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (TEM__FIELD_0__next_value),
        .hw_pulse                               (TEM__FIELD_0__pulse),
        .field_value                            (TEM__FIELD_0__curr_value));

    always_comb begin
        TEM__sw_rd_data[31:0] =
            TEM__FIELD_0__pulse ?
            TEM__FIELD_0__next_value :
            TEM__FIELD_0__curr_value;
    end

    assign  map_11_0_TEM21__sw_wr_en      = reg_sw_wr_sel[1];
    assign  map_11_0_TEM21__sw_rd_en      = reg_sw_rd_sel[1];
    assign  map_11_0_TEM21__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[1]  = map_11_0_TEM21__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_0_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_0_TEM21__sw_wr_data[13:13], map_11_0_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_11_0_TEM21__sw_rd_en, map_11_0_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_0_TEM21__sw_wr_en, map_11_0_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_0_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_11_0_TEM21__FIELD_3__pulse),
        .field_value                            (map_11_0_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_0_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_0_TEM21__sw_wr_data[16:14], map_11_0_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_11_0_TEM21__sw_rd_en, map_11_0_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_0_TEM21__sw_wr_en, map_11_0_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_0_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_11_0_TEM21__FIELD_2__pulse),
        .field_value                            (map_11_0_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_0_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_0_TEM21__sw_wr_data[17:17], map_11_0_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_11_0_TEM21__sw_rd_en, map_11_0_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_0_TEM21__sw_wr_en, map_11_0_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_0_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_11_0_TEM21__FIELD_1__pulse),
        .field_value                            (map_11_0_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_11_0_TEM21__sw_rd_data = 32'h0;
        map_11_0_TEM21__sw_rd_data[13:13] =
            map_11_0_TEM21__FIELD_3__pulse ?
            map_11_0_TEM21__FIELD_3__next_value :
            map_11_0_TEM21__FIELD_3__curr_value;
        map_11_0_TEM21__sw_rd_data[16:14] =
            map_11_0_TEM21__FIELD_2__pulse ?
            map_11_0_TEM21__FIELD_2__next_value :
            map_11_0_TEM21__FIELD_2__curr_value;
        map_11_0_TEM21__sw_rd_data[17:17] =
            map_11_0_TEM21__FIELD_1__pulse ?
            map_11_0_TEM21__FIELD_1__next_value :
            map_11_0_TEM21__FIELD_1__curr_value;
    end

    assign  map_11_0_TEM22__sw_wr_en      = reg_sw_wr_sel[2];
    assign  map_11_0_TEM22__sw_rd_en      = reg_sw_rd_sel[2];
    assign  map_11_0_TEM22__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[2]  = map_11_0_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (32),
        .ARST_VALUE                             (32'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_0_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_0_TEM22__sw_wr_data[31:0], map_11_0_TEM22_alias__sw_wr_data[31:0]}),
        .sw_rd                                  ({map_11_0_TEM22__sw_rd_en, map_11_0_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_0_TEM22__sw_wr_en, map_11_0_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (32'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (map_11_0_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_11_0_TEM22__sw_rd_data[31:0] = map_11_0_TEM22__FIELD_1__curr_value;
    end

    assign  map_11_0_TEM21_alias__sw_wr_en      = reg_sw_wr_sel[3];
    assign  map_11_0_TEM21_alias__sw_rd_en      = reg_sw_rd_sel[3];
    assign  map_11_0_TEM21_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[3]  = map_11_0_TEM21_alias__sw_rd_data;

    always_comb begin
        map_11_0_TEM21_alias__sw_rd_data = 32'h0;
        map_11_0_TEM21_alias__sw_rd_data[13:13] =
            map_11_0_TEM21__FIELD_3__pulse ?
            map_11_0_TEM21__FIELD_3__next_value :
            map_11_0_TEM21__FIELD_3__curr_value;
        map_11_0_TEM21_alias__sw_rd_data[16:14] =
            map_11_0_TEM21__FIELD_2__pulse ?
            map_11_0_TEM21__FIELD_2__next_value :
            map_11_0_TEM21__FIELD_2__curr_value;
        map_11_0_TEM21_alias__sw_rd_data[17:17] =
            map_11_0_TEM21__FIELD_1__pulse ?
            map_11_0_TEM21__FIELD_1__next_value :
            map_11_0_TEM21__FIELD_1__curr_value;
    end

    assign  map_11_0_TEM22_alias__sw_wr_en      = reg_sw_wr_sel[4];
    assign  map_11_0_TEM22_alias__sw_rd_en      = reg_sw_rd_sel[4];
    assign  map_11_0_TEM22_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[4]  = map_11_0_TEM22_alias__sw_rd_data;

    always_comb begin
        map_11_0_TEM22_alias__sw_rd_data[31:0] = map_11_0_TEM22__FIELD_1__curr_value;
    end

    assign  map_11_1_TEM21__sw_wr_en      = reg_sw_wr_sel[5];
    assign  map_11_1_TEM21__sw_rd_en      = reg_sw_rd_sel[5];
    assign  map_11_1_TEM21__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[5]  = map_11_1_TEM21__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_1_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_1_TEM21__sw_wr_data[13:13], map_11_1_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_11_1_TEM21__sw_rd_en, map_11_1_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_1_TEM21__sw_wr_en, map_11_1_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_1_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_11_1_TEM21__FIELD_3__pulse),
        .field_value                            (map_11_1_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_1_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_1_TEM21__sw_wr_data[16:14], map_11_1_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_11_1_TEM21__sw_rd_en, map_11_1_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_1_TEM21__sw_wr_en, map_11_1_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_1_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_11_1_TEM21__FIELD_2__pulse),
        .field_value                            (map_11_1_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_1_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_1_TEM21__sw_wr_data[17:17], map_11_1_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_11_1_TEM21__sw_rd_en, map_11_1_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_1_TEM21__sw_wr_en, map_11_1_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_1_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_11_1_TEM21__FIELD_1__pulse),
        .field_value                            (map_11_1_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_11_1_TEM21__sw_rd_data = 32'h0;
        map_11_1_TEM21__sw_rd_data[13:13] =
            map_11_1_TEM21__FIELD_3__pulse ?
            map_11_1_TEM21__FIELD_3__next_value :
            map_11_1_TEM21__FIELD_3__curr_value;
        map_11_1_TEM21__sw_rd_data[16:14] =
            map_11_1_TEM21__FIELD_2__pulse ?
            map_11_1_TEM21__FIELD_2__next_value :
            map_11_1_TEM21__FIELD_2__curr_value;
        map_11_1_TEM21__sw_rd_data[17:17] =
            map_11_1_TEM21__FIELD_1__pulse ?
            map_11_1_TEM21__FIELD_1__next_value :
            map_11_1_TEM21__FIELD_1__curr_value;
    end

    assign  map_11_1_TEM22__sw_wr_en      = reg_sw_wr_sel[6];
    assign  map_11_1_TEM22__sw_rd_en      = reg_sw_rd_sel[6];
    assign  map_11_1_TEM22__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[6]  = map_11_1_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (32),
        .ARST_VALUE                             (32'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_1_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_1_TEM22__sw_wr_data[31:0], map_11_1_TEM22_alias__sw_wr_data[31:0]}),
        .sw_rd                                  ({map_11_1_TEM22__sw_rd_en, map_11_1_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_1_TEM22__sw_wr_en, map_11_1_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (32'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (map_11_1_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_11_1_TEM22__sw_rd_data[31:0] = map_11_1_TEM22__FIELD_1__curr_value;
    end

    assign  map_11_1_TEM21_alias__sw_wr_en      = reg_sw_wr_sel[7];
    assign  map_11_1_TEM21_alias__sw_rd_en      = reg_sw_rd_sel[7];
    assign  map_11_1_TEM21_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[7]  = map_11_1_TEM21_alias__sw_rd_data;

    always_comb begin
        map_11_1_TEM21_alias__sw_rd_data = 32'h0;
        map_11_1_TEM21_alias__sw_rd_data[13:13] =
            map_11_1_TEM21__FIELD_3__pulse ?
            map_11_1_TEM21__FIELD_3__next_value :
            map_11_1_TEM21__FIELD_3__curr_value;
        map_11_1_TEM21_alias__sw_rd_data[16:14] =
            map_11_1_TEM21__FIELD_2__pulse ?
            map_11_1_TEM21__FIELD_2__next_value :
            map_11_1_TEM21__FIELD_2__curr_value;
        map_11_1_TEM21_alias__sw_rd_data[17:17] =
            map_11_1_TEM21__FIELD_1__pulse ?
            map_11_1_TEM21__FIELD_1__next_value :
            map_11_1_TEM21__FIELD_1__curr_value;
    end

    assign  map_11_1_TEM22_alias__sw_wr_en      = reg_sw_wr_sel[8];
    assign  map_11_1_TEM22_alias__sw_rd_en      = reg_sw_rd_sel[8];
    assign  map_11_1_TEM22_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[8]  = map_11_1_TEM22_alias__sw_rd_data;

    always_comb begin
        map_11_1_TEM22_alias__sw_rd_data[31:0] = map_11_1_TEM22__FIELD_1__curr_value;
    end

    assign  map_11_2_TEM21__sw_wr_en      = reg_sw_wr_sel[9];
    assign  map_11_2_TEM21__sw_rd_en      = reg_sw_rd_sel[9];
    assign  map_11_2_TEM21__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[9]  = map_11_2_TEM21__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_2_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_2_TEM21__sw_wr_data[13:13], map_11_2_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_11_2_TEM21__sw_rd_en, map_11_2_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_2_TEM21__sw_wr_en, map_11_2_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_2_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_11_2_TEM21__FIELD_3__pulse),
        .field_value                            (map_11_2_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_2_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_2_TEM21__sw_wr_data[16:14], map_11_2_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_11_2_TEM21__sw_rd_en, map_11_2_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_2_TEM21__sw_wr_en, map_11_2_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_2_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_11_2_TEM21__FIELD_2__pulse),
        .field_value                            (map_11_2_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_2_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_2_TEM21__sw_wr_data[17:17], map_11_2_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_11_2_TEM21__sw_rd_en, map_11_2_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_2_TEM21__sw_wr_en, map_11_2_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_2_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_11_2_TEM21__FIELD_1__pulse),
        .field_value                            (map_11_2_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_11_2_TEM21__sw_rd_data = 32'h0;
        map_11_2_TEM21__sw_rd_data[13:13] =
            map_11_2_TEM21__FIELD_3__pulse ?
            map_11_2_TEM21__FIELD_3__next_value :
            map_11_2_TEM21__FIELD_3__curr_value;
        map_11_2_TEM21__sw_rd_data[16:14] =
            map_11_2_TEM21__FIELD_2__pulse ?
            map_11_2_TEM21__FIELD_2__next_value :
            map_11_2_TEM21__FIELD_2__curr_value;
        map_11_2_TEM21__sw_rd_data[17:17] =
            map_11_2_TEM21__FIELD_1__pulse ?
            map_11_2_TEM21__FIELD_1__next_value :
            map_11_2_TEM21__FIELD_1__curr_value;
    end

    assign  map_11_2_TEM22__sw_wr_en      = reg_sw_wr_sel[10];
    assign  map_11_2_TEM22__sw_rd_en      = reg_sw_rd_sel[10];
    assign  map_11_2_TEM22__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[10]  = map_11_2_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (32),
        .ARST_VALUE                             (32'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_2_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_2_TEM22__sw_wr_data[31:0], map_11_2_TEM22_alias__sw_wr_data[31:0]}),
        .sw_rd                                  ({map_11_2_TEM22__sw_rd_en, map_11_2_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_2_TEM22__sw_wr_en, map_11_2_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (32'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (map_11_2_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_11_2_TEM22__sw_rd_data[31:0] = map_11_2_TEM22__FIELD_1__curr_value;
    end

    assign  map_11_2_TEM21_alias__sw_wr_en      = reg_sw_wr_sel[11];
    assign  map_11_2_TEM21_alias__sw_rd_en      = reg_sw_rd_sel[11];
    assign  map_11_2_TEM21_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[11]  = map_11_2_TEM21_alias__sw_rd_data;

    always_comb begin
        map_11_2_TEM21_alias__sw_rd_data = 32'h0;
        map_11_2_TEM21_alias__sw_rd_data[13:13] =
            map_11_2_TEM21__FIELD_3__pulse ?
            map_11_2_TEM21__FIELD_3__next_value :
            map_11_2_TEM21__FIELD_3__curr_value;
        map_11_2_TEM21_alias__sw_rd_data[16:14] =
            map_11_2_TEM21__FIELD_2__pulse ?
            map_11_2_TEM21__FIELD_2__next_value :
            map_11_2_TEM21__FIELD_2__curr_value;
        map_11_2_TEM21_alias__sw_rd_data[17:17] =
            map_11_2_TEM21__FIELD_1__pulse ?
            map_11_2_TEM21__FIELD_1__next_value :
            map_11_2_TEM21__FIELD_1__curr_value;
    end

    assign  map_11_2_TEM22_alias__sw_wr_en      = reg_sw_wr_sel[12];
    assign  map_11_2_TEM22_alias__sw_rd_en      = reg_sw_rd_sel[12];
    assign  map_11_2_TEM22_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[12]  = map_11_2_TEM22_alias__sw_rd_data;

    always_comb begin
        map_11_2_TEM22_alias__sw_rd_data[31:0] = map_11_2_TEM22__FIELD_1__curr_value;
    end

    assign  map_11_3_TEM21__sw_wr_en      = reg_sw_wr_sel[13];
    assign  map_11_3_TEM21__sw_rd_en      = reg_sw_rd_sel[13];
    assign  map_11_3_TEM21__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[13]  = map_11_3_TEM21__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_3_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_3_TEM21__sw_wr_data[13:13], map_11_3_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_11_3_TEM21__sw_rd_en, map_11_3_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_3_TEM21__sw_wr_en, map_11_3_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_3_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_11_3_TEM21__FIELD_3__pulse),
        .field_value                            (map_11_3_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_3_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_3_TEM21__sw_wr_data[16:14], map_11_3_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_11_3_TEM21__sw_rd_en, map_11_3_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_3_TEM21__sw_wr_en, map_11_3_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_3_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_11_3_TEM21__FIELD_2__pulse),
        .field_value                            (map_11_3_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_3_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_3_TEM21__sw_wr_data[17:17], map_11_3_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_11_3_TEM21__sw_rd_en, map_11_3_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_3_TEM21__sw_wr_en, map_11_3_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_3_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_11_3_TEM21__FIELD_1__pulse),
        .field_value                            (map_11_3_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_11_3_TEM21__sw_rd_data = 32'h0;
        map_11_3_TEM21__sw_rd_data[13:13] =
            map_11_3_TEM21__FIELD_3__pulse ?
            map_11_3_TEM21__FIELD_3__next_value :
            map_11_3_TEM21__FIELD_3__curr_value;
        map_11_3_TEM21__sw_rd_data[16:14] =
            map_11_3_TEM21__FIELD_2__pulse ?
            map_11_3_TEM21__FIELD_2__next_value :
            map_11_3_TEM21__FIELD_2__curr_value;
        map_11_3_TEM21__sw_rd_data[17:17] =
            map_11_3_TEM21__FIELD_1__pulse ?
            map_11_3_TEM21__FIELD_1__next_value :
            map_11_3_TEM21__FIELD_1__curr_value;
    end

    assign  map_11_3_TEM22__sw_wr_en      = reg_sw_wr_sel[14];
    assign  map_11_3_TEM22__sw_rd_en      = reg_sw_rd_sel[14];
    assign  map_11_3_TEM22__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[14]  = map_11_3_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (32),
        .ARST_VALUE                             (32'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_3_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_3_TEM22__sw_wr_data[31:0], map_11_3_TEM22_alias__sw_wr_data[31:0]}),
        .sw_rd                                  ({map_11_3_TEM22__sw_rd_en, map_11_3_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_3_TEM22__sw_wr_en, map_11_3_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (32'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (map_11_3_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_11_3_TEM22__sw_rd_data[31:0] = map_11_3_TEM22__FIELD_1__curr_value;
    end

    assign  map_11_3_TEM21_alias__sw_wr_en      = reg_sw_wr_sel[15];
    assign  map_11_3_TEM21_alias__sw_rd_en      = reg_sw_rd_sel[15];
    assign  map_11_3_TEM21_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[15]  = map_11_3_TEM21_alias__sw_rd_data;

    always_comb begin
        map_11_3_TEM21_alias__sw_rd_data = 32'h0;
        map_11_3_TEM21_alias__sw_rd_data[13:13] =
            map_11_3_TEM21__FIELD_3__pulse ?
            map_11_3_TEM21__FIELD_3__next_value :
            map_11_3_TEM21__FIELD_3__curr_value;
        map_11_3_TEM21_alias__sw_rd_data[16:14] =
            map_11_3_TEM21__FIELD_2__pulse ?
            map_11_3_TEM21__FIELD_2__next_value :
            map_11_3_TEM21__FIELD_2__curr_value;
        map_11_3_TEM21_alias__sw_rd_data[17:17] =
            map_11_3_TEM21__FIELD_1__pulse ?
            map_11_3_TEM21__FIELD_1__next_value :
            map_11_3_TEM21__FIELD_1__curr_value;
    end

    assign  map_11_3_TEM22_alias__sw_wr_en      = reg_sw_wr_sel[16];
    assign  map_11_3_TEM22_alias__sw_rd_en      = reg_sw_rd_sel[16];
    assign  map_11_3_TEM22_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[16]  = map_11_3_TEM22_alias__sw_rd_data;

    always_comb begin
        map_11_3_TEM22_alias__sw_rd_data[31:0] = map_11_3_TEM22__FIELD_1__curr_value;
    end

    assign  map_11_4_TEM21__sw_wr_en      = reg_sw_wr_sel[17];
    assign  map_11_4_TEM21__sw_rd_en      = reg_sw_rd_sel[17];
    assign  map_11_4_TEM21__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[17]  = map_11_4_TEM21__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_4_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_4_TEM21__sw_wr_data[13:13], map_11_4_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_11_4_TEM21__sw_rd_en, map_11_4_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_4_TEM21__sw_wr_en, map_11_4_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_4_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_11_4_TEM21__FIELD_3__pulse),
        .field_value                            (map_11_4_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_4_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_4_TEM21__sw_wr_data[16:14], map_11_4_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_11_4_TEM21__sw_rd_en, map_11_4_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_4_TEM21__sw_wr_en, map_11_4_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_4_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_11_4_TEM21__FIELD_2__pulse),
        .field_value                            (map_11_4_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_4_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_4_TEM21__sw_wr_data[17:17], map_11_4_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_11_4_TEM21__sw_rd_en, map_11_4_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_4_TEM21__sw_wr_en, map_11_4_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_4_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_11_4_TEM21__FIELD_1__pulse),
        .field_value                            (map_11_4_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_11_4_TEM21__sw_rd_data = 32'h0;
        map_11_4_TEM21__sw_rd_data[13:13] =
            map_11_4_TEM21__FIELD_3__pulse ?
            map_11_4_TEM21__FIELD_3__next_value :
            map_11_4_TEM21__FIELD_3__curr_value;
        map_11_4_TEM21__sw_rd_data[16:14] =
            map_11_4_TEM21__FIELD_2__pulse ?
            map_11_4_TEM21__FIELD_2__next_value :
            map_11_4_TEM21__FIELD_2__curr_value;
        map_11_4_TEM21__sw_rd_data[17:17] =
            map_11_4_TEM21__FIELD_1__pulse ?
            map_11_4_TEM21__FIELD_1__next_value :
            map_11_4_TEM21__FIELD_1__curr_value;
    end

    assign  map_11_4_TEM22__sw_wr_en      = reg_sw_wr_sel[18];
    assign  map_11_4_TEM22__sw_rd_en      = reg_sw_rd_sel[18];
    assign  map_11_4_TEM22__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[18]  = map_11_4_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (32),
        .ARST_VALUE                             (32'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_11_4_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_4_TEM22__sw_wr_data[31:0], map_11_4_TEM22_alias__sw_wr_data[31:0]}),
        .sw_rd                                  ({map_11_4_TEM22__sw_rd_en, map_11_4_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_4_TEM22__sw_wr_en, map_11_4_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (32'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (map_11_4_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_11_4_TEM22__sw_rd_data[31:0] = map_11_4_TEM22__FIELD_1__curr_value;
    end

    assign  map_11_4_TEM21_alias__sw_wr_en      = reg_sw_wr_sel[19];
    assign  map_11_4_TEM21_alias__sw_rd_en      = reg_sw_rd_sel[19];
    assign  map_11_4_TEM21_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[19]  = map_11_4_TEM21_alias__sw_rd_data;

    always_comb begin
        map_11_4_TEM21_alias__sw_rd_data = 32'h0;
        map_11_4_TEM21_alias__sw_rd_data[13:13] =
            map_11_4_TEM21__FIELD_3__pulse ?
            map_11_4_TEM21__FIELD_3__next_value :
            map_11_4_TEM21__FIELD_3__curr_value;
        map_11_4_TEM21_alias__sw_rd_data[16:14] =
            map_11_4_TEM21__FIELD_2__pulse ?
            map_11_4_TEM21__FIELD_2__next_value :
            map_11_4_TEM21__FIELD_2__curr_value;
        map_11_4_TEM21_alias__sw_rd_data[17:17] =
            map_11_4_TEM21__FIELD_1__pulse ?
            map_11_4_TEM21__FIELD_1__next_value :
            map_11_4_TEM21__FIELD_1__curr_value;
    end

    assign  map_11_4_TEM22_alias__sw_wr_en      = reg_sw_wr_sel[20];
    assign  map_11_4_TEM22_alias__sw_rd_en      = reg_sw_rd_sel[20];
    assign  map_11_4_TEM22_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[20]  = map_11_4_TEM22_alias__sw_rd_data;

    always_comb begin
        map_11_4_TEM22_alias__sw_rd_data[31:0] = map_11_4_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_0_TEM21__sw_wr_en      = reg_sw_wr_sel[21];
    assign  map_12_0_TEM21__sw_rd_en      = reg_sw_rd_sel[21];
    assign  map_12_0_TEM21__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[21]  = map_12_0_TEM21__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_0_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_0_TEM21__sw_wr_data[13:13], map_12_0_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_0_TEM21__sw_rd_en, map_12_0_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_0_TEM21__sw_wr_en, map_12_0_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_0_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_0_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_0_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_0_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_0_TEM21__sw_wr_data[16:14], map_12_0_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_0_TEM21__sw_rd_en, map_12_0_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_0_TEM21__sw_wr_en, map_12_0_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_0_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_0_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_0_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_0_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_0_TEM21__sw_wr_data[17:17], map_12_0_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_0_TEM21__sw_rd_en, map_12_0_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_0_TEM21__sw_wr_en, map_12_0_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_0_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_0_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_0_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_0_TEM21__sw_rd_data = 32'h0;
        map_12_0_TEM21__sw_rd_data[13:13] =
            map_12_0_TEM21__FIELD_3__pulse ?
            map_12_0_TEM21__FIELD_3__next_value :
            map_12_0_TEM21__FIELD_3__curr_value;
        map_12_0_TEM21__sw_rd_data[16:14] =
            map_12_0_TEM21__FIELD_2__pulse ?
            map_12_0_TEM21__FIELD_2__next_value :
            map_12_0_TEM21__FIELD_2__curr_value;
        map_12_0_TEM21__sw_rd_data[17:17] =
            map_12_0_TEM21__FIELD_1__pulse ?
            map_12_0_TEM21__FIELD_1__next_value :
            map_12_0_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_0_TEM22__sw_wr_en      = reg_sw_wr_sel[22];
    assign  map_12_0_TEM22__sw_rd_en      = reg_sw_rd_sel[22];
    assign  map_12_0_TEM22__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[22]  = map_12_0_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (32),
        .ARST_VALUE                             (32'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_0_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_0_TEM22__sw_wr_data[31:0], map_12_0_TEM22_alias__sw_wr_data[31:0]}),
        .sw_rd                                  ({map_12_0_TEM22__sw_rd_en, map_12_0_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_0_TEM22__sw_wr_en, map_12_0_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (32'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (map_12_0_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_0_TEM22__sw_rd_data[31:0] = map_12_0_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_0_TEM21_alias__sw_wr_en      = reg_sw_wr_sel[23];
    assign  map_12_0_TEM21_alias__sw_rd_en      = reg_sw_rd_sel[23];
    assign  map_12_0_TEM21_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[23]  = map_12_0_TEM21_alias__sw_rd_data;

    always_comb begin
        map_12_0_TEM21_alias__sw_rd_data = 32'h0;
        map_12_0_TEM21_alias__sw_rd_data[13:13] =
            map_12_0_TEM21__FIELD_3__pulse ?
            map_12_0_TEM21__FIELD_3__next_value :
            map_12_0_TEM21__FIELD_3__curr_value;
        map_12_0_TEM21_alias__sw_rd_data[16:14] =
            map_12_0_TEM21__FIELD_2__pulse ?
            map_12_0_TEM21__FIELD_2__next_value :
            map_12_0_TEM21__FIELD_2__curr_value;
        map_12_0_TEM21_alias__sw_rd_data[17:17] =
            map_12_0_TEM21__FIELD_1__pulse ?
            map_12_0_TEM21__FIELD_1__next_value :
            map_12_0_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_0_TEM22_alias__sw_wr_en      = reg_sw_wr_sel[24];
    assign  map_12_0_TEM22_alias__sw_rd_en      = reg_sw_rd_sel[24];
    assign  map_12_0_TEM22_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[24]  = map_12_0_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_0_TEM22_alias__sw_rd_data[31:0] = map_12_0_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_1_TEM21__sw_wr_en      = reg_sw_wr_sel[25];
    assign  map_12_1_TEM21__sw_rd_en      = reg_sw_rd_sel[25];
    assign  map_12_1_TEM21__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[25]  = map_12_1_TEM21__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_1_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_1_TEM21__sw_wr_data[13:13], map_12_1_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_1_TEM21__sw_rd_en, map_12_1_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_1_TEM21__sw_wr_en, map_12_1_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_1_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_1_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_1_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_1_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_1_TEM21__sw_wr_data[16:14], map_12_1_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_1_TEM21__sw_rd_en, map_12_1_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_1_TEM21__sw_wr_en, map_12_1_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_1_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_1_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_1_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_1_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_1_TEM21__sw_wr_data[17:17], map_12_1_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_1_TEM21__sw_rd_en, map_12_1_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_1_TEM21__sw_wr_en, map_12_1_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_1_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_1_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_1_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_1_TEM21__sw_rd_data = 32'h0;
        map_12_1_TEM21__sw_rd_data[13:13] =
            map_12_1_TEM21__FIELD_3__pulse ?
            map_12_1_TEM21__FIELD_3__next_value :
            map_12_1_TEM21__FIELD_3__curr_value;
        map_12_1_TEM21__sw_rd_data[16:14] =
            map_12_1_TEM21__FIELD_2__pulse ?
            map_12_1_TEM21__FIELD_2__next_value :
            map_12_1_TEM21__FIELD_2__curr_value;
        map_12_1_TEM21__sw_rd_data[17:17] =
            map_12_1_TEM21__FIELD_1__pulse ?
            map_12_1_TEM21__FIELD_1__next_value :
            map_12_1_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_1_TEM22__sw_wr_en      = reg_sw_wr_sel[26];
    assign  map_12_1_TEM22__sw_rd_en      = reg_sw_rd_sel[26];
    assign  map_12_1_TEM22__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[26]  = map_12_1_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (32),
        .ARST_VALUE                             (32'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_1_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_1_TEM22__sw_wr_data[31:0], map_12_1_TEM22_alias__sw_wr_data[31:0]}),
        .sw_rd                                  ({map_12_1_TEM22__sw_rd_en, map_12_1_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_1_TEM22__sw_wr_en, map_12_1_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (32'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (map_12_1_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_1_TEM22__sw_rd_data[31:0] = map_12_1_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_1_TEM21_alias__sw_wr_en      = reg_sw_wr_sel[27];
    assign  map_12_1_TEM21_alias__sw_rd_en      = reg_sw_rd_sel[27];
    assign  map_12_1_TEM21_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[27]  = map_12_1_TEM21_alias__sw_rd_data;

    always_comb begin
        map_12_1_TEM21_alias__sw_rd_data = 32'h0;
        map_12_1_TEM21_alias__sw_rd_data[13:13] =
            map_12_1_TEM21__FIELD_3__pulse ?
            map_12_1_TEM21__FIELD_3__next_value :
            map_12_1_TEM21__FIELD_3__curr_value;
        map_12_1_TEM21_alias__sw_rd_data[16:14] =
            map_12_1_TEM21__FIELD_2__pulse ?
            map_12_1_TEM21__FIELD_2__next_value :
            map_12_1_TEM21__FIELD_2__curr_value;
        map_12_1_TEM21_alias__sw_rd_data[17:17] =
            map_12_1_TEM21__FIELD_1__pulse ?
            map_12_1_TEM21__FIELD_1__next_value :
            map_12_1_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_1_TEM22_alias__sw_wr_en      = reg_sw_wr_sel[28];
    assign  map_12_1_TEM22_alias__sw_rd_en      = reg_sw_rd_sel[28];
    assign  map_12_1_TEM22_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[28]  = map_12_1_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_1_TEM22_alias__sw_rd_data[31:0] = map_12_1_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_2_TEM21__sw_wr_en      = reg_sw_wr_sel[29];
    assign  map_12_2_TEM21__sw_rd_en      = reg_sw_rd_sel[29];
    assign  map_12_2_TEM21__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[29]  = map_12_2_TEM21__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_2_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_2_TEM21__sw_wr_data[13:13], map_12_2_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_2_TEM21__sw_rd_en, map_12_2_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_2_TEM21__sw_wr_en, map_12_2_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_2_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_2_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_2_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_2_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_2_TEM21__sw_wr_data[16:14], map_12_2_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_2_TEM21__sw_rd_en, map_12_2_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_2_TEM21__sw_wr_en, map_12_2_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_2_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_2_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_2_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_2_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_2_TEM21__sw_wr_data[17:17], map_12_2_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_2_TEM21__sw_rd_en, map_12_2_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_2_TEM21__sw_wr_en, map_12_2_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_2_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_2_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_2_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_2_TEM21__sw_rd_data = 32'h0;
        map_12_2_TEM21__sw_rd_data[13:13] =
            map_12_2_TEM21__FIELD_3__pulse ?
            map_12_2_TEM21__FIELD_3__next_value :
            map_12_2_TEM21__FIELD_3__curr_value;
        map_12_2_TEM21__sw_rd_data[16:14] =
            map_12_2_TEM21__FIELD_2__pulse ?
            map_12_2_TEM21__FIELD_2__next_value :
            map_12_2_TEM21__FIELD_2__curr_value;
        map_12_2_TEM21__sw_rd_data[17:17] =
            map_12_2_TEM21__FIELD_1__pulse ?
            map_12_2_TEM21__FIELD_1__next_value :
            map_12_2_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_2_TEM22__sw_wr_en      = reg_sw_wr_sel[30];
    assign  map_12_2_TEM22__sw_rd_en      = reg_sw_rd_sel[30];
    assign  map_12_2_TEM22__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[30]  = map_12_2_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (32),
        .ARST_VALUE                             (32'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_2_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_2_TEM22__sw_wr_data[31:0], map_12_2_TEM22_alias__sw_wr_data[31:0]}),
        .sw_rd                                  ({map_12_2_TEM22__sw_rd_en, map_12_2_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_2_TEM22__sw_wr_en, map_12_2_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (32'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (map_12_2_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_2_TEM22__sw_rd_data[31:0] = map_12_2_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_2_TEM21_alias__sw_wr_en      = reg_sw_wr_sel[31];
    assign  map_12_2_TEM21_alias__sw_rd_en      = reg_sw_rd_sel[31];
    assign  map_12_2_TEM21_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[31]  = map_12_2_TEM21_alias__sw_rd_data;

    always_comb begin
        map_12_2_TEM21_alias__sw_rd_data = 32'h0;
        map_12_2_TEM21_alias__sw_rd_data[13:13] =
            map_12_2_TEM21__FIELD_3__pulse ?
            map_12_2_TEM21__FIELD_3__next_value :
            map_12_2_TEM21__FIELD_3__curr_value;
        map_12_2_TEM21_alias__sw_rd_data[16:14] =
            map_12_2_TEM21__FIELD_2__pulse ?
            map_12_2_TEM21__FIELD_2__next_value :
            map_12_2_TEM21__FIELD_2__curr_value;
        map_12_2_TEM21_alias__sw_rd_data[17:17] =
            map_12_2_TEM21__FIELD_1__pulse ?
            map_12_2_TEM21__FIELD_1__next_value :
            map_12_2_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_2_TEM22_alias__sw_wr_en      = reg_sw_wr_sel[32];
    assign  map_12_2_TEM22_alias__sw_rd_en      = reg_sw_rd_sel[32];
    assign  map_12_2_TEM22_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[32]  = map_12_2_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_2_TEM22_alias__sw_rd_data[31:0] = map_12_2_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_3_TEM21__sw_wr_en      = reg_sw_wr_sel[33];
    assign  map_12_3_TEM21__sw_rd_en      = reg_sw_rd_sel[33];
    assign  map_12_3_TEM21__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[33]  = map_12_3_TEM21__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_3_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_3_TEM21__sw_wr_data[13:13], map_12_3_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_3_TEM21__sw_rd_en, map_12_3_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_3_TEM21__sw_wr_en, map_12_3_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_3_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_3_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_3_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_3_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_3_TEM21__sw_wr_data[16:14], map_12_3_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_3_TEM21__sw_rd_en, map_12_3_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_3_TEM21__sw_wr_en, map_12_3_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_3_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_3_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_3_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_3_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_3_TEM21__sw_wr_data[17:17], map_12_3_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_3_TEM21__sw_rd_en, map_12_3_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_3_TEM21__sw_wr_en, map_12_3_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_3_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_3_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_3_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_3_TEM21__sw_rd_data = 32'h0;
        map_12_3_TEM21__sw_rd_data[13:13] =
            map_12_3_TEM21__FIELD_3__pulse ?
            map_12_3_TEM21__FIELD_3__next_value :
            map_12_3_TEM21__FIELD_3__curr_value;
        map_12_3_TEM21__sw_rd_data[16:14] =
            map_12_3_TEM21__FIELD_2__pulse ?
            map_12_3_TEM21__FIELD_2__next_value :
            map_12_3_TEM21__FIELD_2__curr_value;
        map_12_3_TEM21__sw_rd_data[17:17] =
            map_12_3_TEM21__FIELD_1__pulse ?
            map_12_3_TEM21__FIELD_1__next_value :
            map_12_3_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_3_TEM22__sw_wr_en      = reg_sw_wr_sel[34];
    assign  map_12_3_TEM22__sw_rd_en      = reg_sw_rd_sel[34];
    assign  map_12_3_TEM22__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[34]  = map_12_3_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (32),
        .ARST_VALUE                             (32'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_3_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_3_TEM22__sw_wr_data[31:0], map_12_3_TEM22_alias__sw_wr_data[31:0]}),
        .sw_rd                                  ({map_12_3_TEM22__sw_rd_en, map_12_3_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_3_TEM22__sw_wr_en, map_12_3_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (32'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (map_12_3_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_3_TEM22__sw_rd_data[31:0] = map_12_3_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_3_TEM21_alias__sw_wr_en      = reg_sw_wr_sel[35];
    assign  map_12_3_TEM21_alias__sw_rd_en      = reg_sw_rd_sel[35];
    assign  map_12_3_TEM21_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[35]  = map_12_3_TEM21_alias__sw_rd_data;

    always_comb begin
        map_12_3_TEM21_alias__sw_rd_data = 32'h0;
        map_12_3_TEM21_alias__sw_rd_data[13:13] =
            map_12_3_TEM21__FIELD_3__pulse ?
            map_12_3_TEM21__FIELD_3__next_value :
            map_12_3_TEM21__FIELD_3__curr_value;
        map_12_3_TEM21_alias__sw_rd_data[16:14] =
            map_12_3_TEM21__FIELD_2__pulse ?
            map_12_3_TEM21__FIELD_2__next_value :
            map_12_3_TEM21__FIELD_2__curr_value;
        map_12_3_TEM21_alias__sw_rd_data[17:17] =
            map_12_3_TEM21__FIELD_1__pulse ?
            map_12_3_TEM21__FIELD_1__next_value :
            map_12_3_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_3_TEM22_alias__sw_wr_en      = reg_sw_wr_sel[36];
    assign  map_12_3_TEM22_alias__sw_rd_en      = reg_sw_rd_sel[36];
    assign  map_12_3_TEM22_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[36]  = map_12_3_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_3_TEM22_alias__sw_rd_data[31:0] = map_12_3_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_4_TEM21__sw_wr_en      = reg_sw_wr_sel[37];
    assign  map_12_4_TEM21__sw_rd_en      = reg_sw_rd_sel[37];
    assign  map_12_4_TEM21__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[37]  = map_12_4_TEM21__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_4_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_4_TEM21__sw_wr_data[13:13], map_12_4_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_4_TEM21__sw_rd_en, map_12_4_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_4_TEM21__sw_wr_en, map_12_4_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_4_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_4_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_4_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_4_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_4_TEM21__sw_wr_data[16:14], map_12_4_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_4_TEM21__sw_rd_en, map_12_4_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_4_TEM21__sw_wr_en, map_12_4_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_4_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_4_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_4_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_4_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_4_TEM21__sw_wr_data[17:17], map_12_4_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_4_TEM21__sw_rd_en, map_12_4_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_4_TEM21__sw_wr_en, map_12_4_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_4_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_4_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_4_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_4_TEM21__sw_rd_data = 32'h0;
        map_12_4_TEM21__sw_rd_data[13:13] =
            map_12_4_TEM21__FIELD_3__pulse ?
            map_12_4_TEM21__FIELD_3__next_value :
            map_12_4_TEM21__FIELD_3__curr_value;
        map_12_4_TEM21__sw_rd_data[16:14] =
            map_12_4_TEM21__FIELD_2__pulse ?
            map_12_4_TEM21__FIELD_2__next_value :
            map_12_4_TEM21__FIELD_2__curr_value;
        map_12_4_TEM21__sw_rd_data[17:17] =
            map_12_4_TEM21__FIELD_1__pulse ?
            map_12_4_TEM21__FIELD_1__next_value :
            map_12_4_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_4_TEM22__sw_wr_en      = reg_sw_wr_sel[38];
    assign  map_12_4_TEM22__sw_rd_en      = reg_sw_rd_sel[38];
    assign  map_12_4_TEM22__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[38]  = map_12_4_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (32),
        .ARST_VALUE                             (32'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_4_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_4_TEM22__sw_wr_data[31:0], map_12_4_TEM22_alias__sw_wr_data[31:0]}),
        .sw_rd                                  ({map_12_4_TEM22__sw_rd_en, map_12_4_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_4_TEM22__sw_wr_en, map_12_4_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (32'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (map_12_4_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_4_TEM22__sw_rd_data[31:0] = map_12_4_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_4_TEM21_alias__sw_wr_en      = reg_sw_wr_sel[39];
    assign  map_12_4_TEM21_alias__sw_rd_en      = reg_sw_rd_sel[39];
    assign  map_12_4_TEM21_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[39]  = map_12_4_TEM21_alias__sw_rd_data;

    always_comb begin
        map_12_4_TEM21_alias__sw_rd_data = 32'h0;
        map_12_4_TEM21_alias__sw_rd_data[13:13] =
            map_12_4_TEM21__FIELD_3__pulse ?
            map_12_4_TEM21__FIELD_3__next_value :
            map_12_4_TEM21__FIELD_3__curr_value;
        map_12_4_TEM21_alias__sw_rd_data[16:14] =
            map_12_4_TEM21__FIELD_2__pulse ?
            map_12_4_TEM21__FIELD_2__next_value :
            map_12_4_TEM21__FIELD_2__curr_value;
        map_12_4_TEM21_alias__sw_rd_data[17:17] =
            map_12_4_TEM21__FIELD_1__pulse ?
            map_12_4_TEM21__FIELD_1__next_value :
            map_12_4_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_4_TEM22_alias__sw_wr_en      = reg_sw_wr_sel[40];
    assign  map_12_4_TEM22_alias__sw_rd_en      = reg_sw_rd_sel[40];
    assign  map_12_4_TEM22_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[40]  = map_12_4_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_4_TEM22_alias__sw_rd_data[31:0] = map_12_4_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_5_TEM21__sw_wr_en      = reg_sw_wr_sel[41];
    assign  map_12_5_TEM21__sw_rd_en      = reg_sw_rd_sel[41];
    assign  map_12_5_TEM21__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[41]  = map_12_5_TEM21__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_5_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_5_TEM21__sw_wr_data[13:13], map_12_5_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_5_TEM21__sw_rd_en, map_12_5_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_5_TEM21__sw_wr_en, map_12_5_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_5_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_5_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_5_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_5_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_5_TEM21__sw_wr_data[16:14], map_12_5_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_5_TEM21__sw_rd_en, map_12_5_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_5_TEM21__sw_wr_en, map_12_5_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_5_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_5_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_5_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_5_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_5_TEM21__sw_wr_data[17:17], map_12_5_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_5_TEM21__sw_rd_en, map_12_5_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_5_TEM21__sw_wr_en, map_12_5_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_5_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_5_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_5_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_5_TEM21__sw_rd_data = 32'h0;
        map_12_5_TEM21__sw_rd_data[13:13] =
            map_12_5_TEM21__FIELD_3__pulse ?
            map_12_5_TEM21__FIELD_3__next_value :
            map_12_5_TEM21__FIELD_3__curr_value;
        map_12_5_TEM21__sw_rd_data[16:14] =
            map_12_5_TEM21__FIELD_2__pulse ?
            map_12_5_TEM21__FIELD_2__next_value :
            map_12_5_TEM21__FIELD_2__curr_value;
        map_12_5_TEM21__sw_rd_data[17:17] =
            map_12_5_TEM21__FIELD_1__pulse ?
            map_12_5_TEM21__FIELD_1__next_value :
            map_12_5_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_5_TEM22__sw_wr_en      = reg_sw_wr_sel[42];
    assign  map_12_5_TEM22__sw_rd_en      = reg_sw_rd_sel[42];
    assign  map_12_5_TEM22__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[42]  = map_12_5_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (32),
        .ARST_VALUE                             (32'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_5_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_5_TEM22__sw_wr_data[31:0], map_12_5_TEM22_alias__sw_wr_data[31:0]}),
        .sw_rd                                  ({map_12_5_TEM22__sw_rd_en, map_12_5_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_5_TEM22__sw_wr_en, map_12_5_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (32'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (map_12_5_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_5_TEM22__sw_rd_data[31:0] = map_12_5_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_5_TEM21_alias__sw_wr_en      = reg_sw_wr_sel[43];
    assign  map_12_5_TEM21_alias__sw_rd_en      = reg_sw_rd_sel[43];
    assign  map_12_5_TEM21_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[43]  = map_12_5_TEM21_alias__sw_rd_data;

    always_comb begin
        map_12_5_TEM21_alias__sw_rd_data = 32'h0;
        map_12_5_TEM21_alias__sw_rd_data[13:13] =
            map_12_5_TEM21__FIELD_3__pulse ?
            map_12_5_TEM21__FIELD_3__next_value :
            map_12_5_TEM21__FIELD_3__curr_value;
        map_12_5_TEM21_alias__sw_rd_data[16:14] =
            map_12_5_TEM21__FIELD_2__pulse ?
            map_12_5_TEM21__FIELD_2__next_value :
            map_12_5_TEM21__FIELD_2__curr_value;
        map_12_5_TEM21_alias__sw_rd_data[17:17] =
            map_12_5_TEM21__FIELD_1__pulse ?
            map_12_5_TEM21__FIELD_1__next_value :
            map_12_5_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_5_TEM22_alias__sw_wr_en      = reg_sw_wr_sel[44];
    assign  map_12_5_TEM22_alias__sw_rd_en      = reg_sw_rd_sel[44];
    assign  map_12_5_TEM22_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[44]  = map_12_5_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_5_TEM22_alias__sw_rd_data[31:0] = map_12_5_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_6_TEM21__sw_wr_en      = reg_sw_wr_sel[45];
    assign  map_12_6_TEM21__sw_rd_en      = reg_sw_rd_sel[45];
    assign  map_12_6_TEM21__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[45]  = map_12_6_TEM21__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_6_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_6_TEM21__sw_wr_data[13:13], map_12_6_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_6_TEM21__sw_rd_en, map_12_6_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_6_TEM21__sw_wr_en, map_12_6_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_6_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_6_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_6_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_6_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_6_TEM21__sw_wr_data[16:14], map_12_6_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_6_TEM21__sw_rd_en, map_12_6_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_6_TEM21__sw_wr_en, map_12_6_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_6_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_6_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_6_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_6_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_6_TEM21__sw_wr_data[17:17], map_12_6_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_6_TEM21__sw_rd_en, map_12_6_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_6_TEM21__sw_wr_en, map_12_6_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_6_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_6_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_6_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_6_TEM21__sw_rd_data = 32'h0;
        map_12_6_TEM21__sw_rd_data[13:13] =
            map_12_6_TEM21__FIELD_3__pulse ?
            map_12_6_TEM21__FIELD_3__next_value :
            map_12_6_TEM21__FIELD_3__curr_value;
        map_12_6_TEM21__sw_rd_data[16:14] =
            map_12_6_TEM21__FIELD_2__pulse ?
            map_12_6_TEM21__FIELD_2__next_value :
            map_12_6_TEM21__FIELD_2__curr_value;
        map_12_6_TEM21__sw_rd_data[17:17] =
            map_12_6_TEM21__FIELD_1__pulse ?
            map_12_6_TEM21__FIELD_1__next_value :
            map_12_6_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_6_TEM22__sw_wr_en      = reg_sw_wr_sel[46];
    assign  map_12_6_TEM22__sw_rd_en      = reg_sw_rd_sel[46];
    assign  map_12_6_TEM22__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[46]  = map_12_6_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (32),
        .ARST_VALUE                             (32'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_6_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_6_TEM22__sw_wr_data[31:0], map_12_6_TEM22_alias__sw_wr_data[31:0]}),
        .sw_rd                                  ({map_12_6_TEM22__sw_rd_en, map_12_6_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_6_TEM22__sw_wr_en, map_12_6_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (32'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (map_12_6_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_6_TEM22__sw_rd_data[31:0] = map_12_6_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_6_TEM21_alias__sw_wr_en      = reg_sw_wr_sel[47];
    assign  map_12_6_TEM21_alias__sw_rd_en      = reg_sw_rd_sel[47];
    assign  map_12_6_TEM21_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[47]  = map_12_6_TEM21_alias__sw_rd_data;

    always_comb begin
        map_12_6_TEM21_alias__sw_rd_data = 32'h0;
        map_12_6_TEM21_alias__sw_rd_data[13:13] =
            map_12_6_TEM21__FIELD_3__pulse ?
            map_12_6_TEM21__FIELD_3__next_value :
            map_12_6_TEM21__FIELD_3__curr_value;
        map_12_6_TEM21_alias__sw_rd_data[16:14] =
            map_12_6_TEM21__FIELD_2__pulse ?
            map_12_6_TEM21__FIELD_2__next_value :
            map_12_6_TEM21__FIELD_2__curr_value;
        map_12_6_TEM21_alias__sw_rd_data[17:17] =
            map_12_6_TEM21__FIELD_1__pulse ?
            map_12_6_TEM21__FIELD_1__next_value :
            map_12_6_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_6_TEM22_alias__sw_wr_en      = reg_sw_wr_sel[48];
    assign  map_12_6_TEM22_alias__sw_rd_en      = reg_sw_rd_sel[48];
    assign  map_12_6_TEM22_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[48]  = map_12_6_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_6_TEM22_alias__sw_rd_data[31:0] = map_12_6_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_7_TEM21__sw_wr_en      = reg_sw_wr_sel[49];
    assign  map_12_7_TEM21__sw_rd_en      = reg_sw_rd_sel[49];
    assign  map_12_7_TEM21__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[49]  = map_12_7_TEM21__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_7_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_7_TEM21__sw_wr_data[13:13], map_12_7_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_7_TEM21__sw_rd_en, map_12_7_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_7_TEM21__sw_wr_en, map_12_7_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_7_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_7_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_7_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_7_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_7_TEM21__sw_wr_data[16:14], map_12_7_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_7_TEM21__sw_rd_en, map_12_7_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_7_TEM21__sw_wr_en, map_12_7_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_7_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_7_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_7_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_7_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_7_TEM21__sw_wr_data[17:17], map_12_7_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_7_TEM21__sw_rd_en, map_12_7_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_7_TEM21__sw_wr_en, map_12_7_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_7_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_7_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_7_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_7_TEM21__sw_rd_data = 32'h0;
        map_12_7_TEM21__sw_rd_data[13:13] =
            map_12_7_TEM21__FIELD_3__pulse ?
            map_12_7_TEM21__FIELD_3__next_value :
            map_12_7_TEM21__FIELD_3__curr_value;
        map_12_7_TEM21__sw_rd_data[16:14] =
            map_12_7_TEM21__FIELD_2__pulse ?
            map_12_7_TEM21__FIELD_2__next_value :
            map_12_7_TEM21__FIELD_2__curr_value;
        map_12_7_TEM21__sw_rd_data[17:17] =
            map_12_7_TEM21__FIELD_1__pulse ?
            map_12_7_TEM21__FIELD_1__next_value :
            map_12_7_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_7_TEM22__sw_wr_en      = reg_sw_wr_sel[50];
    assign  map_12_7_TEM22__sw_rd_en      = reg_sw_rd_sel[50];
    assign  map_12_7_TEM22__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[50]  = map_12_7_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (32),
        .ARST_VALUE                             (32'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_7_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_7_TEM22__sw_wr_data[31:0], map_12_7_TEM22_alias__sw_wr_data[31:0]}),
        .sw_rd                                  ({map_12_7_TEM22__sw_rd_en, map_12_7_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_7_TEM22__sw_wr_en, map_12_7_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (32'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (map_12_7_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_7_TEM22__sw_rd_data[31:0] = map_12_7_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_7_TEM21_alias__sw_wr_en      = reg_sw_wr_sel[51];
    assign  map_12_7_TEM21_alias__sw_rd_en      = reg_sw_rd_sel[51];
    assign  map_12_7_TEM21_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[51]  = map_12_7_TEM21_alias__sw_rd_data;

    always_comb begin
        map_12_7_TEM21_alias__sw_rd_data = 32'h0;
        map_12_7_TEM21_alias__sw_rd_data[13:13] =
            map_12_7_TEM21__FIELD_3__pulse ?
            map_12_7_TEM21__FIELD_3__next_value :
            map_12_7_TEM21__FIELD_3__curr_value;
        map_12_7_TEM21_alias__sw_rd_data[16:14] =
            map_12_7_TEM21__FIELD_2__pulse ?
            map_12_7_TEM21__FIELD_2__next_value :
            map_12_7_TEM21__FIELD_2__curr_value;
        map_12_7_TEM21_alias__sw_rd_data[17:17] =
            map_12_7_TEM21__FIELD_1__pulse ?
            map_12_7_TEM21__FIELD_1__next_value :
            map_12_7_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_7_TEM22_alias__sw_wr_en      = reg_sw_wr_sel[52];
    assign  map_12_7_TEM22_alias__sw_rd_en      = reg_sw_rd_sel[52];
    assign  map_12_7_TEM22_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[52]  = map_12_7_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_7_TEM22_alias__sw_rd_data[31:0] = map_12_7_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_8_TEM21__sw_wr_en      = reg_sw_wr_sel[53];
    assign  map_12_8_TEM21__sw_rd_en      = reg_sw_rd_sel[53];
    assign  map_12_8_TEM21__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[53]  = map_12_8_TEM21__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_8_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_8_TEM21__sw_wr_data[13:13], map_12_8_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_8_TEM21__sw_rd_en, map_12_8_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_8_TEM21__sw_wr_en, map_12_8_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_8_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_8_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_8_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_8_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_8_TEM21__sw_wr_data[16:14], map_12_8_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_8_TEM21__sw_rd_en, map_12_8_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_8_TEM21__sw_wr_en, map_12_8_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_8_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_8_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_8_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_8_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_8_TEM21__sw_wr_data[17:17], map_12_8_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_8_TEM21__sw_rd_en, map_12_8_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_8_TEM21__sw_wr_en, map_12_8_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_8_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_8_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_8_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_8_TEM21__sw_rd_data = 32'h0;
        map_12_8_TEM21__sw_rd_data[13:13] =
            map_12_8_TEM21__FIELD_3__pulse ?
            map_12_8_TEM21__FIELD_3__next_value :
            map_12_8_TEM21__FIELD_3__curr_value;
        map_12_8_TEM21__sw_rd_data[16:14] =
            map_12_8_TEM21__FIELD_2__pulse ?
            map_12_8_TEM21__FIELD_2__next_value :
            map_12_8_TEM21__FIELD_2__curr_value;
        map_12_8_TEM21__sw_rd_data[17:17] =
            map_12_8_TEM21__FIELD_1__pulse ?
            map_12_8_TEM21__FIELD_1__next_value :
            map_12_8_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_8_TEM22__sw_wr_en      = reg_sw_wr_sel[54];
    assign  map_12_8_TEM22__sw_rd_en      = reg_sw_rd_sel[54];
    assign  map_12_8_TEM22__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[54]  = map_12_8_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (32),
        .ARST_VALUE                             (32'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_8_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_8_TEM22__sw_wr_data[31:0], map_12_8_TEM22_alias__sw_wr_data[31:0]}),
        .sw_rd                                  ({map_12_8_TEM22__sw_rd_en, map_12_8_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_8_TEM22__sw_wr_en, map_12_8_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (32'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (map_12_8_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_8_TEM22__sw_rd_data[31:0] = map_12_8_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_8_TEM21_alias__sw_wr_en      = reg_sw_wr_sel[55];
    assign  map_12_8_TEM21_alias__sw_rd_en      = reg_sw_rd_sel[55];
    assign  map_12_8_TEM21_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[55]  = map_12_8_TEM21_alias__sw_rd_data;

    always_comb begin
        map_12_8_TEM21_alias__sw_rd_data = 32'h0;
        map_12_8_TEM21_alias__sw_rd_data[13:13] =
            map_12_8_TEM21__FIELD_3__pulse ?
            map_12_8_TEM21__FIELD_3__next_value :
            map_12_8_TEM21__FIELD_3__curr_value;
        map_12_8_TEM21_alias__sw_rd_data[16:14] =
            map_12_8_TEM21__FIELD_2__pulse ?
            map_12_8_TEM21__FIELD_2__next_value :
            map_12_8_TEM21__FIELD_2__curr_value;
        map_12_8_TEM21_alias__sw_rd_data[17:17] =
            map_12_8_TEM21__FIELD_1__pulse ?
            map_12_8_TEM21__FIELD_1__next_value :
            map_12_8_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_8_TEM22_alias__sw_wr_en      = reg_sw_wr_sel[56];
    assign  map_12_8_TEM22_alias__sw_rd_en      = reg_sw_rd_sel[56];
    assign  map_12_8_TEM22_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[56]  = map_12_8_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_8_TEM22_alias__sw_rd_data[31:0] = map_12_8_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_9_TEM21__sw_wr_en      = reg_sw_wr_sel[57];
    assign  map_12_9_TEM21__sw_rd_en      = reg_sw_rd_sel[57];
    assign  map_12_9_TEM21__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[57]  = map_12_9_TEM21__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_9_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_9_TEM21__sw_wr_data[13:13], map_12_9_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_9_TEM21__sw_rd_en, map_12_9_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_9_TEM21__sw_wr_en, map_12_9_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_9_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_9_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_9_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_9_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_9_TEM21__sw_wr_data[16:14], map_12_9_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_9_TEM21__sw_rd_en, map_12_9_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_9_TEM21__sw_wr_en, map_12_9_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_9_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_9_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_9_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_WO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_9_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_9_TEM21__sw_wr_data[17:17], map_12_9_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_9_TEM21__sw_rd_en, map_12_9_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_9_TEM21__sw_wr_en, map_12_9_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_9_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_9_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_9_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_9_TEM21__sw_rd_data = 32'h0;
        map_12_9_TEM21__sw_rd_data[13:13] =
            map_12_9_TEM21__FIELD_3__pulse ?
            map_12_9_TEM21__FIELD_3__next_value :
            map_12_9_TEM21__FIELD_3__curr_value;
        map_12_9_TEM21__sw_rd_data[16:14] =
            map_12_9_TEM21__FIELD_2__pulse ?
            map_12_9_TEM21__FIELD_2__next_value :
            map_12_9_TEM21__FIELD_2__curr_value;
        map_12_9_TEM21__sw_rd_data[17:17] =
            map_12_9_TEM21__FIELD_1__pulse ?
            map_12_9_TEM21__FIELD_1__next_value :
            map_12_9_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_9_TEM22__sw_wr_en      = reg_sw_wr_sel[58];
    assign  map_12_9_TEM22__sw_rd_en      = reg_sw_rd_sel[58];
    assign  map_12_9_TEM22__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[58]  = map_12_9_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (32),
        .ARST_VALUE                             (32'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RO),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__map_12_9_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_9_TEM22__sw_wr_data[31:0], map_12_9_TEM22_alias__sw_wr_data[31:0]}),
        .sw_rd                                  ({map_12_9_TEM22__sw_rd_en, map_12_9_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_9_TEM22__sw_wr_en, map_12_9_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (32'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (map_12_9_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_9_TEM22__sw_rd_data[31:0] = map_12_9_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_9_TEM21_alias__sw_wr_en      = reg_sw_wr_sel[59];
    assign  map_12_9_TEM21_alias__sw_rd_en      = reg_sw_rd_sel[59];
    assign  map_12_9_TEM21_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[59]  = map_12_9_TEM21_alias__sw_rd_data;

    always_comb begin
        map_12_9_TEM21_alias__sw_rd_data = 32'h0;
        map_12_9_TEM21_alias__sw_rd_data[13:13] =
            map_12_9_TEM21__FIELD_3__pulse ?
            map_12_9_TEM21__FIELD_3__next_value :
            map_12_9_TEM21__FIELD_3__curr_value;
        map_12_9_TEM21_alias__sw_rd_data[16:14] =
            map_12_9_TEM21__FIELD_2__pulse ?
            map_12_9_TEM21__FIELD_2__next_value :
            map_12_9_TEM21__FIELD_2__curr_value;
        map_12_9_TEM21_alias__sw_rd_data[17:17] =
            map_12_9_TEM21__FIELD_1__pulse ?
            map_12_9_TEM21__FIELD_1__next_value :
            map_12_9_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_9_TEM22_alias__sw_wr_en      = reg_sw_wr_sel[60];
    assign  map_12_9_TEM22_alias__sw_rd_en      = reg_sw_rd_sel[60];
    assign  map_12_9_TEM22_alias__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[60]  = map_12_9_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_9_TEM22_alias__sw_rd_data[31:0] = map_12_9_TEM22__FIELD_1__curr_value;
    end

//*************************************READ DATA MUX**************************************************//
    assign  reg_rd_data_mux_din                 = reg_sw_rd_data;
    assign  reg_rd_data_mux_sel                 = reg_sw_rd_sel;
    assign  reg_rd_data_vld                     = reg_rd_data_mux_dout_vld;
    assign  reg_rd_data                         = reg_rd_data_mux_dout;

    split_mux_2d #(
        .WIDTH                                  (DATA_WIDTH),
        .CNT                                    (REG_NUM),
        .GROUP_SIZE                             (128),
        .SKIP_DFF_0                             (1),
        .SKIP_DFF_1                             (1))
    reg_rd_data_mux (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .din                                    (reg_rd_data_mux_din),
        .sel                                    (reg_rd_data_mux_sel),
        .dout                                   (reg_rd_data_mux_dout),
        .dout_vld                               (reg_rd_data_mux_dout_vld));
endmodule
`default_nettype wire