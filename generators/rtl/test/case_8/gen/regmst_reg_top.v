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
localparam M = 1;
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
		64'h0,64'h400,64'h410,64'h420,64'h430,64'h440,64'h450,64'h460,64'h470,64'h480,64'h490,64'h4a0,64'h4b0,64'h4c0,64'h4d0,64'h4e0,64'h4f0,64'h500,64'h510,64'h520,64'h530,64'h540,64'h550,64'h560,64'h570,64'h580,64'h590,64'h5a0,64'h5b0,64'h5c0,64'h5d0,64'h5e0,64'h5f0,64'h600,64'h610,64'h620,64'h630,64'h640,64'h650,64'h660,64'h670,64'h680,64'h690,64'h6a0,64'h6b0,64'h6c0,64'h6d0,64'h6e0,64'h6f0,64'h700,64'h710,64'h720,64'h730,64'h740,64'h750,64'h760,64'h770,64'h780,64'h790,64'h7a0,64'h7b0,64'h7c0,64'h7d0,64'h7e0,64'h7f0,64'h800,64'h810,64'h820,64'h830,64'h840,64'h850,64'h860,64'h870,64'h880,64'h890,64'h8a0,64'h8b0,64'h8c0,64'h8d0,64'h8e0,64'h8f0,64'h900,64'h910,64'h920,64'h930,64'h940,64'h950,64'h960,64'h970,64'h980,64'h990,64'h9a0,64'h9b0,64'h9c0,64'h9d0,64'h9e0,64'h9f0,64'ha00,64'ha10,64'ha20,64'ha30,64'ha40,64'ha50,64'ha60,64'ha70,64'ha80,64'ha90,64'haa0,64'hab0,64'hac0,64'had0,64'hae0,64'haf0,64'hb00,64'hb10,64'hb20,64'hb30,64'hb40,64'hb50,64'hb60,64'hb70,64'hb80,64'hb90,64'hba0,64'hbb0,64'hbc0,64'hbd0,64'hbe0,64'hbf0,64'hc00,64'hc10,64'hc20,64'hc30,64'hc40,64'hc50,64'hc60,64'hc70,64'hc80,64'hc90,64'hca0,64'hcb0,64'hcc0,64'hcd0,64'hce0,64'hcf0,64'hd00,64'hd10,64'hd20,64'hd30,64'hd40,64'hd50,64'hd60,64'hd70,64'hd80,64'hd90,64'hda0,64'hdb0,64'hdc0,64'hdd0,64'hde0,64'hdf0,64'he00,64'he10,64'he20,64'he30,64'he40,64'he50,64'he60,64'he70,64'he80,64'he90,64'hea0,64'heb0,64'hec0,64'hed0,64'hee0,64'hef0,64'hf00,64'hf10,64'hf20,64'hf30,64'hf40,64'hf50,64'hf60,64'hf70,64'hf80,64'hf90,64'hfa0,64'hfb0,64'hfc0,64'hfd0,64'hfe0,64'hff0,64'h1000,64'h1010,64'h1020,64'h1030,64'h1040,64'h1050,64'h1060,64'h1070,64'h1080,64'h1090,64'h10a0,64'h10b0,64'h10c0,64'h10d0,64'h10e0,64'h10f0,64'h1100,64'h1110,64'h1120,64'h1130,64'h1140,64'h1150,64'h1160,64'h1170,64'h1180,64'h1190,64'h11a0,64'h11b0,64'h11c0,64'h11d0,64'h11e0,64'h11f0,64'h1200,64'h1210,64'h1220,64'h1230,64'h1240,64'h1250,64'h1260,64'h1270,64'h1280,64'h1290,64'h12a0,64'h12b0,64'h12c0,64'h12d0,64'h12e0,64'h12f0,64'h1300,64'h1310,64'h1320,64'h1330,64'h1340,64'h1350,64'h1360,64'h1370,64'h1380,64'h1390,64'h13a0,64'h13b0,64'h13c0,64'h13d0,64'h13e0,64'h13f0:ext_sel[0] = 1'b1;//external module reg_block_1
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