`include "xregister.vh"
`default_nettype none
module regmst_root_map(
//*************************************EXTERNAL MODULE PORT START*************************************//
	// ports of ext
	ext_req_vld           ,
	ext_ack_vld           ,
	ext_wr_en             ,
	ext_rd_en             ,
	ext_addr              ,
	ext_wr_data           ,
	ext_rd_data           ,
//**************************************EXTERNAL MODULE PORT END**************************************//


//*************************************INTERNAL FIELD PORT START**************************************//
	// ports of internal regfile
	// ports of ['err_log_1', 'intr']
	err_log_1__intr__next_value        ,
	err_log_1__intr__pulse             ,
	err_log_1__intr__curr_value        ,
	// ports of ['err_log_1', 'soft_reset']
	err_log_1__soft_reset__next_value        ,
	err_log_1__soft_reset__pulse             ,
	err_log_1__soft_reset__curr_value        ,
	// ports of ['err_log_0', 'addr']
	err_log_0__addr__next_value        ,
	err_log_0__addr__pulse             ,
	err_log_0__addr__curr_value        ,
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
	localparam                 N = 3                    ;
	localparam                 M = 1                    ;
	localparam                 REG_NUM = N ? N : 1      ;
	localparam                 EXT_NUM = M ? M : 1      ;
//**************************************PARAMETER DEFINITION END**************************************//


//***************************************PORT DECLARATION START***************************************//
	// dispatch domain @clk
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
	// ports define of ext
	output             ext_req_vld           ;
	input              ext_ack_vld           ;
	output             ext_wr_en             ;
	output             ext_rd_en             ;
	output [ADDR_WIDTH-1:0]    ext_addr              ;
	output [DATA_WIDTH-1:0]    ext_wr_data           ;
	input  [DATA_WIDTH-1:0]    ext_rd_data           ;
	//ports define of internal regfile
	// ports of ['err_log_1', 'intr']
	input  [1-1:0]    err_log_1__intr__next_value        ;
	input              err_log_1__intr__pulse             ;
	output [1-1:0]    err_log_1__intr__curr_value        ;
	// ports of ['err_log_1', 'soft_reset']
	input  [1-1:0]    err_log_1__soft_reset__next_value        ;
	input              err_log_1__soft_reset__pulse             ;
	output [1-1:0]    err_log_1__soft_reset__curr_value        ;
	// ports of ['err_log_0', 'addr']
	input  [64-1:0]    err_log_0__addr__next_value        ;
	input              err_log_0__addr__pulse             ;
	output [64-1:0]    err_log_0__addr__curr_value        ;
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
	assign ext_req_vld      = fsm__slv__req_vld           ;
	assign ext_wr_en        = fsm__slv__wr_en             ;
	assign ext_rd_en        = fsm__slv__rd_en             ;
	assign ext_addr         = fsm__slv__addr              ;
	assign ext_wr_data      = fsm__slv__wr_data           ;

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
	assign regfile_ack_vld       = slv__fsm__ack_vld     ;
	assign regfile_wr_en         = fsm__slv__wr_en       ;
	assign regfile_rd_en         = fsm__slv__rd_en       ;
	assign regfile_addr          = fsm__slv__addr        ;
	assign regfile_wr_data       = fsm__slv__wr_data     ;
	assign regfile_rd_data       = slv__fsm__rd_data     ;

	assign wr_sel = {REG_NUM{regfile_wr_en}} & reg_sel   ;
	assign rd_sel = {REG_NUM{regfile_rd_en}} & reg_sel   ;
	assign regfile_ack_vld = regfile_rd_ack_vld | regfile_wr_en;

	logic [31:0] err_log_0__snap_0_wr_data;
	logic err_log_0__snap_0_wr_en;
	logic err_log_0__snap_0_rd_en;

	logic [31:0] err_log_0__snap_1_wr_data;
	logic err_log_0__snap_1_wr_en;
	logic err_log_0__snap_1_rd_en;

	logic [31:0] err_log_1_wr_data;
	logic err_log_1_wr_en;
	logic err_log_1_rd_en;

	logic [63:0] err_log_0_wr_data;
	logic [63:0] err_log_0_snapshot_wr_data;
	logic [63:0] err_log_0_snapshot_reg_rd_data;
	logic err_log_0_wr_en;
	logic err_log_0_snapshot_wr_en;
	logic err_log_0_rd_en;
	logic err_log_0_snapshot_rd_en;
//****************************************WIRE DECLARATION END****************************************//


//***************************************ADDRESS DECODER START****************************************//
	// internal regfile decoder @regfile domain
	always_comb begin
			reg_sel = {REG_NUM{1'b0}};
			dummy_reg = 1'b0;
		unique casez (regfile_addr)
			64'h0:reg_sel[0] = 1'b1;//['err_log_0', '_snap_0']
			64'h4:reg_sel[1] = 1'b1;//['err_log_0', '_snap_1']
			64'h8:reg_sel[2] = 1'b1;//['err_log_1']
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
		.fsm__slv__sync_reset(global_sync_reset_out),
		.clear(clear),
		.interrupt(interrupt)
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
	assign slv__fsm__rd_data = regfile_ack_vld ? regfile_rd_data : (ext_ack_vld ? ext_rd_data : 0);
	assign slv__fsm__ack_vld = regfile_ack_vld | ext_ack_vld;
//******************************************ULTIMATE MUX END******************************************//


//**************************************REG/FIELD INSTANCE START**************************************//
	//============================================REG INSTANT=============================================//
	//REG NAME: err_log_0__snap_0//
	//REG HIERARCHY: ['err_log_0', '_snap_0']//
	//REG ABSOLUTE_ADDR:64'h0//
	//REG OFFSET_ADDR:64'h0//
	logic [31:0] err_log_0__snap_0_o;
	assign err_log_0__snap_0_wr_data = wr_sel[0] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign err_log_0__snap_0_wr_en = wr_sel[0];
	assign err_log_0__snap_0_rd_en = rd_sel[0];
	assign regfile_reg_rd_data_in[0] = err_log_0__snap_0_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: err_log_0__snap_1//
	//REG HIERARCHY: ['err_log_0', '_snap_1']//
	//REG ABSOLUTE_ADDR:64'h4//
	//REG OFFSET_ADDR:64'h0//
	logic [31:0] err_log_0__snap_1_o;
	assign err_log_0__snap_1_wr_data = wr_sel[1] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign err_log_0__snap_1_wr_en = wr_sel[1];
	assign err_log_0__snap_1_rd_en = rd_sel[1];
	assign regfile_reg_rd_data_in[1] = err_log_0__snap_1_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: err_log_1//
	//REG HIERARCHY: ['err_log_1']//
	//REG ABSOLUTE_ADDR:64'h8//
	//REG OFFSET_ADDR:64'h8//
	logic [31:0] err_log_1_o;
	assign err_log_1_wr_data = wr_sel[2] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign err_log_1_wr_en = wr_sel[2];
	assign err_log_1_rd_en = rd_sel[2];
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
	x__err_log_1__intr
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (err_log_1_wr_data[0:0]),
		.sw_rd                 (err_log_1_rd_en),
		.sw_wr                 (err_log_1_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (err_log_1__intr__next_value),
		.hw_pulse              (err_log_1__intr__pulse),
		.field_value           (err_log_1__intr__curr_value)
		);
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
	x__err_log_1__soft_reset
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (err_log_1_wr_data[1:1]),
		.sw_rd                 (err_log_1_rd_en),
		.sw_wr                 (err_log_1_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (err_log_1__soft_reset__next_value),
		.hw_pulse              (err_log_1__soft_reset__pulse),
		.field_value           (err_log_1__soft_reset__curr_value)
		);
	always_comb begin
		err_log_1_o[31:0] = 32'h0;
		err_log_1_o[0:0] = err_log_1__intr__curr_value;
		err_log_1_o[1:1] = err_log_1__soft_reset__curr_value;
	end
	assign regfile_reg_rd_data_in[2] = err_log_1_o;
//***************************************REG/FIELD INSTANCE END***************************************//


//**************************************REG/FIELD INSTANCE START**************************************//
	//============================================REG INSTANT=============================================//
	//REG NAME: err_log_0//
	//REG HIERARCHY: ['err_log_0']//
	//REG ABSOLUTE_ADDR:64'h0//
	//REG OFFSET_ADDR:64'h64'h0//
	logic [63:0] err_log_0_o;
	assign err_log_0_wr_data = err_log_0_snapshot_wr_data;
	assign err_log_0_wr_en = err_log_0_snapshot_wr_en;
	assign err_log_0_rd_en = err_log_0_snapshot_rd_en;
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
	x__err_log_0__addr
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (err_log_0_wr_data[63:0]),
		.sw_rd                 (err_log_0_rd_en),
		.sw_wr                 (err_log_0_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (err_log_0__addr__next_value),
		.hw_pulse              (err_log_0__addr__pulse),
		.field_value           (err_log_0__addr__curr_value)
		);
	always_comb begin
		err_log_0_o[63:0] = 64'h0;
		err_log_0_o[63:0] = err_log_0__addr__curr_value;
	end
	assign err_log_0_snapshot_reg_rd_data = err_log_0_o;
	//snapshot_reg instance
	snapshot_reg
		#(.DATA_WIDTH(32), .REG_WIDTH(64))
	err_log_0_snapshot_reg
		(
		.clk                     (regslv_clk )                               ,
		.rst_n                   (regslv_rstn)                              ,
		.mst__fsm__sync_reset    (global_sync_reset_out)                     ,
		.snap_wr_en              ({err_log_0__snap_1_wr_en,err_log_0__snap_0_wr_en})                              ,
		.snap_rd_en              ({err_log_0__snap_1_rd_en,err_log_0__snap_0_rd_en})                              ,
		.snap_wr_data            ({err_log_0__snap_1_wr_data,err_log_0__snap_0_wr_data})                              ,
		.snap_rd_data            ({err_log_0__snap_1_o,err_log_0__snap_0_o})                              ,
		.reg_wr_en               (err_log_0_snapshot_wr_en)                 ,
		.reg_rd_en               (err_log_0_snapshot_rd_en)                 ,
		.reg_wr_data             (err_log_0_snapshot_wr_data)               ,
		.reg_rd_data             (err_log_0_snapshot_reg_rd_data)           
	);
//***************************************REG/FIELD INSTANCE END***************************************//


endmodule
`default_nettype wire