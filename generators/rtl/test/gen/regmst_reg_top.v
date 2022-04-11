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
		64'h0,64'h4,64'h8,64'hc,64'h10,64'h14,64'h100,64'h104,64'h108,64'h10c,64'h200,64'h204,64'h208,64'h20c,64'h210,64'h214,64'h218,64'h21c,64'h220,64'h224,64'h228,64'h22c,64'h230,64'h234,64'h238,64'h23c,64'h240,64'h244,64'h248,64'h24c,64'h250,64'h254,64'h258,64'h25c,64'h260,64'h264,64'h268,64'h26c,64'h270,64'h274,64'h278,64'h27c,64'h280,64'h284,64'h288,64'h28c,64'h290,64'h294,64'h298,64'h29c,64'h2a0,64'h2a4,64'h2a8,64'h2ac,64'h2b0,64'h2b4,64'h2b8,64'h2bc,64'h2c0,64'h2c4,64'h2c8,64'h2cc,64'h2d0,64'h2d4,64'h2d8,64'h2dc,64'h2e0,64'h2e4,64'h2e8,64'h2ec,64'h2f0,64'h2f4,64'h2f8,64'h2fc:ext_sel[0] = 1'b1;//external module reg_block_1
		64'h800,64'h804,64'h808,64'h80c,64'h810,64'h814,64'h900,64'h904,64'h908,64'h90c,64'ha00,64'ha04,64'ha08,64'ha0c,64'ha10,64'ha14,64'ha18,64'ha1c,64'ha20,64'ha24,64'ha28,64'ha2c,64'ha30,64'ha34,64'ha38,64'ha3c,64'ha40,64'ha44,64'ha48,64'ha4c,64'ha50,64'ha54,64'ha58,64'ha5c,64'ha60,64'ha64,64'ha68,64'ha6c,64'ha70,64'ha74,64'ha78,64'ha7c,64'ha80,64'ha84,64'ha88,64'ha8c,64'ha90,64'ha94,64'ha98,64'ha9c,64'haa0,64'haa4,64'haa8,64'haac,64'hab0,64'hab4,64'hab8,64'habc,64'hac0,64'hac4,64'hac8,64'hacc,64'had0,64'had4,64'had8,64'hadc,64'hae0,64'hae4,64'hae8,64'haec,64'haf0,64'haf4,64'haf8,64'hafc,64'hb00,64'hb04,64'hb08,64'hb0c,64'hb10,64'hb14,64'hb18,64'hb1c,64'hb20,64'hb24,64'hb28,64'hb2c,64'hb30,64'hb34,64'hb38,64'hb3c,64'hb40,64'hb44,64'hb48,64'hb4c,64'hb50,64'hb54,64'hb58,64'hb5c,64'hb60,64'hb64,64'hb68,64'hb6c,64'hb70,64'hb74,64'hb78,64'hb7c,64'hb80,64'hb84,64'hb88,64'hb8c,64'hb90,64'hb94,64'hb98,64'hb9c,64'hba0,64'hba4,64'hba8,64'hbac,64'hbb0,64'hbb4,64'hbb8,64'hbbc,64'hbc0,64'hbc4,64'hbc8,64'hbcc,64'hbd0,64'hbd4,64'hbd8,64'hbdc,64'hbe0,64'hbe4,64'hbe8,64'hbec,64'hbf0,64'hbf4,64'hbf8,64'hbfc,64'hc00,64'hc04,64'hc08,64'hc0c,64'hc10,64'hc14,64'hc18,64'hc1c,64'hc20,64'hc24,64'hc28,64'hc2c,64'hc30,64'hc34,64'hc38,64'hc3c,64'hc40,64'hc44,64'hc48,64'hc4c,64'hc50,64'hc54,64'hc58,64'hc5c,64'hc60,64'hc64,64'hc68,64'hc6c,64'hc70,64'hc74,64'hc78,64'hc7c,64'hc80,64'hc84,64'hc88,64'hc8c,64'hc90,64'hc94,64'hc98,64'hc9c,64'hca0,64'hca4,64'hca8,64'hcac,64'hcb0,64'hcb4,64'hcb8,64'hcbc,64'hcc0,64'hcc4,64'hcc8,64'hccc,64'hcd0,64'hcd4,64'hcd8,64'hcdc,64'hce0,64'hce4,64'hce8,64'hcec,64'hcf0,64'hcf4,64'hcf8,64'hcfc:ext_sel[1] = 1'b1;//external module reg_block_2
		64'hd00,64'hd04,64'hd08,64'hd0c,64'hd10,64'hd14,64'hd18,64'hd1c,64'hd20,64'hd24,64'hd28,64'hd2c,64'hd30,64'hd34,64'hd38,64'hd3c,64'hd40,64'hd44,64'hd48,64'hd4c,64'hd50,64'hd54,64'hd58,64'hd5c,64'hd60,64'hd64,64'hd68,64'hd6c,64'hd70,64'hd74,64'hd78,64'hd7c,64'hd80,64'hd84,64'hd88,64'hd8c,64'hd90,64'hd94,64'hd98,64'hd9c,64'hda0,64'hda4,64'hda8,64'hdac,64'hdb0,64'hdb4,64'hdb8,64'hdbc,64'hdc0,64'hdc4,64'hdc8,64'hdcc,64'hdd0,64'hdd4,64'hdd8,64'hddc,64'hde0,64'hde4,64'hde8,64'hdec,64'hdf0,64'hdf4,64'hdf8,64'hdfc:ext_sel[2] = 1'b1;//external module ext_mem_in_top
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
	.fsm__slv__sync_reset(global_sync_reset_out),
	.clear(clear), .interrupt(interrupt)
	);
//*************************************STATE MACHINE INSTANCE END*************************************//


//*******************************Register&field Instantiate START Here********************************//
//********************************Register&field Instantiate END Here*********************************//
endmodule