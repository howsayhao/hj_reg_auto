`include "xregister.vh"
`default_nettype none
module regslv_root_map__root_map__shared_map6(
//*************************************INTERNAL FIELD PORT START**************************************//
	// ports of internal regfile
	// ports of ['map_2', 'regfile_test', 'shared_reg_1', 'FIELD_2']
	map_2_regfile_test_shared_reg_1__FIELD_2__next_value        ,
	map_2_regfile_test_shared_reg_1__FIELD_2__pulse             ,
	map_2_regfile_test_shared_reg_1__FIELD_2__curr_value        ,
	// ports of ['map_2', 'regfile_test', 'shared_reg_1', 'FIELD_1']
	map_2_regfile_test_shared_reg_1__FIELD_1__next_value        ,
	map_2_regfile_test_shared_reg_1__FIELD_1__pulse             ,
	map_2_regfile_test_shared_reg_1__FIELD_1__curr_value        ,
	// ports of ['map_2', 'regfile_test', 'shared_reg_2', 'FIELD_2']
	map_2_regfile_test_shared_reg_2__FIELD_2__next_value        ,
	map_2_regfile_test_shared_reg_2__FIELD_2__pulse             ,
	map_2_regfile_test_shared_reg_2__FIELD_2__curr_value        ,
	// ports of ['map_2', 'regfile_test', 'shared_reg_2', 'FIELD_1']
	map_2_regfile_test_shared_reg_2__FIELD_1__next_value        ,
	map_2_regfile_test_shared_reg_2__FIELD_1__pulse             ,
	map_2_regfile_test_shared_reg_2__FIELD_1__curr_value        ,
//**************************************INTERNAL FIELD PORT END***************************************//


//****************************************STANDARD PORT START*****************************************//
	regslv_clk                ,
	regslv_rstn               ,
	clk                     ,
	rst_n                   ,
	req_vld                 ,
	ack_vld                 ,
	err                     ,
	wr_en                   ,
	rd_en                   ,
	addr                    ,
	wr_data                 ,
	rd_data                 ,
	soft_rst_i               
//*****************************************STANDARD PORT END******************************************//
);


//*************************************PARAMETER DEFINITION START*************************************//
	parameter                  ADDR_WIDTH = 64          ;
	parameter                  DATA_WIDTH = 32          ;
	//N:number of internal registers, M:number of external modules
	localparam                 N = 4                    ;
	localparam                 REG_NUM = N ? N : 1      ;
//**************************************PARAMETER DEFINITION END**************************************//


//***************************************PORT DECLARATION START***************************************//
	// dispatch domain @clk
	input                         clk                     ;
	input                         rst_n                   ;
	input                         req_vld                 ;
	output                        ack_vld                 ;
	output                        err                     ;
	input                         wr_en                   ;
	input                         rd_en                   ;
	input     [ADDR_WIDTH-1:0]    addr                    ;
	input     [DATA_WIDTH-1:0]    wr_data                 ;
	output    [DATA_WIDTH-1:0]    rd_data                 ;
	input                         soft_rst_i              ;
	// regslv domain @regslv_clk
	input                         regslv_clk          ;
	input                         regslv_rstn         ;
	//ports define of internal regfile
	// ports of ['map_2', 'regfile_test', 'shared_reg_1', 'FIELD_2']
	input  [2-1:0]    map_2_regfile_test_shared_reg_1__FIELD_2__next_value        ;
	input              map_2_regfile_test_shared_reg_1__FIELD_2__pulse             ;
	output [2-1:0]    map_2_regfile_test_shared_reg_1__FIELD_2__curr_value        ;
	// ports of ['map_2', 'regfile_test', 'shared_reg_1', 'FIELD_1']
	input  [3-1:0]    map_2_regfile_test_shared_reg_1__FIELD_1__next_value        ;
	input              map_2_regfile_test_shared_reg_1__FIELD_1__pulse             ;
	output [3-1:0]    map_2_regfile_test_shared_reg_1__FIELD_1__curr_value        ;
	// ports of ['map_2', 'regfile_test', 'shared_reg_2', 'FIELD_2']
	input  [2-1:0]    map_2_regfile_test_shared_reg_2__FIELD_2__next_value        ;
	input              map_2_regfile_test_shared_reg_2__FIELD_2__pulse             ;
	output [2-1:0]    map_2_regfile_test_shared_reg_2__FIELD_2__curr_value        ;
	// ports of ['map_2', 'regfile_test', 'shared_reg_2', 'FIELD_1']
	input  [3-1:0]    map_2_regfile_test_shared_reg_2__FIELD_1__next_value        ;
	input              map_2_regfile_test_shared_reg_2__FIELD_1__pulse             ;
	output [3-1:0]    map_2_regfile_test_shared_reg_2__FIELD_1__curr_value        ;
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
	// signal for internal decoder @regfile domain
	logic [REG_NUM-1:0] 	reg_sel			;
	logic 					dummy_reg		;

	// signal for regfile split mux
	logic [REG_NUM-1:0] [DATA_WIDTH-1:0] regfile_reg_rd_data_in;
	// regslv domain @regslv_clk
	wire                                   req_vld_fsm      ;
	wire                                   ack_vld_fsm      ;
	wire                                   wr_en_fsm        ;
	wire                                   rd_en_fsm        ;
	wire [ADDR_WIDTH-1:0]                  addr_fsm         ;
	wire [DATA_WIDTH-1:0]                  wr_data_fsm      ;
	wire [DATA_WIDTH-1:0]                  rd_data_fsm      ;
	wire                                   soft_rst_i_fsm   ;

	// regslv interface signal to handle cdc
	logic [100-1:0] regslv_value_in_fsm;
	logic [100-1:0] regslv_value_in;
	logic [33-1:0] regslv_value_out_fsm;
	logic [33-1:0] regslv_value_out;
	// the pulse to deliver the value
	logic req_vld_ff;
	logic regslv_sel_pulse;
	logic soft_rst_i_ff;
	logic ack_vld_fsm_ff;
	logic regslv_ack_pulse;

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

	assign regfile_req_vld       = fsm__slv__req_vld     ;
	assign slv__fsm__ack_vld     = regfile_ack_vld       ;
	assign regfile_wr_en         = fsm__slv__wr_en       ;
	assign regfile_rd_en         = fsm__slv__rd_en       ;
	assign regfile_addr          = fsm__slv__addr        ;
	assign regfile_wr_data       = fsm__slv__wr_data     ;
	assign slv__fsm__rd_data     = regfile_rd_data       ;

	assign wr_sel = {REG_NUM{regfile_wr_en}} & reg_sel   ;
	assign rd_sel = {REG_NUM{regfile_rd_en}} & reg_sel   ;
	assign regfile_ack_vld = regfile_rd_ack_vld | regfile_wr_en;

	logic [31:0] map_2_regfile_test_shared_reg_1_wr_data;
	logic map_2_regfile_test_shared_reg_1_wr_en;
	logic map_2_regfile_test_shared_reg_1_rd_en;

	logic [31:0] map_2_regfile_test_shared_reg_2_wr_data;
	logic map_2_regfile_test_shared_reg_2_wr_en;
	logic map_2_regfile_test_shared_reg_2_rd_en;

	logic [31:0] map_3_regfile_test_shared_reg_1_wr_data;
	logic map_3_regfile_test_shared_reg_1_wr_en;
	logic map_3_regfile_test_shared_reg_1_rd_en;

	logic [31:0] map_3_regfile_test_shared_reg_2_wr_data;
	logic map_3_regfile_test_shared_reg_2_wr_en;
	logic map_3_regfile_test_shared_reg_2_rd_en;

//****************************************WIRE DECLARATION END****************************************//


//***************************************ADDRESS DECODER START****************************************//
	// internal regfile decoder @regfile domain
	always_comb begin
			reg_sel = {REG_NUM{1'b0}};
			dummy_reg = 1'b0;
		unique casez (regfile_addr)
			64'h0:reg_sel[0] = 1'b1;//['map_2', 'regfile_test', 'shared_reg_1']
			64'h4:reg_sel[1] = 1'b1;//['map_2', 'regfile_test', 'shared_reg_2']
			64'h8:reg_sel[2] = 1'b1;//['map_3', 'regfile_test', 'shared_reg_1']
			64'hc:reg_sel[3] = 1'b1;//['map_3', 'regfile_test', 'shared_reg_2']
			default: dummy_reg = 1'b1;
		endcase
	end
//****************************************ADDRESS DECODER END*****************************************//


//************************************STATE MACHINE INSTANCE START************************************//
	slv_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
		slv_fsm_root_map__root_map__shared_map6 (
		.clk(regslv_clk),
		.rst_n(regslv_rstn),
		.mst__fsm__req_vld(req_vld_fsm),
		.fsm__mst__ack_vld(ack_vld_fsm),
		.mst__fsm__addr(addr_fsm),
		.mst__fsm__wr_en(wr_en_fsm),
		.mst__fsm__rd_en(rd_en_fsm),
		.mst__fsm__wr_data(wr_data_fsm),
		.fsm__mst__rd_data(rd_data_fsm),
		.fsm__slv__req_vld(fsm__slv__req_vld),
		.slv__fsm__ack_vld(slv__fsm__ack_vld),
		.fsm__slv__addr(fsm__slv__addr),
		.fsm__slv__wr_en(fsm__slv__wr_en),
		.fsm__slv__rd_en(fsm__slv__rd_en),
		.fsm__slv__wr_data(fsm__slv__wr_data),
		.slv__fsm__rd_data(slv__fsm__rd_data),
		.soft_rst(soft_rst_i_fsm),
		.fsm__slv__sync_reset()
	);
//*************************************STATE MACHINE INSTANCE END*************************************//


//**************************************SPLIT MUX INSTANCE START**************************************//
	// regfile mux @regfile domain
	split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(N+1), .GROUP_SIZE(128), .SKIP_DFF_0(1), .SKIP_DFF_1(1)) rd_split_mux
	(.clk(regslv_clk), .rst_n(regslv_rstn),
	.din({regfile_reg_rd_data_in,{DATA_WIDTH{1'b0}}}), .sel({rd_sel, dummy_reg & regfile_req_vld}),
	.dout(regfile_rd_data), .dout_vld(regfile_rd_ack_vld)
	);
//***************************************SPLIT MUX INSTANCE END***************************************//


//*****************************************ULTIMATE MUX START*****************************************//
	// select which to read out and transfer the corresponding vld signal @regslv domain
	assign slv__fsm__rd_data = regfile_ack_vld ? regfile_rd_data : 0;
//******************************************ULTIMATE MUX END******************************************//


//**********************************REGSLV CDC DELIVER INSTANT START**********************************//

	assign regslv_value_out_fsm = {ack_vld_fsm, rd_data_fsm};
	assign {ack_vld, rd_data} =  regslv_value_out;

	assign {req_vld_fsm, soft_rst_i_fsm, wr_en_fsm, rd_en_fsm, wr_data_fsm, addr_fsm} =  regslv_value_in_fsm;
	assign regslv_value_in = {req_vld, soft_rst_i, wr_en, rd_en, wr_data, addr};

	// create the pulse to deliver the value
	always_ff@(posedge clk or negedge rst_n)begin
		if(~rst_n)
			req_vld_ff <= 1'b0;
		else
			req_vld_ff <= req_vld;
	end

	// create the pulse to deliver the value
	always_ff@(posedge clk or negedge rst_n)begin
		if(~rst_n)
			soft_rst_i_ff <= 1'b0;
		else
			soft_rst_i_ff <= soft_rst_i;
	end

	assign regslv_sel_pulse = (~req_vld_ff & req_vld) | (~soft_rst_i_ff & soft_rst_i);

	always_ff@(posedge regslv_clk or negedge regslv_rstn)begin
		if(~regslv_rstn)
			ack_vld_fsm_ff <= 1'b0;
		else
			ack_vld_fsm_ff <= ack_vld_fsm;
	end

	assign regslv_ack_pulse = ~ack_vld_fsm_ff & ack_vld_fsm;

	// dispatch to regslv
	value_transmitter
		#(.WIDTH(100))
		regslv_value_transmitter
		(
		.clk_a                                  (clk    )                   ,
		.rst_a_n                                (rst_n   )                  ,
		.pulse_in                               (regslv_sel_pulse)             ,
		.value_in                               (regslv_value_in)   ,
		.clk_b                                  (regslv_clk)             ,
		.rst_b_n                                (regslv_rstn)            ,
		.value_out_ack                          (ack_vld_fsm | soft_rst_i_fsm)         ,
		.pulse_out                              ()                          ,
		.value_out                              (regslv_value_in_fsm)
	);

	value_transmitter
		#(.WIDTH(33))
		regslv_value_receiver
		(
		.clk_a                                  (regslv_clk)                         ,
		.rst_a_n                                (regslv_rstn)                        ,
		.pulse_in                               (regslv_ack_pulse)                         ,
		.value_in                               (regslv_value_out_fsm)                    ,
		.clk_b                                  (clk    )                               ,
		.rst_b_n                                (rst_n   )                              ,
		.value_out_ack                          (ack_vld)                 ,
		.pulse_out                              ()                                      ,
		.value_out                              (regslv_value_out)
	);
//***********************************REGSLV CDC DELIVER INSTANT END***********************************//


//**************************************REG/FIELD INSTANCE START**************************************//
	//============================================REG INSTANT=============================================//
	//REG NAME: map_2_regfile_test_shared_reg_1//
	//REG HIERARCHY: ['map_2', 'regfile_test', 'shared_reg_1']//
	//REG ABSOLUTE_ADDR:64'h0//
	//REG OFFSET_ADDR:64'h0//
	logic [31:0] map_2_regfile_test_shared_reg_1_o;
	assign map_2_regfile_test_shared_reg_1_wr_data = wr_sel[0] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_2_regfile_test_shared_reg_1_wr_en = wr_sel[0];
	assign map_2_regfile_test_shared_reg_1_rd_en = rd_sel[0];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (2),
		.ARST_VALUE            (2'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_2_regfile_test_shared_reg_1__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rstn),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_2_regfile_test_shared_reg_1_wr_data[13:12],map_3_regfile_test_shared_reg_1_wr_data[13:12]}),
		.sw_rd                 ({map_2_regfile_test_shared_reg_1_rd_en,map_3_regfile_test_shared_reg_1_rd_en}),
		.sw_wr                 ({map_2_regfile_test_shared_reg_1_wr_en,map_3_regfile_test_shared_reg_1_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_2_regfile_test_shared_reg_1__FIELD_2__next_value),
		.hw_pulse              (map_2_regfile_test_shared_reg_1__FIELD_2__pulse),
		.field_value           (map_2_regfile_test_shared_reg_1__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_2_regfile_test_shared_reg_1__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rstn),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_2_regfile_test_shared_reg_1_wr_data[16:14],map_3_regfile_test_shared_reg_1_wr_data[16:14]}),
		.sw_rd                 ({map_2_regfile_test_shared_reg_1_rd_en,map_3_regfile_test_shared_reg_1_rd_en}),
		.sw_wr                 ({map_2_regfile_test_shared_reg_1_wr_en,map_3_regfile_test_shared_reg_1_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_2_regfile_test_shared_reg_1__FIELD_1__next_value),
		.hw_pulse              (map_2_regfile_test_shared_reg_1__FIELD_1__pulse),
		.field_value           (map_2_regfile_test_shared_reg_1__FIELD_1__curr_value)
		);
	always_comb begin
		map_2_regfile_test_shared_reg_1_o[31:0] = 32'h0;
		map_2_regfile_test_shared_reg_1_o[13:12] = map_2_regfile_test_shared_reg_1__FIELD_2__curr_value;
		map_2_regfile_test_shared_reg_1_o[16:14] = map_2_regfile_test_shared_reg_1__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[0] = map_2_regfile_test_shared_reg_1_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_2_regfile_test_shared_reg_2//
	//REG HIERARCHY: ['map_2', 'regfile_test', 'shared_reg_2']//
	//REG ABSOLUTE_ADDR:64'h4//
	//REG OFFSET_ADDR:64'h4//
	logic [31:0] map_2_regfile_test_shared_reg_2_o;
	assign map_2_regfile_test_shared_reg_2_wr_data = wr_sel[1] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_2_regfile_test_shared_reg_2_wr_en = wr_sel[1];
	assign map_2_regfile_test_shared_reg_2_rd_en = rd_sel[1];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (2),
		.ARST_VALUE            (2'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_2_regfile_test_shared_reg_2__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rstn),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_2_regfile_test_shared_reg_2_wr_data[13:12],map_3_regfile_test_shared_reg_2_wr_data[13:12]}),
		.sw_rd                 ({map_2_regfile_test_shared_reg_2_rd_en,map_3_regfile_test_shared_reg_2_rd_en}),
		.sw_wr                 ({map_2_regfile_test_shared_reg_2_wr_en,map_3_regfile_test_shared_reg_2_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_2_regfile_test_shared_reg_2__FIELD_2__next_value),
		.hw_pulse              (map_2_regfile_test_shared_reg_2__FIELD_2__pulse),
		.field_value           (map_2_regfile_test_shared_reg_2__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_2_regfile_test_shared_reg_2__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rstn),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_2_regfile_test_shared_reg_2_wr_data[16:14],map_3_regfile_test_shared_reg_2_wr_data[16:14]}),
		.sw_rd                 ({map_2_regfile_test_shared_reg_2_rd_en,map_3_regfile_test_shared_reg_2_rd_en}),
		.sw_wr                 ({map_2_regfile_test_shared_reg_2_wr_en,map_3_regfile_test_shared_reg_2_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_2_regfile_test_shared_reg_2__FIELD_1__next_value),
		.hw_pulse              (map_2_regfile_test_shared_reg_2__FIELD_1__pulse),
		.field_value           (map_2_regfile_test_shared_reg_2__FIELD_1__curr_value)
		);
	always_comb begin
		map_2_regfile_test_shared_reg_2_o[31:0] = 32'h0;
		map_2_regfile_test_shared_reg_2_o[13:12] = map_2_regfile_test_shared_reg_2__FIELD_2__curr_value;
		map_2_regfile_test_shared_reg_2_o[16:14] = map_2_regfile_test_shared_reg_2__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[1] = map_2_regfile_test_shared_reg_2_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_3_regfile_test_shared_reg_1//
	//REG HIERARCHY: ['map_3', 'regfile_test', 'shared_reg_1']//
	//REG ABSOLUTE_ADDR:64'h8//
	//REG OFFSET_ADDR:64'h0//
	logic [31:0] map_3_regfile_test_shared_reg_1_o;
	assign map_3_regfile_test_shared_reg_1_wr_data = wr_sel[2] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_3_regfile_test_shared_reg_1_wr_en = wr_sel[2];
	assign map_3_regfile_test_shared_reg_1_rd_en = rd_sel[2];
	always_comb begin
		map_3_regfile_test_shared_reg_1_o[31:0] = 32'h0;
		map_3_regfile_test_shared_reg_1_o[13:12] = map_2_regfile_test_shared_reg_1__FIELD_2__curr_value;
		map_3_regfile_test_shared_reg_1_o[16:14] = map_2_regfile_test_shared_reg_1__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[2] = map_3_regfile_test_shared_reg_1_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_3_regfile_test_shared_reg_2//
	//REG HIERARCHY: ['map_3', 'regfile_test', 'shared_reg_2']//
	//REG ABSOLUTE_ADDR:64'hc//
	//REG OFFSET_ADDR:64'h4//
	logic [31:0] map_3_regfile_test_shared_reg_2_o;
	assign map_3_regfile_test_shared_reg_2_wr_data = wr_sel[3] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_3_regfile_test_shared_reg_2_wr_en = wr_sel[3];
	assign map_3_regfile_test_shared_reg_2_rd_en = rd_sel[3];
	always_comb begin
		map_3_regfile_test_shared_reg_2_o[31:0] = 32'h0;
		map_3_regfile_test_shared_reg_2_o[13:12] = map_2_regfile_test_shared_reg_2__FIELD_2__curr_value;
		map_3_regfile_test_shared_reg_2_o[16:14] = map_2_regfile_test_shared_reg_2__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[3] = map_3_regfile_test_shared_reg_2_o;
//***************************************REG/FIELD INSTANCE END***************************************//


//**************************************REG/FIELD INSTANCE START**************************************//
//***************************************REG/FIELD INSTANCE END***************************************//


endmodule
`default_nettype wire