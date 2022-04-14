`include "xregister.vh"
module regslv_reg_top__reg_block_2(
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
//['test_21', 'REG1', 'FIELD_0']
	test_21_REG1__FIELD_0__next_value,
	test_21_REG1__FIELD_0__pulse,
	test_21_REG1__FIELD_0__curr_value,
//['test_21', 'REG2', 'FIELD_0']
	test_21_REG2__FIELD_0__next_value,
	test_21_REG2__FIELD_0__pulse,
	test_21_REG2__FIELD_0__curr_value,
//['test_21', 'REG3', 'FIELD_0']
	test_21_REG3__FIELD_0__next_value,
	test_21_REG3__FIELD_0__pulse,
	test_21_REG3__FIELD_0__curr_value,
//['test_21', 'REG4', 'FIELD_0']
	test_21_REG4__FIELD_0__next_value,
	test_21_REG4__FIELD_0__pulse,
	test_21_REG4__FIELD_0__curr_value,
//['test_22', 'REG1', 'FIELD_0']
	test_22_REG1__FIELD_0__next_value,
	test_22_REG1__FIELD_0__pulse,
	test_22_REG1__FIELD_0__curr_value,
//['test_22', 'REG2', 'FIELD_0']
	test_22_REG2__FIELD_0__next_value,
	test_22_REG2__FIELD_0__pulse,
	test_22_REG2__FIELD_0__curr_value,
//['test_22', 'REG3', 'FIELD_0']
	test_22_REG3__FIELD_0__next_value,
	test_22_REG3__FIELD_0__pulse,
	test_22_REG3__FIELD_0__curr_value,
//['test_22', 'REG4', 'FIELD_0']
	test_22_REG4__FIELD_0__next_value,
	test_22_REG4__FIELD_0__pulse,
	test_22_REG4__FIELD_0__curr_value,
//['test_23', 'REG1', 'FIELD_0']
	test_23_REG1__FIELD_0__next_value,
	test_23_REG1__FIELD_0__pulse,
	test_23_REG1__FIELD_0__curr_value,
//['test_23', 'REG2', 'FIELD_0']
	test_23_REG2__FIELD_0__next_value,
	test_23_REG2__FIELD_0__pulse,
	test_23_REG2__FIELD_0__curr_value,
//['test_23', 'REG3', 'FIELD_0']
	test_23_REG3__FIELD_0__next_value,
	test_23_REG3__FIELD_0__pulse,
	test_23_REG3__FIELD_0__curr_value,
//['test_23', 'REG4', 'FIELD_0']
	test_23_REG4__FIELD_0__next_value,
	test_23_REG4__FIELD_0__pulse,
	test_23_REG4__FIELD_0__curr_value,
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
localparam N = 12;
localparam M = 3;
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
//['test_21', 'REG1', 'FIELD_0']
input [32-1:0] test_21_REG1__FIELD_0__next_value;
input test_21_REG1__FIELD_0__pulse;
output [32-1:0] test_21_REG1__FIELD_0__curr_value;
//['test_21', 'REG2', 'FIELD_0']
input [32-1:0] test_21_REG2__FIELD_0__next_value;
input test_21_REG2__FIELD_0__pulse;
output [32-1:0] test_21_REG2__FIELD_0__curr_value;
//['test_21', 'REG3', 'FIELD_0']
input [32-1:0] test_21_REG3__FIELD_0__next_value;
input test_21_REG3__FIELD_0__pulse;
output [32-1:0] test_21_REG3__FIELD_0__curr_value;
//['test_21', 'REG4', 'FIELD_0']
input [32-1:0] test_21_REG4__FIELD_0__next_value;
input test_21_REG4__FIELD_0__pulse;
output [32-1:0] test_21_REG4__FIELD_0__curr_value;
//['test_22', 'REG1', 'FIELD_0']
input [32-1:0] test_22_REG1__FIELD_0__next_value;
input test_22_REG1__FIELD_0__pulse;
output [32-1:0] test_22_REG1__FIELD_0__curr_value;
//['test_22', 'REG2', 'FIELD_0']
input [32-1:0] test_22_REG2__FIELD_0__next_value;
input test_22_REG2__FIELD_0__pulse;
output [32-1:0] test_22_REG2__FIELD_0__curr_value;
//['test_22', 'REG3', 'FIELD_0']
input [32-1:0] test_22_REG3__FIELD_0__next_value;
input test_22_REG3__FIELD_0__pulse;
output [32-1:0] test_22_REG3__FIELD_0__curr_value;
//['test_22', 'REG4', 'FIELD_0']
input [32-1:0] test_22_REG4__FIELD_0__next_value;
input test_22_REG4__FIELD_0__pulse;
output [32-1:0] test_22_REG4__FIELD_0__curr_value;
//['test_23', 'REG1', 'FIELD_0']
input [32-1:0] test_23_REG1__FIELD_0__next_value;
input test_23_REG1__FIELD_0__pulse;
output [32-1:0] test_23_REG1__FIELD_0__curr_value;
//['test_23', 'REG2', 'FIELD_0']
input [32-1:0] test_23_REG2__FIELD_0__next_value;
input test_23_REG2__FIELD_0__pulse;
output [32-1:0] test_23_REG2__FIELD_0__curr_value;
//['test_23', 'REG3', 'FIELD_0']
input [32-1:0] test_23_REG3__FIELD_0__next_value;
input test_23_REG3__FIELD_0__pulse;
output [32-1:0] test_23_REG3__FIELD_0__curr_value;
//['test_23', 'REG4', 'FIELD_0']
input [32-1:0] test_23_REG4__FIELD_0__next_value;
input test_23_REG4__FIELD_0__pulse;
output [32-1:0] test_23_REG4__FIELD_0__curr_value;
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
//ext_mem_21 connection, external[0];
assign ext_req_vld[0] = ext_sel[0] & fsm__slv__req_vld;
assign ext_ack[0] = ext_ack_vld[0] & ext_sel[0];
//ext_mem_22 connection, external[1];
assign ext_req_vld[1] = ext_sel[1] & fsm__slv__req_vld;
assign ext_ack[1] = ext_ack_vld[1] & ext_sel[1];
//ext_mem_23 connection, external[2];
assign ext_req_vld[2] = ext_sel[2] & fsm__slv__req_vld;
assign ext_ack[2] = ext_ack_vld[2] & ext_sel[2];
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
logic [31:0] test_21_REG1_wr_data;
logic [31:0] test_21_REG2_wr_data;
logic [31:0] test_21_REG3_wr_data;
logic [31:0] test_21_REG4_wr_data;
logic [31:0] test_22_REG1_wr_data;
logic [31:0] test_22_REG2_wr_data;
logic [31:0] test_22_REG3_wr_data;
logic [31:0] test_22_REG4_wr_data;
logic [31:0] test_23_REG1_wr_data;
logic [31:0] test_23_REG2_wr_data;
logic [31:0] test_23_REG3_wr_data;
logic [31:0] test_23_REG4_wr_data;
//****************************internal register operation wire declare END****************************//


//************************************Address Decoding START Here*************************************//
always_comb begin
		reg_sel = {REG_NUM{1'b0}};
		ext_sel = {EXT_NUM{1'b0}};
		dummy_reg = 1'b0;
	unique case (addr_for_decode)
		64'h400:reg_sel[0] = 1'b1;//['test_21', 'REG1']
		64'h404:reg_sel[1] = 1'b1;//['test_21', 'REG2']
		64'h408:reg_sel[2] = 1'b1;//['test_21', 'REG3']
		64'h40c:reg_sel[3] = 1'b1;//['test_21', 'REG4']
		64'h410:reg_sel[4] = 1'b1;//['test_22', 'REG1']
		64'h414:reg_sel[5] = 1'b1;//['test_22', 'REG2']
		64'h418:reg_sel[6] = 1'b1;//['test_22', 'REG3']
		64'h41c:reg_sel[7] = 1'b1;//['test_22', 'REG4']
		64'h420:reg_sel[8] = 1'b1;//['test_23', 'REG1']
		64'h424:reg_sel[9] = 1'b1;//['test_23', 'REG2']
		64'h428:reg_sel[10] = 1'b1;//['test_23', 'REG3']
		64'h42c:reg_sel[11] = 1'b1;//['test_23', 'REG4']
		64'h500,64'h504,64'h508,64'h50c,64'h510,64'h514,64'h518,64'h51c,64'h520,64'h524,64'h528,64'h52c,64'h530,64'h534,64'h538,64'h53c,64'h540,64'h544,64'h548,64'h54c,64'h550,64'h554,64'h558,64'h55c,64'h560,64'h564,64'h568,64'h56c,64'h570,64'h574,64'h578,64'h57c,64'h580,64'h584,64'h588,64'h58c,64'h590,64'h594,64'h598,64'h59c,64'h5a0,64'h5a4,64'h5a8,64'h5ac,64'h5b0,64'h5b4,64'h5b8,64'h5bc,64'h5c0,64'h5c4,64'h5c8,64'h5cc,64'h5d0,64'h5d4,64'h5d8,64'h5dc,64'h5e0,64'h5e4,64'h5e8,64'h5ec,64'h5f0,64'h5f4,64'h5f8,64'h5fc:ext_sel[0] = 1'b1;//external module ext_mem_21
		64'h600,64'h604,64'h608,64'h60c,64'h610,64'h614,64'h618,64'h61c,64'h620,64'h624,64'h628,64'h62c,64'h630,64'h634,64'h638,64'h63c,64'h640,64'h644,64'h648,64'h64c,64'h650,64'h654,64'h658,64'h65c,64'h660,64'h664,64'h668,64'h66c,64'h670,64'h674,64'h678,64'h67c,64'h680,64'h684,64'h688,64'h68c,64'h690,64'h694,64'h698,64'h69c,64'h6a0,64'h6a4,64'h6a8,64'h6ac,64'h6b0,64'h6b4,64'h6b8,64'h6bc,64'h6c0,64'h6c4,64'h6c8,64'h6cc,64'h6d0,64'h6d4,64'h6d8,64'h6dc,64'h6e0,64'h6e4,64'h6e8,64'h6ec,64'h6f0,64'h6f4,64'h6f8,64'h6fc:ext_sel[1] = 1'b1;//external module ext_mem_22
		64'h700,64'h704,64'h708,64'h70c,64'h710,64'h714,64'h718,64'h71c,64'h720,64'h724,64'h728,64'h72c,64'h730,64'h734,64'h738,64'h73c,64'h740,64'h744,64'h748,64'h74c,64'h750,64'h754,64'h758,64'h75c,64'h760,64'h764,64'h768,64'h76c,64'h770,64'h774,64'h778,64'h77c,64'h780,64'h784,64'h788,64'h78c,64'h790,64'h794,64'h798,64'h79c,64'h7a0,64'h7a4,64'h7a8,64'h7ac,64'h7b0,64'h7b4,64'h7b8,64'h7bc,64'h7c0,64'h7c4,64'h7c8,64'h7cc,64'h7d0,64'h7d4,64'h7d8,64'h7dc,64'h7e0,64'h7e4,64'h7e8,64'h7ec,64'h7f0,64'h7f4,64'h7f8,64'h7fc:ext_sel[2] = 1'b1;//external module ext_mem_23
		default: dummy_reg = 1'b1;
	endcase
end
//*************************************Address Decoding END Here**************************************//


//************************************STATE MACHINE INSTANCE START************************************//
slv_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
	slv_fsm_reg_top__reg_block_2 (
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
//REG NAME: test_21_REG1//
//REG HIERARCHY: ['test_21', 'REG1']//
//REG ABSOLUTE_ADDR:64'h400//
//REG OFFSET_ADDR:64'h64'h0//
logic [31:0] test_21_REG1;
assign test_21_REG1_wr_data = reg_sel[0] && internal_wr_en ? internal_wr_data : 0;
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
x__test_21_REG1__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_21_REG1_wr_data[31:0]),
	.sw_rd(rd_sel_ff[0]),
	.sw_wr(wr_sel_ff[0]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG1__FIELD_0__next_value),
	.hw_pulse(test_21_REG1__FIELD_0__pulse),
	.field_value(test_21_REG1__FIELD_0__curr_value)
	);
always_comb begin
	test_21_REG1[31:0] = 32'h0;
	test_21_REG1[31:0] = test_21_REG1__FIELD_0__curr_value;
end
assign reg_rd_data_in[0] = test_21_REG1;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_21_REG2//
//REG HIERARCHY: ['test_21', 'REG2']//
//REG ABSOLUTE_ADDR:64'h404//
//REG OFFSET_ADDR:64'h64'h4//
logic [31:0] test_21_REG2;
assign test_21_REG2_wr_data = reg_sel[1] && internal_wr_en ? internal_wr_data : 0;
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
x__test_21_REG2__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_21_REG2_wr_data[31:0]),
	.sw_rd(rd_sel_ff[1]),
	.sw_wr(wr_sel_ff[1]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG2__FIELD_0__next_value),
	.hw_pulse(test_21_REG2__FIELD_0__pulse),
	.field_value(test_21_REG2__FIELD_0__curr_value)
	);
always_comb begin
	test_21_REG2[31:0] = 32'h0;
	test_21_REG2[31:0] = test_21_REG2__FIELD_0__curr_value;
end
assign reg_rd_data_in[1] = test_21_REG2;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_21_REG3//
//REG HIERARCHY: ['test_21', 'REG3']//
//REG ABSOLUTE_ADDR:64'h408//
//REG OFFSET_ADDR:64'h64'h8//
logic [31:0] test_21_REG3;
assign test_21_REG3_wr_data = reg_sel[2] && internal_wr_en ? internal_wr_data : 0;
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
x__test_21_REG3__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_21_REG3_wr_data[31:0]),
	.sw_rd(rd_sel_ff[2]),
	.sw_wr(wr_sel_ff[2]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG3__FIELD_0__next_value),
	.hw_pulse(test_21_REG3__FIELD_0__pulse),
	.field_value(test_21_REG3__FIELD_0__curr_value)
	);
always_comb begin
	test_21_REG3[31:0] = 32'h0;
	test_21_REG3[31:0] = test_21_REG3__FIELD_0__curr_value;
end
assign reg_rd_data_in[2] = test_21_REG3;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_21_REG4//
//REG HIERARCHY: ['test_21', 'REG4']//
//REG ABSOLUTE_ADDR:64'h40c//
//REG OFFSET_ADDR:64'h64'hc//
logic [31:0] test_21_REG4;
assign test_21_REG4_wr_data = reg_sel[3] && internal_wr_en ? internal_wr_data : 0;
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
x__test_21_REG4__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_21_REG4_wr_data[31:0]),
	.sw_rd(rd_sel_ff[3]),
	.sw_wr(wr_sel_ff[3]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG4__FIELD_0__next_value),
	.hw_pulse(test_21_REG4__FIELD_0__pulse),
	.field_value(test_21_REG4__FIELD_0__curr_value)
	);
always_comb begin
	test_21_REG4[31:0] = 32'h0;
	test_21_REG4[31:0] = test_21_REG4__FIELD_0__curr_value;
end
assign reg_rd_data_in[3] = test_21_REG4;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_22_REG1//
//REG HIERARCHY: ['test_22', 'REG1']//
//REG ABSOLUTE_ADDR:64'h410//
//REG OFFSET_ADDR:64'h64'h0//
logic [31:0] test_22_REG1;
assign test_22_REG1_wr_data = reg_sel[4] && internal_wr_en ? internal_wr_data : 0;
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
x__test_22_REG1__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_22_REG1_wr_data[31:0]),
	.sw_rd(rd_sel_ff[4]),
	.sw_wr(wr_sel_ff[4]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_22_REG1__FIELD_0__next_value),
	.hw_pulse(test_22_REG1__FIELD_0__pulse),
	.field_value(test_22_REG1__FIELD_0__curr_value)
	);
always_comb begin
	test_22_REG1[31:0] = 32'h0;
	test_22_REG1[31:0] = test_22_REG1__FIELD_0__curr_value;
end
assign reg_rd_data_in[4] = test_22_REG1;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_22_REG2//
//REG HIERARCHY: ['test_22', 'REG2']//
//REG ABSOLUTE_ADDR:64'h414//
//REG OFFSET_ADDR:64'h64'h4//
logic [31:0] test_22_REG2;
assign test_22_REG2_wr_data = reg_sel[5] && internal_wr_en ? internal_wr_data : 0;
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
x__test_22_REG2__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_22_REG2_wr_data[31:0]),
	.sw_rd(rd_sel_ff[5]),
	.sw_wr(wr_sel_ff[5]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_22_REG2__FIELD_0__next_value),
	.hw_pulse(test_22_REG2__FIELD_0__pulse),
	.field_value(test_22_REG2__FIELD_0__curr_value)
	);
always_comb begin
	test_22_REG2[31:0] = 32'h0;
	test_22_REG2[31:0] = test_22_REG2__FIELD_0__curr_value;
end
assign reg_rd_data_in[5] = test_22_REG2;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_22_REG3//
//REG HIERARCHY: ['test_22', 'REG3']//
//REG ABSOLUTE_ADDR:64'h418//
//REG OFFSET_ADDR:64'h64'h8//
logic [31:0] test_22_REG3;
assign test_22_REG3_wr_data = reg_sel[6] && internal_wr_en ? internal_wr_data : 0;
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
x__test_22_REG3__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_22_REG3_wr_data[31:0]),
	.sw_rd(rd_sel_ff[6]),
	.sw_wr(wr_sel_ff[6]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_22_REG3__FIELD_0__next_value),
	.hw_pulse(test_22_REG3__FIELD_0__pulse),
	.field_value(test_22_REG3__FIELD_0__curr_value)
	);
always_comb begin
	test_22_REG3[31:0] = 32'h0;
	test_22_REG3[31:0] = test_22_REG3__FIELD_0__curr_value;
end
assign reg_rd_data_in[6] = test_22_REG3;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_22_REG4//
//REG HIERARCHY: ['test_22', 'REG4']//
//REG ABSOLUTE_ADDR:64'h41c//
//REG OFFSET_ADDR:64'h64'hc//
logic [31:0] test_22_REG4;
assign test_22_REG4_wr_data = reg_sel[7] && internal_wr_en ? internal_wr_data : 0;
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
x__test_22_REG4__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_22_REG4_wr_data[31:0]),
	.sw_rd(rd_sel_ff[7]),
	.sw_wr(wr_sel_ff[7]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_22_REG4__FIELD_0__next_value),
	.hw_pulse(test_22_REG4__FIELD_0__pulse),
	.field_value(test_22_REG4__FIELD_0__curr_value)
	);
always_comb begin
	test_22_REG4[31:0] = 32'h0;
	test_22_REG4[31:0] = test_22_REG4__FIELD_0__curr_value;
end
assign reg_rd_data_in[7] = test_22_REG4;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_23_REG1//
//REG HIERARCHY: ['test_23', 'REG1']//
//REG ABSOLUTE_ADDR:64'h420//
//REG OFFSET_ADDR:64'h64'h0//
logic [31:0] test_23_REG1;
assign test_23_REG1_wr_data = reg_sel[8] && internal_wr_en ? internal_wr_data : 0;
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
x__test_23_REG1__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_23_REG1_wr_data[31:0]),
	.sw_rd(rd_sel_ff[8]),
	.sw_wr(wr_sel_ff[8]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_23_REG1__FIELD_0__next_value),
	.hw_pulse(test_23_REG1__FIELD_0__pulse),
	.field_value(test_23_REG1__FIELD_0__curr_value)
	);
always_comb begin
	test_23_REG1[31:0] = 32'h0;
	test_23_REG1[31:0] = test_23_REG1__FIELD_0__curr_value;
end
assign reg_rd_data_in[8] = test_23_REG1;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_23_REG2//
//REG HIERARCHY: ['test_23', 'REG2']//
//REG ABSOLUTE_ADDR:64'h424//
//REG OFFSET_ADDR:64'h64'h4//
logic [31:0] test_23_REG2;
assign test_23_REG2_wr_data = reg_sel[9] && internal_wr_en ? internal_wr_data : 0;
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
x__test_23_REG2__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_23_REG2_wr_data[31:0]),
	.sw_rd(rd_sel_ff[9]),
	.sw_wr(wr_sel_ff[9]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_23_REG2__FIELD_0__next_value),
	.hw_pulse(test_23_REG2__FIELD_0__pulse),
	.field_value(test_23_REG2__FIELD_0__curr_value)
	);
always_comb begin
	test_23_REG2[31:0] = 32'h0;
	test_23_REG2[31:0] = test_23_REG2__FIELD_0__curr_value;
end
assign reg_rd_data_in[9] = test_23_REG2;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_23_REG3//
//REG HIERARCHY: ['test_23', 'REG3']//
//REG ABSOLUTE_ADDR:64'h428//
//REG OFFSET_ADDR:64'h64'h8//
logic [31:0] test_23_REG3;
assign test_23_REG3_wr_data = reg_sel[10] && internal_wr_en ? internal_wr_data : 0;
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
x__test_23_REG3__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_23_REG3_wr_data[31:0]),
	.sw_rd(rd_sel_ff[10]),
	.sw_wr(wr_sel_ff[10]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_23_REG3__FIELD_0__next_value),
	.hw_pulse(test_23_REG3__FIELD_0__pulse),
	.field_value(test_23_REG3__FIELD_0__curr_value)
	);
always_comb begin
	test_23_REG3[31:0] = 32'h0;
	test_23_REG3[31:0] = test_23_REG3__FIELD_0__curr_value;
end
assign reg_rd_data_in[10] = test_23_REG3;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_23_REG4//
//REG HIERARCHY: ['test_23', 'REG4']//
//REG ABSOLUTE_ADDR:64'h42c//
//REG OFFSET_ADDR:64'h64'hc//
logic [31:0] test_23_REG4;
assign test_23_REG4_wr_data = reg_sel[11] && internal_wr_en ? internal_wr_data : 0;
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
x__test_23_REG4__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_23_REG4_wr_data[31:0]),
	.sw_rd(rd_sel_ff[11]),
	.sw_wr(wr_sel_ff[11]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_23_REG4__FIELD_0__next_value),
	.hw_pulse(test_23_REG4__FIELD_0__pulse),
	.field_value(test_23_REG4__FIELD_0__curr_value)
	);
always_comb begin
	test_23_REG4[31:0] = 32'h0;
	test_23_REG4[31:0] = test_23_REG4__FIELD_0__curr_value;
end
assign reg_rd_data_in[11] = test_23_REG4;
//==========================================END REG INSTANT===========================================//
//********************************Register&field Instantiate END Here*********************************//
endmodule