`default_nettype none
`include "field_attr.vh"

module sw_ctrl (
    clk, rst_n, sync_rst,
    sw_rd, sw_wr, sw_modify,
    sw_wr_data, nxt_sw_value, field_value,
    swmod_out, swacc_rd_out, swacc_wr_out
);

    parameter               F_WIDTH             = 1;
    parameter               SW_CNT              = 1;
    parameter   [3:0]       SW_TYPE             = `SW_RW;
    parameter   [3:0]       SW_ONREAD_TYPE      = `NA;
    parameter   [3:0]       SW_ONWRITE_TYPE     = `NA;
    parameter               SWMOD               = 0;
    parameter               SWACC               = 0;
    parameter               PULSE               = 0;

    input   logic                               clk;
    input   logic                               rst_n;
    input   logic                               sync_rst;
    input   logic                               sw_rd;
    input   logic                               sw_wr;
    output  logic                               sw_modify;
    input   logic   [F_WIDTH-1:0]               sw_wr_data;
    output  logic   [F_WIDTH-1:0]               nxt_sw_value;
    input   logic   [F_WIDTH-1:0]               field_value;
    output  logic                               swmod_out;
    output  logic                               swacc_rd_out;
    output  logic                               swacc_wr_out;

    logic                                       onread_modify;
    logic                                       onwrite_modify;
    logic                                       swmod_wr;
    logic                                       swmod_rd;
    logic   [F_WIDTH-1:0]                       sw_onread_value;
    logic   [F_WIDTH-1:0]                       sw_onwrite_value;
    logic   [F_WIDTH*2-1:0]                     sw_mux_din;
    logic   [1:0]                               sw_mux_sel;
    logic   [F_WIDTH-1:0]                       sw_mux_value;
    logic                                       sw_wr_protect;

    generate
        if (SW_TYPE == `SW_RW1 || SW_TYPE == `SW_W1) begin: g_write_only_once
            always_ff @(posedge clk or negedge rst_n) begin
                if (!rst_n)
                    sw_wr_protect <= 1'b0;
                else if (sync_rst)
                    sw_wr_protect <= 1'b0;
                else if (sw_wr)
                    sw_wr_protect <= 1'b1;
            end
        end
        else begin: g_no_write_only_once
            assign sw_wr_protect = 1'b0;
        end
    endgenerate

    // read effect
    generate
        if (SW_TYPE == `SW_RO || SW_TYPE == `SW_RW || SW_TYPE == `SW_RW1) begin: g_SW_R
            if (SW_ONREAD_TYPE == `RCLR) begin: g_ONREAD_RCLR
                if (SWMOD) begin: g_SWMOD
                    assign swmod_rd = sw_rd & (|field_value);
                end

                assign onread_modify = sw_rd;
                assign sw_onread_value = {F_WIDTH{1'b0}};
            end
            else if (SW_ONREAD_TYPE == `RSET) begin: g_ONREAD_RSET
                if (SWMOD) begin: g_SWMOD
                    assign swmod_rd = sw_rd & (|(~field_value));
                end

                assign onread_modify = sw_rd;
                assign sw_onread_value = {F_WIDTH{1'b1}};
            end
            else if (SW_ONREAD_TYPE == `NA) begin: g_ONREAD_NA
                if (SWMOD) begin: g_SWMOD
                    assign swmod_rd = 1'b0;
                end

                assign onread_modify = 1'b0;
                assign sw_onread_value = field_value;
            end
            else begin:g_SW_ONREAD_unknown
                // synopsys translate_off
                initial begin
                    $display("unknown software onread type %d", SW_ONREAD_TYPE);
                    $finish;
                end
                // synopsys translate_on
            end
        end
        else if (SW_TYPE == `SW_WO || SW_TYPE == `SW_W1) begin: g_SW_NR
            if (SWMOD) begin: g_SWMOD
                assign swmod_rd = 1'b0;
            end

            assign onread_modify = 1'b0;
            assign sw_onread_value = {F_WIDTH{1'b0}};
        end
        else begin: g_SW_R_unknown
            // synopsys translate_off
            initial begin
                $display("unknown software access type %d", SW_TYPE);
                $finish;
            end
            // synopsys translate_on
        end
    endgenerate

    // write effect
    generate
        if (SW_TYPE == `SW_WO || SW_TYPE == `SW_RW || SW_TYPE == `SW_RW1 || SW_TYPE == `SW_W1) begin: g_SW_W
            if (SW_ONWRITE_TYPE == `WOCLR) begin: g_ONWRITE_WOCLR
                if (SWMOD) begin: g_SWMOD
                    assign swmod_wr = sw_wr & (|(field_value & sw_wr_data));
                end

                assign onwrite_modify = sw_wr & ~sw_wr_protect;
                assign sw_onwrite_value = field_value & (~sw_wr_data);
            end
            else if (SW_ONWRITE_TYPE == `WOSET) begin: g_ONWRITE_WOSET
                if (SWMOD) begin: g_SWMOD
                    assign swmod_wr = sw_wr & (|(~field_value & sw_wr_data));
                end

                assign onwrite_modify = sw_wr & ~sw_wr_protect;
                assign sw_onwrite_value = field_value | sw_wr_data;
            end
            else if (SW_ONWRITE_TYPE == `WOT) begin: g_ONWRITE_WOT
                if (SWMOD) begin: g_SWMOD
                    assign swmod_wr = sw_wr & (|sw_wr_data);
                end

                assign onwrite_modify = sw_wr & ~sw_wr_protect;
                assign sw_onwrite_value = field_value ^ sw_wr_data;
            end
            else if (SW_ONWRITE_TYPE == `WZS) begin: g_ONWRITE_WZS
                if (SWMOD) begin: g_SWMOD
                    assign swmod_wr = sw_wr & (|((~field_value) & (~sw_wr_data)));
                end

                assign onwrite_modify = sw_wr & ~sw_wr_protect;
                assign sw_onwrite_value = field_value | (~sw_wr_data);
            end
            else if (SW_ONWRITE_TYPE == `WZC) begin: g_ONWRITE_WZC
                if (SWMOD) begin: g_SWMOD
                    assign swmod_wr = sw_wr & (|(field_value & ~sw_wr_data));
                end

                assign onwrite_modify = sw_wr & ~sw_wr_protect;
                assign sw_onwrite_value = field_value & sw_wr_data;
            end
            else if (SW_ONWRITE_TYPE == `WZT) begin: g_ONWRITE_WZT
                if (SWMOD) begin: g_SWMOD
                    assign swmod_wr = sw_wr & (|(~sw_wr_data));
                end

                assign onwrite_modify = sw_wr & ~sw_wr_protect;
                assign sw_onwrite_value = field_value ^~ sw_wr_data;
            end
            else if (PULSE) begin: g_PULSE
                if (SWMOD) begin: g_SWMOD
                    assign swmod_wr = sw_wr & (|(field_value ^ sw_wr_data));
                end

                logic                        return_to_zero;
                always_ff @(posedge clk or negedge rst_n) begin
                    if (!rst_n)
                        return_to_zero <= 1'b0;
                    else if (sync_rst)
                        return_to_zero <= 1'b0;
                    else
                        return_to_zero <= sw_wr & |sw_wr_data & ~sw_wr_protect;
                end

                assign onwrite_modify = (sw_wr & ~sw_wr_protect) | return_to_zero;
                assign sw_onwrite_value = sw_wr_data & ~field_value;
            end
            else if (SW_ONWRITE_TYPE == `NA) begin: g_ONWRITE_NA
                if (SWMOD) begin: g_SWMOD
                    assign swmod_wr = sw_wr & (|(field_value ^ sw_wr_data));
                end

                assign onwrite_modify = sw_wr & ~sw_wr_protect;
                assign sw_onwrite_value = sw_wr_data;
            end
            else begin:g_SW_ONWRITE_unknown
                // synopsys translate_off
                initial begin
                    $display("unknown software onwrite type %d", SW_ONWRITE_TYPE);
                    $finish;
                end
                // synopsys translate_on
            end
        end
        else if (SW_TYPE == `SW_RO) begin: g_SW_NW
            if (SWMOD) begin: g_SWMOD
                assign swmod_wr = 1'b0;
            end

            assign onwrite_modify = 1'b0;
            assign sw_onwrite_value = {F_WIDTH{1'b0}};
        end
        else begin: g_SW_W_unknown
            // synopsys translate_off
            initial begin
                $display("unknown software access type %d", SW_TYPE);
                $finish;
            end
            // synopsys translate_on
        end
    endgenerate

    generate
        if (SWMOD)
            assign swmod_out = swmod_rd | swmod_wr;
        else
            assign swmod_out = 1'b0;

        if (SWACC) begin
            assign swacc_rd_out = sw_rd;
            assign swacc_wr_out = sw_wr;
        end
        else begin
            assign swacc_rd_out = 1'b0;
            assign swacc_wr_out = 1'b0;
        end

    endgenerate

    assign sw_mux_din = {sw_onread_value, sw_onwrite_value};
    assign sw_mux_sel = {onread_modify, onwrite_modify};

    priority_mux #(.WIDTH (F_WIDTH), .CNT (2))
    sw_mux (
        .din            (sw_mux_din),
        .sel            (sw_mux_sel),
        .dout           (nxt_sw_value));

    assign sw_modify = onread_modify | onwrite_modify;
endmodule
`default_nettype wire
