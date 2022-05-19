`include "xregister.vh"
`default_nettype none
module regmst_root_map(
//*************************************EXTERNAL MODULE PORT START*************************************//
	// ports of test_map_1_inst
	test_map_1_inst_req_vld           ,
	test_map_1_inst_ack_vld           ,
	test_map_1_inst_wr_en             ,
	test_map_1_inst_rd_en             ,
	test_map_1_inst_addr              ,
	test_map_1_inst_wr_data           ,
	test_map_1_inst_rd_data           ,
//**************************************EXTERNAL MODULE PORT END**************************************//


//*************************************INTERNAL FIELD PORT START**************************************//
	// ports of internal regfile
	// ports of ['test_map_2_inst', 'shared_2', 'FIELD_2']
	test_map_2_inst_shared_2__FIELD_2__next_value        ,
	test_map_2_inst_shared_2__FIELD_2__pulse             ,
	test_map_2_inst_shared_2__FIELD_2__curr_value        ,
	// ports of ['test_map_2_inst', 'shared_2', 'FIELD_1']
	test_map_2_inst_shared_2__FIELD_1__next_value        ,
	test_map_2_inst_shared_2__FIELD_1__pulse             ,
	test_map_2_inst_shared_2__FIELD_1__curr_value        ,
	// ports of ['ipxact_block_example_inst', 'reg1', 'f1']
	ipxact_block_example_inst_reg1__f1__next_value        ,
	ipxact_block_example_inst_reg1__f1__pulse             ,
	ipxact_block_example_inst_reg1__f1__curr_value        ,
	// ports of ['ipxact_block_example_inst', 'reg1', 'f2']
	ipxact_block_example_inst_reg1__f2__next_value        ,
	ipxact_block_example_inst_reg1__f2__pulse             ,
	ipxact_block_example_inst_reg1__f2__curr_value        ,
	// ports of ['ipxact_block_example_inst', 'reg_array[0]', 'x']
	ipxact_block_example_inst_reg_array0__x__next_value        ,
	ipxact_block_example_inst_reg_array0__x__pulse             ,
	ipxact_block_example_inst_reg_array0__x__curr_value        ,
	// ports of ['ipxact_block_example_inst', 'reg_array[1]', 'x']
	ipxact_block_example_inst_reg_array1__x__next_value        ,
	ipxact_block_example_inst_reg_array1__x__pulse             ,
	ipxact_block_example_inst_reg_array1__x__curr_value        ,
	// ports of ['ipxact_block_example_inst', 'reg_array[2]', 'x']
	ipxact_block_example_inst_reg_array2__x__next_value        ,
	ipxact_block_example_inst_reg_array2__x__pulse             ,
	ipxact_block_example_inst_reg_array2__x__curr_value        ,
	// ports of ['ipxact_block_example_inst', 'reg_array[3]', 'x']
	ipxact_block_example_inst_reg_array3__x__next_value        ,
	ipxact_block_example_inst_reg_array3__x__pulse             ,
	ipxact_block_example_inst_reg_array3__x__curr_value        ,
//**************************************INTERNAL FIELD PORT END***************************************//


//****************************************STANDARD PORT START*****************************************//
	PCLK                    ,
	PRESETn                 ,
	PSEL                    ,
	PENABLE                 ,
	PREADY                  ,
	PSLVERR                 ,
	PWRITE                  ,
	PADDR                   ,
	PWDATA                  ,
	PRDATA                  ,
	clear                   ,
	interrupt               ,
	global_sync_reset_out    
//*****************************************STANDARD PORT END******************************************//
);


//*************************************PARAMETER DEFINITION START*************************************//
	parameter                  ADDR_WIDTH = 64          ;
	parameter                  DATA_WIDTH = 32          ;
	//N:number of internal registers, M:number of external modules
	localparam                 N = 7                    ;
	localparam                 M = 1                    ;
	localparam                 REG_NUM = N ? N : 1      ;
	localparam                 EXT_NUM = M ? M : 1      ;
//**************************************PARAMETER DEFINITION END**************************************//


//***************************************PORT DECLARATION START***************************************//
	// regslv domain fsm_clk
	input                         PCLK                    ;
	input                         PRESETn                 ;
	input                         PSEL                    ;
	input                         PENABLE                 ;
	output                        PREADY                  ;
	output                        PSLVERR                 ;
	input                         PWRITE                  ;
	input     [ADDR_WIDTH-1:0]    PADDR                   ;
	input     [DATA_WIDTH-1:0]    PWDATA                  ;
	output    [DATA_WIDTH-1:0]    PRDATA                  ;
	input                         clear                   ;
	output                        interrupt               ;
	output                        global_sync_reset_out   ;
	wire                          fsm_clk = PCLK          ;
	wire                          fsm_rstn = PRESETn      ;
	// ports define of test_map_1_inst
	output             test_map_1_inst_req_vld           ;
	input              test_map_1_inst_ack_vld           ;
	output             test_map_1_inst_wr_en             ;
	output             test_map_1_inst_rd_en             ;
	output [64-1:0]    test_map_1_inst_addr              ;
	output [32-1:0]    test_map_1_inst_wr_data           ;
	input  [32-1:0]    test_map_1_inst_rd_data           ;
	//ports define of internal regfile
	wire regfile_clk   = fsm_clk   ;
	wire regfile_rstn  = fsm_rstn  ;
	// ports of ['test_map_2_inst', 'shared_2', 'FIELD_2']
	input  [2-1:0]    test_map_2_inst_shared_2__FIELD_2__next_value        ;
	input              test_map_2_inst_shared_2__FIELD_2__pulse             ;
	output [2-1:0]    test_map_2_inst_shared_2__FIELD_2__curr_value        ;
	// ports of ['test_map_2_inst', 'shared_2', 'FIELD_1']
	input  [3-1:0]    test_map_2_inst_shared_2__FIELD_1__next_value        ;
	input              test_map_2_inst_shared_2__FIELD_1__pulse             ;
	output [3-1:0]    test_map_2_inst_shared_2__FIELD_1__curr_value        ;
	// ports of ['ipxact_block_example_inst', 'reg1', 'f1']
	input  [1-1:0]    ipxact_block_example_inst_reg1__f1__next_value        ;
	input              ipxact_block_example_inst_reg1__f1__pulse             ;
	output [1-1:0]    ipxact_block_example_inst_reg1__f1__curr_value        ;
	// ports of ['ipxact_block_example_inst', 'reg1', 'f2']
	input  [8-1:0]    ipxact_block_example_inst_reg1__f2__next_value        ;
	input              ipxact_block_example_inst_reg1__f2__pulse             ;
	output [8-1:0]    ipxact_block_example_inst_reg1__f2__curr_value        ;
	// ports of ['ipxact_block_example_inst', 'reg_array[0]', 'x']
	input  [1-1:0]    ipxact_block_example_inst_reg_array0__x__next_value        ;
	input              ipxact_block_example_inst_reg_array0__x__pulse             ;
	output [1-1:0]    ipxact_block_example_inst_reg_array0__x__curr_value        ;
	// ports of ['ipxact_block_example_inst', 'reg_array[1]', 'x']
	input  [1-1:0]    ipxact_block_example_inst_reg_array1__x__next_value        ;
	input              ipxact_block_example_inst_reg_array1__x__pulse             ;
	output [1-1:0]    ipxact_block_example_inst_reg_array1__x__curr_value        ;
	// ports of ['ipxact_block_example_inst', 'reg_array[2]', 'x']
	input  [1-1:0]    ipxact_block_example_inst_reg_array2__x__next_value        ;
	input              ipxact_block_example_inst_reg_array2__x__pulse             ;
	output [1-1:0]    ipxact_block_example_inst_reg_array2__x__curr_value        ;
	// ports of ['ipxact_block_example_inst', 'reg_array[3]', 'x']
	input  [1-1:0]    ipxact_block_example_inst_reg_array3__x__next_value        ;
	input              ipxact_block_example_inst_reg_array3__x__pulse             ;
	output [1-1:0]    ipxact_block_example_inst_reg_array3__x__curr_value        ;
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
	logic [31:0] test_map_2_inst_shared_2_wr_data;
	logic test_map_2_inst_shared_2_wr_en;
	logic test_map_2_inst_shared_2_rd_en;
	logic [31:0] test_map_3_inst_shared_3_wr_data;
	logic test_map_3_inst_shared_3_wr_en;
	logic test_map_3_inst_shared_3_rd_en;
	logic [31:0] ipxact_block_example_inst_reg1_wr_data;
	logic ipxact_block_example_inst_reg1_wr_en;
	logic ipxact_block_example_inst_reg1_rd_en;
	logic [31:0] ipxact_block_example_inst_reg_array0_wr_data;
	logic ipxact_block_example_inst_reg_array0_wr_en;
	logic ipxact_block_example_inst_reg_array0_rd_en;
	logic [31:0] ipxact_block_example_inst_reg_array1_wr_data;
	logic ipxact_block_example_inst_reg_array1_wr_en;
	logic ipxact_block_example_inst_reg_array1_rd_en;
	logic [31:0] ipxact_block_example_inst_reg_array2_wr_data;
	logic ipxact_block_example_inst_reg_array2_wr_en;
	logic ipxact_block_example_inst_reg_array2_rd_en;
	logic [31:0] ipxact_block_example_inst_reg_array3_wr_data;
	logic ipxact_block_example_inst_reg_array3_wr_en;
	logic ipxact_block_example_inst_reg_array3_rd_en;
	// test_map_1_inst signal in regslv domain
	wire               test_map_1_inst_req_vld_fsm   ;
	wire               test_map_1_inst_ack_vld_fsm   ;
	wire               test_map_1_inst_wr_en_fsm     ;
	wire               test_map_1_inst_rd_en_fsm     ;
	wire [64-1:0]      test_map_1_inst_addr_fsm      ;
	wire [32-1:0]      test_map_1_inst_wr_data_fsm   ;
	wire [32-1:0]      test_map_1_inst_rd_data_fsm   ;
	// test_map_1_inst signal in ext_mem1 domain
	wire               test_map_1_inst_req_vld   ;
	wire               test_map_1_inst_ack_vld   ;
	wire               test_map_1_inst_wr_en     ;
	wire               test_map_1_inst_rd_en     ;
	wire [64-1:0]      test_map_1_inst_addr      ;
	wire [32-1:0]      test_map_1_inst_wr_data   ;
	wire [32-1:0]      test_map_1_inst_rd_data   ;
//****************************************WIRE DECLARATION END****************************************//


//***********************************EXTERNAL WIRE CONNECTION START***********************************//
	assign ext_wr_en_fsm   = fsm__slv__wr_en      ;
	assign ext_rd_en_fsm   = fsm__slv__rd_en      ;
	assign ext_addr_fsm    = fsm__slv__addr       ;
	assign ext_wr_data_fsm = fsm__slv__wr_data    ;
	assign ext_ack_is_back = | ext_ack_fsm        ;
	// wire connection of test_map_1_inst
	assign test_map_1_inst_req_vld_fsm            =   ext_req_vld_fsm[0]         ;
	assign ext_ack_vld_fsm[0]       =   test_map_1_inst_ack_vld_fsm              ;
	assign test_map_1_inst_wr_en_fsm              =   ext_wr_en_fsm               ;
	assign test_map_1_inst_rd_en_fsm              =   ext_rd_en_fsm               ;
	assign test_map_1_inst_addr_fsm               =   ext_addr_fsm                ;
	assign test_map_1_inst_wr_data_fsm            =   ext_wr_data_fsm             ;
	assign ext_rd_data_fsm[0]       =   test_map_1_inst_rd_data_fsm              ;
	assign ext_req_vld_fsm[0]       =   ext_sel[0] & fsm__slv__req_vld  ;
	assign ext_ack_fsm[0]           =   ext_sel[0] & ext_ack_vld_fsm[0]        ;
//************************************EXTERNAL WIRE CONNECTION END************************************//


//***************************************ADDRESS DECODER START****************************************//
	// global fsm_decoder @regslv domain
	assign global_address   = PADDR;
	assign ext_selected     = | ext_sel;
	always_comb begin
			int_selected = 1'b0;
			ext_sel = {EXT_NUM{1'b0}};
			none_selected = 1'b0;
		unique casez (global_address)
			64'h118,64'h11c,64'h200,64'h300,64'h304,64'h308,64'h30c:int_selected = 1'b1;//
			64'hc,64'h10,64'h14,64'h10c,64'h110,64'h114:ext_sel[0] = 1'b1;//external module test_map_1_inst
			default: none_selected = 1'b1;
		endcase
	end
	// internal regfile decoder @regfile domain
	always_comb begin
			reg_sel = {REG_NUM{1'b0}};
			dummy_reg = 1'b0;
		unique casez (regfile_addr)
			64'h118:reg_sel[0] = 1'b1;//['test_map_2_inst', 'shared_2']
			64'h11c:reg_sel[1] = 1'b1;//['test_map_3_inst', 'shared_3']
			64'h200:reg_sel[2] = 1'b1;//['ipxact_block_example_inst', 'reg1']
			64'h300:reg_sel[3] = 1'b1;//['ipxact_block_example_inst', 'reg_array[0]']
			64'h304:reg_sel[4] = 1'b1;//['ipxact_block_example_inst', 'reg_array[1]']
			64'h308:reg_sel[5] = 1'b1;//['ipxact_block_example_inst', 'reg_array[2]']
			64'h30c:reg_sel[6] = 1'b1;//['ipxact_block_example_inst', 'reg_array[3]']
			default: dummy_reg = 1'b1;
		endcase
	end
//****************************************ADDRESS DECODER END*****************************************//


//************************************STATE MACHINE INSTANCE START************************************//
	mst_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
		mst_fsm_root_map (
		.PCLK(PCLK),
		.PRESETn(PRESETn),
		.PSEL(PSEL),
		.PENABLE(PENABLE),
		.PREADY(PREADY),
		.PSLVERR(PSLVERR),
		.PADDR(PADDR),
		.PWRITE(PWRITE),
		.PWDATA(PWDATA),
		.PRDATA(PRDATA),
		.fsm__slv__req_vld(fsm__slv__req_vld),
		.slv__fsm__ack_vld(slv__fsm__ack_vld),
		.fsm__slv__addr(fsm__slv__addr),
		.fsm__slv__wr_en(fsm__slv__wr_en),
		.fsm__slv__rd_en(fsm__slv__rd_en),
		.fsm__slv__wr_data(fsm__slv__wr_data),
		.slv__fsm__rd_data(slv__fsm__rd_data),
		.external_reg_selected(ext_selected),
		.ext_ack_is_back(ext_ack_is_back),
		.fsm__slv__sync_reset(global_sync_reset_out),
		.clear(clear),
		.interrupt(interrupt)
		);
//*************************************STATE MACHINE INSTANCE END*************************************//


//**************************************SPLIT MUX INSTANCE START**************************************//
	// regfile mux @regfile domain
	split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(N+1), .GROUP_SIZE(128), .SKIP_DFF_0(1), .SKIP_DFF_1(1)) rd_split_mux
	(.clk(regfile_clk), .rst_n(regfile_rstn),
	.din({regfile_reg_rd_data_in,{DATA_WIDTH{1'b0}}}), .sel({rd_sel, dummy_reg & regfile_req_vld}),
	.dout(regfile_rd_data), .dout_vld(regfile_rd_ack_vld)
	);
	// external mux @regslv domain
	split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(M), .GROUP_SIZE(128), .SKIP_DFF_0(0), .SKIP_DFF_1(0)) ext_rd_split_mux
	(.clk(fsm_clk), .rst_n(fsm_rstn),
	.din(ext_rd_data_fsm), .sel(ext_ack_fsm),
	.dout(ext_rd_data_vld_fsm), .dout_vld(ext_reg_ack_vld_fsm)
	);
//***************************************SPLIT MUX INSTANCE END***************************************//


//*****************************************ULTIMATE MUX START*****************************************//
	// select which to read out and transfer the corresponding vld signal @regslv domain
	assign slv__fsm__rd_data = none_selected & fsm__slv__req_vld ? {DATA_WIDTH{1'b0}} : regfile_ack_vld_fsm ? regfile_rd_data_fsm : (ext_reg_ack_vld_fsm ? ext_rd_data_vld_fsm : 0);
	assign slv__fsm__ack_vld = none_selected & fsm__slv__req_vld | regfile_ack_vld_fsm | ext_reg_ack_vld_fsm;
//******************************************ULTIMATE MUX END******************************************//


//******************************EXTERNAL MEMORY SNAPSHOT REGISTER START*******************************//
//*******************************EXTERNAL MEMORY SNAPSHOT REGISTER END********************************//


//*****************************EXTERNAL MEMORY CDC DELIVER INSTANT START******************************//
	assign test_map_1_inst_req_vld       = test_map_1_inst_req_vld_fsm    ;
	assign test_map_1_inst_ack_vld_fsm   = test_map_1_inst_ack_vld        ;
	assign test_map_1_inst_wr_en         = test_map_1_inst_wr_en_fsm      ;
	assign test_map_1_inst_rd_en         = test_map_1_inst_rd_en_fsm      ;
	assign test_map_1_inst_addr          = test_map_1_inst_addr_fsm       ;
	assign test_map_1_inst_wr_data       = test_map_1_inst_wr_data_fsm    ;
	assign test_map_1_inst_rd_data_fsm   = test_map_1_inst_rd_data        ;
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
	//REG NAME: test_map_2_inst_shared_2//
	//REG HIERARCHY: ['test_map_2_inst', 'shared_2']//
	//REG ABSOLUTE_ADDR:64'h118//
	//REG OFFSET_ADDR:64'h64'h0//
	logic [31:0] test_map_2_inst_shared_2_o;
	assign test_map_2_inst_shared_2_wr_data = wr_sel[0] ? regfile_wr_data : 0;
	assign test_map_2_inst_shared_2_wr_en = wr_sel[0];
	assign test_map_2_inst_shared_2_rd_en = rd_sel[0];
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
	x__test_map_2_inst_shared_2__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst                (1'b0),
		.sw_wr_data            ({test_map_2_inst_shared_2_wr_data[13:12],test_map_3_inst_shared_3_wr_data[13:12]}),
		.sw_rd                 ({test_map_2_inst_shared_2_rd_en,test_map_3_inst_shared_3_rd_en}),
		.sw_wr                 ({test_map_2_inst_shared_2_wr_en,test_map_3_inst_shared_3_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (test_map_2_inst_shared_2__FIELD_2__next_value),
		.hw_pulse              (test_map_2_inst_shared_2__FIELD_2__pulse),
		.field_value           (test_map_2_inst_shared_2__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RO}),
		.SW_ONREAD_TYPE        ({`RSET,`RCLR}),
		.SW_ONWRITE_TYPE       ({`WZT,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__test_map_2_inst_shared_2__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst                (1'b0),
		.sw_wr_data            ({test_map_2_inst_shared_2_wr_data[16:14],test_map_3_inst_shared_3_wr_data[16:14]}),
		.sw_rd                 ({test_map_2_inst_shared_2_rd_en,test_map_3_inst_shared_3_rd_en}),
		.sw_wr                 ({test_map_2_inst_shared_2_wr_en,test_map_3_inst_shared_3_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (test_map_2_inst_shared_2__FIELD_1__next_value),
		.hw_pulse              (test_map_2_inst_shared_2__FIELD_1__pulse),
		.field_value           (test_map_2_inst_shared_2__FIELD_1__curr_value)
		);
	always_comb begin
	test_map_2_inst_shared_2_o[31:0] = 32'h0;
		test_map_2_inst_shared_2_o[13:12] = test_map_2_inst_shared_2__FIELD_2__curr_value;
		test_map_2_inst_shared_2_o[16:14] = test_map_2_inst_shared_2__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[0] = test_map_2_inst_shared_2_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: test_map_3_inst_shared_3//
	//REG HIERARCHY: ['test_map_3_inst', 'shared_3']//
	//REG ABSOLUTE_ADDR:64'h11c//
	//REG OFFSET_ADDR:64'h64'h0//
	logic [31:0] test_map_3_inst_shared_3_o;
	assign test_map_3_inst_shared_3_wr_data = wr_sel[1] ? regfile_wr_data : 0;
	assign test_map_3_inst_shared_3_wr_en = wr_sel[1];
	assign test_map_3_inst_shared_3_rd_en = rd_sel[1];
	always_comb begin
	test_map_3_inst_shared_3_o[31:0] = 32'h0;
		test_map_3_inst_shared_3_o[13:12] = test_map_2_inst_shared_2__FIELD_2__curr_value;
		test_map_3_inst_shared_3_o[16:14] = test_map_2_inst_shared_2__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[1] = test_map_3_inst_shared_3_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: ipxact_block_example_inst_reg1//
	//REG HIERARCHY: ['ipxact_block_example_inst', 'reg1']//
	//REG ABSOLUTE_ADDR:64'h200//
	//REG OFFSET_ADDR:64'h64'h0//
	logic [31:0] ipxact_block_example_inst_reg1_o;
	assign ipxact_block_example_inst_reg1_wr_data = wr_sel[2] ? regfile_wr_data : 0;
	assign ipxact_block_example_inst_reg1_wr_en = wr_sel[2];
	assign ipxact_block_example_inst_reg1_rd_en = rd_sel[2];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.SW_TYPE               ({`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA}),
		.SW_ONWRITE_TYPE       ({`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__ipxact_block_example_inst_reg1__f1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (ipxact_block_example_inst_reg1_wr_data[0:0]),
		.sw_rd                 (ipxact_block_example_inst_reg1_rd_en),
		.sw_wr                 (ipxact_block_example_inst_reg1_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (ipxact_block_example_inst_reg1__f1__next_value),
		.hw_pulse              (ipxact_block_example_inst_reg1__f1__pulse),
		.field_value           (ipxact_block_example_inst_reg1__f1__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (8),
		.ARST_VALUE            (8'h7b),
		.SW_TYPE               ({`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA}),
		.SW_ONWRITE_TYPE       ({`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__ipxact_block_example_inst_reg1__f2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (ipxact_block_example_inst_reg1_wr_data[15:8]),
		.sw_rd                 (ipxact_block_example_inst_reg1_rd_en),
		.sw_wr                 (ipxact_block_example_inst_reg1_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (ipxact_block_example_inst_reg1__f2__next_value),
		.hw_pulse              (ipxact_block_example_inst_reg1__f2__pulse),
		.field_value           (ipxact_block_example_inst_reg1__f2__curr_value)
		);
	always_comb begin
	ipxact_block_example_inst_reg1_o[31:0] = 32'h0;
		ipxact_block_example_inst_reg1_o[0:0] = ipxact_block_example_inst_reg1__f1__curr_value;
		ipxact_block_example_inst_reg1_o[15:8] = ipxact_block_example_inst_reg1__f2__curr_value;
	end
	assign regfile_reg_rd_data_in[2] = ipxact_block_example_inst_reg1_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: ipxact_block_example_inst_reg_array0//
	//REG HIERARCHY: ['ipxact_block_example_inst', 'reg_array[0]']//
	//REG ABSOLUTE_ADDR:64'h300//
	//REG OFFSET_ADDR:64'h64'h100//
	logic [31:0] ipxact_block_example_inst_reg_array0_o;
	assign ipxact_block_example_inst_reg_array0_wr_data = wr_sel[3] ? regfile_wr_data : 0;
	assign ipxact_block_example_inst_reg_array0_wr_en = wr_sel[3];
	assign ipxact_block_example_inst_reg_array0_rd_en = rd_sel[3];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.SW_TYPE               ({`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA}),
		.SW_ONWRITE_TYPE       ({`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__ipxact_block_example_inst_reg_array0__x
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (ipxact_block_example_inst_reg_array0_wr_data[0:0]),
		.sw_rd                 (ipxact_block_example_inst_reg_array0_rd_en),
		.sw_wr                 (ipxact_block_example_inst_reg_array0_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (ipxact_block_example_inst_reg_array0__x__next_value),
		.hw_pulse              (ipxact_block_example_inst_reg_array0__x__pulse),
		.field_value           (ipxact_block_example_inst_reg_array0__x__curr_value)
		);
	always_comb begin
	ipxact_block_example_inst_reg_array0_o[31:0] = 32'h0;
		ipxact_block_example_inst_reg_array0_o[0:0] = ipxact_block_example_inst_reg_array0__x__curr_value;
	end
	assign regfile_reg_rd_data_in[3] = ipxact_block_example_inst_reg_array0_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: ipxact_block_example_inst_reg_array1//
	//REG HIERARCHY: ['ipxact_block_example_inst', 'reg_array[1]']//
	//REG ABSOLUTE_ADDR:64'h304//
	//REG OFFSET_ADDR:64'h64'h104//
	logic [31:0] ipxact_block_example_inst_reg_array1_o;
	assign ipxact_block_example_inst_reg_array1_wr_data = wr_sel[4] ? regfile_wr_data : 0;
	assign ipxact_block_example_inst_reg_array1_wr_en = wr_sel[4];
	assign ipxact_block_example_inst_reg_array1_rd_en = rd_sel[4];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.SW_TYPE               ({`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA}),
		.SW_ONWRITE_TYPE       ({`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__ipxact_block_example_inst_reg_array1__x
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (ipxact_block_example_inst_reg_array1_wr_data[0:0]),
		.sw_rd                 (ipxact_block_example_inst_reg_array1_rd_en),
		.sw_wr                 (ipxact_block_example_inst_reg_array1_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (ipxact_block_example_inst_reg_array1__x__next_value),
		.hw_pulse              (ipxact_block_example_inst_reg_array1__x__pulse),
		.field_value           (ipxact_block_example_inst_reg_array1__x__curr_value)
		);
	always_comb begin
	ipxact_block_example_inst_reg_array1_o[31:0] = 32'h0;
		ipxact_block_example_inst_reg_array1_o[0:0] = ipxact_block_example_inst_reg_array1__x__curr_value;
	end
	assign regfile_reg_rd_data_in[4] = ipxact_block_example_inst_reg_array1_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: ipxact_block_example_inst_reg_array2//
	//REG HIERARCHY: ['ipxact_block_example_inst', 'reg_array[2]']//
	//REG ABSOLUTE_ADDR:64'h308//
	//REG OFFSET_ADDR:64'h64'h108//
	logic [31:0] ipxact_block_example_inst_reg_array2_o;
	assign ipxact_block_example_inst_reg_array2_wr_data = wr_sel[5] ? regfile_wr_data : 0;
	assign ipxact_block_example_inst_reg_array2_wr_en = wr_sel[5];
	assign ipxact_block_example_inst_reg_array2_rd_en = rd_sel[5];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.SW_TYPE               ({`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA}),
		.SW_ONWRITE_TYPE       ({`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__ipxact_block_example_inst_reg_array2__x
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (ipxact_block_example_inst_reg_array2_wr_data[0:0]),
		.sw_rd                 (ipxact_block_example_inst_reg_array2_rd_en),
		.sw_wr                 (ipxact_block_example_inst_reg_array2_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (ipxact_block_example_inst_reg_array2__x__next_value),
		.hw_pulse              (ipxact_block_example_inst_reg_array2__x__pulse),
		.field_value           (ipxact_block_example_inst_reg_array2__x__curr_value)
		);
	always_comb begin
	ipxact_block_example_inst_reg_array2_o[31:0] = 32'h0;
		ipxact_block_example_inst_reg_array2_o[0:0] = ipxact_block_example_inst_reg_array2__x__curr_value;
	end
	assign regfile_reg_rd_data_in[5] = ipxact_block_example_inst_reg_array2_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: ipxact_block_example_inst_reg_array3//
	//REG HIERARCHY: ['ipxact_block_example_inst', 'reg_array[3]']//
	//REG ABSOLUTE_ADDR:64'h30c//
	//REG OFFSET_ADDR:64'h64'h10c//
	logic [31:0] ipxact_block_example_inst_reg_array3_o;
	assign ipxact_block_example_inst_reg_array3_wr_data = wr_sel[6] ? regfile_wr_data : 0;
	assign ipxact_block_example_inst_reg_array3_wr_en = wr_sel[6];
	assign ipxact_block_example_inst_reg_array3_rd_en = rd_sel[6];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.SW_TYPE               ({`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA}),
		.SW_ONWRITE_TYPE       ({`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__ipxact_block_example_inst_reg_array3__x
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (ipxact_block_example_inst_reg_array3_wr_data[0:0]),
		.sw_rd                 (ipxact_block_example_inst_reg_array3_rd_en),
		.sw_wr                 (ipxact_block_example_inst_reg_array3_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (ipxact_block_example_inst_reg_array3__x__next_value),
		.hw_pulse              (ipxact_block_example_inst_reg_array3__x__pulse),
		.field_value           (ipxact_block_example_inst_reg_array3__x__curr_value)
		);
	always_comb begin
	ipxact_block_example_inst_reg_array3_o[31:0] = 32'h0;
		ipxact_block_example_inst_reg_array3_o[0:0] = ipxact_block_example_inst_reg_array3__x__curr_value;
	end
	assign regfile_reg_rd_data_in[6] = ipxact_block_example_inst_reg_array3_o;
//***************************************REG/FIELD INSTANCE END***************************************//


//**************************************REG/FIELD INSTANCE START**************************************//
//***************************************REG/FIELD INSTANCE END***************************************//


endmodule
`default_nettype wire