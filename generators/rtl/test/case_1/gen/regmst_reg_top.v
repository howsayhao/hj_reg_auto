`include "xregister.vh"
module regmst_reg_top(
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
	PSEL,
	PENABLE,
	PREADY,
	PWRITE,
	PSLVERR,
	PADDR,
	PWDATA,
	PRDATA,
	cdc_pulse_out,
	interrupt,
	clear,
	global_sync_reset_out
);
//**********************************PARAMETER Definition START Here***********************************//
parameter ADDR_WIDTH = 64;
parameter DATA_WIDTH = 32;
//N:number of internal registers, M:number of external modules
localparam N = 0;
localparam M = 3;
localparam REG_NUM = N ? N :1;
localparam EXT_NUM = M ? M :1;
//***********************************PARAMETER Definition END Here************************************//


//***************************************WIRE DECLARATION START***************************************//
input clk;
input rstn;
input PSEL;
input PENABLE;
output PREADY;
input PWRITE;
output PSLVERR;
input [ADDR_WIDTH-1:0] PADDR;
input [DATA_WIDTH-1:0] PWDATA;
output [DATA_WIDTH-1:0] PRDATA;
output global_sync_reset_out;
input clear;
output interrupt;
//declare the syn_rst
//declare the portwidth of external module
output [EXT_NUM-1:0] ext_req_vld;
input [EXT_NUM-1:0] ext_req_rdy;
output ext_wr_en;
output ext_rd_en;
output [ADDR_WIDTH-1:0] ext_addr;
output [DATA_WIDTH-1:0] ext_wr_data;
input [EXT_NUM-1:0] [DATA_WIDTH-1:0] ext_rd_data;
input [EXT_NUM-1:0] ext_ack_vld;
output ext_ack_rdy;
output cdc_pulse_out;
//**************************INTERNAL REGISTER IN/OUT PORTS DEFINE START Here**************************//
//***************************INTERNAL REGISTER IN/OUT PORTS DEFINE END Here***************************//

//declare the portwidth of external registers
logic [EXT_NUM-1:0] ext_sel;
wire external_reg_selected;
assign external_reg_selected = |ext_sel;
wire [DATA_WIDTH-1:0] ext_rd_data_vld;
wire ext_reg_ack_vld;
wire[EXT_NUM-1:0] ext_ack;
//declare the portwidth of internal registers
logic [REG_NUM-1:0] reg_sel;
logic dummy_reg;
wire internal_reg_selected;
assign internal_reg_selected = (|reg_sel) | dummy_reg;
wire [REG_NUM-1:0] [DATA_WIDTH-1:0] reg_rd_data_in;
wire [DATA_WIDTH-1:0] internal_reg_rd_data_vld;
wire internal_reg_ack_vld;
//declare the control signal for external registers
wire fsm__slv__wr_en;
wire fsm__slv__rd_en;
wire [ADDR_WIDTH-1:0] fsm__slv__addr;
wire [DATA_WIDTH-1:0] fsm__slv__wr_data;
wire [DATA_WIDTH-1:0] slv__fsm__rd_data;
//declare the handshake signal for fsm
wire slv__fsm__ack_vld;
wire fsm__slv__req_vld;
wire slv__fsm__req_rdy;
assign slv__fsm__req_rdy = |{ext_req_rdy&ext_sel,internal_reg_selected};
//declare the control signal for internal registers
wire req_rdy;
wire [ADDR_WIDTH-1:0] addr_for_decode;
assign addr_for_decode = fsm__slv__addr;// req_rdy = 1 : fsm_state in S_SETUP for internal operation
wire [DATA_WIDTH-1:0] internal_wr_data;
assign internal_wr_data = fsm__slv__wr_data;
wire internal_wr_en;
assign internal_wr_en = fsm__slv__wr_en;
wire internal_rd_en;
assign internal_rd_en = fsm__slv__rd_en;
wire [REG_NUM-1:0] wr_sel_ff;
wire [REG_NUM-1:0] rd_sel_ff;
assign wr_sel_ff = {REG_NUM{internal_wr_en}} & reg_sel;
assign rd_sel_ff = {REG_NUM{internal_rd_en}} & reg_sel;
//****************************************WIRE DECLARATION END****************************************//


//*********************************EXTERNAL CONNECTION INSTANT START**********************************//
assign ext_wr_en = fsm__slv__wr_en;
assign ext_rd_en = fsm__slv__rd_en;
assign ext_addr = fsm__slv__addr;
assign ext_wr_data = fsm__slv__wr_data;
//reg_block_1 connection, external[0];
assign ext_req_vld[0] = ext_sel[0] & fsm__slv__req_vld;
assign ext_ack[0] = ext_ack_vld[0] & ext_sel[0];
//reg_block_2 connection, external[1];
assign ext_req_vld[1] = ext_sel[1] & fsm__slv__req_vld;
assign ext_ack[1] = ext_ack_vld[1] & ext_sel[1];
//ext_mem_in_top connection, external[2];
assign ext_req_vld[2] = ext_sel[2] & fsm__slv__req_vld;
assign ext_ack[2] = ext_ack_vld[2] & ext_sel[2];
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
assign slv__fsm__rd_data = dummy_reg ? {DATA_WIDTH{1'b0}} : (ext_reg_ack_vld ? ext_rd_data_vld : 0);
assign slv__fsm__ack_vld = dummy_reg | ext_reg_ack_vld;
//**************************Final Split Mux OUT Signal Definitinon END Here***************************//


//***************************internal register operation wire declare START***************************//
//****************************internal register operation wire declare END****************************//


//************************************Address Decoding START Here*************************************//
always_comb begin
		reg_sel = {REG_NUM{1'b0}};
		ext_sel = {EXT_NUM{1'b0}};
		dummy_reg = 1'b0;
	unique case (addr_for_decode)
		64'h0,64'h4,64'h8,64'hc,64'h10,64'h14,64'h18,64'h1c,64'h20,64'h24,64'h28,64'h2c,64'h100,64'h104,64'h108,64'h10c,64'h110,64'h114,64'h118,64'h11c,64'h120,64'h124,64'h128,64'h12c,64'h130,64'h134,64'h138,64'h13c,64'h140,64'h144,64'h148,64'h14c,64'h150,64'h154,64'h158,64'h15c,64'h160,64'h164,64'h168,64'h16c,64'h170,64'h174,64'h178,64'h17c,64'h180,64'h184,64'h188,64'h18c,64'h190,64'h194,64'h198,64'h19c,64'h1a0,64'h1a4,64'h1a8,64'h1ac,64'h1b0,64'h1b4,64'h1b8,64'h1bc,64'h1c0,64'h1c4,64'h1c8,64'h1cc,64'h1d0,64'h1d4,64'h1d8,64'h1dc,64'h1e0,64'h1e4,64'h1e8,64'h1ec,64'h1f0,64'h1f4,64'h1f8,64'h1fc:ext_sel[0] = 1'b1;//external module reg_block_1
		64'h400,64'h404,64'h408,64'h40c,64'h410,64'h414,64'h418,64'h41c,64'h420,64'h424,64'h428,64'h42c,64'h500,64'h504,64'h508,64'h50c,64'h510,64'h514,64'h518,64'h51c,64'h520,64'h524,64'h528,64'h52c,64'h530,64'h534,64'h538,64'h53c,64'h540,64'h544,64'h548,64'h54c,64'h550,64'h554,64'h558,64'h55c,64'h560,64'h564,64'h568,64'h56c,64'h570,64'h574,64'h578,64'h57c,64'h580,64'h584,64'h588,64'h58c,64'h590,64'h594,64'h598,64'h59c,64'h5a0,64'h5a4,64'h5a8,64'h5ac,64'h5b0,64'h5b4,64'h5b8,64'h5bc,64'h5c0,64'h5c4,64'h5c8,64'h5cc,64'h5d0,64'h5d4,64'h5d8,64'h5dc,64'h5e0,64'h5e4,64'h5e8,64'h5ec,64'h5f0,64'h5f4,64'h5f8,64'h5fc,64'h600,64'h604,64'h608,64'h60c,64'h610,64'h614,64'h618,64'h61c,64'h620,64'h624,64'h628,64'h62c,64'h630,64'h634,64'h638,64'h63c,64'h640,64'h644,64'h648,64'h64c,64'h650,64'h654,64'h658,64'h65c,64'h660,64'h664,64'h668,64'h66c,64'h670,64'h674,64'h678,64'h67c,64'h680,64'h684,64'h688,64'h68c,64'h690,64'h694,64'h698,64'h69c,64'h6a0,64'h6a4,64'h6a8,64'h6ac,64'h6b0,64'h6b4,64'h6b8,64'h6bc,64'h6c0,64'h6c4,64'h6c8,64'h6cc,64'h6d0,64'h6d4,64'h6d8,64'h6dc,64'h6e0,64'h6e4,64'h6e8,64'h6ec,64'h6f0,64'h6f4,64'h6f8,64'h6fc,64'h700,64'h704,64'h708,64'h70c,64'h710,64'h714,64'h718,64'h71c,64'h720,64'h724,64'h728,64'h72c,64'h730,64'h734,64'h738,64'h73c,64'h740,64'h744,64'h748,64'h74c,64'h750,64'h754,64'h758,64'h75c,64'h760,64'h764,64'h768,64'h76c,64'h770,64'h774,64'h778,64'h77c,64'h780,64'h784,64'h788,64'h78c,64'h790,64'h794,64'h798,64'h79c,64'h7a0,64'h7a4,64'h7a8,64'h7ac,64'h7b0,64'h7b4,64'h7b8,64'h7bc,64'h7c0,64'h7c4,64'h7c8,64'h7cc,64'h7d0,64'h7d4,64'h7d8,64'h7dc,64'h7e0,64'h7e4,64'h7e8,64'h7ec,64'h7f0,64'h7f4,64'h7f8,64'h7fc:ext_sel[1] = 1'b1;//external module reg_block_2
		64'h800,64'h804,64'h808,64'h80c,64'h810,64'h814,64'h818,64'h81c,64'h820,64'h824,64'h828,64'h82c,64'h830,64'h834,64'h838,64'h83c,64'h840,64'h844,64'h848,64'h84c,64'h850,64'h854,64'h858,64'h85c,64'h860,64'h864,64'h868,64'h86c,64'h870,64'h874,64'h878,64'h87c,64'h880,64'h884,64'h888,64'h88c,64'h890,64'h894,64'h898,64'h89c,64'h8a0,64'h8a4,64'h8a8,64'h8ac,64'h8b0,64'h8b4,64'h8b8,64'h8bc,64'h8c0,64'h8c4,64'h8c8,64'h8cc,64'h8d0,64'h8d4,64'h8d8,64'h8dc,64'h8e0,64'h8e4,64'h8e8,64'h8ec,64'h8f0,64'h8f4,64'h8f8,64'h8fc:ext_sel[2] = 1'b1;//external module ext_mem_in_top
		default: dummy_reg = 1'b1;
	endcase
end
//*************************************Address Decoding END Here**************************************//


//************************************STATE MACHINE INSTANCE START************************************//
mst_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
	mst_fsm_reg_top (
	.clk(clk), .rstn(rstn), .fsm__slv__req_vld(fsm__slv__req_vld),
	.PADDR(PADDR), .PWRITE(PWRITE), .PSEL(PSEL), .PENABLE(PENABLE),
	.PWDATA(PWDATA), .PRDATA(PRDATA), .PREADY(PREADY), .PSLVERR(PSLVERR),
	.slv__fsm__rd_data(slv__fsm__rd_data), .slv__fsm__ack_vld(slv__fsm__ack_vld),
	.fsm__slv__wr_en(fsm__slv__wr_en), .fsm__slv__rd_en(fsm__slv__rd_en), .fsm__slv__addr(fsm__slv__addr), .fsm__slv__wr_data(fsm__slv__wr_data),
	.fsm__mst__req_rdy(req_rdy),
	.slv__fsm__req_rdy(slv__fsm__req_rdy), .fsm__slv__ack_rdy(ext_ack_rdy),
	.external_reg_selected(external_reg_selected),
	.cdc_pulse_out(cdc_pulse_out),	.fsm__slv__sync_reset(global_sync_reset_out),
	.clear(clear), .interrupt(interrupt)
	);
//*************************************STATE MACHINE INSTANCE END*************************************//


//*******************************Register&field Instantiate START Here********************************//
//********************************Register&field Instantiate END Here*********************************//
endmodule