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
	localparam                 N = 0                    ;
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
	assign ext_req_vld      = fsm__slv__req_vld           ;
	assign ext_wr_en        = fsm__slv__wr_en             ;
	assign ext_rd_en        = fsm__slv__rd_en             ;
	assign ext_addr         = fsm__slv__addr              ;
	assign ext_wr_data      = fsm__slv__wr_data           ;
//****************************************WIRE DECLARATION END****************************************//


//***************************************ADDRESS DECODER START****************************************//
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
//***************************************SPLIT MUX INSTANCE END***************************************//


//*****************************************ULTIMATE MUX START*****************************************//
	// select which to read out and transfer the corresponding vld signal @regslv domain
	assign slv__fsm__rd_data = (ext_ack_vld ? ext_rd_data : 0);
	assign slv__fsm__ack_vld = ext_ack_vld;
//******************************************ULTIMATE MUX END******************************************//


//**************************************REG/FIELD INSTANCE START**************************************//
//***************************************REG/FIELD INSTANCE END***************************************//


//**************************************REG/FIELD INSTANCE START**************************************//
//***************************************REG/FIELD INSTANCE END***************************************//


endmodule
`default_nettype wire