`include "xregister.vh"
`default_nettype none
module regslv_root_map__test_map_1_inst(
//*************************************EXTERNAL MODULE PORT START*************************************//
//**************************************EXTERNAL MODULE PORT END**************************************//


//*************************************INTERNAL FIELD PORT START**************************************//
	// ports of internal regfile
	// ports of ['TEM21', 'FIELD_3']
	TEM21__FIELD_3__next_value        ,
	TEM21__FIELD_3__pulse             ,
	TEM21__FIELD_3__curr_value        ,
	// ports of ['TEM21', 'FIELD_2']
	TEM21__FIELD_2__next_value        ,
	TEM21__FIELD_2__pulse             ,
	TEM21__FIELD_2__curr_value        ,
	// ports of ['TEM21', 'FIELD_1']
	TEM21__FIELD_1__next_value        ,
	TEM21__FIELD_1__pulse             ,
	TEM21__FIELD_1__curr_value        ,
	// ports of ['TEM22', 'FIELD_3']
	TEM22__FIELD_3__next_value        ,
	TEM22__FIELD_3__pulse             ,
	TEM22__FIELD_3__curr_value        ,
	// ports of ['TEM22', 'FIELD_2']
	TEM22__FIELD_2__next_value        ,
	TEM22__FIELD_2__pulse             ,
	TEM22__FIELD_2__curr_value        ,
	// ports of ['TEM22', 'FIELD_1']
	TEM22__FIELD_1__next_value        ,
	TEM22__FIELD_1__pulse             ,
	TEM22__FIELD_1__curr_value        ,
	// ports of ['TEM23', 'FIELD_3']
	TEM23__FIELD_3__next_value        ,
	TEM23__FIELD_3__pulse             ,
	TEM23__FIELD_3__curr_value        ,
	// ports of ['TEM23', 'FIELD_2']
	TEM23__FIELD_2__next_value        ,
	TEM23__FIELD_2__pulse             ,
	TEM23__FIELD_2__curr_value        ,
	// ports of ['TEM23', 'FIELD_1']
	TEM23__FIELD_1__next_value        ,
	TEM23__FIELD_1__pulse             ,
	TEM23__FIELD_1__curr_value        ,
	sync_rst_local_1        ,
	sync_rst_local_2        ,
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
	localparam                 N = 6                    ;
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
	// ports of ['TEM21', 'FIELD_3']
	input  [1-1:0]    TEM21__FIELD_3__next_value        ;
	input              TEM21__FIELD_3__pulse             ;
	output [1-1:0]    TEM21__FIELD_3__curr_value        ;
	// ports of ['TEM21', 'FIELD_2']
	input  [3-1:0]    TEM21__FIELD_2__next_value        ;
	input              TEM21__FIELD_2__pulse             ;
	output [3-1:0]    TEM21__FIELD_2__curr_value        ;
	// ports of ['TEM21', 'FIELD_1']
	input  [1-1:0]    TEM21__FIELD_1__next_value        ;
	input              TEM21__FIELD_1__pulse             ;
	output [1-1:0]    TEM21__FIELD_1__curr_value        ;
	// ports of ['TEM22', 'FIELD_3']
	input  [1-1:0]    TEM22__FIELD_3__next_value        ;
	input              TEM22__FIELD_3__pulse             ;
	output [1-1:0]    TEM22__FIELD_3__curr_value        ;
	// ports of ['TEM22', 'FIELD_2']
	input  [3-1:0]    TEM22__FIELD_2__next_value        ;
	input              TEM22__FIELD_2__pulse             ;
	output [3-1:0]    TEM22__FIELD_2__curr_value        ;
	// ports of ['TEM22', 'FIELD_1']
	input  [1-1:0]    TEM22__FIELD_1__next_value        ;
	input              TEM22__FIELD_1__pulse             ;
	output [1-1:0]    TEM22__FIELD_1__curr_value        ;
	// ports of ['TEM23', 'FIELD_3']
	input  [1-1:0]    TEM23__FIELD_3__next_value        ;
	input              TEM23__FIELD_3__pulse             ;
	output [1-1:0]    TEM23__FIELD_3__curr_value        ;
	// ports of ['TEM23', 'FIELD_2']
	input  [3-1:0]    TEM23__FIELD_2__next_value        ;
	input              TEM23__FIELD_2__pulse             ;
	output [3-1:0]    TEM23__FIELD_2__curr_value        ;
	// ports of ['TEM23', 'FIELD_1']
	input  [1-1:0]    TEM23__FIELD_1__next_value        ;
	input              TEM23__FIELD_1__pulse             ;
	output [1-1:0]    TEM23__FIELD_1__curr_value        ;
	input 	sync_rst_local_1;
	input 	sync_rst_local_2;
//****************************************PORT DECLARATION END****************************************//


//***************************************WIRE DECLARATION START***************************************//
	// declare the handshake signal for fsm
	wire                   slv__fsm__ack_vld		;
	reg                    fsm__slv__req_vld     ;
	// signal for fsm
	wire 						fsm__slv__wr_en		;
	wire 						fsm__slv__rd_en		;
	wire [ADDR_WIDTH-1:0] 		fsm__slv__addr		;
	wire [DATA_WIDTH-1:0] 		fsm__slv__wr_data	;
	wire [DATA_WIDTH-1:0]  		slv__fsm__rd_data	;
	// fsm state indicator 
	wire                     ext_ack_is_back        ;
	assign ext_ack_is_back = 1'b0;

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
	wire                                   regfile_req_vld_fsm      ;
	wire                                   regfile_ack_vld_fsm      ;
	wire                                   regfile_wr_en_fsm        ;
	wire                                   regfile_rd_en_fsm        ;
	wire [ADDR_WIDTH-1:0]                  regfile_addr_fsm         ;
	wire [DATA_WIDTH-1:0]                  regfile_wr_data_fsm      ;
	wire [DATA_WIDTH-1:0]                  regfile_rd_data_fsm      ;

	// regfile signal in regfile domain
	wire [REG_NUM-1:0] wr_sel;
	wire [REG_NUM-1:0] rd_sel;
	wire                                   regfile_req_vld      ;
	wire                                   regfile_ack_vld      ;
	wire                                   regfile_rd_ack_vld   ;
	wire                                   regfile_wr_en        ;
	wire                                   regfile_rd_en        ;
	wire [ADDR_WIDTH-1:0]                  regfile_addr         ;
	wire [DATA_WIDTH-1:0]                  regfile_wr_data      ;
	wire [DATA_WIDTH-1:0]                  regfile_rd_data      ;
	logic [31:0] TEM21_wr_data;
	logic TEM21_wr_en;
	logic TEM21_rd_en;
	logic [31:0] TEM22_wr_data;
	logic TEM22_wr_en;
	logic TEM22_rd_en;
	logic [31:0] TEM23_wr_data;
	logic TEM23_wr_en;
	logic TEM23_rd_en;
	logic [31:0] TEM21_alias_wr_data;
	logic TEM21_alias_wr_en;
	logic TEM21_alias_rd_en;
	logic [31:0] TEM22_alias_wr_data;
	logic TEM22_alias_wr_en;
	logic TEM22_alias_rd_en;
	logic [31:0] TEM23_alias_wr_data;
	logic TEM23_alias_wr_en;
	logic TEM23_alias_rd_en;
//****************************************WIRE DECLARATION END****************************************//


//***************************************ADDRESS DECODER START****************************************//
	// global fsm_decoder @regslv domain
	assign global_address   = addr;
	assign ext_selected     = | ext_sel;
	always_comb begin
			int_selected = 1'b0;
			ext_sel = {EXT_NUM{1'b0}};
			none_selected = 1'b0;
		unique casez (global_address)
			64'hc,64'h10,64'h14,64'h10c,64'h110,64'h114:int_selected = 1'b1;//
			default: none_selected = 1'b1;
		endcase
	end
	// internal regfile decoder @regfile domain
	always_comb begin
			reg_sel = {REG_NUM{1'b0}};
			dummy_reg = 1'b0;
		unique casez (regfile_addr)
			64'hc:reg_sel[0] = 1'b1;//['TEM21']
			64'h10:reg_sel[1] = 1'b1;//['TEM22']
			64'h14:reg_sel[2] = 1'b1;//['TEM23']
			64'h10c:reg_sel[3] = 1'b1;//['TEM21_alias']
			64'h110:reg_sel[4] = 1'b1;//['TEM22_alias']
			64'h114:reg_sel[5] = 1'b1;//['TEM23_alias']
			default: dummy_reg = 1'b1;
		endcase
	end
//****************************************ADDRESS DECODER END*****************************************//


//************************************STATE MACHINE INSTANCE START************************************//
	slv_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
		slv_fsm_root_map__test_map_1_inst (
		.clk(fsm_clk),
		.rstn(fsm_rstn),
		.mst__fsm__req_vld(req_vld),
		.fsm__mst__ack_vld(ack_vld),
		.mst__fsm__addr(addr),
		.mst__fsm__wr_en(wr_en),
		.mst__fsm__rd_en(rd_en),
		.mst__fsm__wr_data(wr_data),
		.fsm__mst__rd_data(rd_data),
		.fsm__slv__req_vld(fsm__slv__req_vld),
		.slv__fsm__ack_vld(slv__fsm__ack_vld),
		.fsm__slv__addr(fsm__slv__addr),
		.fsm__slv__wr_en(fsm__slv__wr_en),
		.fsm__slv__rd_en(fsm__slv__rd_en),
		.fsm__slv__wr_data(fsm__slv__wr_data),
		.slv__fsm__rd_data(slv__fsm__rd_data),
		.external_reg_selected(ext_selected),
		.ext_ack_is_back(ext_ack_is_back),
		.mst__fsm__sync_reset(global_sync_reset_in),
		.fsm__slv__sync_reset(global_sync_reset_out)
	);
//*************************************STATE MACHINE INSTANCE END*************************************//


//**************************************SPLIT MUX INSTANCE START**************************************//
	// regfile mux @regfile domain
	split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(N+1), .GROUP_SIZE(128), .SKIP_DFF_0(1), .SKIP_DFF_1(1)) rd_split_mux
	(.clk(regfile_clk), .rst_n(regfile_rstn),
	.din({regfile_reg_rd_data_in,{DATA_WIDTH{1'b0}}}), .sel({rd_sel, dummy_reg & regfile_req_vld}),
	.dout(regfile_rd_data), .dout_vld(regfile_rd_ack_vld)
	);
//***************************************SPLIT MUX INSTANCE END***************************************//


//*****************************************ULTIMATE MUX START*****************************************//
	// select which to read out and transfer the corresponding vld signal @regslv domain
	assign slv__fsm__rd_data = none_selected & fsm__slv__req_vld ? {DATA_WIDTH{1'b0}} : regfile_ack_vld_fsm ? regfile_rd_data_fsm : 0;
	assign slv__fsm__ack_vld = none_selected & fsm__slv__req_vld | regfile_ack_vld_fsm;
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
	//REG NAME: TEM21//
	//REG HIERARCHY: ['TEM21']//
	//REG ABSOLUTE_ADDR:64'hc//
	//REG OFFSET_ADDR:64'h64'hc//
	logic [31:0] TEM21_o;
	assign TEM21_wr_data = wr_sel[0] ? regfile_wr_data : 0;
	assign TEM21_wr_en = wr_sel[0];
	assign TEM21_rd_en = rd_sel[0];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`RCLR,`RCLR}),
		.SW_ONWRITE_TYPE       ({`WOT,`WOT}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__TEM21__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst                (1'b0),
		.sw_wr_data            ({TEM21_wr_data[13:13],TEM21_alias_wr_data[13:13]}),
		.sw_rd                 ({TEM21_rd_en,TEM21_alias_rd_en}),
		.sw_wr                 ({TEM21_wr_en,TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (TEM21__FIELD_3__next_value),
		.hw_pulse              (TEM21__FIELD_3__pulse),
		.field_value           (TEM21__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.SRST_CNT              (4),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`RSET,`RSET}),
		.SW_ONWRITE_TYPE       ({`WOSET,`WZC}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__TEM21__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              ({sync_rst_local_1,sync_rst_local_2,sync_rst_local_1,sync_rst_local_2}),
		.sw_wr_data            ({TEM21_wr_data[16:14],TEM21_alias_wr_data[16:14]}),
		.sw_rd                 ({TEM21_rd_en,TEM21_alias_rd_en}),
		.sw_wr                 ({TEM21_wr_en,TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (TEM21__FIELD_2__next_value),
		.hw_pulse              (TEM21__FIELD_2__pulse),
		.field_value           (TEM21__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.SRST_CNT              (2),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RO,`SW_RO}),
		.SW_ONREAD_TYPE        ({`RCLR,`RCLR}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__TEM21__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              ({sync_rst_local_1,sync_rst_local_1}),
		.sw_wr_data            ({TEM21_wr_data[17:17],TEM21_alias_wr_data[17:17]}),
		.sw_rd                 ({TEM21_rd_en,TEM21_alias_rd_en}),
		.sw_wr                 ({TEM21_wr_en,TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (TEM21__FIELD_1__next_value),
		.hw_pulse              (TEM21__FIELD_1__pulse),
		.field_value           (TEM21__FIELD_1__curr_value)
		);
	always_comb begin
	TEM21_o[31:0] = 32'h0;
		TEM21_o[13:13] = TEM21__FIELD_3__curr_value;
		TEM21_o[16:14] = TEM21__FIELD_2__curr_value;
		TEM21_o[17:17] = TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[0] = TEM21_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: TEM22//
	//REG HIERARCHY: ['TEM22']//
	//REG ABSOLUTE_ADDR:64'h10//
	//REG OFFSET_ADDR:64'h64'h10//
	logic [31:0] TEM22_o;
	assign TEM22_wr_data = wr_sel[1] ? regfile_wr_data : 0;
	assign TEM22_wr_en = wr_sel[1];
	assign TEM22_rd_en = rd_sel[1];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`RCLR,`RCLR}),
		.SW_ONWRITE_TYPE       ({`WOT,`WOT}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__TEM22__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst                (1'b0),
		.sw_wr_data            ({TEM22_wr_data[13:13],TEM22_alias_wr_data[13:13]}),
		.sw_rd                 ({TEM22_rd_en,TEM22_alias_rd_en}),
		.sw_wr                 ({TEM22_wr_en,TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (TEM22__FIELD_3__next_value),
		.hw_pulse              (TEM22__FIELD_3__pulse),
		.field_value           (TEM22__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`RSET,`RSET}),
		.SW_ONWRITE_TYPE       ({`WOSET,`WOSET}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__TEM22__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst                (1'b0),
		.sw_wr_data            ({TEM22_wr_data[16:14],TEM22_alias_wr_data[16:14]}),
		.sw_rd                 ({TEM22_rd_en,TEM22_alias_rd_en}),
		.sw_wr                 ({TEM22_wr_en,TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (TEM22__FIELD_2__next_value),
		.hw_pulse              (TEM22__FIELD_2__pulse),
		.field_value           (TEM22__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RO,`SW_RO}),
		.SW_ONREAD_TYPE        ({`RCLR,`RCLR}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__TEM22__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst                (1'b0),
		.sw_wr_data            ({TEM22_wr_data[17:17],TEM22_alias_wr_data[17:17]}),
		.sw_rd                 ({TEM22_rd_en,TEM22_alias_rd_en}),
		.sw_wr                 ({TEM22_wr_en,TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (TEM22__FIELD_1__next_value),
		.hw_pulse              (TEM22__FIELD_1__pulse),
		.field_value           (TEM22__FIELD_1__curr_value)
		);
	always_comb begin
	TEM22_o[31:0] = 32'h0;
		TEM22_o[13:13] = TEM22__FIELD_3__curr_value;
		TEM22_o[16:14] = TEM22__FIELD_2__curr_value;
		TEM22_o[17:17] = TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[1] = TEM22_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: TEM23//
	//REG HIERARCHY: ['TEM23']//
	//REG ABSOLUTE_ADDR:64'h14//
	//REG OFFSET_ADDR:64'h64'h14//
	logic [31:0] TEM23_o;
	assign TEM23_wr_data = wr_sel[2] ? regfile_wr_data : 0;
	assign TEM23_wr_en = wr_sel[2];
	assign TEM23_rd_en = rd_sel[2];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`RCLR,`RCLR}),
		.SW_ONWRITE_TYPE       ({`WOT,`WOT}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__TEM23__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst                (1'b0),
		.sw_wr_data            ({TEM23_wr_data[13:13],TEM23_alias_wr_data[13:13]}),
		.sw_rd                 ({TEM23_rd_en,TEM23_alias_rd_en}),
		.sw_wr                 ({TEM23_wr_en,TEM23_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (TEM23__FIELD_3__next_value),
		.hw_pulse              (TEM23__FIELD_3__pulse),
		.field_value           (TEM23__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`RSET,`RCLR}),
		.SW_ONWRITE_TYPE       ({`WOSET,`WOSET}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__TEM23__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst                (1'b0),
		.sw_wr_data            ({TEM23_wr_data[16:14],TEM23_alias_wr_data[16:14]}),
		.sw_rd                 ({TEM23_rd_en,TEM23_alias_rd_en}),
		.sw_wr                 ({TEM23_wr_en,TEM23_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (TEM23__FIELD_2__next_value),
		.hw_pulse              (TEM23__FIELD_2__pulse),
		.field_value           (TEM23__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RO,`SW_RO}),
		.SW_ONREAD_TYPE        ({`RCLR,`RCLR}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__TEM23__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst                (1'b0),
		.sw_wr_data            ({TEM23_wr_data[17:17],TEM23_alias_wr_data[17:17]}),
		.sw_rd                 ({TEM23_rd_en,TEM23_alias_rd_en}),
		.sw_wr                 ({TEM23_wr_en,TEM23_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (TEM23__FIELD_1__next_value),
		.hw_pulse              (TEM23__FIELD_1__pulse),
		.field_value           (TEM23__FIELD_1__curr_value)
		);
	always_comb begin
	TEM23_o[31:0] = 32'h0;
		TEM23_o[13:13] = TEM23__FIELD_3__curr_value;
		TEM23_o[16:14] = TEM23__FIELD_2__curr_value;
		TEM23_o[17:17] = TEM23__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[2] = TEM23_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: TEM21_alias//
	//REG HIERARCHY: ['TEM21_alias']//
	//REG ABSOLUTE_ADDR:64'h10c//
	//REG OFFSET_ADDR:64'h64'h10c//
	logic [31:0] TEM21_alias_o;
	assign TEM21_alias_wr_data = wr_sel[3] ? regfile_wr_data : 0;
	assign TEM21_alias_wr_en = wr_sel[3];
	assign TEM21_alias_rd_en = rd_sel[3];
	always_comb begin
	TEM21_alias_o[31:0] = 32'h0;
		TEM21_alias_o[13:13] = TEM21__FIELD_3__curr_value;
		TEM21_alias_o[16:14] = TEM21__FIELD_2__curr_value;
		TEM21_alias_o[17:17] = TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[3] = TEM21_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: TEM22_alias//
	//REG HIERARCHY: ['TEM22_alias']//
	//REG ABSOLUTE_ADDR:64'h110//
	//REG OFFSET_ADDR:64'h64'h110//
	logic [31:0] TEM22_alias_o;
	assign TEM22_alias_wr_data = wr_sel[4] ? regfile_wr_data : 0;
	assign TEM22_alias_wr_en = wr_sel[4];
	assign TEM22_alias_rd_en = rd_sel[4];
	always_comb begin
	TEM22_alias_o[31:0] = 32'h0;
		TEM22_alias_o[13:13] = TEM22__FIELD_3__curr_value;
		TEM22_alias_o[16:14] = TEM22__FIELD_2__curr_value;
		TEM22_alias_o[17:17] = TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[4] = TEM22_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: TEM23_alias//
	//REG HIERARCHY: ['TEM23_alias']//
	//REG ABSOLUTE_ADDR:64'h114//
	//REG OFFSET_ADDR:64'h64'h114//
	logic [31:0] TEM23_alias_o;
	assign TEM23_alias_wr_data = wr_sel[5] ? regfile_wr_data : 0;
	assign TEM23_alias_wr_en = wr_sel[5];
	assign TEM23_alias_rd_en = rd_sel[5];
	always_comb begin
	TEM23_alias_o[31:0] = 32'h0;
		TEM23_alias_o[13:13] = TEM23__FIELD_3__curr_value;
		TEM23_alias_o[16:14] = TEM23__FIELD_2__curr_value;
		TEM23_alias_o[17:17] = TEM23__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[5] = TEM23_alias_o;
//***************************************REG/FIELD INSTANCE END***************************************//


//**************************************REG/FIELD INSTANCE START**************************************//
//***************************************REG/FIELD INSTANCE END***************************************//


endmodule
`default_nettype wire