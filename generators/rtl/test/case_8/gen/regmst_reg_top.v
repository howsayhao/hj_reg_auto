`include "xregister.vh"
module regmst_reg_top(
//*************************************EXTERNAL MODULE PORT START*************************************//
	reg_top__reg_block_1_req_vld,
	reg_top__reg_block_1_req_rdy,
	reg_top__reg_block_1_wr_en,reg_top__reg_block_1_rd_en,
	reg_top__reg_block_1_addr,
	reg_top__reg_block_1_wr_data,
	reg_top__reg_block_1_ack_vld,
	reg_top__reg_block_1_ack_rdy,
	reg_top__reg_block_1_rd_data,
//**************************************EXTERNAL MODULE PORT END**************************************//

//*************************************INTERNAL FIELD PORT START**************************************//
//**************************************INTERNAL FIELD PORT END***************************************//

//****************************************STANDARD PORT START*****************************************//
	clk                          ,
	rstn                         ,
	PSEL                         ,
	PENABLE                      ,
	PREADY                       ,
	PWRITE                       ,
	PSLVERR                      ,
	PADDR                        ,
	PWDATA                       ,
	PRDATA                       ,
	cdc_pulse_out                     ,
	interrupt                     ,
	clear                         ,
	global_sync_reset_out             
//*****************************************STANDARD PORT END******************************************//

);
//*************************************PARAMETER DEFINITION START*************************************//
	parameter                  ADDR_WIDTH = 64          ;
	parameter                  DATA_WIDTH = 32          ;
	//N:number of internal registers, M:number of external modules
	localparam                 N = 0                   ;
	localparam                 M = 1                   ;
	localparam                 REG_NUM = N ? N :1       ;
	localparam                 EXT_NUM = M ? M :1       ;
//**************************************PARAMETER DEFINITION END**************************************//


//***************************************WIRE DECLARATION START***************************************//
	input                      clk                     ;
	input                      rstn                    ;
	input                      PSEL                    ;
	input                      PENABLE                 ;
	output                     PREADY                  ;
	input                      PWRITE                  ;
	output                     PSLVERR                 ;
	input [ADDR_WIDTH-1:0]     PADDR                   ;
	input [DATA_WIDTH-1:0]     PWDATA                  ;
	output [DATA_WIDTH-1:0]    PRDATA                  ;
	output                     global_sync_reset_out   ;
	input                      clear                   ;
	output                     interrupt               ;
	//declare the syn_rst
	output                     reg_top__reg_block_1_req_vld              ;
	input                      reg_top__reg_block_1_req_rdy              ;
	output                     reg_top__reg_block_1_wr_en,reg_top__reg_block_1_rd_en       ;
	output                     reg_top__reg_block_1_addr                 ;
	output                     reg_top__reg_block_1_wr_data              ;
	input                      reg_top__reg_block_1_ack_vld              ;
	output                     reg_top__reg_block_1_ack_rdy              ;
	input                      reg_top__reg_block_1_rd_data              ;
	output                     cdc_pulse_out;
//****************************INTERNAL REGISTER IN/OUT PORTS DEFINE START*****************************//
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
	wire req_rdy;
	wire [ADDR_WIDTH-1:0] addr_for_decode;
	assign addr_for_decode = fsm__slv__addr;// req_rdy = 1 : fsm_state in S_SETUP for internal operation
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

	wire            reg_top__reg_block_1_wr_en     ;
	wire            reg_top__reg_block_1_rd_en     ;
	wire [64-1:0]   reg_top__reg_block_1_addr      ;
	wire [32-1:0]   reg_top__reg_block_1_wr_data   ;
	wire [32-1:0]   reg_top__reg_block_1_rd_data   ;
	wire            reg_top__reg_block_1_req_vld   ;
	wire            reg_top__reg_block_1_req_rdy   ;
	wire            reg_top__reg_block_1_ack_vld   ;


//*********************************EXTERNAL CONNECTION INSTANT START**********************************//
	assign ext_wr_en   = fsm__slv__wr_en;
	assign ext_rd_en   = fsm__slv__rd_en;
	assign ext_addr    = fsm__slv__addr;
	assign ext_wr_data = fsm__slv__wr_data;
	assign reg_top__reg_block_1_wr_en                 = ext_wr_en             ;
	assign reg_top__reg_block_1_rd_en                 = ext_rd_en             ;
	assign reg_top__reg_block_1_addr                  = ext_addr              ;
	assign reg_top__reg_block_1_wr_data = ext_wr_data                         ;
	assign ext_rd_data[0]          = reg_top__reg_block_1_rd_data            ;
	assign reg_top__reg_block_1_req_vld               = ext_req_vld[0]       ;
	assign ext_req_rdy[0]          = reg_top__reg_block_1_req_rdy            ;
	assign ext_ack_vld[0]          = reg_top__reg_block_1_ack_vld            ;
	//reg_block_1 connection, external[0];
	assign ext_req_vld[0] = ext_sel[0] & fsm__slv__req_vld;
	assign ext_ack[0] = ext_ack_vld[0] & ext_sel[0];
//**********************************EXTERNAL CONNECTION INSTANT END***********************************//


//**********************************RD_DATA/ACK_VLD SPLIT MUX START***********************************//
	split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(M), .GROUP_SIZE(64)) ext_rd_split_mux
	(.clk(clk), .rst_n(rstn),
	.din(ext_rd_data), .sel(ext_ack),
	.dout(ext_rd_data_vld), .dout_vld(ext_reg_ack_vld)
	);
//***********************************RD_DATA/ACK_VLD SPLIT MUX END************************************//


//********************************FINAL SPLIT MUX OUT DEFINITION START********************************//
	// select which to read out and transfer the corresponding vld signal
	assign slv__fsm__rd_data = dummy_reg ? {DATA_WIDTH{1'b0}} : (ext_reg_ack_vld ? ext_rd_data_vld : 0);
	assign slv__fsm__ack_vld = dummy_reg | ext_reg_ack_vld;
//*********************************FINAL SPLIT MUX OUT DEFINITION END*********************************//


//*********************************INTERNAL REG WIRE DEFINITION START*********************************//
//**********************************INTERNAL REG WIRE DEFINITION END**********************************//


//***************************************ADDRESS DECODER START****************************************//
	always_comb begin
			reg_sel = {REG_NUM{1'b0}};
			ext_sel = {EXT_NUM{1'b0}};
			dummy_reg = 1'b0;
		unique casez (addr_for_decode)
			64'h0,64'h4,64'h2?,64'h3?:ext_sel[0] = 1'b1;//external module reg_block_1
			default: dummy_reg = 1'b1;
		endcase
	end
//****************************************ADDRESS DECODER END*****************************************//


//************************************STATE MACHINE INSTANCE START************************************//
	mst_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
		mst_fsm_reg_top (
		.clk(clk), .rstn(rstn), .fsm__slv__req_vld(fsm__slv__req_vld),
		.PADDR(PADDR), .PWRITE(PWRITE), .PSEL(PSEL), .PENABLE(PENABLE),
		.PWDATA(PWDATA), .PRDATA(PRDATA), .PREADY(PREADY), .PSLVERR(PSLVERR),
		.slv__fsm__rd_data(slv__fsm__rd_data), .slv__fsm__ack_vld(slv__fsm__ack_vld),
		.fsm__slv__wr_en(fsm__slv__wr_en), .fsm__slv__rd_en(fsm__slv__rd_en), .fsm__slv__addr(fsm__slv__addr), .fsm__slv__wr_data(fsm__slv__wr_data),
		.fsm__mst__req_rdy(req_rdy),
		.slv__fsm__req_rdy(slv__fsm__req_rdy), .fsm__slv__ack_rdy(ext_ack_rdy),
		.external_reg_selected(external_reg_selected),
		.cdc_pulse_out(cdc_pulse_out),		.fsm__slv__sync_reset(global_sync_reset_out),
		.clear(clear), .interrupt(interrupt)
		);
//*************************************STATE MACHINE INSTANCE END*************************************//


//**************************************REG/FIELD INSTANCE START**************************************//
//***************************************REG/FIELD INSTANCE END***************************************//

//**********************************INTERNAL SNAPSHOT REGISTER START**********************************//
//**********************************INTERNAL SNAPSHOT REGISTER START**********************************//


endmodule