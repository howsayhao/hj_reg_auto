`include "xregister.vh"
`default_nettype none
module regslv_reg_top__reg_block_1(
//*************************************EXTERNAL MODULE PORT START*************************************//
//**************************************EXTERNAL MODULE PORT END**************************************//


//*************************************INTERNAL FIELD PORT START**************************************//
	// ports of internal regfile
	// ports of ['REG1', 'FIELD_0']
	REG1__FIELD_0__next_value        ,
	REG1__FIELD_0__pulse             ,
	REG1__FIELD_0__curr_value        ,
	// ports of ['test_2', 'shared_21', 'FIELD_0']
	test_2_shared_21__FIELD_0__next_value        ,
	test_2_shared_21__FIELD_0__pulse             ,
	test_2_shared_21__FIELD_0__curr_value        ,
//**************************************INTERNAL FIELD PORT END***************************************//


//****************************************STANDARD PORT START*****************************************//
	fsm_clk                 ,
	fsm_rstn                ,
	req_vld                 ,
	ack_vld                 ,
	wr_en                   ,
	rd_en                   ,
	addr                    ,
	wr_data                 ,
	rd_data                 ,
	global_sync_reset_in    ,
	global_sync_reset_out
//*****************************************STANDARD PORT END******************************************//
);


//*************************************PARAMETER DEFINITION START*************************************//
	parameter                  ADDR_WIDTH = 64          ;
	parameter                  DATA_WIDTH = 32          ;
	//N:number of internal registers, M:number of external modules
	localparam                 N = 22                    ;
	localparam                 M = 0                    ;
	localparam                 REG_NUM = N ? N : 1      ;
	localparam                 EXT_NUM = M ? M : 1      ;
//**************************************PARAMETER DEFINITION END**************************************//


//***************************************PORT DECLARATION START***************************************//
	// regslv domain fsm_clk
	input                         fsm_clk                 ;
	input                         fsm_rstn                ;
	input                         req_vld                 ;
	output                        ack_vld                 ;
	input                         wr_en                   ;
	input                         rd_en                   ;
	input     [ADDR_WIDTH-1:0]    addr                    ;
	input     [DATA_WIDTH-1:0]    wr_data                 ;
	output    [DATA_WIDTH-1:0]    rd_data                 ;
	input                         global_sync_reset_in    ;
	output                        global_sync_reset_out   ;
	//ports define of internal regfile
	wire regfile_clk   = fsm_clk   ;
	wire regfile_rstn  = fsm_rstn  ;
	// ports of ['REG1', 'FIELD_0']
	input  [32-1:0]    REG1__FIELD_0__next_value        ;
	input              REG1__FIELD_0__pulse             ;
	output [32-1:0]    REG1__FIELD_0__curr_value        ;
	// ports of ['test_2', 'shared_21', 'FIELD_0']
	input  [32-1:0]    test_2_shared_21__FIELD_0__next_value        ;
	input              test_2_shared_21__FIELD_0__pulse             ;
	output [32-1:0]    test_2_shared_21__FIELD_0__curr_value        ;
//****************************************PORT DECLARATION END****************************************//


//***************************************WIRE DECLARATION START***************************************//
	// declare the handshake signal for fsm
	wire                   slv__fsm__ack_vld		;
	reg                    new_ack_launched		;
	reg                    fsm__slv__req_vld_ff  ;
	wire                   fsm__slv__req_vld_int ;
	reg                    fsm__slv__req_vld     ;
	// signal for fsm
	wire 						fsm__slv__wr_en		;
	wire 						fsm__slv__rd_en		;
	wire [ADDR_WIDTH-1:0] 		fsm__slv__addr		;
	wire [DATA_WIDTH-1:0] 		fsm__slv__wr_data	;
	wire [DATA_WIDTH-1:0]  		slv__fsm__rd_data	;
	// fsm state indicator
	wire				   		cs_is_idle			;
	reg                new_ack_lanuch            ;

	// signal for decoder
	// signal for global decoder @regslv domain
	logic [64-1:0] 			global_address	;
	logic [EXT_NUM-1:0] 	ext_sel			;
	logic 					int_selected	;
	logic 					ext_selected	;
	logic 					none_selected	;
	// signal for internal decoder @regfile domain
	logic [REG_NUM-1:0] 	reg_sel			;
	logic 					dummy_reg		;

	// signal for regfile split mux
	logic [REG_NUM-1:0] [DATA_WIDTH-1:0] regfile_reg_rd_data_in;

	// signal for external split mux
	wire [EXT_NUM-1:0]                     ext_req_vld_fsm      ;
	wire [EXT_NUM-1:0]                     ext_ack_vld_fsm      ;
	wire [EXT_NUM-1:0]                     ext_ack_fsm		    ;
	wire                                   ext_wr_en_fsm        ;
	wire                                   ext_rd_en_fsm        ;
	wire [ADDR_WIDTH-1:0]                  ext_addr_fsm         ;
	wire [DATA_WIDTH-1:0]                  ext_wr_data_fsm      ;
	wire [EXT_NUM-1:0] [DATA_WIDTH-1:0]    ext_rd_data_fsm      ;
	wire [DATA_WIDTH-1:0] 				   ext_rd_data_vld_fsm	;
	wire                                   ext_reg_ack_vld_fsm  ;

	// regfile signal in regslv domain
	wire [EXT_NUM-1:0]                     regfile_req_vld_fsm      ;
	wire                                   regfile_ack_vld_fsm      ;
	wire                                   regfile_wr_en_fsm        ;
	wire                                   regfile_rd_en_fsm        ;
	wire [ADDR_WIDTH-1:0]                  regfile_addr_fsm         ;
	wire [DATA_WIDTH-1:0]                  regfile_wr_data_fsm      ;
	wire [DATA_WIDTH-1:0]                  regfile_rd_data_fsm      ;

	// regfile signal in regfile domain
	wire [REG_NUM-1:0] wr_sel;
	wire [REG_NUM-1:0] rd_sel;
	wire [EXT_NUM-1:0]                     regfile_req_vld      ;
	wire                                   regfile_ack_vld      ;
	wire                                   regfile_rd_ack_vld   ;
	wire                                   regfile_wr_en        ;
	wire                                   regfile_rd_en        ;
	wire [ADDR_WIDTH-1:0]                  regfile_addr         ;
	wire [DATA_WIDTH-1:0]                  regfile_wr_data      ;
	wire [DATA_WIDTH-1:0]                  regfile_rd_data      ;
	logic [31:0] REG1_wr_data;
	logic REG1_wr_en;
	logic REG1_rd_en;
	logic [31:0] REG1_alias_1_wr_data;
	logic REG1_alias_1_wr_en;
	logic REG1_alias_1_rd_en;
	logic [31:0] REG1_alias_2_wr_data;
	logic REG1_alias_2_wr_en;
	logic REG1_alias_2_rd_en;
	logic [31:0] REG1_alias_3_wr_data;
	logic REG1_alias_3_wr_en;
	logic REG1_alias_3_rd_en;
	logic [31:0] REG1_alias_4_wr_data;
	logic REG1_alias_4_wr_en;
	logic REG1_alias_4_rd_en;
	logic [31:0] REG1_alias_5_wr_data;
	logic REG1_alias_5_wr_en;
	logic REG1_alias_5_rd_en;
	logic [31:0] REG1_alias_6_wr_data;
	logic REG1_alias_6_wr_en;
	logic REG1_alias_6_rd_en;
	logic [31:0] REG1_alias_7_wr_data;
	logic REG1_alias_7_wr_en;
	logic REG1_alias_7_rd_en;
	logic [31:0] REG1_alias_8_wr_data;
	logic REG1_alias_8_wr_en;
	logic REG1_alias_8_rd_en;
	logic [31:0] REG1_alias_9_wr_data;
	logic REG1_alias_9_wr_en;
	logic REG1_alias_9_rd_en;
	logic [31:0] REG1_alias_10_wr_data;
	logic REG1_alias_10_wr_en;
	logic REG1_alias_10_rd_en;
	logic [31:0] test_2_shared_21_wr_data;
	logic test_2_shared_21_wr_en;
	logic test_2_shared_21_rd_en;
	logic [31:0] test_2_shared_22_wr_data;
	logic test_2_shared_22_wr_en;
	logic test_2_shared_22_rd_en;
	logic [31:0] test_2_shared_23_wr_data;
	logic test_2_shared_23_wr_en;
	logic test_2_shared_23_rd_en;
	logic [31:0] test_2_shared_24_wr_data;
	logic test_2_shared_24_wr_en;
	logic test_2_shared_24_rd_en;
	logic [31:0] test_2_shared_25_wr_data;
	logic test_2_shared_25_wr_en;
	logic test_2_shared_25_rd_en;
	logic [31:0] test_2_shared_26_wr_data;
	logic test_2_shared_26_wr_en;
	logic test_2_shared_26_rd_en;
	logic [31:0] test_2_shared_27_wr_data;
	logic test_2_shared_27_wr_en;
	logic test_2_shared_27_rd_en;
	logic [31:0] test_2_shared_28_wr_data;
	logic test_2_shared_28_wr_en;
	logic test_2_shared_28_rd_en;
	logic [31:0] test_2_shared_29_wr_data;
	logic test_2_shared_29_wr_en;
	logic test_2_shared_29_rd_en;
	logic [31:0] test_2_shared_210_wr_data;
	logic test_2_shared_210_wr_en;
	logic test_2_shared_210_rd_en;
	logic [31:0] test_3_shared_31_wr_data;
	logic test_3_shared_31_wr_en;
	logic test_3_shared_31_rd_en;
//****************************************WIRE DECLARATION END****************************************//


//***************************************ADDRESS DECODER START****************************************//
	// global fsm_decoder @regslv domain
	assign global_address   = cs_is_idle ? addr : fsm__slv__addr;
	assign ext_selected     = | ext_sel;
	always_comb begin
			int_selected = 1'b0;
			ext_sel = {EXT_NUM{1'b0}};
			none_selected = 1'b0;
		unique casez (global_address)
			64'h0,64'h4,64'h8,64'hc,64'h10,64'h14,64'h18,64'h1c,64'h20,64'h24,64'h28,64'h40,64'h44,64'h48,64'h4c,64'h50,64'h54,64'h58,64'h5c,64'h60,64'h64,64'h68:int_selected = 1'b1;//
			default: none_selected = 1'b1;
		endcase
	end
	// internal regfile decoder @regfile domain
	always_comb begin
			reg_sel = {REG_NUM{1'b0}};
			dummy_reg = 1'b0;
		unique casez (regfile_addr)
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
			64'h40:reg_sel[11] = 1'b1;//['test_2', 'shared_21']
			64'h44:reg_sel[12] = 1'b1;//['test_2', 'shared_22']
			64'h48:reg_sel[13] = 1'b1;//['test_2', 'shared_23']
			64'h4c:reg_sel[14] = 1'b1;//['test_2', 'shared_24']
			64'h50:reg_sel[15] = 1'b1;//['test_2', 'shared_25']
			64'h54:reg_sel[16] = 1'b1;//['test_2', 'shared_26']
			64'h58:reg_sel[17] = 1'b1;//['test_2', 'shared_27']
			64'h5c:reg_sel[18] = 1'b1;//['test_2', 'shared_28']
			64'h60:reg_sel[19] = 1'b1;//['test_2', 'shared_29']
			64'h64:reg_sel[20] = 1'b1;//['test_2', 'shared_210']
			64'h68:reg_sel[21] = 1'b1;//['test_3', 'shared_31']
			default: dummy_reg = 1'b1;
		endcase
	end
//****************************************ADDRESS DECODER END*****************************************//


//************************************STATE MACHINE INSTANCE START************************************//
	slv_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
		slv_fsm_reg_top__reg_block_1 (
		.clk(fsm_clk), .rstn(fsm_rstn), .mst__fsm__req_vld(req_vld), .mst__fsm__wr_en(wr_en), .mst__fsm__rd_en(rd_en), .mst__fsm__addr(addr), .mst__fsm__wr_data(wr_data),
		.slv__fsm__rd_data(slv__fsm__rd_data), .slv__fsm__ack_vld(slv__fsm__ack_vld), .fsm__slv__req_vld(fsm__slv__req_vld),
		.fsm__slv__wr_en(fsm__slv__wr_en), .fsm__slv__rd_en(fsm__slv__rd_en), .fsm__slv__addr(fsm__slv__addr), .fsm__slv__wr_data(fsm__slv__wr_data),
		.fsm__mst__rd_data(rd_data), .fsm__mst__ack_vld(ack_vld),
		.external_reg_selected(ext_selected),
		.cs_is_idle(cs_is_idle),		.mst__fsm__sync_reset(global_sync_reset_in),
		.fsm__slv__sync_reset(global_sync_reset_out)
	);
	always@(posedge fsm_clk or negedge fsm_rstn) begin
		if(~fsm_rstn)begin
			new_ack_launched <= 1'b0;
			fsm__slv__req_vld_ff <= 1'b0;
		end
		else begin
			fsm__slv__req_vld_ff <= fsm__slv__req_vld;
			if(fsm__slv__req_vld & ! fsm__slv__req_vld_ff) new_ack_launched <= 1'b0;
			else if(| ext_ack_fsm) new_ack_launched <= 1'b1;
			else new_ack_launched <= 1'b0;
		end
	end

	assign fsm__slv__req_vld_int = fsm__slv__req_vld & !new_ack_launched;
//*************************************STATE MACHINE INSTANCE END*************************************//


//**************************************SPLIT MUX INSTANCE START**************************************//
	// regfile mux @regfile domain
	split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(N+1), .GROUP_SIZE(128), .SKIP_DFF_0(1), .SKIP_DFF_1(1)) rd_split_mux
	(.clk(regfile_clk), .rst_n(regfile_rstn),
	.din({regfile_reg_rd_data_in,{DATA_WIDTH{1'b0}}}), .sel({rd_sel, dummy_reg}),
	.dout(regfile_rd_data), .dout_vld(regfile_rd_ack_vld)
	);
//***************************************SPLIT MUX INSTANCE END***************************************//


//*****************************************ULTIMATE MUX START*****************************************//
	// select which to read out and transfer the corresponding vld signal @regslv domain
	assign slv__fsm__rd_data = regfile_ack_vld_fsm ? regfile_rd_data_fsm : 0;
	assign slv__fsm__ack_vld = regfile_ack_vld_fsm;
//******************************************ULTIMATE MUX END******************************************//


//******************************EXTERNAL MEMORY SNAPSHOT REGISTER START*******************************//
//*******************************EXTERNAL MEMORY SNAPSHOT REGISTER END********************************//


//*****************************EXTERNAL MEMORY CDC DELIVER INSTANT START******************************//
//******************************EXTERNAL MEMORY CDC DELIVER INSTANT END*******************************//


//*********************************REGFILE CDC DELIVER INSTANT START**********************************//
	assign regfile_req_vld_fsm = fsm__slv__req_vld & int_selected;
	assign regfile_wr_en_fsm = fsm__slv__wr_en & int_selected;
	assign regfile_rd_en_fsm = fsm__slv__rd_en & int_selected;
	assign regfile_wr_data_fsm = int_selected ? fsm__slv__wr_data : 0;
	assign regfile_addr_fsm = int_selected ? fsm__slv__addr : 0;
	assign wr_sel = {REG_NUM{regfile_wr_en}} & reg_sel;
	assign rd_sel = {REG_NUM{regfile_rd_en}} & reg_sel;
	assign regfile_ack_vld = regfile_rd_ack_vld | regfile_wr_en;
	assign regfile_req_vld       = regfile_req_vld_fsm    ;
	assign regfile_ack_vld_fsm   = regfile_ack_vld        ;
	assign regfile_wr_en         = regfile_wr_en_fsm      ;
	assign regfile_rd_en         = regfile_rd_en_fsm      ;
	assign regfile_addr          = regfile_addr_fsm       ;
	assign regfile_wr_data       = regfile_wr_data_fsm    ;
	assign regfile_rd_data_fsm   = regfile_rd_data        ;
//**********************************REGFILE CDC DELIVER INSTANT END***********************************//


//**************************************REG/FIELD INSTANCE START**************************************//
	//============================================REG INSTANT=============================================//
	//REG NAME: REG1//
	//REG HIERARCHY: ['REG1']//
	//REG ABSOLUTE_ADDR:64'h0//
	//REG OFFSET_ADDR:64'h64'h0//
	logic [31:0] REG1_o;
	assign REG1_wr_data = wr_sel[0] ? regfile_wr_data : 0;
	assign REG1_wr_en = wr_sel[0];
	assign REG1_rd_en = rd_sel[0];
	field
		//**************PARAMETER INSTANTIATE***************//
		#(
		.F_WIDTH               (32),
		.ARST_VALUE            (32'haaaaaaaa),
		.ALIAS_NUM             (11),
		.SW_TYPE               ({`SW_RW,`SW_RO,`SW_WO,`SW_RW,`SW_RW,`SW_RW,`SW_RW,`SW_RW,`SW_RW,`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA,`NA,`RCLR,`RSET,`NA,`NA,`NA,`NA,`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA,`NA,`NA,`NA,`WOCLR,`WOSET,`WOT,`WZS,`WZC,`WZT}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__REG1__FIELD_0
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst                (1'b0),
		.sw_wr_data            ({REG1_wr_data[31:0],REG1_alias_1_wr_data[31:0],REG1_alias_2_wr_data[31:0],REG1_alias_3_wr_data[31:0],REG1_alias_4_wr_data[31:0],REG1_alias_5_wr_data[31:0],REG1_alias_6_wr_data[31:0],REG1_alias_7_wr_data[31:0],REG1_alias_8_wr_data[31:0],REG1_alias_9_wr_data[31:0],REG1_alias_10_wr_data[31:0]}),
		.sw_rd                 ({REG1_rd_en,REG1_alias_1_rd_en,REG1_alias_2_rd_en,REG1_alias_3_rd_en,REG1_alias_4_rd_en,REG1_alias_5_rd_en,REG1_alias_6_rd_en,REG1_alias_7_rd_en,REG1_alias_8_rd_en,REG1_alias_9_rd_en,REG1_alias_10_rd_en}),
		.sw_wr                 ({REG1_wr_en,REG1_alias_1_wr_en,REG1_alias_2_wr_en,REG1_alias_3_wr_en,REG1_alias_4_wr_en,REG1_alias_5_wr_en,REG1_alias_6_wr_en,REG1_alias_7_wr_en,REG1_alias_8_wr_en,REG1_alias_9_wr_en,REG1_alias_10_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (REG1__FIELD_0__next_value),
		.hw_pulse              (REG1__FIELD_0__pulse),
		.field_value           (REG1__FIELD_0__curr_value)
		);
	always_comb begin
	REG1_o[31:0] = 32'h0;
		REG1_o[31:0] = REG1__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[0] = REG1_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: REG1_alias_1//
	//REG HIERARCHY: ['REG1_alias_1']//
	//REG ABSOLUTE_ADDR:64'h4//
	//REG OFFSET_ADDR:64'h64'h4//
	logic [31:0] REG1_alias_1_o;
	assign REG1_alias_1_wr_data = wr_sel[1] ? regfile_wr_data : 0;
	assign REG1_alias_1_wr_en = wr_sel[1];
	assign REG1_alias_1_rd_en = rd_sel[1];
	always_comb begin
	REG1_alias_1_o[31:0] = 32'h0;
		REG1_alias_1_o[31:0] = REG1__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[1] = REG1_alias_1_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: REG1_alias_2//
	//REG HIERARCHY: ['REG1_alias_2']//
	//REG ABSOLUTE_ADDR:64'h8//
	//REG OFFSET_ADDR:64'h64'h8//
	logic [31:0] REG1_alias_2_o;
	assign REG1_alias_2_wr_data = wr_sel[2] ? regfile_wr_data : 0;
	assign REG1_alias_2_wr_en = wr_sel[2];
	assign REG1_alias_2_rd_en = rd_sel[2];
	always_comb begin
	REG1_alias_2_o[31:0] = 32'h0;
		REG1_alias_2_o[31:0] = REG1__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[2] = REG1_alias_2_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: REG1_alias_3//
	//REG HIERARCHY: ['REG1_alias_3']//
	//REG ABSOLUTE_ADDR:64'hc//
	//REG OFFSET_ADDR:64'h64'hc//
	logic [31:0] REG1_alias_3_o;
	assign REG1_alias_3_wr_data = wr_sel[3] ? regfile_wr_data : 0;
	assign REG1_alias_3_wr_en = wr_sel[3];
	assign REG1_alias_3_rd_en = rd_sel[3];
	always_comb begin
	REG1_alias_3_o[31:0] = 32'h0;
		REG1_alias_3_o[31:0] = REG1__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[3] = REG1_alias_3_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: REG1_alias_4//
	//REG HIERARCHY: ['REG1_alias_4']//
	//REG ABSOLUTE_ADDR:64'h10//
	//REG OFFSET_ADDR:64'h64'h10//
	logic [31:0] REG1_alias_4_o;
	assign REG1_alias_4_wr_data = wr_sel[4] ? regfile_wr_data : 0;
	assign REG1_alias_4_wr_en = wr_sel[4];
	assign REG1_alias_4_rd_en = rd_sel[4];
	always_comb begin
	REG1_alias_4_o[31:0] = 32'h0;
		REG1_alias_4_o[31:0] = REG1__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[4] = REG1_alias_4_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: REG1_alias_5//
	//REG HIERARCHY: ['REG1_alias_5']//
	//REG ABSOLUTE_ADDR:64'h14//
	//REG OFFSET_ADDR:64'h64'h14//
	logic [31:0] REG1_alias_5_o;
	assign REG1_alias_5_wr_data = wr_sel[5] ? regfile_wr_data : 0;
	assign REG1_alias_5_wr_en = wr_sel[5];
	assign REG1_alias_5_rd_en = rd_sel[5];
	always_comb begin
	REG1_alias_5_o[31:0] = 32'h0;
		REG1_alias_5_o[31:0] = REG1__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[5] = REG1_alias_5_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: REG1_alias_6//
	//REG HIERARCHY: ['REG1_alias_6']//
	//REG ABSOLUTE_ADDR:64'h18//
	//REG OFFSET_ADDR:64'h64'h18//
	logic [31:0] REG1_alias_6_o;
	assign REG1_alias_6_wr_data = wr_sel[6] ? regfile_wr_data : 0;
	assign REG1_alias_6_wr_en = wr_sel[6];
	assign REG1_alias_6_rd_en = rd_sel[6];
	always_comb begin
	REG1_alias_6_o[31:0] = 32'h0;
		REG1_alias_6_o[31:0] = REG1__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[6] = REG1_alias_6_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: REG1_alias_7//
	//REG HIERARCHY: ['REG1_alias_7']//
	//REG ABSOLUTE_ADDR:64'h1c//
	//REG OFFSET_ADDR:64'h64'h1c//
	logic [31:0] REG1_alias_7_o;
	assign REG1_alias_7_wr_data = wr_sel[7] ? regfile_wr_data : 0;
	assign REG1_alias_7_wr_en = wr_sel[7];
	assign REG1_alias_7_rd_en = rd_sel[7];
	always_comb begin
	REG1_alias_7_o[31:0] = 32'h0;
		REG1_alias_7_o[31:0] = REG1__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[7] = REG1_alias_7_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: REG1_alias_8//
	//REG HIERARCHY: ['REG1_alias_8']//
	//REG ABSOLUTE_ADDR:64'h20//
	//REG OFFSET_ADDR:64'h64'h20//
	logic [31:0] REG1_alias_8_o;
	assign REG1_alias_8_wr_data = wr_sel[8] ? regfile_wr_data : 0;
	assign REG1_alias_8_wr_en = wr_sel[8];
	assign REG1_alias_8_rd_en = rd_sel[8];
	always_comb begin
	REG1_alias_8_o[31:0] = 32'h0;
		REG1_alias_8_o[31:0] = REG1__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[8] = REG1_alias_8_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: REG1_alias_9//
	//REG HIERARCHY: ['REG1_alias_9']//
	//REG ABSOLUTE_ADDR:64'h24//
	//REG OFFSET_ADDR:64'h64'h24//
	logic [31:0] REG1_alias_9_o;
	assign REG1_alias_9_wr_data = wr_sel[9] ? regfile_wr_data : 0;
	assign REG1_alias_9_wr_en = wr_sel[9];
	assign REG1_alias_9_rd_en = rd_sel[9];
	always_comb begin
	REG1_alias_9_o[31:0] = 32'h0;
		REG1_alias_9_o[31:0] = REG1__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[9] = REG1_alias_9_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: REG1_alias_10//
	//REG HIERARCHY: ['REG1_alias_10']//
	//REG ABSOLUTE_ADDR:64'h28//
	//REG OFFSET_ADDR:64'h64'h28//
	logic [31:0] REG1_alias_10_o;
	assign REG1_alias_10_wr_data = wr_sel[10] ? regfile_wr_data : 0;
	assign REG1_alias_10_wr_en = wr_sel[10];
	assign REG1_alias_10_rd_en = rd_sel[10];
	always_comb begin
	REG1_alias_10_o[31:0] = 32'h0;
		REG1_alias_10_o[31:0] = REG1__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[10] = REG1_alias_10_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: test_2_shared_21//
	//REG HIERARCHY: ['test_2', 'shared_21']//
	//REG ABSOLUTE_ADDR:64'h40//
	//REG OFFSET_ADDR:64'h64'h0//
	logic [31:0] test_2_shared_21_o;
	assign test_2_shared_21_wr_data = wr_sel[11] ? regfile_wr_data : 0;
	assign test_2_shared_21_wr_en = wr_sel[11];
	assign test_2_shared_21_rd_en = rd_sel[11];
	field
		//**************PARAMETER INSTANTIATE***************//
		#(
		.F_WIDTH               (32),
		.SRST_CNT              (2),
		.ARST_VALUE            (32'haaaaaaaa),
		.ALIAS_NUM             (11),
		.SW_TYPE               ({`SW_RO,`SW_WO,`SW_RW,`SW_RW,`SW_RW,`SW_RW,`SW_RW,`SW_RW,`SW_RW,`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA,`RCLR,`RSET,`NA,`NA,`NA,`NA,`NA,`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA,`NA,`NA,`WOCLR,`WOSET,`WOT,`WZS,`WZC,`WZT,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__test_2_shared_21__FIELD_0
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              ({srst_1,srst_2}),
		.sw_wr_data            ({test_2_shared_21_wr_data[31:0],test_2_shared_22_wr_data[31:0],test_2_shared_23_wr_data[31:0],test_2_shared_24_wr_data[31:0],test_2_shared_25_wr_data[31:0],test_2_shared_26_wr_data[31:0],test_2_shared_27_wr_data[31:0],test_2_shared_28_wr_data[31:0],test_2_shared_29_wr_data[31:0],test_2_shared_210_wr_data[31:0],test_3_shared_31_wr_data[31:0]}),
		.sw_rd                 ({test_2_shared_21_rd_en,test_2_shared_22_rd_en,test_2_shared_23_rd_en,test_2_shared_24_rd_en,test_2_shared_25_rd_en,test_2_shared_26_rd_en,test_2_shared_27_rd_en,test_2_shared_28_rd_en,test_2_shared_29_rd_en,test_2_shared_210_rd_en,test_3_shared_31_rd_en}),
		.sw_wr                 ({test_2_shared_21_wr_en,test_2_shared_22_wr_en,test_2_shared_23_wr_en,test_2_shared_24_wr_en,test_2_shared_25_wr_en,test_2_shared_26_wr_en,test_2_shared_27_wr_en,test_2_shared_28_wr_en,test_2_shared_29_wr_en,test_2_shared_210_wr_en,test_3_shared_31_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (test_2_shared_21__FIELD_0__next_value),
		.hw_pulse              (test_2_shared_21__FIELD_0__pulse),
		.field_value           (test_2_shared_21__FIELD_0__curr_value)
		);
	always_comb begin
	test_2_shared_21_o[31:0] = 32'h0;
		test_2_shared_21_o[31:0] = test_2_shared_21__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[11] = test_2_shared_21_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: test_2_shared_22//
	//REG HIERARCHY: ['test_2', 'shared_22']//
	//REG ABSOLUTE_ADDR:64'h44//
	//REG OFFSET_ADDR:64'h64'h4//
	logic [31:0] test_2_shared_22_o;
	assign test_2_shared_22_wr_data = wr_sel[12] ? regfile_wr_data : 0;
	assign test_2_shared_22_wr_en = wr_sel[12];
	assign test_2_shared_22_rd_en = rd_sel[12];
	always_comb begin
	test_2_shared_22_o[31:0] = 32'h0;
		test_2_shared_22_o[31:0] = test_2_shared_21__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[12] = test_2_shared_22_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: test_2_shared_23//
	//REG HIERARCHY: ['test_2', 'shared_23']//
	//REG ABSOLUTE_ADDR:64'h48//
	//REG OFFSET_ADDR:64'h64'h8//
	logic [31:0] test_2_shared_23_o;
	assign test_2_shared_23_wr_data = wr_sel[13] ? regfile_wr_data : 0;
	assign test_2_shared_23_wr_en = wr_sel[13];
	assign test_2_shared_23_rd_en = rd_sel[13];
	always_comb begin
	test_2_shared_23_o[31:0] = 32'h0;
		test_2_shared_23_o[31:0] = test_2_shared_21__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[13] = test_2_shared_23_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: test_2_shared_24//
	//REG HIERARCHY: ['test_2', 'shared_24']//
	//REG ABSOLUTE_ADDR:64'h4c//
	//REG OFFSET_ADDR:64'h64'hc//
	logic [31:0] test_2_shared_24_o;
	assign test_2_shared_24_wr_data = wr_sel[14] ? regfile_wr_data : 0;
	assign test_2_shared_24_wr_en = wr_sel[14];
	assign test_2_shared_24_rd_en = rd_sel[14];
	always_comb begin
	test_2_shared_24_o[31:0] = 32'h0;
		test_2_shared_24_o[31:0] = test_2_shared_21__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[14] = test_2_shared_24_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: test_2_shared_25//
	//REG HIERARCHY: ['test_2', 'shared_25']//
	//REG ABSOLUTE_ADDR:64'h50//
	//REG OFFSET_ADDR:64'h64'h10//
	logic [31:0] test_2_shared_25_o;
	assign test_2_shared_25_wr_data = wr_sel[15] ? regfile_wr_data : 0;
	assign test_2_shared_25_wr_en = wr_sel[15];
	assign test_2_shared_25_rd_en = rd_sel[15];
	always_comb begin
	test_2_shared_25_o[31:0] = 32'h0;
		test_2_shared_25_o[31:0] = test_2_shared_21__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[15] = test_2_shared_25_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: test_2_shared_26//
	//REG HIERARCHY: ['test_2', 'shared_26']//
	//REG ABSOLUTE_ADDR:64'h54//
	//REG OFFSET_ADDR:64'h64'h14//
	logic [31:0] test_2_shared_26_o;
	assign test_2_shared_26_wr_data = wr_sel[16] ? regfile_wr_data : 0;
	assign test_2_shared_26_wr_en = wr_sel[16];
	assign test_2_shared_26_rd_en = rd_sel[16];
	always_comb begin
	test_2_shared_26_o[31:0] = 32'h0;
		test_2_shared_26_o[31:0] = test_2_shared_21__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[16] = test_2_shared_26_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: test_2_shared_27//
	//REG HIERARCHY: ['test_2', 'shared_27']//
	//REG ABSOLUTE_ADDR:64'h58//
	//REG OFFSET_ADDR:64'h64'h18//
	logic [31:0] test_2_shared_27_o;
	assign test_2_shared_27_wr_data = wr_sel[17] ? regfile_wr_data : 0;
	assign test_2_shared_27_wr_en = wr_sel[17];
	assign test_2_shared_27_rd_en = rd_sel[17];
	always_comb begin
	test_2_shared_27_o[31:0] = 32'h0;
		test_2_shared_27_o[31:0] = test_2_shared_21__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[17] = test_2_shared_27_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: test_2_shared_28//
	//REG HIERARCHY: ['test_2', 'shared_28']//
	//REG ABSOLUTE_ADDR:64'h5c//
	//REG OFFSET_ADDR:64'h64'h1c//
	logic [31:0] test_2_shared_28_o;
	assign test_2_shared_28_wr_data = wr_sel[18] ? regfile_wr_data : 0;
	assign test_2_shared_28_wr_en = wr_sel[18];
	assign test_2_shared_28_rd_en = rd_sel[18];
	always_comb begin
	test_2_shared_28_o[31:0] = 32'h0;
		test_2_shared_28_o[31:0] = test_2_shared_21__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[18] = test_2_shared_28_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: test_2_shared_29//
	//REG HIERARCHY: ['test_2', 'shared_29']//
	//REG ABSOLUTE_ADDR:64'h60//
	//REG OFFSET_ADDR:64'h64'h20//
	logic [31:0] test_2_shared_29_o;
	assign test_2_shared_29_wr_data = wr_sel[19] ? regfile_wr_data : 0;
	assign test_2_shared_29_wr_en = wr_sel[19];
	assign test_2_shared_29_rd_en = rd_sel[19];
	always_comb begin
	test_2_shared_29_o[31:0] = 32'h0;
		test_2_shared_29_o[31:0] = test_2_shared_21__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[19] = test_2_shared_29_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: test_2_shared_210//
	//REG HIERARCHY: ['test_2', 'shared_210']//
	//REG ABSOLUTE_ADDR:64'h64//
	//REG OFFSET_ADDR:64'h64'h24//
	logic [31:0] test_2_shared_210_o;
	assign test_2_shared_210_wr_data = wr_sel[20] ? regfile_wr_data : 0;
	assign test_2_shared_210_wr_en = wr_sel[20];
	assign test_2_shared_210_rd_en = rd_sel[20];
	always_comb begin
	test_2_shared_210_o[31:0] = 32'h0;
		test_2_shared_210_o[31:0] = test_2_shared_21__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[20] = test_2_shared_210_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: test_3_shared_31//
	//REG HIERARCHY: ['test_3', 'shared_31']//
	//REG ABSOLUTE_ADDR:64'h68//
	//REG OFFSET_ADDR:64'h64'h0//
	logic [31:0] test_3_shared_31_o;
	assign test_3_shared_31_wr_data = wr_sel[21] ? regfile_wr_data : 0;
	assign test_3_shared_31_wr_en = wr_sel[21];
	assign test_3_shared_31_rd_en = rd_sel[21];
	always_comb begin
	test_3_shared_31_o[31:0] = 32'h0;
		test_3_shared_31_o[31:0] = test_2_shared_21__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[21] = test_3_shared_31_o;
//***************************************REG/FIELD INSTANCE END***************************************//


//**************************************REG/FIELD INSTANCE START**************************************//
//***************************************REG/FIELD INSTANCE END***************************************//


endmodule
`default_nettype wire