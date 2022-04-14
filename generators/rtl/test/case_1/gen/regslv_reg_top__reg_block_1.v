`include "xregister.vh"
module regslv_reg_top__reg_block_1(
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
//['test_12', 'REG1', 'FIELD_0']
	test_12_REG1__FIELD_0__next_value,
	test_12_REG1__FIELD_0__pulse,
	test_12_REG1__FIELD_0__curr_value,
//['test_12', 'REG2', 'FIELD_0']
	test_12_REG2__FIELD_0__next_value,
	test_12_REG2__FIELD_0__pulse,
	test_12_REG2__FIELD_0__curr_value,
//['test_12', 'REG3', 'FIELD_0']
	test_12_REG3__FIELD_0__next_value,
	test_12_REG3__FIELD_0__pulse,
	test_12_REG3__FIELD_0__curr_value,
//['test_12', 'REG4', 'FIELD_0']
	test_12_REG4__FIELD_0__next_value,
	test_12_REG4__FIELD_0__pulse,
	test_12_REG4__FIELD_0__curr_value,
//['test_13', 'REG1', 'FIELD_0']
	test_13_REG1__FIELD_0__next_value,
	test_13_REG1__FIELD_0__pulse,
	test_13_REG1__FIELD_0__curr_value,
//['test_13', 'REG2', 'FIELD_0']
	test_13_REG2__FIELD_0__next_value,
	test_13_REG2__FIELD_0__pulse,
	test_13_REG2__FIELD_0__curr_value,
//['test_13', 'REG3', 'FIELD_0']
	test_13_REG3__FIELD_0__next_value,
	test_13_REG3__FIELD_0__pulse,
	test_13_REG3__FIELD_0__curr_value,
//['test_13', 'REG4', 'FIELD_0']
	test_13_REG4__FIELD_0__next_value,
	test_13_REG4__FIELD_0__pulse,
	test_13_REG4__FIELD_0__curr_value,
//*********************************INTERNAL field connection port END*********************************//
	clk,
	rstn,
	req_vld,
	req_rdy,
	wr_en,rd_en,
	addr,
	wr_data,
	ack_vld,
	ack_rdy,
	rd_data,
	cdc_pulse_out,
	global_sync_reset_in,
	global_sync_reset_out
);
//**********************************PARAMETER Definition START Here***********************************//
parameter ADDR_WIDTH = 64;
parameter DATA_WIDTH = 32;
//N:number of internal registers, M:number of external modules
localparam N = 8;
localparam M = 2;
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
//['test_12', 'REG1', 'FIELD_0']
input [32-1:0] test_12_REG1__FIELD_0__next_value;
input test_12_REG1__FIELD_0__pulse;
output [32-1:0] test_12_REG1__FIELD_0__curr_value;
//['test_12', 'REG2', 'FIELD_0']
input [32-1:0] test_12_REG2__FIELD_0__next_value;
input test_12_REG2__FIELD_0__pulse;
output [32-1:0] test_12_REG2__FIELD_0__curr_value;
//['test_12', 'REG3', 'FIELD_0']
input [32-1:0] test_12_REG3__FIELD_0__next_value;
input test_12_REG3__FIELD_0__pulse;
output [32-1:0] test_12_REG3__FIELD_0__curr_value;
//['test_12', 'REG4', 'FIELD_0']
input [32-1:0] test_12_REG4__FIELD_0__next_value;
input test_12_REG4__FIELD_0__pulse;
output [32-1:0] test_12_REG4__FIELD_0__curr_value;
//['test_13', 'REG1', 'FIELD_0']
input [32-1:0] test_13_REG1__FIELD_0__next_value;
input test_13_REG1__FIELD_0__pulse;
output [32-1:0] test_13_REG1__FIELD_0__curr_value;
//['test_13', 'REG2', 'FIELD_0']
input [32-1:0] test_13_REG2__FIELD_0__next_value;
input test_13_REG2__FIELD_0__pulse;
output [32-1:0] test_13_REG2__FIELD_0__curr_value;
//['test_13', 'REG3', 'FIELD_0']
input [32-1:0] test_13_REG3__FIELD_0__next_value;
input test_13_REG3__FIELD_0__pulse;
output [32-1:0] test_13_REG3__FIELD_0__curr_value;
//['test_13', 'REG4', 'FIELD_0']
input [32-1:0] test_13_REG4__FIELD_0__next_value;
input test_13_REG4__FIELD_0__pulse;
output [32-1:0] test_13_REG4__FIELD_0__curr_value;
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
wire [ADDR_WIDTH-1:0] addr_for_decode;
assign addr_for_decode = fsm__slv__addr;
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
//test_11 connection, external[0];
assign ext_req_vld[0] = ext_sel[0] & fsm__slv__req_vld;
assign ext_ack[0] = ext_ack_vld[0] & ext_sel[0];
//ext_mem_11 connection, external[1];
assign ext_req_vld[1] = ext_sel[1] & fsm__slv__req_vld;
assign ext_ack[1] = ext_ack_vld[1] & ext_sel[1];
//**********************************EXTERNAL CONNECTION INSTANT END***********************************//


//********************************Rd_data/Ack_vld Split Mux START Here********************************//
split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(N+1), .GROUP_SIZE(64)) rd_split_mux
(.clk(clk), .rst_n(rstn),
.din({reg_rd_data_in,{DATA_WIDTH{1'b0}}}), .sel({rd_sel_ff, !req_rdy & dummy_reg}),
.dout(internal_reg_rd_data_vld), .dout_vld(internal_reg_ack_vld)
);
split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(M), .GROUP_SIZE(64)) ext_rd_split_mux
(.clk(clk), .rst_n(rstn),
.din(ext_rd_data), .sel(ext_ack),
.dout(ext_rd_data_vld), .dout_vld(ext_reg_ack_vld)
);
//*********************************Rd_data/Ack_vld Split Mux END Here*********************************//


//*************************Final Split Mux OUT Signal Definitinon START Here**************************//
// select which to read out and transfer the corresponding vld signal
assign slv__fsm__rd_data = internal_reg_ack_vld ? internal_reg_rd_data_vld : (ext_reg_ack_vld ? ext_rd_data_vld : 0);
assign slv__fsm__ack_vld = internal_reg_ack_vld | ext_reg_ack_vld | (internal_wr_en & internal_reg_selected);
//**************************Final Split Mux OUT Signal Definitinon END Here***************************//


//***************************internal register operation wire declare START***************************//
logic [31:0] test_12_REG1_wr_data;
logic [31:0] test_12_REG2_wr_data;
logic [31:0] test_12_REG3_wr_data;
logic [31:0] test_12_REG4_wr_data;
logic [31:0] test_13_REG1_wr_data;
logic [31:0] test_13_REG2_wr_data;
logic [31:0] test_13_REG3_wr_data;
logic [31:0] test_13_REG4_wr_data;
//****************************internal register operation wire declare END****************************//


//************************************Address Decoding START Here*************************************//
always_comb begin
		reg_sel = {REG_NUM{1'b0}};
		ext_sel = {EXT_NUM{1'b0}};
		dummy_reg = 1'b0;
	unique case (addr_for_decode)
		64'h10:reg_sel[0] = 1'b1;//['test_12', 'REG1']
		64'h14:reg_sel[1] = 1'b1;//['test_12', 'REG2']
		64'h18:reg_sel[2] = 1'b1;//['test_12', 'REG3']
		64'h1c:reg_sel[3] = 1'b1;//['test_12', 'REG4']
		64'h20:reg_sel[4] = 1'b1;//['test_13', 'REG1']
		64'h24:reg_sel[5] = 1'b1;//['test_13', 'REG2']
		64'h28:reg_sel[6] = 1'b1;//['test_13', 'REG3']
		64'h2c:reg_sel[7] = 1'b1;//['test_13', 'REG4']
		64'h0,64'h4,64'h8,64'hc:ext_sel[0] = 1'b1;//external module test_11
		64'h100,64'h104,64'h108,64'h10c,64'h110,64'h114,64'h118,64'h11c,64'h120,64'h124,64'h128,64'h12c,64'h130,64'h134,64'h138,64'h13c,64'h140,64'h144,64'h148,64'h14c,64'h150,64'h154,64'h158,64'h15c,64'h160,64'h164,64'h168,64'h16c,64'h170,64'h174,64'h178,64'h17c,64'h180,64'h184,64'h188,64'h18c,64'h190,64'h194,64'h198,64'h19c,64'h1a0,64'h1a4,64'h1a8,64'h1ac,64'h1b0,64'h1b4,64'h1b8,64'h1bc,64'h1c0,64'h1c4,64'h1c8,64'h1cc,64'h1d0,64'h1d4,64'h1d8,64'h1dc,64'h1e0,64'h1e4,64'h1e8,64'h1ec,64'h1f0,64'h1f4,64'h1f8,64'h1fc:ext_sel[1] = 1'b1;//external module ext_mem_11
		default: dummy_reg = 1'b1;
	endcase
end
//*************************************Address Decoding END Here**************************************//


//************************************STATE MACHINE INSTANCE START************************************//
slv_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
	slv_fsm_reg_top__reg_block_1 (
	.clk(clk), .rstn(rstn), .mst__fsm__req_vld(req_vld), .mst__fsm__wr_en(wr_en), .mst__fsm__rd_en(rd_en), .mst__fsm__addr(addr), .mst__fsm__wr_data(wr_data),
	.slv__fsm__rd_data(slv__fsm__rd_data), .slv__fsm__ack_vld(slv__fsm__ack_vld), .fsm__slv__req_vld(fsm__slv__req_vld),
	.fsm__slv__wr_en(fsm__slv__wr_en), .fsm__slv__rd_en(fsm__slv__rd_en), .fsm__slv__addr(fsm__slv__addr), .fsm__slv__wr_data(fsm__slv__wr_data),
	.fsm__mst__req_rdy(req_rdy), .mst__fsm__ack_rdy(ack_rdy),
	.slv__fsm__req_rdy(slv__fsm__req_rdy), .fsm__slv__ack_rdy(ext_ack_rdy),
	.fsm__mst__rd_data(rd_data), .fsm__mst__ack_vld(ack_vld),
	.external_reg_selected(external_reg_selected),
	.cdc_pulse_out(cdc_pulse_out),	.mst__fsm__sync_reset(global_sync_reset_in),
	.fsm__slv__sync_reset(global_sync_reset_out)
	);
//*************************************STATE MACHINE INSTANCE END*************************************//


//*******************************Register&field Instantiate START Here********************************//
//============================================REG INSTANT=============================================//
//REG NAME: test_12_REG1//
//REG HIERARCHY: ['test_12', 'REG1']//
//REG ABSOLUTE_ADDR:64'h10//
//REG OFFSET_ADDR:64'h64'h0//
logic [31:0] test_12_REG1;
assign test_12_REG1_wr_data = reg_sel[0] && internal_wr_en ? internal_wr_data : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(32),
	.ARST_VALUE(32'h0),
	.SW_TYPE({`SW_RW}),
	.SW_ONREAD_TYPE({`NA}),
	.SW_ONWRITE_TYPE({`NA}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_12_REG1__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_12_REG1_wr_data[31:0]),
	.sw_rd(rd_sel_ff[0]),
	.sw_wr(wr_sel_ff[0]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_12_REG1__FIELD_0__next_value),
	.hw_pulse(test_12_REG1__FIELD_0__pulse),
	.field_value(test_12_REG1__FIELD_0__curr_value)
	);
always_comb begin
	test_12_REG1[31:0] = 32'h0;
	test_12_REG1[31:0] = test_12_REG1__FIELD_0__curr_value;
end
assign reg_rd_data_in[0] = test_12_REG1;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_12_REG2//
//REG HIERARCHY: ['test_12', 'REG2']//
//REG ABSOLUTE_ADDR:64'h14//
//REG OFFSET_ADDR:64'h64'h4//
logic [31:0] test_12_REG2;
assign test_12_REG2_wr_data = reg_sel[1] && internal_wr_en ? internal_wr_data : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(32),
	.ARST_VALUE(32'h0),
	.SW_TYPE({`SW_RW}),
	.SW_ONREAD_TYPE({`NA}),
	.SW_ONWRITE_TYPE({`NA}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_12_REG2__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_12_REG2_wr_data[31:0]),
	.sw_rd(rd_sel_ff[1]),
	.sw_wr(wr_sel_ff[1]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_12_REG2__FIELD_0__next_value),
	.hw_pulse(test_12_REG2__FIELD_0__pulse),
	.field_value(test_12_REG2__FIELD_0__curr_value)
	);
always_comb begin
	test_12_REG2[31:0] = 32'h0;
	test_12_REG2[31:0] = test_12_REG2__FIELD_0__curr_value;
end
assign reg_rd_data_in[1] = test_12_REG2;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_12_REG3//
//REG HIERARCHY: ['test_12', 'REG3']//
//REG ABSOLUTE_ADDR:64'h18//
//REG OFFSET_ADDR:64'h64'h8//
logic [31:0] test_12_REG3;
assign test_12_REG3_wr_data = reg_sel[2] && internal_wr_en ? internal_wr_data : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(32),
	.ARST_VALUE(32'h0),
	.SW_TYPE({`SW_RW}),
	.SW_ONREAD_TYPE({`NA}),
	.SW_ONWRITE_TYPE({`NA}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_12_REG3__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_12_REG3_wr_data[31:0]),
	.sw_rd(rd_sel_ff[2]),
	.sw_wr(wr_sel_ff[2]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_12_REG3__FIELD_0__next_value),
	.hw_pulse(test_12_REG3__FIELD_0__pulse),
	.field_value(test_12_REG3__FIELD_0__curr_value)
	);
always_comb begin
	test_12_REG3[31:0] = 32'h0;
	test_12_REG3[31:0] = test_12_REG3__FIELD_0__curr_value;
end
assign reg_rd_data_in[2] = test_12_REG3;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_12_REG4//
//REG HIERARCHY: ['test_12', 'REG4']//
//REG ABSOLUTE_ADDR:64'h1c//
//REG OFFSET_ADDR:64'h64'hc//
logic [31:0] test_12_REG4;
assign test_12_REG4_wr_data = reg_sel[3] && internal_wr_en ? internal_wr_data : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(32),
	.ARST_VALUE(32'h0),
	.SW_TYPE({`SW_RW}),
	.SW_ONREAD_TYPE({`NA}),
	.SW_ONWRITE_TYPE({`NA}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_12_REG4__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_12_REG4_wr_data[31:0]),
	.sw_rd(rd_sel_ff[3]),
	.sw_wr(wr_sel_ff[3]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_12_REG4__FIELD_0__next_value),
	.hw_pulse(test_12_REG4__FIELD_0__pulse),
	.field_value(test_12_REG4__FIELD_0__curr_value)
	);
always_comb begin
	test_12_REG4[31:0] = 32'h0;
	test_12_REG4[31:0] = test_12_REG4__FIELD_0__curr_value;
end
assign reg_rd_data_in[3] = test_12_REG4;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_13_REG1//
//REG HIERARCHY: ['test_13', 'REG1']//
//REG ABSOLUTE_ADDR:64'h20//
//REG OFFSET_ADDR:64'h64'h0//
logic [31:0] test_13_REG1;
assign test_13_REG1_wr_data = reg_sel[4] && internal_wr_en ? internal_wr_data : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(32),
	.ARST_VALUE(32'h0),
	.SW_TYPE({`SW_RW}),
	.SW_ONREAD_TYPE({`NA}),
	.SW_ONWRITE_TYPE({`NA}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_13_REG1__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_13_REG1_wr_data[31:0]),
	.sw_rd(rd_sel_ff[4]),
	.sw_wr(wr_sel_ff[4]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_13_REG1__FIELD_0__next_value),
	.hw_pulse(test_13_REG1__FIELD_0__pulse),
	.field_value(test_13_REG1__FIELD_0__curr_value)
	);
always_comb begin
	test_13_REG1[31:0] = 32'h0;
	test_13_REG1[31:0] = test_13_REG1__FIELD_0__curr_value;
end
assign reg_rd_data_in[4] = test_13_REG1;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_13_REG2//
//REG HIERARCHY: ['test_13', 'REG2']//
//REG ABSOLUTE_ADDR:64'h24//
//REG OFFSET_ADDR:64'h64'h4//
logic [31:0] test_13_REG2;
assign test_13_REG2_wr_data = reg_sel[5] && internal_wr_en ? internal_wr_data : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(32),
	.ARST_VALUE(32'h0),
	.SW_TYPE({`SW_RW}),
	.SW_ONREAD_TYPE({`NA}),
	.SW_ONWRITE_TYPE({`NA}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_13_REG2__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_13_REG2_wr_data[31:0]),
	.sw_rd(rd_sel_ff[5]),
	.sw_wr(wr_sel_ff[5]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_13_REG2__FIELD_0__next_value),
	.hw_pulse(test_13_REG2__FIELD_0__pulse),
	.field_value(test_13_REG2__FIELD_0__curr_value)
	);
always_comb begin
	test_13_REG2[31:0] = 32'h0;
	test_13_REG2[31:0] = test_13_REG2__FIELD_0__curr_value;
end
assign reg_rd_data_in[5] = test_13_REG2;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_13_REG3//
//REG HIERARCHY: ['test_13', 'REG3']//
//REG ABSOLUTE_ADDR:64'h28//
//REG OFFSET_ADDR:64'h64'h8//
logic [31:0] test_13_REG3;
assign test_13_REG3_wr_data = reg_sel[6] && internal_wr_en ? internal_wr_data : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(32),
	.ARST_VALUE(32'h0),
	.SW_TYPE({`SW_RW}),
	.SW_ONREAD_TYPE({`NA}),
	.SW_ONWRITE_TYPE({`NA}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_13_REG3__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_13_REG3_wr_data[31:0]),
	.sw_rd(rd_sel_ff[6]),
	.sw_wr(wr_sel_ff[6]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_13_REG3__FIELD_0__next_value),
	.hw_pulse(test_13_REG3__FIELD_0__pulse),
	.field_value(test_13_REG3__FIELD_0__curr_value)
	);
always_comb begin
	test_13_REG3[31:0] = 32'h0;
	test_13_REG3[31:0] = test_13_REG3__FIELD_0__curr_value;
end
assign reg_rd_data_in[6] = test_13_REG3;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_13_REG4//
//REG HIERARCHY: ['test_13', 'REG4']//
//REG ABSOLUTE_ADDR:64'h2c//
//REG OFFSET_ADDR:64'h64'hc//
logic [31:0] test_13_REG4;
assign test_13_REG4_wr_data = reg_sel[7] && internal_wr_en ? internal_wr_data : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(32),
	.ARST_VALUE(32'h0),
	.SW_TYPE({`SW_RW}),
	.SW_ONREAD_TYPE({`NA}),
	.SW_ONWRITE_TYPE({`NA}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_13_REG4__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_13_REG4_wr_data[31:0]),
	.sw_rd(rd_sel_ff[7]),
	.sw_wr(wr_sel_ff[7]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_13_REG4__FIELD_0__next_value),
	.hw_pulse(test_13_REG4__FIELD_0__pulse),
	.field_value(test_13_REG4__FIELD_0__curr_value)
	);
always_comb begin
	test_13_REG4[31:0] = 32'h0;
	test_13_REG4[31:0] = test_13_REG4__FIELD_0__curr_value;
end
assign reg_rd_data_in[7] = test_13_REG4;
//==========================================END REG INSTANT===========================================//
//********************************Register&field Instantiate END Here*********************************//
endmodule