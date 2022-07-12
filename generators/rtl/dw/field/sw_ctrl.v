`include "field_attr.vh"

module sw_ctrl (field_value,
		sw_wr, sw_rd, sw_wr_data, sw_type_alter_signal,
                nxt_sw_value, sw_modify,swmod_out,swacc_out,reset_modify);

   parameter F_WIDTH = 4;
   parameter SW_CNT  = 1;
   parameter [3:0] SW_TYPE = `SW_RW;
   parameter [3:0] SW_ONREAD_TYPE = `NA;
   parameter [3:0] SW_ONWRITE_TYPE = `NA;
   parameter SWMOD = 0;
   parameter SWACC = 0;
   parameter PULSE = 0;

   input logic [F_WIDTH-1:0]          field_value;
   input logic [F_WIDTH*SW_CNT-1:0]   sw_wr_data;
   input logic [SW_CNT-1:0] 	      sw_wr, sw_rd;
   input logic 			      sw_type_alter_signal;

   output logic [F_WIDTH-1:0] 	      nxt_sw_value;
   output logic 		      sw_modify;
   output logic               swmod_out;
   output logic               swacc_out;
   output logic               reset_modify;

   logic modified;

   logic onread_modify;
   logic onwrite_modify;

   logic [F_WIDTH-1:0] 		      sw_onread_value;
   logic [F_WIDTH-1:0] 		      sw_onwrite_value;
   logic [F_WIDTH*2-1:0]         sw_mux_din;
   logic [2-1:0]                 sw_mux_sel;
   logic [F_WIDTH-1:0] 		      sw_mux_value;

   generate
      if (SWMOD) begin:g_SWMOD
        assign swmod_out = sw_modify;
      end else begin
         assign swmod_out = 1'b0;
      end

      if (SWACC) begin:g_SWACC
        assign swacc_out = (|sw_rd) | (|sw_wr);
      end else begin
         assign swacc_out = 1'b0;
      end
   endgenerate

   generate
      if(SW_TYPE == `SW_RW1 || SW_TYPE == `SW_W1)begin: g_has_reset_modified_once_limitation
         assign reset_modify = sw_modify;
      end
      else begin: g_has_no_reset_modified_once_limitation
         assign reset_modify = 1'b0;
      end
   endgenerate

// if field is readable it will have a onreadtype module
   generate
      if (SW_TYPE == `SW_RO || SW_TYPE == `SW_RW || SW_TYPE == `SW_RW1) begin: g_SW_R
         if(SW_ONREAD_TYPE == `RCLR)begin: g_ONREAD_RCLR
            assign onread_modify = |sw_rd;
            assign sw_onread_value = {F_WIDTH{1'b0}};
         end
         else if(SW_ONREAD_TYPE == `RSET)begin: g_ONREAD_RSET
            assign onread_modify = |sw_rd;
            assign sw_onread_value = {F_WIDTH{1'b1}};
         end
         else if(SW_ONREAD_TYPE == `NA)begin:  g_ONREAD_NA
             assign onread_modify = 1'b0;
             assign sw_onread_value = field_value;
         end
         else begin:g_SW_ONREAD_unknown
// synopsys translate_off
            initial begin
                     $display("%m:Unknown SW_ONREAD_TYPE %d", SW_TYPE);
                     $finish;
                  end
// synopsys translate_on
         end
      end
      else if(SW_TYPE == `SW_WO || SW_TYPE == `SW_W1)begin: g_SW_NR//no readable
         assign onread_modify = 1'b0;
         assign sw_onread_value = {F_WIDTH{1'b0}};
      end
      else begin:g_SW_R_unknown
// synopsys translate_off
        initial begin
                $display("%m:Unknown SW_TYPE %d", SW_TYPE);
                $finish;
            end
// synopsys translate_on
      end
   endgenerate

// if field is writable it will have a onwritetype module
   generate
      if (SW_TYPE == `SW_WO || SW_TYPE == `SW_RW || SW_TYPE == `SW_RW1 || SW_TYPE == `SW_W1) begin: g_SW_W
         if(SW_ONWRITE_TYPE == `WOCLR)begin: g_ONWRITE_WOCLR
            assign onwrite_modify = |sw_wr;
            priority_mux #(.WIDTH(F_WIDTH), .CNT (SW_CNT)) sw_mux_onwrite
            (.din (sw_wr_data),
                .sel (sw_wr),
                .dout (sw_mux_value));
            assign sw_onwrite_value = field_value & (~sw_mux_value);
         end
         else if(SW_ONWRITE_TYPE == `WOSET)begin: g_ONWRITE_WOSET
            assign onwrite_modify = |sw_wr;
            priority_mux #(.WIDTH(F_WIDTH), .CNT (SW_CNT)) sw_mux_onwrite
            (.din (sw_wr_data),
                .sel (sw_wr),
                .dout (sw_mux_value));
            assign sw_onwrite_value = field_value | sw_mux_value;
         end
         else if(SW_ONWRITE_TYPE == `WOT)begin: g_ONWRITE_WOT
            assign onwrite_modify = |sw_wr;
            priority_mux #(.WIDTH(F_WIDTH), .CNT (SW_CNT)) sw_mux_onwrite
            (.din (sw_wr_data),
                .sel (sw_wr),
                .dout (sw_mux_value));
            assign sw_onwrite_value = field_value ^ sw_mux_value;
         end
         else if(SW_ONWRITE_TYPE == `WZS)begin: g_ONWRITE_WZS
            assign onwrite_modify = |sw_wr;
            priority_mux #(.WIDTH(F_WIDTH), .CNT (SW_CNT)) sw_mux_onwrite
            (.din (sw_wr_data),
                .sel (sw_wr),
                .dout (sw_mux_value));
            assign sw_onwrite_value = field_value | (~sw_mux_value);
         end
         else if(SW_ONWRITE_TYPE == `WZC)begin: g_ONWRITE_WZC
            assign onwrite_modify = |sw_wr;
            priority_mux #(.WIDTH(F_WIDTH), .CNT (SW_CNT)) sw_mux_onwrite
            (.din (sw_wr_data),
                .sel (sw_wr),
                .dout (sw_mux_value));
            assign sw_onwrite_value = field_value & sw_mux_value;
         end
         else if(SW_ONWRITE_TYPE == `WZT)begin: g_ONWRITE_WZT
            assign onwrite_modify = |sw_wr;
            priority_mux #(.WIDTH(F_WIDTH), .CNT (SW_CNT)) sw_mux_onwrite
            (.din (sw_wr_data),
                .sel (sw_wr),
                .dout (sw_mux_value));
            assign sw_onwrite_value = field_value ^ (~sw_mux_value);
         end
         else if(PULSE) begin:g_PULSE
            // when a operation is requested or one of the the last field_value is asserted, the pulse will be generated
            assign onwrite_modify = (|sw_wr) | (|field_value);
            priority_mux #(.WIDTH(F_WIDTH), .CNT (SW_CNT)) sw_mux
            (.din (sw_wr_data),
                .sel (sw_wr),
                .dout (sw_mux_value));
            // ~field value to let previous asserted bit turn zero
            assign sw_onwrite_value = sw_mux_value & ~(field_value);
         end
         else if(SW_ONWRITE_TYPE == `NA) begin: g_ONWRITE_NA
            assign onwrite_modify = |sw_wr;
            priority_mux #(.WIDTH(F_WIDTH), .CNT (SW_CNT)) sw_mux
            (.din (sw_wr_data),
                .sel (sw_wr),
                .dout (sw_mux_value));
            assign sw_onwrite_value = sw_mux_value;
         end
         else begin:g_SW_ONWRITE_unknown
// synopsys translate_off
               initial begin
                        $display("%m:Unknown SW_ONWRITE_TYPE %d", SW_TYPE);
                        $finish;
                     end
// synopsys translate_on
         end
      end
      else if(SW_TYPE == `SW_RO)begin: g_SW_RO//no writable
         assign onwrite_modify = 1'b0;
         assign sw_onwrite_value = {F_WIDTH{1'b0}};
      end
      else begin:g_SW_W_unknown
// synopsys translate_off
        initial begin
                $display("%m:Unknown SW_TYPE %d", SW_TYPE);
                $finish;
            end
// synopsys translate_on
      end
   endgenerate

// onread/onwrite selector
   assign sw_mux_din = {sw_onread_value,sw_onwrite_value};
   assign sw_mux_sel = {onread_modify,onwrite_modify};

   priority_mux #(.WIDTH (F_WIDTH), .CNT (2))
     sw_mux (.din (sw_mux_din),
                .sel (sw_mux_sel),
                .dout (nxt_sw_value));
   assign sw_modify = onread_modify | onwrite_modify;

endmodule
