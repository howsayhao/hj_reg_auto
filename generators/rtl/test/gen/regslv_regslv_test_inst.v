`include "xregister.vh"
module regslv_regslv_test_inst(
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
//['test_1_inst', 'REG1_SW_RW', 'FIELD_9']
	test_1_inst_REG1_SW_RW__FIELD_9__next_value,
	test_1_inst_REG1_SW_RW__FIELD_9__pulse,
	test_1_inst_REG1_SW_RW__FIELD_9__curr_value,
//['test_1_inst', 'REG1_SW_RW', 'FIELD_8']
	test_1_inst_REG1_SW_RW__FIELD_8__next_value,
	test_1_inst_REG1_SW_RW__FIELD_8__pulse,
	test_1_inst_REG1_SW_RW__FIELD_8__curr_value,
//['test_1_inst', 'REG1_SW_RW', 'FIELD_7']
	test_1_inst_REG1_SW_RW__FIELD_7__next_value,
	test_1_inst_REG1_SW_RW__FIELD_7__pulse,
	test_1_inst_REG1_SW_RW__FIELD_7__curr_value,
//['test_1_inst', 'REG1_SW_RW', 'FIELD_6']
	test_1_inst_REG1_SW_RW__FIELD_6__next_value,
	test_1_inst_REG1_SW_RW__FIELD_6__pulse,
	test_1_inst_REG1_SW_RW__FIELD_6__curr_value,
//['test_1_inst', 'REG1_SW_RW', 'FIELD_5']
	test_1_inst_REG1_SW_RW__FIELD_5__next_value,
	test_1_inst_REG1_SW_RW__FIELD_5__pulse,
	test_1_inst_REG1_SW_RW__FIELD_5__curr_value,
//['test_1_inst', 'REG1_SW_RW', 'FIELD_4']
	test_1_inst_REG1_SW_RW__FIELD_4__next_value,
	test_1_inst_REG1_SW_RW__FIELD_4__pulse,
	test_1_inst_REG1_SW_RW__FIELD_4__curr_value,
//['test_1_inst', 'REG1_SW_RW', 'FIELD_3']
	test_1_inst_REG1_SW_RW__FIELD_3__next_value,
	test_1_inst_REG1_SW_RW__FIELD_3__pulse,
	test_1_inst_REG1_SW_RW__FIELD_3__curr_value,
//['test_1_inst', 'REG1_SW_RW', 'FIELD_2']
	test_1_inst_REG1_SW_RW__FIELD_2__next_value,
	test_1_inst_REG1_SW_RW__FIELD_2__pulse,
	test_1_inst_REG1_SW_RW__FIELD_2__curr_value,
//['test_1_inst', 'REG1_SW_RW', 'FIELD_1']
	test_1_inst_REG1_SW_RW__FIELD_1__next_value,
	test_1_inst_REG1_SW_RW__FIELD_1__pulse,
	test_1_inst_REG1_SW_RW__FIELD_1__curr_value,
//['test_1_inst', 'REG2_SW_W', 'FIELD_6']
	test_1_inst_REG2_SW_W__FIELD_6__next_value,
	test_1_inst_REG2_SW_W__FIELD_6__pulse,
	test_1_inst_REG2_SW_W__FIELD_6__curr_value,
//['test_1_inst', 'REG2_SW_W', 'FIELD_5']
	test_1_inst_REG2_SW_W__FIELD_5__next_value,
	test_1_inst_REG2_SW_W__FIELD_5__pulse,
	test_1_inst_REG2_SW_W__FIELD_5__curr_value,
//['test_1_inst', 'REG2_SW_W', 'FIELD_4']
	test_1_inst_REG2_SW_W__FIELD_4__next_value,
	test_1_inst_REG2_SW_W__FIELD_4__pulse,
	test_1_inst_REG2_SW_W__FIELD_4__curr_value,
//['test_1_inst', 'REG2_SW_W', 'FIELD_3']
	test_1_inst_REG2_SW_W__FIELD_3__next_value,
	test_1_inst_REG2_SW_W__FIELD_3__pulse,
	test_1_inst_REG2_SW_W__FIELD_3__curr_value,
//['test_1_inst', 'REG2_SW_W', 'FIELD_2']
	test_1_inst_REG2_SW_W__FIELD_2__next_value,
	test_1_inst_REG2_SW_W__FIELD_2__pulse,
	test_1_inst_REG2_SW_W__FIELD_2__curr_value,
//['test_1_inst', 'REG2_SW_W', 'FIELD_1']
	test_1_inst_REG2_SW_W__FIELD_1__next_value,
	test_1_inst_REG2_SW_W__FIELD_1__pulse,
	test_1_inst_REG2_SW_W__FIELD_1__curr_value,
//['test_1_inst', 'REG2_SW_W', 'FIELD_0']
	test_1_inst_REG2_SW_W__FIELD_0__next_value,
	test_1_inst_REG2_SW_W__FIELD_0__pulse,
	test_1_inst_REG2_SW_W__FIELD_0__curr_value,
//['test_1_inst', 'REG3_HW', 'FIELD_3']
	test_1_inst_REG3_HW__FIELD_3__next_value,
	test_1_inst_REG3_HW__FIELD_3__pulse,
	test_1_inst_REG3_HW__FIELD_3__curr_value,
//['test_1_inst', 'REG3_HW', 'FIELD_2']
	test_1_inst_REG3_HW__FIELD_2__next_value,
	test_1_inst_REG3_HW__FIELD_2__pulse,
	test_1_inst_REG3_HW__FIELD_2__curr_value,
	test_1_inst_REG3_HW__FIELD_1__curr_value,
//['test_1_inst', 'REG3_HW', 'FIELD_0']
	test_1_inst_REG3_HW__FIELD_0__next_value,
	test_1_inst_REG3_HW__FIELD_0__pulse,
	test_1_inst_REG3_HW__FIELD_0__curr_value,
//['test_1_inst', 'REG4_PRECEDENCE', 'FIELD_1']
	test_1_inst_REG4_PRECEDENCE__FIELD_1__next_value,
	test_1_inst_REG4_PRECEDENCE__FIELD_1__pulse,
	test_1_inst_REG4_PRECEDENCE__FIELD_1__curr_value,
//['test_1_inst', 'REG4_PRECEDENCE', 'FIELD_0']
	test_1_inst_REG4_PRECEDENCE__FIELD_0__next_value,
	test_1_inst_REG4_PRECEDENCE__FIELD_0__pulse,
	test_1_inst_REG4_PRECEDENCE__FIELD_0__curr_value,
//['test_1_inst', 'REG5_SINGLEPULSE', 'FIELD_0']
	test_1_inst_REG5_SINGLEPULSE__FIELD_0__next_value,
	test_1_inst_REG5_SINGLEPULSE__FIELD_0__pulse,
	test_1_inst_REG5_SINGLEPULSE__FIELD_0__curr_value,
//['test_1_inst', 'REG6_SW_ACC_MOD', 'FIELD_0']
	test_1_inst_REG6_SW_ACC_MOD__FIELD_0__next_value,
	test_1_inst_REG6_SW_ACC_MOD__FIELD_0__pulse,
	test_1_inst_REG6_SW_ACC_MOD__FIELD_0__curr_value,
	test_1_inst_REG6_SW_ACC_MOD__FIELD_0__swmod_out,
	test_1_inst_REG6_SW_ACC_MOD__FIELD_0__swacc_out,
//['test_2_inst', 'shared_2', 'FIELD_0']
	test_2_inst_shared_2__FIELD_0__next_value,
	test_2_inst_shared_2__FIELD_0__pulse,
	test_2_inst_shared_2__FIELD_0__curr_value,
//*********************************INTERNAL field connection port END*********************************//
	clk,
	rstn,
	req_vld,
	req_rdy,
	wr_en,rd_en,
	addr,
	wr_data,
	global_sync_reset_in,
	global_sync_reset_out,
	test_1_inst_srst_1,
	test_1_inst_srst_2,
	ack_vld,
	ack_rdy,
	rd_data
);
//**********************************PARAMETER Definition START Here***********************************//
parameter ADDR_WIDTH = 64;
parameter DATA_WIDTH = 32;
//N:number of internal registers, M:number of external modules
localparam N = 10;
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
input test_1_inst_srst_1;
input test_1_inst_srst_2;
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

//**************************INTERNAL REGISTER IN/OUT PORTS DEFINE START Here**************************//
//['test_1_inst', 'REG1_SW_RW', 'FIELD_9']
input [2-1:0] test_1_inst_REG1_SW_RW__FIELD_9__next_value;
input test_1_inst_REG1_SW_RW__FIELD_9__pulse;
output [2-1:0] test_1_inst_REG1_SW_RW__FIELD_9__curr_value;
//['test_1_inst', 'REG1_SW_RW', 'FIELD_8']
input [2-1:0] test_1_inst_REG1_SW_RW__FIELD_8__next_value;
input test_1_inst_REG1_SW_RW__FIELD_8__pulse;
output [2-1:0] test_1_inst_REG1_SW_RW__FIELD_8__curr_value;
//['test_1_inst', 'REG1_SW_RW', 'FIELD_7']
input [2-1:0] test_1_inst_REG1_SW_RW__FIELD_7__next_value;
input test_1_inst_REG1_SW_RW__FIELD_7__pulse;
output [2-1:0] test_1_inst_REG1_SW_RW__FIELD_7__curr_value;
//['test_1_inst', 'REG1_SW_RW', 'FIELD_6']
input [2-1:0] test_1_inst_REG1_SW_RW__FIELD_6__next_value;
input test_1_inst_REG1_SW_RW__FIELD_6__pulse;
output [2-1:0] test_1_inst_REG1_SW_RW__FIELD_6__curr_value;
//['test_1_inst', 'REG1_SW_RW', 'FIELD_5']
input [2-1:0] test_1_inst_REG1_SW_RW__FIELD_5__next_value;
input test_1_inst_REG1_SW_RW__FIELD_5__pulse;
output [2-1:0] test_1_inst_REG1_SW_RW__FIELD_5__curr_value;
//['test_1_inst', 'REG1_SW_RW', 'FIELD_4']
input [2-1:0] test_1_inst_REG1_SW_RW__FIELD_4__next_value;
input test_1_inst_REG1_SW_RW__FIELD_4__pulse;
output [2-1:0] test_1_inst_REG1_SW_RW__FIELD_4__curr_value;
//['test_1_inst', 'REG1_SW_RW', 'FIELD_3']
input [2-1:0] test_1_inst_REG1_SW_RW__FIELD_3__next_value;
input test_1_inst_REG1_SW_RW__FIELD_3__pulse;
output [2-1:0] test_1_inst_REG1_SW_RW__FIELD_3__curr_value;
//['test_1_inst', 'REG1_SW_RW', 'FIELD_2']
input [2-1:0] test_1_inst_REG1_SW_RW__FIELD_2__next_value;
input test_1_inst_REG1_SW_RW__FIELD_2__pulse;
output [2-1:0] test_1_inst_REG1_SW_RW__FIELD_2__curr_value;
//['test_1_inst', 'REG1_SW_RW', 'FIELD_1']
input [2-1:0] test_1_inst_REG1_SW_RW__FIELD_1__next_value;
input test_1_inst_REG1_SW_RW__FIELD_1__pulse;
output [2-1:0] test_1_inst_REG1_SW_RW__FIELD_1__curr_value;
//['test_1_inst', 'REG2_SW_W', 'FIELD_6']
input [2-1:0] test_1_inst_REG2_SW_W__FIELD_6__next_value;
input test_1_inst_REG2_SW_W__FIELD_6__pulse;
output [2-1:0] test_1_inst_REG2_SW_W__FIELD_6__curr_value;
//['test_1_inst', 'REG2_SW_W', 'FIELD_5']
input [2-1:0] test_1_inst_REG2_SW_W__FIELD_5__next_value;
input test_1_inst_REG2_SW_W__FIELD_5__pulse;
output [2-1:0] test_1_inst_REG2_SW_W__FIELD_5__curr_value;
//['test_1_inst', 'REG2_SW_W', 'FIELD_4']
input [2-1:0] test_1_inst_REG2_SW_W__FIELD_4__next_value;
input test_1_inst_REG2_SW_W__FIELD_4__pulse;
output [2-1:0] test_1_inst_REG2_SW_W__FIELD_4__curr_value;
//['test_1_inst', 'REG2_SW_W', 'FIELD_3']
input [2-1:0] test_1_inst_REG2_SW_W__FIELD_3__next_value;
input test_1_inst_REG2_SW_W__FIELD_3__pulse;
output [2-1:0] test_1_inst_REG2_SW_W__FIELD_3__curr_value;
//['test_1_inst', 'REG2_SW_W', 'FIELD_2']
input [2-1:0] test_1_inst_REG2_SW_W__FIELD_2__next_value;
input test_1_inst_REG2_SW_W__FIELD_2__pulse;
output [2-1:0] test_1_inst_REG2_SW_W__FIELD_2__curr_value;
//['test_1_inst', 'REG2_SW_W', 'FIELD_1']
input [2-1:0] test_1_inst_REG2_SW_W__FIELD_1__next_value;
input test_1_inst_REG2_SW_W__FIELD_1__pulse;
output [2-1:0] test_1_inst_REG2_SW_W__FIELD_1__curr_value;
//['test_1_inst', 'REG2_SW_W', 'FIELD_0']
input [2-1:0] test_1_inst_REG2_SW_W__FIELD_0__next_value;
input test_1_inst_REG2_SW_W__FIELD_0__pulse;
output [2-1:0] test_1_inst_REG2_SW_W__FIELD_0__curr_value;
//['test_1_inst', 'REG3_HW', 'FIELD_3']
input [2-1:0] test_1_inst_REG3_HW__FIELD_3__next_value;
input test_1_inst_REG3_HW__FIELD_3__pulse;
output [2-1:0] test_1_inst_REG3_HW__FIELD_3__curr_value;
//['test_1_inst', 'REG3_HW', 'FIELD_2']
input [2-1:0] test_1_inst_REG3_HW__FIELD_2__next_value;
input test_1_inst_REG3_HW__FIELD_2__pulse;
output [2-1:0] test_1_inst_REG3_HW__FIELD_2__curr_value;
output [2-1:0] test_1_inst_REG3_HW__FIELD_1__curr_value;
//['test_1_inst', 'REG3_HW', 'FIELD_0']
input [2-1:0] test_1_inst_REG3_HW__FIELD_0__next_value;
input test_1_inst_REG3_HW__FIELD_0__pulse;
output [2-1:0] test_1_inst_REG3_HW__FIELD_0__curr_value;
//['test_1_inst', 'REG4_PRECEDENCE', 'FIELD_1']
input [2-1:0] test_1_inst_REG4_PRECEDENCE__FIELD_1__next_value;
input test_1_inst_REG4_PRECEDENCE__FIELD_1__pulse;
output [2-1:0] test_1_inst_REG4_PRECEDENCE__FIELD_1__curr_value;
//['test_1_inst', 'REG4_PRECEDENCE', 'FIELD_0']
input [2-1:0] test_1_inst_REG4_PRECEDENCE__FIELD_0__next_value;
input test_1_inst_REG4_PRECEDENCE__FIELD_0__pulse;
output [2-1:0] test_1_inst_REG4_PRECEDENCE__FIELD_0__curr_value;
//['test_1_inst', 'REG5_SINGLEPULSE', 'FIELD_0']
input [1-1:0] test_1_inst_REG5_SINGLEPULSE__FIELD_0__next_value;
input test_1_inst_REG5_SINGLEPULSE__FIELD_0__pulse;
output [1-1:0] test_1_inst_REG5_SINGLEPULSE__FIELD_0__curr_value;
//['test_1_inst', 'REG6_SW_ACC_MOD', 'FIELD_0']
input [2-1:0] test_1_inst_REG6_SW_ACC_MOD__FIELD_0__next_value;
input test_1_inst_REG6_SW_ACC_MOD__FIELD_0__pulse;
output [2-1:0] test_1_inst_REG6_SW_ACC_MOD__FIELD_0__curr_value;
output test_1_inst_REG6_SW_ACC_MOD__FIELD_0__swmod_out;
output test_1_inst_REG6_SW_ACC_MOD__FIELD_0__swacc_out;
//['test_2_inst', 'shared_2', 'FIELD_0']
input [32-1:0] test_2_inst_shared_2__FIELD_0__next_value;
input test_2_inst_shared_2__FIELD_0__pulse;
output [32-1:0] test_2_inst_shared_2__FIELD_0__curr_value;
//***************************INTERNAL REGISTER IN/OUT PORTS DEFINE END Here***************************//

logic [EXT_NUM-1:0] ext_sel;
wire external_reg_selected;
assign external_reg_selected = |ext_sel;
wire [DATA_WIDTH-1:0] ext_rd_data_vld;
//declare the portwidth of internal registers
wire [REG_NUM-1:0] [DATA_WIDTH-1:0] reg_rd_data_in;
wire [DATA_WIDTH-1:0] internal_reg_rd_data_vld;
wire internal_reg_ack_vld;
logic [REG_NUM-1:0] reg_sel;
wire internal_reg_selected;
logic dummy_reg;
assign internal_reg_selected = (|reg_sel) | dummy_reg;
wire fsm__slv__wr_en;
wire fsm__slv__rd_en;
wire [ADDR_WIDTH-1:0] fsm__slv__addr;
wire [DATA_WIDTH-1:0] fsm__slv__wr_data;
wire [DATA_WIDTH-1:0] slv__fsm__rd_data;
wire slv__fsm__ack_vld;
wire ext_reg_ack_vld;
wire ext_ack_rdy;
wire[EXT_NUM-1:0] ext_ack_vld;
wire[EXT_NUM-1:0] ext_ack;
wire[EXT_NUM-1:0] ext_req_rdy;
wire fsm__slv__req_vld;
wire slv__fsm__req_rdy;
assign slv__fsm__req_rdy = |{ext_req_rdy&ext_sel,internal_reg_selected};
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


//***************************internal register operation wire declare START***************************//
logic [31:0] test_1_inst_REG1_SW_RW_wr_data;
logic [31:0] test_1_inst_REG2_SW_W_wr_data;
logic [31:0] test_1_inst_REG3_HW_wr_data;
logic [31:0] test_1_inst_REG4_PRECEDENCE_wr_data;
logic [31:0] test_1_inst_REG5_SINGLEPULSE_wr_data;
logic [31:0] test_1_inst_REG6_SW_ACC_MOD_wr_data;
logic [31:0] test_1_inst_REG1_SW_R_alias_wr_data;
logic [31:0] test_1_inst_REG2_SRST_alias_wr_data;
logic [31:0] test_2_inst_shared_2_wr_data;
logic [31:0] test_3_inst_shared_3_wr_data;
//****************************internal register operation wire declare END****************************//


//************************************Address Decoding START Here*************************************//
always_comb begin
		reg_sel = {REG_NUM{1'b0}};
		ext_sel = {EXT_NUM{1'b0}};
		dummy_reg = 1'b0;
	unique case (addr_for_decode)
		64'h0:reg_sel[0] = 1'b1;//['test_1_inst', 'REG1_SW_RW']
		64'h4:reg_sel[1] = 1'b1;//['test_1_inst', 'REG2_SW_W']
		64'h8:reg_sel[2] = 1'b1;//['test_1_inst', 'REG3_HW']
		64'hc:reg_sel[3] = 1'b1;//['test_1_inst', 'REG4_PRECEDENCE']
		64'h10:reg_sel[4] = 1'b1;//['test_1_inst', 'REG5_SINGLEPULSE']
		64'h14:reg_sel[5] = 1'b1;//['test_1_inst', 'REG6_SW_ACC_MOD']
		64'h100:reg_sel[6] = 1'b1;//['test_1_inst', 'REG1_SW_R_alias']
		64'h104:reg_sel[7] = 1'b1;//['test_1_inst', 'REG2_SRST_alias']
		64'h108:reg_sel[8] = 1'b1;//['test_2_inst', 'shared_2']
		64'h10c:reg_sel[9] = 1'b1;//['test_3_inst', 'shared_3']
		64'h200,64'h204,64'h208,64'h20c,64'h210,64'h214,64'h218,64'h21c,64'h220,64'h224,64'h228,64'h22c,64'h230,64'h234,64'h238,64'h23c,64'h240,64'h244,64'h248,64'h24c,64'h250,64'h254,64'h258,64'h25c,64'h260,64'h264,64'h268,64'h26c,64'h270,64'h274,64'h278,64'h27c,64'h280,64'h284,64'h288,64'h28c,64'h290,64'h294,64'h298,64'h29c,64'h2a0,64'h2a4,64'h2a8,64'h2ac,64'h2b0,64'h2b4,64'h2b8,64'h2bc,64'h2c0,64'h2c4,64'h2c8,64'h2cc,64'h2d0,64'h2d4,64'h2d8,64'h2dc,64'h2e0,64'h2e4,64'h2e8,64'h2ec,64'h2f0,64'h2f4,64'h2f8,64'h2fc:ext_sel[0] = 1'b1;//external module ext_mem_1_inst
		64'h300,64'h304,64'h308,64'h30c,64'h310,64'h314,64'h318,64'h31c,64'h320,64'h324,64'h328,64'h32c,64'h330,64'h334,64'h338,64'h33c,64'h340,64'h344,64'h348,64'h34c,64'h350,64'h354,64'h358,64'h35c,64'h360,64'h364,64'h368,64'h36c,64'h370,64'h374,64'h378,64'h37c,64'h380,64'h384,64'h388,64'h38c,64'h390,64'h394,64'h398,64'h39c,64'h3a0,64'h3a4,64'h3a8,64'h3ac,64'h3b0,64'h3b4,64'h3b8,64'h3bc,64'h3c0,64'h3c4,64'h3c8,64'h3cc,64'h3d0,64'h3d4,64'h3d8,64'h3dc,64'h3e0,64'h3e4,64'h3e8,64'h3ec,64'h3f0,64'h3f4,64'h3f8,64'h3fc:ext_sel[1] = 1'b1;//external module ext_mem_2_inst
		64'h400,64'h404,64'h408,64'h40c,64'h410,64'h414,64'h418,64'h41c,64'h420,64'h424,64'h428,64'h42c,64'h430,64'h434,64'h438,64'h43c,64'h440,64'h444,64'h448,64'h44c,64'h450,64'h454,64'h458,64'h45c,64'h460,64'h464,64'h468,64'h46c,64'h470,64'h474,64'h478,64'h47c,64'h480,64'h484,64'h488,64'h48c,64'h490,64'h494,64'h498,64'h49c,64'h4a0,64'h4a4,64'h4a8,64'h4ac,64'h4b0,64'h4b4,64'h4b8,64'h4bc,64'h4c0,64'h4c4,64'h4c8,64'h4cc,64'h4d0,64'h4d4,64'h4d8,64'h4dc,64'h4e0,64'h4e4,64'h4e8,64'h4ec,64'h4f0,64'h4f4,64'h4f8,64'h4fc:ext_sel[2] = 1'b1;//external module ext_mem_3_inst
		default: dummy_reg = 1'b1;
	endcase
end
//*************************************Address Decoding END Here**************************************//


//************************************STATE MACHINE INSTANCE START************************************//
slv_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH), .M(M), .N(N))
	slv_fsm_regslv_test_inst (
	.clk(clk), .rstn(rstn), .mst__fsm__req_vld(req_vld), .mst__fsm__wr_en(wr_en), .mst__fsm__rd_en(rd_en), .mst__fsm__addr(addr), .mst__fsm__wr_data(wr_data),
	.slv__fsm__rd_data(slv__fsm__rd_data), .slv__fsm__ack_vld(slv__fsm__ack_vld), .fsm__slv__req_vld(fsm__slv__req_vld),
	.fsm__slv__wr_en(fsm__slv__wr_en), .fsm__slv__rd_en(fsm__slv__rd_en), .fsm__slv__addr(fsm__slv__addr), .fsm__slv__wr_data(fsm__slv__wr_data),
	.fsm__mst__req_rdy(req_rdy), .mst__fsm__ack_rdy(ack_rdy),
	.slv__fsm__req_rdy(slv__fsm__req_rdy), .fsm__slv__ack_rdy(ext_ack_rdy),
	.fsm__mst__rd_data(rd_data), .fsm__mst__ack_vld(ack_vld),
	.mst__fsm__sync_reset(global_sync_reset_in),
	.fsm__slv__sync_reset(global_sync_reset_out)
	);
//*************************************STATE MACHINE INSTANCE END*************************************//


//*******************************Register&field Instantiate START Here********************************//
//============================================REG INSTANT=============================================//
//REG NAME: test_1_inst_REG1_SW_RW//
//REG HIERARCHY: ['test_1_inst', 'REG1_SW_RW']//
//REG ABSOLUTE_ADDR:64'h0//
//REG OFFSET_ADDR:64'h64'h0//
logic [31:0] test_1_inst_REG1_SW_RW;
assign test_1_inst_REG1_SW_RW_wr_data = reg_sel[0] && internal_wr_en ? internal_wr_data : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_RW,`SW_RW}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WZT,`WZT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_1_inst_REG1_SW_RW__FIELD_9
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_1_inst_REG1_SW_RW_wr_data[13:12],test_1_inst_REG1_SW_R_alias_wr_data[13:12]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG1_SW_RW__FIELD_9__next_value),
	.hw_pulse(test_1_inst_REG1_SW_RW__FIELD_9__pulse),
	.field_value(test_1_inst_REG1_SW_RW__FIELD_9__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_RW,`SW_RW}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WZS,`WZT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_1_inst_REG1_SW_RW__FIELD_8
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_1_inst_REG1_SW_RW_wr_data[15:14],test_1_inst_REG1_SW_R_alias_wr_data[15:14]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG1_SW_RW__FIELD_8__next_value),
	.hw_pulse(test_1_inst_REG1_SW_RW__FIELD_8__pulse),
	.field_value(test_1_inst_REG1_SW_RW__FIELD_8__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_RW,`SW_RW}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WZC,`WZT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_1_inst_REG1_SW_RW__FIELD_7
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_1_inst_REG1_SW_RW_wr_data[17:16],test_1_inst_REG1_SW_R_alias_wr_data[17:16]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG1_SW_RW__FIELD_7__next_value),
	.hw_pulse(test_1_inst_REG1_SW_RW__FIELD_7__pulse),
	.field_value(test_1_inst_REG1_SW_RW__FIELD_7__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_RW,`SW_RW}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WOT,`WZT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_1_inst_REG1_SW_RW__FIELD_6
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_1_inst_REG1_SW_RW_wr_data[19:18],test_1_inst_REG1_SW_R_alias_wr_data[19:18]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG1_SW_RW__FIELD_6__next_value),
	.hw_pulse(test_1_inst_REG1_SW_RW__FIELD_6__pulse),
	.field_value(test_1_inst_REG1_SW_RW__FIELD_6__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_RW,`SW_RW}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WOSET,`WZT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_1_inst_REG1_SW_RW__FIELD_5
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_1_inst_REG1_SW_RW_wr_data[21:20],test_1_inst_REG1_SW_R_alias_wr_data[21:20]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG1_SW_RW__FIELD_5__next_value),
	.hw_pulse(test_1_inst_REG1_SW_RW__FIELD_5__pulse),
	.field_value(test_1_inst_REG1_SW_RW__FIELD_5__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_RW,`SW_RW}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WOCLR,`WZT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_1_inst_REG1_SW_RW__FIELD_4
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_1_inst_REG1_SW_RW_wr_data[23:22],test_1_inst_REG1_SW_R_alias_wr_data[23:22]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG1_SW_RW__FIELD_4__next_value),
	.hw_pulse(test_1_inst_REG1_SW_RW__FIELD_4__pulse),
	.field_value(test_1_inst_REG1_SW_RW__FIELD_4__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_RW,`SW_RW}),
	.SW_ONREAD_TYPE({`RSET,`NA}),
	.SW_ONWRITE_TYPE({`NA,`WZT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_1_inst_REG1_SW_RW__FIELD_3
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_1_inst_REG1_SW_RW_wr_data[25:24],test_1_inst_REG1_SW_R_alias_wr_data[25:24]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG1_SW_RW__FIELD_3__next_value),
	.hw_pulse(test_1_inst_REG1_SW_RW__FIELD_3__pulse),
	.field_value(test_1_inst_REG1_SW_RW__FIELD_3__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_RW,`SW_RW}),
	.SW_ONREAD_TYPE({`RCLR,`NA}),
	.SW_ONWRITE_TYPE({`NA,`WZT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_1_inst_REG1_SW_RW__FIELD_2
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_1_inst_REG1_SW_RW_wr_data[27:26],test_1_inst_REG1_SW_R_alias_wr_data[27:26]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG1_SW_RW__FIELD_2__next_value),
	.hw_pulse(test_1_inst_REG1_SW_RW__FIELD_2__pulse),
	.field_value(test_1_inst_REG1_SW_RW__FIELD_2__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_RW,`SW_RW}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`NA,`WZT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_1_inst_REG1_SW_RW__FIELD_1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_1_inst_REG1_SW_RW_wr_data[29:28],test_1_inst_REG1_SW_R_alias_wr_data[29:28]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG1_SW_RW__FIELD_1__next_value),
	.hw_pulse(test_1_inst_REG1_SW_RW__FIELD_1__pulse),
	.field_value(test_1_inst_REG1_SW_RW__FIELD_1__curr_value)
	);
always_comb begin
	test_1_inst_REG1_SW_RW[31:0] = 32'h0;
	test_1_inst_REG1_SW_RW[13:12] = test_1_inst_REG1_SW_RW__FIELD_9__curr_value;
	test_1_inst_REG1_SW_RW[15:14] = test_1_inst_REG1_SW_RW__FIELD_8__curr_value;
	test_1_inst_REG1_SW_RW[17:16] = test_1_inst_REG1_SW_RW__FIELD_7__curr_value;
	test_1_inst_REG1_SW_RW[19:18] = test_1_inst_REG1_SW_RW__FIELD_6__curr_value;
	test_1_inst_REG1_SW_RW[21:20] = test_1_inst_REG1_SW_RW__FIELD_5__curr_value;
	test_1_inst_REG1_SW_RW[23:22] = test_1_inst_REG1_SW_RW__FIELD_4__curr_value;
	test_1_inst_REG1_SW_RW[25:24] = test_1_inst_REG1_SW_RW__FIELD_3__curr_value;
	test_1_inst_REG1_SW_RW[27:26] = test_1_inst_REG1_SW_RW__FIELD_2__curr_value;
	test_1_inst_REG1_SW_RW[29:28] = test_1_inst_REG1_SW_RW__FIELD_1__curr_value;
end
assign reg_rd_data_in[0] = test_1_inst_REG1_SW_RW;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_1_inst_REG2_SW_W//
//REG HIERARCHY: ['test_1_inst', 'REG2_SW_W']//
//REG ABSOLUTE_ADDR:64'h4//
//REG OFFSET_ADDR:64'h64'h4//
logic [31:0] test_1_inst_REG2_SW_W;
assign test_1_inst_REG2_SW_W_wr_data = reg_sel[1] && internal_wr_en ? internal_wr_data : 0;
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
x__test_1_inst_REG2_SW_W__FIELD_6
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_1_inst_REG2_SW_W_wr_data[19:18],test_1_inst_REG2_SRST_alias_wr_data[19:18]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG2_SW_W__FIELD_6__next_value),
	.hw_pulse(test_1_inst_REG2_SW_W__FIELD_6__pulse),
	.field_value(test_1_inst_REG2_SW_W__FIELD_6__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_WO,`SW_WO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WZS,`WZT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_1_inst_REG2_SW_W__FIELD_5
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_1_inst_REG2_SW_W_wr_data[21:20],test_1_inst_REG2_SRST_alias_wr_data[21:20]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG2_SW_W__FIELD_5__next_value),
	.hw_pulse(test_1_inst_REG2_SW_W__FIELD_5__pulse),
	.field_value(test_1_inst_REG2_SW_W__FIELD_5__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_WO,`SW_WO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WZC,`WZT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_1_inst_REG2_SW_W__FIELD_4
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_1_inst_REG2_SW_W_wr_data[23:22],test_1_inst_REG2_SRST_alias_wr_data[23:22]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG2_SW_W__FIELD_4__next_value),
	.hw_pulse(test_1_inst_REG2_SW_W__FIELD_4__pulse),
	.field_value(test_1_inst_REG2_SW_W__FIELD_4__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_WO,`SW_WO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WOT,`WZT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_1_inst_REG2_SW_W__FIELD_3
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_1_inst_REG2_SW_W_wr_data[25:24],test_1_inst_REG2_SRST_alias_wr_data[25:24]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG2_SW_W__FIELD_3__next_value),
	.hw_pulse(test_1_inst_REG2_SW_W__FIELD_3__pulse),
	.field_value(test_1_inst_REG2_SW_W__FIELD_3__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_WO,`SW_WO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WOSET,`WZT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_1_inst_REG2_SW_W__FIELD_2
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_1_inst_REG2_SW_W_wr_data[27:26],test_1_inst_REG2_SRST_alias_wr_data[27:26]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG2_SW_W__FIELD_2__next_value),
	.hw_pulse(test_1_inst_REG2_SW_W__FIELD_2__pulse),
	.field_value(test_1_inst_REG2_SW_W__FIELD_2__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_WO,`SW_WO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`WOCLR,`WZT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_1_inst_REG2_SW_W__FIELD_1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_1_inst_REG2_SW_W_wr_data[29:28],test_1_inst_REG2_SRST_alias_wr_data[29:28]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG2_SW_W__FIELD_1__next_value),
	.hw_pulse(test_1_inst_REG2_SW_W__FIELD_1__pulse),
	.field_value(test_1_inst_REG2_SW_W__FIELD_1__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(2),
	.ARST_VALUE(2'h0),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_WO,`SW_WO}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`NA,`WZT}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_1_inst_REG2_SW_W__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_1_inst_REG2_SW_W_wr_data[31:30],test_1_inst_REG2_SRST_alias_wr_data[31:30]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG2_SW_W__FIELD_0__next_value),
	.hw_pulse(test_1_inst_REG2_SW_W__FIELD_0__pulse),
	.field_value(test_1_inst_REG2_SW_W__FIELD_0__curr_value)
	);
always_comb begin
	test_1_inst_REG2_SW_W[31:0] = 32'h0;
end
assign reg_rd_data_in[1] = test_1_inst_REG2_SW_W;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_1_inst_REG3_HW//
//REG HIERARCHY: ['test_1_inst', 'REG3_HW']//
//REG ABSOLUTE_ADDR:64'h8//
//REG OFFSET_ADDR:64'h64'h8//
logic [31:0] test_1_inst_REG3_HW;
assign test_1_inst_REG3_HW_wr_data = reg_sel[2] && internal_wr_en ? internal_wr_data : 0;
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
x__test_1_inst_REG3_HW__FIELD_3
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_1_inst_REG3_HW_wr_data[25:24]),
	.sw_rd(rd_sel_ff[2]),
	.sw_wr(wr_sel_ff[2]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG3_HW__FIELD_3__next_value),
	.hw_pulse(test_1_inst_REG3_HW__FIELD_3__pulse),
	.field_value(test_1_inst_REG3_HW__FIELD_3__curr_value)
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
x__test_1_inst_REG3_HW__FIELD_2
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_1_inst_REG3_HW_wr_data[27:26]),
	.sw_rd(rd_sel_ff[2]),
	.sw_wr(wr_sel_ff[2]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG3_HW__FIELD_2__next_value),
	.hw_pulse(test_1_inst_REG3_HW__FIELD_2__pulse),
	.field_value(test_1_inst_REG3_HW__FIELD_2__curr_value)
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
x__test_1_inst_REG3_HW__FIELD_1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_1_inst_REG3_HW_wr_data[29:28]),
	.sw_rd(rd_sel_ff[2]),
	.sw_wr(wr_sel_ff[2]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(2'b0),
	.hw_pulse(1'b0),
	.field_value(test_1_inst_REG3_HW__FIELD_1__curr_value)
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
x__test_1_inst_REG3_HW__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_1_inst_REG3_HW_wr_data[31:30]),
	.sw_rd(rd_sel_ff[2]),
	.sw_wr(wr_sel_ff[2]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG3_HW__FIELD_0__next_value),
	.hw_pulse(test_1_inst_REG3_HW__FIELD_0__pulse),
	.field_value(test_1_inst_REG3_HW__FIELD_0__curr_value)
	);
always_comb begin
	test_1_inst_REG3_HW[31:0] = 32'h0;
	test_1_inst_REG3_HW[25:24] = test_1_inst_REG3_HW__FIELD_3__curr_value;
	test_1_inst_REG3_HW[27:26] = test_1_inst_REG3_HW__FIELD_2__curr_value;
	test_1_inst_REG3_HW[29:28] = test_1_inst_REG3_HW__FIELD_1__curr_value;
	test_1_inst_REG3_HW[31:30] = test_1_inst_REG3_HW__FIELD_0__curr_value;
end
assign reg_rd_data_in[2] = test_1_inst_REG3_HW;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_1_inst_REG4_PRECEDENCE//
//REG HIERARCHY: ['test_1_inst', 'REG4_PRECEDENCE']//
//REG ABSOLUTE_ADDR:64'hc//
//REG OFFSET_ADDR:64'h64'hc//
logic [31:0] test_1_inst_REG4_PRECEDENCE;
assign test_1_inst_REG4_PRECEDENCE_wr_data = reg_sel[3] && internal_wr_en ? internal_wr_data : 0;
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
x__test_1_inst_REG4_PRECEDENCE__FIELD_1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_1_inst_REG4_PRECEDENCE_wr_data[29:28]),
	.sw_rd(rd_sel_ff[3]),
	.sw_wr(wr_sel_ff[3]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG4_PRECEDENCE__FIELD_1__next_value),
	.hw_pulse(test_1_inst_REG4_PRECEDENCE__FIELD_1__pulse),
	.field_value(test_1_inst_REG4_PRECEDENCE__FIELD_1__curr_value)
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
x__test_1_inst_REG4_PRECEDENCE__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_1_inst_REG4_PRECEDENCE_wr_data[31:30]),
	.sw_rd(rd_sel_ff[3]),
	.sw_wr(wr_sel_ff[3]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG4_PRECEDENCE__FIELD_0__next_value),
	.hw_pulse(test_1_inst_REG4_PRECEDENCE__FIELD_0__pulse),
	.field_value(test_1_inst_REG4_PRECEDENCE__FIELD_0__curr_value)
	);
always_comb begin
	test_1_inst_REG4_PRECEDENCE[31:0] = 32'h0;
	test_1_inst_REG4_PRECEDENCE[29:28] = test_1_inst_REG4_PRECEDENCE__FIELD_1__curr_value;
	test_1_inst_REG4_PRECEDENCE[31:30] = test_1_inst_REG4_PRECEDENCE__FIELD_0__curr_value;
end
assign reg_rd_data_in[3] = test_1_inst_REG4_PRECEDENCE;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_1_inst_REG5_SINGLEPULSE//
//REG HIERARCHY: ['test_1_inst', 'REG5_SINGLEPULSE']//
//REG ABSOLUTE_ADDR:64'h10//
//REG OFFSET_ADDR:64'h64'h10//
logic [31:0] test_1_inst_REG5_SINGLEPULSE;
assign test_1_inst_REG5_SINGLEPULSE_wr_data = reg_sel[4] && internal_wr_en ? internal_wr_data : 0;
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
x__test_1_inst_REG5_SINGLEPULSE__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_1_inst_REG5_SINGLEPULSE_wr_data[31:31]),
	.sw_rd(rd_sel_ff[4]),
	.sw_wr(wr_sel_ff[4]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_1_inst_REG5_SINGLEPULSE__FIELD_0__next_value),
	.hw_pulse(test_1_inst_REG5_SINGLEPULSE__FIELD_0__pulse),
	.field_value(test_1_inst_REG5_SINGLEPULSE__FIELD_0__curr_value)
	);
always_comb begin
	test_1_inst_REG5_SINGLEPULSE[31:0] = 32'h0;
	test_1_inst_REG5_SINGLEPULSE[31:31] = test_1_inst_REG5_SINGLEPULSE__FIELD_0__curr_value;
end
assign reg_rd_data_in[4] = test_1_inst_REG5_SINGLEPULSE;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_1_inst_REG6_SW_ACC_MOD//
//REG HIERARCHY: ['test_1_inst', 'REG6_SW_ACC_MOD']//
//REG ABSOLUTE_ADDR:64'h14//
//REG OFFSET_ADDR:64'h64'h14//
logic [31:0] test_1_inst_REG6_SW_ACC_MOD;
assign test_1_inst_REG6_SW_ACC_MOD_wr_data = reg_sel[5] && internal_wr_en ? internal_wr_data : 0;
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
x__test_1_inst_REG6_SW_ACC_MOD__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_1_inst_REG6_SW_ACC_MOD_wr_data[31:30]),
	.sw_rd(rd_sel_ff[5]),
	.sw_wr(wr_sel_ff[5]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(test_1_inst_REG6_SW_ACC_MOD__FIELD_0__swmod_out),
	.swacc_out(test_1_inst_REG6_SW_ACC_MOD__FIELD_0__swacc_out),
	.hw_value(test_1_inst_REG6_SW_ACC_MOD__FIELD_0__next_value),
	.hw_pulse(test_1_inst_REG6_SW_ACC_MOD__FIELD_0__pulse),
	.field_value(test_1_inst_REG6_SW_ACC_MOD__FIELD_0__curr_value)
	);
always_comb begin
	test_1_inst_REG6_SW_ACC_MOD[31:0] = 32'h0;
	test_1_inst_REG6_SW_ACC_MOD[31:30] = test_1_inst_REG6_SW_ACC_MOD__FIELD_0__curr_value;
end
assign reg_rd_data_in[5] = test_1_inst_REG6_SW_ACC_MOD;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_1_inst_REG1_SW_R_alias//
//REG HIERARCHY: ['test_1_inst', 'REG1_SW_R_alias']//
//REG ABSOLUTE_ADDR:64'h100//
//REG OFFSET_ADDR:64'h64'h100//
logic [31:0] test_1_inst_REG1_SW_R_alias;
assign test_1_inst_REG1_SW_R_alias_wr_data = reg_sel[6] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	test_1_inst_REG1_SW_R_alias[31:0] = 32'h0;
	test_1_inst_REG1_SW_R_alias[13:12] = test_1_inst_REG1_SW_RW__FIELD_9__curr_value;
	test_1_inst_REG1_SW_R_alias[15:14] = test_1_inst_REG1_SW_RW__FIELD_8__curr_value;
	test_1_inst_REG1_SW_R_alias[17:16] = test_1_inst_REG1_SW_RW__FIELD_7__curr_value;
	test_1_inst_REG1_SW_R_alias[19:18] = test_1_inst_REG1_SW_RW__FIELD_6__curr_value;
	test_1_inst_REG1_SW_R_alias[21:20] = test_1_inst_REG1_SW_RW__FIELD_5__curr_value;
	test_1_inst_REG1_SW_R_alias[23:22] = test_1_inst_REG1_SW_RW__FIELD_4__curr_value;
	test_1_inst_REG1_SW_R_alias[25:24] = test_1_inst_REG1_SW_RW__FIELD_3__curr_value;
	test_1_inst_REG1_SW_R_alias[27:26] = test_1_inst_REG1_SW_RW__FIELD_2__curr_value;
	test_1_inst_REG1_SW_R_alias[29:28] = test_1_inst_REG1_SW_RW__FIELD_1__curr_value;
end
assign reg_rd_data_in[6] = test_1_inst_REG1_SW_R_alias;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_1_inst_REG2_SRST_alias//
//REG HIERARCHY: ['test_1_inst', 'REG2_SRST_alias']//
//REG ABSOLUTE_ADDR:64'h104//
//REG OFFSET_ADDR:64'h64'h104//
logic [31:0] test_1_inst_REG2_SRST_alias;
assign test_1_inst_REG2_SRST_alias_wr_data = reg_sel[7] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	test_1_inst_REG2_SRST_alias[31:0] = 32'h0;
end
assign reg_rd_data_in[7] = test_1_inst_REG2_SRST_alias;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_2_inst_shared_2//
//REG HIERARCHY: ['test_2_inst', 'shared_2']//
//REG ABSOLUTE_ADDR:64'h108//
//REG OFFSET_ADDR:64'h64'h0//
logic [31:0] test_2_inst_shared_2;
assign test_2_inst_shared_2_wr_data = reg_sel[8] && internal_wr_en ? internal_wr_data : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WIDTH(32),
	.ARST_VALUE(32'hffffffff),
	.ALIAS_NUM(2),
	.SW_TYPE({`SW_RW,`SW_RW}),
	.SW_ONREAD_TYPE({`NA,`NA}),
	.SW_ONWRITE_TYPE({`NA,`NA}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_2_inst_shared_2__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_2_inst_shared_2_wr_data[31:0],test_3_inst_shared_3_wr_data[31:0]}),
	.sw_rd({rd_sel_ff[8],rd_sel_ff[9]}),
	.sw_wr({wr_sel_ff[8],wr_sel_ff[9]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_2_inst_shared_2__FIELD_0__next_value),
	.hw_pulse(test_2_inst_shared_2__FIELD_0__pulse),
	.field_value(test_2_inst_shared_2__FIELD_0__curr_value)
	);
always_comb begin
	test_2_inst_shared_2[31:0] = 32'h0;
	test_2_inst_shared_2[31:0] = test_2_inst_shared_2__FIELD_0__curr_value;
end
assign reg_rd_data_in[8] = test_2_inst_shared_2;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_3_inst_shared_3//
//REG HIERARCHY: ['test_3_inst', 'shared_3']//
//REG ABSOLUTE_ADDR:64'h10c//
//REG OFFSET_ADDR:64'h64'h0//
logic [31:0] test_3_inst_shared_3;
assign test_3_inst_shared_3_wr_data = reg_sel[9] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	test_3_inst_shared_3[31:0] = 32'h0;
	test_3_inst_shared_3[31:0] = test_2_inst_shared_2__FIELD_0__curr_value;
end
assign reg_rd_data_in[9] = test_3_inst_shared_3;
//==========================================END REG INSTANT===========================================//
//********************************Register&field Instantiate END Here*********************************//


//*********************************EXTERNAL CONNECTION INSTANT START**********************************//
assign ext_wr_en = fsm__slv__wr_en;
assign ext_rd_en = fsm__slv__rd_en;
assign ext_addr = fsm__slv__addr;
assign ext_wr_data = fsm__slv__wr_data;
//ext_mem_1_inst connection, external[0];
assign ext_req_vld[0] = ext_sel[0] & fsm__slv__req_vld;
assign ext_ack[0] = ext_ack_vld[0] & ext_sel[0];
//ext_mem_2_inst connection, external[1];
assign ext_req_vld[1] = ext_sel[1] & fsm__slv__req_vld;
assign ext_ack[1] = ext_ack_vld[1] & ext_sel[1];
//ext_mem_3_inst connection, external[2];
assign ext_req_vld[2] = ext_sel[2] & fsm__slv__req_vld;
assign ext_ack[2] = ext_ack_vld[2] & ext_sel[2];
//**********************************EXTERNAL CONNECTION INSTANT END***********************************//




//********************************Rd_data/Ack_vld Split Mux START Here********************************//
split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(N+1), .GROUP_SIZE(64)) rd_split_mux
(.clk(clk), .rst_n(rstn),
.din({reg_rd_data_in,{DATA_WIDTH{1'b0}}}), .sel({rd_sel_ff,dummy_reg}),
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
assign slv__fsm__ack_vld = internal_reg_ack_vld | ext_reg_ack_vld| (fsm__slv__wr_en & internal_reg_selected);
//**************************Final Split Mux OUT Signal Definitinon END Here***************************//
endmodule