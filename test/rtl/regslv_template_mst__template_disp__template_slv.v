`include "xregister.vh"
`default_nettype none
module regslv_template_mst__template_disp__template_slv(
//*************************************INTERNAL FIELD PORT START**************************************//
	// ports of internal regfile
	// ports of ['TEM1', 'FIELD_3']
	TEM1__FIELD_3__next_value        ,
	TEM1__FIELD_3__pulse             ,
	TEM1__FIELD_3__curr_value        ,
	// ports of ['TEM1', 'FIELD_2']
	TEM1__FIELD_2__next_value        ,
	TEM1__FIELD_2__pulse             ,
	TEM1__FIELD_2__curr_value        ,
	// ports of ['TEM1', 'FIELD_1']
	TEM1__FIELD_1__next_value        ,
	TEM1__FIELD_1__pulse             ,
	TEM1__FIELD_1__curr_value        ,
	srst_10        ,
//**************************************INTERNAL FIELD PORT END***************************************//


//****************************************STANDARD PORT START*****************************************//
	clk                 ,
	rstn                ,
	req_vld                 ,
	ack_vld                 ,
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
	localparam                 N = 2                    ;
	localparam                 REG_NUM = N ? N : 1      ;
//**************************************PARAMETER DEFINITION END**************************************//


//***************************************PORT DECLARATION START***************************************//
	// dispatch domain @clk
	input                         clk                 ;
	input                         rst_n                ;
	input                         req_vld                 ;
	output                        ack_vld                 ;
	input                         wr_en                   ;
	input                         rd_en                   ;
	input     [ADDR_WIDTH-1:0]    addr                    ;
	input     [DATA_WIDTH-1:0]    wr_data                 ;
	output    [DATA_WIDTH-1:0]    rd_data                 ;
	input                         soft_rst_i              ;
	wire regslv_clk     = clk           ;
	wire regslv_rstn    = rst_n          ;
	//ports define of internal regfile
	// ports of ['TEM1', 'FIELD_3']
	input  [1-1:0]    TEM1__FIELD_3__next_value        ;
	input              TEM1__FIELD_3__pulse             ;
	output [1-1:0]    TEM1__FIELD_3__curr_value        ;
	// ports of ['TEM1', 'FIELD_2']
	input  [3-1:0]    TEM1__FIELD_2__next_value        ;
	input              TEM1__FIELD_2__pulse             ;
	output [3-1:0]    TEM1__FIELD_2__curr_value        ;
	// ports of ['TEM1', 'FIELD_1']
	input  [1-1:0]    TEM1__FIELD_1__next_value        ;
	input              TEM1__FIELD_1__pulse             ;
	output [1-1:0]    TEM1__FIELD_1__curr_value        ;
	input 	srst_10        ;
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
	wire                                   soft_rst_i_fsm      ;

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

	logic [31:0] TEM1_wr_data;
	logic TEM1_wr_en;
	logic TEM1_rd_en;

	logic [31:0] TEM2_wr_data;
	logic TEM2_wr_en;
	logic TEM2_rd_en;

//****************************************WIRE DECLARATION END****************************************//


//***************************************ADDRESS DECODER START****************************************//
	// internal regfile decoder @regfile domain
	always_comb begin
			reg_sel = {REG_NUM{1'b0}};
			dummy_reg = 1'b0;
		unique casez (regfile_addr)
			64'h0:reg_sel[0] = 1'b1;//['TEM1']
			64'h4:reg_sel[1] = 1'b1;//['TEM2']
			default: dummy_reg = 1'b1;
		endcase
	end
//****************************************ADDRESS DECODER END*****************************************//


//************************************STATE MACHINE INSTANCE START************************************//
	slv_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
		slv_fsm_template_mst__template_disp__template_slv (
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
		.mst__fsm__sync_reset(soft_rst_i_fsm),
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
	assign req_vld_fsm      = req_vld        ;
	assign ack_vld          = ack_vld_fsm    ;
	assign wr_en_fsm        = wr_en          ;
	assign rd_en_fsm        = rd_en          ;
	assign addr_fsm         = addr           ;
	assign wr_data_fsm      = wr_data        ;
	assign rd_data          = rd_data_fsm    ;
	assign soft_rst_i_fsm = soft_rst_i;
//***********************************REGSLV CDC DELIVER INSTANT END***********************************//


//**************************************REG/FIELD INSTANCE START**************************************//
	//============================================REG INSTANT=============================================//
	//REG NAME: TEM1//
	//REG HIERARCHY: ['TEM1']//
	//REG ABSOLUTE_ADDR:64'h0//
	//REG OFFSET_ADDR:64'h0//
	logic [31:0] TEM1_o;
	assign TEM1_wr_data = wr_sel[0] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign TEM1_wr_en = wr_sel[0];
	assign TEM1_rd_en = rd_sel[0];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`WOT,`WOT}),
		.HW_TYPE               (`HW_SET),
		.PRECEDENCE            (`SW)
		)
	x__TEM1__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rstn),
		.sync_rst                (1'b0),
		.sw_wr_data            ({TEM1_wr_data[13:13],TEM2_wr_data[13:13]}),
		.sw_rd                 ({TEM1_rd_en,TEM2_rd_en}),
		.sw_wr                 ({TEM1_wr_en,TEM2_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (TEM1__FIELD_3__next_value),
		.hw_pulse              (TEM1__FIELD_3__pulse),
		.field_value           (TEM1__FIELD_3__curr_value)
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
		.HW_TYPE               (`HW_CLR),
		.PRECEDENCE            (`SW)
		)
	x__TEM1__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rstn),
		.sync_rst                (1'b0),
		.sw_wr_data            ({TEM1_wr_data[16:14],TEM2_wr_data[16:14]}),
		.sw_rd                 ({TEM1_rd_en,TEM2_rd_en}),
		.sw_wr                 ({TEM1_wr_en,TEM2_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (TEM1__FIELD_2__next_value),
		.hw_pulse              (TEM1__FIELD_2__pulse),
		.field_value           (TEM1__FIELD_2__curr_value)
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
	x__TEM1__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rstn),
		.sync_rst              ({srst_10,srst_10}),
		.sw_wr_data            ({TEM1_wr_data[17:17],TEM2_wr_data[17:17]}),
		.sw_rd                 ({TEM1_rd_en,TEM2_rd_en}),
		.sw_wr                 ({TEM1_wr_en,TEM2_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (TEM1__FIELD_1__next_value),
		.hw_pulse              (TEM1__FIELD_1__pulse),
		.field_value           (TEM1__FIELD_1__curr_value)
		);
	always_comb begin
		TEM1_o[31:0] = 32'h0;
		TEM1_o[13:13] = TEM1__FIELD_3__curr_value;
		TEM1_o[16:14] = TEM1__FIELD_2__curr_value;
		TEM1_o[17:17] = TEM1__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[0] = TEM1_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: TEM2//
	//REG HIERARCHY: ['TEM2']//
	//REG ABSOLUTE_ADDR:64'h4//
	//REG OFFSET_ADDR:64'h4//
	logic [31:0] TEM2_o;
	assign TEM2_wr_data = wr_sel[1] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign TEM2_wr_en = wr_sel[1];
	assign TEM2_rd_en = rd_sel[1];
	always_comb begin
		TEM2_o[31:0] = 32'h0;
		TEM2_o[13:13] = TEM1__FIELD_3__curr_value;
		TEM2_o[16:14] = TEM1__FIELD_2__curr_value;
		TEM2_o[17:17] = TEM1__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[1] = TEM2_o;
//***************************************REG/FIELD INSTANCE END***************************************//


//**************************************REG/FIELD INSTANCE START**************************************//
//***************************************REG/FIELD INSTANCE END***************************************//


endmodule
`default_nettype wire