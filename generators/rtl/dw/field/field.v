`default_nettype none
`include "field_attr.vh"

module field (
    clk, rst_n, sync_rst,
    sw_wr, sw_rd, sw_wr_data,
    hw_pulse, hw_value, field_value,
    swmod_out, swacc_out
);
    parameter           F_WIDTH         = 4;
    parameter           ALIAS_NUM       = 1;
    parameter           SRST_CNT        = 0;
    parameter           PRECEDENCE      = `SW;
    parameter           HARD_WIRED      = 0;
    parameter   [3:0]   SW_TYPE         [ALIAS_NUM-1:0]     = '{ALIAS_NUM{`SW_RW}};
    parameter   [3:0]   SW_ONREAD_TYPE  [ALIAS_NUM-1:0]     = '{ALIAS_NUM{`NA}};
    parameter   [3:0]   SW_ONWRITE_TYPE [ALIAS_NUM-1:0]     = '{ALIAS_NUM{`NA}};
    parameter           HW_TYPE                             = `HW_RW;
    parameter           SRST_WIDTH                          = SRST_CNT ? SRST_CNT : 1;
    parameter   [ALIAS_NUM-1:0]         SWMOD               = {ALIAS_NUM{1'b0}};
    parameter   [ALIAS_NUM-1:0]         SWACC               = {ALIAS_NUM{1'b0}};
    parameter   [ALIAS_NUM-1:0]         PULSE               = {ALIAS_NUM{1'b0}};
    parameter   [F_WIDTH-1:0]           ARST_VALUE          = {F_WIDTH{1'b0}};
    parameter   [F_WIDTH-1:0]           SRST_VALUE          = ARST_VALUE;

    input   logic                                           clk;
    input   logic                                           rst_n;
    input   logic   [SRST_WIDTH-1:0]                        sync_rst;
    input   logic   [ALIAS_NUM-1:0] [F_WIDTH-1:0]           sw_wr_data;
    input   logic   [ALIAS_NUM-1:0]                         sw_rd;
    input   logic   [ALIAS_NUM-1:0]                         sw_wr;
    input   logic   [F_WIDTH-1:0]                           hw_value;
    input   logic                                           hw_pulse;
    output  logic   [F_WIDTH-1:0]                           field_value;
    output  logic                                           swmod_out;
    output  logic   [1:0]                                   swacc_out;

    logic           [ALIAS_NUM-1:0]                         swmod_out_pre;
    logic           [ALIAS_NUM-1:0]                         swacc_rd_out_pre;
    logic           [ALIAS_NUM-1:0]                         swacc_wr_out_pre;

    logic                                                   hw_modify;
    logic                                                   sw_modify;
    logic           [ALIAS_NUM-1:0]                         sw_modify_pre;

    logic           [F_WIDTH-1:0]                           nxt_hw_value;
    logic           [F_WIDTH-1:0]                           nxt_sw_value;
    logic           [F_WIDTH-1:0]                           nxt_field_value;
    logic           [ALIAS_NUM-1:0] [F_WIDTH-1:0]           nxt_sw_value_pre;

    logic           [F_WIDTH*2-1:0]                         field_mux_din_pre;
    logic           [1:0]                                   field_mux_sel_pre;
    logic           [F_WIDTH*(2+SRST_CNT)-1:0]              field_mux_din;
    logic           [(2+SRST_CNT)-1:0]                      field_mux_sel;
    logic                                                   field_value_modify;
    logic                                                   or_all_sync_rst;

    assign  or_all_sync_rst    = |sync_rst;

    genvar i;
    generate
        for (i = 0; i < ALIAS_NUM; i = i + 1) begin: g_sw_ctrl
            sw_ctrl #(
                .F_WIDTH                    (F_WIDTH),
                .SW_TYPE                    (SW_TYPE[i]),
                .SW_ONREAD_TYPE             (SW_ONREAD_TYPE[i]),
                .SW_ONWRITE_TYPE            (SW_ONWRITE_TYPE[i]),
                .SWMOD                      (SWMOD[i]),
                .SWACC                      (SWACC[i]),
                .PULSE                      (PULSE[i]))
            sw_ctrl (
                .clk                        (clk),
                .rst_n                      (rst_n),
                .sync_rst                   (or_all_sync_rst),
                .sw_wr                      (sw_wr[i]),
                .sw_rd                      (sw_rd[i]),
                .sw_wr_data                 (sw_wr_data[i]),
                .field_value                (field_value),
                .nxt_sw_value               (nxt_sw_value_pre[i]),
                .sw_modify                  (sw_modify_pre[i]),
                .swmod_out                  (swmod_out_pre[i]),
                .swacc_rd_out               (swacc_rd_out_pre[i]),
                .swacc_wr_out               (swacc_wr_out_pre[i]));
        end
    endgenerate

    hw_ctrl #(
        .F_WIDTH                            (F_WIDTH),
        .HW_TYPE                            (HW_TYPE),
        .HARD_WIRED                         (HARD_WIRED),
        .HARD_WIRED_VAL                     (ARST_VALUE))
    hw_ctrl (
        .hw_pulse                           (hw_pulse),
        .hw_value                           (hw_value),
        .field_value                        (field_value),
        .nxt_hw_value                       (nxt_hw_value),
        .hw_modify                          (hw_modify));

    generate
        if (ALIAS_NUM >1) begin: g_sw_mux
            priority_mux_2d #(.WIDTH (F_WIDTH), .CNT (ALIAS_NUM))
            sw_mux (
                .din                        (nxt_sw_value_pre),
                .sel                        (sw_modify_pre),
                .dout                       (nxt_sw_value));
            assign sw_modify = |sw_modify_pre;
        end
        else begin: g_no_sw_mux
            assign nxt_sw_value = nxt_sw_value_pre;
            assign sw_modify = sw_modify_pre;
        end
    endgenerate

    // ultimate mux to field
    generate
        if (PRECEDENCE == `SW) begin: g_fmux_sw_dominant
            assign field_mux_din_pre = {nxt_hw_value, nxt_sw_value};
            assign field_mux_sel_pre = {hw_modify, sw_modify};
        end
        else begin: g_fmux_hw_dominant
            assign field_mux_din_pre = {nxt_sw_value, nxt_hw_value};
            assign field_mux_sel_pre = {sw_modify, hw_modify};
        end
    endgenerate

    generate
        if (SRST_CNT == 0) begin: g_no_sync_rst
            assign field_mux_din = field_mux_din_pre;
            assign field_mux_sel = field_mux_sel_pre;
        end
        else begin: g_has_sync_rst
            assign field_mux_din = {field_mux_din_pre, {SRST_CNT{SRST_VALUE}}};
            assign field_mux_sel = {field_mux_sel_pre, sync_rst};
        end
    endgenerate

    priority_mux #(.WIDTH (F_WIDTH), .CNT (2+SRST_CNT))
    field_mux (
        .din                    (field_mux_din),
        .sel                    (field_mux_sel),
        .dout                   (nxt_field_value));

    assign field_value_modify = |field_mux_sel;

    generate
        if (HARD_WIRED)
            assign field_value = nxt_hw_value;
        else
            // field DFF
            always_ff @(posedge clk or negedge rst_n) begin
                if (!rst_n)
                    field_value <= ARST_VALUE;
                else if (field_value_modify)
                    field_value <= nxt_field_value;
            end
    endgenerate

    // swmod, swacc (swrd, swwr) genrated by software
    always_ff @(posedge clk or negedge rst_n)
        if (!rst_n) begin
            swmod_out <= 1'b0;
            swacc_out <= 2'b0;
        end
        else begin
            swmod_out <= |swmod_out_pre;
            swacc_out <= {|swacc_rd_out_pre, |swacc_wr_out_pre};
        end
endmodule
`default_nettype wire