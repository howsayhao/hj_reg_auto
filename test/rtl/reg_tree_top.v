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
	,output regmst_root_map_cdc_pulse_out
	,output regslv_root_map__test_map_1_inst_cdc_pulse_out
	//field interface port
	,input [1-1:0]TEM21__FIELD_3__next_value
	,input [1-1:0]TEM21__FIELD_3__pulse
	,input [3-1:0]TEM21__FIELD_2__next_value
	,input [1-1:0]TEM21__FIELD_2__pulse
	,input [1-1:0]TEM21__FIELD_1__next_value
	,input [1-1:0]TEM21__FIELD_1__pulse
	,input [1-1:0]TEM22__FIELD_3__next_value
	,input [1-1:0]TEM22__FIELD_3__pulse
	,input [3-1:0]TEM22__FIELD_2__next_value
	,input [1-1:0]TEM22__FIELD_2__pulse
	,input [1-1:0]TEM22__FIELD_1__next_value
	,input [1-1:0]TEM22__FIELD_1__pulse
	,input [1-1:0]TEM23__FIELD_3__next_value
	,input [1-1:0]TEM23__FIELD_3__pulse
	,input [3-1:0]TEM23__FIELD_2__next_value
	,input [1-1:0]TEM23__FIELD_2__pulse
	,input [1-1:0]TEM23__FIELD_1__next_value
	,input [1-1:0]TEM23__FIELD_1__pulse
	,output [1-1:0]TEM21__FIELD_3__curr_value
	,output [3-1:0]TEM21__FIELD_2__curr_value
	,output [1-1:0]TEM21__FIELD_1__curr_value
	,output [1-1:0]TEM22__FIELD_3__curr_value
	,output [3-1:0]TEM22__FIELD_2__curr_value
	,output [1-1:0]TEM22__FIELD_1__curr_value
	,output [1-1:0]TEM23__FIELD_3__curr_value
	,output [3-1:0]TEM23__FIELD_2__curr_value
	,output [1-1:0]TEM23__FIELD_1__curr_value
	//field interface end
	//sync_reset interface start
	,input sync_rst_local_1
	,input sync_rst_local_2
	//sync_reset interface end
//external IP/memory port declare
//external IP/memory port declare
);
//parameter instance here
//wire definition here
logic [1-1:0] regmst_root_map_ext_req_vld;
logic [1-1:0] regmst_root_map_ext_req_rdy;
logic [1-1:0] regmst_root_map_ext_ack_vld;
logic regmst_root_map_ext_ack_rdy;
logic [1-1:0] [`DATA_WIDTH-1:0]regmst_root_map_ext_rd_data;
logic regmst_root_map_wr_en;
logic regmst_root_map_rd_en;
logic regmst_root_map_fsm_sync_reset;
logic [`DATA_WIDTH-1:0]regmst_root_map_wr_data;
logic [`ADDR_WIDTH-1:0] regmst_root_map_addr;
logic [1-1:0] regslv_root_map__test_map_1_inst_ext_req_vld;
logic [1-1:0] regslv_root_map__test_map_1_inst_ext_req_rdy;
logic [1-1:0] regslv_root_map__test_map_1_inst_ext_ack_vld;
logic regslv_root_map__test_map_1_inst_ext_ack_rdy;
logic [1-1:0] [`DATA_WIDTH-1:0]regslv_root_map__test_map_1_inst_ext_rd_data;
logic regslv_root_map__test_map_1_inst_wr_en;
logic regslv_root_map__test_map_1_inst_rd_en;
logic regslv_root_map__test_map_1_inst_fsm_sync_reset;
logic [`DATA_WIDTH-1:0]regslv_root_map__test_map_1_inst_wr_data;
logic [`ADDR_WIDTH-1:0] regslv_root_map__test_map_1_inst_addr;
//external IP/memory port define
//reg module instance here
regmst_root_map #(.ADDR_WIDTH(`ADDR_WIDTH), .DATA_WIDTH(`DATA_WIDTH))
	regmst_root_map (
	//APB interface instance
	.clk(clk),.rstn(rstn),.PADDR(PADDR), .PWRITE(PWRITE), .PSEL(PSEL), .PENABLE(PENABLE), .PWDATA(PWDATA), .PRDATA(PRDATA), .PREADY(PREADY), .PSLVERR(PSLVERR)
	,.clear(clear), .interrupt(interrupt)
	//reg_slv downstream interface instance
	,.ext_req_vld(regmst_root_map_ext_req_vld),.ext_req_rdy(regmst_root_map_ext_req_rdy),.ext_ack_vld(regmst_root_map_ext_ack_vld),.ext_ack_rdy(regmst_root_map_ext_ack_rdy),.ext_rd_data(regmst_root_map_ext_rd_data)
	,.ext_wr_en(regmst_root_map_wr_en),.ext_rd_en(regmst_root_map_rd_en),.ext_wr_data(regmst_root_map_wr_data),.ext_addr(regmst_root_map_addr),.cdc_pulse_out(regmst_root_map_cdc_pulse_out)
	,.global_sync_reset_out(regmst_root_map_fsm_sync_reset)//field ports instance
	,.test_map_2_inst_shared_2__FIELD_2__next_value(test_map_2_inst_shared_2__FIELD_2__next_value),.test_map_2_inst_shared_2__FIELD_2__pulse(test_map_2_inst_shared_2__FIELD_2__pulse),.test_map_2_inst_shared_2__FIELD_1__next_value(test_map_2_inst_shared_2__FIELD_1__next_value)
	,.test_map_2_inst_shared_2__FIELD_1__pulse(test_map_2_inst_shared_2__FIELD_1__pulse),.ipxact_block_example_inst_reg1__f1__next_value(ipxact_block_example_inst_reg1__f1__next_value),.ipxact_block_example_inst_reg1__f1__pulse(ipxact_block_example_inst_reg1__f1__pulse)
	,.ipxact_block_example_inst_reg1__f2__next_value(ipxact_block_example_inst_reg1__f2__next_value),.ipxact_block_example_inst_reg1__f2__pulse(ipxact_block_example_inst_reg1__f2__pulse),.ipxact_block_example_inst_reg_array0__x__next_value(ipxact_block_example_inst_reg_array0__x__next_value)
	,.ipxact_block_example_inst_reg_array0__x__pulse(ipxact_block_example_inst_reg_array0__x__pulse),.ipxact_block_example_inst_reg_array1__x__next_value(ipxact_block_example_inst_reg_array1__x__next_value),.ipxact_block_example_inst_reg_array1__x__pulse(ipxact_block_example_inst_reg_array1__x__pulse)
	,.ipxact_block_example_inst_reg_array2__x__next_value(ipxact_block_example_inst_reg_array2__x__next_value),.ipxact_block_example_inst_reg_array2__x__pulse(ipxact_block_example_inst_reg_array2__x__pulse),.ipxact_block_example_inst_reg_array3__x__next_value(ipxact_block_example_inst_reg_array3__x__next_value)
	,.ipxact_block_example_inst_reg_array3__x__pulse(ipxact_block_example_inst_reg_array3__x__pulse),.test_map_2_inst_shared_2__FIELD_2__curr_value(test_map_2_inst_shared_2__FIELD_2__curr_value),.test_map_2_inst_shared_2__FIELD_1__curr_value(test_map_2_inst_shared_2__FIELD_1__curr_value)
	,.ipxact_block_example_inst_reg1__f1__curr_value(ipxact_block_example_inst_reg1__f1__curr_value),.ipxact_block_example_inst_reg1__f2__curr_value(ipxact_block_example_inst_reg1__f2__curr_value),.ipxact_block_example_inst_reg_array0__x__curr_value(ipxact_block_example_inst_reg_array0__x__curr_value)
	,.ipxact_block_example_inst_reg_array1__x__curr_value(ipxact_block_example_inst_reg_array1__x__curr_value),.ipxact_block_example_inst_reg_array2__x__curr_value(ipxact_block_example_inst_reg_array2__x__curr_value),.ipxact_block_example_inst_reg_array3__x__curr_value(ipxact_block_example_inst_reg_array3__x__curr_value)
	
	);
regslv_root_map__test_map_1_inst #(.ADDR_WIDTH(`ADDR_WIDTH), .DATA_WIDTH(`DATA_WIDTH))
	regslv_root_map__test_map_1_inst (
	//reg_module upstream interface instance
	.clk(clk),.rstn(rstn),.req_vld(regmst_root_map_ext_req_vld[0]),.req_rdy(regmst_root_map_ext_req_rdy[0])
	,.wr_en(regmst_root_map_wr_en),.rd_en(regmst_root_map_rd_en),.addr(regmst_root_map_addr),.wr_data(regmst_root_map_wr_data)
	,.ack_vld(regmst_root_map_ext_ack_vld[0]),.ack_rdy(regmst_root_map_ext_ack_rdy),.rd_data(regmst_root_map_ext_rd_data[0])
	,.sync_rst_local_1(sync_rst_local_1)
	,.sync_rst_local_2(sync_rst_local_2)
	//reg_slv downstream interface instance
	,.ext_req_vld(regslv_root_map__test_map_1_inst_ext_req_vld),.ext_req_rdy(regslv_root_map__test_map_1_inst_ext_req_rdy),.ext_ack_vld(regslv_root_map__test_map_1_inst_ext_ack_vld),.ext_ack_rdy(regslv_root_map__test_map_1_inst_ext_ack_rdy),.ext_rd_data(regslv_root_map__test_map_1_inst_ext_rd_data)
	,.ext_wr_en(regslv_root_map__test_map_1_inst_wr_en),.ext_rd_en(regslv_root_map__test_map_1_inst_rd_en),.ext_wr_data(regslv_root_map__test_map_1_inst_wr_data),.ext_addr(regslv_root_map__test_map_1_inst_addr),.cdc_pulse_out(regslv_root_map__test_map_1_inst_cdc_pulse_out)
	,.global_sync_reset_out(regslv_root_map__test_map_1_inst_fsm_sync_reset),.global_sync_reset_in(regmst_root_map_fsm_sync_reset)//field ports instance
	,.TEM21__FIELD_3__next_value(TEM21__FIELD_3__next_value),.TEM21__FIELD_3__pulse(TEM21__FIELD_3__pulse),.TEM21__FIELD_2__next_value(TEM21__FIELD_2__next_value)
	,.TEM21__FIELD_2__pulse(TEM21__FIELD_2__pulse),.TEM21__FIELD_1__next_value(TEM21__FIELD_1__next_value),.TEM21__FIELD_1__pulse(TEM21__FIELD_1__pulse)
	,.TEM22__FIELD_3__next_value(TEM22__FIELD_3__next_value),.TEM22__FIELD_3__pulse(TEM22__FIELD_3__pulse),.TEM22__FIELD_2__next_value(TEM22__FIELD_2__next_value)
	,.TEM22__FIELD_2__pulse(TEM22__FIELD_2__pulse),.TEM22__FIELD_1__next_value(TEM22__FIELD_1__next_value),.TEM22__FIELD_1__pulse(TEM22__FIELD_1__pulse)
	,.TEM23__FIELD_3__next_value(TEM23__FIELD_3__next_value),.TEM23__FIELD_3__pulse(TEM23__FIELD_3__pulse),.TEM23__FIELD_2__next_value(TEM23__FIELD_2__next_value)
	,.TEM23__FIELD_2__pulse(TEM23__FIELD_2__pulse),.TEM23__FIELD_1__next_value(TEM23__FIELD_1__next_value),.TEM23__FIELD_1__pulse(TEM23__FIELD_1__pulse)
	,.TEM21__FIELD_3__curr_value(TEM21__FIELD_3__curr_value),.TEM21__FIELD_2__curr_value(TEM21__FIELD_2__curr_value),.TEM21__FIELD_1__curr_value(TEM21__FIELD_1__curr_value)
	,.TEM22__FIELD_3__curr_value(TEM22__FIELD_3__curr_value),.TEM22__FIELD_2__curr_value(TEM22__FIELD_2__curr_value),.TEM22__FIELD_1__curr_value(TEM22__FIELD_1__curr_value)
	,.TEM23__FIELD_3__curr_value(TEM23__FIELD_3__curr_value),.TEM23__FIELD_2__curr_value(TEM23__FIELD_2__curr_value),.TEM23__FIELD_1__curr_value(TEM23__FIELD_1__curr_value)
	
	);
endmodule