// - \insertfigure{Field block diagram}{field}{fig:field}

`include "xregister.vh"

module field (clk, rst_n,

              // synchronous reset is not mandatory
              // It can be float because it is not used internally
              sync_rst,

              // When asserted, write protect is ON,
              // field can't be written by software
              write_protect_en,

              sw_wr, sw_rd, sw_wr_data,
              sw_type_alter_signal,

              hw_pulse, hw_value,

              field_value,

              // Fields' output defined by access property
              swmod_out,swacc_out);

   parameter F_WIDTH       = 4;
   parameter ALIAS_NUM     = 1; //Alias Register number
   parameter SRST_CNT      = 1;
   parameter PRECEDENCE    = `SW;

   parameter [3:0] SW_TYPE[ALIAS_NUM-1:0]       = '{ALIAS_NUM{`SW_RW}};
   parameter [3:0] SW_ONREAD_TYPE[ALIAS_NUM-1:0]       = '{ALIAS_NUM{`NA}};
   parameter [3:0] SW_ONWRITE_TYPE[ALIAS_NUM-1:0]       = '{ALIAS_NUM{`NA}};
   parameter HW_TYPE       = `HW_RO;

   parameter SWMOD[ALIAS_NUM-1:0]       = '{ALIAS_NUM{0}};
   parameter SWACC[ALIAS_NUM-1:0]       = '{ALIAS_NUM{0}};
   parameter PULSE[ALIAS_NUM-1:0]       = '{ALIAS_NUM{0}};


   parameter SRST_WIDTH    = SRST_CNT ? SRST_CNT : 1;
   parameter OVERFLOW_LOCK = 0;

   parameter [F_WIDTH-1:0] ARST_VALUE = {F_WIDTH{1'b0}};
   parameter [F_WIDTH-1:0] SRST_VALUE  = ARST_VALUE;



   input [ALIAS_NUM-1:0] [F_WIDTH-1:0] sw_wr_data;
   input [ALIAS_NUM-1:0]         sw_rd, sw_wr;
   input                      sw_type_alter_signal;
   input [F_WIDTH-1:0]        hw_value;
   input                      hw_pulse;
   output [F_WIDTH-1:0]       field_value;
   input                      clk, rst_n;
   input                      write_protect_en;
   input [SRST_WIDTH-1:0]     sync_rst;

   output logic               swmod_out;
   output logic               swacc_out;

   logic [ALIAS_NUM-1:0] [F_WIDTH-1:0] sw_wr_data;
   logic [ALIAS_NUM-1:0]         sw_rd, sw_wr;
   logic                      sw_type_alter_signal;
   logic [F_WIDTH-1:0]        hw_value;
   logic                      hw_pulse;
   logic [F_WIDTH-1:0]        field_value;
   logic                      clk, rst_n;
   logic [SRST_WIDTH-1:0]     sync_rst;

   logic [ALIAS_NUM-1:0]         swmod_out_pre, swacc_out_pre;

   logic                       hw_modify;
   logic                       sw_modify;
   logic [ALIAS_NUM-1:0]       sw_modify_pre;
   logic                       reset_modify;
   logic [ALIAS_NUM-1:0]       reset_modify_pre;

   logic [F_WIDTH-1:0]         nxt_hw_value,
                               nxt_sw_value,
                               nxt_field_value;
   logic [ALIAS_NUM-1:0] [F_WIDTH-1:0] nxt_sw_value_pre;

   logic [F_WIDTH*2-1:0]      field_mux_din_pre;
   logic [2-1:0]              field_mux_sel_pre;
   logic [F_WIDTH*(2+SRST_CNT)-1:0] field_mux_din;
   logic [(2+SRST_CNT)-1:0]         field_mux_sel;

   // flag to show if SW = RW1 or W1, and they have been modified once
   logic flag;


   wire [F_WIDTH-1:0]               sync_rst_value, async_rst_value;
   assign sync_rst_value  = SRST_VALUE; // For TB force
   assign async_rst_value = ARST_VALUE; // For TB force


   genvar i;
   generate
      for(i=0; i < ALIAS_NUM; i = i + 1)begin: SW_CTRL_GENERATE
         // - * SW control Instance number as Alias number
         sw_ctrl #(.F_WIDTH (F_WIDTH), .SW_CNT (1), .SW_TYPE (SW_TYPE[i]),
                .SW_ONREAD_TYPE(SW_ONREAD_TYPE[i]),.SW_ONWRITE_TYPE(SW_ONWRITE_TYPE[i]),
                .SWMOD(SWMOD[i]),.SWACC(SWACC[i]),.PULSE(PULSE[i])) sw_ctrl_i
         (.sw_wr (sw_wr[i]),
         .sw_rd (sw_rd[i]),
         .sw_wr_data (sw_wr_data[i]),
         .sw_type_alter_signal (sw_type_alter_signal),
         .field_value (field_value),
         .nxt_sw_value (nxt_sw_value_pre[i]),
         .sw_modify (sw_modify_pre[i]),
         .swmod_out (swmod_out_pre[i]),
         .swacc_out (swacc_out_pre[i]),
         .reset_modify(reset_modify_pre[i]));
         end
   endgenerate


   // - * Hardware control
   hw_ctrl #(.F_WIDTH (F_WIDTH), .HW_TYPE (HW_TYPE), .OVERFLOW_LOCK (OVERFLOW_LOCK)) hw_ctrl
     (.hw_pulse (hw_pulse),
      .hw_value (hw_value),
      .field_value (field_value),
      .nxt_hw_value (nxt_hw_value),
      .hw_modify (hw_modify));

   // generate sw value seletor
   // reset_modify to show when field is rw1 or w1 and they have been modified once
   assign reset_modify = |reset_modify_pre;
   generate
      if(ALIAS_NUM >1)begin: g_sw_ctrl_mux
         priority_mux_2d #(.WIDTH (F_WIDTH), .CNT (ALIAS_NUM))
         sw_mux (.din (nxt_sw_value_pre),
                     .sel (sw_modify_pre),
                     .dout (nxt_sw_value));
         assign sw_modify = (| sw_modify_pre) & ~flag;
      end
      else begin: g_sw_ctrl_single
         assign nxt_sw_value = nxt_sw_value_pre;
         assign sw_modify = sw_modify_pre & ~flag;
      end
   endgenerate

   // - * Ultimate mux
   generate
      if (PRECEDENCE == `SW) begin: g_fmux_sw_dominant
         // For ROC hw_ctrl should update value based on cleared value
         assign field_mux_din_pre = {nxt_hw_value, nxt_sw_value};
         assign field_mux_sel_pre = {hw_modify, sw_modify};
      end
      else begin: g_fmux_hw_dominant
         assign field_mux_din_pre = {nxt_sw_value, nxt_hw_value};
         assign field_mux_sel_pre = {sw_modify & ~write_protect_en, hw_modify};
      end
   endgenerate

   generate
      if (SRST_CNT == 0) begin: g_no_sync_reset
         assign field_mux_din = field_mux_din_pre;
         assign field_mux_sel = field_mux_sel_pre;
      end
      else begin: g_has_sync_reset
         assign field_mux_din = {field_mux_din_pre, {SRST_CNT{sync_rst_value}}};
         assign field_mux_sel = {field_mux_sel_pre, sync_rst};
      end
   endgenerate

   priority_mux #(.WIDTH (F_WIDTH), .CNT (2+SRST_CNT))
     field_mux (.din (field_mux_din),
                .sel (field_mux_sel),
                .dout (nxt_field_value));

   // - *DFF
   wire         field_value_modify;
   assign field_value_modify = |field_mux_sel;

   always_ff @(posedge clk or negedge rst_n)
     if (!rst_n)
       field_value <= async_rst_value;
     else if (field_value_modify)
       field_value <= nxt_field_value;
     else
       field_value <= field_value;

   // swmod/swacc/singpulse genrated by software
   always_ff @(posedge clk or negedge rst_n)
      if(!rst_n)begin
       swmod_out <= 1'b0;
       swacc_out <= 1'b0;

      end
      else begin
       swmod_out <= |swmod_out_pre;
       swacc_out <= |swacc_out_pre;
      end

   // flag to show if SW = RW1 and W1 and they have been modified once
   always_ff @(posedge clk or negedge rst_n)
      if(!rst_n)
       flag <= 1'b0;
      else if(reset_modify)
       flag <= 1'b1;
      else
       flag <= flag;

endmodule
