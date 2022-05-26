`include "xregister.vh"

module snapshot_reg_mem     (// upstream control signal
                             clk,
                             rst_n,
                             mst__fsm__sync_reset,
                             addr,
                             wr_en,
                             rd_en,
                             wr_data,
                             rd_data,
                             // upstream handshake
                             req_vld,
                             ack_vld,
                             // other signals
                             entry_write_protect_en,
                             entry_vld,
                             entry_vld_nxt,
                             // downstram(memory) control signal
                             mem_addr,
                             mem_wr_en,
                             mem_rd_en,
                             mem_wr_data,
                             mem_rd_data,
                             // downstream(memory) handshake
                             mem_req_vld,
                             mem_ack_vld);

   `include "common_funcs.vh"

   parameter DATA_WIDTH       = 32;
   parameter MEM_WIDTH        = 36;
   parameter PARTITION_CNT    = MEM_WIDTH / DATA_WIDTH + (MEM_WIDTH % DATA_WIDTH ? 1 : 0);
   parameter ADDR_WIDTH       = 7;
   parameter VALID_WIDTH      = 7;
   parameter ENTRY_WIDTH      = 7;
   parameter SUB              = 0;
   parameter BASE             = 0;
   parameter RST_VALUE        = {MEM_WIDTH{1'b0}};


   localparam REM_WIDTH       = MEM_WIDTH % DATA_WIDTH;
   localparam PAD_WIDTH       = DATA_WIDTH - REM_WIDTH;

   localparam BYTE_WIDTH = 8;
   localparam RESERVERD_BITS     = log2(MEM_WIDTH)-log2(BYTE_WIDTH);

   localparam IDLE     = 7'b0000001;
   localparam SNAPSHOT = 7'b0000010;
   localparam OP_DATA  = 7'b0000100;
   localparam _IDLE_     = 0;
   localparam _SNAPSHOT_   = 1;
   localparam _OP_DATA_ = 2;


   input [ADDR_WIDTH-1:0] addr;
   input [DATA_WIDTH-1:0]       wr_data;
   output [DATA_WIDTH-1:0]      rd_data;
   input                      req_vld;
   output                     ack_vld;
   input                      wr_en,rd_en;
   input                      entry_write_protect_en;
   input                      entry_vld;
   output                     entry_vld_nxt;

   output [ENTRY_WIDTH-1:0]     mem_addr;
   output                      mem_rd_en, mem_wr_en;
   input [MEM_WIDTH-1:0]         mem_rd_data;
   output [MEM_WIDTH-1:0]        mem_wr_data;

   input mst__fsm__sync_reset;

   output mem_req_vld;
   input mem_ack_vld;
   input clk, rst_n;

   wire [PARTITION_CNT-1:0] snap_rd, snap_wr;

   reg [PARTITION_CNT-1:0] snap_wr_ff, snap_rd_ff;
   reg [ADDR_WIDTH-1:0]    addr_ff;

   wire [ADDR_WIDTH-1:0]  valid_addr;
   reg  [VALID_WIDTH-1:0]  valid_addr_ff;

   reg [6:0]               sw_ctrl_cs, sw_ctrl_ns;

   reg                     entry_vld_nxt;
   reg [DATA_WIDTH-1:0]       wr_data_ff;
   wire [MEM_WIDTH-1:0]      mem_wr_data;

   wire [MEM_WIDTH-1:0]      mem_rd_data_int;

   reg [MEM_WIDTH-1:0]       snapshot_ff;

   reg                               entry_vld_ff;
   wire                              mem_access;

   wire                    snap_rd_vld;
   wire                    snap_wr_vld;

   reg                     mem_ack_vld_ff;


   assign valid_addr = SUB ? addr - BASE : addr;


   always @(posedge clk or negedge rst_n)
     if(!rst_n) mem_ack_vld_ff <= 0;
     else mem_ack_vld_ff <= mem_ack_vld;

   always @(posedge clk or negedge rst_n)
     if (!rst_n) begin
        snap_rd_ff      <= {PARTITION_CNT{1'b0}};
        snap_wr_ff      <= {PARTITION_CNT{1'b0}};
        valid_addr_ff    <= {VALID_WIDTH{1'b0}};
     end
     else if (sw_ctrl_cs[_IDLE_] && !sw_ctrl_ns[_IDLE_]) begin
        snap_rd_ff      <= snap_rd;
        snap_wr_ff      <= snap_wr;
        valid_addr_ff    <= valid_addr[VALID_WIDTH-1:0];
     end
     else if (!sw_ctrl_cs[_IDLE_] && sw_ctrl_ns[_IDLE_]) begin
        snap_rd_ff      <= {PARTITION_CNT{1'b0}};
        snap_wr_ff      <= {PARTITION_CNT{1'b0}};
        valid_addr_ff    <= {VALID_WIDTH{1'b0}};
     end
     else begin
        snap_rd_ff      <= snap_rd_ff;
        snap_wr_ff      <= snap_wr_ff;
        valid_addr_ff    <= valid_addr_ff;
     end

   always @(posedge clk or negedge rst_n)
     if (!rst_n)
       entry_vld_ff <= 1'b0;
     else if (sw_ctrl_cs[_IDLE_] && !sw_ctrl_ns[_IDLE_])
       entry_vld_ff <= entry_vld;
     else if (!sw_ctrl_cs[_IDLE_] && sw_ctrl_ns[_IDLE_])
       entry_vld_ff <= 1'b0;
     else
       entry_vld_ff <= entry_vld_ff;

   // read/write to lowest partion triggers memory access
   assign mem_access = snap_rd[0] | snap_wr[0];
   // make 1 cycle delay for locking data from reading memory
   assign snap_rd_vld = snap_rd_ff[0] ? mem_ack_vld_ff : sw_ctrl_cs[_OP_DATA_] & rd_en;
   assign snap_wr_vld = snap_wr_ff[0] ? mem_ack_vld | entry_write_protect_en : sw_ctrl_cs[_OP_DATA_] & wr_en;

   assign ack_vld = snap_rd_vld | snap_wr_vld;

   assign mem_req_vld = sw_ctrl_cs[_SNAPSHOT_];


   genvar i;
   generate
      for (i=0; i<PARTITION_CNT; i=i+1) begin: g_operation_decoder
        assign snap_wr[i] = addr[RESERVERD_BITS-1:0] == i * (DATA_WIDTH / BYTE_WIDTH) ? wr_en : 1'b0;
        assign snap_rd[i] = addr[RESERVERD_BITS-1:0] == i * (DATA_WIDTH / BYTE_WIDTH) ? rd_en : 1'b0;
      end
   endgenerate


   // Snapshot register
   generate
      for (i=0; i<PARTITION_CNT; i=i+1)
        if ((i == PARTITION_CNT-1) && (REM_WIDTH != 0))
          always @(posedge clk or negedge rst_n)
            if (!rst_n)
              snapshot_ff[i*DATA_WIDTH +: REM_WIDTH] <= {REM_WIDTH{1'b0}};
            else if (sw_ctrl_ns[_SNAPSHOT_] & rd_en)
              snapshot_ff[i*DATA_WIDTH +: REM_WIDTH] <= mem_rd_data_int[i*DATA_WIDTH +: REM_WIDTH];
	          else if (snap_wr[i])
              snapshot_ff[i*DATA_WIDTH +: REM_WIDTH] <= wr_data[0 +: REM_WIDTH];
            else
              snapshot_ff[i*DATA_WIDTH +: REM_WIDTH] <= snapshot_ff[i*DATA_WIDTH +: REM_WIDTH];
        else
          always @(posedge clk or negedge rst_n)
            if (!rst_n)
              snapshot_ff[i*DATA_WIDTH +: DATA_WIDTH] <= {DATA_WIDTH{1'b0}};
	          else if (sw_ctrl_ns[_SNAPSHOT_] & rd_en)
	            snapshot_ff[i*DATA_WIDTH +: DATA_WIDTH] <= mem_rd_data_int[i*DATA_WIDTH +: DATA_WIDTH];
            else if (snap_wr[i])
              snapshot_ff[i*DATA_WIDTH +: DATA_WIDTH] <= wr_data[0 +: DATA_WIDTH];
            else
              snapshot_ff[i*DATA_WIDTH +: DATA_WIDTH] <= snapshot_ff[i*DATA_WIDTH +: DATA_WIDTH];
   endgenerate

   wire [DATA_WIDTH*PARTITION_CNT-1:0] padded_snapshot;
   assign padded_snapshot = {{PAD_WIDTH{1'b0}}, snapshot_ff[MEM_WIDTH-1:0]};

   one_hot_mux #(.WIDTH (DATA_WIDTH), .CNT (PARTITION_CNT)) x_mux_rd_data
     (.din (padded_snapshot), .sel (snap_rd_ff),
      .dout (rd_data), .err ());


   always @(posedge clk or negedge rst_n)
     if (!rst_n)
       sw_ctrl_cs <= IDLE;
     else
       sw_ctrl_cs <= sw_ctrl_ns;

   always @(*)
     case (1'b1)
       mst__fsm__sync_reset:
          sw_ctrl_ns = IDLE;
       sw_ctrl_cs[_IDLE_]:
         if(req_vld)
             if (mem_access)
                sw_ctrl_ns = SNAPSHOT;
             else
                sw_ctrl_ns = OP_DATA;
         else
           sw_ctrl_ns = IDLE;
       sw_ctrl_cs[_SNAPSHOT_]:
         if(ack_vld)
           sw_ctrl_ns = IDLE;
         else sw_ctrl_ns = SNAPSHOT;
       sw_ctrl_cs[_OP_DATA_]:
           sw_ctrl_ns = IDLE;
       default:
         sw_ctrl_ns = IDLE;
     endcase // case (1'b1)



   assign mem_addr  = sw_ctrl_cs[_IDLE_] ? valid_addr[VALID_WIDTH-1:VALID_WIDTH-ENTRY_WIDTH] : valid_addr_ff[VALID_WIDTH-1:VALID_WIDTH-ENTRY_WIDTH];
   assign mem_rd_en = snap_rd_ff[0] & entry_vld & (sw_ctrl_cs[_IDLE_] & sw_ctrl_ns[_SNAPSHOT_] | sw_ctrl_cs[_SNAPSHOT_]);
   assign mem_wr_en = snap_wr_ff[0] & !entry_write_protect_en &
                         (sw_ctrl_cs[_IDLE_] & sw_ctrl_ns[_SNAPSHOT_] | sw_ctrl_cs[_SNAPSHOT_]);
   generate
      if (MEM_WIDTH > DATA_WIDTH)
        assign mem_wr_data = {snapshot_ff[MEM_WIDTH-1:DATA_WIDTH], wr_data[DATA_WIDTH-1:0]};
      else
        assign mem_wr_data = wr_data[MEM_WIDTH-1:0];
   endgenerate


   assign mem_rd_data_int[MEM_WIDTH-1:0] = entry_vld_ff ?
                                            mem_rd_data : RST_VALUE;

   assign entry_vld_nxt = 1'b1;

endmodule
