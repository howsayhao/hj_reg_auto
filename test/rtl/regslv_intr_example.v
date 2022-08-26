`include "field_attr.vh"
`default_nettype none

module regslv_intr_example (
    ctrl_status_0__ctrl_status__next_value,
    ctrl_status_0__intr_out,
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

    input   logic   [ 0:0]                      ctrl_status_0__ctrl_status__next_value;
    output  logic                               ctrl_status_0__intr_out;
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
    slv_fsm #(.DATA_WIDTH (DATA_WIDTH))
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
        .reg_rd_data_vld                        (reg_rd_data_vld));

//***********************************FIELDS AND REGISTERS*********************************************//
    logic                                       inj_0__sw_wr_en;
    logic                                       inj_0__sw_rd_en;
    logic   [31:0]                              inj_0__sw_wr_data;
    logic   [31:0]                              inj_0__sw_rd_data;
    logic   [ 0:0]                              inj_0__inj__curr_value;
    logic                                       en_0__sw_wr_en;
    logic                                       en_0__sw_rd_en;
    logic   [31:0]                              en_0__sw_wr_data;
    logic   [31:0]                              en_0__sw_rd_data;
    logic   [ 0:0]                              en_0__en__curr_value;
    logic                                       ctrl_status_0__sw_wr_en;
    logic                                       ctrl_status_0__sw_rd_en;
    logic   [31:0]                              ctrl_status_0__sw_wr_data;
    logic   [31:0]                              ctrl_status_0__sw_rd_data;
    logic   [ 0:0]                              ctrl_status_0__ctrl_status__curr_value;
    logic                                       ctrl_status_0__ctrl_status__pulse;
    logic   [ 0:0]                              ctrl_status_0__intr_vec;
    logic                                       typ_0__sw_wr_en;
    logic                                       typ_0__sw_rd_en;
    logic   [31:0]                              typ_0__sw_wr_data;
    logic   [31:0]                              typ_0__sw_rd_data;
    logic   [ 0:0]                              typ_0__typ__curr_value;

    assign  inj_0__sw_wr_en      = reg_sw_wr_sel[0];
    assign  inj_0__sw_rd_en      = reg_sw_rd_sel[0];
    assign  inj_0__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[0]  = inj_0__sw_rd_data;

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
    x__inj_0__inj (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({inj_0__sw_wr_data[0:0]}),
        .sw_rd                                  ({inj_0__sw_rd_en}),
        .sw_wr                                  ({inj_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (inj_0__inj__curr_value));

    always_comb begin
        inj_0__sw_rd_data = 32'h0;
        inj_0__sw_rd_data[0:0] = inj_0__inj__curr_value;
    end

    assign  en_0__sw_wr_en      = reg_sw_wr_sel[1];
    assign  en_0__sw_rd_en      = reg_sw_rd_sel[1];
    assign  en_0__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[1]  = en_0__sw_rd_data;

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
    x__en_0__en (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({en_0__sw_wr_data[0:0]}),
        .sw_rd                                  ({en_0__sw_rd_en}),
        .sw_wr                                  ({en_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (en_0__en__curr_value));

    always_comb begin
        en_0__sw_rd_data = 32'h0;
        en_0__sw_rd_data[0:0] = en_0__en__curr_value;
    end

    assign  ctrl_status_0__sw_wr_en      = reg_sw_wr_sel[2];
    assign  ctrl_status_0__sw_rd_en      = reg_sw_rd_sel[2];
    assign  ctrl_status_0__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[2]  = ctrl_status_0__sw_rd_data;

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
    x__ctrl_status_0__ctrl_status (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({ctrl_status_0__sw_wr_data[0:0]}),
        .sw_rd                                  ({ctrl_status_0__sw_rd_en}),
        .sw_wr                                  ({ctrl_status_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (ctrl_status_0__ctrl_status__next_value),
        .hw_pulse                               (ctrl_status_0__ctrl_status__pulse),
        .field_value                            (ctrl_status_0__ctrl_status__curr_value));

    always_comb begin
        if (typ_0__typ__curr_value)
            ctrl_status_0__ctrl_status__pulse = ctrl_status_0__ctrl_status__next_value;
        else
            ctrl_status_0__ctrl_status__pulse = 1'b1;
    end

    assign  ctrl_status_0__intr_vec[0] =
        (ctrl_status_0__ctrl_status__curr_value |
        inj_0__inj__curr_value) &
        en_0__en__curr_value;

    // interrupt aggregation
    assign  ctrl_status_0__intr_out = |ctrl_status_0__intr_vec;

    always_comb begin
        ctrl_status_0__sw_rd_data = 32'h0;
        ctrl_status_0__sw_rd_data[0:0] = ctrl_status_0__ctrl_status__curr_value;
    end

    assign  typ_0__sw_wr_en      = reg_sw_wr_sel[3];
    assign  typ_0__sw_rd_en      = reg_sw_rd_sel[3];
    assign  typ_0__sw_wr_data    = reg_sw_wr_data;
    assign  reg_sw_rd_data[3]  = typ_0__sw_rd_data;

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
    x__typ_0__typ (
        .clk                                    (clk),
        .rst_n                                  (rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({typ_0__sw_wr_data[0:0]}),
        .sw_rd                                  ({typ_0__sw_rd_en}),
        .sw_wr                                  ({typ_0__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (1'b0),
        .hw_pulse                               (1'b0),
        .field_value                            (typ_0__typ__curr_value));

    always_comb begin
        typ_0__sw_rd_data = 32'h0;
        typ_0__sw_rd_data[0:0] = typ_0__typ__curr_value;
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