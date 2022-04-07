`include "xregister.vh"
module regmst_regmst_test(
//*******************************EXTERNAL module connection port START********************************//
	ext_req_vld,
	ext_req_rdy,
	ext_wr_en,ext_rd_en,
	ext_addr,
	ext_wr_data,
	ext_ack_vld,
	ext_ack_rdy,
	ext_rd_data,
//********************************EXTERNAL module connection port END*********************************//
//********************************INTERNAL field connection port START********************************//
//*********************************INTERNAL field connection port END*********************************//
	clk,
	rstn,
	req_vld,
	req_rdy,
	wr_en,rd_en,
	addr,
	wr_data,
	global_sync_reset_out,
	interrupt,
	clear,
	ack_vld,
	ack_rdy,
	rd_data
);
//**********************************PARAMETER Definition START Here***********************************//
parameter ADDR_WIDTH = 64;
parameter DATA_WIDTH = 32;
//N:number of internal registers, M:number of external modules
localparam N = 0;
localparam M = 1;
localparam REG_NUM = N ? N :1;
localparam EXT_NUM = M ? M :1;
//***********************************PARAMETER Definition END Here************************************//


//***************************************WIRE DECLARATION START***************************************//
input clk;
input rstn;
input req_vld;
output req_rdy;
input wr_en;
input rd_en;
input [ADDR_WIDTH-1:0] addr;
input [DATA_WIDTH-1:0] wr_data;
output [DATA_WIDTH-1:0] rd_data;
input global_sync_reset_in;
output global_sync_reset_out;
output ack_vld;
input ack_rdy;
//declare the syn_rst
//declare the portwidth of external module
output [EXT_NUM-1:0] ext_req_vld;
input ext_req_rdy;
output ext_wr_en;
output ext_rd_en;
output [ADDR_WIDTH-1:0] ext_addr;
output [DATA_WIDTH-1:0] ext_wr_data;
input [EXT_NUM-1:0] [DATA_WIDTH-1:0] ext_rd_data;
input [EXT_NUM-1:0] ext_ack_vld;
output ext_ack_rdy;
logic [EXT_NUM-1:0] ext_sel;
wire external;
assign external = |ext_sel;
wire [DATA_WIDTH-1:0] ext_rd_data_vld;
//declare the portwidth of internal registers
wire [REG_NUM-1:0] [DATA_WIDTH-1:0] reg_rd_data_in;
wire [DATA_WIDTH-1:0] reg_rd_data_vld;
logic [REG_NUM-1:0] reg_sel;
wire internal;
logic dummy_reg;
assign internal = (|reg_sel) | dummy_reg;
wire wr_en_ff;
wire rd_en_ff;
wire [ADDR_WIDTH-1:0] addr_decode;
wire [DATA_WIDTH-1:0] wr_data_ff;
wire [REG_NUM-1:0] wr_sel_ff;
wire [REG_NUM-1:0] rd_sel_ff;
assign wr_sel_ff = {REG_NUM{wr_en_ff}} & reg_sel;
assign rd_sel_ff = {REG_NUM{rd_en_ff}} & reg_sel;
wire [DATA_WIDTH-1:0] rd_data_vld_in;
wire ack_vld_in;
wire ext_reg_ack_vld;
wire ext_ack_rdy;
wire[EXT_NUM-1:0] ext_ack_vld;
wire[EXT_NUM-1:0] ext_ack;
wire[EXT_NUM-1:0] ext_req_rdy;
wire req_vld_s;
//****************************************WIRE DECLARATION END****************************************//


//***************************internal register operation wire declare START***************************//
//****************************internal register operation wire declare END****************************//


//************************************Address Decoding START Here*************************************//
always_comb begin
		reg_sel = {REG_NUM{1'b0}};
		ext_sel = {EXT_NUM{1'b0}};
		dummy_reg = 1'b0;
	unique case (addr)
		64'h0,64'h4,64'h8,64'hc,64'h10,64'h14,64'h100,64'h104,64'h108,64'h10c,64'h200,64'h204,64'h208,64'h20c,64'h210,64'h214,64'h218,64'h21c,64'h220,64'h224,64'h228,64'h22c,64'h230,64'h234,64'h238,64'h23c,64'h240,64'h244,64'h248,64'h24c,64'h250,64'h254,64'h258,64'h25c,64'h260,64'h264,64'h268,64'h26c,64'h270,64'h274,64'h278,64'h27c,64'h280,64'h284,64'h288,64'h28c,64'h290,64'h294,64'h298,64'h29c,64'h2a0,64'h2a4,64'h2a8,64'h2ac,64'h2b0,64'h2b4,64'h2b8,64'h2bc,64'h2c0,64'h2c4,64'h2c8,64'h2cc,64'h2d0,64'h2d4,64'h2d8,64'h2dc,64'h2e0,64'h2e4,64'h2e8,64'h2ec,64'h2f0,64'h2f4,64'h2f8,64'h2fc,64'h300,64'h304,64'h308,64'h30c,64'h310,64'h314,64'h318,64'h31c,64'h320,64'h324,64'h328,64'h32c,64'h330,64'h334,64'h338,64'h33c,64'h340,64'h344,64'h348,64'h34c,64'h350,64'h354,64'h358,64'h35c,64'h360,64'h364,64'h368,64'h36c,64'h370,64'h374,64'h378,64'h37c,64'h380,64'h384,64'h388,64'h38c,64'h390,64'h394,64'h398,64'h39c,64'h3a0,64'h3a4,64'h3a8,64'h3ac,64'h3b0,64'h3b4,64'h3b8,64'h3bc,64'h3c0,64'h3c4,64'h3c8,64'h3cc,64'h3d0,64'h3d4,64'h3d8,64'h3dc,64'h3e0,64'h3e4,64'h3e8,64'h3ec,64'h3f0,64'h3f4,64'h3f8,64'h3fc,64'h400,64'h404,64'h408,64'h40c,64'h410,64'h414,64'h418,64'h41c,64'h420,64'h424,64'h428,64'h42c,64'h430,64'h434,64'h438,64'h43c,64'h440,64'h444,64'h448,64'h44c,64'h450,64'h454,64'h458,64'h45c,64'h460,64'h464,64'h468,64'h46c,64'h470,64'h474,64'h478,64'h47c,64'h480,64'h484,64'h488,64'h48c,64'h490,64'h494,64'h498,64'h49c,64'h4a0,64'h4a4,64'h4a8,64'h4ac,64'h4b0,64'h4b4,64'h4b8,64'h4bc,64'h4c0,64'h4c4,64'h4c8,64'h4cc,64'h4d0,64'h4d4,64'h4d8,64'h4dc,64'h4e0,64'h4e4,64'h4e8,64'h4ec,64'h4f0,64'h4f4,64'h4f8,64'h4fc:ext_sel[0] = 1'b1;//external module regslv_test_inst
		default: dummy_reg = 1'b1;
	endcase
end
//*************************************Address Decoding END Here**************************************//


//************************************STATE MACHINE INSTANCE START************************************//
mst_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH), .M(M))
	mst_fsmregmst_test (
	.clk(clk), .rstn(rstn), .req_vld(req_vld), .wr_en(wr_en), .rd_en(rd_en), .addr(addr), .wr_data(wr_data),
	.rd_data_vld_in(rd_data_vld_in), .ack_vld_in(ack_vld_in),
	.wr_en_ff(wr_en_ff), .rd_en_ff(rd_en_ff), .addr_ff(addr_ff), .wr_data_ff(wr_data_ff),
	.req_rdy_m(req_rdy), .ack_rdy_m(ack_rdy),
	.req_rdy_s(ext_req_rdy), .ack_rdy_s(ext_ack_rdy),
	.rd_data(rd_data), .ack_vld(ack_vld),
	.global_sync_reset(global_sync_reset),
	.slv_sel(ext_sel), .slv_sel_ff(ext_sel_ff),
	.dummy_reg(dummy_reg), .dummy_reg_ff(dummy_reg_ff),
	.clear(clear), .interrupt(interrupt)
	);
//*************************************STATE MACHINE INSTANCE END*************************************//


//*******************************Register&field Instantiate START Here********************************//
//********************************Register&field Instantiate END Here*********************************//


//*********************************EXTERNAL CONNECTION INSTANT START**********************************//
assign ext_wr_en = wr_en_ff;
assign ext_rd_en = rd_en_ff;
assign ext_addr = addr_decode;
assign ext_wr_data = wr_data_ff;
//regslv_test_inst connection, external[0];
assign ext_req_vld[0] = ext_sel[0] & req_vld_s;
assign ext_ack[0] = ext_ack_vld[0] & ext_sel[0];
//**********************************EXTERNAL CONNECTION INSTANT END***********************************//




//********************************Rd_data/Ack_vld Split Mux START Here********************************//
split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(M), .GROUP_SIZE(64)) ext_rd_split_mux
(.clk(clk), .rst_n(rstn),
.din(ext_rd_data), .sel(ext_ack),
.dout(ext_rd_data_vld), .dout_vld(ext_reg_ack_vld)
);
//*********************************Rd_data/Ack_vld Split Mux END Here*********************************//


//*************************Final Split Mux OUT Signal Definitinon START Here**************************//
// select which to read out and transfer the corresponding vld signal
assign rd_data_vld_in = dummy_reg ? {DATA_WIDTH{1'b0}} : (ext_reg_ack_vld ? ext_rd_data_vld : 0);
assign ack_vld_in = dummy_reg |ext_reg_ack_vld;
//**************************Final Split Mux OUT Signal Definitinon END Here***************************//
endmodule