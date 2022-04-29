`include "xregister.vh"
module regslv_reg_top__reg_block_1(
//*************************************EXTERNAL MODULE PORT START*************************************//
	ext_mem_1_req_vld,
	ext_mem_1_req_rdy,
	ext_mem_1_wr_en,ext_mem_1_rd_en,
	ext_mem_1_addr,
	ext_mem_1_wr_data,
	ext_mem_1_ack_vld,
	ext_mem_1_ack_rdy,
	ext_mem_1_rd_data,
//**************************************EXTERNAL MODULE PORT END**************************************//

//*************************************INTERNAL FIELD PORT START**************************************//
	//['REG1', 'FIELD_0']
	REG1__FIELD_0__next_value,
	REG1__FIELD_0__pulse,
	REG1__FIELD_0__curr_value,
//**************************************INTERNAL FIELD PORT END***************************************//

//****************************************STANDARD PORT START*****************************************//
	clk                          ,
	rstn                         ,
	req_vld                      ,
	req_rdy                      ,
	wr_en,rd_en                  ,
	addr                         ,
	wr_data                      ,
	ack_vld                      ,
	ack_rdy                      ,
	rd_data                      ,
	cdc_pulse_out                     ,
	global_sync_reset_in          ,
	global_sync_reset_out             
//*****************************************STANDARD PORT END******************************************//

);
//*************************************PARAMETER DEFINITION START*************************************//
	parameter                  ADDR_WIDTH = 64          ;
	parameter                  DATA_WIDTH = 32          ;
	//N:number of internal registers, M:number of external modules
	localparam                 N = 2                   ;
	localparam                 M = 1                   ;
	localparam                 REG_NUM = N ? N :1       ;
	localparam                 EXT_NUM = M ? M :1       ;
//**************************************PARAMETER DEFINITION END**************************************//


//***************************************WIRE DECLARATION START***************************************//
	input                      clk                     ;
	input                      rstn                    ;
	input                      req_vld                 ;
	output                     req_rdy                 ;
	input                      wr_en                   ;
	input                      rd_en                   ;
	input [ADDR_WIDTH-1:0]     addr                    ;
	input [DATA_WIDTH-1:0]     wr_data                 ;
	output [DATA_WIDTH-1:0]    rd_data                 ;
	input                      global_sync_reset_in    ;
	output                     global_sync_reset_out   ;
	output                     ack_vld                 ;
	input                      ack_rdy                 ;
	//declare the syn_rst
	output                     ext_mem_1_req_vld              ;
	input                      ext_mem_1_req_rdy              ;
	output                     ext_mem_1_wr_en,ext_mem_1_rd_en       ;
	output                     ext_mem_1_addr                 ;
	output                     ext_mem_1_wr_data              ;
	input                      ext_mem_1_ack_vld              ;
	output                     ext_mem_1_ack_rdy              ;
	input                      ext_mem_1_rd_data              ;
	output                     cdc_pulse_out;
//****************************INTERNAL REGISTER IN/OUT PORTS DEFINE START*****************************//
	//['REG1', 'FIELD_0']
	input [64-1:0] REG1__FIELD_0__next_value;
	input REG1__FIELD_0__pulse;
	output [64-1:0] REG1__FIELD_0__curr_value;
	//declare the portwidth of external module
	wire [EXT_NUM-1:0]                     ext_req_vld     ;
	wire [EXT_NUM-1:0]                     ext_req_rdy     ;
	wire                                   ext_wr_en       ;
	wire                                   ext_rd_en       ;
	wire [ADDR_WIDTH-1:0]                  ext_addr        ;
	wire [DATA_WIDTH-1:0]                  ext_wr_data     ;
	wire [EXT_NUM-1:0] [DATA_WIDTH-1:0]    ext_rd_data     ;
	wire [EXT_NUM-1:0]                     ext_ack_vld     ;
	wire                                   ext_ack_rdy     ;
//*****************************INTERNAL REGISTER IN/OUT PORTS DEFINE END******************************//

	//declare the portwidth of external registers
	logic [EXT_NUM-1:0] ext_sel;
	wire external_reg_selected;
	assign external_reg_selected = |ext_sel;
	wire [DATA_WIDTH-1:0] ext_rd_data_vld;
	wire ext_reg_ack_vld;
	wire[EXT_NUM-1:0] ext_ack;
	//declare the portwidth of internal registers
	logic [REG_NUM-1:0] reg_sel;
	logic dummy_reg;
	wire internal_reg_selected;
	assign internal_reg_selected = (|reg_sel) | dummy_reg;
	wire [REG_NUM-1:0] [DATA_WIDTH-1:0] reg_rd_data_in;
	wire [DATA_WIDTH-1:0] internal_reg_rd_data_vld;
	wire internal_reg_ack_vld;
	//declare the control signal for external registers
	wire fsm__slv__wr_en ;
	wire fsm__slv__rd_en;
	wire [ADDR_WIDTH-1:0] fsm__slv__addr;
	wire [DATA_WIDTH-1:0] fsm__slv__wr_data;
	wire [DATA_WIDTH-1:0]  slv__fsm__rd_data;
	//declare the handshake signal for fsm
	wire                   slv__fsm__ack_vld;
	wire                   fsm__slv__req_vld;
	wire                   slv__fsm__req_rdy;
	assign slv__fsm__req_rdy = |{ext_req_rdy&ext_sel,internal_reg_selected};
	//declare the control signal for internal registers
	wire [ADDR_WIDTH-1:0] addr_for_decode;
	assign addr_for_decode = fsm__slv__addr;
	wire [DATA_WIDTH-1:0] internal_wr_data;
	assign internal_wr_data = fsm__slv__wr_data;
	wire internal_wr_en;
	assign internal_wr_en = fsm__slv__wr_en;
	wire internal_rd_en;
	assign internal_rd_en = fsm__slv__rd_en;
	wire [REG_NUM-1:0] wr_sel;
	wire [REG_NUM-1:0] rd_sel;
	assign wr_sel = {REG_NUM{internal_wr_en}} & reg_sel;
	assign rd_sel = {REG_NUM{internal_rd_en}} & reg_sel;
//****************************************WIRE DECLARATION END****************************************//

	wire            ext_mem_1_snapshot_wr_en     ;
	wire            ext_mem_1_snapshot_rd_en     ;
	wire [64-1:0]   ext_mem_1_snapshot_addr      ;
	wire [32-1:0]   ext_mem_1_snapshot_wr_data   ;
	wire [32-1:0]   ext_mem_1_snapshot_rd_data   ;
	wire            ext_mem_1_snapshot_req_vld   ;
	wire            ext_mem_1_snapshot_req_rdy   ;
	wire            ext_mem_1_snapshot_ack_vld   ;
	wire            ext_mem_1_wr_en     ;
	wire            ext_mem_1_rd_en     ;
	wire [1-1:0]   ext_mem_1_addr      ;
	wire [128-1:0]   ext_mem_1_wr_data   ;
	wire [128-1:0]   ext_mem_1_rd_data   ;
	wire            ext_mem_1_req_vld   ;
	wire            ext_mem_1_req_rdy   ;
	wire            ext_mem_1_ack_vld   ;
	wire            ext_mem_1_wr_en_int     ;
	wire            ext_mem_1_rd_en_int     ;
	wire [1-1:0]   ext_mem_1_addr_int      ;
	wire [128-1:0]   ext_mem_1_wr_data_int   ;
	wire [128-1:0]   ext_mem_1_rd_data_int   ;
	wire            ext_mem_1_req_vld_int   ;
	wire            ext_mem_1_req_rdy_int   ;
	wire            ext_mem_1_ack_vld_int   ;


//*********************************EXTERNAL CONNECTION INSTANT START**********************************//
	assign ext_wr_en   = fsm__slv__wr_en;
	assign ext_rd_en   = fsm__slv__rd_en;
	assign ext_addr    = fsm__slv__addr;
	assign ext_wr_data = fsm__slv__wr_data;
	assign ext_mem_1_wr_en       =   ext_mem_1_wr_en_int        ;
	assign ext_mem_1_rd_en       =   ext_mem_1_rd_en_int        ;
	assign ext_mem_1_addr        =   ext_mem_1_addr_int         ;
	assign ext_mem_1_wr_data     =   ext_mem_1_wr_data_int      ;
	assign ext_mem_1_rd_data_int =   ext_mem_1_rd_data          ;
	assign ext_mem_1_req_vld     =   ext_mem_1_req_vld_int      ;
	assign ext_mem_1_req_rdy_int =   ext_mem_1_req_rdy          ;
	assign ext_mem_1_ack_vld_int =   ext_mem_1_ack_vld          ;
	assign ext_mem_1_snapshot_wr_en        = ext_wr_en             ;
	assign ext_mem_1_snapshot_rd_en        = ext_rd_en             ;
	assign ext_mem_1_snapshot_addr         = ext_addr              ;
	assign ext_mem_1_snapshot_wr_data      = ext_wr_data           ;
	assign ext_rd_data[0]          = ext_mem_1_snapshot_rd_data   ;
	assign ext_mem_1_snapshot_req_vld      = ext_req_vld[0]       ;
	assign ext_req_rdy[0]          = ext_mem_1_snapshot_req_rdy   ;
	assign ext_ack_vld[0]          = ext_mem_1_snapshot_ack_vld   ;
	//ext_mem_1 connection, external[0];
	assign ext_req_vld[0] = ext_sel[0] & fsm__slv__req_vld;
	assign ext_ack[0] = ext_ack_vld[0] & ext_sel[0];
//**********************************EXTERNAL CONNECTION INSTANT END***********************************//


//**********************************RD_DATA/ACK_VLD SPLIT MUX START***********************************//
	split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(N+1), .GROUP_SIZE(64)) rd_split_mux
	(.clk(clk), .rst_n(rstn),
	.din({reg_rd_data_in,{DATA_WIDTH{1'b0}}}), .sel({rd_sel, !req_rdy & dummy_reg}),
	.dout(internal_reg_rd_data_vld), .dout_vld(internal_reg_ack_vld)
	);
	split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(M), .GROUP_SIZE(64)) ext_rd_split_mux
	(.clk(clk), .rst_n(rstn),
	.din(ext_rd_data), .sel(ext_ack),
	.dout(ext_rd_data_vld), .dout_vld(ext_reg_ack_vld)
	);
//***********************************RD_DATA/ACK_VLD SPLIT MUX END************************************//


//********************************FINAL SPLIT MUX OUT DEFINITION START********************************//
	// select which to read out and transfer the corresponding vld signal
	assign slv__fsm__rd_data = internal_reg_ack_vld ? internal_reg_rd_data_vld : (ext_reg_ack_vld ? ext_rd_data_vld : 0);
	assign slv__fsm__ack_vld = internal_reg_ack_vld | ext_reg_ack_vld | (internal_wr_en & internal_reg_selected);
//*********************************FINAL SPLIT MUX OUT DEFINITION END*********************************//


//*********************************INTERNAL REG WIRE DEFINITION START*********************************//
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
//**********************************INTERNAL REG WIRE DEFINITION END**********************************//


//***************************************ADDRESS DECODER START****************************************//
	always_comb begin
			reg_sel = {REG_NUM{1'b0}};
			ext_sel = {EXT_NUM{1'b0}};
			dummy_reg = 1'b0;
		unique casez (addr_for_decode)
			64'h0:reg_sel[0] = 1'b1;//['REG1', '_snap_0']
			64'h4:reg_sel[1] = 1'b1;//['REG1', '_snap_1']
			64'h2?,64'h3?:ext_sel[0] = 1'b1;//external module ext_mem_1
			default: dummy_reg = 1'b1;
		endcase
	end
//****************************************ADDRESS DECODER END*****************************************//


//************************************STATE MACHINE INSTANCE START************************************//
	slv_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
		slv_fsm_reg_top__reg_block_1 (
		.clk(clk), .rstn(rstn), .mst__fsm__req_vld(req_vld), .mst__fsm__wr_en(wr_en), .mst__fsm__rd_en(rd_en), .mst__fsm__addr(addr), .mst__fsm__wr_data(wr_data),
		.slv__fsm__rd_data(slv__fsm__rd_data), .slv__fsm__ack_vld(slv__fsm__ack_vld), .fsm__slv__req_vld(fsm__slv__req_vld),
		.fsm__slv__wr_en(fsm__slv__wr_en), .fsm__slv__rd_en(fsm__slv__rd_en), .fsm__slv__addr(fsm__slv__addr), .fsm__slv__wr_data(fsm__slv__wr_data),
		.fsm__mst__req_rdy(req_rdy), .mst__fsm__ack_rdy(ack_rdy),
		.slv__fsm__req_rdy(slv__fsm__req_rdy), .fsm__slv__ack_rdy(ext_ack_rdy),
		.fsm__mst__rd_data(rd_data), .fsm__mst__ack_vld(ack_vld),
		.external_reg_selected(external_reg_selected),
		.cdc_pulse_out(cdc_pulse_out),		.mst__fsm__sync_reset(global_sync_reset_in),
		.fsm__slv__sync_reset(global_sync_reset_out)
	);
//*************************************STATE MACHINE INSTANCE END*************************************//


//**************************************REG/FIELD INSTANCE START**************************************//
	//============================================REG INSTANT=============================================//
	//REG NAME: REG1__snap_0//
	//REG HIERARCHY: ['REG1', '_snap_0']//
	//REG ABSOLUTE_ADDR:64'h0//
	//REG OFFSET_ADDR:64'h64'h0//
	logic [31:0] REG1__snap_0_o;
	assign REG1__snap_0_wr_data = wr_sel[0] ? internal_wr_data : 0;
	assign REG1__snap_0_wr_en = wr_sel[0];
	assign REG1__snap_0_rd_en = rd_sel[0];
	assign reg_rd_data_in[0] = REG1__snap_0_o;
	//==========================================END REG INSTANT===========================================//
	//============================================REG INSTANT=============================================//
	//REG NAME: REG1__snap_1//
	//REG HIERARCHY: ['REG1', '_snap_1']//
	//REG ABSOLUTE_ADDR:64'h4//
	//REG OFFSET_ADDR:64'h64'h0//
	logic [31:0] REG1__snap_1_o;
	assign REG1__snap_1_wr_data = wr_sel[1] ? internal_wr_data : 0;
	assign REG1__snap_1_wr_en = wr_sel[1];
	assign REG1__snap_1_rd_en = rd_sel[1];
	assign reg_rd_data_in[1] = REG1__snap_1_o;
	//==========================================END REG INSTANT===========================================//
//***************************************REG/FIELD INSTANCE END***************************************//

//**********************************INTERNAL SNAPSHOT REGISTER START**********************************//
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
		.clk                   (clk),
		.rst_n                 (rstn),
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
	//snapshot_register instance
	snapshot_reg
		#(.DATA_WIDTH(32), .REG_WIDTH(64))
	REG1_snapshot_reg
		(
		.clk                     (clk)                               ,
		.rst_n                   (rstn)                              ,
		.snap_wr_en              ({REG1__snap_1_wr_en,REG1__snap_0_wr_en})                              ,
		.snap_rd_en              ({REG1__snap_1_rd_en,REG1__snap_0_rd_en})                              ,
		.snap_wr_data            ({REG1__snap_1_wr_data,REG1__snap_0_wr_data})                              ,
		.snap_rd_data            ({REG1__snap_1_o,REG1__snap_0_o})                              ,
		.reg_wr_en               (REG1_snapshot_wr_en)                 ,
		.reg_rd_en               (REG1_snapshot_rd_en)                 ,
		.reg_wr_data             (REG1_snapshot_wr_data)               ,
		.reg_rd_data             (REG1_snapshot_reg_rd_data)           
	);
//**********************************INTERNAL SNAPSHOT REGISTER START**********************************//


//******************************EXTERNAL MEMORY SNAPSHOT REGISTER START*******************************//
	snapshot_reg_mem
		#(.DATA_WIDTH(32), .MEM_WIDTH(128), .SUB(0),	.ADDR_WIDTH(64), .VALID_WIDTH(5), .ENTRY_WIDTH(1))
	ext_mem_1_snapshot_reg_mem
		(
		.clk                     (clk)                               ,
		.rst_n                   (rstn)                              ,
		.addr                    (ext_mem_1_snapshot_addr)                  ,
		.wr_en                   (ext_mem_1_snapshot_wr_en)                 ,
		.rd_en                   (ext_mem_1_snapshot_rd_en)                 ,
		.wr_data                 (ext_mem_1_snapshot_wr_data)               ,
		.rd_data                 (ext_mem_1_snapshot_rd_data)               ,
		.req_vld                 (ext_mem_1_snapshot_req_vld)               ,
		.req_rdy                 (ext_mem_1_snapshot_req_rdy)               ,
		.ack_vld                 (ext_mem_1_snapshot_ack_vld)               ,
		.entry_write_protect_en  (1'b0)                             ,
		.entry_vld               (1'b1)                             ,
		.entry_vld_nxt           ()                                  ,
		.mem_addr                (ext_mem_1_addr_int)                           ,
		.mem_wr_en               (ext_mem_1_wr_en_int)                          ,
		.mem_rd_en               (ext_mem_1_rd_en_int)                          ,
		.mem_wr_data             (ext_mem_1_wr_data_int)                        ,
		.mem_rd_data             (ext_mem_1_rd_data_int)                        ,
		.mem_req_vld             (ext_mem_1_req_vld_int)                        ,
		.mem_req_rdy             (ext_mem_1_req_rdy_int)                        ,
		.mem_ack_vld             (ext_mem_1_ack_vld_int)                        
	);
//*******************************EXTERNAL MEMORY SNAPSHOT REGISTER END********************************//
endmodule