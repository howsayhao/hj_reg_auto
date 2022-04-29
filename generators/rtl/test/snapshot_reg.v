`include "xregister.vh"

module snapshot_reg         (// upstream control signal
                             snap_wr_en, snap_rd_data, 
                             snap_rd_en, snap_wr_data, 
                             // downstram(register) control signal
                             reg_rd_en, reg_rd_data, 
                             reg_wr_en, reg_wr_data, 
                             clk, rst_n);

   `include "common_funcs.vh"

   parameter DATA_WIDTH       = 32;
   parameter REG_WIDTH       = 36;
   parameter PARTITION_CNT = REG_WIDTH / DATA_WIDTH + (REG_WIDTH % DATA_WIDTH ? 1 : 0);
   parameter RST_VALUE     = {REG_WIDTH{1'b0}};


   localparam REM_WIDTH     = REG_WIDTH % DATA_WIDTH;
   localparam PAD_WIDTH     = DATA_WIDTH - REM_WIDTH;

   localparam BYTE_WIDTH = 8;
   localparam RESERVERD_BITS     = log2(REG_WIDTH)-log2(BYTE_WIDTH);
   

   input  [DATA_WIDTH*PARTITION_CNT-1:0]       snap_wr_data;
   output [PARTITION_CNT-1:0] [DATA_WIDTH-1:0]       snap_rd_data;
   input  [PARTITION_CNT-1:0]                        snap_wr_en,snap_rd_en;

   output                      reg_rd_en, reg_wr_en;
   input [REG_WIDTH-1:0]         reg_rd_data;
   output [REG_WIDTH-1:0]        reg_wr_data;
   
   input clk, rst_n;

   wire [REG_WIDTH-1:0]      reg_wr_data;

   wire [REG_WIDTH-1:0]      reg_rd_data;

   reg [REG_WIDTH-1:0]       snapshot_ff;


   // Snapshot register
   genvar i;
   generate
      for (i=0; i<PARTITION_CNT; i=i+1)
        if ((i == PARTITION_CNT-1) && (REM_WIDTH != 0))
          always @(posedge clk or negedge rst_n)
            if (!rst_n)
              snapshot_ff[i*DATA_WIDTH +: REM_WIDTH] <= {REM_WIDTH{1'b0}};
            else if (snap_rd_en[0])
              snapshot_ff[i*DATA_WIDTH +: REM_WIDTH] <= reg_rd_data[i*DATA_WIDTH +: REM_WIDTH];
	          else if (snap_wr_en[i])
              snapshot_ff[i*DATA_WIDTH +: REM_WIDTH] <= snap_wr_data[i*DATA_WIDTH +: REM_WIDTH];
            else
              snapshot_ff[i*DATA_WIDTH +: REM_WIDTH] <= snapshot_ff[i*DATA_WIDTH +: REM_WIDTH];
        else
          always @(posedge clk or negedge rst_n)
            if (!rst_n)
              snapshot_ff[i*DATA_WIDTH +: DATA_WIDTH] <= {DATA_WIDTH{1'b0}};
	          else if (snap_rd_en[0])
	            snapshot_ff[i*DATA_WIDTH +: DATA_WIDTH] <= reg_rd_data[i*DATA_WIDTH +: DATA_WIDTH];
            else if (snap_wr_en[i])
              snapshot_ff[i*DATA_WIDTH +: DATA_WIDTH] <= snap_wr_data[i*DATA_WIDTH +: DATA_WIDTH];
            else
              snapshot_ff[i*DATA_WIDTH +: DATA_WIDTH] <= snapshot_ff[i*DATA_WIDTH +: DATA_WIDTH];
   endgenerate

   wire [DATA_WIDTH*PARTITION_CNT-1:0] padded_snapshot;
   wire [DATA_WIDTH*PARTITION_CNT-1:0] padded_reg;

   assign padded_snapshot = {{PAD_WIDTH{1'b0}}, snapshot_ff[REG_WIDTH-1:0]};
   assign padded_reg = {{PAD_WIDTH{1'b0}}, reg_rd_data[REG_WIDTH-1:0]};

   assign snap_rd_data = snap_rd_en[0] ? padded_reg : padded_snapshot;
   
   assign reg_rd_en = snap_rd_en[0];
   assign reg_wr_en = snap_wr_en[0];

   generate
      if (REG_WIDTH > DATA_WIDTH)
        assign reg_wr_data = {snapshot_ff[REG_WIDTH-1:DATA_WIDTH], snap_wr_data[DATA_WIDTH-1:0]};
      else 
        assign reg_wr_data = snap_wr_data[REG_WIDTH-1:0];
   endgenerate

endmodule
