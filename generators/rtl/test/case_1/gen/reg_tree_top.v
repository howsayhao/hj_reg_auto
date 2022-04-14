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
	,output regslv_reg_top__reg_block_1__test_11_cdc_pulse_out
	,output regslv_reg_top__reg_block_2_cdc_pulse_out
	//field interface port
	,input [32-1:0]test_12_REG1__FIELD_0__next_value
	,input [1-1:0]test_12_REG1__FIELD_0__pulse
	,input [32-1:0]test_12_REG2__FIELD_0__next_value
	,input [1-1:0]test_12_REG2__FIELD_0__pulse
	,input [32-1:0]test_12_REG3__FIELD_0__next_value
	,input [1-1:0]test_12_REG3__FIELD_0__pulse
	,input [32-1:0]test_12_REG4__FIELD_0__next_value
	,input [1-1:0]test_12_REG4__FIELD_0__pulse
	,input [32-1:0]test_13_REG1__FIELD_0__next_value
	,input [1-1:0]test_13_REG1__FIELD_0__pulse
	,input [32-1:0]test_13_REG2__FIELD_0__next_value
	,input [1-1:0]test_13_REG2__FIELD_0__pulse
	,input [32-1:0]test_13_REG3__FIELD_0__next_value
	,input [1-1:0]test_13_REG3__FIELD_0__pulse
	,input [32-1:0]test_13_REG4__FIELD_0__next_value
	,input [1-1:0]test_13_REG4__FIELD_0__pulse
	,output [32-1:0]test_12_REG1__FIELD_0__curr_value
	,output [32-1:0]test_12_REG2__FIELD_0__curr_value
	,output [32-1:0]test_12_REG3__FIELD_0__curr_value
	,output [32-1:0]test_12_REG4__FIELD_0__curr_value
	,output [32-1:0]test_13_REG1__FIELD_0__curr_value
	,output [32-1:0]test_13_REG2__FIELD_0__curr_value
	,output [32-1:0]test_13_REG3__FIELD_0__curr_value
	,output [32-1:0]test_13_REG4__FIELD_0__curr_value
	,input [32-1:0]REG1__FIELD_0__next_value
	,input [1-1:0]REG1__FIELD_0__pulse
	,input [32-1:0]REG2__FIELD_0__next_value
	,input [1-1:0]REG2__FIELD_0__pulse
	,input [32-1:0]REG3__FIELD_0__next_value
	,input [1-1:0]REG3__FIELD_0__pulse
	,input [32-1:0]REG4__FIELD_0__next_value
	,input [1-1:0]REG4__FIELD_0__pulse
	,output [32-1:0]REG1__FIELD_0__curr_value
	,output [32-1:0]REG2__FIELD_0__curr_value
	,output [32-1:0]REG3__FIELD_0__curr_value
	,output [32-1:0]REG4__FIELD_0__curr_value
	,input [32-1:0]test_21_REG1__FIELD_0__next_value
	,input [1-1:0]test_21_REG1__FIELD_0__pulse
	,input [32-1:0]test_21_REG2__FIELD_0__next_value
	,input [1-1:0]test_21_REG2__FIELD_0__pulse
	,input [32-1:0]test_21_REG3__FIELD_0__next_value
	,input [1-1:0]test_21_REG3__FIELD_0__pulse
	,input [32-1:0]test_21_REG4__FIELD_0__next_value
	,input [1-1:0]test_21_REG4__FIELD_0__pulse
	,input [32-1:0]test_22_REG1__FIELD_0__next_value
	,input [1-1:0]test_22_REG1__FIELD_0__pulse
	,input [32-1:0]test_22_REG2__FIELD_0__next_value
	,input [1-1:0]test_22_REG2__FIELD_0__pulse
	,input [32-1:0]test_22_REG3__FIELD_0__next_value
	,input [1-1:0]test_22_REG3__FIELD_0__pulse
	,input [32-1:0]test_22_REG4__FIELD_0__next_value
	,input [1-1:0]test_22_REG4__FIELD_0__pulse
	,input [32-1:0]test_23_REG1__FIELD_0__next_value
	,input [1-1:0]test_23_REG1__FIELD_0__pulse
	,input [32-1:0]test_23_REG2__FIELD_0__next_value
	,input [1-1:0]test_23_REG2__FIELD_0__pulse
	,input [32-1:0]test_23_REG3__FIELD_0__next_value
	,input [1-1:0]test_23_REG3__FIELD_0__pulse
	,input [32-1:0]test_23_REG4__FIELD_0__next_value
	,input [1-1:0]test_23_REG4__FIELD_0__pulse
	,output [32-1:0]test_21_REG1__FIELD_0__curr_value
	,output [32-1:0]test_21_REG2__FIELD_0__curr_value
	,output [32-1:0]test_21_REG3__FIELD_0__curr_value
	,output [32-1:0]test_21_REG4__FIELD_0__curr_value
	,output [32-1:0]test_22_REG1__FIELD_0__curr_value
	,output [32-1:0]test_22_REG2__FIELD_0__curr_value
	,output [32-1:0]test_22_REG3__FIELD_0__curr_value
	,output [32-1:0]test_22_REG4__FIELD_0__curr_value
	,output [32-1:0]test_23_REG1__FIELD_0__curr_value
	,output [32-1:0]test_23_REG2__FIELD_0__curr_value
	,output [32-1:0]test_23_REG3__FIELD_0__curr_value
	,output [32-1:0]test_23_REG4__FIELD_0__curr_value
	//field interface end
	//sync_reset interface start
	//sync_reset interface end
//external IP/memory port declare
	,output regslv_reg_top__reg_block_1__ext_mem_11_req_vld
	,input regslv_reg_top__reg_block_1__ext_mem_11_ack_vld
	,input regslv_reg_top__reg_block_1__ext_mem_11_req_rdy
	,output regslv_reg_top__reg_block_1__ext_mem_11_ack_rdy
	,input [`DATA_WIDTH-1:0]regslv_reg_top__reg_block_1__ext_mem_11_rd_data
	,output regslv_reg_top__reg_block_2__ext_mem_21_req_vld
	,input regslv_reg_top__reg_block_2__ext_mem_21_ack_vld
	,input regslv_reg_top__reg_block_2__ext_mem_21_req_rdy
	,output regslv_reg_top__reg_block_2__ext_mem_21_ack_rdy
	,input [`DATA_WIDTH-1:0]regslv_reg_top__reg_block_2__ext_mem_21_rd_data
	,output regslv_reg_top__reg_block_2__ext_mem_22_req_vld
	,input regslv_reg_top__reg_block_2__ext_mem_22_ack_vld
	,input regslv_reg_top__reg_block_2__ext_mem_22_req_rdy
	,output regslv_reg_top__reg_block_2__ext_mem_22_ack_rdy
	,input [`DATA_WIDTH-1:0]regslv_reg_top__reg_block_2__ext_mem_22_rd_data
	,output regslv_reg_top__reg_block_2__ext_mem_23_req_vld
	,input regslv_reg_top__reg_block_2__ext_mem_23_ack_vld
	,input regslv_reg_top__reg_block_2__ext_mem_23_req_rdy
	,output regslv_reg_top__reg_block_2__ext_mem_23_ack_rdy
	,input [`DATA_WIDTH-1:0]regslv_reg_top__reg_block_2__ext_mem_23_rd_data
	,output regmst_reg_top__ext_mem_in_top_req_vld
	,input regmst_reg_top__ext_mem_in_top_ack_vld
	,input regmst_reg_top__ext_mem_in_top_req_rdy
	,output regmst_reg_top__ext_mem_in_top_ack_rdy
	,input [`DATA_WIDTH-1:0]regmst_reg_top__ext_mem_in_top_rd_data
//external IP/memory port declare
);
//parameter instance here
//wire definition here
logic [3-1:0] regmst_reg_top_ext_req_vld;
logic [3-1:0] regmst_reg_top_ext_req_rdy;
logic [3-1:0] regmst_reg_top_ext_ack_vld;
logic regmst_reg_top_ext_ack_rdy;
logic [3-1:0] [`DATA_WIDTH-1:0]regmst_reg_top_ext_rd_data;
logic regmst_reg_top_wr_en;
logic regmst_reg_top_rd_en;
logic regmst_reg_top_fsm_sync_reset;
logic [`DATA_WIDTH-1:0]regmst_reg_top_wr_data;
logic [`ADDR_WIDTH-1:0] regmst_reg_top_addr;
logic [2-1:0] regslv_reg_top__reg_block_1_ext_req_vld;
logic [2-1:0] regslv_reg_top__reg_block_1_ext_req_rdy;
logic [2-1:0] regslv_reg_top__reg_block_1_ext_ack_vld;
logic regslv_reg_top__reg_block_1_ext_ack_rdy;
logic [2-1:0] [`DATA_WIDTH-1:0]regslv_reg_top__reg_block_1_ext_rd_data;
logic regslv_reg_top__reg_block_1_wr_en;
logic regslv_reg_top__reg_block_1_rd_en;
logic regslv_reg_top__reg_block_1_fsm_sync_reset;
logic [`DATA_WIDTH-1:0]regslv_reg_top__reg_block_1_wr_data;
logic [`ADDR_WIDTH-1:0] regslv_reg_top__reg_block_1_addr;
logic [1-1:0] regslv_reg_top__reg_block_1__test_11_ext_req_vld;
logic [1-1:0] regslv_reg_top__reg_block_1__test_11_ext_req_rdy;
logic [1-1:0] regslv_reg_top__reg_block_1__test_11_ext_ack_vld;
logic regslv_reg_top__reg_block_1__test_11_ext_ack_rdy;
logic [1-1:0] [`DATA_WIDTH-1:0]regslv_reg_top__reg_block_1__test_11_ext_rd_data;
logic regslv_reg_top__reg_block_1__test_11_wr_en;
logic regslv_reg_top__reg_block_1__test_11_rd_en;
logic regslv_reg_top__reg_block_1__test_11_fsm_sync_reset;
logic [`DATA_WIDTH-1:0]regslv_reg_top__reg_block_1__test_11_wr_data;
logic [`ADDR_WIDTH-1:0] regslv_reg_top__reg_block_1__test_11_addr;
logic [3-1:0] regslv_reg_top__reg_block_2_ext_req_vld;
logic [3-1:0] regslv_reg_top__reg_block_2_ext_req_rdy;
logic [3-1:0] regslv_reg_top__reg_block_2_ext_ack_vld;
logic regslv_reg_top__reg_block_2_ext_ack_rdy;
logic [3-1:0] [`DATA_WIDTH-1:0]regslv_reg_top__reg_block_2_ext_rd_data;
logic regslv_reg_top__reg_block_2_wr_en;
logic regslv_reg_top__reg_block_2_rd_en;
logic regslv_reg_top__reg_block_2_fsm_sync_reset;
logic [`DATA_WIDTH-1:0]regslv_reg_top__reg_block_2_wr_data;
logic [`ADDR_WIDTH-1:0] regslv_reg_top__reg_block_2_addr;
//external IP/memory port define
//external: ext_mem_11 ref:regslv_reg_top__reg_block_1  wire connection define
assign regslv_reg_top__reg_block_1__ext_mem_11_req_vld = regslv_reg_top__reg_block_1_ext_req_vld[1];
assign regslv_reg_top__reg_block_1__ext_mem_11_ack_rdy = regslv_reg_top__reg_block_1_ext_ack_rdy;
assign regslv_reg_top__reg_block_1_ext_ack_vld[1] = regslv_reg_top__reg_block_1__ext_mem_11_ack_vld;
assign regslv_reg_top__reg_block_1_ext_req_rdy[1] = regslv_reg_top__reg_block_1__ext_mem_11_req_rdy;
assign regslv_reg_top__reg_block_1_ext_rd_data[1] = regslv_reg_top__reg_block_1__ext_mem_11_rd_data;
//external: ext_mem_21 ref:regslv_reg_top__reg_block_2  wire connection define
assign regslv_reg_top__reg_block_2__ext_mem_21_req_vld = regslv_reg_top__reg_block_2_ext_req_vld[0];
assign regslv_reg_top__reg_block_2__ext_mem_21_ack_rdy = regslv_reg_top__reg_block_2_ext_ack_rdy;
assign regslv_reg_top__reg_block_2_ext_ack_vld[0] = regslv_reg_top__reg_block_2__ext_mem_21_ack_vld;
assign regslv_reg_top__reg_block_2_ext_req_rdy[0] = regslv_reg_top__reg_block_2__ext_mem_21_req_rdy;
assign regslv_reg_top__reg_block_2_ext_rd_data[0] = regslv_reg_top__reg_block_2__ext_mem_21_rd_data;
//external: ext_mem_22 ref:regslv_reg_top__reg_block_2  wire connection define
assign regslv_reg_top__reg_block_2__ext_mem_22_req_vld = regslv_reg_top__reg_block_2_ext_req_vld[1];
assign regslv_reg_top__reg_block_2__ext_mem_22_ack_rdy = regslv_reg_top__reg_block_2_ext_ack_rdy;
assign regslv_reg_top__reg_block_2_ext_ack_vld[1] = regslv_reg_top__reg_block_2__ext_mem_22_ack_vld;
assign regslv_reg_top__reg_block_2_ext_req_rdy[1] = regslv_reg_top__reg_block_2__ext_mem_22_req_rdy;
assign regslv_reg_top__reg_block_2_ext_rd_data[1] = regslv_reg_top__reg_block_2__ext_mem_22_rd_data;
//external: ext_mem_23 ref:regslv_reg_top__reg_block_2  wire connection define
assign regslv_reg_top__reg_block_2__ext_mem_23_req_vld = regslv_reg_top__reg_block_2_ext_req_vld[2];
assign regslv_reg_top__reg_block_2__ext_mem_23_ack_rdy = regslv_reg_top__reg_block_2_ext_ack_rdy;
assign regslv_reg_top__reg_block_2_ext_ack_vld[2] = regslv_reg_top__reg_block_2__ext_mem_23_ack_vld;
assign regslv_reg_top__reg_block_2_ext_req_rdy[2] = regslv_reg_top__reg_block_2__ext_mem_23_req_rdy;
assign regslv_reg_top__reg_block_2_ext_rd_data[2] = regslv_reg_top__reg_block_2__ext_mem_23_rd_data;
//external: ext_mem_in_top ref:regmst_reg_top  wire connection define
assign regmst_reg_top__ext_mem_in_top_req_vld = regmst_reg_top_ext_req_vld[2];
assign regmst_reg_top__ext_mem_in_top_ack_rdy = regmst_reg_top_ext_ack_rdy;
assign regmst_reg_top_ext_ack_vld[2] = regmst_reg_top__ext_mem_in_top_ack_vld;
assign regmst_reg_top_ext_req_rdy[2] = regmst_reg_top__ext_mem_in_top_req_rdy;
assign regmst_reg_top_ext_rd_data[2] = regmst_reg_top__ext_mem_in_top_rd_data;
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
	,.test_12_REG1__FIELD_0__next_value(test_12_REG1__FIELD_0__next_value),.test_12_REG1__FIELD_0__pulse(test_12_REG1__FIELD_0__pulse),.test_12_REG2__FIELD_0__next_value(test_12_REG2__FIELD_0__next_value)
	,.test_12_REG2__FIELD_0__pulse(test_12_REG2__FIELD_0__pulse),.test_12_REG3__FIELD_0__next_value(test_12_REG3__FIELD_0__next_value),.test_12_REG3__FIELD_0__pulse(test_12_REG3__FIELD_0__pulse)
	,.test_12_REG4__FIELD_0__next_value(test_12_REG4__FIELD_0__next_value),.test_12_REG4__FIELD_0__pulse(test_12_REG4__FIELD_0__pulse),.test_13_REG1__FIELD_0__next_value(test_13_REG1__FIELD_0__next_value)
	,.test_13_REG1__FIELD_0__pulse(test_13_REG1__FIELD_0__pulse),.test_13_REG2__FIELD_0__next_value(test_13_REG2__FIELD_0__next_value),.test_13_REG2__FIELD_0__pulse(test_13_REG2__FIELD_0__pulse)
	,.test_13_REG3__FIELD_0__next_value(test_13_REG3__FIELD_0__next_value),.test_13_REG3__FIELD_0__pulse(test_13_REG3__FIELD_0__pulse),.test_13_REG4__FIELD_0__next_value(test_13_REG4__FIELD_0__next_value)
	,.test_13_REG4__FIELD_0__pulse(test_13_REG4__FIELD_0__pulse),.test_12_REG1__FIELD_0__curr_value(test_12_REG1__FIELD_0__curr_value),.test_12_REG2__FIELD_0__curr_value(test_12_REG2__FIELD_0__curr_value)
	,.test_12_REG3__FIELD_0__curr_value(test_12_REG3__FIELD_0__curr_value),.test_12_REG4__FIELD_0__curr_value(test_12_REG4__FIELD_0__curr_value),.test_13_REG1__FIELD_0__curr_value(test_13_REG1__FIELD_0__curr_value)
	,.test_13_REG2__FIELD_0__curr_value(test_13_REG2__FIELD_0__curr_value),.test_13_REG3__FIELD_0__curr_value(test_13_REG3__FIELD_0__curr_value),.test_13_REG4__FIELD_0__curr_value(test_13_REG4__FIELD_0__curr_value)
	
	);
regslv_reg_top__reg_block_1__test_11 #(.ADDR_WIDTH(`ADDR_WIDTH), .DATA_WIDTH(`DATA_WIDTH))
	regslv_reg_top__reg_block_1__test_11 (
	//reg_module upstream interface instance
	.clk(clk),.rstn(rstn),.req_vld(regslv_reg_top__reg_block_1_ext_req_vld[0]),.req_rdy(regslv_reg_top__reg_block_1_ext_req_rdy[0])
	,.wr_en(regslv_reg_top__reg_block_1_wr_en),.rd_en(regslv_reg_top__reg_block_1_rd_en),.addr(regslv_reg_top__reg_block_1_addr),.wr_data(regslv_reg_top__reg_block_1_wr_data)
	,.ack_vld(regslv_reg_top__reg_block_1_ext_ack_vld[0]),.ack_rdy(regslv_reg_top__reg_block_1_ext_ack_rdy),.rd_data(regslv_reg_top__reg_block_1_ext_rd_data[0])
	//reg_slv downstream interface instance
	,.ext_req_vld(regslv_reg_top__reg_block_1__test_11_ext_req_vld),.ext_req_rdy(regslv_reg_top__reg_block_1__test_11_ext_req_rdy),.ext_ack_vld(regslv_reg_top__reg_block_1__test_11_ext_ack_vld),.ext_ack_rdy(regslv_reg_top__reg_block_1__test_11_ext_ack_rdy),.ext_rd_data(regslv_reg_top__reg_block_1__test_11_ext_rd_data)
	,.ext_wr_en(regslv_reg_top__reg_block_1__test_11_wr_en),.ext_rd_en(regslv_reg_top__reg_block_1__test_11_rd_en),.ext_wr_data(regslv_reg_top__reg_block_1__test_11_wr_data),.ext_addr(regslv_reg_top__reg_block_1__test_11_addr),.cdc_pulse_out(regslv_reg_top__reg_block_1__test_11_cdc_pulse_out)
	,.global_sync_reset_out(regslv_reg_top__reg_block_1__test_11_fsm_sync_reset),.global_sync_reset_in(regslv_reg_top__reg_block_1_fsm_sync_reset)//field ports instance
	,.REG1__FIELD_0__next_value(REG1__FIELD_0__next_value),.REG1__FIELD_0__pulse(REG1__FIELD_0__pulse),.REG2__FIELD_0__next_value(REG2__FIELD_0__next_value)
	,.REG2__FIELD_0__pulse(REG2__FIELD_0__pulse),.REG3__FIELD_0__next_value(REG3__FIELD_0__next_value),.REG3__FIELD_0__pulse(REG3__FIELD_0__pulse)
	,.REG4__FIELD_0__next_value(REG4__FIELD_0__next_value),.REG4__FIELD_0__pulse(REG4__FIELD_0__pulse),.REG1__FIELD_0__curr_value(REG1__FIELD_0__curr_value)
	,.REG2__FIELD_0__curr_value(REG2__FIELD_0__curr_value),.REG3__FIELD_0__curr_value(REG3__FIELD_0__curr_value),.REG4__FIELD_0__curr_value(REG4__FIELD_0__curr_value)
	
	);
regslv_reg_top__reg_block_2 #(.ADDR_WIDTH(`ADDR_WIDTH), .DATA_WIDTH(`DATA_WIDTH))
	regslv_reg_top__reg_block_2 (
	//reg_module upstream interface instance
	.clk(clk),.rstn(rstn),.req_vld(regmst_reg_top_ext_req_vld[1]),.req_rdy(regmst_reg_top_ext_req_rdy[1])
	,.wr_en(regmst_reg_top_wr_en),.rd_en(regmst_reg_top_rd_en),.addr(regmst_reg_top_addr),.wr_data(regmst_reg_top_wr_data)
	,.ack_vld(regmst_reg_top_ext_ack_vld[1]),.ack_rdy(regmst_reg_top_ext_ack_rdy),.rd_data(regmst_reg_top_ext_rd_data[1])
	//reg_slv downstream interface instance
	,.ext_req_vld(regslv_reg_top__reg_block_2_ext_req_vld),.ext_req_rdy(regslv_reg_top__reg_block_2_ext_req_rdy),.ext_ack_vld(regslv_reg_top__reg_block_2_ext_ack_vld),.ext_ack_rdy(regslv_reg_top__reg_block_2_ext_ack_rdy),.ext_rd_data(regslv_reg_top__reg_block_2_ext_rd_data)
	,.ext_wr_en(regslv_reg_top__reg_block_2_wr_en),.ext_rd_en(regslv_reg_top__reg_block_2_rd_en),.ext_wr_data(regslv_reg_top__reg_block_2_wr_data),.ext_addr(regslv_reg_top__reg_block_2_addr),.cdc_pulse_out(regslv_reg_top__reg_block_2_cdc_pulse_out)
	,.global_sync_reset_out(regslv_reg_top__reg_block_2_fsm_sync_reset),.global_sync_reset_in(regmst_reg_top_fsm_sync_reset)//field ports instance
	,.test_21_REG1__FIELD_0__next_value(test_21_REG1__FIELD_0__next_value),.test_21_REG1__FIELD_0__pulse(test_21_REG1__FIELD_0__pulse),.test_21_REG2__FIELD_0__next_value(test_21_REG2__FIELD_0__next_value)
	,.test_21_REG2__FIELD_0__pulse(test_21_REG2__FIELD_0__pulse),.test_21_REG3__FIELD_0__next_value(test_21_REG3__FIELD_0__next_value),.test_21_REG3__FIELD_0__pulse(test_21_REG3__FIELD_0__pulse)
	,.test_21_REG4__FIELD_0__next_value(test_21_REG4__FIELD_0__next_value),.test_21_REG4__FIELD_0__pulse(test_21_REG4__FIELD_0__pulse),.test_22_REG1__FIELD_0__next_value(test_22_REG1__FIELD_0__next_value)
	,.test_22_REG1__FIELD_0__pulse(test_22_REG1__FIELD_0__pulse),.test_22_REG2__FIELD_0__next_value(test_22_REG2__FIELD_0__next_value),.test_22_REG2__FIELD_0__pulse(test_22_REG2__FIELD_0__pulse)
	,.test_22_REG3__FIELD_0__next_value(test_22_REG3__FIELD_0__next_value),.test_22_REG3__FIELD_0__pulse(test_22_REG3__FIELD_0__pulse),.test_22_REG4__FIELD_0__next_value(test_22_REG4__FIELD_0__next_value)
	,.test_22_REG4__FIELD_0__pulse(test_22_REG4__FIELD_0__pulse),.test_23_REG1__FIELD_0__next_value(test_23_REG1__FIELD_0__next_value),.test_23_REG1__FIELD_0__pulse(test_23_REG1__FIELD_0__pulse)
	,.test_23_REG2__FIELD_0__next_value(test_23_REG2__FIELD_0__next_value),.test_23_REG2__FIELD_0__pulse(test_23_REG2__FIELD_0__pulse),.test_23_REG3__FIELD_0__next_value(test_23_REG3__FIELD_0__next_value)
	,.test_23_REG3__FIELD_0__pulse(test_23_REG3__FIELD_0__pulse),.test_23_REG4__FIELD_0__next_value(test_23_REG4__FIELD_0__next_value),.test_23_REG4__FIELD_0__pulse(test_23_REG4__FIELD_0__pulse)
	,.test_21_REG1__FIELD_0__curr_value(test_21_REG1__FIELD_0__curr_value),.test_21_REG2__FIELD_0__curr_value(test_21_REG2__FIELD_0__curr_value),.test_21_REG3__FIELD_0__curr_value(test_21_REG3__FIELD_0__curr_value)
	,.test_21_REG4__FIELD_0__curr_value(test_21_REG4__FIELD_0__curr_value),.test_22_REG1__FIELD_0__curr_value(test_22_REG1__FIELD_0__curr_value),.test_22_REG2__FIELD_0__curr_value(test_22_REG2__FIELD_0__curr_value)
	,.test_22_REG3__FIELD_0__curr_value(test_22_REG3__FIELD_0__curr_value),.test_22_REG4__FIELD_0__curr_value(test_22_REG4__FIELD_0__curr_value),.test_23_REG1__FIELD_0__curr_value(test_23_REG1__FIELD_0__curr_value)
	,.test_23_REG2__FIELD_0__curr_value(test_23_REG2__FIELD_0__curr_value),.test_23_REG3__FIELD_0__curr_value(test_23_REG3__FIELD_0__curr_value),.test_23_REG4__FIELD_0__curr_value(test_23_REG4__FIELD_0__curr_value)
	
	);
endmodule