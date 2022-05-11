`include "xregister.vh"
`default_nettype none
module regmst_reg_top(
//*************************************EXTERNAL MODULE PORT START*************************************//
	// ports of reg_block_1
	reg_block_1_req_vld           ,
	reg_block_1_ack_vld           ,
	reg_block_1_wr_en             ,
	reg_block_1_rd_en             ,
	reg_block_1_addr              ,
	reg_block_1_wr_data           ,
	reg_block_1_rd_data           ,
//**************************************EXTERNAL MODULE PORT END**************************************//


//*************************************INTERNAL FIELD PORT START**************************************//
	// ports of internal regfile
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
	// ports define of reg_block_1
	output             reg_block_1_req_vld           ;
	input              reg_block_1_ack_vld           ;
	output             reg_block_1_wr_en             ;
	output             reg_block_1_rd_en             ;
	output [64-1:0]    reg_block_1_addr              ;
	output [32-1:0]    reg_block_1_wr_data           ;
	input  [32-1:0]    reg_block_1_rd_data           ;
	//ports define of internal regfile
	wire regfile_clk   = fsm_clk   ;
	wire regfile_rstn  = fsm_rstn  ;
//****************************************PORT DECLARATION END****************************************//


//***************************************WIRE DECLARATION START***************************************//
	// declare the handshake signal for fsm
	wire                   slv__fsm__ack_vld		;
	reg                    new_ack_launched		;
	reg                    fsm__slv__req_vld_ff  ;
	wire                   fsm__slv__req_vld_int ;
	reg                    fsm__slv__req_vld     ;
	// signal for fsm
	wire 						fsm__slv__wr_en		;
	wire 						fsm__slv__rd_en		;
	wire [ADDR_WIDTH-1:0] 		fsm__slv__addr		;
	wire [DATA_WIDTH-1:0] 		fsm__slv__wr_data	;
	wire [DATA_WIDTH-1:0]  		slv__fsm__rd_data	;
	// fsm state indicator
	wire				   		cs_is_idle			;
	reg                new_ack_lanuch            ;

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
	wire                                   regfile_rd_ack_vld   ;
	wire                                   regfile_wr_en        ;
	wire                                   regfile_rd_en        ;
	wire [ADDR_WIDTH-1:0]                  regfile_addr         ;
	wire [DATA_WIDTH-1:0]                  regfile_wr_data      ;
	wire [DATA_WIDTH-1:0]                  regfile_rd_data      ;
	// reg_block_1 signal in regslv domain
	wire               reg_block_1_req_vld_fsm   ;
	wire               reg_block_1_ack_vld_fsm   ;
	wire               reg_block_1_wr_en_fsm     ;
	wire               reg_block_1_rd_en_fsm     ;
	wire [64-1:0]      reg_block_1_addr_fsm      ;
	wire [32-1:0]      reg_block_1_wr_data_fsm   ;
	wire [32-1:0]      reg_block_1_rd_data_fsm   ;
	// reg_block_1 signal in ext_mem1 domain
	wire               reg_block_1_req_vld   ;
	wire               reg_block_1_ack_vld   ;
	wire               reg_block_1_wr_en     ;
	wire               reg_block_1_rd_en     ;
	wire [64-1:0]      reg_block_1_addr      ;
	wire [32-1:0]      reg_block_1_wr_data   ;
	wire [32-1:0]      reg_block_1_rd_data   ;
//****************************************WIRE DECLARATION END****************************************//


//***********************************EXTERNAL WIRE CONNECTION START***********************************//
	assign ext_wr_en_fsm   = fsm__slv__wr_en      ;
	assign ext_rd_en_fsm   = fsm__slv__rd_en      ;
	assign ext_addr_fsm    = fsm__slv__addr       ;
	assign ext_wr_data_fsm = fsm__slv__wr_data    ;
	// wire connection of reg_block_1
	assign reg_block_1_req_vld_fsm            =   ext_req_vld_fsm[-1]         ;
	assign ext_ack_vld_fsm[-1]       =   reg_block_1_ack_vld_fsm              ;
	assign reg_block_1_wr_en_fsm              =   ext_wr_en_fsm               ;
	assign reg_block_1_rd_en_fsm              =   ext_rd_en_fsm               ;
	assign reg_block_1_addr_fsm               =   ext_addr_fsm                ;
	assign reg_block_1_wr_data_fsm            =   ext_wr_data_fsm             ;
	assign ext_rd_data_fsm[-1]       =   reg_block_1_rd_data_fsm              ;
	assign ext_req_vld_fsm[-1]       =   ext_sel[-1] & fsm__slv__req_vld_int  ;
	assign ext_ack_fsm[-1]           =   ext_sel[-1] & ext_ack_vld_fsm        ;
//************************************EXTERNAL WIRE CONNECTION END************************************//


//***************************************ADDRESS DECODER START****************************************//
	// global fsm_decoder @regslv domain
	assign global_address   = cs_is_idle ? PADDR : fsm__slv__addr;
	assign ext_selected     = | ext_sel;
	always_comb begin
			int_selected = 1'b0;
			ext_sel = {EXT_NUM{1'b0}};
			none_selected = 1'b0;
		unique casez (global_address)
			64'h0,64'h4,64'h8:ext_sel[0] = 1'b1;//external module reg_block_1
			default: none_selected = 1'b1;
		endcase
	end
	// internal regfile decoder @regfile domain
	always_comb begin
			reg_sel = {REG_NUM{1'b0}};
			dummy_reg = 1'b0;
		unique casez (regfile_addr)
			default: dummy_reg = 1'b1;
		endcase
	end
//****************************************ADDRESS DECODER END*****************************************//


//************************************STATE MACHINE INSTANCE START************************************//
	mst_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
		mst_fsm_reg_top (
		.PCLK(PCLK), .PRESETn(PRESETn), .fsm__slv__req_vld(fsm__slv__req_vld),
		.PADDR(PADDR), .PWRITE(PWRITE), .PSEL(PSEL), .PENABLE(PENABLE),
		.PWDATA(PWDATA), .PRDATA(PRDATA), .PREADY(PREADY), .PSLVERR(PSLVERR),
		.slv__fsm__rd_data(slv__fsm__rd_data), .slv__fsm__ack_vld(slv__fsm__ack_vld),
		.fsm__slv__wr_en(fsm__slv__wr_en), .fsm__slv__rd_en(fsm__slv__rd_en), .fsm__slv__addr(fsm__slv__addr), .fsm__slv__wr_data(fsm__slv__wr_data),
		.external_reg_selected(ext_selected),
		.cs_is_idle(cs_is_idle),		.fsm__slv__sync_reset(global_sync_reset_out),
		.clear(clear), .interrupt(interrupt)
		);
	always@(posedge fsm_clk or negedge fsm_rstn) begin
		if(~fsm_rstn)begin
			new_ack_launched <= 1'b0;
			fsm__slv__req_vld_ff <= 1'b0;
		end
		else begin
			fsm__slv__req_vld_ff <= fsm__slv__req_vld;
			if(fsm__slv__req_vld & ! fsm__slv__req_vld_ff) new_ack_launched <= 1'b0;
			else if(| ext_ack_fsm) new_ack_launched <= 1'b1;
			else new_ack_launched <= 1'b0;
		end
	end

	assign fsm__slv__req_vld_int = fsm__slv__req_vld & !new_ack_launched;
//*************************************STATE MACHINE INSTANCE END*************************************//


//**************************************SPLIT MUX INSTANCE START**************************************//
	// external mux @regslv domain
	split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(M), .GROUP_SIZE(128), .SKIP_DFF_0(0), .SKIP_DFF_1(0)) ext_rd_split_mux
	(.clk(fsm_clk), .rst_n(fsm_rstn),
	.din(ext_rd_data_fsm), .sel(ext_ack_fsm),
	.dout(ext_rd_data_vld_fsm), .dout_vld(ext_reg_ack_vld_fsm)
	);
//***************************************SPLIT MUX INSTANCE END***************************************//


//*****************************************ULTIMATE MUX START*****************************************//
	// select which to read out and transfer the corresponding vld signal @regslv domain
	assign slv__fsm__rd_data = none_selected ? {DATA_WIDTH{1'b0}} : (ext_reg_ack_vld_fsm ? ext_rd_data_vld_fsm : 0);
	assign slv__fsm__ack_vld = none_selected | ext_reg_ack_vld_fsm;
//******************************************ULTIMATE MUX END******************************************//


//******************************EXTERNAL MEMORY SNAPSHOT REGISTER START*******************************//
//*******************************EXTERNAL MEMORY SNAPSHOT REGISTER END********************************//


//*****************************EXTERNAL MEMORY CDC DELIVER INSTANT START******************************//
	assign reg_block_1_req_vld       = reg_block_1_req_vld_fsm    ;
	assign reg_block_1_ack_vld_fsm   = reg_block_1_ack_vld        ;
	assign reg_block_1_wr_en         = reg_block_1_wr_en_fsm      ;
	assign reg_block_1_rd_en         = reg_block_1_rd_en_fsm      ;
	assign reg_block_1_addr          = reg_block_1_addr_fsm       ;
	assign reg_block_1_wr_data       = reg_block_1_wr_data_fsm    ;
	assign reg_block_1_rd_data_fsm   = reg_block_1_rd_data        ;
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
//***************************************REG/FIELD INSTANCE END***************************************//


//**************************************REG/FIELD INSTANCE START**************************************//
//***************************************REG/FIELD INSTANCE END***************************************//


endmodule
`default_nettype wire