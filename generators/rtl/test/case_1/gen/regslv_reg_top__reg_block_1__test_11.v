`include "xregister.vh"
`default_nettype none
module regslv_reg_top__reg_block_1__test_11(
//*************************************EXTERNAL MODULE PORT START*************************************//
//**************************************EXTERNAL MODULE PORT END**************************************//


//*************************************INTERNAL FIELD PORT START**************************************//
	// ports of internal regfile
	regfile_clk          ,
	regfile_rstn         ,
	// ports of ['REG1', 'FIELD_0']
	REG1__FIELD_0__next_value        ,
	REG1__FIELD_0__pulse             ,
	REG1__FIELD_0__curr_value        ,
	// ports of ['REG2', 'FIELD_0']
	REG2__FIELD_0__next_value        ,
	REG2__FIELD_0__pulse             ,
	REG2__FIELD_0__curr_value        ,
	// ports of ['REG3', 'FIELD_0']
	REG3__FIELD_0__next_value        ,
	REG3__FIELD_0__pulse             ,
	REG3__FIELD_0__curr_value        ,
	// ports of ['REG4', 'FIELD_0']
	REG4__FIELD_0__next_value        ,
	REG4__FIELD_0__pulse             ,
	REG4__FIELD_0__curr_value        ,
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
	localparam                 N = 4                    ;
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
	input regfile_clk          ;
	input regfile_rstn         ;
	// ports of ['REG1', 'FIELD_0']
	input  [32-1:0]    REG1__FIELD_0__next_value        ;
	input              REG1__FIELD_0__pulse             ;
	output [32-1:0]    REG1__FIELD_0__curr_value        ;
	// ports of ['REG2', 'FIELD_0']
	input  [32-1:0]    REG2__FIELD_0__next_value        ;
	input              REG2__FIELD_0__pulse             ;
	output [32-1:0]    REG2__FIELD_0__curr_value        ;
	// ports of ['REG3', 'FIELD_0']
	input  [32-1:0]    REG3__FIELD_0__next_value        ;
	input              REG3__FIELD_0__pulse             ;
	output [32-1:0]    REG3__FIELD_0__curr_value        ;
	// ports of ['REG4', 'FIELD_0']
	input  [32-1:0]    REG4__FIELD_0__next_value        ;
	input              REG4__FIELD_0__pulse             ;
	output [32-1:0]    REG4__FIELD_0__curr_value        ;
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

	// regfile signal to handle cdc
	logic [99-1:0] regfile_value_out_fsm;
	logic [99-1:0] regfile_value_out;
	logic [33-1:0] regfile_value_in_fsm;
	logic [33-1:0] regfile_value_in;
	// the pulse to deliver the value
	logic regfile_req_vld_fsm_ff;
	logic regfile_sel_pulse;
	logic regfile_ack_vld_ff;
	logic regfile_ack_pulse;
	logic [31:0] REG1_wr_data;
	logic REG1_wr_en;
	logic REG1_rd_en;
	logic [31:0] REG2_wr_data;
	logic REG2_wr_en;
	logic REG2_rd_en;
	logic [31:0] REG3_wr_data;
	logic REG3_wr_en;
	logic REG3_rd_en;
	logic [31:0] REG4_wr_data;
	logic REG4_wr_en;
	logic REG4_rd_en;
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
			64'h0,64'h4,64'h8,64'hc:int_selected = 1'b1;//
			default: none_selected = 1'b1;
		endcase
	end
	// internal regfile decoder @regfile domain
	always_comb begin
			reg_sel = {REG_NUM{1'b0}};
			dummy_reg = 1'b0;
		unique casez (regfile_addr)
			64'h0:reg_sel[0] = 1'b1;//['REG1']
			64'h4:reg_sel[1] = 1'b1;//['REG2']
			64'h8:reg_sel[2] = 1'b1;//['REG3']
			64'hc:reg_sel[3] = 1'b1;//['REG4']
			default: dummy_reg = 1'b1;
		endcase
	end
//****************************************ADDRESS DECODER END*****************************************//


//************************************STATE MACHINE INSTANCE START************************************//
	slv_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
		slv_fsm_reg_top__reg_block_1__test_11 (
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

	assign regfile_value_out_fsm = {regfile_req_vld_fsm, regfile_wr_en_fsm, regfile_rd_en_fsm, regfile_wr_data_fsm, regfile_addr_fsm};
	assign {regfile_req_vld, regfile_wr_en, regfile_rd_en, regfile_wr_data, regfile_addr} =  regfile_value_out;

	assign {regfile_ack_vld_fsm, regfile_rd_data_fsm} =  regfile_value_in_fsm;
	assign regfile_value_in = {regfile_ack_vld, regfile_rd_data};

	// create the pulse to deliver the value
	always_ff@(posedge fsm_clk or negedge fsm_rstn)begin
		if(~fsm_rstn)
			regfile_req_vld_fsm_ff <= 1'b0;
		else
			regfile_req_vld_fsm_ff <= regfile_req_vld_fsm;
	end

	assign regfile_sel_pulse = ~regfile_req_vld_fsm_ff & regfile_req_vld_fsm;

	always_ff@(posedge regfile_clk or negedge regfile_rstn)begin
		if(~regfile_rstn)
			regfile_ack_vld_ff <= 1'b0;
		else
			regfile_ack_vld_ff <= regfile_ack_vld;
	end

	assign regfile_ack_pulse = ~regfile_ack_vld_ff & regfile_ack_vld;

	// fsm to regfile
	value_transmitter
		#(.WIDTH(99))
		regfile_value_transmitter
		(
		.clk_a                                  (fsm_clk)                   ,
		.rst_a_n                                (fsm_rstn)                  ,
		.pulse_in                               (regfile_sel_pulse)             ,
		.value_in                               (regfile_value_out_fsm)   ,
		.clk_b                                  (regfile_clk)             ,
		.rst_b_n                                (regfile_rstn)            ,
		.value_out_ack                          (regfile_ack_vld)         ,
		.pulse_out                              ()                          ,
		.value_out                              (regfile_value_out)
	);

	value_transmitter
		#(.WIDTH(33))
		regfile_value_receiver
		(
		.clk_a                                  (regfile_clk)                         ,
		.rst_a_n                                (regfile_rstn)                        ,
		.pulse_in                               (regfile_ack_pulse)                         ,
		.value_in                               (regfile_value_in)                    ,
		.clk_b                                  (fsm_clk)                               ,
		.rst_b_n                                (fsm_rstn)                              ,
		.value_out_ack                          (regfile_ack_vld_fsm)                 ,
		.pulse_out                              ()                                      ,
		.value_out                              (regfile_value_in_fsm)
	);
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
		.ARST_VALUE            (32'h0),
		.SW_TYPE               ({`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA}),
		.SW_ONWRITE_TYPE       ({`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__REG1__FIELD_0
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (REG1_wr_data[31:0]),
		.sw_rd                 (REG1_rd_en),
		.sw_wr                 (REG1_wr_en),
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
	//REG NAME: REG2//
	//REG HIERARCHY: ['REG2']//
	//REG ABSOLUTE_ADDR:64'h4//
	//REG OFFSET_ADDR:64'h64'h4//
	logic [31:0] REG2_o;
	assign REG2_wr_data = wr_sel[1] ? regfile_wr_data : 0;
	assign REG2_wr_en = wr_sel[1];
	assign REG2_rd_en = rd_sel[1];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (32),
		.ARST_VALUE            (32'h0),
		.SW_TYPE               ({`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA}),
		.SW_ONWRITE_TYPE       ({`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__REG2__FIELD_0
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (REG2_wr_data[31:0]),
		.sw_rd                 (REG2_rd_en),
		.sw_wr                 (REG2_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (REG2__FIELD_0__next_value),
		.hw_pulse              (REG2__FIELD_0__pulse),
		.field_value           (REG2__FIELD_0__curr_value)
		);
	always_comb begin
	REG2_o[31:0] = 32'h0;
		REG2_o[31:0] = REG2__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[1] = REG2_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: REG3//
	//REG HIERARCHY: ['REG3']//
	//REG ABSOLUTE_ADDR:64'h8//
	//REG OFFSET_ADDR:64'h64'h8//
	logic [31:0] REG3_o;
	assign REG3_wr_data = wr_sel[2] ? regfile_wr_data : 0;
	assign REG3_wr_en = wr_sel[2];
	assign REG3_rd_en = rd_sel[2];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (32),
		.ARST_VALUE            (32'h0),
		.SW_TYPE               ({`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA}),
		.SW_ONWRITE_TYPE       ({`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__REG3__FIELD_0
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (REG3_wr_data[31:0]),
		.sw_rd                 (REG3_rd_en),
		.sw_wr                 (REG3_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (REG3__FIELD_0__next_value),
		.hw_pulse              (REG3__FIELD_0__pulse),
		.field_value           (REG3__FIELD_0__curr_value)
		);
	always_comb begin
	REG3_o[31:0] = 32'h0;
		REG3_o[31:0] = REG3__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[2] = REG3_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: REG4//
	//REG HIERARCHY: ['REG4']//
	//REG ABSOLUTE_ADDR:64'hc//
	//REG OFFSET_ADDR:64'h64'hc//
	logic [31:0] REG4_o;
	assign REG4_wr_data = wr_sel[3] ? regfile_wr_data : 0;
	assign REG4_wr_en = wr_sel[3];
	assign REG4_rd_en = rd_sel[3];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (32),
		.ARST_VALUE            (32'h0),
		.SW_TYPE               ({`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA}),
		.SW_ONWRITE_TYPE       ({`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__REG4__FIELD_0
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (REG4_wr_data[31:0]),
		.sw_rd                 (REG4_rd_en),
		.sw_wr                 (REG4_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (REG4__FIELD_0__next_value),
		.hw_pulse              (REG4__FIELD_0__pulse),
		.field_value           (REG4__FIELD_0__curr_value)
		);
	always_comb begin
	REG4_o[31:0] = 32'h0;
		REG4_o[31:0] = REG4__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[3] = REG4_o;
//***************************************REG/FIELD INSTANCE END***************************************//


//**************************************REG/FIELD INSTANCE START**************************************//
//***************************************REG/FIELD INSTANCE END***************************************//


endmodule
`default_nettype wire