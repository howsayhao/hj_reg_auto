`define ADDR_WIDTH 7'd64
`define DATA_WIDTH 6'd32
module reg_tree 
(
	//reg_mst interface port
	 input clk
	,input rstn
	,input [`ADDR_WIDTH-1:0]PADDR
	,input PWRITE
	,input PSEL
	,input PENABLE
	,input [`DATA_WIDTH-1:0]PWDATA
	,output [`DATA_WIDTH-1:0]PRDATA
	,output PREADY
	,output PSLVERR
	,input clear
	,input interrupt
	//reg module cdc pulse port
	,output regmst_reg_top_cdc_pulse_out
	,output regslv_reg_top__reg_block_1_cdc_pulse_out
	//field interface port
	//field interface end
	//sync_reset interface start
	//sync_reset interface end
//external IP/memory port declare
	,output regslv_reg_top__reg_block_1__ext_mem_1_req_vld
	,input regslv_reg_top__reg_block_1__ext_mem_1_ack_vld
	,input regslv_reg_top__reg_block_1__ext_mem_1_req_rdy
	,output regslv_reg_top__reg_block_1__ext_mem_1_ack_rdy
	,input [`DATA_WIDTH-1:0]regslv_reg_top__reg_block_1__ext_mem_1_rd_data
//external IP/memory port declare
);
//parameter instance here
//wire definition here
logic [1-1:0] regmst_reg_top_ext_req_vld;
logic [1-1:0] regmst_reg_top_ext_req_rdy;
logic [1-1:0] regmst_reg_top_ext_ack_vld;
logic regmst_reg_top_ext_ack_rdy;
logic [1-1:0] [`DATA_WIDTH-1:0]regmst_reg_top_ext_rd_data;
logic regmst_reg_top_wr_en;
logic regmst_reg_top_rd_en;
logic regmst_reg_top_fsm_sync_reset;
logic [`DATA_WIDTH-1:0]regmst_reg_top_wr_data;
logic [`ADDR_WIDTH-1:0] regmst_reg_top_addr;
logic [1-1:0] regslv_reg_top__reg_block_1_ext_req_vld;
logic [1-1:0] regslv_reg_top__reg_block_1_ext_req_rdy;
logic [1-1:0] regslv_reg_top__reg_block_1_ext_ack_vld;
logic regslv_reg_top__reg_block_1_ext_ack_rdy;
logic [1-1:0] [`DATA_WIDTH-1:0]regslv_reg_top__reg_block_1_ext_rd_data;
logic regslv_reg_top__reg_block_1_wr_en;
logic regslv_reg_top__reg_block_1_rd_en;
logic regslv_reg_top__reg_block_1_fsm_sync_reset;
logic [`DATA_WIDTH-1:0]regslv_reg_top__reg_block_1_wr_data;
logic [`ADDR_WIDTH-1:0] regslv_reg_top__reg_block_1_addr;
//external IP/memory port define
//external: ext_mem_1 ref:regslv_reg_top__reg_block_1  wire connection define
assign regslv_reg_top__reg_block_1__ext_mem_1_req_vld = regslv_reg_top__reg_block_1_ext_req_vld[0];
assign regslv_reg_top__reg_block_1__ext_mem_1_ack_rdy = regslv_reg_top__reg_block_1_ext_ack_rdy;
assign regslv_reg_top__reg_block_1_ext_ack_vld[0] = regslv_reg_top__reg_block_1__ext_mem_1_ack_vld;
assign regslv_reg_top__reg_block_1_ext_req_rdy[0] = regslv_reg_top__reg_block_1__ext_mem_1_req_rdy;
assign regslv_reg_top__reg_block_1_ext_rd_data[0] = regslv_reg_top__reg_block_1__ext_mem_1_rd_data;
//reg module instance here
regmst_reg_top #(.ADDR_WIDTH(`ADDR_WIDTH), .DATA_WIDTH(`DATA_WIDTH))
	regmst_reg_top (
	//APB interface instance
	.clk(clk),.rstn(rstn),.PADDR(PADDR), .PWRITE(PWRITE), .PSEL(PSEL), .PENABLE(PENABLE), .PWDATA(PWDATA), .PRDATA(PRDATA), .PREADY(PREADY), .PSLVERR(PSLVERR)
	,.clear(clear), .interrupt(interrupt)
	//reg_slv downstream interface instance
	,.ext_req_vld(regmst_reg_top_ext_req_vld),.ext_req_rdy(regmst_reg_top_ext_req_rdy),.ext_ack_vld(regmst_reg_top_ext_ack_vld),.ext_ack_rdy(regmst_reg_top_ext_ack_rdy),.ext_rd_data(regmst_reg_top_ext_rd_data)
	,.ext_wr_en(regmst_reg_top_wr_en),.ext_rd_en(regmst_reg_top_rd_en),.ext_wr_data(regmst_reg_top_wr_data),.ext_addr(regmst_reg_top_addr),.cdc_pulse_out(regmst_reg_top_cdc_pulse_out)
	,.global_sync_reset_out(regmst_reg_top_fsm_sync_reset)//field ports instance
	
	);
regslv_reg_top__reg_block_1 #(.ADDR_WIDTH(`ADDR_WIDTH), .DATA_WIDTH(`DATA_WIDTH))
	regslv_reg_top__reg_block_1 (
	//reg_module upstream interface instance
	.clk(clk),.rstn(rstn),.req_vld(regmst_reg_top_ext_req_vld[0]),.req_rdy(regmst_reg_top_ext_req_rdy[0])
	,.wr_en(regmst_reg_top_wr_en),.rd_en(regmst_reg_top_rd_en),.addr(regmst_reg_top_addr),.wr_data(regmst_reg_top_wr_data)
	,.ack_vld(regmst_reg_top_ext_ack_vld[0]),.ack_rdy(regmst_reg_top_ext_ack_rdy),.rd_data(regmst_reg_top_ext_rd_data[0])
	//reg_slv downstream interface instance
	,.ext_req_vld(regslv_reg_top__reg_block_1_ext_req_vld),.ext_req_rdy(regslv_reg_top__reg_block_1_ext_req_rdy),.ext_ack_vld(regslv_reg_top__reg_block_1_ext_ack_vld),.ext_ack_rdy(regslv_reg_top__reg_block_1_ext_ack_rdy),.ext_rd_data(regslv_reg_top__reg_block_1_ext_rd_data)
	,.ext_wr_en(regslv_reg_top__reg_block_1_wr_en),.ext_rd_en(regslv_reg_top__reg_block_1_rd_en),.ext_wr_data(regslv_reg_top__reg_block_1_wr_data),.ext_addr(regslv_reg_top__reg_block_1_addr),.cdc_pulse_out(regslv_reg_top__reg_block_1_cdc_pulse_out)
	,.global_sync_reset_out(regslv_reg_top__reg_block_1_fsm_sync_reset),.global_sync_reset_in(regmst_reg_top_fsm_sync_reset)//field ports instance
	
	);
endmodule