`include "field_attr.vh"
`default_nettype none

module regslv_intr_ex (
    status_0__stat_0__next_value,
    status_0__stat_1__next_value,
    status_0__stat_2__next_value,
    status_0__stat_3__next_value,
    status_0__stat_4__next_value,
    status_0__stat_5__next_value,
    status_0__stat_6__next_value,
    status_0__stat_7__next_value,
    status_0__stat_8__next_value,
    status_0__stat_9__next_value,
    status_0__intr_out,
    clk,
    rst_n,
    soft_rst,
    req_vld,
    wr_en,
    rd_en,
    addr,
    wr_data,
    rd_data,
    ack_vld,
    err,
    err_en
);
    `include "common_funcs.vh"

    parameter       ADDR_WIDTH                  = 48;
    parameter       DATA_WIDTH                  = 32;
    parameter       INSERT_REG_FF               = 1;
    localparam      REG_NUM                     = 4;

    input   logic   [ 0:0]                      status_0__stat_0__next_value;
    input   logic   [ 0:0]                      status_0__stat_1__next_value;
    input   logic   [ 0:0]                      status_0__stat_2__next_value;
    input   logic   [ 0:0]                      status_0__stat_3__next_value;
    input   logic   [ 0:0]                      status_0__stat_4__next_value;
    input   logic   [ 0:0]                      status_0__stat_5__next_value;
    input   logic   [ 0:0]                      status_0__stat_6__next_value;
    input   logic   [ 0:0]                      status_0__stat_7__next_value;
    input   logic   [ 0:0]                      status_0__stat_8__next_value;
    input   logic   [ 0:0]                      status_0__stat_9__next_value;
    output  logic                               status_0__intr_out;
    input   logic                               clk;
    input   logic                               rst_n;
    input   logic                               req_vld;
    input   logic                               wr_en;
    input   logic                               rd_en;
    input   logic   [ADDR_WIDTH-1:0]            addr;
    input   logic   [DATA_WIDTH-1:0]            wr_data;
    input   logic                               soft_rst;
    output  logic   [DATA_WIDTH-1:0]            rd_data;
    output  logic                               ack_vld;
    output  logic                               err;
    input   logic                               err_en;

    logic                                       int_req_vld;
    logic                                       int_wr_en;
    logic                                       int_rd_en;
    logic   [ADDR_WIDTH-1:0]                    int_addr;
    logic   [DATA_WIDTH-1:0]                    int_wr_data;
    logic                                       int_soft_rst;
    logic   [DATA_WIDTH-1:0]                    int_rd_data;
    logic                                       int_ack_vld;
    logic                                       int_err;
    logic   [REG_NUM-1:0] [DATA_WIDTH-1:0]      reg_sw_rd_data;
    logic   [REG_NUM-1:0] [DATA_WIDTH-1:0]      reg_rd_data_mux_din;
    logic   [REG_NUM-1:0]                       reg_rd_data_mux_sel;
    logic   [DATA_WIDTH-1:0]                    reg_rd_data_mux_dout;
    logic                                       reg_rd_data_mux_dout_vld;
    logic                                       reg_rd_data_vld;
    logic   [DATA_WIDTH-1:0]                    reg_rd_data;

    assign  int_req_vld                         = req_vld;
    assign  int_wr_en                           = wr_en;
    assign  int_rd_en                           = rd_en;
    assign  int_addr                            = addr;
    assign  int_wr_data                         = wr_data;
    assign  int_soft_rst                        = soft_rst;
    assign  rd_data                             = int_rd_data;
    assign  ack_vld                             = int_ack_vld;
    assign  err                                 = int_err;

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
        if (int_req_vld & ~int_soft_rst) begin
            dec_reg_sel = {REG_NUM{1'b0}};
            dec_dummy_sel = 1'b0;

            unique case (int_addr[ADDR_WIDTH-1:ADDR_TRUNC_BITS])
                ADDR_REM_BITS'('h0 >> ADDR_TRUNC_BITS): dec_reg_sel[0] = 1'b1;
                ADDR_REM_BITS'('h4 >> ADDR_TRUNC_BITS): dec_reg_sel[1] = 1'b1;
                ADDR_REM_BITS'('h8 >> ADDR_TRUNC_BITS): dec_reg_sel[2] = 1'b1;
                ADDR_REM_BITS'('hc >> ADDR_TRUNC_BITS): dec_reg_sel[3] = 1'b1;
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
            always_ff @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    reg_sw_wr_sel               <= {REG_NUM{1'b0}};
                    reg_sw_rd_sel               <= {REG_NUM{1'b0}};
                    reg_sw_wr_data              <= {DATA_WIDTH{1'b0}};
                    dummy_acc                   <= 1'b0;
                end
                else if (int_soft_rst) begin
                    reg_sw_wr_sel               <= {REG_NUM{1'b0}};
                    reg_sw_rd_sel               <= {REG_NUM{1'b0}};
                    reg_sw_wr_data              <= {DATA_WIDTH{1'b0}};
                    dummy_acc                   <= 1'b0;
                end
                else begin
                    reg_sw_wr_sel               <= {REG_NUM{int_wr_en}} & dec_reg_sel;
                    reg_sw_rd_sel               <= {REG_NUM{int_rd_en}} & dec_reg_sel;
                    reg_sw_wr_data              <= int_wr_data;
                    dummy_acc                   <= dec_dummy_sel;
                end
            end
        end
        else begin: g_no_reg_ff
            assign  reg_sw_wr_sel               = {REG_NUM{int_wr_en}} & dec_reg_sel;
            assign  reg_sw_rd_sel               = {REG_NUM{int_rd_en}} & dec_reg_sel;
            assign  reg_sw_wr_data              = int_wr_data;
            assign  dummy_acc                   = dec_dummy_sel;
        end
    endgenerate

    assign  reg_acc                             = (|reg_sw_wr_sel) | (|reg_sw_rd_sel);

//*******************************************FSM******************************************************//
    slv_fsm #(
        .DATA_WIDTH (DATA_WIDTH)
    )
    slv_fsm (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .if_soft_rst                            (int_soft_rst),
        .if_req_vld                             (int_req_vld),
        .if_ack_vld                             (int_ack_vld),
        .if_rd_data                             (int_rd_data),
        .if_err                                 (int_err),
        .if_err_en                              (err_en),
        .if_wr_en                               (int_wr_en),
        .if_rd_en                               (int_rd_en),
        .dummy_acc                              (dummy_acc),
        .reg_acc                                (reg_acc),
        .reg_rd_data                            (reg_rd_data),
        .reg_rd_data_vld                        (reg_rd_data_vld)
    );

//***********************************FIELDS AND REGISTERS*********************************************//
    logic                                       injection_0__sw_wr_en;
    logic                                       injection_0__sw_rd_en;
    logic   [31:0]                              injection_0__sw_wr_data;
    logic   [31:0]                              injection_0__sw_rd_data;
    logic   [ 0:0]                              injection_0__inj_0__curr_value;
    logic   [ 0:0]                              injection_0__inj_1__curr_value;
    logic   [ 0:0]                              injection_0__inj_2__curr_value;
    logic   [ 0:0]                              injection_0__inj_3__curr_value;
    logic   [ 0:0]                              injection_0__inj_4__curr_value;
    logic   [ 0:0]                              injection_0__inj_5__curr_value;
    logic   [ 0:0]                              injection_0__inj_6__curr_value;
    logic   [ 0:0]                              injection_0__inj_7__curr_value;
    logic   [ 0:0]                              injection_0__inj_8__curr_value;
    logic   [ 0:0]                              injection_0__inj_9__curr_value;
    logic                                       enable_0__sw_wr_en;
    logic                                       enable_0__sw_rd_en;
    logic   [31:0]                              enable_0__sw_wr_data;
    logic   [31:0]                              enable_0__sw_rd_data;
    logic   [ 0:0]                              enable_0__en_0__curr_value;
    logic   [ 0:0]                              enable_0__en_1__curr_value;
    logic   [ 0:0]                              enable_0__en_2__curr_value;
    logic   [ 0:0]                              enable_0__en_3__curr_value;
    logic   [ 0:0]                              enable_0__en_4__curr_value;
    logic   [ 0:0]                              enable_0__en_5__curr_value;
    logic   [ 0:0]                              enable_0__en_6__curr_value;
    logic   [ 0:0]                              enable_0__en_7__curr_value;
    logic   [ 0:0]                              enable_0__en_8__curr_value;
    logic   [ 0:0]                              enable_0__en_9__curr_value;
    logic                                       intr_type_0__sw_wr_en;
    logic                                       intr_type_0__sw_rd_en;
    logic   [31:0]                              intr_type_0__sw_wr_data;
    logic   [31:0]                              intr_type_0__sw_rd_data;
    logic   [ 0:0]                              intr_type_0__typ_0__curr_value;
    logic   [ 0:0]                              intr_type_0__typ_1__curr_value;
    logic   [ 0:0]                              intr_type_0__typ_2__curr_value;
    logic   [ 0:0]                              intr_type_0__typ_3__curr_value;
    logic   [ 0:0]                              intr_type_0__typ_4__curr_value;
    logic   [ 0:0]                              intr_type_0__typ_5__curr_value;
    logic   [ 0:0]                              intr_type_0__typ_6__curr_value;
    logic   [ 0:0]                              intr_type_0__typ_7__curr_value;
    logic   [ 0:0]                              intr_type_0__typ_8__curr_value;
    logic   [ 0:0]                              intr_type_0__typ_9__curr_value;
    logic                                       status_0__sw_wr_en;
    logic                                       status_0__sw_rd_en;
    logic   [31:0]                              status_0__sw_wr_data;
    logic   [31:0]                              status_0__sw_rd_data;
    logic                                       status_0__stat_0__pulse;
    logic                                       status_0__stat_1__pulse;
    logic                                       status_0__stat_2__pulse;
    logic                                       status_0__stat_3__pulse;
    logic                                       status_0__stat_4__pulse;
    logic                                       status_0__stat_5__pulse;
    logic                                       status_0__stat_6__pulse;
    logic                                       status_0__stat_7__pulse;
    logic                                       status_0__stat_8__pulse;
    logic                                       status_0__stat_9__pulse;
    logic   [ 9:0]                              status_0__intr_vec;

    assign  injection_0__sw_wr_en      = reg_sw_wr_sel[0];
    assign  injection_0__sw_rd_en      = reg_sw_rd_sel[0];
    assign  injection_0__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[0]  = injection_0__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__injection_0__inj_0 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({injection_0__sw_wr_data[0:0]}),
        .sw_rd                                  ({injection_0__sw_rd_en}),
        .sw_wr                                  ({injection_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (injection_0__inj_0__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__injection_0__inj_1 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({injection_0__sw_wr_data[1:1]}),
        .sw_rd                                  ({injection_0__sw_rd_en}),
        .sw_wr                                  ({injection_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (injection_0__inj_1__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__injection_0__inj_2 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({injection_0__sw_wr_data[2:2]}),
        .sw_rd                                  ({injection_0__sw_rd_en}),
        .sw_wr                                  ({injection_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (injection_0__inj_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__injection_0__inj_3 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({injection_0__sw_wr_data[3:3]}),
        .sw_rd                                  ({injection_0__sw_rd_en}),
        .sw_wr                                  ({injection_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (injection_0__inj_3__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__injection_0__inj_4 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({injection_0__sw_wr_data[4:4]}),
        .sw_rd                                  ({injection_0__sw_rd_en}),
        .sw_wr                                  ({injection_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (injection_0__inj_4__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__injection_0__inj_5 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({injection_0__sw_wr_data[5:5]}),
        .sw_rd                                  ({injection_0__sw_rd_en}),
        .sw_wr                                  ({injection_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (injection_0__inj_5__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__injection_0__inj_6 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({injection_0__sw_wr_data[6:6]}),
        .sw_rd                                  ({injection_0__sw_rd_en}),
        .sw_wr                                  ({injection_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (injection_0__inj_6__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__injection_0__inj_7 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({injection_0__sw_wr_data[7:7]}),
        .sw_rd                                  ({injection_0__sw_rd_en}),
        .sw_wr                                  ({injection_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (injection_0__inj_7__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__injection_0__inj_8 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({injection_0__sw_wr_data[8:8]}),
        .sw_rd                                  ({injection_0__sw_rd_en}),
        .sw_wr                                  ({injection_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (injection_0__inj_8__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__injection_0__inj_9 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({injection_0__sw_wr_data[9:9]}),
        .sw_rd                                  ({injection_0__sw_rd_en}),
        .sw_wr                                  ({injection_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (injection_0__inj_9__curr_value));

    always_comb begin
        injection_0__sw_rd_data = 32'h0;
        injection_0__sw_rd_data[0:0] = injection_0__inj_0__curr_value;
        injection_0__sw_rd_data[1:1] = injection_0__inj_1__curr_value;
        injection_0__sw_rd_data[2:2] = injection_0__inj_2__curr_value;
        injection_0__sw_rd_data[3:3] = injection_0__inj_3__curr_value;
        injection_0__sw_rd_data[4:4] = injection_0__inj_4__curr_value;
        injection_0__sw_rd_data[5:5] = injection_0__inj_5__curr_value;
        injection_0__sw_rd_data[6:6] = injection_0__inj_6__curr_value;
        injection_0__sw_rd_data[7:7] = injection_0__inj_7__curr_value;
        injection_0__sw_rd_data[8:8] = injection_0__inj_8__curr_value;
        injection_0__sw_rd_data[9:9] = injection_0__inj_9__curr_value;
    end

    assign  enable_0__sw_wr_en      = reg_sw_wr_sel[1];
    assign  enable_0__sw_rd_en      = reg_sw_rd_sel[1];
    assign  enable_0__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[1]  = enable_0__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__enable_0__en_0 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({enable_0__sw_wr_data[0:0]}),
        .sw_rd                                  ({enable_0__sw_rd_en}),
        .sw_wr                                  ({enable_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (enable_0__en_0__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__enable_0__en_1 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({enable_0__sw_wr_data[1:1]}),
        .sw_rd                                  ({enable_0__sw_rd_en}),
        .sw_wr                                  ({enable_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (enable_0__en_1__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__enable_0__en_2 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({enable_0__sw_wr_data[2:2]}),
        .sw_rd                                  ({enable_0__sw_rd_en}),
        .sw_wr                                  ({enable_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (enable_0__en_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__enable_0__en_3 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({enable_0__sw_wr_data[3:3]}),
        .sw_rd                                  ({enable_0__sw_rd_en}),
        .sw_wr                                  ({enable_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (enable_0__en_3__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__enable_0__en_4 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({enable_0__sw_wr_data[4:4]}),
        .sw_rd                                  ({enable_0__sw_rd_en}),
        .sw_wr                                  ({enable_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (enable_0__en_4__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__enable_0__en_5 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({enable_0__sw_wr_data[5:5]}),
        .sw_rd                                  ({enable_0__sw_rd_en}),
        .sw_wr                                  ({enable_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (enable_0__en_5__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__enable_0__en_6 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({enable_0__sw_wr_data[6:6]}),
        .sw_rd                                  ({enable_0__sw_rd_en}),
        .sw_wr                                  ({enable_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (enable_0__en_6__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__enable_0__en_7 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({enable_0__sw_wr_data[7:7]}),
        .sw_rd                                  ({enable_0__sw_rd_en}),
        .sw_wr                                  ({enable_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (enable_0__en_7__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__enable_0__en_8 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({enable_0__sw_wr_data[8:8]}),
        .sw_rd                                  ({enable_0__sw_rd_en}),
        .sw_wr                                  ({enable_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (enable_0__en_8__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__enable_0__en_9 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({enable_0__sw_wr_data[9:9]}),
        .sw_rd                                  ({enable_0__sw_rd_en}),
        .sw_wr                                  ({enable_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (enable_0__en_9__curr_value));

    always_comb begin
        enable_0__sw_rd_data = 32'h0;
        enable_0__sw_rd_data[0:0] = enable_0__en_0__curr_value;
        enable_0__sw_rd_data[1:1] = enable_0__en_1__curr_value;
        enable_0__sw_rd_data[2:2] = enable_0__en_2__curr_value;
        enable_0__sw_rd_data[3:3] = enable_0__en_3__curr_value;
        enable_0__sw_rd_data[4:4] = enable_0__en_4__curr_value;
        enable_0__sw_rd_data[5:5] = enable_0__en_5__curr_value;
        enable_0__sw_rd_data[6:6] = enable_0__en_6__curr_value;
        enable_0__sw_rd_data[7:7] = enable_0__en_7__curr_value;
        enable_0__sw_rd_data[8:8] = enable_0__en_8__curr_value;
        enable_0__sw_rd_data[9:9] = enable_0__en_9__curr_value;
    end

    assign  intr_type_0__sw_wr_en      = reg_sw_wr_sel[2];
    assign  intr_type_0__sw_rd_en      = reg_sw_rd_sel[2];
    assign  intr_type_0__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[2]  = intr_type_0__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__intr_type_0__typ_0 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({intr_type_0__sw_wr_data[0:0]}),
        .sw_rd                                  ({intr_type_0__sw_rd_en}),
        .sw_wr                                  ({intr_type_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (intr_type_0__typ_0__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__intr_type_0__typ_1 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({intr_type_0__sw_wr_data[1:1]}),
        .sw_rd                                  ({intr_type_0__sw_rd_en}),
        .sw_wr                                  ({intr_type_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (intr_type_0__typ_1__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__intr_type_0__typ_2 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({intr_type_0__sw_wr_data[2:2]}),
        .sw_rd                                  ({intr_type_0__sw_rd_en}),
        .sw_wr                                  ({intr_type_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (intr_type_0__typ_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__intr_type_0__typ_3 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({intr_type_0__sw_wr_data[3:3]}),
        .sw_rd                                  ({intr_type_0__sw_rd_en}),
        .sw_wr                                  ({intr_type_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (intr_type_0__typ_3__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__intr_type_0__typ_4 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({intr_type_0__sw_wr_data[4:4]}),
        .sw_rd                                  ({intr_type_0__sw_rd_en}),
        .sw_wr                                  ({intr_type_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (intr_type_0__typ_4__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__intr_type_0__typ_5 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({intr_type_0__sw_wr_data[5:5]}),
        .sw_rd                                  ({intr_type_0__sw_rd_en}),
        .sw_wr                                  ({intr_type_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (intr_type_0__typ_5__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__intr_type_0__typ_6 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({intr_type_0__sw_wr_data[6:6]}),
        .sw_rd                                  ({intr_type_0__sw_rd_en}),
        .sw_wr                                  ({intr_type_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (intr_type_0__typ_6__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__intr_type_0__typ_7 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({intr_type_0__sw_wr_data[7:7]}),
        .sw_rd                                  ({intr_type_0__sw_rd_en}),
        .sw_wr                                  ({intr_type_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (intr_type_0__typ_7__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__intr_type_0__typ_8 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({intr_type_0__sw_wr_data[8:8]}),
        .sw_rd                                  ({intr_type_0__sw_rd_en}),
        .sw_wr                                  ({intr_type_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (intr_type_0__typ_8__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`NA}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_NA),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__intr_type_0__typ_9 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({intr_type_0__sw_wr_data[9:9]}),
        .sw_rd                                  ({intr_type_0__sw_rd_en}),
        .sw_wr                                  ({intr_type_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (intr_type_0__typ_9__curr_value));

    always_comb begin
        intr_type_0__sw_rd_data = 32'h0;
        intr_type_0__sw_rd_data[0:0] = intr_type_0__typ_0__curr_value;
        intr_type_0__sw_rd_data[1:1] = intr_type_0__typ_1__curr_value;
        intr_type_0__sw_rd_data[2:2] = intr_type_0__typ_2__curr_value;
        intr_type_0__sw_rd_data[3:3] = intr_type_0__typ_3__curr_value;
        intr_type_0__sw_rd_data[4:4] = intr_type_0__typ_4__curr_value;
        intr_type_0__sw_rd_data[5:5] = intr_type_0__typ_5__curr_value;
        intr_type_0__sw_rd_data[6:6] = intr_type_0__typ_6__curr_value;
        intr_type_0__sw_rd_data[7:7] = intr_type_0__typ_7__curr_value;
        intr_type_0__sw_rd_data[8:8] = intr_type_0__typ_8__curr_value;
        intr_type_0__sw_rd_data[9:9] = intr_type_0__typ_9__curr_value;
    end

    assign  status_0__sw_wr_en      = reg_sw_wr_sel[3];
    assign  status_0__sw_rd_en      = reg_sw_rd_sel[3];
    assign  status_0__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[3]  = status_0__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`WZC}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__status_0__stat_0 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({status_0__sw_wr_data[0:0]}),
        .sw_rd                                  ({status_0__sw_rd_en}),
        .sw_wr                                  ({status_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (status_0__stat_0__next_value),
        .hw_pulse                               (status_0__stat_0__pulse),
        .field_value                            (status_0__stat_0__curr_value));
    always_comb begin
        if (intr_type_0__typ_0__curr_value)
            status_0__stat_0__pulse = status_0__stat_0__next_value;
        else
            status_0__stat_0__pulse = 1'b1;
    end

    assign  status_0__intr_vec[0] =
        (status_0__stat_0__curr_value |
        injection_0__inj_0__curr_value) &
        enable_0__en_0__curr_value;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`WZC}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__status_0__stat_1 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({status_0__sw_wr_data[1:1]}),
        .sw_rd                                  ({status_0__sw_rd_en}),
        .sw_wr                                  ({status_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (status_0__stat_1__next_value),
        .hw_pulse                               (status_0__stat_1__pulse),
        .field_value                            (status_0__stat_1__curr_value));
    always_comb begin
        if (intr_type_0__typ_1__curr_value)
            status_0__stat_1__pulse = status_0__stat_1__next_value;
        else
            status_0__stat_1__pulse = 1'b1;
    end

    assign  status_0__intr_vec[1] =
        (status_0__stat_1__curr_value |
        injection_0__inj_1__curr_value) &
        enable_0__en_1__curr_value;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`WZC}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__status_0__stat_2 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({status_0__sw_wr_data[2:2]}),
        .sw_rd                                  ({status_0__sw_rd_en}),
        .sw_wr                                  ({status_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (status_0__stat_2__next_value),
        .hw_pulse                               (status_0__stat_2__pulse),
        .field_value                            (status_0__stat_2__curr_value));
    always_comb begin
        if (intr_type_0__typ_2__curr_value)
            status_0__stat_2__pulse = status_0__stat_2__next_value;
        else
            status_0__stat_2__pulse = 1'b1;
    end

    assign  status_0__intr_vec[2] =
        (status_0__stat_2__curr_value |
        injection_0__inj_2__curr_value) &
        enable_0__en_2__curr_value;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`WZC}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__status_0__stat_3 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({status_0__sw_wr_data[3:3]}),
        .sw_rd                                  ({status_0__sw_rd_en}),
        .sw_wr                                  ({status_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (status_0__stat_3__next_value),
        .hw_pulse                               (status_0__stat_3__pulse),
        .field_value                            (status_0__stat_3__curr_value));
    always_comb begin
        if (intr_type_0__typ_3__curr_value)
            status_0__stat_3__pulse = status_0__stat_3__next_value;
        else
            status_0__stat_3__pulse = 1'b1;
    end

    assign  status_0__intr_vec[3] =
        (status_0__stat_3__curr_value |
        injection_0__inj_3__curr_value) &
        enable_0__en_3__curr_value;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`WZC}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__status_0__stat_4 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({status_0__sw_wr_data[4:4]}),
        .sw_rd                                  ({status_0__sw_rd_en}),
        .sw_wr                                  ({status_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (status_0__stat_4__next_value),
        .hw_pulse                               (status_0__stat_4__pulse),
        .field_value                            (status_0__stat_4__curr_value));
    always_comb begin
        if (intr_type_0__typ_4__curr_value)
            status_0__stat_4__pulse = status_0__stat_4__next_value;
        else
            status_0__stat_4__pulse = 1'b1;
    end

    assign  status_0__intr_vec[4] =
        (status_0__stat_4__curr_value |
        injection_0__inj_4__curr_value) &
        enable_0__en_4__curr_value;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`WZC}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__status_0__stat_5 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({status_0__sw_wr_data[5:5]}),
        .sw_rd                                  ({status_0__sw_rd_en}),
        .sw_wr                                  ({status_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (status_0__stat_5__next_value),
        .hw_pulse                               (status_0__stat_5__pulse),
        .field_value                            (status_0__stat_5__curr_value));
    always_comb begin
        if (intr_type_0__typ_5__curr_value)
            status_0__stat_5__pulse = status_0__stat_5__next_value;
        else
            status_0__stat_5__pulse = 1'b1;
    end

    assign  status_0__intr_vec[5] =
        (status_0__stat_5__curr_value |
        injection_0__inj_5__curr_value) &
        enable_0__en_5__curr_value;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`WZC}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__status_0__stat_6 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({status_0__sw_wr_data[6:6]}),
        .sw_rd                                  ({status_0__sw_rd_en}),
        .sw_wr                                  ({status_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (status_0__stat_6__next_value),
        .hw_pulse                               (status_0__stat_6__pulse),
        .field_value                            (status_0__stat_6__curr_value));
    always_comb begin
        if (intr_type_0__typ_6__curr_value)
            status_0__stat_6__pulse = status_0__stat_6__next_value;
        else
            status_0__stat_6__pulse = 1'b1;
    end

    assign  status_0__intr_vec[6] =
        (status_0__stat_6__curr_value |
        injection_0__inj_6__curr_value) &
        enable_0__en_6__curr_value;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`WZC}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__status_0__stat_7 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({status_0__sw_wr_data[7:7]}),
        .sw_rd                                  ({status_0__sw_rd_en}),
        .sw_wr                                  ({status_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (status_0__stat_7__next_value),
        .hw_pulse                               (status_0__stat_7__pulse),
        .field_value                            (status_0__stat_7__curr_value));
    always_comb begin
        if (intr_type_0__typ_7__curr_value)
            status_0__stat_7__pulse = status_0__stat_7__next_value;
        else
            status_0__stat_7__pulse = 1'b1;
    end

    assign  status_0__intr_vec[7] =
        (status_0__stat_7__curr_value |
        injection_0__inj_7__curr_value) &
        enable_0__en_7__curr_value;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`WZC}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__status_0__stat_8 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({status_0__sw_wr_data[8:8]}),
        .sw_rd                                  ({status_0__sw_rd_en}),
        .sw_wr                                  ({status_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (status_0__stat_8__next_value),
        .hw_pulse                               (status_0__stat_8__pulse),
        .field_value                            (status_0__stat_8__curr_value));
    always_comb begin
        if (intr_type_0__typ_8__curr_value)
            status_0__stat_8__pulse = status_0__stat_8__next_value;
        else
            status_0__stat_8__pulse = 1'b1;
    end

    assign  status_0__intr_vec[8] =
        (status_0__stat_8__curr_value |
        injection_0__inj_8__curr_value) &
        enable_0__en_8__curr_value;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (1),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA}),
        .SW_ONWRITE_TYPE                        ({`WZC}),
        .SWMOD                                  ({1{1'b0}}),
        .SWACC                                  ({1{1'b0}}),
        .PULSE                                  ({1{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW),
        .HARD_WIRED                             (0))
    x__status_0__stat_9 (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({status_0__sw_wr_data[9:9]}),
        .sw_rd                                  ({status_0__sw_rd_en}),
        .sw_wr                                  ({status_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (status_0__stat_9__next_value),
        .hw_pulse                               (status_0__stat_9__pulse),
        .field_value                            (status_0__stat_9__curr_value));
    always_comb begin
        if (intr_type_0__typ_9__curr_value)
            status_0__stat_9__pulse = status_0__stat_9__next_value;
        else
            status_0__stat_9__pulse = 1'b1;
    end

    assign  status_0__intr_vec[9] =
        (status_0__stat_9__curr_value |
        injection_0__inj_9__curr_value) &
        enable_0__en_9__curr_value;

    // interrupt aggregation
    assign  status_0__intr_out = |status_0__intr_vec;
    always_comb begin
        status_0__sw_rd_data = 32'h0;
        status_0__sw_rd_data[0:0] = status_0__stat_0__curr_value;
        status_0__sw_rd_data[1:1] = status_0__stat_1__curr_value;
        status_0__sw_rd_data[2:2] = status_0__stat_2__curr_value;
        status_0__sw_rd_data[3:3] = status_0__stat_3__curr_value;
        status_0__sw_rd_data[4:4] = status_0__stat_4__curr_value;
        status_0__sw_rd_data[5:5] = status_0__stat_5__curr_value;
        status_0__sw_rd_data[6:6] = status_0__stat_6__curr_value;
        status_0__sw_rd_data[7:7] = status_0__stat_7__curr_value;
        status_0__sw_rd_data[8:8] = status_0__stat_8__curr_value;
        status_0__sw_rd_data[9:9] = status_0__stat_9__curr_value;
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
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .din                                    (reg_rd_data_mux_din),
        .sel                                    (reg_rd_data_mux_sel),
        .dout                                   (reg_rd_data_mux_dout),
        .dout_vld                               (reg_rd_data_mux_dout_vld));
endmodule
`default_nettype wire