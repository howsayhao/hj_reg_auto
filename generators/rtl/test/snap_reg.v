`include "xregister.vh"

module snap_reg             (sw_addr, 
                             sw_rd, sw_rd_data, 
                             sw_wr, sw_wr_data, 
                             req_vld,
                             ack_vld,
                             entry_write_protect_en, 
                             sw_modify, 
                             entry_vld, entry_vld_nxt, 
                             sw_mem_addr,
                             sw_mem_rd_en, sw_mem_rd_data, 
                             sw_mem_wr_en, sw_mem_wr_data, 
                             hw_mem_rd_en, hw_mem_wr_en, hw_mem_addr,
                             clk, rst_n);


   parameter W_WIDTH       = 32;
   parameter F_WIDTH       = 36;
   parameter PARTITION_CNT = F_WIDTH / W_WIDTH + (F_WIDTH % W_WIDTH ? 1 : 0);
   parameter ADDR_WIDTH    = 7;
   parameter RST_VALUE     = {F_WIDTH{1'b0}};

   parameter REM_WIDTH     = F_WIDTH % W_WIDTH;
   parameter PAD_WIDTH     = W_WIDTH - REM_WIDTH;

   localparam IDLE     = 7'b0000001;
   localparam RD_WT_HW = 7'b0000010;
   localparam RD_MEM   = 7'b0000100;
   localparam WR_WT_HW = 7'b0001000;
   localparam WR_MEM   = 7'b0010000;
   localparam SNAPSHOT = 7'b0100000;
   localparam RD_DATA  = 7'b1000000;
   localparam _IDLE_     = 0; 
   localparam _RD_WT_HW_ = 1; 
   localparam _RD_MEM_   = 2; 
   localparam _WR_WT_HW_ = 3; 
   localparam _WR_MEM_   = 4; 
   localparam _SNAPSHOT_ = 5; 
   localparam _RD_DATA_  = 6; 


   input [ADDR_WIDTH-1:0] sw_addr;
   input [PARTITION_CNT-1:0] sw_rd, sw_wr;
   input [W_WIDTH-1:0]       sw_wr_data;
   output [W_WIDTH-1:0]      sw_rd_data;
   input                     req_vld;
   output                    ack_vld;

   input                     entry_write_protect_en;
   input                     entry_vld;
   output                    entry_vld_nxt;

   input [ADDR_WIDTH-1:0]     hw_mem_addr;
   input                      hw_mem_rd_en, hw_mem_wr_en;

   output [ADDR_WIDTH-1:0]     sw_mem_addr;
   output                      sw_mem_rd_en, sw_mem_wr_en;
   input [F_WIDTH-1:0]         sw_mem_rd_data;
   output [F_WIDTH-1:0]        sw_mem_wr_data;
   
   input clk, rst_n;

   reg [PARTITION_CNT-1:0] sw_wr_ff, sw_rd_ff;
   reg [ADDR_WIDTH-1:0]    sw_addr_ff;

   reg [6:0]               sw_ctrl_cs, sw_ctrl_ns;
   
   reg                     entry_vld_nxt;
   reg [W_WIDTH-1:0]       sw_wr_data_ff;
   wire [F_WIDTH-1:0]      sw_mem_wr_data;

   wire [F_WIDTH-1:0]      sw_mem_rd_data_int;

   reg [F_WIDTH-1:0]       snapshot_ff;
   
   reg                               entry_vld_ff;
   wire                              mem_access;
   wire                              hw_ctrl_access_conflict;     
   
   wire                    sw_modify;
   wire                    sw_rd_vld;                     


   // read/write to lowest partion triggers memory access
   assign mem_access = sw_rd[0] | sw_wr[0];

   always @(posedge clk or negedge rst_n) 
     if (!rst_n) begin
        sw_rd_ff      <= {PARTITION_CNT{1'b0}};
        sw_addr_ff    <= {ADDR_WIDTH{1'b0}};
     end
     else if (sw_ctrl_cs[_IDLE_] && !sw_ctrl_ns[_IDLE_]) begin
        sw_rd_ff      <= sw_rd;
        sw_addr_ff    <= sw_addr;
     end
     else if (!sw_ctrl_cs[_IDLE_] && sw_ctrl_ns[_IDLE_]) begin
        sw_rd_ff      <= {PARTITION_CNT{1'b0}};
        sw_addr_ff    <= {ADDR_WIDTH{1'b0}};   
     end
     else begin
        sw_rd_ff      <= sw_rd_ff;
        sw_addr_ff    <= sw_addr_ff;
     end        

   always @(posedge clk or negedge rst_n)
     if (!rst_n)
       entry_vld_ff <= 1'b0;
     else if (!sw_ctrl_cs[_IDLE_] && sw_ctrl_ns[_IDLE_])
       entry_vld_ff <= 1'b0;
     else if (sw_ctrl_cs[_IDLE_] && !sw_ctrl_ns[_IDLE_])
       entry_vld_ff <= entry_vld;
     else
       entry_vld_ff <= entry_vld_ff;


   assign sw_modify = sw_mem_wr_en;
   assign sw_rd_vld = sw_ctrl_cs[_RD_DATA_];
   assign ack_vld = sw_rd_vld | sw_rd_vld;


   // Snapshot register
   genvar i;
   generate
      for (i=0; i<PARTITION_CNT; i=i+1)
        if ((i == PARTITION_CNT-1) && (REM_WIDTH != 0))
          always @(posedge clk or negedge rst_n)
            if (!rst_n)
              snapshot_ff[i*W_WIDTH +: REM_WIDTH] <= {REM_WIDTH{1'b0}};
            else if (sw_ctrl_cs[_SNAPSHOT_])
              snapshot_ff[i*W_WIDTH +: REM_WIDTH] <= sw_mem_rd_data_int[i*W_WIDTH +: REM_WIDTH];
	          else if (sw_wr[i])
              snapshot_ff[i*W_WIDTH +: REM_WIDTH] <= sw_wr_data[0 +: REM_WIDTH];
            else
              snapshot_ff[i*W_WIDTH +: REM_WIDTH] <= snapshot_ff[i*W_WIDTH +: REM_WIDTH];
        else
          always @(posedge clk or negedge rst_n)
            if (!rst_n)
              snapshot_ff[i*W_WIDTH +: W_WIDTH] <= {W_WIDTH{1'b0}};
	          else if (sw_ctrl_cs[_SNAPSHOT_])
	            snapshot_ff[i*W_WIDTH +: W_WIDTH] <= sw_mem_rd_data_int[i*W_WIDTH +: W_WIDTH];  
            else if (sw_wr[i])
              snapshot_ff[i*W_WIDTH +: W_WIDTH] <= sw_wr_data[0 +: W_WIDTH];
            else
              snapshot_ff[i*W_WIDTH +: W_WIDTH] <= snapshot_ff[i*W_WIDTH +: W_WIDTH];
   endgenerate

   wire [W_WIDTH*PARTITION_CNT-1:0] padded_snapshot;
   assign padded_snapshot = {{PAD_WIDTH{1'b0}}, snapshot_ff[F_WIDTH-1:0]};
   
   one_hot_mux #(.WIDTH (W_WIDTH), .CNT (PARTITION_CNT)) x_mux_sw_rd_data
     (.din (padded_snapshot), .sel (sw_rd_ff), 
      .dout (sw_rd_data), .err ());


   always @(posedge clk or negedge rst_n)
     if (!rst_n)
       sw_ctrl_cs <= IDLE;
     else
       sw_ctrl_cs <= sw_ctrl_ns;

   always @(*)
     case (1'b1)
       sw_ctrl_cs[_IDLE_]:
         if(req_vld)
           if (|sw_rd)
             if (mem_access)
                if (hw_ctrl_access_conflict)
                sw_ctrl_ns = RD_WT_HW;
                else 
                sw_ctrl_ns = SNAPSHOT;
             else 
                sw_ctrl_ns = RD_DATA;
           else
            sw_ctrl_ns = IDLE;
         else if(|sw_wr)
           if (mem_access)
                if (hw_ctrl_access_conflict)
                sw_ctrl_ns = WR_WT_HW;
                else 
                sw_ctrl_ns = SNAPSHOT;
             else 
                sw_ctrl_ns = WR_DATA;
           else
            sw_ctrl_ns = IDLE;
         else
           sw_ctrl_ns = IDLE;
       sw_ctrl_cs[_RD_WT_HW_]:
         if (hw_ctrl_access_conflict)
           sw_ctrl_ns = RD_WT_HW;
         else
           sw_ctrl_ns = SNAPSHOT;

       sw_ctrl_cs[_SNAPSHOT_]:
         sw_ctrl_ns = RD_DATA;

       sw_ctrl_cs[_RD_DATA_]:
         sw_ctrl_ns = IDLE;
       
       default:
         sw_ctrl_ns = IDLE;
     endcase // case (1'b1)
   
   

   assign sw_mem_addr  = sw_ctrl_cs[_IDLE_] ? sw_addr : sw_addr_ff; 
   assign sw_mem_rd_en = (sw_ctrl_cs[_IDLE_]     & sw_ctrl_ns[_SNAPSHOT_] & entry_vld) | 
                         (sw_ctrl_cs[_RD_WT_HW_] & sw_ctrl_ns[_SNAPSHOT_] & entry_vld_ff);
   assign sw_mem_wr_en =  !entry_write_protect_en & sw_wr[0];
   generate 
      if (F_WIDTH > W_WIDTH)
        assign sw_mem_wr_data = {snapshot_ff[F_WIDTH-1:W_WIDTH], sw_wr_data[W_WIDTH-1:0]};
      else 
        assign sw_mem_wr_data = sw_wr_data[F_WIDTH-1:0];
   endgenerate


   assign hw_ctrl_access_conflict = (hw_mem_wr_en | hw_mem_rd_en) &
                                    (hw_mem_addr == sw_addr);

   assign sw_mem_rd_data_int[F_WIDTH-1:0] = entry_vld_ff ?
                                            sw_mem_rd_data : RST_VALUE;

   assign entry_vld_nxt = 1'b1;

endmodule
