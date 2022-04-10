`include "xregister.vh"
module regslv_reg_block_2(
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
//['test_21', 'REG1_SW_RW', 'FIELD_8']
	test_21_REG1_SW_RW__FIELD_8__next_value,
	test_21_REG1_SW_RW__FIELD_8__pulse,
	test_21_REG1_SW_RW__FIELD_8__curr_value,
//['test_21', 'REG1_SW_RW', 'FIELD_7']
	test_21_REG1_SW_RW__FIELD_7__next_value,
	test_21_REG1_SW_RW__FIELD_7__pulse,
	test_21_REG1_SW_RW__FIELD_7__curr_value,
//['test_21', 'REG1_SW_RW', 'FIELD_6']
	test_21_REG1_SW_RW__FIELD_6__next_value,
	test_21_REG1_SW_RW__FIELD_6__pulse,
	test_21_REG1_SW_RW__FIELD_6__curr_value,
//['test_21', 'REG1_SW_RW', 'FIELD_5']
	test_21_REG1_SW_RW__FIELD_5__next_value,
	test_21_REG1_SW_RW__FIELD_5__pulse,
	test_21_REG1_SW_RW__FIELD_5__curr_value,
//['test_21', 'REG1_SW_RW', 'FIELD_4']
	test_21_REG1_SW_RW__FIELD_4__next_value,
	test_21_REG1_SW_RW__FIELD_4__pulse,
	test_21_REG1_SW_RW__FIELD_4__curr_value,
//['test_21', 'REG1_SW_RW', 'FIELD_3']
	test_21_REG1_SW_RW__FIELD_3__next_value,
	test_21_REG1_SW_RW__FIELD_3__pulse,
	test_21_REG1_SW_RW__FIELD_3__curr_value,
//['test_21', 'REG1_SW_RW', 'FIELD_2']
	test_21_REG1_SW_RW__FIELD_2__next_value,
	test_21_REG1_SW_RW__FIELD_2__pulse,
	test_21_REG1_SW_RW__FIELD_2__curr_value,
//['test_21', 'REG1_SW_RW', 'FIELD_1']
	test_21_REG1_SW_RW__FIELD_1__next_value,
	test_21_REG1_SW_RW__FIELD_1__pulse,
	test_21_REG1_SW_RW__FIELD_1__curr_value,
//['test_21', 'REG1_SW_RW', 'FIELD_0']
	test_21_REG1_SW_RW__FIELD_0__next_value,
	test_21_REG1_SW_RW__FIELD_0__pulse,
	test_21_REG1_SW_RW__FIELD_0__curr_value,
//['test_21', 'REG2_SW_W', 'FIELD_6']
	test_21_REG2_SW_W__FIELD_6__next_value,
	test_21_REG2_SW_W__FIELD_6__pulse,
	test_21_REG2_SW_W__FIELD_6__curr_value,
//['test_21', 'REG2_SW_W', 'FIELD_5']
	test_21_REG2_SW_W__FIELD_5__next_value,
	test_21_REG2_SW_W__FIELD_5__pulse,
	test_21_REG2_SW_W__FIELD_5__curr_value,
//['test_21', 'REG2_SW_W', 'FIELD_4']
	test_21_REG2_SW_W__FIELD_4__next_value,
	test_21_REG2_SW_W__FIELD_4__pulse,
	test_21_REG2_SW_W__FIELD_4__curr_value,
//['test_21', 'REG2_SW_W', 'FIELD_3']
	test_21_REG2_SW_W__FIELD_3__next_value,
	test_21_REG2_SW_W__FIELD_3__pulse,
	test_21_REG2_SW_W__FIELD_3__curr_value,
//['test_21', 'REG2_SW_W', 'FIELD_2']
	test_21_REG2_SW_W__FIELD_2__next_value,
	test_21_REG2_SW_W__FIELD_2__pulse,
	test_21_REG2_SW_W__FIELD_2__curr_value,
//['test_21', 'REG2_SW_W', 'FIELD_1']
	test_21_REG2_SW_W__FIELD_1__next_value,
	test_21_REG2_SW_W__FIELD_1__pulse,
	test_21_REG2_SW_W__FIELD_1__curr_value,
//['test_21', 'REG2_SW_W', 'FIELD_0']
	test_21_REG2_SW_W__FIELD_0__next_value,
	test_21_REG2_SW_W__FIELD_0__pulse,
	test_21_REG2_SW_W__FIELD_0__curr_value,
//['test_21', 'REG3_HW', 'FIELD_3']
	test_21_REG3_HW__FIELD_3__next_value,
	test_21_REG3_HW__FIELD_3__pulse,
	test_21_REG3_HW__FIELD_3__curr_value,
//['test_21', 'REG3_HW', 'FIELD_2']
	test_21_REG3_HW__FIELD_2__next_value,
	test_21_REG3_HW__FIELD_2__pulse,
	test_21_REG3_HW__FIELD_2__curr_value,
	test_21_REG3_HW__FIELD_1__curr_value,
//['test_21', 'REG3_HW', 'FIELD_0']
	test_21_REG3_HW__FIELD_0__next_value,
	test_21_REG3_HW__FIELD_0__pulse,
	test_21_REG3_HW__FIELD_0__curr_value,
//['test_21', 'REG4_PRECEDENCE', 'FIELD_1']
	test_21_REG4_PRECEDENCE__FIELD_1__next_value,
	test_21_REG4_PRECEDENCE__FIELD_1__pulse,
	test_21_REG4_PRECEDENCE__FIELD_1__curr_value,
//['test_21', 'REG4_PRECEDENCE', 'FIELD_0']
	test_21_REG4_PRECEDENCE__FIELD_0__next_value,
	test_21_REG4_PRECEDENCE__FIELD_0__pulse,
	test_21_REG4_PRECEDENCE__FIELD_0__curr_value,
//['test_21', 'REG5_SINGLEPULSE', 'FIELD_0']
	test_21_REG5_SINGLEPULSE__FIELD_0__next_value,
	test_21_REG5_SINGLEPULSE__FIELD_0__pulse,
	test_21_REG5_SINGLEPULSE__FIELD_0__curr_value,
//['test_21', 'REG6_SW_ACC_MOD', 'FIELD_0']
	test_21_REG6_SW_ACC_MOD__FIELD_0__next_value,
	test_21_REG6_SW_ACC_MOD__FIELD_0__pulse,
	test_21_REG6_SW_ACC_MOD__FIELD_0__curr_value,
	test_21_REG6_SW_ACC_MOD__FIELD_0__swmod_out,
	test_21_REG6_SW_ACC_MOD__FIELD_0__swacc_out,
//['test_22', 'shared_2', 'FIELD_0']
	test_22_shared_2__FIELD_0__next_value,
	test_22_shared_2__FIELD_0__pulse,
	test_22_shared_2__FIELD_0__curr_value,
//*********************************INTERNAL field connection port END*********************************//
	test_21_srst_1,
	test_21_srst_2,
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
input test_21_srst_1;
input test_21_srst_2;
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
//['test_21', 'REG1_SW_RW', 'FIELD_8']
input [2-1:0] test_21_REG1_SW_RW__FIELD_8__next_value;
input test_21_REG1_SW_RW__FIELD_8__pulse;
output [2-1:0] test_21_REG1_SW_RW__FIELD_8__curr_value;
//['test_21', 'REG1_SW_RW', 'FIELD_7']
input [2-1:0] test_21_REG1_SW_RW__FIELD_7__next_value;
input test_21_REG1_SW_RW__FIELD_7__pulse;
output [2-1:0] test_21_REG1_SW_RW__FIELD_7__curr_value;
//['test_21', 'REG1_SW_RW', 'FIELD_6']
input [2-1:0] test_21_REG1_SW_RW__FIELD_6__next_value;
input test_21_REG1_SW_RW__FIELD_6__pulse;
output [2-1:0] test_21_REG1_SW_RW__FIELD_6__curr_value;
//['test_21', 'REG1_SW_RW', 'FIELD_5']
input [2-1:0] test_21_REG1_SW_RW__FIELD_5__next_value;
input test_21_REG1_SW_RW__FIELD_5__pulse;
output [2-1:0] test_21_REG1_SW_RW__FIELD_5__curr_value;
//['test_21', 'REG1_SW_RW', 'FIELD_4']
input [2-1:0] test_21_REG1_SW_RW__FIELD_4__next_value;
input test_21_REG1_SW_RW__FIELD_4__pulse;
output [2-1:0] test_21_REG1_SW_RW__FIELD_4__curr_value;
//['test_21', 'REG1_SW_RW', 'FIELD_3']
input [2-1:0] test_21_REG1_SW_RW__FIELD_3__next_value;
input test_21_REG1_SW_RW__FIELD_3__pulse;
output [2-1:0] test_21_REG1_SW_RW__FIELD_3__curr_value;
//['test_21', 'REG1_SW_RW', 'FIELD_2']
input [2-1:0] test_21_REG1_SW_RW__FIELD_2__next_value;
input test_21_REG1_SW_RW__FIELD_2__pulse;
output [2-1:0] test_21_REG1_SW_RW__FIELD_2__curr_value;
//['test_21', 'REG1_SW_RW', 'FIELD_1']
input [2-1:0] test_21_REG1_SW_RW__FIELD_1__next_value;
input test_21_REG1_SW_RW__FIELD_1__pulse;
output [2-1:0] test_21_REG1_SW_RW__FIELD_1__curr_value;
//['test_21', 'REG1_SW_RW', 'FIELD_0']
input [2-1:0] test_21_REG1_SW_RW__FIELD_0__next_value;
input test_21_REG1_SW_RW__FIELD_0__pulse;
output [2-1:0] test_21_REG1_SW_RW__FIELD_0__curr_value;
//['test_21', 'REG2_SW_W', 'FIELD_6']
input [2-1:0] test_21_REG2_SW_W__FIELD_6__next_value;
input test_21_REG2_SW_W__FIELD_6__pulse;
output [2-1:0] test_21_REG2_SW_W__FIELD_6__curr_value;
//['test_21', 'REG2_SW_W', 'FIELD_5']
input [2-1:0] test_21_REG2_SW_W__FIELD_5__next_value;
input test_21_REG2_SW_W__FIELD_5__pulse;
output [2-1:0] test_21_REG2_SW_W__FIELD_5__curr_value;
//['test_21', 'REG2_SW_W', 'FIELD_4']
input [2-1:0] test_21_REG2_SW_W__FIELD_4__next_value;
input test_21_REG2_SW_W__FIELD_4__pulse;
output [2-1:0] test_21_REG2_SW_W__FIELD_4__curr_value;
//['test_21', 'REG2_SW_W', 'FIELD_3']
input [2-1:0] test_21_REG2_SW_W__FIELD_3__next_value;
input test_21_REG2_SW_W__FIELD_3__pulse;
output [2-1:0] test_21_REG2_SW_W__FIELD_3__curr_value;
//['test_21', 'REG2_SW_W', 'FIELD_2']
input [2-1:0] test_21_REG2_SW_W__FIELD_2__next_value;
input test_21_REG2_SW_W__FIELD_2__pulse;
output [2-1:0] test_21_REG2_SW_W__FIELD_2__curr_value;
//['test_21', 'REG2_SW_W', 'FIELD_1']
input [2-1:0] test_21_REG2_SW_W__FIELD_1__next_value;
input test_21_REG2_SW_W__FIELD_1__pulse;
output [2-1:0] test_21_REG2_SW_W__FIELD_1__curr_value;
//['test_21', 'REG2_SW_W', 'FIELD_0']
input [2-1:0] test_21_REG2_SW_W__FIELD_0__next_value;
input test_21_REG2_SW_W__FIELD_0__pulse;
output [2-1:0] test_21_REG2_SW_W__FIELD_0__curr_value;
//['test_21', 'REG3_HW', 'FIELD_3']
input [2-1:0] test_21_REG3_HW__FIELD_3__next_value;
input test_21_REG3_HW__FIELD_3__pulse;
output [2-1:0] test_21_REG3_HW__FIELD_3__curr_value;
//['test_21', 'REG3_HW', 'FIELD_2']
input [2-1:0] test_21_REG3_HW__FIELD_2__next_value;
input test_21_REG3_HW__FIELD_2__pulse;
output [2-1:0] test_21_REG3_HW__FIELD_2__curr_value;
output [2-1:0] test_21_REG3_HW__FIELD_1__curr_value;
//['test_21', 'REG3_HW', 'FIELD_0']
input [2-1:0] test_21_REG3_HW__FIELD_0__next_value;
input test_21_REG3_HW__FIELD_0__pulse;
output [2-1:0] test_21_REG3_HW__FIELD_0__curr_value;
//['test_21', 'REG4_PRECEDENCE', 'FIELD_1']
input [2-1:0] test_21_REG4_PRECEDENCE__FIELD_1__next_value;
input test_21_REG4_PRECEDENCE__FIELD_1__pulse;
output [2-1:0] test_21_REG4_PRECEDENCE__FIELD_1__curr_value;
//['test_21', 'REG4_PRECEDENCE', 'FIELD_0']
input [2-1:0] test_21_REG4_PRECEDENCE__FIELD_0__next_value;
input test_21_REG4_PRECEDENCE__FIELD_0__pulse;
output [2-1:0] test_21_REG4_PRECEDENCE__FIELD_0__curr_value;
//['test_21', 'REG5_SINGLEPULSE', 'FIELD_0']
input [1-1:0] test_21_REG5_SINGLEPULSE__FIELD_0__next_value;
input test_21_REG5_SINGLEPULSE__FIELD_0__pulse;
output [1-1:0] test_21_REG5_SINGLEPULSE__FIELD_0__curr_value;
//['test_21', 'REG6_SW_ACC_MOD', 'FIELD_0']
input [2-1:0] test_21_REG6_SW_ACC_MOD__FIELD_0__next_value;
input test_21_REG6_SW_ACC_MOD__FIELD_0__pulse;
output [2-1:0] test_21_REG6_SW_ACC_MOD__FIELD_0__curr_value;
output test_21_REG6_SW_ACC_MOD__FIELD_0__swmod_out;
output test_21_REG6_SW_ACC_MOD__FIELD_0__swacc_out;
//['test_22', 'shared_2', 'FIELD_0']
input [32-1:0] test_22_shared_2__FIELD_0__next_value;
input test_22_shared_2__FIELD_0__pulse;
output [32-1:0] test_22_shared_2__FIELD_0__curr_value;
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
assign slv__fsm__ack_vld = internal_reg_ack_vld | ext_reg_ack_vld | (internal_wr_en & internal_reg_selected);
//**************************Final Split Mux OUT Signal Definitinon END Here***************************//


//***************************internal register operation wire declare START***************************//
logic [31:0] test_21_REG1_SW_RW_wr_data;
logic [31:0] test_21_REG2_SW_W_wr_data;
logic [31:0] test_21_REG3_HW_wr_data;
logic [31:0] test_21_REG4_PRECEDENCE_wr_data;
logic [31:0] test_21_REG5_SINGLEPULSE_wr_data;
logic [31:0] test_21_REG6_SW_ACC_MOD_wr_data;
logic [31:0] test_21_REG1_SW_R_W_alias_wr_data;
logic [31:0] test_21_REG2_SRST_alias_wr_data;
logic [31:0] test_22_shared_2_wr_data;
logic [31:0] test_23_shared_3_wr_data;
//****************************internal register operation wire declare END****************************//


//************************************Address Decoding START Here*************************************//
always_comb begin
		reg_sel = {REG_NUM{1'b0}};
		ext_sel = {EXT_NUM{1'b0}};
		dummy_reg = 1'b0;
	unique case (addr_for_decode)
		64'h800:reg_sel[0] = 1'b1;//['test_21', 'REG1_SW_RW']
		64'h804:reg_sel[1] = 1'b1;//['test_21', 'REG2_SW_W']
		64'h808:reg_sel[2] = 1'b1;//['test_21', 'REG3_HW']
		64'h80c:reg_sel[3] = 1'b1;//['test_21', 'REG4_PRECEDENCE']
		64'h810:reg_sel[4] = 1'b1;//['test_21', 'REG5_SINGLEPULSE']
		64'h814:reg_sel[5] = 1'b1;//['test_21', 'REG6_SW_ACC_MOD']
		64'h900:reg_sel[6] = 1'b1;//['test_21', 'REG1_SW_R_W_alias']
		64'h904:reg_sel[7] = 1'b1;//['test_21', 'REG2_SRST_alias']
		64'h908:reg_sel[8] = 1'b1;//['test_22', 'shared_2']
		64'h90c:reg_sel[9] = 1'b1;//['test_23', 'shared_3']
		64'ha00,64'ha04,64'ha08,64'ha0c,64'ha10,64'ha14,64'ha18,64'ha1c,64'ha20,64'ha24,64'ha28,64'ha2c,64'ha30,64'ha34,64'ha38,64'ha3c,64'ha40,64'ha44,64'ha48,64'ha4c,64'ha50,64'ha54,64'ha58,64'ha5c,64'ha60,64'ha64,64'ha68,64'ha6c,64'ha70,64'ha74,64'ha78,64'ha7c,64'ha80,64'ha84,64'ha88,64'ha8c,64'ha90,64'ha94,64'ha98,64'ha9c,64'haa0,64'haa4,64'haa8,64'haac,64'hab0,64'hab4,64'hab8,64'habc,64'hac0,64'hac4,64'hac8,64'hacc,64'had0,64'had4,64'had8,64'hadc,64'hae0,64'hae4,64'hae8,64'haec,64'haf0,64'haf4,64'haf8,64'hafc:ext_sel[0] = 1'b1;//external module ext_mem_21
		64'hb00,64'hb04,64'hb08,64'hb0c,64'hb10,64'hb14,64'hb18,64'hb1c,64'hb20,64'hb24,64'hb28,64'hb2c,64'hb30,64'hb34,64'hb38,64'hb3c,64'hb40,64'hb44,64'hb48,64'hb4c,64'hb50,64'hb54,64'hb58,64'hb5c,64'hb60,64'hb64,64'hb68,64'hb6c,64'hb70,64'hb74,64'hb78,64'hb7c,64'hb80,64'hb84,64'hb88,64'hb8c,64'hb90,64'hb94,64'hb98,64'hb9c,64'hba0,64'hba4,64'hba8,64'hbac,64'hbb0,64'hbb4,64'hbb8,64'hbbc,64'hbc0,64'hbc4,64'hbc8,64'hbcc,64'hbd0,64'hbd4,64'hbd8,64'hbdc,64'hbe0,64'hbe4,64'hbe8,64'hbec,64'hbf0,64'hbf4,64'hbf8,64'hbfc:ext_sel[1] = 1'b1;//external module ext_mem_22
		64'hc00,64'hc04,64'hc08,64'hc0c,64'hc10,64'hc14,64'hc18,64'hc1c,64'hc20,64'hc24,64'hc28,64'hc2c,64'hc30,64'hc34,64'hc38,64'hc3c,64'hc40,64'hc44,64'hc48,64'hc4c,64'hc50,64'hc54,64'hc58,64'hc5c,64'hc60,64'hc64,64'hc68,64'hc6c,64'hc70,64'hc74,64'hc78,64'hc7c,64'hc80,64'hc84,64'hc88,64'hc8c,64'hc90,64'hc94,64'hc98,64'hc9c,64'hca0,64'hca4,64'hca8,64'hcac,64'hcb0,64'hcb4,64'hcb8,64'hcbc,64'hcc0,64'hcc4,64'hcc8,64'hccc,64'hcd0,64'hcd4,64'hcd8,64'hcdc,64'hce0,64'hce4,64'hce8,64'hcec,64'hcf0,64'hcf4,64'hcf8,64'hcfc:ext_sel[2] = 1'b1;//external module ext_mem_23
		default: dummy_reg = 1'b1;
	endcase
end
//*************************************Address Decoding END Here**************************************//


//************************************STATE MACHINE INSTANCE START************************************//
slv_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
	slv_fsm_reg_block_2 (
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
//REG NAME: test_21_REG1_SW_RW//
//REG HIERARCHY: ['test_21', 'REG1_SW_RW']//
//REG ABSOLUTE_ADDR:64'h800//
//REG OFFSET_ADDR:64'h64'h0//
logic [31:0] test_21_REG1_SW_RW;
assign test_21_REG1_SW_RW_wr_data = reg_sel[0] && internal_wr_en ? internal_wr_data : 0;
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
x__test_21_REG1_SW_RW__FIELD_8
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_21_REG1_SW_RW_wr_data[13:12],test_21_REG1_SW_R_W_alias_wr_data[13:12]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG1_SW_RW__FIELD_8__next_value),
	.hw_pulse(test_21_REG1_SW_RW__FIELD_8__pulse),
	.field_value(test_21_REG1_SW_RW__FIELD_8__curr_value)
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
x__test_21_REG1_SW_RW__FIELD_7
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_21_REG1_SW_RW_wr_data[15:14],test_21_REG1_SW_R_W_alias_wr_data[15:14]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG1_SW_RW__FIELD_7__next_value),
	.hw_pulse(test_21_REG1_SW_RW__FIELD_7__pulse),
	.field_value(test_21_REG1_SW_RW__FIELD_7__curr_value)
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
x__test_21_REG1_SW_RW__FIELD_6
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_21_REG1_SW_RW_wr_data[17:16],test_21_REG1_SW_R_W_alias_wr_data[17:16]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG1_SW_RW__FIELD_6__next_value),
	.hw_pulse(test_21_REG1_SW_RW__FIELD_6__pulse),
	.field_value(test_21_REG1_SW_RW__FIELD_6__curr_value)
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
x__test_21_REG1_SW_RW__FIELD_5
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_21_REG1_SW_RW_wr_data[19:18],test_21_REG1_SW_R_W_alias_wr_data[19:18]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG1_SW_RW__FIELD_5__next_value),
	.hw_pulse(test_21_REG1_SW_RW__FIELD_5__pulse),
	.field_value(test_21_REG1_SW_RW__FIELD_5__curr_value)
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
x__test_21_REG1_SW_RW__FIELD_4
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_21_REG1_SW_RW_wr_data[21:20],test_21_REG1_SW_R_W_alias_wr_data[21:20]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG1_SW_RW__FIELD_4__next_value),
	.hw_pulse(test_21_REG1_SW_RW__FIELD_4__pulse),
	.field_value(test_21_REG1_SW_RW__FIELD_4__curr_value)
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
x__test_21_REG1_SW_RW__FIELD_3
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_21_REG1_SW_RW_wr_data[23:22],test_21_REG1_SW_R_W_alias_wr_data[23:22]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG1_SW_RW__FIELD_3__next_value),
	.hw_pulse(test_21_REG1_SW_RW__FIELD_3__pulse),
	.field_value(test_21_REG1_SW_RW__FIELD_3__curr_value)
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
x__test_21_REG1_SW_RW__FIELD_2
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_21_REG1_SW_RW_wr_data[25:24],test_21_REG1_SW_R_W_alias_wr_data[25:24]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG1_SW_RW__FIELD_2__next_value),
	.hw_pulse(test_21_REG1_SW_RW__FIELD_2__pulse),
	.field_value(test_21_REG1_SW_RW__FIELD_2__curr_value)
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
x__test_21_REG1_SW_RW__FIELD_1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_21_REG1_SW_RW_wr_data[27:26],test_21_REG1_SW_R_W_alias_wr_data[27:26]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG1_SW_RW__FIELD_1__next_value),
	.hw_pulse(test_21_REG1_SW_RW__FIELD_1__pulse),
	.field_value(test_21_REG1_SW_RW__FIELD_1__curr_value)
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
x__test_21_REG1_SW_RW__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_21_REG1_SW_RW_wr_data[29:28],test_21_REG1_SW_R_W_alias_wr_data[29:28]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[6]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[6]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG1_SW_RW__FIELD_0__next_value),
	.hw_pulse(test_21_REG1_SW_RW__FIELD_0__pulse),
	.field_value(test_21_REG1_SW_RW__FIELD_0__curr_value)
	);
always_comb begin
	test_21_REG1_SW_RW[31:0] = 32'h0;
	test_21_REG1_SW_RW[13:12] = test_21_REG1_SW_RW__FIELD_8__curr_value;
	test_21_REG1_SW_RW[15:14] = test_21_REG1_SW_RW__FIELD_7__curr_value;
	test_21_REG1_SW_RW[17:16] = test_21_REG1_SW_RW__FIELD_6__curr_value;
	test_21_REG1_SW_RW[19:18] = test_21_REG1_SW_RW__FIELD_5__curr_value;
	test_21_REG1_SW_RW[21:20] = test_21_REG1_SW_RW__FIELD_4__curr_value;
	test_21_REG1_SW_RW[23:22] = test_21_REG1_SW_RW__FIELD_3__curr_value;
	test_21_REG1_SW_RW[25:24] = test_21_REG1_SW_RW__FIELD_2__curr_value;
	test_21_REG1_SW_RW[27:26] = test_21_REG1_SW_RW__FIELD_1__curr_value;
	test_21_REG1_SW_RW[29:28] = test_21_REG1_SW_RW__FIELD_0__curr_value;
end
assign reg_rd_data_in[0] = test_21_REG1_SW_RW;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_21_REG2_SW_W//
//REG HIERARCHY: ['test_21', 'REG2_SW_W']//
//REG ABSOLUTE_ADDR:64'h804//
//REG OFFSET_ADDR:64'h64'h4//
logic [31:0] test_21_REG2_SW_W;
assign test_21_REG2_SW_W_wr_data = reg_sel[1] && internal_wr_en ? internal_wr_data : 0;
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
x__test_21_REG2_SW_W__FIELD_6
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_21_REG2_SW_W_wr_data[19:18],test_21_REG2_SRST_alias_wr_data[19:18]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG2_SW_W__FIELD_6__next_value),
	.hw_pulse(test_21_REG2_SW_W__FIELD_6__pulse),
	.field_value(test_21_REG2_SW_W__FIELD_6__curr_value)
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
x__test_21_REG2_SW_W__FIELD_5
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_21_REG2_SW_W_wr_data[21:20],test_21_REG2_SRST_alias_wr_data[21:20]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG2_SW_W__FIELD_5__next_value),
	.hw_pulse(test_21_REG2_SW_W__FIELD_5__pulse),
	.field_value(test_21_REG2_SW_W__FIELD_5__curr_value)
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
x__test_21_REG2_SW_W__FIELD_4
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_21_REG2_SW_W_wr_data[23:22],test_21_REG2_SRST_alias_wr_data[23:22]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG2_SW_W__FIELD_4__next_value),
	.hw_pulse(test_21_REG2_SW_W__FIELD_4__pulse),
	.field_value(test_21_REG2_SW_W__FIELD_4__curr_value)
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
x__test_21_REG2_SW_W__FIELD_3
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_21_REG2_SW_W_wr_data[25:24],test_21_REG2_SRST_alias_wr_data[25:24]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG2_SW_W__FIELD_3__next_value),
	.hw_pulse(test_21_REG2_SW_W__FIELD_3__pulse),
	.field_value(test_21_REG2_SW_W__FIELD_3__curr_value)
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
x__test_21_REG2_SW_W__FIELD_2
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst({test_21_srst_2}),
	.sw_wr_data({test_21_REG2_SW_W_wr_data[27:26],test_21_REG2_SRST_alias_wr_data[27:26]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG2_SW_W__FIELD_2__next_value),
	.hw_pulse(test_21_REG2_SW_W__FIELD_2__pulse),
	.field_value(test_21_REG2_SW_W__FIELD_2__curr_value)
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
x__test_21_REG2_SW_W__FIELD_1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst({test_21_srst_1}),
	.sw_wr_data({test_21_REG2_SW_W_wr_data[29:28],test_21_REG2_SRST_alias_wr_data[29:28]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG2_SW_W__FIELD_1__next_value),
	.hw_pulse(test_21_REG2_SW_W__FIELD_1__pulse),
	.field_value(test_21_REG2_SW_W__FIELD_1__curr_value)
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
x__test_21_REG2_SW_W__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_21_REG2_SW_W_wr_data[31:30],test_21_REG2_SRST_alias_wr_data[31:30]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[7]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG2_SW_W__FIELD_0__next_value),
	.hw_pulse(test_21_REG2_SW_W__FIELD_0__pulse),
	.field_value(test_21_REG2_SW_W__FIELD_0__curr_value)
	);
always_comb begin
	test_21_REG2_SW_W[31:0] = 32'h0;
end
assign reg_rd_data_in[1] = test_21_REG2_SW_W;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_21_REG3_HW//
//REG HIERARCHY: ['test_21', 'REG3_HW']//
//REG ABSOLUTE_ADDR:64'h808//
//REG OFFSET_ADDR:64'h64'h8//
logic [31:0] test_21_REG3_HW;
assign test_21_REG3_HW_wr_data = reg_sel[2] && internal_wr_en ? internal_wr_data : 0;
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
x__test_21_REG3_HW__FIELD_3
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_21_REG3_HW_wr_data[25:24]),
	.sw_rd(rd_sel_ff[2]),
	.sw_wr(wr_sel_ff[2]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG3_HW__FIELD_3__next_value),
	.hw_pulse(test_21_REG3_HW__FIELD_3__pulse),
	.field_value(test_21_REG3_HW__FIELD_3__curr_value)
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
x__test_21_REG3_HW__FIELD_2
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_21_REG3_HW_wr_data[27:26]),
	.sw_rd(rd_sel_ff[2]),
	.sw_wr(wr_sel_ff[2]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG3_HW__FIELD_2__next_value),
	.hw_pulse(test_21_REG3_HW__FIELD_2__pulse),
	.field_value(test_21_REG3_HW__FIELD_2__curr_value)
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
x__test_21_REG3_HW__FIELD_1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_21_REG3_HW_wr_data[29:28]),
	.sw_rd(rd_sel_ff[2]),
	.sw_wr(wr_sel_ff[2]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(2'b0),
	.hw_pulse(1'b0),
	.field_value(test_21_REG3_HW__FIELD_1__curr_value)
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
x__test_21_REG3_HW__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_21_REG3_HW_wr_data[31:30]),
	.sw_rd(rd_sel_ff[2]),
	.sw_wr(wr_sel_ff[2]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG3_HW__FIELD_0__next_value),
	.hw_pulse(test_21_REG3_HW__FIELD_0__pulse),
	.field_value(test_21_REG3_HW__FIELD_0__curr_value)
	);
always_comb begin
	test_21_REG3_HW[31:0] = 32'h0;
	test_21_REG3_HW[25:24] = test_21_REG3_HW__FIELD_3__curr_value;
	test_21_REG3_HW[27:26] = test_21_REG3_HW__FIELD_2__curr_value;
	test_21_REG3_HW[29:28] = test_21_REG3_HW__FIELD_1__curr_value;
	test_21_REG3_HW[31:30] = test_21_REG3_HW__FIELD_0__curr_value;
end
assign reg_rd_data_in[2] = test_21_REG3_HW;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_21_REG4_PRECEDENCE//
//REG HIERARCHY: ['test_21', 'REG4_PRECEDENCE']//
//REG ABSOLUTE_ADDR:64'h80c//
//REG OFFSET_ADDR:64'h64'hc//
logic [31:0] test_21_REG4_PRECEDENCE;
assign test_21_REG4_PRECEDENCE_wr_data = reg_sel[3] && internal_wr_en ? internal_wr_data : 0;
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
x__test_21_REG4_PRECEDENCE__FIELD_1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_21_REG4_PRECEDENCE_wr_data[29:28]),
	.sw_rd(rd_sel_ff[3]),
	.sw_wr(wr_sel_ff[3]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG4_PRECEDENCE__FIELD_1__next_value),
	.hw_pulse(test_21_REG4_PRECEDENCE__FIELD_1__pulse),
	.field_value(test_21_REG4_PRECEDENCE__FIELD_1__curr_value)
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
x__test_21_REG4_PRECEDENCE__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_21_REG4_PRECEDENCE_wr_data[31:30]),
	.sw_rd(rd_sel_ff[3]),
	.sw_wr(wr_sel_ff[3]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG4_PRECEDENCE__FIELD_0__next_value),
	.hw_pulse(test_21_REG4_PRECEDENCE__FIELD_0__pulse),
	.field_value(test_21_REG4_PRECEDENCE__FIELD_0__curr_value)
	);
always_comb begin
	test_21_REG4_PRECEDENCE[31:0] = 32'h0;
	test_21_REG4_PRECEDENCE[29:28] = test_21_REG4_PRECEDENCE__FIELD_1__curr_value;
	test_21_REG4_PRECEDENCE[31:30] = test_21_REG4_PRECEDENCE__FIELD_0__curr_value;
end
assign reg_rd_data_in[3] = test_21_REG4_PRECEDENCE;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_21_REG5_SINGLEPULSE//
//REG HIERARCHY: ['test_21', 'REG5_SINGLEPULSE']//
//REG ABSOLUTE_ADDR:64'h810//
//REG OFFSET_ADDR:64'h64'h10//
logic [31:0] test_21_REG5_SINGLEPULSE;
assign test_21_REG5_SINGLEPULSE_wr_data = reg_sel[4] && internal_wr_en ? internal_wr_data : 0;
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
x__test_21_REG5_SINGLEPULSE__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_21_REG5_SINGLEPULSE_wr_data[31:31]),
	.sw_rd(rd_sel_ff[4]),
	.sw_wr(wr_sel_ff[4]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_21_REG5_SINGLEPULSE__FIELD_0__next_value),
	.hw_pulse(test_21_REG5_SINGLEPULSE__FIELD_0__pulse),
	.field_value(test_21_REG5_SINGLEPULSE__FIELD_0__curr_value)
	);
always_comb begin
	test_21_REG5_SINGLEPULSE[31:0] = 32'h0;
	test_21_REG5_SINGLEPULSE[31:31] = test_21_REG5_SINGLEPULSE__FIELD_0__curr_value;
end
assign reg_rd_data_in[4] = test_21_REG5_SINGLEPULSE;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_21_REG6_SW_ACC_MOD//
//REG HIERARCHY: ['test_21', 'REG6_SW_ACC_MOD']//
//REG ABSOLUTE_ADDR:64'h814//
//REG OFFSET_ADDR:64'h64'h14//
logic [31:0] test_21_REG6_SW_ACC_MOD;
assign test_21_REG6_SW_ACC_MOD_wr_data = reg_sel[5] && internal_wr_en ? internal_wr_data : 0;
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
x__test_21_REG6_SW_ACC_MOD__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data(test_21_REG6_SW_ACC_MOD_wr_data[31:30]),
	.sw_rd(rd_sel_ff[5]),
	.sw_wr(wr_sel_ff[5]),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(test_21_REG6_SW_ACC_MOD__FIELD_0__swmod_out),
	.swacc_out(test_21_REG6_SW_ACC_MOD__FIELD_0__swacc_out),
	.hw_value(test_21_REG6_SW_ACC_MOD__FIELD_0__next_value),
	.hw_pulse(test_21_REG6_SW_ACC_MOD__FIELD_0__pulse),
	.field_value(test_21_REG6_SW_ACC_MOD__FIELD_0__curr_value)
	);
always_comb begin
	test_21_REG6_SW_ACC_MOD[31:0] = 32'h0;
	test_21_REG6_SW_ACC_MOD[31:30] = test_21_REG6_SW_ACC_MOD__FIELD_0__curr_value;
end
assign reg_rd_data_in[5] = test_21_REG6_SW_ACC_MOD;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_21_REG1_SW_R_W_alias//
//REG HIERARCHY: ['test_21', 'REG1_SW_R_W_alias']//
//REG ABSOLUTE_ADDR:64'h900//
//REG OFFSET_ADDR:64'h64'h100//
logic [31:0] test_21_REG1_SW_R_W_alias;
assign test_21_REG1_SW_R_W_alias_wr_data = reg_sel[6] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	test_21_REG1_SW_R_W_alias[31:0] = 32'h0;
	test_21_REG1_SW_R_W_alias[13:12] = test_21_REG1_SW_RW__FIELD_8__curr_value;
	test_21_REG1_SW_R_W_alias[15:14] = test_21_REG1_SW_RW__FIELD_7__curr_value;
	test_21_REG1_SW_R_W_alias[17:16] = test_21_REG1_SW_RW__FIELD_6__curr_value;
	test_21_REG1_SW_R_W_alias[19:18] = test_21_REG1_SW_RW__FIELD_5__curr_value;
	test_21_REG1_SW_R_W_alias[21:20] = test_21_REG1_SW_RW__FIELD_4__curr_value;
	test_21_REG1_SW_R_W_alias[23:22] = test_21_REG1_SW_RW__FIELD_3__curr_value;
	test_21_REG1_SW_R_W_alias[25:24] = test_21_REG1_SW_RW__FIELD_2__curr_value;
	test_21_REG1_SW_R_W_alias[27:26] = test_21_REG1_SW_RW__FIELD_1__curr_value;
	test_21_REG1_SW_R_W_alias[29:28] = test_21_REG1_SW_RW__FIELD_0__curr_value;
end
assign reg_rd_data_in[6] = test_21_REG1_SW_R_W_alias;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_21_REG2_SRST_alias//
//REG HIERARCHY: ['test_21', 'REG2_SRST_alias']//
//REG ABSOLUTE_ADDR:64'h904//
//REG OFFSET_ADDR:64'h64'h104//
logic [31:0] test_21_REG2_SRST_alias;
assign test_21_REG2_SRST_alias_wr_data = reg_sel[7] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	test_21_REG2_SRST_alias[31:0] = 32'h0;
end
assign reg_rd_data_in[7] = test_21_REG2_SRST_alias;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_22_shared_2//
//REG HIERARCHY: ['test_22', 'shared_2']//
//REG ABSOLUTE_ADDR:64'h908//
//REG OFFSET_ADDR:64'h64'h0//
logic [31:0] test_22_shared_2;
assign test_22_shared_2_wr_data = reg_sel[8] && internal_wr_en ? internal_wr_data : 0;
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
x__test_22_shared_2__FIELD_0
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst_n(rstn),
	.sync_rst(1'b0),
	.sw_wr_data({test_22_shared_2_wr_data[31:0],test_23_shared_3_wr_data[31:0]}),
	.sw_rd({rd_sel_ff[8],rd_sel_ff[9]}),
	.sw_wr({wr_sel_ff[8],wr_sel_ff[9]}),
	.write_protect_en(1'b0),
	.sw_type_alter_signal(1'b0),
	.swmod_out(),
	.swacc_out(),
	.hw_value(test_22_shared_2__FIELD_0__next_value),
	.hw_pulse(test_22_shared_2__FIELD_0__pulse),
	.field_value(test_22_shared_2__FIELD_0__curr_value)
	);
always_comb begin
	test_22_shared_2[31:0] = 32'h0;
	test_22_shared_2[31:0] = test_22_shared_2__FIELD_0__curr_value;
end
assign reg_rd_data_in[8] = test_22_shared_2;
//==========================================END REG INSTANT===========================================//
//============================================REG INSTANT=============================================//
//REG NAME: test_23_shared_3//
//REG HIERARCHY: ['test_23', 'shared_3']//
//REG ABSOLUTE_ADDR:64'h90c//
//REG OFFSET_ADDR:64'h64'h0//
logic [31:0] test_23_shared_3;
assign test_23_shared_3_wr_data = reg_sel[9] && internal_wr_en ? internal_wr_data : 0;
always_comb begin
	test_23_shared_3[31:0] = 32'h0;
	test_23_shared_3[31:0] = test_22_shared_2__FIELD_0__curr_value;
end
assign reg_rd_data_in[9] = test_23_shared_3;
//==========================================END REG INSTANT===========================================//
//********************************Register&field Instantiate END Here*********************************//
endmodule