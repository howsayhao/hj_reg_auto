module reg_tree(
	//reg_mst interface port
	input clk
	,input rstn
	,input req_vld
	,input wr_en,rd_en
	,input [ADDR_WIDTH-1:0]addr
	,input [DATA_WIDTH-1:0]wr_data
	,output req_rdy
	,output ack_vld
	,output [DATA_WIDTH-1:0]rd_data
	,output ack_rdy
	,input global_sync_reset
	//field interface port
	,input [2-1:0]test_1_inst_REG1_SW_RW__FIELD_9__next_value
	,input [2-1:0]test_1_inst_REG1_SW_RW__FIELD_8__next_value
	,input [2-1:0]test_1_inst_REG1_SW_RW__FIELD_7__next_value
	,input [2-1:0]test_1_inst_REG1_SW_RW__FIELD_6__next_value
	,input [2-1:0]test_1_inst_REG1_SW_RW__FIELD_5__next_value
	,input [2-1:0]test_1_inst_REG1_SW_RW__FIELD_4__next_value
	,input [2-1:0]test_1_inst_REG1_SW_RW__FIELD_3__next_value
	,input [2-1:0]test_1_inst_REG1_SW_RW__FIELD_2__next_value
	,input [2-1:0]test_1_inst_REG1_SW_RW__FIELD_1__next_value
	,input [2-1:0]test_1_inst_REG2_SW_W__FIELD_6__next_value
	,input [2-1:0]test_1_inst_REG2_SW_W__FIELD_5__next_value
	,input [2-1:0]test_1_inst_REG2_SW_W__FIELD_4__next_value
	,input [2-1:0]test_1_inst_REG2_SW_W__FIELD_3__next_value
	,input [2-1:0]test_1_inst_REG2_SW_W__FIELD_2__next_value
	,input [2-1:0]test_1_inst_REG2_SW_W__FIELD_1__next_value
	,input [2-1:0]test_1_inst_REG2_SW_W__FIELD_0__next_value
	,input [2-1:0]test_1_inst_REG3_HW__FIELD_3__next_value
	,input [2-1:0]test_1_inst_REG3_HW__FIELD_2__next_value
	,input [2-1:0]test_1_inst_REG3_HW__FIELD_1__next_value
	,input [2-1:0]test_1_inst_REG3_HW__FIELD_0__next_value
	,input [2-1:0]test_1_inst_REG4_PRECEDENCE__FIELD_1__next_value
	,input [2-1:0]test_1_inst_REG4_PRECEDENCE__FIELD_0__next_value
	,input [1-1:0]test_1_inst_REG5_SINGLEPULSE__FIELD_0__next_value
	,input [2-1:0]test_1_inst_REG6_SW_ACC_MOD__FIELD_0__next_value
	,input [32-1:0]test_2_inst_shared_2__FIELD_0__next_value
	,input [32-1:0]test_3_inst_shared_3__FIELD_0__next_value
	,output [2-1:0]test_1_inst_REG1_SW_RW__FIELD_9__curr_value
	,output [2-1:0]test_1_inst_REG1_SW_RW__FIELD_8__curr_value
	,output [2-1:0]test_1_inst_REG1_SW_RW__FIELD_7__curr_value
	,output [2-1:0]test_1_inst_REG1_SW_RW__FIELD_6__curr_value
	,output [2-1:0]test_1_inst_REG1_SW_RW__FIELD_5__curr_value
	,output [2-1:0]test_1_inst_REG1_SW_RW__FIELD_4__curr_value
	,output [2-1:0]test_1_inst_REG1_SW_RW__FIELD_3__curr_value
	,output [2-1:0]test_1_inst_REG1_SW_RW__FIELD_2__curr_value
	,output [2-1:0]test_1_inst_REG1_SW_RW__FIELD_1__curr_value
	,output [2-1:0]test_1_inst_REG2_SW_W__FIELD_6__curr_value
	,output [2-1:0]test_1_inst_REG2_SW_W__FIELD_5__curr_value
	,output [2-1:0]test_1_inst_REG2_SW_W__FIELD_4__curr_value
	,output [2-1:0]test_1_inst_REG2_SW_W__FIELD_3__curr_value
	,output [2-1:0]test_1_inst_REG2_SW_W__FIELD_2__curr_value
	,output [2-1:0]test_1_inst_REG2_SW_W__FIELD_1__curr_value
	,output [2-1:0]test_1_inst_REG2_SW_W__FIELD_0__curr_value
	,output [2-1:0]test_1_inst_REG3_HW__FIELD_3__curr_value
	,output [2-1:0]test_1_inst_REG3_HW__FIELD_2__curr_value
	,output [2-1:0]test_1_inst_REG3_HW__FIELD_1__curr_value
	,output [2-1:0]test_1_inst_REG3_HW__FIELD_0__curr_value
	,output [2-1:0]test_1_inst_REG4_PRECEDENCE__FIELD_1__curr_value
	,output [2-1:0]test_1_inst_REG4_PRECEDENCE__FIELD_0__curr_value
	,output [1-1:0]test_1_inst_REG5_SINGLEPULSE__FIELD_0__curr_value
	,output [2-1:0]test_1_inst_REG6_SW_ACC_MOD__FIELD_0__curr_value
	,output [2-1:0]test_1_inst_REG6_SW_ACC_MOD__FIELD_0__curr_value
	,output [1-1:0]test_1_inst_REG6_SW_ACC_MOD__FIELD_0__swacc_out
	,output [32-1:0]test_2_inst_shared_2__FIELD_0__curr_value
	,output [32-1:0]test_3_inst_shared_3__FIELD_0__curr_value
	,output regslv_regslv_test_inst_ext_mem_1_inst_req_vld
	,input regslv_regslv_test_inst_ext_mem_1_inst_ack_vld
	,input regslv_regslv_test_inst_ext_mem_1_inst_req_rdy
	,output regslv_regslv_test_inst_ext_mem_1_inst_ack_rdy
	,input [DATA_WIDTH-1:0]regslv_regslv_test_inst_ext_mem_1_inst_rd_data
	,output regslv_regslv_test_inst_ext_mem_2_inst_req_vld
	,input regslv_regslv_test_inst_ext_mem_2_inst_ack_vld
	,input regslv_regslv_test_inst_ext_mem_2_inst_req_rdy
	,output regslv_regslv_test_inst_ext_mem_2_inst_ack_rdy
	,input [DATA_WIDTH-1:0]regslv_regslv_test_inst_ext_mem_2_inst_rd_data
	,output regslv_regslv_test_inst_ext_mem_3_inst_req_vld
	,input regslv_regslv_test_inst_ext_mem_3_inst_ack_vld
	,input regslv_regslv_test_inst_ext_mem_3_inst_req_rdy
	,output regslv_regslv_test_inst_ext_mem_3_inst_ack_rdy
	,input [DATA_WIDTH-1:0]regslv_regslv_test_inst_ext_mem_3_inst_rd_data
	,output regslv_regslv_test_inst_addr
	,output regslv_regslv_test_inst_wr_en
	,output regslv_regslv_test_inst_rd_en
	,output regslv_regslv_test_inst_wr_data
	,output regslv_regslv_test_inst_global_sync_reset
);
//parameter instance here
parameter ADDR_WIDTH = 64;
parameter DATA_WIDTH = 32;
//wire definition here
logic [1-1:0] regslv_regmst_test_ext_req_vld;
logic [1-1:0] regslv_regmst_test_ext_req_rdy;
logic [1-1:0] regslv_regmst_test_ext_ack_vld;
logic [1-1:0] regslv_regmst_test_ext_ack_rdy;
logic [1-1:0] [DATA_WIDTH-1:0]regslv_regmst_test_ext_rd_data;
logic regslv_regmst_test_wr_en;
logic regslv_regmst_test_rd_en;
logic regslv_regmst_test_global_sync_reset;
logic [DATA_WIDTH-1:0]regslv_regmst_test_wr_data;
logic [DATA_WIDTH-1:0] regslv_regmst_test_addr;
logic [3-1:0] regslv_regslv_test_inst_ext_req_vld;
logic [3-1:0] regslv_regslv_test_inst_ext_req_rdy;
logic [3-1:0] regslv_regslv_test_inst_ext_ack_vld;
logic [3-1:0] regslv_regslv_test_inst_ext_ack_rdy;
logic [3-1:0] [DATA_WIDTH-1:0]regslv_regslv_test_inst_ext_rd_data;
logic regslv_regslv_test_inst_wr_en;
logic regslv_regslv_test_inst_rd_en;
logic regslv_regslv_test_inst_global_sync_reset;
logic [DATA_WIDTH-1:0]regslv_regslv_test_inst_wr_data;
logic [DATA_WIDTH-1:0] regslv_regslv_test_inst_addr;
//external IP define
//external regslv_regslv_test_inst_ext_mem_1_inst define
assign regslv_regslv_test_inst_ext_mem_1_inst_req_vld = regslv_regslv_test_inst_ext_req_vld[0];
assign regslv_regslv_test_inst_ext_ack_vld[0] = regslv_regslv_test_inst_ext_mem_1_inst_ack_vld;
assign regslv_regslv_test_inst_ext_req_rdy[0] = regslv_regslv_test_inst_ext_mem_1_inst_req_rdy;
assign regslv_regslv_test_inst_ext_mem_1_inst_ack_rdy = regslv_regslv_test_inst_ext_ack_rdy;
assign regslv_regslv_test_inst_ext_rd_data[0] = regslv_regslv_test_inst_ext_mem_1_inst_rd_data;
//external regslv_regslv_test_inst_ext_mem_2_inst define
assign regslv_regslv_test_inst_ext_mem_2_inst_req_vld = regslv_regslv_test_inst_ext_req_vld[1];
assign regslv_regslv_test_inst_ext_ack_vld[1] = regslv_regslv_test_inst_ext_mem_2_inst_ack_vld;
assign regslv_regslv_test_inst_ext_req_rdy[1] = regslv_regslv_test_inst_ext_mem_2_inst_req_rdy;
assign regslv_regslv_test_inst_ext_mem_2_inst_ack_rdy = regslv_regslv_test_inst_ext_ack_rdy;
assign regslv_regslv_test_inst_ext_rd_data[1] = regslv_regslv_test_inst_ext_mem_2_inst_rd_data;
//external regslv_regslv_test_inst_ext_mem_3_inst define
assign regslv_regslv_test_inst_ext_mem_3_inst_req_vld = regslv_regslv_test_inst_ext_req_vld[2];
assign regslv_regslv_test_inst_ext_ack_vld[2] = regslv_regslv_test_inst_ext_mem_3_inst_ack_vld;
assign regslv_regslv_test_inst_ext_req_rdy[2] = regslv_regslv_test_inst_ext_mem_3_inst_req_rdy;
assign regslv_regslv_test_inst_ext_mem_3_inst_ack_rdy = regslv_regslv_test_inst_ext_ack_rdy;
assign regslv_regslv_test_inst_ext_rd_data[2] = regslv_regslv_test_inst_ext_mem_3_inst_rd_data;
//reg module instance here
regslv_regmst_test #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
	regslv_regmst_test (
	//reg_slv upstream interface instance
	.clk(clk),.rstn(rstn),.req_vld(req_vld),.req_rdy(req_rdy)
	,.wr_en(wr_en),.rd_en(rd_en),.addr(addr),.wr_data(wr_data)
	,.ack_vld(ack_vld),.ack_rdy(ack_rdy),.rd_data(rd_data),.global_sync_in(global_sync_reset)
	//reg_slv downstream interface instance
	,.global_sync_out(regslv_regmst_test_global_sync_reset),.ext_req_vld(regslv_regmst_test_ext_req_vld),.ext_req_rdy(regslv_regmst_test_ext_req_rdy).ext_ack_vld(regslv_regmst_test_ext_ack_vld).ext_ack_rdy(regslv_regmst_test_ext_ack_rdy).ext_rd_data(regslv_regmst_test_ext_rd_data)
	,.wr_en_ff(regslv_regmst_test_wr_en),.rd_en_ff(regslv_regmst_test_rd_en),.wr_data_ff(regslv_regmst_test_wr_data),.addr_ff(regslv_regmst_test_addr),
	//field ports instance
	
	);
regslv_regslv_test_inst #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
	regslv_regslv_test_inst (
	//reg_slv upstream interface instance
	.clk(clk),.rstn(rstn),.req_vld(regslv_regmst_test_ext_req_vld[0]),.req_rdy(regslv_regmst_test_ext_req_rdy[0])
	,.wr_en(regslv_regmst_test_wr_en),.rd_en(regslv_regmst_test_rd_en),.addr(regslv_regmst_test_addr),.wr_data(regslv_regmst_test_wr_data)
	,.ack_vld(regslv_regmst_test_ext_ack_vld[0]),.ack_rdy(regslv_regmst_test_ext_ack_rdy[0]),.rd_data(regslv_regmst_test_ext_rd_data[0]),.global_sync_in(regslv_regmst_test_global_sync_reset)
	//reg_slv downstream interface instance
	,.global_sync_out(regslv_regslv_test_inst_global_sync_reset),.ext_req_vld(regslv_regslv_test_inst_ext_req_vld),.ext_req_rdy(regslv_regslv_test_inst_ext_req_rdy).ext_ack_vld(regslv_regslv_test_inst_ext_ack_vld).ext_ack_rdy(regslv_regslv_test_inst_ext_ack_rdy).ext_rd_data(regslv_regslv_test_inst_ext_rd_data)
	,.wr_en_ff(regslv_regslv_test_inst_wr_en),.rd_en_ff(regslv_regslv_test_inst_rd_en),.wr_data_ff(regslv_regslv_test_inst_wr_data),.addr_ff(regslv_regslv_test_inst_addr),
	//field ports instance
	,.test_1_inst_REG1_SW_RW__FIELD_9__next_value(test_1_inst_REG1_SW_RW__FIELD_9__next_value),.test_1_inst_REG1_SW_RW__FIELD_8__next_value(test_1_inst_REG1_SW_RW__FIELD_8__next_value),.test_1_inst_REG1_SW_RW__FIELD_7__next_value(test_1_inst_REG1_SW_RW__FIELD_7__next_value)
	,.test_1_inst_REG1_SW_RW__FIELD_6__next_value(test_1_inst_REG1_SW_RW__FIELD_6__next_value),.test_1_inst_REG1_SW_RW__FIELD_5__next_value(test_1_inst_REG1_SW_RW__FIELD_5__next_value),.test_1_inst_REG1_SW_RW__FIELD_4__next_value(test_1_inst_REG1_SW_RW__FIELD_4__next_value)
	,.test_1_inst_REG1_SW_RW__FIELD_3__next_value(test_1_inst_REG1_SW_RW__FIELD_3__next_value),.test_1_inst_REG1_SW_RW__FIELD_2__next_value(test_1_inst_REG1_SW_RW__FIELD_2__next_value),.test_1_inst_REG1_SW_RW__FIELD_1__next_value(test_1_inst_REG1_SW_RW__FIELD_1__next_value)
	,.test_1_inst_REG2_SW_W__FIELD_6__next_value(test_1_inst_REG2_SW_W__FIELD_6__next_value),.test_1_inst_REG2_SW_W__FIELD_5__next_value(test_1_inst_REG2_SW_W__FIELD_5__next_value),.test_1_inst_REG2_SW_W__FIELD_4__next_value(test_1_inst_REG2_SW_W__FIELD_4__next_value)
	,.test_1_inst_REG2_SW_W__FIELD_3__next_value(test_1_inst_REG2_SW_W__FIELD_3__next_value),.test_1_inst_REG2_SW_W__FIELD_2__next_value(test_1_inst_REG2_SW_W__FIELD_2__next_value),.test_1_inst_REG2_SW_W__FIELD_1__next_value(test_1_inst_REG2_SW_W__FIELD_1__next_value)
	,.test_1_inst_REG2_SW_W__FIELD_0__next_value(test_1_inst_REG2_SW_W__FIELD_0__next_value),.test_1_inst_REG3_HW__FIELD_3__next_value(test_1_inst_REG3_HW__FIELD_3__next_value),.test_1_inst_REG3_HW__FIELD_2__next_value(test_1_inst_REG3_HW__FIELD_2__next_value)
	,.test_1_inst_REG3_HW__FIELD_1__next_value(test_1_inst_REG3_HW__FIELD_1__next_value),.test_1_inst_REG3_HW__FIELD_0__next_value(test_1_inst_REG3_HW__FIELD_0__next_value),.test_1_inst_REG4_PRECEDENCE__FIELD_1__next_value(test_1_inst_REG4_PRECEDENCE__FIELD_1__next_value)
	,.test_1_inst_REG4_PRECEDENCE__FIELD_0__next_value(test_1_inst_REG4_PRECEDENCE__FIELD_0__next_value),.test_1_inst_REG5_SINGLEPULSE__FIELD_0__next_value(test_1_inst_REG5_SINGLEPULSE__FIELD_0__next_value),.test_1_inst_REG6_SW_ACC_MOD__FIELD_0__next_value(test_1_inst_REG6_SW_ACC_MOD__FIELD_0__next_value)
	,.test_2_inst_shared_2__FIELD_0__next_value(test_2_inst_shared_2__FIELD_0__next_value),.test_3_inst_shared_3__FIELD_0__next_value(test_3_inst_shared_3__FIELD_0__next_value),.test_1_inst_REG1_SW_RW__FIELD_9__curr_value(test_1_inst_REG1_SW_RW__FIELD_9__curr_value)
	,.test_1_inst_REG1_SW_RW__FIELD_8__curr_value(test_1_inst_REG1_SW_RW__FIELD_8__curr_value),.test_1_inst_REG1_SW_RW__FIELD_7__curr_value(test_1_inst_REG1_SW_RW__FIELD_7__curr_value),.test_1_inst_REG1_SW_RW__FIELD_6__curr_value(test_1_inst_REG1_SW_RW__FIELD_6__curr_value)
	,.test_1_inst_REG1_SW_RW__FIELD_5__curr_value(test_1_inst_REG1_SW_RW__FIELD_5__curr_value),.test_1_inst_REG1_SW_RW__FIELD_4__curr_value(test_1_inst_REG1_SW_RW__FIELD_4__curr_value),.test_1_inst_REG1_SW_RW__FIELD_3__curr_value(test_1_inst_REG1_SW_RW__FIELD_3__curr_value)
	,.test_1_inst_REG1_SW_RW__FIELD_2__curr_value(test_1_inst_REG1_SW_RW__FIELD_2__curr_value),.test_1_inst_REG1_SW_RW__FIELD_1__curr_value(test_1_inst_REG1_SW_RW__FIELD_1__curr_value),.test_1_inst_REG2_SW_W__FIELD_6__curr_value(test_1_inst_REG2_SW_W__FIELD_6__curr_value)
	,.test_1_inst_REG2_SW_W__FIELD_5__curr_value(test_1_inst_REG2_SW_W__FIELD_5__curr_value),.test_1_inst_REG2_SW_W__FIELD_4__curr_value(test_1_inst_REG2_SW_W__FIELD_4__curr_value),.test_1_inst_REG2_SW_W__FIELD_3__curr_value(test_1_inst_REG2_SW_W__FIELD_3__curr_value)
	,.test_1_inst_REG2_SW_W__FIELD_2__curr_value(test_1_inst_REG2_SW_W__FIELD_2__curr_value),.test_1_inst_REG2_SW_W__FIELD_1__curr_value(test_1_inst_REG2_SW_W__FIELD_1__curr_value),.test_1_inst_REG2_SW_W__FIELD_0__curr_value(test_1_inst_REG2_SW_W__FIELD_0__curr_value)
	,.test_1_inst_REG3_HW__FIELD_3__curr_value(test_1_inst_REG3_HW__FIELD_3__curr_value),.test_1_inst_REG3_HW__FIELD_2__curr_value(test_1_inst_REG3_HW__FIELD_2__curr_value),.test_1_inst_REG3_HW__FIELD_1__curr_value(test_1_inst_REG3_HW__FIELD_1__curr_value)
	,.test_1_inst_REG3_HW__FIELD_0__curr_value(test_1_inst_REG3_HW__FIELD_0__curr_value),.test_1_inst_REG4_PRECEDENCE__FIELD_1__curr_value(test_1_inst_REG4_PRECEDENCE__FIELD_1__curr_value),.test_1_inst_REG4_PRECEDENCE__FIELD_0__curr_value(test_1_inst_REG4_PRECEDENCE__FIELD_0__curr_value)
	,.test_1_inst_REG5_SINGLEPULSE__FIELD_0__curr_value(test_1_inst_REG5_SINGLEPULSE__FIELD_0__curr_value),.test_1_inst_REG6_SW_ACC_MOD__FIELD_0__curr_value(test_1_inst_REG6_SW_ACC_MOD__FIELD_0__curr_value),.test_1_inst_REG6_SW_ACC_MOD__FIELD_0__curr_value(test_1_inst_REG6_SW_ACC_MOD__FIELD_0__curr_value)
	,.test_1_inst_REG6_SW_ACC_MOD__FIELD_0__swacc_out(test_1_inst_REG6_SW_ACC_MOD__FIELD_0__swacc_out),.test_2_inst_shared_2__FIELD_0__curr_value(test_2_inst_shared_2__FIELD_0__curr_value),.test_3_inst_shared_3__FIELD_0__curr_value(test_3_inst_shared_3__FIELD_0__curr_value)
	
	);
endmodule