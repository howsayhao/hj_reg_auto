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
	// ports of ['test_map_2_inst', 'shared_2', 'FIELD_2']
	test_map_2_inst_shared_2__FIELD_2__next_value        ,
	test_map_2_inst_shared_2__FIELD_2__pulse             ,
	test_map_2_inst_shared_2__FIELD_2__curr_value        ,
	// ports of ['test_map_2_inst', 'shared_2', 'FIELD_1']
	test_map_2_inst_shared_2__FIELD_1__next_value        ,
	test_map_2_inst_shared_2__FIELD_1__pulse             ,
	test_map_2_inst_shared_2__FIELD_1__curr_value        ,
	// ports of ['reg_t', 'f']
	reg_t__f__next_value        ,
	reg_t__f__pulse             ,
	reg_t__f__curr_value        ,
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
	localparam                 M = 2                    ;
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
	// ports of ['test_map_2_inst', 'shared_2', 'FIELD_2']
	input  [2-1:0]    test_map_2_inst_shared_2__FIELD_2__next_value        ;
	input              test_map_2_inst_shared_2__FIELD_2__pulse             ;
	output [2-1:0]    test_map_2_inst_shared_2__FIELD_2__curr_value        ;
	// ports of ['test_map_2_inst', 'shared_2', 'FIELD_1']
	input  [3-1:0]    test_map_2_inst_shared_2__FIELD_1__next_value        ;
	input              test_map_2_inst_shared_2__FIELD_1__pulse             ;
	output [3-1:0]    test_map_2_inst_shared_2__FIELD_1__curr_value        ;
	// ports of ['reg_t', 'f']
	input  [32-1:0]    reg_t__f__next_value        ;
	input              reg_t__f__pulse             ;
	output [32-1:0]    reg_t__f__curr_value        ;
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

	logic [31:0] test_map_2_inst_shared_2_wr_data;
	logic test_map_2_inst_shared_2_wr_en;
	logic test_map_2_inst_shared_2_rd_en;

	logic [31:0] test_map_3_inst_shared_3_wr_data;
	logic test_map_3_inst_shared_3_wr_en;
	logic test_map_3_inst_shared_3_rd_en;

	logic [31:0] reg_t_wr_data;
	logic reg_t_wr_en;
	logic reg_t_rd_en;

//****************************************WIRE DECLARATION END****************************************//


//***************************************ADDRESS DECODER START****************************************//
	// internal regfile decoder @regfile domain
	always_comb begin
			reg_sel = {REG_NUM{1'b0}};
			dummy_reg = 1'b0;
		unique casez (regfile_addr)
			64'h118:reg_sel[0] = 1'b1;//['test_map_2_inst', 'shared_2']
			64'h11c:reg_sel[1] = 1'b1;//['test_map_3_inst', 'shared_3']
			64'h310:reg_sel[2] = 1'b1;//['reg_t']
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
	//REG NAME: test_map_2_inst_shared_2//
	//REG HIERARCHY: ['test_map_2_inst', 'shared_2']//
	//REG ABSOLUTE_ADDR:64'h118//
	//REG OFFSET_ADDR:64'h0//
	logic [31:0] test_map_2_inst_shared_2_o;
	assign test_map_2_inst_shared_2_wr_data = wr_sel[0] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
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
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rstn),
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
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rstn),
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
	//REG OFFSET_ADDR:64'h0//
	logic [31:0] test_map_3_inst_shared_3_o;
	assign test_map_3_inst_shared_3_wr_data = wr_sel[1] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign test_map_3_inst_shared_3_wr_en = wr_sel[1];
	assign test_map_3_inst_shared_3_rd_en = rd_sel[1];
	always_comb begin
		test_map_3_inst_shared_3_o[31:0] = 32'h0;
		test_map_3_inst_shared_3_o[13:12] = test_map_2_inst_shared_2__FIELD_2__curr_value;
		test_map_3_inst_shared_3_o[16:14] = test_map_2_inst_shared_2__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[1] = test_map_3_inst_shared_3_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: reg_t//
	//REG HIERARCHY: ['reg_t']//
	//REG ABSOLUTE_ADDR:64'h310//
	//REG OFFSET_ADDR:64'h310//
	logic [31:0] reg_t_o;
	assign reg_t_wr_data = wr_sel[2] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign reg_t_wr_en = wr_sel[2];
	assign reg_t_rd_en = rd_sel[2];
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
	x__reg_t__f
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rstn),
		.sync_rst              (1'b0),
		.sw_wr_data            (reg_t_wr_data[31:0]),
		.sw_rd                 (reg_t_rd_en),
		.sw_wr                 (reg_t_wr_en),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (reg_t__f__next_value),
		.hw_pulse              (reg_t__f__pulse),
		.field_value           (reg_t__f__curr_value)
		);
	always_comb begin
		reg_t_o[31:0] = 32'h0;
		reg_t_o[31:0] = reg_t__f__curr_value;
	end
	assign regfile_reg_rd_data_in[2] = reg_t_o;
//***************************************REG/FIELD INSTANCE END***************************************//


//**************************************REG/FIELD INSTANCE START**************************************//
//***************************************REG/FIELD INSTANCE END***************************************//


endmodule
`default_nettype wire