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
	,input clear
	,input interrupt
	//field interface port
	,input [32-1:0]test_12_shared_2__FIELD_0__next_value
	,input [1-1:0]test_12_shared_2__FIELD_0__pulse
	,input [32-1:0]test_12_shared_2__FIELD_0__next_value
	,output [32-1:0]test_12_shared_2__FIELD_0__curr_value
	,input [2-1:0]REG1_SW_RW__FIELD_8__next_value
	,input [1-1:0]REG1_SW_RW__FIELD_8__pulse
	,input [2-1:0]REG1_SW_RW__FIELD_8__next_value
	,input [2-1:0]REG1_SW_RW__FIELD_7__next_value
	,input [1-1:0]REG1_SW_RW__FIELD_7__pulse
	,input [2-1:0]REG1_SW_RW__FIELD_7__next_value
	,input [2-1:0]REG1_SW_RW__FIELD_6__next_value
	,input [1-1:0]REG1_SW_RW__FIELD_6__pulse
	,input [2-1:0]REG1_SW_RW__FIELD_6__next_value
	,input [2-1:0]REG1_SW_RW__FIELD_5__next_value
	,input [1-1:0]REG1_SW_RW__FIELD_5__pulse
	,input [2-1:0]REG1_SW_RW__FIELD_5__next_value
	,input [2-1:0]REG1_SW_RW__FIELD_4__next_value
	,input [1-1:0]REG1_SW_RW__FIELD_4__pulse
	,input [2-1:0]REG1_SW_RW__FIELD_4__next_value
	,input [2-1:0]REG1_SW_RW__FIELD_3__next_value
	,input [1-1:0]REG1_SW_RW__FIELD_3__pulse
	,input [2-1:0]REG1_SW_RW__FIELD_3__next_value
	,input [2-1:0]REG1_SW_RW__FIELD_2__next_value
	,input [1-1:0]REG1_SW_RW__FIELD_2__pulse
	,input [2-1:0]REG1_SW_RW__FIELD_2__next_value
	,input [2-1:0]REG1_SW_RW__FIELD_1__next_value
	,input [1-1:0]REG1_SW_RW__FIELD_1__pulse
	,input [2-1:0]REG1_SW_RW__FIELD_1__next_value
	,input [2-1:0]REG1_SW_RW__FIELD_0__next_value
	,input [1-1:0]REG1_SW_RW__FIELD_0__pulse
	,input [2-1:0]REG1_SW_RW__FIELD_0__next_value
	,input [2-1:0]REG2_SW_W__FIELD_6__next_value
	,input [1-1:0]REG2_SW_W__FIELD_6__pulse
	,input [2-1:0]REG2_SW_W__FIELD_6__next_value
	,input [2-1:0]REG2_SW_W__FIELD_5__next_value
	,input [1-1:0]REG2_SW_W__FIELD_5__pulse
	,input [2-1:0]REG2_SW_W__FIELD_5__next_value
	,input [2-1:0]REG2_SW_W__FIELD_4__next_value
	,input [1-1:0]REG2_SW_W__FIELD_4__pulse
	,input [2-1:0]REG2_SW_W__FIELD_4__next_value
	,input [2-1:0]REG2_SW_W__FIELD_3__next_value
	,input [1-1:0]REG2_SW_W__FIELD_3__pulse
	,input [2-1:0]REG2_SW_W__FIELD_3__next_value
	,input [2-1:0]REG2_SW_W__FIELD_2__next_value
	,input [1-1:0]REG2_SW_W__FIELD_2__pulse
	,input [2-1:0]REG2_SW_W__FIELD_2__next_value
	,input [2-1:0]REG2_SW_W__FIELD_1__next_value
	,input [1-1:0]REG2_SW_W__FIELD_1__pulse
	,input [2-1:0]REG2_SW_W__FIELD_1__next_value
	,input [2-1:0]REG2_SW_W__FIELD_0__next_value
	,input [1-1:0]REG2_SW_W__FIELD_0__pulse
	,input [2-1:0]REG2_SW_W__FIELD_0__next_value
	,input [2-1:0]REG3_HW__FIELD_3__next_value
	,input [1-1:0]REG3_HW__FIELD_3__pulse
	,input [2-1:0]REG3_HW__FIELD_3__next_value
	,input [2-1:0]REG3_HW__FIELD_2__next_value
	,input [1-1:0]REG3_HW__FIELD_2__pulse
	,input [2-1:0]REG3_HW__FIELD_2__next_value
	,input [2-1:0]REG3_HW__FIELD_2__next_value
	,input [2-1:0]REG3_HW__FIELD_0__next_value
	,input [1-1:0]REG3_HW__FIELD_0__pulse
	,input [2-1:0]REG3_HW__FIELD_0__next_value
	,input [2-1:0]REG4_PRECEDENCE__FIELD_1__next_value
	,input [1-1:0]REG4_PRECEDENCE__FIELD_1__pulse
	,input [2-1:0]REG4_PRECEDENCE__FIELD_1__next_value
	,input [2-1:0]REG4_PRECEDENCE__FIELD_0__next_value
	,input [1-1:0]REG4_PRECEDENCE__FIELD_0__pulse
	,input [2-1:0]REG4_PRECEDENCE__FIELD_0__next_value
	,input [1-1:0]REG5_SINGLEPULSE__FIELD_0__next_value
	,input [1-1:0]REG5_SINGLEPULSE__FIELD_0__pulse
	,input [1-1:0]REG5_SINGLEPULSE__FIELD_0__next_value
	,input [2-1:0]REG6_SW_ACC_MOD__FIELD_0__next_value
	,input [1-1:0]REG6_SW_ACC_MOD__FIELD_0__pulse
	,input [2-1:0]REG6_SW_ACC_MOD__FIELD_0__next_value
	,output [2-1:0]REG1_SW_RW__FIELD_8__curr_value
	,output [2-1:0]REG1_SW_RW__FIELD_7__curr_value
	,output [2-1:0]REG1_SW_RW__FIELD_6__curr_value
	,output [2-1:0]REG1_SW_RW__FIELD_5__curr_value
	,output [2-1:0]REG1_SW_RW__FIELD_4__curr_value
	,output [2-1:0]REG1_SW_RW__FIELD_3__curr_value
	,output [2-1:0]REG1_SW_RW__FIELD_2__curr_value
	,output [2-1:0]REG1_SW_RW__FIELD_1__curr_value
	,output [2-1:0]REG1_SW_RW__FIELD_0__curr_value
	,output [2-1:0]REG2_SW_W__FIELD_6__curr_value
	,output [2-1:0]REG2_SW_W__FIELD_5__curr_value
	,output [2-1:0]REG2_SW_W__FIELD_4__curr_value
	,output [2-1:0]REG2_SW_W__FIELD_3__curr_value
	,output [2-1:0]REG2_SW_W__FIELD_2__curr_value
	,output [2-1:0]REG2_SW_W__FIELD_1__curr_value
	,output [2-1:0]REG2_SW_W__FIELD_0__curr_value
	,output [2-1:0]REG3_HW__FIELD_3__curr_value
	,output [2-1:0]REG3_HW__FIELD_2__curr_value
	,output [2-1:0]REG3_HW__FIELD_1__curr_value
	,output [2-1:0]REG3_HW__FIELD_0__curr_value
	,output [2-1:0]REG4_PRECEDENCE__FIELD_1__curr_value
	,output [2-1:0]REG4_PRECEDENCE__FIELD_0__curr_value
	,output [1-1:0]REG5_SINGLEPULSE__FIELD_0__curr_value
	,output [2-1:0]REG6_SW_ACC_MOD__FIELD_0__curr_value
	,output [2-1:0]REG6_SW_ACC_MOD__FIELD_0__curr_value
	,output [1-1:0]REG6_SW_ACC_MOD__FIELD_0__swacc_out
	,input [2-1:0]test_21_REG1_SW_RW__FIELD_8__next_value
	,input [1-1:0]test_21_REG1_SW_RW__FIELD_8__pulse
	,input [2-1:0]test_21_REG1_SW_RW__FIELD_8__next_value
	,input [2-1:0]test_21_REG1_SW_RW__FIELD_7__next_value
	,input [1-1:0]test_21_REG1_SW_RW__FIELD_7__pulse
	,input [2-1:0]test_21_REG1_SW_RW__FIELD_7__next_value
	,input [2-1:0]test_21_REG1_SW_RW__FIELD_6__next_value
	,input [1-1:0]test_21_REG1_SW_RW__FIELD_6__pulse
	,input [2-1:0]test_21_REG1_SW_RW__FIELD_6__next_value
	,input [2-1:0]test_21_REG1_SW_RW__FIELD_5__next_value
	,input [1-1:0]test_21_REG1_SW_RW__FIELD_5__pulse
	,input [2-1:0]test_21_REG1_SW_RW__FIELD_5__next_value
	,input [2-1:0]test_21_REG1_SW_RW__FIELD_4__next_value
	,input [1-1:0]test_21_REG1_SW_RW__FIELD_4__pulse
	,input [2-1:0]test_21_REG1_SW_RW__FIELD_4__next_value
	,input [2-1:0]test_21_REG1_SW_RW__FIELD_3__next_value
	,input [1-1:0]test_21_REG1_SW_RW__FIELD_3__pulse
	,input [2-1:0]test_21_REG1_SW_RW__FIELD_3__next_value
	,input [2-1:0]test_21_REG1_SW_RW__FIELD_2__next_value
	,input [1-1:0]test_21_REG1_SW_RW__FIELD_2__pulse
	,input [2-1:0]test_21_REG1_SW_RW__FIELD_2__next_value
	,input [2-1:0]test_21_REG1_SW_RW__FIELD_1__next_value
	,input [1-1:0]test_21_REG1_SW_RW__FIELD_1__pulse
	,input [2-1:0]test_21_REG1_SW_RW__FIELD_1__next_value
	,input [2-1:0]test_21_REG1_SW_RW__FIELD_0__next_value
	,input [1-1:0]test_21_REG1_SW_RW__FIELD_0__pulse
	,input [2-1:0]test_21_REG1_SW_RW__FIELD_0__next_value
	,input [2-1:0]test_21_REG2_SW_W__FIELD_6__next_value
	,input [1-1:0]test_21_REG2_SW_W__FIELD_6__pulse
	,input [2-1:0]test_21_REG2_SW_W__FIELD_6__next_value
	,input [2-1:0]test_21_REG2_SW_W__FIELD_5__next_value
	,input [1-1:0]test_21_REG2_SW_W__FIELD_5__pulse
	,input [2-1:0]test_21_REG2_SW_W__FIELD_5__next_value
	,input [2-1:0]test_21_REG2_SW_W__FIELD_4__next_value
	,input [1-1:0]test_21_REG2_SW_W__FIELD_4__pulse
	,input [2-1:0]test_21_REG2_SW_W__FIELD_4__next_value
	,input [2-1:0]test_21_REG2_SW_W__FIELD_3__next_value
	,input [1-1:0]test_21_REG2_SW_W__FIELD_3__pulse
	,input [2-1:0]test_21_REG2_SW_W__FIELD_3__next_value
	,input [2-1:0]test_21_REG2_SW_W__FIELD_2__next_value
	,input [1-1:0]test_21_REG2_SW_W__FIELD_2__pulse
	,input [2-1:0]test_21_REG2_SW_W__FIELD_2__next_value
	,input [2-1:0]test_21_REG2_SW_W__FIELD_1__next_value
	,input [1-1:0]test_21_REG2_SW_W__FIELD_1__pulse
	,input [2-1:0]test_21_REG2_SW_W__FIELD_1__next_value
	,input [2-1:0]test_21_REG2_SW_W__FIELD_0__next_value
	,input [1-1:0]test_21_REG2_SW_W__FIELD_0__pulse
	,input [2-1:0]test_21_REG2_SW_W__FIELD_0__next_value
	,input [2-1:0]test_21_REG3_HW__FIELD_3__next_value
	,input [1-1:0]test_21_REG3_HW__FIELD_3__pulse
	,input [2-1:0]test_21_REG3_HW__FIELD_3__next_value
	,input [2-1:0]test_21_REG3_HW__FIELD_2__next_value
	,input [1-1:0]test_21_REG3_HW__FIELD_2__pulse
	,input [2-1:0]test_21_REG3_HW__FIELD_2__next_value
	,input [2-1:0]test_21_REG3_HW__FIELD_2__next_value
	,input [2-1:0]test_21_REG3_HW__FIELD_0__next_value
	,input [1-1:0]test_21_REG3_HW__FIELD_0__pulse
	,input [2-1:0]test_21_REG3_HW__FIELD_0__next_value
	,input [2-1:0]test_21_REG4_PRECEDENCE__FIELD_1__next_value
	,input [1-1:0]test_21_REG4_PRECEDENCE__FIELD_1__pulse
	,input [2-1:0]test_21_REG4_PRECEDENCE__FIELD_1__next_value
	,input [2-1:0]test_21_REG4_PRECEDENCE__FIELD_0__next_value
	,input [1-1:0]test_21_REG4_PRECEDENCE__FIELD_0__pulse
	,input [2-1:0]test_21_REG4_PRECEDENCE__FIELD_0__next_value
	,input [1-1:0]test_21_REG5_SINGLEPULSE__FIELD_0__next_value
	,input [1-1:0]test_21_REG5_SINGLEPULSE__FIELD_0__pulse
	,input [1-1:0]test_21_REG5_SINGLEPULSE__FIELD_0__next_value
	,input [2-1:0]test_21_REG6_SW_ACC_MOD__FIELD_0__next_value
	,input [1-1:0]test_21_REG6_SW_ACC_MOD__FIELD_0__pulse
	,input [2-1:0]test_21_REG6_SW_ACC_MOD__FIELD_0__next_value
	,input [32-1:0]test_22_shared_2__FIELD_0__next_value
	,input [1-1:0]test_22_shared_2__FIELD_0__pulse
	,input [32-1:0]test_22_shared_2__FIELD_0__next_value
	,output [2-1:0]test_21_REG1_SW_RW__FIELD_8__curr_value
	,output [2-1:0]test_21_REG1_SW_RW__FIELD_7__curr_value
	,output [2-1:0]test_21_REG1_SW_RW__FIELD_6__curr_value
	,output [2-1:0]test_21_REG1_SW_RW__FIELD_5__curr_value
	,output [2-1:0]test_21_REG1_SW_RW__FIELD_4__curr_value
	,output [2-1:0]test_21_REG1_SW_RW__FIELD_3__curr_value
	,output [2-1:0]test_21_REG1_SW_RW__FIELD_2__curr_value
	,output [2-1:0]test_21_REG1_SW_RW__FIELD_1__curr_value
	,output [2-1:0]test_21_REG1_SW_RW__FIELD_0__curr_value
	,output [2-1:0]test_21_REG2_SW_W__FIELD_6__curr_value
	,output [2-1:0]test_21_REG2_SW_W__FIELD_5__curr_value
	,output [2-1:0]test_21_REG2_SW_W__FIELD_4__curr_value
	,output [2-1:0]test_21_REG2_SW_W__FIELD_3__curr_value
	,output [2-1:0]test_21_REG2_SW_W__FIELD_2__curr_value
	,output [2-1:0]test_21_REG2_SW_W__FIELD_1__curr_value
	,output [2-1:0]test_21_REG2_SW_W__FIELD_0__curr_value
	,output [2-1:0]test_21_REG3_HW__FIELD_3__curr_value
	,output [2-1:0]test_21_REG3_HW__FIELD_2__curr_value
	,output [2-1:0]test_21_REG3_HW__FIELD_1__curr_value
	,output [2-1:0]test_21_REG3_HW__FIELD_0__curr_value
	,output [2-1:0]test_21_REG4_PRECEDENCE__FIELD_1__curr_value
	,output [2-1:0]test_21_REG4_PRECEDENCE__FIELD_0__curr_value
	,output [1-1:0]test_21_REG5_SINGLEPULSE__FIELD_0__curr_value
	,output [2-1:0]test_21_REG6_SW_ACC_MOD__FIELD_0__curr_value
	,output [2-1:0]test_21_REG6_SW_ACC_MOD__FIELD_0__curr_value
	,output [1-1:0]test_21_REG6_SW_ACC_MOD__FIELD_0__swacc_out
	,output [32-1:0]test_22_shared_2__FIELD_0__curr_value
	//field interface end
	//sync_reset interface start
	,input srst_1
	,input srst_2
	,input test_21_srst_1
	,input test_21_srst_2
	//sync_reset interface end
//external IP/memory port declare
	,output regslv_reg_block_1__ext_mem_11_req_vld
	,input regslv_reg_block_1__ext_mem_11_ack_vld
	,input regslv_reg_block_1__ext_mem_11_req_rdy
	,output regslv_reg_block_1__ext_mem_11_ack_rdy
	,input [DATA_WIDTH-1:0]regslv_reg_block_1__ext_mem_11_rd_data
	,output regslv_reg_block_2__ext_mem_21_req_vld
	,input regslv_reg_block_2__ext_mem_21_ack_vld
	,input regslv_reg_block_2__ext_mem_21_req_rdy
	,output regslv_reg_block_2__ext_mem_21_ack_rdy
	,input [DATA_WIDTH-1:0]regslv_reg_block_2__ext_mem_21_rd_data
	,output regslv_reg_block_2__ext_mem_22_req_vld
	,input regslv_reg_block_2__ext_mem_22_ack_vld
	,input regslv_reg_block_2__ext_mem_22_req_rdy
	,output regslv_reg_block_2__ext_mem_22_ack_rdy
	,input [DATA_WIDTH-1:0]regslv_reg_block_2__ext_mem_22_rd_data
	,output regslv_reg_block_2__ext_mem_23_req_vld
	,input regslv_reg_block_2__ext_mem_23_ack_vld
	,input regslv_reg_block_2__ext_mem_23_req_rdy
	,output regslv_reg_block_2__ext_mem_23_ack_rdy
	,input [DATA_WIDTH-1:0]regslv_reg_block_2__ext_mem_23_rd_data
	,output regslv_reg_top__ext_mem_in_top_req_vld
	,input regslv_reg_top__ext_mem_in_top_ack_vld
	,input regslv_reg_top__ext_mem_in_top_req_rdy
	,output regslv_reg_top__ext_mem_in_top_ack_rdy
	,input [DATA_WIDTH-1:0]regslv_reg_top__ext_mem_in_top_rd_data
//external IP/memory port declare
	,output regslv_reg_block_1_addr
	,output regslv_reg_block_1_wr_en
	,output regslv_reg_block_1_rd_en
	,output regslv_reg_block_1_wr_data
	,output regslv_reg_block_1_fsm_sync_reset
	,output regslv_reg_block_2_addr
	,output regslv_reg_block_2_wr_en
	,output regslv_reg_block_2_rd_en
	,output regslv_reg_block_2_wr_data
	,output regslv_reg_block_2_fsm_sync_reset
//external IP/memory port end
);
//parameter instance here
parameter ADDR_WIDTH = 64;
parameter DATA_WIDTH = 32;
//wire definition here
logic [3-1:0] regmst_reg_top_ext_req_vld;
logic [3-1:0] regmst_reg_top_ext_req_rdy;
logic [3-1:0] regmst_reg_top_ext_ack_vld;
logic [3-1:0] regmst_reg_top_ext_ack_rdy;
logic [3-1:0] [DATA_WIDTH-1:0]regmst_reg_top_ext_rd_data;
logic regmst_reg_top_wr_en;
logic regmst_reg_top_rd_en;
logic regmst_reg_top_fsm_sync_reset;
logic [DATA_WIDTH-1:0]regmst_reg_top_wr_data;
logic [DATA_WIDTH-1:0] regmst_reg_top_addr;
logic [2-1:0] regslv_reg_block_1_ext_req_vld;
logic [2-1:0] regslv_reg_block_1_ext_req_rdy;
logic [2-1:0] regslv_reg_block_1_ext_ack_vld;
logic [2-1:0] regslv_reg_block_1_ext_ack_rdy;
logic [2-1:0] [DATA_WIDTH-1:0]regslv_reg_block_1_ext_rd_data;
logic regslv_reg_block_1_wr_en;
logic regslv_reg_block_1_rd_en;
logic regslv_reg_block_1_fsm_sync_reset;
logic [DATA_WIDTH-1:0]regslv_reg_block_1_wr_data;
logic [DATA_WIDTH-1:0] regslv_reg_block_1_addr;
logic [3-1:0] regslv_reg_block_2_ext_req_vld;
logic [3-1:0] regslv_reg_block_2_ext_req_rdy;
logic [3-1:0] regslv_reg_block_2_ext_ack_vld;
logic [3-1:0] regslv_reg_block_2_ext_ack_rdy;
logic [3-1:0] [DATA_WIDTH-1:0]regslv_reg_block_2_ext_rd_data;
logic regslv_reg_block_2_wr_en;
logic regslv_reg_block_2_rd_en;
logic regslv_reg_block_2_fsm_sync_reset;
logic [DATA_WIDTH-1:0]regslv_reg_block_2_wr_data;
logic [DATA_WIDTH-1:0] regslv_reg_block_2_addr;
//external IP/memory port define
//external: ext_mem_11 ref:regslv_reg_block_1  wire connection define
assign regslv_reg_block_1__ext_mem_11_req_vld = regslv_reg_block_1_ext_req_vld[1];
assign regslv_reg_block_1__ext_mem_11_ack_rdy = regslv_reg_block_1_ext_ack_rdy;
assign regslv_reg_block_1_ext_ack_vld[1] = regslv_reg_block_1__ext_mem_11_ack_vld;
assign regslv_reg_block_1_ext_req_rdy[1] = regslv_reg_block_1__ext_mem_11_req_rdy;
assign regslv_reg_block_1_ext_rd_data[1] = regslv_reg_block_1__ext_mem_11_rd_data;
//external: ext_mem_21 ref:regslv_reg_block_2  wire connection define
assign regslv_reg_block_2__ext_mem_21_req_vld = regslv_reg_block_2_ext_req_vld[0];
assign regslv_reg_block_2__ext_mem_21_ack_rdy = regslv_reg_block_2_ext_ack_rdy;
assign regslv_reg_block_2_ext_ack_vld[0] = regslv_reg_block_2__ext_mem_21_ack_vld;
assign regslv_reg_block_2_ext_req_rdy[0] = regslv_reg_block_2__ext_mem_21_req_rdy;
assign regslv_reg_block_2_ext_rd_data[0] = regslv_reg_block_2__ext_mem_21_rd_data;
//external: ext_mem_22 ref:regslv_reg_block_2  wire connection define
assign regslv_reg_block_2__ext_mem_22_req_vld = regslv_reg_block_2_ext_req_vld[1];
assign regslv_reg_block_2__ext_mem_22_ack_rdy = regslv_reg_block_2_ext_ack_rdy;
assign regslv_reg_block_2_ext_ack_vld[1] = regslv_reg_block_2__ext_mem_22_ack_vld;
assign regslv_reg_block_2_ext_req_rdy[1] = regslv_reg_block_2__ext_mem_22_req_rdy;
assign regslv_reg_block_2_ext_rd_data[1] = regslv_reg_block_2__ext_mem_22_rd_data;
//external: ext_mem_23 ref:regslv_reg_block_2  wire connection define
assign regslv_reg_block_2__ext_mem_23_req_vld = regslv_reg_block_2_ext_req_vld[2];
assign regslv_reg_block_2__ext_mem_23_ack_rdy = regslv_reg_block_2_ext_ack_rdy;
assign regslv_reg_block_2_ext_ack_vld[2] = regslv_reg_block_2__ext_mem_23_ack_vld;
assign regslv_reg_block_2_ext_req_rdy[2] = regslv_reg_block_2__ext_mem_23_req_rdy;
assign regslv_reg_block_2_ext_rd_data[2] = regslv_reg_block_2__ext_mem_23_rd_data;
//external: ext_mem_in_top ref:regslv_reg_top  wire connection define
assign regslv_reg_top__ext_mem_in_top_req_vld = regslv_reg_top_ext_req_vld[2];
assign regslv_reg_top__ext_mem_in_top_ack_rdy = regslv_reg_top_ext_ack_rdy;
assign regslv_reg_top_ext_ack_vld[2] = regslv_reg_top__ext_mem_in_top_ack_vld;
assign regslv_reg_top_ext_req_rdy[2] = regslv_reg_top__ext_mem_in_top_req_rdy;
assign regslv_reg_top_ext_rd_data[2] = regslv_reg_top__ext_mem_in_top_rd_data;
//reg module instance here
regmst_reg_top #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
	regmst_reg_top (
	//reg_module upstream interface instance
	.clk(clk),.rstn(rstn),.req_vld(req_vld),.req_rdy(req_rdy)
	,.wr_en(wr_en),.rd_en(rd_en),.addr(addr),.wr_data(wr_data)
	,.ack_vld(ack_vld),.ack_rdy(ack_rdy),.rd_data(rd_data)
	,.clear(clear), .interrupt(interrupt)
	//reg_slv downstream interface instance
	,.global_sync_out(regmst_reg_top_fsm_sync_reset),.ext_req_vld(regmst_reg_top_ext_req_vld),.ext_req_rdy(regmst_reg_top_ext_req_rdy).ext_ack_vld(regmst_reg_top_ext_ack_vld).ext_ack_rdy(regmst_reg_top_ext_ack_rdy).ext_rd_data(regmst_reg_top_ext_rd_data)
	,.wr_en_ff(regmst_reg_top_wr_en),.rd_en_ff(regmst_reg_top_rd_en),.wr_data_ff(regmst_reg_top_wr_data),.addr_ff(regmst_reg_top_addr),
	//field ports instance
	
	);
regslv_reg_block_1 #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
	regslv_reg_block_1 (
	//reg_module upstream interface instance
	.clk(clk),.rstn(rstn),.req_vld(regslv_reg_top_ext_req_vld[0]),.req_rdy(regslv_reg_top_ext_req_rdy[0])
	,.wr_en(regslv_reg_top_wr_en),.rd_en(regslv_reg_top_rd_en),.addr(regslv_reg_top_addr),.wr_data(regslv_reg_top_wr_data)
	,.ack_vld(regslv_reg_top_ext_ack_vld[0]),.ack_rdy(regslv_reg_top_ext_ack_rdy[0]),.rd_data(regslv_reg_top_ext_rd_data[0])
	,.global_sync_in(regslv_reg_top_fsm_sync_reset)
	//reg_slv downstream interface instance
	,.global_sync_out(regslv_reg_block_1_fsm_sync_reset),.ext_req_vld(regslv_reg_block_1_ext_req_vld),.ext_req_rdy(regslv_reg_block_1_ext_req_rdy).ext_ack_vld(regslv_reg_block_1_ext_ack_vld).ext_ack_rdy(regslv_reg_block_1_ext_ack_rdy).ext_rd_data(regslv_reg_block_1_ext_rd_data)
	,.wr_en_ff(regslv_reg_block_1_wr_en),.rd_en_ff(regslv_reg_block_1_rd_en),.wr_data_ff(regslv_reg_block_1_wr_data),.addr_ff(regslv_reg_block_1_addr),
	//field ports instance
	,.test_12_shared_2__FIELD_0__next_value(test_12_shared_2__FIELD_0__next_value),.test_12_shared_2__FIELD_0__pulse(test_12_shared_2__FIELD_0__pulse),.test_12_shared_2__FIELD_0__next_value(test_12_shared_2__FIELD_0__next_value)
	,.test_12_shared_2__FIELD_0__curr_value(test_12_shared_2__FIELD_0__curr_value)
	);
regslv_test_11 #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
	regslv_test_11 (
	//reg_module upstream interface instance
	.clk(clk),.rstn(rstn),.req_vld(regslv_reg_block_1_ext_req_vld[0]),.req_rdy(regslv_reg_block_1_ext_req_rdy[0])
	,.wr_en(regslv_reg_block_1_wr_en),.rd_en(regslv_reg_block_1_rd_en),.addr(regslv_reg_block_1_addr),.wr_data(regslv_reg_block_1_wr_data)
	,.ack_vld(regslv_reg_block_1_ext_ack_vld[0]),.ack_rdy(regslv_reg_block_1_ext_ack_rdy[0]),.rd_data(regslv_reg_block_1_ext_rd_data[0])
	,.global_sync_in(regslv_reg_block_1_fsm_sync_reset)
	,.srst_1(srst_1)
	,.srst_2(srst_2)
	//field ports instance
	,.REG1_SW_RW__FIELD_8__next_value(REG1_SW_RW__FIELD_8__next_value),.REG1_SW_RW__FIELD_8__pulse(REG1_SW_RW__FIELD_8__pulse),.REG1_SW_RW__FIELD_8__next_value(REG1_SW_RW__FIELD_8__next_value)
	,.REG1_SW_RW__FIELD_7__next_value(REG1_SW_RW__FIELD_7__next_value),.REG1_SW_RW__FIELD_7__pulse(REG1_SW_RW__FIELD_7__pulse),.REG1_SW_RW__FIELD_7__next_value(REG1_SW_RW__FIELD_7__next_value)
	,.REG1_SW_RW__FIELD_6__next_value(REG1_SW_RW__FIELD_6__next_value),.REG1_SW_RW__FIELD_6__pulse(REG1_SW_RW__FIELD_6__pulse),.REG1_SW_RW__FIELD_6__next_value(REG1_SW_RW__FIELD_6__next_value)
	,.REG1_SW_RW__FIELD_5__next_value(REG1_SW_RW__FIELD_5__next_value),.REG1_SW_RW__FIELD_5__pulse(REG1_SW_RW__FIELD_5__pulse),.REG1_SW_RW__FIELD_5__next_value(REG1_SW_RW__FIELD_5__next_value)
	,.REG1_SW_RW__FIELD_4__next_value(REG1_SW_RW__FIELD_4__next_value),.REG1_SW_RW__FIELD_4__pulse(REG1_SW_RW__FIELD_4__pulse),.REG1_SW_RW__FIELD_4__next_value(REG1_SW_RW__FIELD_4__next_value)
	,.REG1_SW_RW__FIELD_3__next_value(REG1_SW_RW__FIELD_3__next_value),.REG1_SW_RW__FIELD_3__pulse(REG1_SW_RW__FIELD_3__pulse),.REG1_SW_RW__FIELD_3__next_value(REG1_SW_RW__FIELD_3__next_value)
	,.REG1_SW_RW__FIELD_2__next_value(REG1_SW_RW__FIELD_2__next_value),.REG1_SW_RW__FIELD_2__pulse(REG1_SW_RW__FIELD_2__pulse),.REG1_SW_RW__FIELD_2__next_value(REG1_SW_RW__FIELD_2__next_value)
	,.REG1_SW_RW__FIELD_1__next_value(REG1_SW_RW__FIELD_1__next_value),.REG1_SW_RW__FIELD_1__pulse(REG1_SW_RW__FIELD_1__pulse),.REG1_SW_RW__FIELD_1__next_value(REG1_SW_RW__FIELD_1__next_value)
	,.REG1_SW_RW__FIELD_0__next_value(REG1_SW_RW__FIELD_0__next_value),.REG1_SW_RW__FIELD_0__pulse(REG1_SW_RW__FIELD_0__pulse),.REG1_SW_RW__FIELD_0__next_value(REG1_SW_RW__FIELD_0__next_value)
	,.REG2_SW_W__FIELD_6__next_value(REG2_SW_W__FIELD_6__next_value),.REG2_SW_W__FIELD_6__pulse(REG2_SW_W__FIELD_6__pulse),.REG2_SW_W__FIELD_6__next_value(REG2_SW_W__FIELD_6__next_value)
	,.REG2_SW_W__FIELD_5__next_value(REG2_SW_W__FIELD_5__next_value),.REG2_SW_W__FIELD_5__pulse(REG2_SW_W__FIELD_5__pulse),.REG2_SW_W__FIELD_5__next_value(REG2_SW_W__FIELD_5__next_value)
	,.REG2_SW_W__FIELD_4__next_value(REG2_SW_W__FIELD_4__next_value),.REG2_SW_W__FIELD_4__pulse(REG2_SW_W__FIELD_4__pulse),.REG2_SW_W__FIELD_4__next_value(REG2_SW_W__FIELD_4__next_value)
	,.REG2_SW_W__FIELD_3__next_value(REG2_SW_W__FIELD_3__next_value),.REG2_SW_W__FIELD_3__pulse(REG2_SW_W__FIELD_3__pulse),.REG2_SW_W__FIELD_3__next_value(REG2_SW_W__FIELD_3__next_value)
	,.REG2_SW_W__FIELD_2__next_value(REG2_SW_W__FIELD_2__next_value),.REG2_SW_W__FIELD_2__pulse(REG2_SW_W__FIELD_2__pulse),.REG2_SW_W__FIELD_2__next_value(REG2_SW_W__FIELD_2__next_value)
	,.REG2_SW_W__FIELD_1__next_value(REG2_SW_W__FIELD_1__next_value),.REG2_SW_W__FIELD_1__pulse(REG2_SW_W__FIELD_1__pulse),.REG2_SW_W__FIELD_1__next_value(REG2_SW_W__FIELD_1__next_value)
	,.REG2_SW_W__FIELD_0__next_value(REG2_SW_W__FIELD_0__next_value),.REG2_SW_W__FIELD_0__pulse(REG2_SW_W__FIELD_0__pulse),.REG2_SW_W__FIELD_0__next_value(REG2_SW_W__FIELD_0__next_value)
	,.REG3_HW__FIELD_3__next_value(REG3_HW__FIELD_3__next_value),.REG3_HW__FIELD_3__pulse(REG3_HW__FIELD_3__pulse),.REG3_HW__FIELD_3__next_value(REG3_HW__FIELD_3__next_value)
	,.REG3_HW__FIELD_2__next_value(REG3_HW__FIELD_2__next_value),.REG3_HW__FIELD_2__pulse(REG3_HW__FIELD_2__pulse),.REG3_HW__FIELD_2__next_value(REG3_HW__FIELD_2__next_value)
	,.REG3_HW__FIELD_2__next_value(REG3_HW__FIELD_2__next_value),.REG3_HW__FIELD_0__next_value(REG3_HW__FIELD_0__next_value),.REG3_HW__FIELD_0__pulse(REG3_HW__FIELD_0__pulse)
	,.REG3_HW__FIELD_0__next_value(REG3_HW__FIELD_0__next_value),.REG4_PRECEDENCE__FIELD_1__next_value(REG4_PRECEDENCE__FIELD_1__next_value),.REG4_PRECEDENCE__FIELD_1__pulse(REG4_PRECEDENCE__FIELD_1__pulse)
	,.REG4_PRECEDENCE__FIELD_1__next_value(REG4_PRECEDENCE__FIELD_1__next_value),.REG4_PRECEDENCE__FIELD_0__next_value(REG4_PRECEDENCE__FIELD_0__next_value),.REG4_PRECEDENCE__FIELD_0__pulse(REG4_PRECEDENCE__FIELD_0__pulse)
	,.REG4_PRECEDENCE__FIELD_0__next_value(REG4_PRECEDENCE__FIELD_0__next_value),.REG5_SINGLEPULSE__FIELD_0__next_value(REG5_SINGLEPULSE__FIELD_0__next_value),.REG5_SINGLEPULSE__FIELD_0__pulse(REG5_SINGLEPULSE__FIELD_0__pulse)
	,.REG5_SINGLEPULSE__FIELD_0__next_value(REG5_SINGLEPULSE__FIELD_0__next_value),.REG6_SW_ACC_MOD__FIELD_0__next_value(REG6_SW_ACC_MOD__FIELD_0__next_value),.REG6_SW_ACC_MOD__FIELD_0__pulse(REG6_SW_ACC_MOD__FIELD_0__pulse)
	,.REG6_SW_ACC_MOD__FIELD_0__next_value(REG6_SW_ACC_MOD__FIELD_0__next_value),.REG1_SW_RW__FIELD_8__curr_value(REG1_SW_RW__FIELD_8__curr_value),.REG1_SW_RW__FIELD_7__curr_value(REG1_SW_RW__FIELD_7__curr_value)
	,.REG1_SW_RW__FIELD_6__curr_value(REG1_SW_RW__FIELD_6__curr_value),.REG1_SW_RW__FIELD_5__curr_value(REG1_SW_RW__FIELD_5__curr_value),.REG1_SW_RW__FIELD_4__curr_value(REG1_SW_RW__FIELD_4__curr_value)
	,.REG1_SW_RW__FIELD_3__curr_value(REG1_SW_RW__FIELD_3__curr_value),.REG1_SW_RW__FIELD_2__curr_value(REG1_SW_RW__FIELD_2__curr_value),.REG1_SW_RW__FIELD_1__curr_value(REG1_SW_RW__FIELD_1__curr_value)
	,.REG1_SW_RW__FIELD_0__curr_value(REG1_SW_RW__FIELD_0__curr_value),.REG2_SW_W__FIELD_6__curr_value(REG2_SW_W__FIELD_6__curr_value),.REG2_SW_W__FIELD_5__curr_value(REG2_SW_W__FIELD_5__curr_value)
	,.REG2_SW_W__FIELD_4__curr_value(REG2_SW_W__FIELD_4__curr_value),.REG2_SW_W__FIELD_3__curr_value(REG2_SW_W__FIELD_3__curr_value),.REG2_SW_W__FIELD_2__curr_value(REG2_SW_W__FIELD_2__curr_value)
	,.REG2_SW_W__FIELD_1__curr_value(REG2_SW_W__FIELD_1__curr_value),.REG2_SW_W__FIELD_0__curr_value(REG2_SW_W__FIELD_0__curr_value),.REG3_HW__FIELD_3__curr_value(REG3_HW__FIELD_3__curr_value)
	,.REG3_HW__FIELD_2__curr_value(REG3_HW__FIELD_2__curr_value),.REG3_HW__FIELD_1__curr_value(REG3_HW__FIELD_1__curr_value),.REG3_HW__FIELD_0__curr_value(REG3_HW__FIELD_0__curr_value)
	,.REG4_PRECEDENCE__FIELD_1__curr_value(REG4_PRECEDENCE__FIELD_1__curr_value),.REG4_PRECEDENCE__FIELD_0__curr_value(REG4_PRECEDENCE__FIELD_0__curr_value),.REG5_SINGLEPULSE__FIELD_0__curr_value(REG5_SINGLEPULSE__FIELD_0__curr_value)
	,.REG6_SW_ACC_MOD__FIELD_0__curr_value(REG6_SW_ACC_MOD__FIELD_0__curr_value),.REG6_SW_ACC_MOD__FIELD_0__curr_value(REG6_SW_ACC_MOD__FIELD_0__curr_value),.REG6_SW_ACC_MOD__FIELD_0__swacc_out(REG6_SW_ACC_MOD__FIELD_0__swacc_out)
	
	);
regslv_reg_block_2 #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
	regslv_reg_block_2 (
	//reg_module upstream interface instance
	.clk(clk),.rstn(rstn),.req_vld(regslv_reg_top_ext_req_vld[1]),.req_rdy(regslv_reg_top_ext_req_rdy[1])
	,.wr_en(regslv_reg_top_wr_en),.rd_en(regslv_reg_top_rd_en),.addr(regslv_reg_top_addr),.wr_data(regslv_reg_top_wr_data)
	,.ack_vld(regslv_reg_top_ext_ack_vld[1]),.ack_rdy(regslv_reg_top_ext_ack_rdy[1]),.rd_data(regslv_reg_top_ext_rd_data[1])
	,.global_sync_in(regslv_reg_top_fsm_sync_reset)
	,.test_21_srst_1(test_21_srst_1)
	,.test_21_srst_2(test_21_srst_2)
	//reg_slv downstream interface instance
	,.global_sync_out(regslv_reg_block_2_fsm_sync_reset),.ext_req_vld(regslv_reg_block_2_ext_req_vld),.ext_req_rdy(regslv_reg_block_2_ext_req_rdy).ext_ack_vld(regslv_reg_block_2_ext_ack_vld).ext_ack_rdy(regslv_reg_block_2_ext_ack_rdy).ext_rd_data(regslv_reg_block_2_ext_rd_data)
	,.wr_en_ff(regslv_reg_block_2_wr_en),.rd_en_ff(regslv_reg_block_2_rd_en),.wr_data_ff(regslv_reg_block_2_wr_data),.addr_ff(regslv_reg_block_2_addr),
	//field ports instance
	,.test_21_REG1_SW_RW__FIELD_8__next_value(test_21_REG1_SW_RW__FIELD_8__next_value),.test_21_REG1_SW_RW__FIELD_8__pulse(test_21_REG1_SW_RW__FIELD_8__pulse),.test_21_REG1_SW_RW__FIELD_8__next_value(test_21_REG1_SW_RW__FIELD_8__next_value)
	,.test_21_REG1_SW_RW__FIELD_7__next_value(test_21_REG1_SW_RW__FIELD_7__next_value),.test_21_REG1_SW_RW__FIELD_7__pulse(test_21_REG1_SW_RW__FIELD_7__pulse),.test_21_REG1_SW_RW__FIELD_7__next_value(test_21_REG1_SW_RW__FIELD_7__next_value)
	,.test_21_REG1_SW_RW__FIELD_6__next_value(test_21_REG1_SW_RW__FIELD_6__next_value),.test_21_REG1_SW_RW__FIELD_6__pulse(test_21_REG1_SW_RW__FIELD_6__pulse),.test_21_REG1_SW_RW__FIELD_6__next_value(test_21_REG1_SW_RW__FIELD_6__next_value)
	,.test_21_REG1_SW_RW__FIELD_5__next_value(test_21_REG1_SW_RW__FIELD_5__next_value),.test_21_REG1_SW_RW__FIELD_5__pulse(test_21_REG1_SW_RW__FIELD_5__pulse),.test_21_REG1_SW_RW__FIELD_5__next_value(test_21_REG1_SW_RW__FIELD_5__next_value)
	,.test_21_REG1_SW_RW__FIELD_4__next_value(test_21_REG1_SW_RW__FIELD_4__next_value),.test_21_REG1_SW_RW__FIELD_4__pulse(test_21_REG1_SW_RW__FIELD_4__pulse),.test_21_REG1_SW_RW__FIELD_4__next_value(test_21_REG1_SW_RW__FIELD_4__next_value)
	,.test_21_REG1_SW_RW__FIELD_3__next_value(test_21_REG1_SW_RW__FIELD_3__next_value),.test_21_REG1_SW_RW__FIELD_3__pulse(test_21_REG1_SW_RW__FIELD_3__pulse),.test_21_REG1_SW_RW__FIELD_3__next_value(test_21_REG1_SW_RW__FIELD_3__next_value)
	,.test_21_REG1_SW_RW__FIELD_2__next_value(test_21_REG1_SW_RW__FIELD_2__next_value),.test_21_REG1_SW_RW__FIELD_2__pulse(test_21_REG1_SW_RW__FIELD_2__pulse),.test_21_REG1_SW_RW__FIELD_2__next_value(test_21_REG1_SW_RW__FIELD_2__next_value)
	,.test_21_REG1_SW_RW__FIELD_1__next_value(test_21_REG1_SW_RW__FIELD_1__next_value),.test_21_REG1_SW_RW__FIELD_1__pulse(test_21_REG1_SW_RW__FIELD_1__pulse),.test_21_REG1_SW_RW__FIELD_1__next_value(test_21_REG1_SW_RW__FIELD_1__next_value)
	,.test_21_REG1_SW_RW__FIELD_0__next_value(test_21_REG1_SW_RW__FIELD_0__next_value),.test_21_REG1_SW_RW__FIELD_0__pulse(test_21_REG1_SW_RW__FIELD_0__pulse),.test_21_REG1_SW_RW__FIELD_0__next_value(test_21_REG1_SW_RW__FIELD_0__next_value)
	,.test_21_REG2_SW_W__FIELD_6__next_value(test_21_REG2_SW_W__FIELD_6__next_value),.test_21_REG2_SW_W__FIELD_6__pulse(test_21_REG2_SW_W__FIELD_6__pulse),.test_21_REG2_SW_W__FIELD_6__next_value(test_21_REG2_SW_W__FIELD_6__next_value)
	,.test_21_REG2_SW_W__FIELD_5__next_value(test_21_REG2_SW_W__FIELD_5__next_value),.test_21_REG2_SW_W__FIELD_5__pulse(test_21_REG2_SW_W__FIELD_5__pulse),.test_21_REG2_SW_W__FIELD_5__next_value(test_21_REG2_SW_W__FIELD_5__next_value)
	,.test_21_REG2_SW_W__FIELD_4__next_value(test_21_REG2_SW_W__FIELD_4__next_value),.test_21_REG2_SW_W__FIELD_4__pulse(test_21_REG2_SW_W__FIELD_4__pulse),.test_21_REG2_SW_W__FIELD_4__next_value(test_21_REG2_SW_W__FIELD_4__next_value)
	,.test_21_REG2_SW_W__FIELD_3__next_value(test_21_REG2_SW_W__FIELD_3__next_value),.test_21_REG2_SW_W__FIELD_3__pulse(test_21_REG2_SW_W__FIELD_3__pulse),.test_21_REG2_SW_W__FIELD_3__next_value(test_21_REG2_SW_W__FIELD_3__next_value)
	,.test_21_REG2_SW_W__FIELD_2__next_value(test_21_REG2_SW_W__FIELD_2__next_value),.test_21_REG2_SW_W__FIELD_2__pulse(test_21_REG2_SW_W__FIELD_2__pulse),.test_21_REG2_SW_W__FIELD_2__next_value(test_21_REG2_SW_W__FIELD_2__next_value)
	,.test_21_REG2_SW_W__FIELD_1__next_value(test_21_REG2_SW_W__FIELD_1__next_value),.test_21_REG2_SW_W__FIELD_1__pulse(test_21_REG2_SW_W__FIELD_1__pulse),.test_21_REG2_SW_W__FIELD_1__next_value(test_21_REG2_SW_W__FIELD_1__next_value)
	,.test_21_REG2_SW_W__FIELD_0__next_value(test_21_REG2_SW_W__FIELD_0__next_value),.test_21_REG2_SW_W__FIELD_0__pulse(test_21_REG2_SW_W__FIELD_0__pulse),.test_21_REG2_SW_W__FIELD_0__next_value(test_21_REG2_SW_W__FIELD_0__next_value)
	,.test_21_REG3_HW__FIELD_3__next_value(test_21_REG3_HW__FIELD_3__next_value),.test_21_REG3_HW__FIELD_3__pulse(test_21_REG3_HW__FIELD_3__pulse),.test_21_REG3_HW__FIELD_3__next_value(test_21_REG3_HW__FIELD_3__next_value)
	,.test_21_REG3_HW__FIELD_2__next_value(test_21_REG3_HW__FIELD_2__next_value),.test_21_REG3_HW__FIELD_2__pulse(test_21_REG3_HW__FIELD_2__pulse),.test_21_REG3_HW__FIELD_2__next_value(test_21_REG3_HW__FIELD_2__next_value)
	,.test_21_REG3_HW__FIELD_2__next_value(test_21_REG3_HW__FIELD_2__next_value),.test_21_REG3_HW__FIELD_0__next_value(test_21_REG3_HW__FIELD_0__next_value),.test_21_REG3_HW__FIELD_0__pulse(test_21_REG3_HW__FIELD_0__pulse)
	,.test_21_REG3_HW__FIELD_0__next_value(test_21_REG3_HW__FIELD_0__next_value),.test_21_REG4_PRECEDENCE__FIELD_1__next_value(test_21_REG4_PRECEDENCE__FIELD_1__next_value),.test_21_REG4_PRECEDENCE__FIELD_1__pulse(test_21_REG4_PRECEDENCE__FIELD_1__pulse)
	,.test_21_REG4_PRECEDENCE__FIELD_1__next_value(test_21_REG4_PRECEDENCE__FIELD_1__next_value),.test_21_REG4_PRECEDENCE__FIELD_0__next_value(test_21_REG4_PRECEDENCE__FIELD_0__next_value),.test_21_REG4_PRECEDENCE__FIELD_0__pulse(test_21_REG4_PRECEDENCE__FIELD_0__pulse)
	,.test_21_REG4_PRECEDENCE__FIELD_0__next_value(test_21_REG4_PRECEDENCE__FIELD_0__next_value),.test_21_REG5_SINGLEPULSE__FIELD_0__next_value(test_21_REG5_SINGLEPULSE__FIELD_0__next_value),.test_21_REG5_SINGLEPULSE__FIELD_0__pulse(test_21_REG5_SINGLEPULSE__FIELD_0__pulse)
	,.test_21_REG5_SINGLEPULSE__FIELD_0__next_value(test_21_REG5_SINGLEPULSE__FIELD_0__next_value),.test_21_REG6_SW_ACC_MOD__FIELD_0__next_value(test_21_REG6_SW_ACC_MOD__FIELD_0__next_value),.test_21_REG6_SW_ACC_MOD__FIELD_0__pulse(test_21_REG6_SW_ACC_MOD__FIELD_0__pulse)
	,.test_21_REG6_SW_ACC_MOD__FIELD_0__next_value(test_21_REG6_SW_ACC_MOD__FIELD_0__next_value),.test_22_shared_2__FIELD_0__next_value(test_22_shared_2__FIELD_0__next_value),.test_22_shared_2__FIELD_0__pulse(test_22_shared_2__FIELD_0__pulse)
	,.test_22_shared_2__FIELD_0__next_value(test_22_shared_2__FIELD_0__next_value),.test_21_REG1_SW_RW__FIELD_8__curr_value(test_21_REG1_SW_RW__FIELD_8__curr_value),.test_21_REG1_SW_RW__FIELD_7__curr_value(test_21_REG1_SW_RW__FIELD_7__curr_value)
	,.test_21_REG1_SW_RW__FIELD_6__curr_value(test_21_REG1_SW_RW__FIELD_6__curr_value),.test_21_REG1_SW_RW__FIELD_5__curr_value(test_21_REG1_SW_RW__FIELD_5__curr_value),.test_21_REG1_SW_RW__FIELD_4__curr_value(test_21_REG1_SW_RW__FIELD_4__curr_value)
	,.test_21_REG1_SW_RW__FIELD_3__curr_value(test_21_REG1_SW_RW__FIELD_3__curr_value),.test_21_REG1_SW_RW__FIELD_2__curr_value(test_21_REG1_SW_RW__FIELD_2__curr_value),.test_21_REG1_SW_RW__FIELD_1__curr_value(test_21_REG1_SW_RW__FIELD_1__curr_value)
	,.test_21_REG1_SW_RW__FIELD_0__curr_value(test_21_REG1_SW_RW__FIELD_0__curr_value),.test_21_REG2_SW_W__FIELD_6__curr_value(test_21_REG2_SW_W__FIELD_6__curr_value),.test_21_REG2_SW_W__FIELD_5__curr_value(test_21_REG2_SW_W__FIELD_5__curr_value)
	,.test_21_REG2_SW_W__FIELD_4__curr_value(test_21_REG2_SW_W__FIELD_4__curr_value),.test_21_REG2_SW_W__FIELD_3__curr_value(test_21_REG2_SW_W__FIELD_3__curr_value),.test_21_REG2_SW_W__FIELD_2__curr_value(test_21_REG2_SW_W__FIELD_2__curr_value)
	,.test_21_REG2_SW_W__FIELD_1__curr_value(test_21_REG2_SW_W__FIELD_1__curr_value),.test_21_REG2_SW_W__FIELD_0__curr_value(test_21_REG2_SW_W__FIELD_0__curr_value),.test_21_REG3_HW__FIELD_3__curr_value(test_21_REG3_HW__FIELD_3__curr_value)
	,.test_21_REG3_HW__FIELD_2__curr_value(test_21_REG3_HW__FIELD_2__curr_value),.test_21_REG3_HW__FIELD_1__curr_value(test_21_REG3_HW__FIELD_1__curr_value),.test_21_REG3_HW__FIELD_0__curr_value(test_21_REG3_HW__FIELD_0__curr_value)
	,.test_21_REG4_PRECEDENCE__FIELD_1__curr_value(test_21_REG4_PRECEDENCE__FIELD_1__curr_value),.test_21_REG4_PRECEDENCE__FIELD_0__curr_value(test_21_REG4_PRECEDENCE__FIELD_0__curr_value),.test_21_REG5_SINGLEPULSE__FIELD_0__curr_value(test_21_REG5_SINGLEPULSE__FIELD_0__curr_value)
	,.test_21_REG6_SW_ACC_MOD__FIELD_0__curr_value(test_21_REG6_SW_ACC_MOD__FIELD_0__curr_value),.test_21_REG6_SW_ACC_MOD__FIELD_0__curr_value(test_21_REG6_SW_ACC_MOD__FIELD_0__curr_value),.test_21_REG6_SW_ACC_MOD__FIELD_0__swacc_out(test_21_REG6_SW_ACC_MOD__FIELD_0__swacc_out)
	,.test_22_shared_2__FIELD_0__curr_value(test_22_shared_2__FIELD_0__curr_value)
	);
endmodule