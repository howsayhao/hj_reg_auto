`include "xregister.vh"

module hw_ctrl (hw_pulse, hw_value,
                field_value,
                nxt_hw_value, hw_modify);

   parameter F_WIDTH       = 4;
   parameter HW_TYPE       = `HW_RW;
   parameter OVERFLOW_LOCK = 1;

   input logic [F_WIDTH-1:0] hw_value;
   input logic               hw_pulse;
   input logic [F_WIDTH-1:0] field_value;

   output logic [F_WIDTH-1:0] nxt_hw_value;
   output logic               hw_modify;

   generate
      if (HW_TYPE == `HW_CLR) begin:g_HW_CLR
         assign nxt_hw_value = field_value & (~hw_value);
         assign hw_modify    = |hw_value;
      end
      else if (HW_TYPE == `HW_SET) begin:g_HW_SET
         assign nxt_hw_value = field_value | hw_value;
         assign hw_modify    = |hw_value;
      end
      else if (HW_TYPE == `HW_RO) begin:g_HW_RO
         assign nxt_hw_value = {F_WIDTH{1'b0}};
         assign hw_modify    = 1'b0;
      end
      else if (HW_TYPE == `HW_RW) begin:g_HW_RW
         assign nxt_hw_value = hw_value;
         assign hw_modify    = hw_pulse;
      end
      else begin:g_unknown
// synopsys translate_off
         initial begin
            $display("%m:Unknown HW_TYPE:%d",HW_TYPE);
            $finish;
         end
// synopsys translate_on
      end
   endgenerate

endmodule