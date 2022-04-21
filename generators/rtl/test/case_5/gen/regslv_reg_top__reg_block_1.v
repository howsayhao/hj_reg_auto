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
//['REG1', 'FIELD_0']
	REG1__FIELD_0__next_value,
	REG1__FIELD_0__pulse,
	REG1__FIELD_0__curr_value,
//['test_2', 'shared_21', 'FIELD_0']
	test_2_shared_21__FIELD_0__next_value,
	test_2_shared_21__FIELD_0__pulse,
	test_2_shared_21__FIELD_0__curr_value,
//*********************************INTERNAL field connection port END*********************************//
	,
	,
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
localparam N = 26;
localparam M = 0;
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
input ;
input ;
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
//['REG1', 'FIELD_0']
input [32-1:0] REG1__FIELD_0__next_value;
input REG1__FIELD_0__pulse;
output [32-1:0] REG1__FIELD_0__curr_value;
//['test_2', 'shared_21', 'FIELD_0']
input [32-1:0] test_2_shared_21__FIELD_0__next_value;
input test_2_shared_21__FIELD_0__pulse;
output [32-1:0] test_2_shared_21__FIELD_0__curr_value;
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




//********************************Rd_data/Ack_vld Split Mux START Here********************************//
split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(N+1), .GROUP_SIZE(64)) rd_split_mux
(.clk(clk), .rst_n(rstn),
.din({reg_rd_data_in,{DATA_WIDTH{1'b0}}}), .sel({rd_sel_ff, !req_rdy & dummy_reg}),
.dout(internal_reg_rd_data_vld), .dout_vld(internal_reg_ack_vld)
);
//*********************************Rd_data/Ack_vld Split Mux END Here*********************************//


//*************************Final Split Mux OUT Signal Definitinon START Here**************************//
// select which to read out and transfer the corresponding vld signal
assign slv__fsm__rd_data = internal_reg_ack_vld ? internal_reg_rd_data_vld : 0;
assign slv__fsm__ack_vld = internal_reg_ack_vld | (internal_wr_en & internal_reg_selected);
//**************************Final Split Mux OUT Signal Definitinon END Here***************************//


//***************************internal register operation wire declare START***************************//
logic [31:0] REG1_wr_data;
logic [31:0] REG1_alias_1_wr_data;
logic [31:0] REG1_alias_2_wr_data;
logic [31:0] REG1_alias_3_wr_data;
logic [31:0] REG1_alias_4_wr_data;
logic [31:0] REG1_alias_5_wr_data;
logic [31:0] REG1_alias_6_wr_data;
logic [31:0] REG1_alias_7_wr_data;
logic [31:0] REG1_alias_8_wr_data;
logic [31:0] REG1_alias_9_wr_data;
logic [31:0] REG1_alias_10_wr_data;
logic [31:0] REG1_alias_11_wr_data;
logic [31:0] REG1_alias_12_wr_data;
logic [31:0] test_2_shared_21_wr_data;
logic [31:0] test_2_shared_22_wr_data;
logic [31:0] test_2_shared_23_wr_data;
logic [31:0] test_2_shared_24_wr_data;
logic [31:0] test_2_shared_25_wr_data;
logic [31:0] test_2_shared_26_wr_data;
logic [31:0] test_2_shared_27_wr_data;
logic [31:0] test_2_shared_28_wr_data;
logic [31:0] test_2_shared_29_wr_data;
logic [31:0] test_2_shared_210_wr_data;
logic [31:0] test_2_shared_211_wr_data;
logic [31:0] test_2_shared_212_wr_data;
logic [31:0] test_3_shared_31_wr_data;
//****************************internal register operation wire declare END****************************//


//************************************Address Decoding START Here*************************************//
always_comb begin
		reg_sel = {REG_NUM{1'b0}};
		ext_sel = {EXT_NUM{1'b0}};
		dummy_reg = 1'b0;
	unique case (addr_for_decode)
		64'h0:reg_sel[0] = 1'b1;//['REG1']
		64'h4:reg_sel[1] = 1'b1;//['REG1_alias_1']
		64'h8:reg_sel[2] = 1'b1;//['REG1_alias_2']
		64'hc:reg_sel[3] = 1'b1;//['REG1_alias_3']
		64'h10:reg_sel[4] = 1'b1;//['REG1_alias_4']
		64'h14:reg_sel[5] = 1'b1;//['REG1_alias_5']
		64'h18:reg_sel[6] = 1'b1;//['REG1_alias_6']
		64'h1c:reg_sel[7] = 1'b1;//['REG1_alias_7']
		64'h20:reg_sel[8] = 1'b1;//['REG1_alias_8']
		64'h24:reg_sel[9] = 1'b1;//['REG1_alias_9']
		64'h28:reg_sel[10] = 1'b1;//['REG1_alias_10']
		64'h2c:reg_sel[11] = 1'b1;//['REG1_alias_11']
		64'h30:reg_sel[12] = 1'b1;//['REG1_alias_12']
		64'h40:reg_sel[13] = 1'b1;//['test_2', 'shared_21']
		64'h44:reg_sel[14] = 1'b1;//['test_2', 'shared_22']
		64'h48:reg_sel[15] = 1'b1;//['test_2', 'shared_23']
		64'h4c:reg_sel[16] = 1'b1;//['test_2', 'shared_24']
		64'h50:reg_sel[17] = 1'b1;//['test_2', 'shared_25']
		64'h54:reg_sel[18] = 1'b1;//['test_2', 'shared_26']
		64'h58:reg_sel[19] = 1'b1;//['test_2', 'shared_27']
		64'h5c:reg_sel[20] = 1'b1;//['test_2', 'shared_28']
		64'h60:reg_sel[21] = 1'b1;//['test_2', 'shared_29']
		64'h64:reg_sel[22] = 1'b1;//['test_2', 'shared_210']
		64'h68:reg_sel[23] = 1'b1;//['test_2', 'shared_211']
		64'h6c:reg_sel[24] = 1'b1;//['test_2', 'shared_212']
		64'h70:reg_sel[25] = 1'b1;//['test_3', 'shared_31']
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
//REG NAME: REG1//
//REG HIERARCHY: ['REG1']//
//REG ABSOLUTE_ADDR:64'h0//
//REG OFFSET_ADDR:64'h64'h0//
logic [31:0] REG1;
assign REG1_wr_data = reg_sel[0] && internal_wr_en ? internal_wr_data : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(32),
	.ARST_VALUE(32'haaaaaaaa),
	.ALIAS_NUM(13),
	.SW_TYPE({`SW_RW,`SW_RO,`SW_WO,`SW_W1,`SW_RW1,`SW_RW,`SW_RW,`SW_RW,`SW_RW,`SW_RW,`SW_RW,`SW_RW,`SW_RW}),
	.SW_ONREAD_TYPE({`NA,`NA,`NA,`NA,`NA,`RCLR,`RSET,`NA,`NA,`NA,`NA,`NA,`NA}),
	.SW_ONWRITE_TYPE({`NA,`NA,`NA,`NA,`NA,`NA,`NA,`WOCLR,`WOSET,`WOT,`WZS,`WZC,`WZT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG1__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({REG1_wr_data[31:0],REG1_alias_12_wr_data[31:0],REG1_alias_12_wr_data[31:0],REG1_alias_12_wr_data[31:0],REG1_alias_12_wr_data[31:0],REG1_alias_12_wr_data[31:0],REG1_alias_12_wr_data[31:0],REG1_alias_12_wr_data[31:0],REG1_alias_12_wr_data[31:0],REG1_alias_12_wr_data[31:0],REG1_alias_12_wr_data[31:0],REG1_alias_12_wr_data[31:0],REG1_alias_12_wr_data[31:0]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[1],rd_sel_ff[2],rd_sel_ff[3],rd_sel_ff[4],rd_sel_ff[5],rd_sel_ff[6],rd_sel_ff[7],rd_sel_ff[8],rd_sel_ff[9],rd_sel_ff[10],rd_sel_ff[11],rd_sel_ff[12]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[1],wr_sel_ff[2],wr_sel_ff[3],wr_sel_ff[4],wr_sel_ff[5],wr_sel_ff[6],wr_sel_ff[7],wr_sel_ff[8],wr_sel_ff[9],wr_sel_ff[10],wr_sel_ff[11],wr_sel_ff[12]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG1__FIELD_0__next_value),
	.hw_pulse(REG1__FIELD_0__pulse),
	.field_value(REG1__FIELD_0__curr_value)
	);
always_comb begin
	REG1[31:0] = 32'h0;
	REG1[31:0] = REG1__FIELD_0__curr_value;
end
assign reg_rd_data_in[0] = REG1;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: REG1_alias_1//
//REG HIERARCHY: ['REG1_alias_1']//
//REG ABSOLUTE_ADDR:64'h4//
//REG OFFSET_ADDR:64'h64'h4//
logic [31:0] REG1_alias_1;
assign REG1_alias_1_wr_data = reg_sel[1] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	REG1_alias_1[31:0] = 32'h0;
	REG1_alias_1[31:0] = REG1__FIELD_0__curr_value;
end
assign reg_rd_data_in[1] = REG1_alias_1;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: REG1_alias_2//
//REG HIERARCHY: ['REG1_alias_2']//
//REG ABSOLUTE_ADDR:64'h8//
//REG OFFSET_ADDR:64'h64'h8//
logic [31:0] REG1_alias_2;
assign REG1_alias_2_wr_data = reg_sel[2] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	REG1_alias_2[31:0] = 32'h0;
	REG1_alias_2[31:0] = REG1__FIELD_0__curr_value;
end
assign reg_rd_data_in[2] = REG1_alias_2;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: REG1_alias_3//
//REG HIERARCHY: ['REG1_alias_3']//
//REG ABSOLUTE_ADDR:64'hc//
//REG OFFSET_ADDR:64'h64'hc//
logic [31:0] REG1_alias_3;
assign REG1_alias_3_wr_data = reg_sel[3] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	REG1_alias_3[31:0] = 32'h0;
	REG1_alias_3[31:0] = REG1__FIELD_0__curr_value;
end
assign reg_rd_data_in[3] = REG1_alias_3;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: REG1_alias_4//
//REG HIERARCHY: ['REG1_alias_4']//
//REG ABSOLUTE_ADDR:64'h10//
//REG OFFSET_ADDR:64'h64'h10//
logic [31:0] REG1_alias_4;
assign REG1_alias_4_wr_data = reg_sel[4] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	REG1_alias_4[31:0] = 32'h0;
	REG1_alias_4[31:0] = REG1__FIELD_0__curr_value;
end
assign reg_rd_data_in[4] = REG1_alias_4;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: REG1_alias_5//
//REG HIERARCHY: ['REG1_alias_5']//
//REG ABSOLUTE_ADDR:64'h14//
//REG OFFSET_ADDR:64'h64'h14//
logic [31:0] REG1_alias_5;
assign REG1_alias_5_wr_data = reg_sel[5] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	REG1_alias_5[31:0] = 32'h0;
	REG1_alias_5[31:0] = REG1__FIELD_0__curr_value;
end
assign reg_rd_data_in[5] = REG1_alias_5;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: REG1_alias_6//
//REG HIERARCHY: ['REG1_alias_6']//
//REG ABSOLUTE_ADDR:64'h18//
//REG OFFSET_ADDR:64'h64'h18//
logic [31:0] REG1_alias_6;
assign REG1_alias_6_wr_data = reg_sel[6] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	REG1_alias_6[31:0] = 32'h0;
	REG1_alias_6[31:0] = REG1__FIELD_0__curr_value;
end
assign reg_rd_data_in[6] = REG1_alias_6;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: REG1_alias_7//
//REG HIERARCHY: ['REG1_alias_7']//
//REG ABSOLUTE_ADDR:64'h1c//
//REG OFFSET_ADDR:64'h64'h1c//
logic [31:0] REG1_alias_7;
assign REG1_alias_7_wr_data = reg_sel[7] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	REG1_alias_7[31:0] = 32'h0;
	REG1_alias_7[31:0] = REG1__FIELD_0__curr_value;
end
assign reg_rd_data_in[7] = REG1_alias_7;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: REG1_alias_8//
//REG HIERARCHY: ['REG1_alias_8']//
//REG ABSOLUTE_ADDR:64'h20//
//REG OFFSET_ADDR:64'h64'h20//
logic [31:0] REG1_alias_8;
assign REG1_alias_8_wr_data = reg_sel[8] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	REG1_alias_8[31:0] = 32'h0;
	REG1_alias_8[31:0] = REG1__FIELD_0__curr_value;
end
assign reg_rd_data_in[8] = REG1_alias_8;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: REG1_alias_9//
//REG HIERARCHY: ['REG1_alias_9']//
//REG ABSOLUTE_ADDR:64'h24//
//REG OFFSET_ADDR:64'h64'h24//
logic [31:0] REG1_alias_9;
assign REG1_alias_9_wr_data = reg_sel[9] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	REG1_alias_9[31:0] = 32'h0;
	REG1_alias_9[31:0] = REG1__FIELD_0__curr_value;
end
assign reg_rd_data_in[9] = REG1_alias_9;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: REG1_alias_10//
//REG HIERARCHY: ['REG1_alias_10']//
//REG ABSOLUTE_ADDR:64'h28//
//REG OFFSET_ADDR:64'h64'h28//
logic [31:0] REG1_alias_10;
assign REG1_alias_10_wr_data = reg_sel[10] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	REG1_alias_10[31:0] = 32'h0;
	REG1_alias_10[31:0] = REG1__FIELD_0__curr_value;
end
assign reg_rd_data_in[10] = REG1_alias_10;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: REG1_alias_11//
//REG HIERARCHY: ['REG1_alias_11']//
//REG ABSOLUTE_ADDR:64'h2c//
//REG OFFSET_ADDR:64'h64'h2c//
logic [31:0] REG1_alias_11;
assign REG1_alias_11_wr_data = reg_sel[11] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	REG1_alias_11[31:0] = 32'h0;
	REG1_alias_11[31:0] = REG1__FIELD_0__curr_value;
end
assign reg_rd_data_in[11] = REG1_alias_11;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: REG1_alias_12//
//REG HIERARCHY: ['REG1_alias_12']//
//REG ABSOLUTE_ADDR:64'h30//
//REG OFFSET_ADDR:64'h64'h30//
logic [31:0] REG1_alias_12;
assign REG1_alias_12_wr_data = reg_sel[12] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	REG1_alias_12[31:0] = 32'h0;
	REG1_alias_12[31:0] = REG1__FIELD_0__curr_value;
end
assign reg_rd_data_in[12] = REG1_alias_12;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_2_shared_21//
//REG HIERARCHY: ['test_2', 'shared_21']//
//REG ABSOLUTE_ADDR:64'h40//
//REG OFFSET_ADDR:64'h64'h0//
logic [31:0] test_2_shared_21;
assign test_2_shared_21_wr_data = reg_sel[13] && internal_wr_en ? internal_wr_data : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(32),
	.SRST_CNT(2),
	.ARST_VALUE(32'haaaaaaaa),
	.ALIAS_NUM(13),
	.SW_TYPE({`SW_RO,`SW_WO,`SW_W1,`SW_RW1,`SW_RW,`SW_RW,`SW_RW,`SW_RW,`SW_RW,`SW_RW,`SW_RW,`SW_RW,`SW_RW}),
	.SW_ONREAD_TYPE({`NA,`NA,`NA,`NA,`RCLR,`RSET,`NA,`NA,`NA,`NA,`NA,`NA,`NA}),
	.SW_ONWRITE_TYPE({`NA,`NA,`NA,`NA,`NA,`NA,`WOCLR,`WOSET,`WOT,`WZS,`WZC,`WZT,`NA}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_2_shared_21__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst({,}),
	.sw_wr_data({test_2_shared_21_wr_data[31:0],test_3_shared_31_wr_data[31:0],test_3_shared_31_wr_data[31:0],test_3_shared_31_wr_data[31:0],test_3_shared_31_wr_data[31:0],test_3_shared_31_wr_data[31:0],test_3_shared_31_wr_data[31:0],test_3_shared_31_wr_data[31:0],test_3_shared_31_wr_data[31:0],test_3_shared_31_wr_data[31:0],test_3_shared_31_wr_data[31:0],test_3_shared_31_wr_data[31:0],test_3_shared_31_wr_data[31:0]}),
	.sw_rd({rd_sel_ff[13],rd_sel_ff[14],rd_sel_ff[15],rd_sel_ff[16],rd_sel_ff[17],rd_sel_ff[18],rd_sel_ff[19],rd_sel_ff[20],rd_sel_ff[21],rd_sel_ff[22],rd_sel_ff[23],rd_sel_ff[24],rd_sel_ff[25]}),
	.sw_wr({wr_sel_ff[13],wr_sel_ff[14],wr_sel_ff[15],wr_sel_ff[16],wr_sel_ff[17],wr_sel_ff[18],wr_sel_ff[19],wr_sel_ff[20],wr_sel_ff[21],wr_sel_ff[22],wr_sel_ff[23],wr_sel_ff[24],wr_sel_ff[25]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_2_shared_21__FIELD_0__next_value),
	.hw_pulse(test_2_shared_21__FIELD_0__pulse),
	.field_value(test_2_shared_21__FIELD_0__curr_value)
	);
always_comb begin
	test_2_shared_21[31:0] = 32'h0;
	test_2_shared_21[31:0] = test_2_shared_21__FIELD_0__curr_value;
end
assign reg_rd_data_in[13] = test_2_shared_21;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_2_shared_22//
//REG HIERARCHY: ['test_2', 'shared_22']//
//REG ABSOLUTE_ADDR:64'h44//
//REG OFFSET_ADDR:64'h64'h4//
logic [31:0] test_2_shared_22;
assign test_2_shared_22_wr_data = reg_sel[14] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	test_2_shared_22[31:0] = 32'h0;
	test_2_shared_22[31:0] = test_2_shared_21__FIELD_0__curr_value;
end
assign reg_rd_data_in[14] = test_2_shared_22;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_2_shared_23//
//REG HIERARCHY: ['test_2', 'shared_23']//
//REG ABSOLUTE_ADDR:64'h48//
//REG OFFSET_ADDR:64'h64'h8//
logic [31:0] test_2_shared_23;
assign test_2_shared_23_wr_data = reg_sel[15] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	test_2_shared_23[31:0] = 32'h0;
	test_2_shared_23[31:0] = test_2_shared_21__FIELD_0__curr_value;
end
assign reg_rd_data_in[15] = test_2_shared_23;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_2_shared_24//
//REG HIERARCHY: ['test_2', 'shared_24']//
//REG ABSOLUTE_ADDR:64'h4c//
//REG OFFSET_ADDR:64'h64'hc//
logic [31:0] test_2_shared_24;
assign test_2_shared_24_wr_data = reg_sel[16] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	test_2_shared_24[31:0] = 32'h0;
	test_2_shared_24[31:0] = test_2_shared_21__FIELD_0__curr_value;
end
assign reg_rd_data_in[16] = test_2_shared_24;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_2_shared_25//
//REG HIERARCHY: ['test_2', 'shared_25']//
//REG ABSOLUTE_ADDR:64'h50//
//REG OFFSET_ADDR:64'h64'h10//
logic [31:0] test_2_shared_25;
assign test_2_shared_25_wr_data = reg_sel[17] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	test_2_shared_25[31:0] = 32'h0;
	test_2_shared_25[31:0] = test_2_shared_21__FIELD_0__curr_value;
end
assign reg_rd_data_in[17] = test_2_shared_25;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_2_shared_26//
//REG HIERARCHY: ['test_2', 'shared_26']//
//REG ABSOLUTE_ADDR:64'h54//
//REG OFFSET_ADDR:64'h64'h14//
logic [31:0] test_2_shared_26;
assign test_2_shared_26_wr_data = reg_sel[18] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	test_2_shared_26[31:0] = 32'h0;
	test_2_shared_26[31:0] = test_2_shared_21__FIELD_0__curr_value;
end
assign reg_rd_data_in[18] = test_2_shared_26;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_2_shared_27//
//REG HIERARCHY: ['test_2', 'shared_27']//
//REG ABSOLUTE_ADDR:64'h58//
//REG OFFSET_ADDR:64'h64'h18//
logic [31:0] test_2_shared_27;
assign test_2_shared_27_wr_data = reg_sel[19] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	test_2_shared_27[31:0] = 32'h0;
	test_2_shared_27[31:0] = test_2_shared_21__FIELD_0__curr_value;
end
assign reg_rd_data_in[19] = test_2_shared_27;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_2_shared_28//
//REG HIERARCHY: ['test_2', 'shared_28']//
//REG ABSOLUTE_ADDR:64'h5c//
//REG OFFSET_ADDR:64'h64'h1c//
logic [31:0] test_2_shared_28;
assign test_2_shared_28_wr_data = reg_sel[20] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	test_2_shared_28[31:0] = 32'h0;
	test_2_shared_28[31:0] = test_2_shared_21__FIELD_0__curr_value;
end
assign reg_rd_data_in[20] = test_2_shared_28;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_2_shared_29//
//REG HIERARCHY: ['test_2', 'shared_29']//
//REG ABSOLUTE_ADDR:64'h60//
//REG OFFSET_ADDR:64'h64'h20//
logic [31:0] test_2_shared_29;
assign test_2_shared_29_wr_data = reg_sel[21] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	test_2_shared_29[31:0] = 32'h0;
	test_2_shared_29[31:0] = test_2_shared_21__FIELD_0__curr_value;
end
assign reg_rd_data_in[21] = test_2_shared_29;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_2_shared_210//
//REG HIERARCHY: ['test_2', 'shared_210']//
//REG ABSOLUTE_ADDR:64'h64//
//REG OFFSET_ADDR:64'h64'h24//
logic [31:0] test_2_shared_210;
assign test_2_shared_210_wr_data = reg_sel[22] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	test_2_shared_210[31:0] = 32'h0;
	test_2_shared_210[31:0] = test_2_shared_21__FIELD_0__curr_value;
end
assign reg_rd_data_in[22] = test_2_shared_210;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_2_shared_211//
//REG HIERARCHY: ['test_2', 'shared_211']//
//REG ABSOLUTE_ADDR:64'h68//
//REG OFFSET_ADDR:64'h64'h28//
logic [31:0] test_2_shared_211;
assign test_2_shared_211_wr_data = reg_sel[23] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	test_2_shared_211[31:0] = 32'h0;
	test_2_shared_211[31:0] = test_2_shared_21__FIELD_0__curr_value;
end
assign reg_rd_data_in[23] = test_2_shared_211;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_2_shared_212//
//REG HIERARCHY: ['test_2', 'shared_212']//
//REG ABSOLUTE_ADDR:64'h6c//
//REG OFFSET_ADDR:64'h64'h2c//
logic [31:0] test_2_shared_212;
assign test_2_shared_212_wr_data = reg_sel[24] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	test_2_shared_212[31:0] = 32'h0;
	test_2_shared_212[31:0] = test_2_shared_21__FIELD_0__curr_value;
end
assign reg_rd_data_in[24] = test_2_shared_212;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_3_shared_31//
//REG HIERARCHY: ['test_3', 'shared_31']//
//REG ABSOLUTE_ADDR:64'h70//
//REG OFFSET_ADDR:64'h64'h0//
logic [31:0] test_3_shared_31;
assign test_3_shared_31_wr_data = reg_sel[25] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	test_3_shared_31[31:0] = 32'h0;
	test_3_shared_31[31:0] = test_2_shared_21__FIELD_0__curr_value;
end
assign reg_rd_data_in[25] = test_3_shared_31;
//==========================================END REG INSTANT===========================================//
//********************************Register&field Instantiate END Here*********************************//
endmodule