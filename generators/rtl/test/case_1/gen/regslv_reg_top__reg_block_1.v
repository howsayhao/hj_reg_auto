`include "xregister.vh"
`default_nettype none
module regslv_reg_top__reg_block_1(
//*************************************EXTERNAL MODULE PORT START*************************************//
	// ports of test_11
	test_11_req_vld           ,
	test_11_ack_vld           ,
	test_11_wr_en             ,
	test_11_rd_en             ,
	test_11_addr              ,
	test_11_wr_data           ,
	test_11_rd_data           ,
	// ports of ext_mem_11
	ext_mem_11_clk               ,
	ext_mem_11_rstn              ,
	ext_mem_11_req_vld           ,
	ext_mem_11_ack_vld           ,
	ext_mem_11_wr_en             ,
	ext_mem_11_rd_en             ,
	ext_mem_11_addr              ,
	ext_mem_11_wr_data           ,
	ext_mem_11_rd_data           ,
//**************************************EXTERNAL MODULE PORT END**************************************//


//*************************************INTERNAL FIELD PORT START**************************************//
	// ports of internal regfile
	regfile_clk          ,
	regfile_rstn         ,
	// ports of ['test_12', 'REG1', 'FIELD_0']
	test_12_REG1__FIELD_0__next_value        ,
	test_12_REG1__FIELD_0__pulse             ,
	test_12_REG1__FIELD_0__curr_value        ,
	// ports of ['test_12', 'REG2', 'FIELD_0']
	test_12_REG2__FIELD_0__next_value        ,
	test_12_REG2__FIELD_0__pulse             ,
	test_12_REG2__FIELD_0__curr_value        ,
	// ports of ['test_12', 'REG3', 'FIELD_0']
	test_12_REG3__FIELD_0__next_value        ,
	test_12_REG3__FIELD_0__pulse             ,
	test_12_REG3__FIELD_0__curr_value        ,
	// ports of ['test_12', 'REG4', 'FIELD_0']
	test_12_REG4__FIELD_0__next_value        ,
	test_12_REG4__FIELD_0__pulse             ,
	test_12_REG4__FIELD_0__curr_value        ,
	// ports of ['test_13', 'REG1', 'FIELD_0']
	test_13_REG1__FIELD_0__next_value        ,
	test_13_REG1__FIELD_0__pulse             ,
	test_13_REG1__FIELD_0__curr_value        ,
	// ports of ['test_13', 'REG2', 'FIELD_0']
	test_13_REG2__FIELD_0__next_value        ,
	test_13_REG2__FIELD_0__pulse             ,
	test_13_REG2__FIELD_0__curr_value        ,
	// ports of ['test_13', 'REG3', 'FIELD_0']
	test_13_REG3__FIELD_0__next_value        ,
	test_13_REG3__FIELD_0__pulse             ,
	test_13_REG3__FIELD_0__curr_value        ,
	// ports of ['test_13', 'REG4', 'FIELD_0']
	test_13_REG4__FIELD_0__next_value        ,
	test_13_REG4__FIELD_0__pulse             ,
	test_13_REG4__FIELD_0__curr_value        ,
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
	localparam                 N = 8                    ;
	localparam                 M = 2                    ;
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
	// ports define of test_11
	output             test_11_req_vld           ;
	input              test_11_ack_vld           ;
	output             test_11_wr_en             ;
	output             test_11_rd_en             ;
	output [64-1:0]    test_11_addr              ;
	output [32-1:0]    test_11_wr_data           ;
	input  [32-1:0]    test_11_rd_data           ;
	// ports define of ext_mem_11
	input              ext_mem_11_clk               ;
	input              ext_mem_11_rstn              ;
	output             ext_mem_11_req_vld           ;
	input              ext_mem_11_ack_vld           ;
	output             ext_mem_11_wr_en             ;
	output             ext_mem_11_rd_en             ;
	output [6-1:0]    ext_mem_11_addr              ;
	output [32-1:0]    ext_mem_11_wr_data           ;
	input  [32-1:0]    ext_mem_11_rd_data           ;
	//ports define of internal regfile
	input regfile_clk          ;
	input regfile_rstn         ;
	// ports of ['test_12', 'REG1', 'FIELD_0']
	input  [32-1:0]    test_12_REG1__FIELD_0__next_value        ;
	input              test_12_REG1__FIELD_0__pulse             ;
	output [32-1:0]    test_12_REG1__FIELD_0__curr_value        ;
	// ports of ['test_12', 'REG2', 'FIELD_0']
	input  [32-1:0]    test_12_REG2__FIELD_0__next_value        ;
	input              test_12_REG2__FIELD_0__pulse             ;
	output [32-1:0]    test_12_REG2__FIELD_0__curr_value        ;
	// ports of ['test_12', 'REG3', 'FIELD_0']
	input  [32-1:0]    test_12_REG3__FIELD_0__next_value        ;
	input              test_12_REG3__FIELD_0__pulse             ;
	output [32-1:0]    test_12_REG3__FIELD_0__curr_value        ;
	// ports of ['test_12', 'REG4', 'FIELD_0']
	input  [32-1:0]    test_12_REG4__FIELD_0__next_value        ;
	input              test_12_REG4__FIELD_0__pulse             ;
	output [32-1:0]    test_12_REG4__FIELD_0__curr_value        ;
	// ports of ['test_13', 'REG1', 'FIELD_0']
	input  [32-1:0]    test_13_REG1__FIELD_0__next_value        ;
	input              test_13_REG1__FIELD_0__pulse             ;
	output [32-1:0]    test_13_REG1__FIELD_0__curr_value        ;
	// ports of ['test_13', 'REG2', 'FIELD_0']
	input  [32-1:0]    test_13_REG2__FIELD_0__next_value        ;
	input              test_13_REG2__FIELD_0__pulse             ;
	output [32-1:0]    test_13_REG2__FIELD_0__curr_value        ;
	// ports of ['test_13', 'REG3', 'FIELD_0']
	input  [32-1:0]    test_13_REG3__FIELD_0__next_value        ;
	input              test_13_REG3__FIELD_0__pulse             ;
	output [32-1:0]    test_13_REG3__FIELD_0__curr_value        ;
	// ports of ['test_13', 'REG4', 'FIELD_0']
	input  [32-1:0]    test_13_REG4__FIELD_0__next_value        ;
	input              test_13_REG4__FIELD_0__pulse             ;
	output [32-1:0]    test_13_REG4__FIELD_0__curr_value        ;
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
	logic [31:0] test_12_REG1_wr_data;
	logic test_12_REG1_wr_en;
	logic test_12_REG1_rd_en;
	logic [31:0] test_12_REG2_wr_data;
	logic test_12_REG2_wr_en;
	logic test_12_REG2_rd_en;
	logic [31:0] test_12_REG3_wr_data;
	logic test_12_REG3_wr_en;
	logic test_12_REG3_rd_en;
	logic [31:0] test_12_REG4_wr_data;
	logic test_12_REG4_wr_en;
	logic test_12_REG4_rd_en;
	logic [31:0] test_13_REG1_wr_data;
	logic test_13_REG1_wr_en;
	logic test_13_REG1_rd_en;
	logic [31:0] test_13_REG2_wr_data;
	logic test_13_REG2_wr_en;
	logic test_13_REG2_rd_en;
	logic [31:0] test_13_REG3_wr_data;
	logic test_13_REG3_wr_en;
	logic test_13_REG3_rd_en;
	logic [31:0] test_13_REG4_wr_data;
	logic test_13_REG4_wr_en;
	logic test_13_REG4_rd_en;
	// test_11 signal in regslv domain
	wire               test_11_req_vld_fsm   ;
	wire               test_11_ack_vld_fsm   ;
	wire               test_11_wr_en_fsm     ;
	wire               test_11_rd_en_fsm     ;
	wire [64-1:0]      test_11_addr_fsm      ;
	wire [32-1:0]      test_11_wr_data_fsm   ;
	wire [32-1:0]      test_11_rd_data_fsm   ;
	// test_11 signal in ext_mem1 domain
	wire               test_11_req_vld   ;
	wire               test_11_ack_vld   ;
	wire               test_11_wr_en     ;
	wire               test_11_rd_en     ;
	wire [64-1:0]      test_11_addr      ;
	wire [32-1:0]      test_11_wr_data   ;
	wire [32-1:0]      test_11_rd_data   ;
	// ext_mem_11 signal in regslv domain
	wire               ext_mem_11_req_vld_fsm   ;
	wire               ext_mem_11_ack_vld_fsm   ;
	wire               ext_mem_11_wr_en_fsm     ;
	wire               ext_mem_11_rd_en_fsm     ;
	wire [6-1:0]      ext_mem_11_addr_fsm      ;
	wire [32-1:0]      ext_mem_11_wr_data_fsm   ;
	wire [32-1:0]      ext_mem_11_rd_data_fsm   ;
	// ext_mem_11 signal in ext_mem1 domain
	wire               ext_mem_11_req_vld   ;
	wire               ext_mem_11_ack_vld   ;
	wire               ext_mem_11_wr_en     ;
	wire               ext_mem_11_rd_en     ;
	wire [6-1:0]      ext_mem_11_addr      ;
	wire [32-1:0]      ext_mem_11_wr_data   ;
	wire [32-1:0]      ext_mem_11_rd_data   ;
	// ext_mem_11 signal to handle cdc
	logic [41-1:0] ext_mem_11_value_out_fsm;
	logic [41-1:0] ext_mem_11_value_out    ;
	logic [33-1:0] ext_mem_11_value_in_fsm ;
	logic [33-1:0] ext_mem_11_value_in     ;
	// the pulse to deliver the ext_mem_11 value
	logic          ext_mem_11_req_vld_fsm_ff   ;
	logic          ext_mem_11_sel_pulse        ;
	logic          ext_mem_11_ack_vld_ff       ;
	logic          ext_mem_11_ack_pulse        ;
	// ext_mem_11 snapshot signal in regslv domain
	wire            ext_mem_11_snapshot_wr_en_fsm     ;
	wire            ext_mem_11_snapshot_rd_en_fsm     ;
	wire [64-1:0]   ext_mem_11_snapshot_addr_fsm      ;
	wire [32-1:0]   ext_mem_11_snapshot_wr_data_fsm   ;
	wire [32-1:0]   ext_mem_11_snapshot_rd_data_fsm   ;
	wire            ext_mem_11_snapshot_req_vld_fsm   ;
	wire            ext_mem_11_snapshot_ack_vld_fsm   ;
//****************************************WIRE DECLARATION END****************************************//


//***********************************EXTERNAL WIRE CONNECTION START***********************************//
	assign ext_wr_en_fsm   = fsm__slv__wr_en      ;
	assign ext_rd_en_fsm   = fsm__slv__rd_en      ;
	assign ext_addr_fsm    = fsm__slv__addr       ;
	assign ext_wr_data_fsm = fsm__slv__wr_data    ;
	assign ext_ack_is_back = | ext_ack_fsm        ;
	// wire connection of test_11
	assign test_11_req_vld_fsm            =   ext_req_vld_fsm[0]         ;
	assign ext_ack_vld_fsm[0]       =   test_11_ack_vld_fsm              ;
	assign test_11_wr_en_fsm              =   ext_wr_en_fsm               ;
	assign test_11_rd_en_fsm              =   ext_rd_en_fsm               ;
	assign test_11_addr_fsm               =   ext_addr_fsm                ;
	assign test_11_wr_data_fsm            =   ext_wr_data_fsm             ;
	assign ext_rd_data_fsm[0]       =   test_11_rd_data_fsm              ;
	assign ext_req_vld_fsm[0]       =   ext_sel[0] & fsm__slv__req_vld  ;
	assign ext_ack_fsm[0]           =   ext_sel[0] & ext_ack_vld_fsm[0]        ;
	// wire connection of ext_mem_11
	assign ext_mem_11_snapshot_req_vld_fsm   =   ext_req_vld_fsm[1]         ;
	assign ext_ack_vld_fsm[1]       =   ext_mem_11_snapshot_ack_vld_fsm     ;
	assign ext_mem_11_snapshot_wr_en_fsm     =   ext_wr_en_fsm               ;
	assign ext_mem_11_snapshot_rd_en_fsm     =   ext_rd_en_fsm               ;
	assign ext_mem_11_snapshot_addr_fsm      =   ext_addr_fsm                ;
	assign ext_mem_11_snapshot_wr_data_fsm   =   ext_wr_data_fsm             ;
	assign ext_rd_data_fsm[1]       =   ext_mem_11_snapshot_rd_data_fsm     ;
	assign ext_req_vld_fsm[1]       =   ext_sel[1] & fsm__slv__req_vld  ;
	assign ext_ack_fsm[1]           =   ext_sel[1] & ext_ack_vld_fsm[1]        ;
//************************************EXTERNAL WIRE CONNECTION END************************************//


//***************************************ADDRESS DECODER START****************************************//
	// global fsm_decoder @regslv domain
	assign global_address   = addr;
	assign ext_selected     = | ext_sel;
	always_comb begin
			int_selected = 1'b0;
			ext_sel = {EXT_NUM{1'b0}};
			none_selected = 1'b0;
		unique casez (global_address)
			64'h10,64'h14,64'h18,64'h1c,64'h20,64'h24,64'h28,64'h2c:int_selected = 1'b1;//
			64'h0,64'h4,64'h8,64'hc:ext_sel[0] = 1'b1;//external module test_11
			64'h1??:ext_sel[1] = 1'b1;//external module ext_mem_11
			default: none_selected = 1'b1;
		endcase
	end
	// internal regfile decoder @regfile domain
	always_comb begin
			reg_sel = {REG_NUM{1'b0}};
			dummy_reg = 1'b0;
		unique casez (regfile_addr)
			64'h10:reg_sel[0] = 1'b1;//['test_12', 'REG1']
			64'h14:reg_sel[1] = 1'b1;//['test_12', 'REG2']
			64'h18:reg_sel[2] = 1'b1;//['test_12', 'REG3']
			64'h1c:reg_sel[3] = 1'b1;//['test_12', 'REG4']
			64'h20:reg_sel[4] = 1'b1;//['test_13', 'REG1']
			64'h24:reg_sel[5] = 1'b1;//['test_13', 'REG2']
			64'h28:reg_sel[6] = 1'b1;//['test_13', 'REG3']
			64'h2c:reg_sel[7] = 1'b1;//['test_13', 'REG4']
			default: dummy_reg = 1'b1;
		endcase
	end
//****************************************ADDRESS DECODER END*****************************************//


//************************************STATE MACHINE INSTANCE START************************************//
	slv_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
		slv_fsm_reg_top__reg_block_1 (
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
wire [ADDR_WIDTH-1:0] ext_mem_11_valid_addr_fsm ;
assign ext_mem_11_valid_addr_fsm  = ext_mem_11_snapshot_addr_fsm              ;
assign ext_mem_11_addr_fsm     = ext_mem_11_valid_addr_fsm[8-1:8-6]  ;
assign ext_mem_11_wr_en_fsm        = ext_mem_11_snapshot_wr_en_fsm            
;assign ext_mem_11_rd_en_fsm        = ext_mem_11_snapshot_rd_en_fsm            
;assign ext_mem_11_wr_data_fsm      = ext_mem_11_snapshot_wr_data_fsm          
;assign ext_mem_11_snapshot_rd_data_fsm      = ext_mem_11_rd_data_fsm          
;assign ext_mem_11_req_vld_fsm      = ext_mem_11_snapshot_req_vld_fsm          
;assign ext_mem_11_snapshot_ack_vld_fsm      = ext_mem_11_ack_vld_fsm          
;//*******************************EXTERNAL MEMORY SNAPSHOT REGISTER END********************************//


//*****************************EXTERNAL MEMORY CDC DELIVER INSTANT START******************************//
	assign test_11_req_vld       = test_11_req_vld_fsm    ;
	assign test_11_ack_vld_fsm   = test_11_ack_vld        ;
	assign test_11_wr_en         = test_11_wr_en_fsm      ;
	assign test_11_rd_en         = test_11_rd_en_fsm      ;
	assign test_11_addr          = test_11_addr_fsm       ;
	assign test_11_wr_data       = test_11_wr_data_fsm    ;
	assign test_11_rd_data_fsm   = test_11_rd_data        ;
	assign ext_mem_11_value_out_fsm = {ext_mem_11_req_vld_fsm, ext_mem_11_wr_en_fsm, ext_mem_11_rd_en_fsm, ext_mem_11_wr_data_fsm, ext_mem_11_addr_fsm};
	assign {ext_mem_11_req_vld, ext_mem_11_wr_en, ext_mem_11_rd_en, ext_mem_11_wr_data, ext_mem_11_addr} =  ext_mem_11_value_out;

	assign {ext_mem_11_ack_vld_fsm, ext_mem_11_rd_data_fsm} =  ext_mem_11_value_in_fsm;
	assign ext_mem_11_value_in = {ext_mem_11_ack_vld, ext_mem_11_rd_data};

	// create the pulse to deliver the value
	always_ff@(posedge fsm_clk or negedge fsm_rstn)begin
		if(~fsm_rstn)
			ext_mem_11_req_vld_fsm_ff <= 1'b0;
		else
			ext_mem_11_req_vld_fsm_ff <= ext_mem_11_req_vld_fsm;
	end

	assign ext_mem_11_sel_pulse = ~ext_mem_11_req_vld_fsm_ff & ext_mem_11_req_vld_fsm;

	always_ff@(posedge ext_mem_11_clk or negedge ext_mem_11_rstn)begin
		if(~ext_mem_11_rstn)
			ext_mem_11_ack_vld_ff <= 1'b0;
		else
			ext_mem_11_ack_vld_ff <= ext_mem_11_ack_vld;
	end

	assign ext_mem_11_ack_pulse = ~ext_mem_11_ack_vld_ff & ext_mem_11_ack_vld;

	// fsm to ext_mem_11
	value_transmitter
		#(.WIDTH(41))
		ext_mem_11_value_transmitter
		(
		.clk_a                                  (fsm_clk)                   ,
		.rst_a_n                                (fsm_rstn)                  ,
		.pulse_in                               (ext_mem_11_sel_pulse)             ,
		.value_in                               (ext_mem_11_value_out_fsm)   ,
		.clk_b                                  (ext_mem_11_clk)             ,
		.rst_b_n                                (ext_mem_11_rstn)            ,
		.value_out_ack                          (ext_mem_11_ack_vld)         ,
		.pulse_out                              ()                          ,
		.value_out                              (ext_mem_11_value_out)
	);

	value_transmitter
		#(.WIDTH(33))
		ext_mem_11_value_receiver
		(
		.clk_a                                  (ext_mem_11_clk)                         ,
		.rst_a_n                                (ext_mem_11_rstn)                        ,
		.pulse_in                               (ext_mem_11_ack_pulse)                         ,
		.value_in                               (ext_mem_11_value_in)                    ,
		.clk_b                                  (fsm_clk)                               ,
		.rst_b_n                                (fsm_rstn)                              ,
		.value_out_ack                          (ext_mem_11_ack_vld_fsm)                 ,
		.pulse_out                              ()                                      ,
		.value_out                              (ext_mem_11_value_in_fsm)
	);
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
	//REG NAME: test_12_REG1//
	//REG HIERARCHY: ['test_12', 'REG1']//
	//REG ABSOLUTE_ADDR:64'h10//
	//REG OFFSET_ADDR:64'h64'h0//
	logic [31:0] test_12_REG1_o;
	assign test_12_REG1_wr_data = wr_sel[0] ? regfile_wr_data : 0;
	assign test_12_REG1_wr_en = wr_sel[0];
	assign test_12_REG1_rd_en = rd_sel[0];
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
	x__test_12_REG1__FIELD_0
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (test_12_REG1_wr_data[31:0]),
		.sw_rd                 (test_12_REG1_rd_en),
		.sw_wr                 (test_12_REG1_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (test_12_REG1__FIELD_0__next_value),
		.hw_pulse              (test_12_REG1__FIELD_0__pulse),
		.field_value           (test_12_REG1__FIELD_0__curr_value)
		);
	always_comb begin
	test_12_REG1_o[31:0] = 32'h0;
		test_12_REG1_o[31:0] = test_12_REG1__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[0] = test_12_REG1_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: test_12_REG2//
	//REG HIERARCHY: ['test_12', 'REG2']//
	//REG ABSOLUTE_ADDR:64'h14//
	//REG OFFSET_ADDR:64'h64'h4//
	logic [31:0] test_12_REG2_o;
	assign test_12_REG2_wr_data = wr_sel[1] ? regfile_wr_data : 0;
	assign test_12_REG2_wr_en = wr_sel[1];
	assign test_12_REG2_rd_en = rd_sel[1];
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
	x__test_12_REG2__FIELD_0
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (test_12_REG2_wr_data[31:0]),
		.sw_rd                 (test_12_REG2_rd_en),
		.sw_wr                 (test_12_REG2_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (test_12_REG2__FIELD_0__next_value),
		.hw_pulse              (test_12_REG2__FIELD_0__pulse),
		.field_value           (test_12_REG2__FIELD_0__curr_value)
		);
	always_comb begin
	test_12_REG2_o[31:0] = 32'h0;
		test_12_REG2_o[31:0] = test_12_REG2__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[1] = test_12_REG2_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: test_12_REG3//
	//REG HIERARCHY: ['test_12', 'REG3']//
	//REG ABSOLUTE_ADDR:64'h18//
	//REG OFFSET_ADDR:64'h64'h8//
	logic [31:0] test_12_REG3_o;
	assign test_12_REG3_wr_data = wr_sel[2] ? regfile_wr_data : 0;
	assign test_12_REG3_wr_en = wr_sel[2];
	assign test_12_REG3_rd_en = rd_sel[2];
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
	x__test_12_REG3__FIELD_0
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (test_12_REG3_wr_data[31:0]),
		.sw_rd                 (test_12_REG3_rd_en),
		.sw_wr                 (test_12_REG3_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (test_12_REG3__FIELD_0__next_value),
		.hw_pulse              (test_12_REG3__FIELD_0__pulse),
		.field_value           (test_12_REG3__FIELD_0__curr_value)
		);
	always_comb begin
	test_12_REG3_o[31:0] = 32'h0;
		test_12_REG3_o[31:0] = test_12_REG3__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[2] = test_12_REG3_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: test_12_REG4//
	//REG HIERARCHY: ['test_12', 'REG4']//
	//REG ABSOLUTE_ADDR:64'h1c//
	//REG OFFSET_ADDR:64'h64'hc//
	logic [31:0] test_12_REG4_o;
	assign test_12_REG4_wr_data = wr_sel[3] ? regfile_wr_data : 0;
	assign test_12_REG4_wr_en = wr_sel[3];
	assign test_12_REG4_rd_en = rd_sel[3];
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
	x__test_12_REG4__FIELD_0
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (test_12_REG4_wr_data[31:0]),
		.sw_rd                 (test_12_REG4_rd_en),
		.sw_wr                 (test_12_REG4_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (test_12_REG4__FIELD_0__next_value),
		.hw_pulse              (test_12_REG4__FIELD_0__pulse),
		.field_value           (test_12_REG4__FIELD_0__curr_value)
		);
	always_comb begin
	test_12_REG4_o[31:0] = 32'h0;
		test_12_REG4_o[31:0] = test_12_REG4__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[3] = test_12_REG4_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: test_13_REG1//
	//REG HIERARCHY: ['test_13', 'REG1']//
	//REG ABSOLUTE_ADDR:64'h20//
	//REG OFFSET_ADDR:64'h64'h0//
	logic [31:0] test_13_REG1_o;
	assign test_13_REG1_wr_data = wr_sel[4] ? regfile_wr_data : 0;
	assign test_13_REG1_wr_en = wr_sel[4];
	assign test_13_REG1_rd_en = rd_sel[4];
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
	x__test_13_REG1__FIELD_0
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (test_13_REG1_wr_data[31:0]),
		.sw_rd                 (test_13_REG1_rd_en),
		.sw_wr                 (test_13_REG1_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (test_13_REG1__FIELD_0__next_value),
		.hw_pulse              (test_13_REG1__FIELD_0__pulse),
		.field_value           (test_13_REG1__FIELD_0__curr_value)
		);
	always_comb begin
	test_13_REG1_o[31:0] = 32'h0;
		test_13_REG1_o[31:0] = test_13_REG1__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[4] = test_13_REG1_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: test_13_REG2//
	//REG HIERARCHY: ['test_13', 'REG2']//
	//REG ABSOLUTE_ADDR:64'h24//
	//REG OFFSET_ADDR:64'h64'h4//
	logic [31:0] test_13_REG2_o;
	assign test_13_REG2_wr_data = wr_sel[5] ? regfile_wr_data : 0;
	assign test_13_REG2_wr_en = wr_sel[5];
	assign test_13_REG2_rd_en = rd_sel[5];
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
	x__test_13_REG2__FIELD_0
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (test_13_REG2_wr_data[31:0]),
		.sw_rd                 (test_13_REG2_rd_en),
		.sw_wr                 (test_13_REG2_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (test_13_REG2__FIELD_0__next_value),
		.hw_pulse              (test_13_REG2__FIELD_0__pulse),
		.field_value           (test_13_REG2__FIELD_0__curr_value)
		);
	always_comb begin
	test_13_REG2_o[31:0] = 32'h0;
		test_13_REG2_o[31:0] = test_13_REG2__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[5] = test_13_REG2_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: test_13_REG3//
	//REG HIERARCHY: ['test_13', 'REG3']//
	//REG ABSOLUTE_ADDR:64'h28//
	//REG OFFSET_ADDR:64'h64'h8//
	logic [31:0] test_13_REG3_o;
	assign test_13_REG3_wr_data = wr_sel[6] ? regfile_wr_data : 0;
	assign test_13_REG3_wr_en = wr_sel[6];
	assign test_13_REG3_rd_en = rd_sel[6];
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
	x__test_13_REG3__FIELD_0
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (test_13_REG3_wr_data[31:0]),
		.sw_rd                 (test_13_REG3_rd_en),
		.sw_wr                 (test_13_REG3_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (test_13_REG3__FIELD_0__next_value),
		.hw_pulse              (test_13_REG3__FIELD_0__pulse),
		.field_value           (test_13_REG3__FIELD_0__curr_value)
		);
	always_comb begin
	test_13_REG3_o[31:0] = 32'h0;
		test_13_REG3_o[31:0] = test_13_REG3__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[6] = test_13_REG3_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: test_13_REG4//
	//REG HIERARCHY: ['test_13', 'REG4']//
	//REG ABSOLUTE_ADDR:64'h2c//
	//REG OFFSET_ADDR:64'h64'hc//
	logic [31:0] test_13_REG4_o;
	assign test_13_REG4_wr_data = wr_sel[7] ? regfile_wr_data : 0;
	assign test_13_REG4_wr_en = wr_sel[7];
	assign test_13_REG4_rd_en = rd_sel[7];
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
	x__test_13_REG4__FIELD_0
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regfile_clk),
		.rst_n                 (regfile_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (test_13_REG4_wr_data[31:0]),
		.sw_rd                 (test_13_REG4_rd_en),
		.sw_wr                 (test_13_REG4_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (test_13_REG4__FIELD_0__next_value),
		.hw_pulse              (test_13_REG4__FIELD_0__pulse),
		.field_value           (test_13_REG4__FIELD_0__curr_value)
		);
	always_comb begin
	test_13_REG4_o[31:0] = 32'h0;
		test_13_REG4_o[31:0] = test_13_REG4__FIELD_0__curr_value;
	end
	assign regfile_reg_rd_data_in[7] = test_13_REG4_o;
//***************************************REG/FIELD INSTANCE END***************************************//


//**************************************REG/FIELD INSTANCE START**************************************//
//***************************************REG/FIELD INSTANCE END***************************************//


endmodule
`default_nettype wire