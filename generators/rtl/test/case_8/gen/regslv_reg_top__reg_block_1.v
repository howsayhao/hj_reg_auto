`include "xregister.vh"
module regslv_reg_top__reg_block_1(
//*************************************EXTERNAL MODULE PORT START*************************************//
	// ports of ext_mem_1
	ext_mem_1_clk               ,
	ext_mem_1_rstn              ,
	ext_mem_1_req_vld           ,
	ext_mem_1_ack_vld           ,
	ext_mem_1_wr_en             ,
	ext_mem_1_rd_en             ,
	ext_mem_1_addr              ,
	ext_mem_1_wr_data           ,
	ext_mem_1_rd_data           ,
//**************************************EXTERNAL MODULE PORT END**************************************//


//*************************************INTERNAL FIELD PORT START**************************************//
	// ports of internal regfile
	regfile_clk          ,
	regfile_rstn         ,
	// ports of ['REG1', 'FIELD_0']
	REG1__FIELD_0__next_value        ,
	REG1__FIELD_0__pulse             ,
	REG1__FIELD_0__curr_value        ,
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
	localparam                 N = 2                    ;
	localparam                 M = 1                    ;
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
	// ports define of ext_mem_1
	input              ext_mem_1_clk               ;
	input              ext_mem_1_rstn              ;
	output             ext_mem_1_req_vld           ;
	input              ext_mem_1_ack_vld           ;
	output             ext_mem_1_wr_en             ;
	output             ext_mem_1_rd_en             ;
	output [1-1:0]    ext_mem_1_addr              ;
	output [128-1:0]    ext_mem_1_wr_data           ;
	input  [128-1:0]    ext_mem_1_rd_data           ;
	//ports define of internal regfile
	input regfile_clk          ;
	input regfile_rstn         ;
	// ports of ['REG1', 'FIELD_0']
	input  [64-1:0]    REG1__FIELD_0__next_value        ;
	input              REG1__FIELD_0__pulse             ;
	output [64-1:0]    REG1__FIELD_0__curr_value        ;
//****************************************PORT DECLARATION END****************************************//


//***************************************WIRE DECLARATION START***************************************//
	// declare the handshake signal for fsm
	wire                   slv__fsm__ack_vld		;
	wire                   fsm__slv__req_vld		;
	// signal for fsm
	wire 						fsm__slv__wr_en		;
	wire 						fsm__slv__rd_en		;
	wire [ADDR_WIDTH-1:0] 		fsm__slv__addr		;
	wire [DATA_WIDTH-1:0] 		fsm__slv__wr_data	;
	wire [DATA_WIDTH-1:0]  		slv__fsm__rd_data	;
	// fsm state indicator 
	wire				   		cs_is_idle			;

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
	logic [31:0] REG1__snap_0_wr_data;
	logic REG1__snap_0_wr_en;
	logic REG1__snap_0_rd_en;
	logic [31:0] REG1__snap_1_wr_data;
	logic REG1__snap_1_wr_en;
	logic REG1__snap_1_rd_en;
	logic [63:0] REG1_wr_data;
	logic [63:0] REG1_snapshot_wr_data;
	logic [63:0] REG1_snapshot_reg_rd_data;
	logic REG1_wr_en;
	logic REG1_snapshot_wr_en;
	logic REG1_rd_en;
	logic REG1_snapshot_rd_en;
	// ext_mem_1 signal in regslv domain
	wire               ext_mem_1_req_vld_fsm   ;
	wire               ext_mem_1_ack_vld_fsm   ;
	wire               ext_mem_1_wr_en_fsm     ;
	wire               ext_mem_1_rd_en_fsm     ;
	wire [1-1:0]      ext_mem_1_addr_fsm      ;
	wire [128-1:0]      ext_mem_1_wr_data_fsm   ;
	wire [128-1:0]      ext_mem_1_rd_data_fsm   ;
	// ext_mem_1 signal in ext_mem1 domain
	wire               ext_mem_1_req_vld   ;
	wire               ext_mem_1_ack_vld   ;
	wire               ext_mem_1_wr_en     ;
	wire               ext_mem_1_rd_en     ;
	wire [1-1:0]      ext_mem_1_addr      ;
	wire [128-1:0]      ext_mem_1_wr_data   ;
	wire [128-1:0]      ext_mem_1_rd_data   ;
	// ext_mem_1 signal to handle cdc
	logic [132-1:0] ext_mem_1_value_out_fsm;
	logic [132-1:0] ext_mem_1_value_out    ;
	logic [129-1:0] ext_mem_1_value_in_fsm ;
	logic [129-1:0] ext_mem_1_value_in     ;
	// the pulse to deliver the ext_mem_1 value
	logic          ext_mem_1_req_vld_fsm_ff   ;
	logic          ext_mem_1_sel_pulse        ;
	logic          ext_mem_1_ack_vld_ff       ;
	logic          ext_mem_1_ack_pulse        ;
	// ext_mem_1 snapshot signal in regslv domain
	wire            ext_mem_1_snapshot_wr_en_fsm     ;
	wire            ext_mem_1_snapshot_rd_en_fsm     ;
	wire [64-1:0]   ext_mem_1_snapshot_addr_fsm      ;
	wire [32-1:0]   ext_mem_1_snapshot_wr_data_fsm   ;
	wire [32-1:0]   ext_mem_1_snapshot_rd_data_fsm   ;
	wire            ext_mem_1_snapshot_req_vld_fsm   ;
	wire            ext_mem_1_snapshot_ack_vld_fsm   ;
//****************************************WIRE DECLARATION END****************************************//


//***********************************EXTERNAL WIRE CONNECTION START***********************************//
	assign ext_wr_en_fsm   = fsm__slv__wr_en      ;
	assign ext_rd_en_fsm   = fsm__slv__rd_en      ;
	assign ext_addr_fsm    = fsm__slv__addr       ;
	assign ext_wr_data_fsm = fsm__slv__wr_data    ;
	// wire connection of ext_mem_1
	assign ext_mem_1_snapshot_req_vld_fsm   =   ext_req_vld_fsm[0]         ;
	assign ext_ack_vld_fsm[0]       =   ext_mem_1_snapshot_ack_vld_fsm     ;
	assign ext_mem_1_snapshot_wr_en_fsm     =   ext_wr_en_fsm               ;
	assign ext_mem_1_snapshot_rd_en_fsm     =   ext_rd_en_fsm               ;
	assign ext_mem_1_snapshot_addr_fsm      =   ext_addr_fsm                ;
	assign ext_mem_1_snapshot_wr_data_fsm   =   ext_wr_data_fsm             ;
	assign ext_rd_data_fsm[0]       =   ext_mem_1_snapshot_rd_data_fsm     ;
	assign ext_req_vld_fsm[0]       =   ext_sel[0] & fsm__slv__req_vld ;
	assign ext_ack_fsm[0]           =   ext_sel[0] & ext_ack_vld_fsm   ;
//************************************EXTERNAL WIRE CONNECTION END************************************//


//***************************************ADDRESS DECODER START****************************************//
	// global fsm_decoder @regslv domain
	assign global_address   = cs_is_idle ? addr : fsm__slv__addr;
	assign ext_selected     = | ext_sel;
	always_comb begin
			int_selected = 1'b0;
			ext_sel = {EXT_NUM{1'b0}};
			none_selected = 1'b0;
		unique casez (global_address)
			64'h0,64'h4:int_selected = 1'b1;//
			64'h2?,64'h3?:ext_sel[0] = 1'b1;//external module ext_mem_1
			default: none_selected = 1'b1;
		endcase
	end
	// internal regfile decoder @regfile domain
	always_comb begin
			reg_sel = {REG_NUM{1'b0}};
			dummy_reg = 1'b0;
		unique casez (regfile_addr)
			64'h0:reg_sel[0] = 1'b1;//['REG1', '_snap_0']
			64'h4:reg_sel[1] = 1'b1;//['REG1', '_snap_1']
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
//*************************************STATE MACHINE INSTANCE END*************************************//


//**************************************SPLIT MUX INSTANCE START**************************************//
	// regfile mux @regfile domain
	split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(N+1), .GROUP_SIZE(128), .SKIP_DFF_0(1), .SKIP_DFF_1(1)) rd_split_mux
	(.clk(regfile_clk), .rst_n(regfile_rstn),
	.din({regfile_reg_rd_data_in,{DATA_WIDTH{1'b0}}}), .sel({rd_sel, dummy_reg}),
	.dout(regfile_rd_data), .dout_vld(regfile_ack_vld)
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
	assign slv__fsm__rd_data = regfile_ack_vld_fsm ? regfile_rd_data_fsm : (ext_reg_ack_vld_fsm ? ext_rd_data_vld_fsm : 0);
	assign slv__fsm__ack_vld = regfile_ack_vld_fsm | ext_reg_ack_vld_fsm;
//******************************************ULTIMATE MUX END******************************************//


//******************************EXTERNAL MEMORY SNAPSHOT REGISTER START*******************************//
	snapshot_reg_mem
		#(.DATA_WIDTH(32), .MEM_WIDTH(128), .SUB(0),	.ADDR_WIDTH(64), .VALID_WIDTH(5), .ENTRY_WIDTH(1))
	ext_mem_1_snapshot_reg_mem
		(
		.clk                     (fsm_clk)                               ,
		.rst_n                   (fsm_rstn)                              ,
		.addr                    (ext_mem_1_snapshot_addr_fsm)                  ,
		.wr_en                   (ext_mem_1_snapshot_wr_en_fsm)                 ,
		.rd_en                   (ext_mem_1_snapshot_rd_en_fsm)                 ,
		.wr_data                 (ext_mem_1_snapshot_wr_data_fsm)               ,
		.rd_data                 (ext_mem_1_snapshot_rd_data_fsm)               ,
		.req_vld                 (ext_mem_1_snapshot_req_vld_fsm)               ,
		.ack_vld                 (ext_mem_1_snapshot_ack_vld_fsm)               ,
		.entry_write_protect_en  (1'b0)                             ,
		.entry_vld               (1'b1)                             ,
		.entry_vld_nxt           ()                                  ,
		.mem_addr                (ext_mem_1_addr_fsm)                           ,
		.mem_wr_en               (ext_mem_1_wr_en_fsm)                          ,
		.mem_rd_en               (ext_mem_1_rd_en_fsm)                          ,
		.mem_wr_data             (ext_mem_1_wr_data_fsm)                        ,
		.mem_rd_data             (ext_mem_1_rd_data_fsm)                        ,
		.mem_req_vld             (ext_mem_1_req_vld_fsm)                        ,
		.mem_ack_vld             (ext_mem_1_ack_vld_fsm)                        
	);
//*******************************EXTERNAL MEMORY SNAPSHOT REGISTER END********************************//


//*****************************EXTERNAL MEMORY CDC DELIVER INSTANT START******************************//
	assign ext_mem_1_value_out_fsm = {ext_mem_1_req_vld_fsm, ext_mem_1_wr_en_fsm, ext_mem_1_rd_en_fsm, ext_mem_1_wr_data_fsm, ext_mem_1_addr_fsm};
	assign {ext_mem_1_req_vld, ext_mem_1_wr_en, ext_mem_1_rd_en, ext_mem_1_wr_data, ext_mem_1_addr} =  ext_mem_1_value_out;

	assign {ext_mem_1_ack_vld_fsm, ext_mem_1_rd_data_fsm} =  ext_mem_1_value_in_fsm;
	assign ext_mem_1_value_in = {ext_mem_1_ack_vld, ext_mem_1_rd_data};

	// create the pulse to deliver the value
	always_ff@(posedge fsm_clk or negedge fsm_rstn)begin
		if(fsm_rstn)
			ext_mem_1_req_vld_fsm_ff = 1'b0;
		else
			ext_mem_1_req_vld_fsm_ff = ext_mem_1_req_vld_fsm;
	end

	assign mem_sel_pulse = ~ext_mem_1_req_vld_fsm_ff & ext_mem_1_req_vld_fsm;

	always_ff@(posedge ext_mem_1_clk or negedge ext_mem_1_rstn)begin
		if(ext_mem_1_rstn)
			ext_mem_1_ack_vld_ff = 1'b0;
		else
			ext_mem_1_ack_vld_ff = ext_mem_1_ack_vld;
	end

	assign mem_ack_pulse = ~ext_mem_1_ack_vld_ff & ext_mem_1_ack_vld;

	// fsm to ext_mem_1
	value_transmitter
		#(.WIDTH(132))
		ext_mem_1_value_transmitter
		(
		.clk_a                                  (fsm_clk)                   ,
		.rst_a_n                                (fsm_rstn)                  ,
		.pulse_in                               (ext_mem_1_sel_pulse)             ,
		.value_in                               (ext_mem_1_value_out_fsm)   ,
		.clk_b                                  (ext_mem_1_clk)             ,
		.rst_b_n                                (ext_mem_1_rstn)            ,
		.value_out_ack                          (ext_mem_1_ack_vld)         ,
		.pulse_out                              ()                          ,
		.value_out                              (ext_mem_1_value_out)
	);

	value_transmitter
		#(.WIDTH(129))
		ext_mem_1_value_receiver
		(
		.clk_a                                  (ext_mem_1_clk)                         ,
		.rst_a_n                                (ext_mem_1_rstn)                        ,
		.pulse_in                               (ext_mem_1_ack_pulse)                         ,
		.value_in                               (ext_mem_1_value_in)                    ,
		.clk_b                                  (fsm_clk)                               ,
		.rst_b_n                                (fsm_rstn)                              ,
		.value_out_ack                          (ext_mem_1_ack_vld_fsm)                 ,
		.pulse_out                              ()                                      ,
		.value_out                              (ext_mem_1_value_in_fsm)
	);
//******************************EXTERNAL MEMORY CDC DELIVER INSTANT END*******************************//


//*********************************REGFILE CDC DELIVER INSTANT START**********************************//
	assign regfile_req_vld_fsm = fsm__slv__req_vld & int_selected;
	assign regfile_wr_en_fsm = fsm__slv__wr_en & int_selected;
	assign regfile_rd_en_fsm = fsm__slv__rd_en & int_selected;
	assign regfile_wr_data_fsm = int_selected ? fsm__slv__wr_data : 0;
	assign regfile_addr_fsm = int_selected ? fsm__slv__addr : 0;

	assign regfile_value_out_fsm = {regfile_req_vld_fsm, regfile_wr_en_fsm, regfile_rd_en_fsm, regfile_wr_data_fsm, regfile_addr_fsm};
	assign {regfile_req_vld, regfile_wr_en, regfile_rd_en, regfile_wr_data, regfile_addr} =  regfile_value_out;

	assign {regfile_ack_vld_fsm, regfile_rd_data_fsm} =  regfile_value_in_fsm;
	assign regfile_value_in = {regfile_ack_vld, regfile_rd_data};

	// create the pulse to deliver the value
	always_ff@(posedge fsm_clk or negedge fsm_rstn)begin
		if(fsm_rstn)
			regfile_req_vld_fsm_ff = 1'b0;
		else
			regfile_req_vld_fsm_ff = regfile_req_vld_fsm;
	end

	assign mem_sel_pulse = ~regfile_req_vld_fsm_ff & regfile_req_vld_fsm;

	always_ff@(posedge regfile_clk or negedge regfile_rstn)begin
		if(regfile_rstn)
			regfile_ack_vld_ff = 1'b0;
		else
			regfile_ack_vld_ff = regfile_ack_vld;
	end

	assign mem_ack_pulse = ~regfile_ack_vld_ff & regfile_ack_vld;

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
	//REG NAME: REG1__snap_0//
	//REG HIERARCHY: ['REG1', '_snap_0']//
	//REG ABSOLUTE_ADDR:64'h0//
	//REG OFFSET_ADDR:64'h64'h0//
	logic [31:0] REG1__snap_0_o;
	assign REG1__snap_0_wr_data = wr_sel[0] ? regfile_wr_data : 0;
	assign REG1__snap_0_wr_en = wr_sel[0];
	assign REG1__snap_0_rd_en = rd_sel[0];
	assign regfile_reg_rd_data_in[0] = REG1__snap_0_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: REG1__snap_1//
	//REG HIERARCHY: ['REG1', '_snap_1']//
	//REG ABSOLUTE_ADDR:64'h4//
	//REG OFFSET_ADDR:64'h64'h0//
	logic [31:0] REG1__snap_1_o;
	assign REG1__snap_1_wr_data = wr_sel[1] ? regfile_wr_data : 0;
	assign REG1__snap_1_wr_en = wr_sel[1];
	assign REG1__snap_1_rd_en = rd_sel[1];
	assign regfile_reg_rd_data_in[1] = REG1__snap_1_o;
//***************************************REG/FIELD INSTANCE END***************************************//


//**************************************REG/FIELD INSTANCE START**************************************//
	//============================================REG INSTANT=============================================//
	//REG NAME: REG1//
	//REG HIERARCHY: ['REG1']//
	//REG ABSOLUTE_ADDR:64'h0//
	//REG OFFSET_ADDR:64'h64'h0//
	logic [63:0] REG1_o;
	assign REG1_wr_data = REG1_snapshot_wr_data;
	assign REG1_wr_en = REG1_snapshot_wr_en;
	assign REG1_rd_en = REG1_snapshot_rd_en;
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (64),
		.ARST_VALUE            (64'h0),
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
		.sw_wr_data            (REG1_wr_data[63:0]),
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
		REG1_o[63:0] = 64'h0;
		REG1_o[63:0] = REG1__FIELD_0__curr_value;
	end
	assign REG1_snapshot_reg_rd_data = REG1_o;
	//snapshot_reg instance
	snapshot_reg
		#(.DATA_WIDTH(32), .REG_WIDTH(64))
	REG1_snapshot_reg
		(
		.clk                     (regfile_clk)                               ,
		.rst_n                   (regfile_rstn)                              ,
		.snap_wr_en              ({REG1__snap_1_wr_en,REG1__snap_0_wr_en})                              ,
		.snap_rd_en              ({REG1__snap_1_rd_en,REG1__snap_0_rd_en})                              ,
		.snap_wr_data            ({REG1__snap_1_wr_data,REG1__snap_0_wr_data})                              ,
		.snap_rd_data            ({REG1__snap_1_o,REG1__snap_0_o})                              ,
		.reg_wr_en               (REG1_snapshot_wr_en)                 ,
		.reg_rd_en               (REG1_snapshot_rd_en)                 ,
		.reg_wr_data             (REG1_snapshot_wr_data)               ,
		.reg_rd_data             (REG1_snapshot_reg_rd_data)           
	);
//***************************************REG/FIELD INSTANCE END***************************************//


endmodule