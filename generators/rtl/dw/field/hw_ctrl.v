`default_nettype none
`include "field_attr.vh"

module hw_ctrl (
   hw_pulse, hw_value,
   field_value, nxt_hw_value, hw_modify
);

    parameter       F_WIDTH         = 1;
    parameter       HW_TYPE         = `HW_RW;
    parameter       HARD_WIRED      = 0;
    parameter       HARD_WIRED_VAL  = {F_WIDTH{1'b0}};

    input   logic   [F_WIDTH-1:0]   hw_value;
    input   logic                   hw_pulse;
    input   logic   [F_WIDTH-1:0]   field_value;
    output  logic   [F_WIDTH-1:0]   nxt_hw_value;
    output  logic                   hw_modify;

    generate
        if (HARD_WIRED) begin
            if (HW_TYPE == `HW_RO || HW_TYPE == `HW_NA) begin: g_hardwired_HW_RO_NA
                assign nxt_hw_value = HARD_WIRED_VAL;
                assign hw_modify    = 1'b0;
            end
            else if (HW_TYPE == `HW_WO || HW_TYPE == `HW_RW) begin: g_hardwired_HW_WO_RW
                assign nxt_hw_value = hw_value;
                assign hw_modify    = 1'b0;
            end
            else begin: g_hardwired_unknown
                // synopsys translate_off
                initial begin
                    $display("unknown hardware access type (hard-wired): %d", HW_TYPE);
                    $finish;
                end
                // synopsys translate_on
            end
        end
        else begin
            if (HW_TYPE == `HW_CLR) begin: g_HW_CLR
                assign nxt_hw_value = field_value & (~hw_value);
                assign hw_modify    = |hw_value;
            end
            else if (HW_TYPE == `HW_SET) begin: g_HW_SET
                assign nxt_hw_value = field_value | hw_value;
                assign hw_modify    = |hw_value;
            end
            else if (HW_TYPE == `HW_RO || HW_TYPE == `HW_NA) begin: g_HW_RO_NA
                assign nxt_hw_value = {F_WIDTH{1'b0}};
                assign hw_modify    = 1'b0;
            end
            else if (HW_TYPE == `HW_WO || HW_TYPE == `HW_RW) begin: g_HW_WO_RW
                assign nxt_hw_value = hw_value;
                assign hw_modify    = hw_pulse;
            end
            else begin: g_unknown
                // synopsys translate_off
                initial begin
                    $display("unknown hardware access type: %d", HW_TYPE);
                    $finish;
                end
                // synopsys translate_on
            end
        end
    endgenerate
endmodule
`default_nettype wire