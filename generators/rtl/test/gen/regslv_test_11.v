`include "xregister.vh"
module regslv_test_11(
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
//['REG1_SW_RW', 'FIELD_8']
	REG1_SW_RW__FIELD_8__next_value,
	REG1_SW_RW__FIELD_8__pulse,
	REG1_SW_RW__FIELD_8__curr_value,
//['REG1_SW_RW', 'FIELD_7']
	REG1_SW_RW__FIELD_7__next_value,
	REG1_SW_RW__FIELD_7__pulse,
	REG1_SW_RW__FIELD_7__curr_value,
//['REG1_SW_RW', 'FIELD_6']
	REG1_SW_RW__FIELD_6__next_value,
	REG1_SW_RW__FIELD_6__pulse,
	REG1_SW_RW__FIELD_6__curr_value,
//['REG1_SW_RW', 'FIELD_5']
	REG1_SW_RW__FIELD_5__next_value,
	REG1_SW_RW__FIELD_5__pulse,
	REG1_SW_RW__FIELD_5__curr_value,
//['REG1_SW_RW', 'FIELD_4']
	REG1_SW_RW__FIELD_4__next_value,
	REG1_SW_RW__FIELD_4__pulse,
	REG1_SW_RW__FIELD_4__curr_value,
//['REG1_SW_RW', 'FIELD_3']
	REG1_SW_RW__FIELD_3__next_value,
	REG1_SW_RW__FIELD_3__pulse,
	REG1_SW_RW__FIELD_3__curr_value,
//['REG1_SW_RW', 'FIELD_2']
	REG1_SW_RW__FIELD_2__next_value,
	REG1_SW_RW__FIELD_2__pulse,
	REG1_SW_RW__FIELD_2__curr_value,
//['REG1_SW_RW', 'FIELD_1']
	REG1_SW_RW__FIELD_1__next_value,
	REG1_SW_RW__FIELD_1__pulse,
	REG1_SW_RW__FIELD_1__curr_value,
//['REG1_SW_RW', 'FIELD_0']
	REG1_SW_RW__FIELD_0__next_value,
	REG1_SW_RW__FIELD_0__pulse,
	REG1_SW_RW__FIELD_0__curr_value,
//['REG2_SW_W', 'FIELD_6']
	REG2_SW_W__FIELD_6__next_value,
	REG2_SW_W__FIELD_6__pulse,
	REG2_SW_W__FIELD_6__curr_value,
//['REG2_SW_W', 'FIELD_5']
	REG2_SW_W__FIELD_5__next_value,
	REG2_SW_W__FIELD_5__pulse,
	REG2_SW_W__FIELD_5__curr_value,
//['REG2_SW_W', 'FIELD_4']
	REG2_SW_W__FIELD_4__next_value,
	REG2_SW_W__FIELD_4__pulse,
	REG2_SW_W__FIELD_4__curr_value,
//['REG2_SW_W', 'FIELD_3']
	REG2_SW_W__FIELD_3__next_value,
	REG2_SW_W__FIELD_3__pulse,
	REG2_SW_W__FIELD_3__curr_value,
//['REG2_SW_W', 'FIELD_2']
	REG2_SW_W__FIELD_2__next_value,
	REG2_SW_W__FIELD_2__pulse,
	REG2_SW_W__FIELD_2__curr_value,
//['REG2_SW_W', 'FIELD_1']
	REG2_SW_W__FIELD_1__next_value,
	REG2_SW_W__FIELD_1__pulse,
	REG2_SW_W__FIELD_1__curr_value,
//['REG2_SW_W', 'FIELD_0']
	REG2_SW_W__FIELD_0__next_value,
	REG2_SW_W__FIELD_0__pulse,
	REG2_SW_W__FIELD_0__curr_value,
//['REG3_HW', 'FIELD_3']
	REG3_HW__FIELD_3__next_value,
	REG3_HW__FIELD_3__pulse,
	REG3_HW__FIELD_3__curr_value,
//['REG3_HW', 'FIELD_2']
	REG3_HW__FIELD_2__next_value,
	REG3_HW__FIELD_2__pulse,
	REG3_HW__FIELD_2__curr_value,
	REG3_HW__FIELD_1__curr_value,
//['REG3_HW', 'FIELD_0']
	REG3_HW__FIELD_0__next_value,
	REG3_HW__FIELD_0__pulse,
	REG3_HW__FIELD_0__curr_value,
//['REG4_PRECEDENCE', 'FIELD_1']
	REG4_PRECEDENCE__FIELD_1__next_value,
	REG4_PRECEDENCE__FIELD_1__pulse,
	REG4_PRECEDENCE__FIELD_1__curr_value,
//['REG4_PRECEDENCE', 'FIELD_0']
	REG4_PRECEDENCE__FIELD_0__next_value,
	REG4_PRECEDENCE__FIELD_0__pulse,
	REG4_PRECEDENCE__FIELD_0__curr_value,
//['REG5_SINGLEPULSE', 'FIELD_0']
	REG5_SINGLEPULSE__FIELD_0__next_value,
	REG5_SINGLEPULSE__FIELD_0__pulse,
	REG5_SINGLEPULSE__FIELD_0__curr_value,
//['REG6_SW_ACC_MOD', 'FIELD_0']
	REG6_SW_ACC_MOD__FIELD_0__next_value,
	REG6_SW_ACC_MOD__FIELD_0__pulse,
	REG6_SW_ACC_MOD__FIELD_0__curr_value,
	REG6_SW_ACC_MOD__FIELD_0__swmod_out,
	REG6_SW_ACC_MOD__FIELD_0__swacc_out,
//*********************************INTERNAL field connection port END*********************************//
	srst_1,
	srst_2,
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
	global_sync_reset_in,
	global_sync_reset_out
);
//**********************************PARAMETER Definition START Here***********************************//
parameter ADDR_WIDTH = 64;
parameter DATA_WIDTH = 32;
//N:number of internal registers, M:number of external modules
localparam N = 8;
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
input srst_1;
input srst_2;
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
//['REG1_SW_RW', 'FIELD_8']
input [2-1:0] REG1_SW_RW__FIELD_8__next_value;
input REG1_SW_RW__FIELD_8__pulse;
output [2-1:0] REG1_SW_RW__FIELD_8__curr_value;
//['REG1_SW_RW', 'FIELD_7']
input [2-1:0] REG1_SW_RW__FIELD_7__next_value;
input REG1_SW_RW__FIELD_7__pulse;
output [2-1:0] REG1_SW_RW__FIELD_7__curr_value;
//['REG1_SW_RW', 'FIELD_6']
input [2-1:0] REG1_SW_RW__FIELD_6__next_value;
input REG1_SW_RW__FIELD_6__pulse;
output [2-1:0] REG1_SW_RW__FIELD_6__curr_value;
//['REG1_SW_RW', 'FIELD_5']
input [2-1:0] REG1_SW_RW__FIELD_5__next_value;
input REG1_SW_RW__FIELD_5__pulse;
output [2-1:0] REG1_SW_RW__FIELD_5__curr_value;
//['REG1_SW_RW', 'FIELD_4']
input [2-1:0] REG1_SW_RW__FIELD_4__next_value;
input REG1_SW_RW__FIELD_4__pulse;
output [2-1:0] REG1_SW_RW__FIELD_4__curr_value;
//['REG1_SW_RW', 'FIELD_3']
input [2-1:0] REG1_SW_RW__FIELD_3__next_value;
input REG1_SW_RW__FIELD_3__pulse;
output [2-1:0] REG1_SW_RW__FIELD_3__curr_value;
//['REG1_SW_RW', 'FIELD_2']
input [2-1:0] REG1_SW_RW__FIELD_2__next_value;
input REG1_SW_RW__FIELD_2__pulse;
output [2-1:0] REG1_SW_RW__FIELD_2__curr_value;
//['REG1_SW_RW', 'FIELD_1']
input [2-1:0] REG1_SW_RW__FIELD_1__next_value;
input REG1_SW_RW__FIELD_1__pulse;
output [2-1:0] REG1_SW_RW__FIELD_1__curr_value;
//['REG1_SW_RW', 'FIELD_0']
input [2-1:0] REG1_SW_RW__FIELD_0__next_value;
input REG1_SW_RW__FIELD_0__pulse;
output [2-1:0] REG1_SW_RW__FIELD_0__curr_value;
//['REG2_SW_W', 'FIELD_6']
input [2-1:0] REG2_SW_W__FIELD_6__next_value;
input REG2_SW_W__FIELD_6__pulse;
output [2-1:0] REG2_SW_W__FIELD_6__curr_value;
//['REG2_SW_W', 'FIELD_5']
input [2-1:0] REG2_SW_W__FIELD_5__next_value;
input REG2_SW_W__FIELD_5__pulse;
output [2-1:0] REG2_SW_W__FIELD_5__curr_value;
//['REG2_SW_W', 'FIELD_4']
input [2-1:0] REG2_SW_W__FIELD_4__next_value;
input REG2_SW_W__FIELD_4__pulse;
output [2-1:0] REG2_SW_W__FIELD_4__curr_value;
//['REG2_SW_W', 'FIELD_3']
input [2-1:0] REG2_SW_W__FIELD_3__next_value;
input REG2_SW_W__FIELD_3__pulse;
output [2-1:0] REG2_SW_W__FIELD_3__curr_value;
//['REG2_SW_W', 'FIELD_2']
input [2-1:0] REG2_SW_W__FIELD_2__next_value;
input REG2_SW_W__FIELD_2__pulse;
output [2-1:0] REG2_SW_W__FIELD_2__curr_value;
//['REG2_SW_W', 'FIELD_1']
input [2-1:0] REG2_SW_W__FIELD_1__next_value;
input REG2_SW_W__FIELD_1__pulse;
output [2-1:0] REG2_SW_W__FIELD_1__curr_value;
//['REG2_SW_W', 'FIELD_0']
input [2-1:0] REG2_SW_W__FIELD_0__next_value;
input REG2_SW_W__FIELD_0__pulse;
output [2-1:0] REG2_SW_W__FIELD_0__curr_value;
//['REG3_HW', 'FIELD_3']
input [2-1:0] REG3_HW__FIELD_3__next_value;
input REG3_HW__FIELD_3__pulse;
output [2-1:0] REG3_HW__FIELD_3__curr_value;
//['REG3_HW', 'FIELD_2']
input [2-1:0] REG3_HW__FIELD_2__next_value;
input REG3_HW__FIELD_2__pulse;
output [2-1:0] REG3_HW__FIELD_2__curr_value;
output [2-1:0] REG3_HW__FIELD_1__curr_value;
//['REG3_HW', 'FIELD_0']
input [2-1:0] REG3_HW__FIELD_0__next_value;
input REG3_HW__FIELD_0__pulse;
output [2-1:0] REG3_HW__FIELD_0__curr_value;
//['REG4_PRECEDENCE', 'FIELD_1']
input [2-1:0] REG4_PRECEDENCE__FIELD_1__next_value;
input REG4_PRECEDENCE__FIELD_1__pulse;
output [2-1:0] REG4_PRECEDENCE__FIELD_1__curr_value;
//['REG4_PRECEDENCE', 'FIELD_0']
input [2-1:0] REG4_PRECEDENCE__FIELD_0__next_value;
input REG4_PRECEDENCE__FIELD_0__pulse;
output [2-1:0] REG4_PRECEDENCE__FIELD_0__curr_value;
//['REG5_SINGLEPULSE', 'FIELD_0']
input [1-1:0] REG5_SINGLEPULSE__FIELD_0__next_value;
input REG5_SINGLEPULSE__FIELD_0__pulse;
output [1-1:0] REG5_SINGLEPULSE__FIELD_0__curr_value;
//['REG6_SW_ACC_MOD', 'FIELD_0']
input [2-1:0] REG6_SW_ACC_MOD__FIELD_0__next_value;
input REG6_SW_ACC_MOD__FIELD_0__pulse;
output [2-1:0] REG6_SW_ACC_MOD__FIELD_0__curr_value;
output REG6_SW_ACC_MOD__FIELD_0__swmod_out;
output REG6_SW_ACC_MOD__FIELD_0__swacc_out;
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
assign addr_for_decode = req_rdy ? addr : fsm__slv__addr;// req_rdy = 1 : fsm_state in IDLE for internal operation
wire [DATA_WIDTH-1:0] internal_wr_data;
assign internal_wr_data = req_rdy ? wr_data : fsm__slv__wr_data;
wire internal_wr_en;
assign internal_wr_en = req_rdy ? wr_en : fsm__slv__wr_en;
wire internal_rd_en;
assign internal_rd_en = req_rdy ? rd_en : fsm__slv__rd_en;
wire [REG_NUM-1:0] wr_sel_ff;
wire [REG_NUM-1:0] rd_sel_ff;
assign wr_sel_ff = {REG_NUM{internal_wr_en}} & reg_sel;
assign rd_sel_ff = {REG_NUM{internal_rd_en}} & reg_sel;
//****************************************WIRE DECLARATION END****************************************//




//********************************Rd_data/Ack_vld Split Mux START Here********************************//
split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(N+1), .GROUP_SIZE(64)) rd_split_mux
(.clk(clk), .rst_n(rstn),
.din({reg_rd_data_in,{DATA_WIDTH{1'b0}}}), .sel({rd_sel_ff,dummy_reg}),
.dout(internal_reg_rd_data_vld), .dout_vld(internal_reg_ack_vld)
);
//*********************************Rd_data/Ack_vld Split Mux END Here*********************************//


//*************************Final Split Mux OUT Signal Definitinon START Here**************************//
// select which to read out and transfer the corresponding vld signal
assign slv__fsm__rd_data = internal_reg_ack_vld ? internal_reg_rd_data_vld : 0;
assign slv__fsm__ack_vld = internal_reg_ack_vld | (internal_wr_en & internal_reg_selected);
//**************************Final Split Mux OUT Signal Definitinon END Here***************************//


//***************************internal register operation wire declare START***************************//
logic [31:0] REG1_SW_RW_wr_data;
logic [31:0] REG2_SW_W_wr_data;
logic [31:0] REG3_HW_wr_data;
logic [31:0] REG4_PRECEDENCE_wr_data;
logic [31:0] REG5_SINGLEPULSE_wr_data;
logic [31:0] REG6_SW_ACC_MOD_wr_data;
logic [31:0] REG1_SW_R_W_alias_wr_data;
logic [31:0] REG2_SRST_alias_wr_data;
//****************************internal register operation wire declare END****************************//


//************************************Address Decoding START Here*************************************//
always_comb begin
		reg_sel = {REG_NUM{1'b0}};
		ext_sel = {EXT_NUM{1'b0}};
		dummy_reg = 1'b0;
	unique case (addr_for_decode)
		64'h0:reg_sel[0] = 1'b1;//['REG1_SW_RW']
		64'h4:reg_sel[1] = 1'b1;//['REG2_SW_W']
		64'h8:reg_sel[2] = 1'b1;//['REG3_HW']
		64'hc:reg_sel[3] = 1'b1;//['REG4_PRECEDENCE']
		64'h10:reg_sel[4] = 1'b1;//['REG5_SINGLEPULSE']
		64'h14:reg_sel[5] = 1'b1;//['REG6_SW_ACC_MOD']
		64'h100:reg_sel[6] = 1'b1;//['REG1_SW_R_W_alias']
		64'h104:reg_sel[7] = 1'b1;//['REG2_SRST_alias']
		default: dummy_reg = 1'b1;
	endcase
end
//*************************************Address Decoding END Here**************************************//


//************************************STATE MACHINE INSTANCE START************************************//
slv_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
	slv_fsm_test_11 (
	.clk(clk), .rstn(rstn), .mst__fsm__req_vld(req_vld), .mst__fsm__wr_en(wr_en), .mst__fsm__rd_en(rd_en), .mst__fsm__addr(addr), .mst__fsm__wr_data(wr_data),
	.slv__fsm__rd_data(slv__fsm__rd_data), .slv__fsm__ack_vld(slv__fsm__ack_vld), .fsm__slv__req_vld(fsm__slv__req_vld),
	.fsm__slv__wr_en(fsm__slv__wr_en), .fsm__slv__rd_en(fsm__slv__rd_en), .fsm__slv__addr(fsm__slv__addr), .fsm__slv__wr_data(fsm__slv__wr_data),
	.fsm__mst__req_rdy(req_rdy), .mst__fsm__ack_rdy(ack_rdy),
	.slv__fsm__req_rdy(slv__fsm__req_rdy), .fsm__slv__ack_rdy(ext_ack_rdy),
	.fsm__mst__rd_data(rd_data), .fsm__mst__ack_vld(ack_vld),
	.external_reg_selected(external_reg_selected),
	.mst__fsm__sync_reset(global_sync_reset_in),
	.fsm__slv__sync_reset(global_sync_reset_out)
	);
//*************************************STATE MACHINE INSTANCE END*************************************//


//*******************************Register&field Instantiate START Here********************************//
//============================================REG INSTANT=============================================//
//REG NAME: REG1_SW_RW//
//REG HIERARCHY: ['REG1_SW_RW']//
//REG ABSOLUTE_ADDR:64'h0//
//REG OFFSET_ADDR:64'h64'h0//
logic [31:0] REG1_SW_RW;
assign REG1_SW_RW_wr_data = reg_sel[0] && internal_wr_en ? internal_wr_data : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_RW,`SW_WO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WZT,`WZT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG1_SW_RW__FIELD_8
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({REG1_SW_RW_wr_data[13:12],REG1_SW_R_W_alias_wr_data[13:12]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG1_SW_RW__FIELD_8__next_value),
	.hw_pulse(REG1_SW_RW__FIELD_8__pulse),
	.field_value(REG1_SW_RW__FIELD_8__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_RW,`SW_WO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WZS,`WZS}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG1_SW_RW__FIELD_7
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({REG1_SW_RW_wr_data[15:14],REG1_SW_R_W_alias_wr_data[15:14]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG1_SW_RW__FIELD_7__next_value),
	.hw_pulse(REG1_SW_RW__FIELD_7__pulse),
	.field_value(REG1_SW_RW__FIELD_7__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_RW,`SW_WO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WZC,`WZC}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG1_SW_RW__FIELD_6
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({REG1_SW_RW_wr_data[17:16],REG1_SW_R_W_alias_wr_data[17:16]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG1_SW_RW__FIELD_6__next_value),
	.hw_pulse(REG1_SW_RW__FIELD_6__pulse),
	.field_value(REG1_SW_RW__FIELD_6__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_RW,`SW_WO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WOT,`WOT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG1_SW_RW__FIELD_5
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({REG1_SW_RW_wr_data[19:18],REG1_SW_R_W_alias_wr_data[19:18]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG1_SW_RW__FIELD_5__next_value),
	.hw_pulse(REG1_SW_RW__FIELD_5__pulse),
	.field_value(REG1_SW_RW__FIELD_5__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_RW,`SW_WO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WOSET,`WOSET}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG1_SW_RW__FIELD_4
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({REG1_SW_RW_wr_data[21:20],REG1_SW_R_W_alias_wr_data[21:20]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG1_SW_RW__FIELD_4__next_value),
	.hw_pulse(REG1_SW_RW__FIELD_4__pulse),
	.field_value(REG1_SW_RW__FIELD_4__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_RW,`SW_WO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WOCLR,`WOCLR}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG1_SW_RW__FIELD_3
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({REG1_SW_RW_wr_data[23:22],REG1_SW_R_W_alias_wr_data[23:22]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG1_SW_RW__FIELD_3__next_value),
	.hw_pulse(REG1_SW_RW__FIELD_3__pulse),
	.field_value(REG1_SW_RW__FIELD_3__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_RW,`SW_RO}),
	.SW_ONREAD_TYPE({`RSET,`RSET}),
	.SW_ONWRITE_TYPE({`NA,`NA}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG1_SW_RW__FIELD_2
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({REG1_SW_RW_wr_data[25:24],REG1_SW_R_W_alias_wr_data[25:24]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG1_SW_RW__FIELD_2__next_value),
	.hw_pulse(REG1_SW_RW__FIELD_2__pulse),
	.field_value(REG1_SW_RW__FIELD_2__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_RW,`SW_RO}),
	.SW_ONREAD_TYPE({`RCLR,`RCLR}),
	.SW_ONWRITE_TYPE({`NA,`NA}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG1_SW_RW__FIELD_1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({REG1_SW_RW_wr_data[27:26],REG1_SW_R_W_alias_wr_data[27:26]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG1_SW_RW__FIELD_1__next_value),
	.hw_pulse(REG1_SW_RW__FIELD_1__pulse),
	.field_value(REG1_SW_RW__FIELD_1__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_RW,`SW_RO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`NA,`NA}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG1_SW_RW__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({REG1_SW_RW_wr_data[29:28],REG1_SW_R_W_alias_wr_data[29:28]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG1_SW_RW__FIELD_0__next_value),
	.hw_pulse(REG1_SW_RW__FIELD_0__pulse),
	.field_value(REG1_SW_RW__FIELD_0__curr_value)
	);
always_comb begin
	REG1_SW_RW[31:0] = 32'h0;
	REG1_SW_RW[13:12] = REG1_SW_RW__FIELD_8__curr_value;
	REG1_SW_RW[15:14] = REG1_SW_RW__FIELD_7__curr_value;
	REG1_SW_RW[17:16] = REG1_SW_RW__FIELD_6__curr_value;
	REG1_SW_RW[19:18] = REG1_SW_RW__FIELD_5__curr_value;
	REG1_SW_RW[21:20] = REG1_SW_RW__FIELD_4__curr_value;
	REG1_SW_RW[23:22] = REG1_SW_RW__FIELD_3__curr_value;
	REG1_SW_RW[25:24] = REG1_SW_RW__FIELD_2__curr_value;
	REG1_SW_RW[27:26] = REG1_SW_RW__FIELD_1__curr_value;
	REG1_SW_RW[29:28] = REG1_SW_RW__FIELD_0__curr_value;
end
assign reg_rd_data_in[0] = REG1_SW_RW;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: REG2_SW_W//
//REG HIERARCHY: ['REG2_SW_W']//
//REG ABSOLUTE_ADDR:64'h4//
//REG OFFSET_ADDR:64'h64'h4//
logic [31:0] REG2_SW_W;
assign REG2_SW_W_wr_data = reg_sel[1] && internal_wr_en ? internal_wr_data : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_WO,`SW_WO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WZT,`WZT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG2_SW_W__FIELD_6
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({REG2_SW_W_wr_data[19:18],REG2_SRST_alias_wr_data[19:18]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG2_SW_W__FIELD_6__next_value),
	.hw_pulse(REG2_SW_W__FIELD_6__pulse),
	.field_value(REG2_SW_W__FIELD_6__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_WO,`SW_WO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WZS,`WZS}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG2_SW_W__FIELD_5
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({REG2_SW_W_wr_data[21:20],REG2_SRST_alias_wr_data[21:20]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG2_SW_W__FIELD_5__next_value),
	.hw_pulse(REG2_SW_W__FIELD_5__pulse),
	.field_value(REG2_SW_W__FIELD_5__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_WO,`SW_WO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WZC,`WZC}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG2_SW_W__FIELD_4
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({REG2_SW_W_wr_data[23:22],REG2_SRST_alias_wr_data[23:22]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG2_SW_W__FIELD_4__next_value),
	.hw_pulse(REG2_SW_W__FIELD_4__pulse),
	.field_value(REG2_SW_W__FIELD_4__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_WO,`SW_WO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WOT,`WOT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG2_SW_W__FIELD_3
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({REG2_SW_W_wr_data[25:24],REG2_SRST_alias_wr_data[25:24]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG2_SW_W__FIELD_3__next_value),
	.hw_pulse(REG2_SW_W__FIELD_3__pulse),
	.field_value(REG2_SW_W__FIELD_3__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.SRST_CNT(1),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_WO,`SW_WO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WOSET,`WOSET}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG2_SW_W__FIELD_2
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst({srst_2}),
	.sw_wr_data({REG2_SW_W_wr_data[27:26],REG2_SRST_alias_wr_data[27:26]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG2_SW_W__FIELD_2__next_value),
	.hw_pulse(REG2_SW_W__FIELD_2__pulse),
	.field_value(REG2_SW_W__FIELD_2__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.SRST_CNT(1),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_WO,`SW_WO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WOCLR,`WOCLR}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG2_SW_W__FIELD_1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst({srst_1}),
	.sw_wr_data({REG2_SW_W_wr_data[29:28],REG2_SRST_alias_wr_data[29:28]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG2_SW_W__FIELD_1__next_value),
	.hw_pulse(REG2_SW_W__FIELD_1__pulse),
	.field_value(REG2_SW_W__FIELD_1__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_WO,`SW_WO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`NA,`NA}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG2_SW_W__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({REG2_SW_W_wr_data[31:30],REG2_SRST_alias_wr_data[31:30]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG2_SW_W__FIELD_0__next_value),
	.hw_pulse(REG2_SW_W__FIELD_0__pulse),
	.field_value(REG2_SW_W__FIELD_0__curr_value)
	);
always_comb begin
	REG2_SW_W[31:0] = 32'h0;
end
assign reg_rd_data_in[1] = REG2_SW_W;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: REG3_HW//
//REG HIERARCHY: ['REG3_HW']//
//REG ABSOLUTE_ADDR:64'h8//
//REG OFFSET_ADDR:64'h64'h8//
logic [31:0] REG3_HW;
assign REG3_HW_wr_data = reg_sel[2] && internal_wr_en ? internal_wr_data : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.SW_TYPE({`SW_RW}),
	.SW_ONREAD_TYPE({`NA}),
	.SW_ONWRITE_TYPE({`NA}),
	.HW_TYPE(`HW_SET),
	.PRECEDENCE(`SW)
	)
x__REG3_HW__FIELD_3
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(REG3_HW_wr_data[25:24]),
	.sw_rd(rd_sel_ff[2]),
	.sw_wr(wr_sel_ff[2]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG3_HW__FIELD_3__next_value),
	.hw_pulse(REG3_HW__FIELD_3__pulse),
	.field_value(REG3_HW__FIELD_3__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.SW_TYPE({`SW_RW}),
	.SW_ONREAD_TYPE({`NA}),
	.SW_ONWRITE_TYPE({`NA}),
	.HW_TYPE(`HW_CLR),
	.PRECEDENCE(`SW)
	)
x__REG3_HW__FIELD_2
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(REG3_HW_wr_data[27:26]),
	.sw_rd(rd_sel_ff[2]),
	.sw_wr(wr_sel_ff[2]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG3_HW__FIELD_2__next_value),
	.hw_pulse(REG3_HW__FIELD_2__pulse),
	.field_value(REG3_HW__FIELD_2__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.SW_TYPE({`SW_RW}),
	.SW_ONREAD_TYPE({`NA}),
	.SW_ONWRITE_TYPE({`WOCLR}),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(`SW)
	)
x__REG3_HW__FIELD_1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(REG3_HW_wr_data[29:28]),
	.sw_rd(rd_sel_ff[2]),
	.sw_wr(wr_sel_ff[2]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(2'b0),
	.hw_pulse(1'b0),
	.field_value(REG3_HW__FIELD_1__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.SW_TYPE({`SW_RW}),
	.SW_ONREAD_TYPE({`NA}),
	.SW_ONWRITE_TYPE({`NA}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG3_HW__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(REG3_HW_wr_data[31:30]),
	.sw_rd(rd_sel_ff[2]),
	.sw_wr(wr_sel_ff[2]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG3_HW__FIELD_0__next_value),
	.hw_pulse(REG3_HW__FIELD_0__pulse),
	.field_value(REG3_HW__FIELD_0__curr_value)
	);
always_comb begin
	REG3_HW[31:0] = 32'h0;
	REG3_HW[25:24] = REG3_HW__FIELD_3__curr_value;
	REG3_HW[27:26] = REG3_HW__FIELD_2__curr_value;
	REG3_HW[29:28] = REG3_HW__FIELD_1__curr_value;
	REG3_HW[31:30] = REG3_HW__FIELD_0__curr_value;
end
assign reg_rd_data_in[2] = REG3_HW;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: REG4_PRECEDENCE//
//REG HIERARCHY: ['REG4_PRECEDENCE']//
//REG ABSOLUTE_ADDR:64'hc//
//REG OFFSET_ADDR:64'h64'hc//
logic [31:0] REG4_PRECEDENCE;
assign REG4_PRECEDENCE_wr_data = reg_sel[3] && internal_wr_en ? internal_wr_data : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.SW_TYPE({`SW_RW}),
	.SW_ONREAD_TYPE({`NA}),
	.SW_ONWRITE_TYPE({`NA}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`HW)
	)
x__REG4_PRECEDENCE__FIELD_1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(REG4_PRECEDENCE_wr_data[29:28]),
	.sw_rd(rd_sel_ff[3]),
	.sw_wr(wr_sel_ff[3]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG4_PRECEDENCE__FIELD_1__next_value),
	.hw_pulse(REG4_PRECEDENCE__FIELD_1__pulse),
	.field_value(REG4_PRECEDENCE__FIELD_1__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.SW_TYPE({`SW_RW}),
	.SW_ONREAD_TYPE({`NA}),
	.SW_ONWRITE_TYPE({`NA}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG4_PRECEDENCE__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(REG4_PRECEDENCE_wr_data[31:30]),
	.sw_rd(rd_sel_ff[3]),
	.sw_wr(wr_sel_ff[3]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG4_PRECEDENCE__FIELD_0__next_value),
	.hw_pulse(REG4_PRECEDENCE__FIELD_0__pulse),
	.field_value(REG4_PRECEDENCE__FIELD_0__curr_value)
	);
always_comb begin
	REG4_PRECEDENCE[31:0] = 32'h0;
	REG4_PRECEDENCE[29:28] = REG4_PRECEDENCE__FIELD_1__curr_value;
	REG4_PRECEDENCE[31:30] = REG4_PRECEDENCE__FIELD_0__curr_value;
end
assign reg_rd_data_in[3] = REG4_PRECEDENCE;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: REG5_SINGLEPULSE//
//REG HIERARCHY: ['REG5_SINGLEPULSE']//
//REG ABSOLUTE_ADDR:64'h10//
//REG OFFSET_ADDR:64'h64'h10//
logic [31:0] REG5_SINGLEPULSE;
assign REG5_SINGLEPULSE_wr_data = reg_sel[4] && internal_wr_en ? internal_wr_data : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(1),
	.ARST_VALUE(1'h0),
	.SW_TYPE({`SW_RW}),
	.SW_ONREAD_TYPE({`NA}),
	.SW_ONWRITE_TYPE({`NA}),
	.PULSE({1}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG5_SINGLEPULSE__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(REG5_SINGLEPULSE_wr_data[31:31]),
	.sw_rd(rd_sel_ff[4]),
	.sw_wr(wr_sel_ff[4]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(REG5_SINGLEPULSE__FIELD_0__next_value),
	.hw_pulse(REG5_SINGLEPULSE__FIELD_0__pulse),
	.field_value(REG5_SINGLEPULSE__FIELD_0__curr_value)
	);
always_comb begin
	REG5_SINGLEPULSE[31:0] = 32'h0;
	REG5_SINGLEPULSE[31:31] = REG5_SINGLEPULSE__FIELD_0__curr_value;
end
assign reg_rd_data_in[4] = REG5_SINGLEPULSE;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: REG6_SW_ACC_MOD//
//REG HIERARCHY: ['REG6_SW_ACC_MOD']//
//REG ABSOLUTE_ADDR:64'h14//
//REG OFFSET_ADDR:64'h64'h14//
logic [31:0] REG6_SW_ACC_MOD;
assign REG6_SW_ACC_MOD_wr_data = reg_sel[5] && internal_wr_en ? internal_wr_data : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.SW_TYPE({`SW_RW}),
	.SW_ONREAD_TYPE({`NA}),
	.SW_ONWRITE_TYPE({`NA}),
	.SWMOD({1}),
	.SWACC({1}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__REG6_SW_ACC_MOD__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(REG6_SW_ACC_MOD_wr_data[31:30]),
	.sw_rd(rd_sel_ff[5]),
	.sw_wr(wr_sel_ff[5]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(REG6_SW_ACC_MOD__FIELD_0__swmod_out),
	.swacc_out(REG6_SW_ACC_MOD__FIELD_0__swacc_out),
	.hw_value(REG6_SW_ACC_MOD__FIELD_0__next_value),
	.hw_pulse(REG6_SW_ACC_MOD__FIELD_0__pulse),
	.field_value(REG6_SW_ACC_MOD__FIELD_0__curr_value)
	);
always_comb begin
	REG6_SW_ACC_MOD[31:0] = 32'h0;
	REG6_SW_ACC_MOD[31:30] = REG6_SW_ACC_MOD__FIELD_0__curr_value;
end
assign reg_rd_data_in[5] = REG6_SW_ACC_MOD;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: REG1_SW_R_W_alias//
//REG HIERARCHY: ['REG1_SW_R_W_alias']//
//REG ABSOLUTE_ADDR:64'h100//
//REG OFFSET_ADDR:64'h64'h100//
logic [31:0] REG1_SW_R_W_alias;
assign REG1_SW_R_W_alias_wr_data = reg_sel[6] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	REG1_SW_R_W_alias[31:0] = 32'h0;
	REG1_SW_R_W_alias[13:12] = REG1_SW_RW__FIELD_8__curr_value;
	REG1_SW_R_W_alias[15:14] = REG1_SW_RW__FIELD_7__curr_value;
	REG1_SW_R_W_alias[17:16] = REG1_SW_RW__FIELD_6__curr_value;
	REG1_SW_R_W_alias[19:18] = REG1_SW_RW__FIELD_5__curr_value;
	REG1_SW_R_W_alias[21:20] = REG1_SW_RW__FIELD_4__curr_value;
	REG1_SW_R_W_alias[23:22] = REG1_SW_RW__FIELD_3__curr_value;
	REG1_SW_R_W_alias[25:24] = REG1_SW_RW__FIELD_2__curr_value;
	REG1_SW_R_W_alias[27:26] = REG1_SW_RW__FIELD_1__curr_value;
	REG1_SW_R_W_alias[29:28] = REG1_SW_RW__FIELD_0__curr_value;
end
assign reg_rd_data_in[6] = REG1_SW_R_W_alias;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: REG2_SRST_alias//
//REG HIERARCHY: ['REG2_SRST_alias']//
//REG ABSOLUTE_ADDR:64'h104//
//REG OFFSET_ADDR:64'h64'h104//
logic [31:0] REG2_SRST_alias;
assign REG2_SRST_alias_wr_data = reg_sel[7] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	REG2_SRST_alias[31:0] = 32'h0;
end
assign reg_rd_data_in[7] = REG2_SRST_alias;
//==========================================END REG INSTANT===========================================//
//********************************Register&field Instantiate END Here*********************************//
endmodule