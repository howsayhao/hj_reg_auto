`include "basic.vh"
module basic{
	input clk,
	input rstn,
	input req_vld,
	input wr_en,rd_en,
	input [ADDR_WIDTH-1:0] addr,
	input [DATA_WIDTH-1:0] wr_data,
	output ack_vld_t,
	output [DATA_WIDTH-1:0] rd_data,
//******EXTERNAL module connection port START*******//
	output ext_req_vld,
	output ext_wr_en,ext_rd_en,
	output [ADDR_WIDTH-1:0] ext_addr,
	output [DATA_WIDTH-1:0] ext_wr_data,
	input ext_ack_vld_t,
	input ext_rd_data,
//*******EXTERNAL module connection port END********//
//*******INTERNAL field connection port START*******//
//['basic', 'foo', 'r1', 'f1']
	input [16-1:0] foo_r1_f1__next_value,
	input foo_r1_f1__pulse,
	output [16-1:0] foo_r1_f1__curr_value,
	output foo_r1_f1__swmod_out,
	output foo_r1_f1__swacc_out,
//['basic', 'foo', 'r1', 'f2']
	input [1-1:0] foo_r1_f2__next_value,
	input foo_r1_f2__pulse,
	output [1-1:0] foo_r1_f2__curr_value,
	output foo_r1_f2__swmod_out,
	output foo_r1_f2__swacc_out,
//['basic', 'foo', 'r1', 'f3']
	input [1-1:0] foo_r1_f3__next_value,
	input foo_r1_f3__pulse,
	output [1-1:0] foo_r1_f3__curr_value,
	output foo_r1_f3__swmod_out,
	output foo_r1_f3__swacc_out,
//['basic', 'foo', 'r1', 'f5']
	input [2-1:0] foo_r1_f5__next_value,
	input foo_r1_f5__pulse,
	output [2-1:0] foo_r1_f5__curr_value,
	output foo_r1_f5__swmod_out,
	output foo_r1_f5__swacc_out,
//['basic', 'foo', 'r1', 'f4']
	input [2-1:0] foo_r1_f4__next_value,
	input foo_r1_f4__pulse,
	output [2-1:0] foo_r1_f4__curr_value,
	output foo_r1_f4__swmod_out,
	output foo_r1_f4__swacc_out,
//['basic', 'foo', 'r2', 'f1']
	input [16-1:0] foo_r2_f1__next_value,
	input foo_r2_f1__pulse,
	output [16-1:0] foo_r2_f1__curr_value,
	output foo_r2_f1__swmod_out,
	output foo_r2_f1__swacc_out,
//['basic', 'foo', 'r2', 'f2']
	input [1-1:0] foo_r2_f2__next_value,
	input foo_r2_f2__pulse,
	output [1-1:0] foo_r2_f2__curr_value,
	output foo_r2_f2__swmod_out,
	output foo_r2_f2__swacc_out,
//['basic', 'foo', 'r2', 'f3']
	input [1-1:0] foo_r2_f3__next_value,
	input foo_r2_f3__pulse,
	output [1-1:0] foo_r2_f3__curr_value,
	output foo_r2_f3__swmod_out,
	output foo_r2_f3__swacc_out,
//['basic', 'foo', 'r2', 'f5']
	input [2-1:0] foo_r2_f5__next_value,
	input foo_r2_f5__pulse,
	output [2-1:0] foo_r2_f5__curr_value,
	output foo_r2_f5__swmod_out,
	output foo_r2_f5__swacc_out,
//['basic', 'foo', 'r2', 'f4']
	input [2-1:0] foo_r2_f4__next_value,
	input foo_r2_f4__pulse,
	output [2-1:0] foo_r2_f4__curr_value,
	output foo_r2_f4__swmod_out,
	output foo_r2_f4__swacc_out,
//['basic', 'foo', 'r3', 'f1']
	input [16-1:0] foo_r3_f1__next_value,
	input foo_r3_f1__pulse,
	output [16-1:0] foo_r3_f1__curr_value,
	output foo_r3_f1__swmod_out,
	output foo_r3_f1__swacc_out,
//['basic', 'foo', 'r3', 'f2']
	input [1-1:0] foo_r3_f2__next_value,
	input foo_r3_f2__pulse,
	output [1-1:0] foo_r3_f2__curr_value,
	output foo_r3_f2__swmod_out,
	output foo_r3_f2__swacc_out,
//['basic', 'foo', 'r3', 'f3']
	input [1-1:0] foo_r3_f3__next_value,
	input foo_r3_f3__pulse,
	output [1-1:0] foo_r3_f3__curr_value,
	output foo_r3_f3__swmod_out,
	output foo_r3_f3__swacc_out,
//['basic', 'foo', 'r3', 'f5']
	input [2-1:0] foo_r3_f5__next_value,
	input foo_r3_f5__pulse,
	output [2-1:0] foo_r3_f5__curr_value,
	output foo_r3_f5__swmod_out,
	output foo_r3_f5__swacc_out,
//['basic', 'foo', 'r3', 'f4']
	input [2-1:0] foo_r3_f4__next_value,
	input foo_r3_f4__pulse,
	output [2-1:0] foo_r3_f4__curr_value,
	output foo_r3_f4__swmod_out,
	output foo_r3_f4__swacc_out,
//['basic', 'bar[0][0]', 'r1[0]', 'fo']
	input [16-1:0] bar0_0_r10_fo__next_value,
	input bar0_0_r10_fo__pulse,
	output [16-1:0] bar0_0_r10_fo__curr_value,
	output bar0_0_r10_fo__swmod_out,
	output bar0_0_r10_fo__swacc_out,
//['basic', 'bar[0][0]', 'r1[1]', 'fo']
	input [16-1:0] bar0_0_r11_fo__next_value,
	input bar0_0_r11_fo__pulse,
	output [16-1:0] bar0_0_r11_fo__curr_value,
	output bar0_0_r11_fo__swmod_out,
	output bar0_0_r11_fo__swacc_out,
//['basic', 'bar[0][0]', 'r1[2]', 'fo']
	input [16-1:0] bar0_0_r12_fo__next_value,
	input bar0_0_r12_fo__pulse,
	output [16-1:0] bar0_0_r12_fo__curr_value,
	output bar0_0_r12_fo__swmod_out,
	output bar0_0_r12_fo__swacc_out,
//['basic', 'bar[0][0]', 'r1[3]', 'fo']
	input [16-1:0] bar0_0_r13_fo__next_value,
	input bar0_0_r13_fo__pulse,
	output [16-1:0] bar0_0_r13_fo__curr_value,
	output bar0_0_r13_fo__swmod_out,
	output bar0_0_r13_fo__swacc_out,
//['basic', 'bar[0][1]', 'r1[0]', 'fo']
	input [16-1:0] bar0_1_r10_fo__next_value,
	input bar0_1_r10_fo__pulse,
	output [16-1:0] bar0_1_r10_fo__curr_value,
	output bar0_1_r10_fo__swmod_out,
	output bar0_1_r10_fo__swacc_out,
//['basic', 'bar[0][1]', 'r1[1]', 'fo']
	input [16-1:0] bar0_1_r11_fo__next_value,
	input bar0_1_r11_fo__pulse,
	output [16-1:0] bar0_1_r11_fo__curr_value,
	output bar0_1_r11_fo__swmod_out,
	output bar0_1_r11_fo__swacc_out,
//['basic', 'bar[0][1]', 'r1[2]', 'fo']
	input [16-1:0] bar0_1_r12_fo__next_value,
	input bar0_1_r12_fo__pulse,
	output [16-1:0] bar0_1_r12_fo__curr_value,
	output bar0_1_r12_fo__swmod_out,
	output bar0_1_r12_fo__swacc_out,
//['basic', 'bar[0][1]', 'r1[3]', 'fo']
	input [16-1:0] bar0_1_r13_fo__next_value,
	input bar0_1_r13_fo__pulse,
	output [16-1:0] bar0_1_r13_fo__curr_value,
	output bar0_1_r13_fo__swmod_out,
	output bar0_1_r13_fo__swacc_out,
//['basic', 'bar[0][2]', 'r1[0]', 'fo']
	input [16-1:0] bar0_2_r10_fo__next_value,
	input bar0_2_r10_fo__pulse,
	output [16-1:0] bar0_2_r10_fo__curr_value,
	output bar0_2_r10_fo__swmod_out,
	output bar0_2_r10_fo__swacc_out,
//['basic', 'bar[0][2]', 'r1[1]', 'fo']
	input [16-1:0] bar0_2_r11_fo__next_value,
	input bar0_2_r11_fo__pulse,
	output [16-1:0] bar0_2_r11_fo__curr_value,
	output bar0_2_r11_fo__swmod_out,
	output bar0_2_r11_fo__swacc_out,
//['basic', 'bar[0][2]', 'r1[2]', 'fo']
	input [16-1:0] bar0_2_r12_fo__next_value,
	input bar0_2_r12_fo__pulse,
	output [16-1:0] bar0_2_r12_fo__curr_value,
	output bar0_2_r12_fo__swmod_out,
	output bar0_2_r12_fo__swacc_out,
//['basic', 'bar[0][2]', 'r1[3]', 'fo']
	input [16-1:0] bar0_2_r13_fo__next_value,
	input bar0_2_r13_fo__pulse,
	output [16-1:0] bar0_2_r13_fo__curr_value,
	output bar0_2_r13_fo__swmod_out,
	output bar0_2_r13_fo__swacc_out,
//['basic', 'bar[1][0]', 'r1[0]', 'fo']
	input [16-1:0] bar1_0_r10_fo__next_value,
	input bar1_0_r10_fo__pulse,
	output [16-1:0] bar1_0_r10_fo__curr_value,
	output bar1_0_r10_fo__swmod_out,
	output bar1_0_r10_fo__swacc_out,
//['basic', 'bar[1][0]', 'r1[1]', 'fo']
	input [16-1:0] bar1_0_r11_fo__next_value,
	input bar1_0_r11_fo__pulse,
	output [16-1:0] bar1_0_r11_fo__curr_value,
	output bar1_0_r11_fo__swmod_out,
	output bar1_0_r11_fo__swacc_out,
//['basic', 'bar[1][0]', 'r1[2]', 'fo']
	input [16-1:0] bar1_0_r12_fo__next_value,
	input bar1_0_r12_fo__pulse,
	output [16-1:0] bar1_0_r12_fo__curr_value,
	output bar1_0_r12_fo__swmod_out,
	output bar1_0_r12_fo__swacc_out,
//['basic', 'bar[1][0]', 'r1[3]', 'fo']
	input [16-1:0] bar1_0_r13_fo__next_value,
	input bar1_0_r13_fo__pulse,
	output [16-1:0] bar1_0_r13_fo__curr_value,
	output bar1_0_r13_fo__swmod_out,
	output bar1_0_r13_fo__swacc_out,
//['basic', 'bar[1][1]', 'r1[0]', 'fo']
	input [16-1:0] bar1_1_r10_fo__next_value,
	input bar1_1_r10_fo__pulse,
	output [16-1:0] bar1_1_r10_fo__curr_value,
	output bar1_1_r10_fo__swmod_out,
	output bar1_1_r10_fo__swacc_out,
//['basic', 'bar[1][1]', 'r1[1]', 'fo']
	input [16-1:0] bar1_1_r11_fo__next_value,
	input bar1_1_r11_fo__pulse,
	output [16-1:0] bar1_1_r11_fo__curr_value,
	output bar1_1_r11_fo__swmod_out,
	output bar1_1_r11_fo__swacc_out,
//['basic', 'bar[1][1]', 'r1[2]', 'fo']
	input [16-1:0] bar1_1_r12_fo__next_value,
	input bar1_1_r12_fo__pulse,
	output [16-1:0] bar1_1_r12_fo__curr_value,
	output bar1_1_r12_fo__swmod_out,
	output bar1_1_r12_fo__swacc_out,
//['basic', 'bar[1][1]', 'r1[3]', 'fo']
	input [16-1:0] bar1_1_r13_fo__next_value,
	input bar1_1_r13_fo__pulse,
	output [16-1:0] bar1_1_r13_fo__curr_value,
	output bar1_1_r13_fo__swmod_out,
	output bar1_1_r13_fo__swacc_out,
//['basic', 'bar[1][2]', 'r1[0]', 'fo']
	input [16-1:0] bar1_2_r10_fo__next_value,
	input bar1_2_r10_fo__pulse,
	output [16-1:0] bar1_2_r10_fo__curr_value,
	output bar1_2_r10_fo__swmod_out,
	output bar1_2_r10_fo__swacc_out,
//['basic', 'bar[1][2]', 'r1[1]', 'fo']
	input [16-1:0] bar1_2_r11_fo__next_value,
	input bar1_2_r11_fo__pulse,
	output [16-1:0] bar1_2_r11_fo__curr_value,
	output bar1_2_r11_fo__swmod_out,
	output bar1_2_r11_fo__swacc_out,
//['basic', 'bar[1][2]', 'r1[2]', 'fo']
	input [16-1:0] bar1_2_r12_fo__next_value,
	input bar1_2_r12_fo__pulse,
	output [16-1:0] bar1_2_r12_fo__curr_value,
	output bar1_2_r12_fo__swmod_out,
	output bar1_2_r12_fo__swacc_out,
//['basic', 'bar[1][2]', 'r1[3]', 'fo']
	input [16-1:0] bar1_2_r13_fo__next_value,
	input bar1_2_r13_fo__pulse,
	output [16-1:0] bar1_2_r13_fo__curr_value,
	output bar1_2_r13_fo__swmod_out,
	output bar1_2_r13_fo__swacc_out,
//['basic', 'bar[2][0]', 'r1[0]', 'fo']
	input [16-1:0] bar2_0_r10_fo__next_value,
	input bar2_0_r10_fo__pulse,
	output [16-1:0] bar2_0_r10_fo__curr_value,
	output bar2_0_r10_fo__swmod_out,
	output bar2_0_r10_fo__swacc_out,
//['basic', 'bar[2][0]', 'r1[1]', 'fo']
	input [16-1:0] bar2_0_r11_fo__next_value,
	input bar2_0_r11_fo__pulse,
	output [16-1:0] bar2_0_r11_fo__curr_value,
	output bar2_0_r11_fo__swmod_out,
	output bar2_0_r11_fo__swacc_out,
//['basic', 'bar[2][0]', 'r1[2]', 'fo']
	input [16-1:0] bar2_0_r12_fo__next_value,
	input bar2_0_r12_fo__pulse,
	output [16-1:0] bar2_0_r12_fo__curr_value,
	output bar2_0_r12_fo__swmod_out,
	output bar2_0_r12_fo__swacc_out,
//['basic', 'bar[2][0]', 'r1[3]', 'fo']
	input [16-1:0] bar2_0_r13_fo__next_value,
	input bar2_0_r13_fo__pulse,
	output [16-1:0] bar2_0_r13_fo__curr_value,
	output bar2_0_r13_fo__swmod_out,
	output bar2_0_r13_fo__swacc_out,
//['basic', 'bar[2][1]', 'r1[0]', 'fo']
	input [16-1:0] bar2_1_r10_fo__next_value,
	input bar2_1_r10_fo__pulse,
	output [16-1:0] bar2_1_r10_fo__curr_value,
	output bar2_1_r10_fo__swmod_out,
	output bar2_1_r10_fo__swacc_out,
//['basic', 'bar[2][1]', 'r1[1]', 'fo']
	input [16-1:0] bar2_1_r11_fo__next_value,
	input bar2_1_r11_fo__pulse,
	output [16-1:0] bar2_1_r11_fo__curr_value,
	output bar2_1_r11_fo__swmod_out,
	output bar2_1_r11_fo__swacc_out,
//['basic', 'bar[2][1]', 'r1[2]', 'fo']
	input [16-1:0] bar2_1_r12_fo__next_value,
	input bar2_1_r12_fo__pulse,
	output [16-1:0] bar2_1_r12_fo__curr_value,
	output bar2_1_r12_fo__swmod_out,
	output bar2_1_r12_fo__swacc_out,
//['basic', 'bar[2][1]', 'r1[3]', 'fo']
	input [16-1:0] bar2_1_r13_fo__next_value,
	input bar2_1_r13_fo__pulse,
	output [16-1:0] bar2_1_r13_fo__curr_value,
	output bar2_1_r13_fo__swmod_out,
	output bar2_1_r13_fo__swacc_out,
//['basic', 'bar[2][2]', 'r1[0]', 'fo']
	input [16-1:0] bar2_2_r10_fo__next_value,
	input bar2_2_r10_fo__pulse,
	output [16-1:0] bar2_2_r10_fo__curr_value,
	output bar2_2_r10_fo__swmod_out,
	output bar2_2_r10_fo__swacc_out,
//['basic', 'bar[2][2]', 'r1[1]', 'fo']
	input [16-1:0] bar2_2_r11_fo__next_value,
	input bar2_2_r11_fo__pulse,
	output [16-1:0] bar2_2_r11_fo__curr_value,
	output bar2_2_r11_fo__swmod_out,
	output bar2_2_r11_fo__swacc_out,
//['basic', 'bar[2][2]', 'r1[2]', 'fo']
	input [16-1:0] bar2_2_r12_fo__next_value,
	input bar2_2_r12_fo__pulse,
	output [16-1:0] bar2_2_r12_fo__curr_value,
	output bar2_2_r12_fo__swmod_out,
	output bar2_2_r12_fo__swacc_out,
//['basic', 'bar[2][2]', 'r1[3]', 'fo']
	input [16-1:0] bar2_2_r13_fo__next_value,
	input bar2_2_r13_fo__pulse,
	output [16-1:0] bar2_2_r13_fo__curr_value,
	output bar2_2_r13_fo__swmod_out,
	output bar2_2_r13_fo__swacc_out,
//['basic', 'bar[3][0]', 'r1[0]', 'fo']
	input [16-1:0] bar3_0_r10_fo__next_value,
	input bar3_0_r10_fo__pulse,
	output [16-1:0] bar3_0_r10_fo__curr_value,
	output bar3_0_r10_fo__swmod_out,
	output bar3_0_r10_fo__swacc_out,
//['basic', 'bar[3][0]', 'r1[1]', 'fo']
	input [16-1:0] bar3_0_r11_fo__next_value,
	input bar3_0_r11_fo__pulse,
	output [16-1:0] bar3_0_r11_fo__curr_value,
	output bar3_0_r11_fo__swmod_out,
	output bar3_0_r11_fo__swacc_out,
//['basic', 'bar[3][0]', 'r1[2]', 'fo']
	input [16-1:0] bar3_0_r12_fo__next_value,
	input bar3_0_r12_fo__pulse,
	output [16-1:0] bar3_0_r12_fo__curr_value,
	output bar3_0_r12_fo__swmod_out,
	output bar3_0_r12_fo__swacc_out,
//['basic', 'bar[3][0]', 'r1[3]', 'fo']
	input [16-1:0] bar3_0_r13_fo__next_value,
	input bar3_0_r13_fo__pulse,
	output [16-1:0] bar3_0_r13_fo__curr_value,
	output bar3_0_r13_fo__swmod_out,
	output bar3_0_r13_fo__swacc_out,
//['basic', 'bar[3][1]', 'r1[0]', 'fo']
	input [16-1:0] bar3_1_r10_fo__next_value,
	input bar3_1_r10_fo__pulse,
	output [16-1:0] bar3_1_r10_fo__curr_value,
	output bar3_1_r10_fo__swmod_out,
	output bar3_1_r10_fo__swacc_out,
//['basic', 'bar[3][1]', 'r1[1]', 'fo']
	input [16-1:0] bar3_1_r11_fo__next_value,
	input bar3_1_r11_fo__pulse,
	output [16-1:0] bar3_1_r11_fo__curr_value,
	output bar3_1_r11_fo__swmod_out,
	output bar3_1_r11_fo__swacc_out,
//['basic', 'bar[3][1]', 'r1[2]', 'fo']
	input [16-1:0] bar3_1_r12_fo__next_value,
	input bar3_1_r12_fo__pulse,
	output [16-1:0] bar3_1_r12_fo__curr_value,
	output bar3_1_r12_fo__swmod_out,
	output bar3_1_r12_fo__swacc_out,
//['basic', 'bar[3][1]', 'r1[3]', 'fo']
	input [16-1:0] bar3_1_r13_fo__next_value,
	input bar3_1_r13_fo__pulse,
	output [16-1:0] bar3_1_r13_fo__curr_value,
	output bar3_1_r13_fo__swmod_out,
	output bar3_1_r13_fo__swacc_out,
//['basic', 'bar[3][2]', 'r1[0]', 'fo']
	input [16-1:0] bar3_2_r10_fo__next_value,
	input bar3_2_r10_fo__pulse,
	output [16-1:0] bar3_2_r10_fo__curr_value,
	output bar3_2_r10_fo__swmod_out,
	output bar3_2_r10_fo__swacc_out,
//['basic', 'bar[3][2]', 'r1[1]', 'fo']
	input [16-1:0] bar3_2_r11_fo__next_value,
	input bar3_2_r11_fo__pulse,
	output [16-1:0] bar3_2_r11_fo__curr_value,
	output bar3_2_r11_fo__swmod_out,
	output bar3_2_r11_fo__swacc_out,
//['basic', 'bar[3][2]', 'r1[2]', 'fo']
	input [16-1:0] bar3_2_r12_fo__next_value,
	input bar3_2_r12_fo__pulse,
	output [16-1:0] bar3_2_r12_fo__curr_value,
	output bar3_2_r12_fo__swmod_out,
	output bar3_2_r12_fo__swacc_out,
//['basic', 'bar[3][2]', 'r1[3]', 'fo']
	input [16-1:0] bar3_2_r13_fo__next_value,
	input bar3_2_r13_fo__pulse,
	output [16-1:0] bar3_2_r13_fo__curr_value,
	output bar3_2_r13_fo__swmod_out,
	output bar3_2_r13_fo__swacc_out,
//['basic', 'bar2', 'r1[0]', 'fo']
	input [16-1:0] bar2_r10_fo__next_value,
	input bar2_r10_fo__pulse,
	output [16-1:0] bar2_r10_fo__curr_value,
	output bar2_r10_fo__swmod_out,
	output bar2_r10_fo__swacc_out,
//['basic', 'bar2', 'r1[1]', 'fo']
	input [16-1:0] bar2_r11_fo__next_value,
	input bar2_r11_fo__pulse,
	output [16-1:0] bar2_r11_fo__curr_value,
	output bar2_r11_fo__swmod_out,
	output bar2_r11_fo__swacc_out,
//['basic', 'bar2', 'r1[2]', 'fo']
	input [16-1:0] bar2_r12_fo__next_value,
	input bar2_r12_fo__pulse,
	output [16-1:0] bar2_r12_fo__curr_value,
	output bar2_r12_fo__swmod_out,
	output bar2_r12_fo__swacc_out,
//['basic', 'bar2', 'r1[3]', 'fo']
	input [16-1:0] bar2_r13_fo__next_value,
	input bar2_r13_fo__pulse,
	output [16-1:0] bar2_r13_fo__curr_value,
	output bar2_r13_fo__swmod_out,
	output bar2_r13_fo__swacc_out
//********INTERNAL field connection port END********//
};
//*********PARAMETER Definition START Here**********//
PARAMETER ADDR_WIDTH = 64;
PARAMETER DATA_WIDTH = 32;
//N:number of internal registers, M:number of external modules
PARAMETER N = 55;
PARAMETER M = 1;
//**********PARAMETER Definition END Here***********//


//**************WIRE DECLARATION START**************//
//declare the portwidth of external module
wire external;
wire [M-1:0] ext_req_vld;
wire [M-1:0] ext_ack_vld_t;
wire [M-1:0] [DATAWIDTH-1:0] ext_rd_data;
wire [M-1:0] ext_sel;
reg [M-1:0] ext_sel_ff;
assign external = |ext_mem_sel
wire [N-1:0] [DATAWIDTH-1:0] reg_rd_data_in;
wire [N-1:0] reg_sel;
reg [N-1:0] reg_sel_ff;
wire dummy_reg;
reg dummy_reg_ff;
//***************WIRE DECLARATION END***************//


//***********Address Decoding START Here************//
always_comb begin
	unique case (addr)
		reg_sel = {55{1'b0}};
		ext_reg_sel = {8{1'b0}};
		dummy_reg = 1'b0;
		`foo_r1:reg_sel[0] = 1'b1;//['foo', 'r1']
		`foo_r2:reg_sel[1] = 1'b1;//['foo', 'r2']
		`foo_r3:reg_sel[2] = 1'b1;//['foo', 'r3']
		`bar0_0_r10:reg_sel[3] = 1'b1;//['bar[0][0]', 'r1[0]']
		`bar0_0_r11:reg_sel[4] = 1'b1;//['bar[0][0]', 'r1[1]']
		`bar0_0_r12:reg_sel[5] = 1'b1;//['bar[0][0]', 'r1[2]']
		`bar0_0_r13:reg_sel[6] = 1'b1;//['bar[0][0]', 'r1[3]']
		`bar0_1_r10:reg_sel[7] = 1'b1;//['bar[0][1]', 'r1[0]']
		`bar0_1_r11:reg_sel[8] = 1'b1;//['bar[0][1]', 'r1[1]']
		`bar0_1_r12:reg_sel[9] = 1'b1;//['bar[0][1]', 'r1[2]']
		`bar0_1_r13:reg_sel[10] = 1'b1;//['bar[0][1]', 'r1[3]']
		`bar0_2_r10:reg_sel[11] = 1'b1;//['bar[0][2]', 'r1[0]']
		`bar0_2_r11:reg_sel[12] = 1'b1;//['bar[0][2]', 'r1[1]']
		`bar0_2_r12:reg_sel[13] = 1'b1;//['bar[0][2]', 'r1[2]']
		`bar0_2_r13:reg_sel[14] = 1'b1;//['bar[0][2]', 'r1[3]']
		`bar1_0_r10:reg_sel[15] = 1'b1;//['bar[1][0]', 'r1[0]']
		`bar1_0_r11:reg_sel[16] = 1'b1;//['bar[1][0]', 'r1[1]']
		`bar1_0_r12:reg_sel[17] = 1'b1;//['bar[1][0]', 'r1[2]']
		`bar1_0_r13:reg_sel[18] = 1'b1;//['bar[1][0]', 'r1[3]']
		`bar1_1_r10:reg_sel[19] = 1'b1;//['bar[1][1]', 'r1[0]']
		`bar1_1_r11:reg_sel[20] = 1'b1;//['bar[1][1]', 'r1[1]']
		`bar1_1_r12:reg_sel[21] = 1'b1;//['bar[1][1]', 'r1[2]']
		`bar1_1_r13:reg_sel[22] = 1'b1;//['bar[1][1]', 'r1[3]']
		`bar1_2_r10:reg_sel[23] = 1'b1;//['bar[1][2]', 'r1[0]']
		`bar1_2_r11:reg_sel[24] = 1'b1;//['bar[1][2]', 'r1[1]']
		`bar1_2_r12:reg_sel[25] = 1'b1;//['bar[1][2]', 'r1[2]']
		`bar1_2_r13:reg_sel[26] = 1'b1;//['bar[1][2]', 'r1[3]']
		`bar2_0_r10:reg_sel[27] = 1'b1;//['bar[2][0]', 'r1[0]']
		`bar2_0_r11:reg_sel[28] = 1'b1;//['bar[2][0]', 'r1[1]']
		`bar2_0_r12:reg_sel[29] = 1'b1;//['bar[2][0]', 'r1[2]']
		`bar2_0_r13:reg_sel[30] = 1'b1;//['bar[2][0]', 'r1[3]']
		`bar2_1_r10:reg_sel[31] = 1'b1;//['bar[2][1]', 'r1[0]']
		`bar2_1_r11:reg_sel[32] = 1'b1;//['bar[2][1]', 'r1[1]']
		`bar2_1_r12:reg_sel[33] = 1'b1;//['bar[2][1]', 'r1[2]']
		`bar2_1_r13:reg_sel[34] = 1'b1;//['bar[2][1]', 'r1[3]']
		`bar2_2_r10:reg_sel[35] = 1'b1;//['bar[2][2]', 'r1[0]']
		`bar2_2_r11:reg_sel[36] = 1'b1;//['bar[2][2]', 'r1[1]']
		`bar2_2_r12:reg_sel[37] = 1'b1;//['bar[2][2]', 'r1[2]']
		`bar2_2_r13:reg_sel[38] = 1'b1;//['bar[2][2]', 'r1[3]']
		`bar3_0_r10:reg_sel[39] = 1'b1;//['bar[3][0]', 'r1[0]']
		`bar3_0_r11:reg_sel[40] = 1'b1;//['bar[3][0]', 'r1[1]']
		`bar3_0_r12:reg_sel[41] = 1'b1;//['bar[3][0]', 'r1[2]']
		`bar3_0_r13:reg_sel[42] = 1'b1;//['bar[3][0]', 'r1[3]']
		`bar3_1_r10:reg_sel[43] = 1'b1;//['bar[3][1]', 'r1[0]']
		`bar3_1_r11:reg_sel[44] = 1'b1;//['bar[3][1]', 'r1[1]']
		`bar3_1_r12:reg_sel[45] = 1'b1;//['bar[3][1]', 'r1[2]']
		`bar3_1_r13:reg_sel[46] = 1'b1;//['bar[3][1]', 'r1[3]']
		`bar3_2_r10:reg_sel[47] = 1'b1;//['bar[3][2]', 'r1[0]']
		`bar3_2_r11:reg_sel[48] = 1'b1;//['bar[3][2]', 'r1[1]']
		`bar3_2_r12:reg_sel[49] = 1'b1;//['bar[3][2]', 'r1[2]']
		`bar3_2_r13:reg_sel[50] = 1'b1;//['bar[3][2]', 'r1[3]']
		`bar2_r10:reg_sel[51] = 1'b1;//['bar2', 'r1[0]']
		`bar2_r11:reg_sel[52] = 1'b1;//['bar2', 'r1[1]']
		`bar2_r12:reg_sel[53] = 1'b1;//['bar2', 'r1[2]']
		`bar2_r13:reg_sel[54] = 1'b1;//['bar2', 'r1[3]']
		`xxx_r10,`xxx_r11,`xxx_r12,`xxx_r13,`xxx_r14,`xxx_r15,`xxx_r16,`xxx_r17:ext_sel[0] = 1'b1;//external module xxx
		default: dummy_reg = 1'b1;
	endcase
end
//************Address Decoding END Here*************//


//*********State Machine Control START Here*********//
// machine state decode
PARAMETER   IDLE = 3'd0;
PARAMETER   ACK = 3'd1;
PARAMETER   EXTERN_ACK = 3'd2;

// machine state value
reg [2:0] next_state;
reg [2:0] state;

// state transfer
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        state <= 3'b0;
    end
    else begin
        state <= next_state;
    end
end

// state transfer flow
wire reg_ack_vld;
wire reg_timeout;
wire ext_ack_vld;
wire ext_timeout;
always_comb begin
    case(state)
        IDLE:begin
            if(req_vld && ~external && rd_en) next_state = ACK;
            else if(req_vld && external && rd_en) next_state = EXT_ACK;
            else next_state = IDLE;
        end
        ACK:begin
            if(ack_vld_t || reg_timeout)begin
                next_state = IDLE;
            end
            else next_state = ACK;
        end
        EXT_ACK:begin
            if(ack_vld_t || ext_timeout)begin
                next_state = IDLE;
            end
            else next_state = EXT_ACK;
        end
        default: next_state = IDLE;
    endcase
end



// state output

// for IDLE state: collect the bus information, execute the write operation
// for IDLE  state: if WR, just back to IDLE ,if RD, just wait for ack
reg [ADDR_WIDTH-1:0]addr_ff;
reg [DATA_WIDTH-1:0]wr_data_ff;
reg wr_en_ff;
reg rd_en_ff;
reg [N-1:0] reg_sel_ff;
reg [M-1:0] ext_sel_ff
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        addr_ff <= 0;
        wr_en_ff <= 0;
        rd_en_ff <= 0;
        wr_data_ff <= 0;
        reg_sel_ff <= 0;
        ext_sel_ff <= 0;
    end
    else begin
        case(next_state)
            IDLE:begin
                addr_ff <= addr;
                wr_en_ff <= wr_en;
                rd_en_ff <= rd_en;
                wr_data_ff <= wr_data;
                reg_sel_ff <= reg_sel;
                ext_sel_ff <= ext_sel;
            end
            default:begin
                addr_ff <= addr_ff;
                wr_en_ff <= wr_en_ff;
                rd_en_ff <= rd_en_ff;
                wr_data_ff <= wr_data_ff;
                reg_sel_ff <= reg_sel_ff;
                ext_sel_ff <= ext_sel_ff;
            end
        endcase
    end
end

// for ACK state
// INTERN REG READ time_out detecter
reg reg_timeout;
reg [2:0] reg_time_cnt;
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        reg_timeout <= 1'b0;
        reg_time_cnt <= 3'b0;
    end
    else begin
        if(next_state == ACK)begin
            if(reg_time_cnt == 3'b111)begin
                reg_timeout <= 1'b1;
                reg_time_cnt <= 3'b0;
            end
            else begin
                reg_timeout <= 1'b0;
                reg_time_cnt <= reg_time_cnt + 1'b1;
            end
        end
        else begin
            reg_timeout <= 1'b0;
            reg_time_cnt <= 3'b0;
        end
    end
end

// for EXTERNAL_ACK state
// EXT MODULE READ time_out detecter
reg ext_timeout;
reg [2:0] mem_time_cnt;
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        ext_timeout <= 1'b0;
        mem_time_cnt <= 3'b0;
    end
    else begin
        if(next_state == ACK)begin
            if(mem_time_cnt == 3'b111)begin
                ext_timeout <= 1'b1;
                mem_time_cnt <= 3'b0;
            end
            else begin
                ext_timeout <= 1'b0;
                mem_time_cnt <= mem_time_cnt + 1'b1;
            end
        end
        else begin
            ext_timeout <= 1'b0;
            mem_time_cnt <= 3'b0;
        end
    end
end

// for output select

// for normal register
wire [DATA_WIDTH-1:0] reg_rd_data;
wire reg_ack_vld;

// for external module
wire [DATA_WIDTH-1:0] ext_rd_data_vld;
wire ext_ack_vld;

wire [DATA_WIDTH-1:0] rd_data_t;
wire ack_vld_t;
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        rd_data_t <= 0;
        ack_vld_t <= 1'b0;
    end
    else begin
        case(next_state)
            ACK:begin
                rd_data_t <= reg_ack_vld ? reg_rd_data_vld : 0;
                ack_vld_t <= reg_ack_vld ? 1 : 0;
            end
            EXTERN_ACK:begin
                rd_data_t <= ext_ack_vld ? ext_rd_data_vld : 0;
                ack_vld_t <= ext_ack_vld ? 1 : 0;
            end
            default:begin
                rd_data_t <= rd_data_t;
                ack_vld_t <= 1'b0;
            end
    end
end//**********State Machine Control END Here**********//


//******Register&field Instantiate START Here*******//
//===================REG INSTANT====================//
//REG NAME: foo_r1//
//REG HIERARCHY: ['basic', 'foo', 'r1']//
//REG ABSOLUTE_ADDR:64'h0//
//REG OFFSET_ADDR:64'h64'h0//
wire [31:0] foo_r1;
wire [31:0] foo_r1_wr_data;
assign foo_r1_wr_data = reg_sel_ff[0] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__foo_r1_f1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(foo_r1_f1_wr_data),
	.sw_rd(rd_sel_ff[0]),
	.sw_wr(wr_sel_ff[0]),
	.write_protect_en(0),
	.sw_out(foo_r1_f1__swmod_out),
	.swacc_out(foo_r1_f1__swacc_out)
	.hw_value(foo_r1_f1__next_value),
	.hw_pulse(foo_r1_f1__pulse),
	.field_value(foo_r1_f1__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(1),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(1'h0),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__foo_r1_f2
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(foo_r1_f2_wr_data),
	.sw_rd(rd_sel_ff[0]),
	.sw_wr(wr_sel_ff[0]),
	.write_protect_en(0),
	.sw_out(foo_r1_f2__swmod_out),
	.swacc_out(foo_r1_f2__swacc_out)
	.hw_value(foo_r1_f2__next_value),
	.hw_pulse(foo_r1_f2__pulse),
	.field_value(foo_r1_f2__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(1),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(1'h0),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__foo_r1_f3
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(foo_r1_f3_wr_data),
	.sw_rd(rd_sel_ff[0]),
	.sw_wr(wr_sel_ff[0]),
	.write_protect_en(0),
	.sw_out(foo_r1_f3__swmod_out),
	.swacc_out(foo_r1_f3__swacc_out)
	.hw_value(foo_r1_f3__next_value),
	.hw_pulse(foo_r1_f3__pulse),
	.field_value(foo_r1_f3__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(2),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(2'h0),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__foo_r1_f5
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(foo_r1_f5_wr_data),
	.sw_rd(rd_sel_ff[0]),
	.sw_wr(wr_sel_ff[0]),
	.write_protect_en(0),
	.sw_out(foo_r1_f5__swmod_out),
	.swacc_out(foo_r1_f5__swacc_out)
	.hw_value(foo_r1_f5__next_value),
	.hw_pulse(foo_r1_f5__pulse),
	.field_value(foo_r1_f5__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(2),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(2'h0),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__foo_r1_f4
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(foo_r1_f4_wr_data),
	.sw_rd(rd_sel_ff[0]),
	.sw_wr(wr_sel_ff[0]),
	.write_protect_en(0),
	.sw_out(foo_r1_f4__swmod_out),
	.swacc_out(foo_r1_f4__swacc_out)
	.hw_value(foo_r1_f4__next_value),
	.hw_pulse(foo_r1_f4__pulse),
	.field_value(foo_r1_f4__curr_value)
	);
always_comb begin
	foo_r1[31:0] = 32'd0;
	foo_r1[15:0] = foo_r1_f1__curr_value;
	foo_r1[16:16] = foo_r1_f2__curr_value;
	foo_r1[17:17] = foo_r1_f3__curr_value;
	foo_r1[29:28] = foo_r1_f5__curr_value;
	foo_r1[31:30] = foo_r1_f4__curr_value;
end
assign reg_rd_data_in[0] = foo_r1;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: foo_r2//
//REG HIERARCHY: ['basic', 'foo', 'r2']//
//REG ABSOLUTE_ADDR:64'h4//
//REG OFFSET_ADDR:64'h64'h4//
wire [31:0] foo_r2;
wire [31:0] foo_r2_wr_data;
assign foo_r2_wr_data = reg_sel_ff[1] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__foo_r2_f1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(foo_r2_f1_wr_data),
	.sw_rd(rd_sel_ff[1]),
	.sw_wr(wr_sel_ff[1]),
	.write_protect_en(1),
	.sw_out(foo_r2_f1__swmod_out),
	.swacc_out(foo_r2_f1__swacc_out)
	.hw_value(foo_r2_f1__next_value),
	.hw_pulse(foo_r2_f1__pulse),
	.field_value(foo_r2_f1__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(1),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(1'h0),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__foo_r2_f2
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(foo_r2_f2_wr_data),
	.sw_rd(rd_sel_ff[1]),
	.sw_wr(wr_sel_ff[1]),
	.write_protect_en(1),
	.sw_out(foo_r2_f2__swmod_out),
	.swacc_out(foo_r2_f2__swacc_out)
	.hw_value(foo_r2_f2__next_value),
	.hw_pulse(foo_r2_f2__pulse),
	.field_value(foo_r2_f2__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(1),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(1'h0),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__foo_r2_f3
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(foo_r2_f3_wr_data),
	.sw_rd(rd_sel_ff[1]),
	.sw_wr(wr_sel_ff[1]),
	.write_protect_en(1),
	.sw_out(foo_r2_f3__swmod_out),
	.swacc_out(foo_r2_f3__swacc_out)
	.hw_value(foo_r2_f3__next_value),
	.hw_pulse(foo_r2_f3__pulse),
	.field_value(foo_r2_f3__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(2),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(2'h0),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__foo_r2_f5
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(foo_r2_f5_wr_data),
	.sw_rd(rd_sel_ff[1]),
	.sw_wr(wr_sel_ff[1]),
	.write_protect_en(1),
	.sw_out(foo_r2_f5__swmod_out),
	.swacc_out(foo_r2_f5__swacc_out)
	.hw_value(foo_r2_f5__next_value),
	.hw_pulse(foo_r2_f5__pulse),
	.field_value(foo_r2_f5__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(2),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(2'h0),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__foo_r2_f4
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(foo_r2_f4_wr_data),
	.sw_rd(rd_sel_ff[1]),
	.sw_wr(wr_sel_ff[1]),
	.write_protect_en(1),
	.sw_out(foo_r2_f4__swmod_out),
	.swacc_out(foo_r2_f4__swacc_out)
	.hw_value(foo_r2_f4__next_value),
	.hw_pulse(foo_r2_f4__pulse),
	.field_value(foo_r2_f4__curr_value)
	);
always_comb begin
	foo_r2[31:0] = 32'd0;
	foo_r2[15:0] = foo_r2_f1__curr_value;
	foo_r2[16:16] = foo_r2_f2__curr_value;
	foo_r2[17:17] = foo_r2_f3__curr_value;
	foo_r2[29:28] = foo_r2_f5__curr_value;
	foo_r2[31:30] = foo_r2_f4__curr_value;
end
assign reg_rd_data_in[1] = foo_r2;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: foo_r3//
//REG HIERARCHY: ['basic', 'foo', 'r3']//
//REG ABSOLUTE_ADDR:64'h8//
//REG OFFSET_ADDR:64'h64'h8//
wire [31:0] foo_r3;
wire [31:0] foo_r3_wr_data;
assign foo_r3_wr_data = reg_sel_ff[2] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'hc8),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`W),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__foo_r3_f1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(foo_r3_f1_wr_data),
	.sw_rd(rd_sel_ff[2]),
	.sw_wr(wr_sel_ff[2]),
	.write_protect_en(2),
	.sw_out(foo_r3_f1__swmod_out),
	.swacc_out(foo_r3_f1__swacc_out)
	.hw_value(foo_r3_f1__next_value),
	.hw_pulse(foo_r3_f1__pulse),
	.field_value(foo_r3_f1__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(1),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(1'h0),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__foo_r3_f2
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(foo_r3_f2_wr_data),
	.sw_rd(rd_sel_ff[2]),
	.sw_wr(wr_sel_ff[2]),
	.write_protect_en(2),
	.sw_out(foo_r3_f2__swmod_out),
	.swacc_out(foo_r3_f2__swacc_out)
	.hw_value(foo_r3_f2__next_value),
	.hw_pulse(foo_r3_f2__pulse),
	.field_value(foo_r3_f2__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(1),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(1'h0),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__foo_r3_f3
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(foo_r3_f3_wr_data),
	.sw_rd(rd_sel_ff[2]),
	.sw_wr(wr_sel_ff[2]),
	.write_protect_en(2),
	.sw_out(foo_r3_f3__swmod_out),
	.swacc_out(foo_r3_f3__swacc_out)
	.hw_value(foo_r3_f3__next_value),
	.hw_pulse(foo_r3_f3__pulse),
	.field_value(foo_r3_f3__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(2),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(2'h0),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__foo_r3_f5
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(foo_r3_f5_wr_data),
	.sw_rd(rd_sel_ff[2]),
	.sw_wr(wr_sel_ff[2]),
	.write_protect_en(2),
	.sw_out(foo_r3_f5__swmod_out),
	.swacc_out(foo_r3_f5__swacc_out)
	.hw_value(foo_r3_f5__next_value),
	.hw_pulse(foo_r3_f5__pulse),
	.field_value(foo_r3_f5__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(2),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(2'h0),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__foo_r3_f4
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(foo_r3_f4_wr_data),
	.sw_rd(rd_sel_ff[2]),
	.sw_wr(wr_sel_ff[2]),
	.write_protect_en(2),
	.sw_out(foo_r3_f4__swmod_out),
	.swacc_out(foo_r3_f4__swacc_out)
	.hw_value(foo_r3_f4__next_value),
	.hw_pulse(foo_r3_f4__pulse),
	.field_value(foo_r3_f4__curr_value)
	);
always_comb begin
	foo_r3[31:0] = 32'd0;
	foo_r3[15:0] = foo_r3_f1__curr_value;
	foo_r3[16:16] = foo_r3_f2__curr_value;
	foo_r3[17:17] = foo_r3_f3__curr_value;
	foo_r3[29:28] = foo_r3_f5__curr_value;
	foo_r3[31:30] = foo_r3_f4__curr_value;
end
assign reg_rd_data_in[2] = foo_r3;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar0_0_r10//
//REG HIERARCHY: ['basic', 'bar[0][0]', 'r1[0]']//
//REG ABSOLUTE_ADDR:64'h1000//
//REG OFFSET_ADDR:64'h64'h0//
wire [31:0] bar0_0_r10;
wire [31:0] bar0_0_r10_wr_data;
assign bar0_0_r10_wr_data = reg_sel_ff[3] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar0_0_r10_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar0_0_r10_fo_wr_data),
	.sw_rd(rd_sel_ff[3]),
	.sw_wr(wr_sel_ff[3]),
	.write_protect_en(3),
	.sw_out(bar0_0_r10_fo__swmod_out),
	.swacc_out(bar0_0_r10_fo__swacc_out)
	.hw_value(bar0_0_r10_fo__next_value),
	.hw_pulse(bar0_0_r10_fo__pulse),
	.field_value(bar0_0_r10_fo__curr_value)
	);
always_comb begin
	bar0_0_r10[31:0] = 32'd0;
	bar0_0_r10[15:0] = bar0_0_r10_fo__curr_value;
end
assign reg_rd_data_in[3] = bar0_0_r10;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar0_0_r11//
//REG HIERARCHY: ['basic', 'bar[0][0]', 'r1[1]']//
//REG ABSOLUTE_ADDR:64'h1004//
//REG OFFSET_ADDR:64'h64'h4//
wire [31:0] bar0_0_r11;
wire [31:0] bar0_0_r11_wr_data;
assign bar0_0_r11_wr_data = reg_sel_ff[4] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar0_0_r11_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar0_0_r11_fo_wr_data),
	.sw_rd(rd_sel_ff[4]),
	.sw_wr(wr_sel_ff[4]),
	.write_protect_en(4),
	.sw_out(bar0_0_r11_fo__swmod_out),
	.swacc_out(bar0_0_r11_fo__swacc_out)
	.hw_value(bar0_0_r11_fo__next_value),
	.hw_pulse(bar0_0_r11_fo__pulse),
	.field_value(bar0_0_r11_fo__curr_value)
	);
always_comb begin
	bar0_0_r11[31:0] = 32'd0;
	bar0_0_r11[15:0] = bar0_0_r11_fo__curr_value;
end
assign reg_rd_data_in[4] = bar0_0_r11;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar0_0_r12//
//REG HIERARCHY: ['basic', 'bar[0][0]', 'r1[2]']//
//REG ABSOLUTE_ADDR:64'h1008//
//REG OFFSET_ADDR:64'h64'h8//
wire [31:0] bar0_0_r12;
wire [31:0] bar0_0_r12_wr_data;
assign bar0_0_r12_wr_data = reg_sel_ff[5] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar0_0_r12_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar0_0_r12_fo_wr_data),
	.sw_rd(rd_sel_ff[5]),
	.sw_wr(wr_sel_ff[5]),
	.write_protect_en(5),
	.sw_out(bar0_0_r12_fo__swmod_out),
	.swacc_out(bar0_0_r12_fo__swacc_out)
	.hw_value(bar0_0_r12_fo__next_value),
	.hw_pulse(bar0_0_r12_fo__pulse),
	.field_value(bar0_0_r12_fo__curr_value)
	);
always_comb begin
	bar0_0_r12[31:0] = 32'd0;
	bar0_0_r12[15:0] = bar0_0_r12_fo__curr_value;
end
assign reg_rd_data_in[5] = bar0_0_r12;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar0_0_r13//
//REG HIERARCHY: ['basic', 'bar[0][0]', 'r1[3]']//
//REG ABSOLUTE_ADDR:64'h100c//
//REG OFFSET_ADDR:64'h64'hc//
wire [31:0] bar0_0_r13;
wire [31:0] bar0_0_r13_wr_data;
assign bar0_0_r13_wr_data = reg_sel_ff[6] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar0_0_r13_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar0_0_r13_fo_wr_data),
	.sw_rd(rd_sel_ff[6]),
	.sw_wr(wr_sel_ff[6]),
	.write_protect_en(6),
	.sw_out(bar0_0_r13_fo__swmod_out),
	.swacc_out(bar0_0_r13_fo__swacc_out)
	.hw_value(bar0_0_r13_fo__next_value),
	.hw_pulse(bar0_0_r13_fo__pulse),
	.field_value(bar0_0_r13_fo__curr_value)
	);
always_comb begin
	bar0_0_r13[31:0] = 32'd0;
	bar0_0_r13[15:0] = bar0_0_r13_fo__curr_value;
end
assign reg_rd_data_in[6] = bar0_0_r13;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar0_1_r10//
//REG HIERARCHY: ['basic', 'bar[0][1]', 'r1[0]']//
//REG ABSOLUTE_ADDR:64'h1100//
//REG OFFSET_ADDR:64'h64'h0//
wire [31:0] bar0_1_r10;
wire [31:0] bar0_1_r10_wr_data;
assign bar0_1_r10_wr_data = reg_sel_ff[7] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar0_1_r10_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar0_1_r10_fo_wr_data),
	.sw_rd(rd_sel_ff[7]),
	.sw_wr(wr_sel_ff[7]),
	.write_protect_en(7),
	.sw_out(bar0_1_r10_fo__swmod_out),
	.swacc_out(bar0_1_r10_fo__swacc_out)
	.hw_value(bar0_1_r10_fo__next_value),
	.hw_pulse(bar0_1_r10_fo__pulse),
	.field_value(bar0_1_r10_fo__curr_value)
	);
always_comb begin
	bar0_1_r10[31:0] = 32'd0;
	bar0_1_r10[15:0] = bar0_1_r10_fo__curr_value;
end
assign reg_rd_data_in[7] = bar0_1_r10;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar0_1_r11//
//REG HIERARCHY: ['basic', 'bar[0][1]', 'r1[1]']//
//REG ABSOLUTE_ADDR:64'h1104//
//REG OFFSET_ADDR:64'h64'h4//
wire [31:0] bar0_1_r11;
wire [31:0] bar0_1_r11_wr_data;
assign bar0_1_r11_wr_data = reg_sel_ff[8] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar0_1_r11_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar0_1_r11_fo_wr_data),
	.sw_rd(rd_sel_ff[8]),
	.sw_wr(wr_sel_ff[8]),
	.write_protect_en(8),
	.sw_out(bar0_1_r11_fo__swmod_out),
	.swacc_out(bar0_1_r11_fo__swacc_out)
	.hw_value(bar0_1_r11_fo__next_value),
	.hw_pulse(bar0_1_r11_fo__pulse),
	.field_value(bar0_1_r11_fo__curr_value)
	);
always_comb begin
	bar0_1_r11[31:0] = 32'd0;
	bar0_1_r11[15:0] = bar0_1_r11_fo__curr_value;
end
assign reg_rd_data_in[8] = bar0_1_r11;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar0_1_r12//
//REG HIERARCHY: ['basic', 'bar[0][1]', 'r1[2]']//
//REG ABSOLUTE_ADDR:64'h1108//
//REG OFFSET_ADDR:64'h64'h8//
wire [31:0] bar0_1_r12;
wire [31:0] bar0_1_r12_wr_data;
assign bar0_1_r12_wr_data = reg_sel_ff[9] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar0_1_r12_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar0_1_r12_fo_wr_data),
	.sw_rd(rd_sel_ff[9]),
	.sw_wr(wr_sel_ff[9]),
	.write_protect_en(9),
	.sw_out(bar0_1_r12_fo__swmod_out),
	.swacc_out(bar0_1_r12_fo__swacc_out)
	.hw_value(bar0_1_r12_fo__next_value),
	.hw_pulse(bar0_1_r12_fo__pulse),
	.field_value(bar0_1_r12_fo__curr_value)
	);
always_comb begin
	bar0_1_r12[31:0] = 32'd0;
	bar0_1_r12[15:0] = bar0_1_r12_fo__curr_value;
end
assign reg_rd_data_in[9] = bar0_1_r12;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar0_1_r13//
//REG HIERARCHY: ['basic', 'bar[0][1]', 'r1[3]']//
//REG ABSOLUTE_ADDR:64'h110c//
//REG OFFSET_ADDR:64'h64'hc//
wire [31:0] bar0_1_r13;
wire [31:0] bar0_1_r13_wr_data;
assign bar0_1_r13_wr_data = reg_sel_ff[10] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar0_1_r13_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar0_1_r13_fo_wr_data),
	.sw_rd(rd_sel_ff[10]),
	.sw_wr(wr_sel_ff[10]),
	.write_protect_en(10),
	.sw_out(bar0_1_r13_fo__swmod_out),
	.swacc_out(bar0_1_r13_fo__swacc_out)
	.hw_value(bar0_1_r13_fo__next_value),
	.hw_pulse(bar0_1_r13_fo__pulse),
	.field_value(bar0_1_r13_fo__curr_value)
	);
always_comb begin
	bar0_1_r13[31:0] = 32'd0;
	bar0_1_r13[15:0] = bar0_1_r13_fo__curr_value;
end
assign reg_rd_data_in[10] = bar0_1_r13;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar0_2_r10//
//REG HIERARCHY: ['basic', 'bar[0][2]', 'r1[0]']//
//REG ABSOLUTE_ADDR:64'h1200//
//REG OFFSET_ADDR:64'h64'h0//
wire [31:0] bar0_2_r10;
wire [31:0] bar0_2_r10_wr_data;
assign bar0_2_r10_wr_data = reg_sel_ff[11] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar0_2_r10_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar0_2_r10_fo_wr_data),
	.sw_rd(rd_sel_ff[11]),
	.sw_wr(wr_sel_ff[11]),
	.write_protect_en(11),
	.sw_out(bar0_2_r10_fo__swmod_out),
	.swacc_out(bar0_2_r10_fo__swacc_out)
	.hw_value(bar0_2_r10_fo__next_value),
	.hw_pulse(bar0_2_r10_fo__pulse),
	.field_value(bar0_2_r10_fo__curr_value)
	);
always_comb begin
	bar0_2_r10[31:0] = 32'd0;
	bar0_2_r10[15:0] = bar0_2_r10_fo__curr_value;
end
assign reg_rd_data_in[11] = bar0_2_r10;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar0_2_r11//
//REG HIERARCHY: ['basic', 'bar[0][2]', 'r1[1]']//
//REG ABSOLUTE_ADDR:64'h1204//
//REG OFFSET_ADDR:64'h64'h4//
wire [31:0] bar0_2_r11;
wire [31:0] bar0_2_r11_wr_data;
assign bar0_2_r11_wr_data = reg_sel_ff[12] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar0_2_r11_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar0_2_r11_fo_wr_data),
	.sw_rd(rd_sel_ff[12]),
	.sw_wr(wr_sel_ff[12]),
	.write_protect_en(12),
	.sw_out(bar0_2_r11_fo__swmod_out),
	.swacc_out(bar0_2_r11_fo__swacc_out)
	.hw_value(bar0_2_r11_fo__next_value),
	.hw_pulse(bar0_2_r11_fo__pulse),
	.field_value(bar0_2_r11_fo__curr_value)
	);
always_comb begin
	bar0_2_r11[31:0] = 32'd0;
	bar0_2_r11[15:0] = bar0_2_r11_fo__curr_value;
end
assign reg_rd_data_in[12] = bar0_2_r11;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar0_2_r12//
//REG HIERARCHY: ['basic', 'bar[0][2]', 'r1[2]']//
//REG ABSOLUTE_ADDR:64'h1208//
//REG OFFSET_ADDR:64'h64'h8//
wire [31:0] bar0_2_r12;
wire [31:0] bar0_2_r12_wr_data;
assign bar0_2_r12_wr_data = reg_sel_ff[13] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar0_2_r12_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar0_2_r12_fo_wr_data),
	.sw_rd(rd_sel_ff[13]),
	.sw_wr(wr_sel_ff[13]),
	.write_protect_en(13),
	.sw_out(bar0_2_r12_fo__swmod_out),
	.swacc_out(bar0_2_r12_fo__swacc_out)
	.hw_value(bar0_2_r12_fo__next_value),
	.hw_pulse(bar0_2_r12_fo__pulse),
	.field_value(bar0_2_r12_fo__curr_value)
	);
always_comb begin
	bar0_2_r12[31:0] = 32'd0;
	bar0_2_r12[15:0] = bar0_2_r12_fo__curr_value;
end
assign reg_rd_data_in[13] = bar0_2_r12;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar0_2_r13//
//REG HIERARCHY: ['basic', 'bar[0][2]', 'r1[3]']//
//REG ABSOLUTE_ADDR:64'h120c//
//REG OFFSET_ADDR:64'h64'hc//
wire [31:0] bar0_2_r13;
wire [31:0] bar0_2_r13_wr_data;
assign bar0_2_r13_wr_data = reg_sel_ff[14] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar0_2_r13_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar0_2_r13_fo_wr_data),
	.sw_rd(rd_sel_ff[14]),
	.sw_wr(wr_sel_ff[14]),
	.write_protect_en(14),
	.sw_out(bar0_2_r13_fo__swmod_out),
	.swacc_out(bar0_2_r13_fo__swacc_out)
	.hw_value(bar0_2_r13_fo__next_value),
	.hw_pulse(bar0_2_r13_fo__pulse),
	.field_value(bar0_2_r13_fo__curr_value)
	);
always_comb begin
	bar0_2_r13[31:0] = 32'd0;
	bar0_2_r13[15:0] = bar0_2_r13_fo__curr_value;
end
assign reg_rd_data_in[14] = bar0_2_r13;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar1_0_r10//
//REG HIERARCHY: ['basic', 'bar[1][0]', 'r1[0]']//
//REG ABSOLUTE_ADDR:64'h1300//
//REG OFFSET_ADDR:64'h64'h0//
wire [31:0] bar1_0_r10;
wire [31:0] bar1_0_r10_wr_data;
assign bar1_0_r10_wr_data = reg_sel_ff[15] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar1_0_r10_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar1_0_r10_fo_wr_data),
	.sw_rd(rd_sel_ff[15]),
	.sw_wr(wr_sel_ff[15]),
	.write_protect_en(15),
	.sw_out(bar1_0_r10_fo__swmod_out),
	.swacc_out(bar1_0_r10_fo__swacc_out)
	.hw_value(bar1_0_r10_fo__next_value),
	.hw_pulse(bar1_0_r10_fo__pulse),
	.field_value(bar1_0_r10_fo__curr_value)
	);
always_comb begin
	bar1_0_r10[31:0] = 32'd0;
	bar1_0_r10[15:0] = bar1_0_r10_fo__curr_value;
end
assign reg_rd_data_in[15] = bar1_0_r10;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar1_0_r11//
//REG HIERARCHY: ['basic', 'bar[1][0]', 'r1[1]']//
//REG ABSOLUTE_ADDR:64'h1304//
//REG OFFSET_ADDR:64'h64'h4//
wire [31:0] bar1_0_r11;
wire [31:0] bar1_0_r11_wr_data;
assign bar1_0_r11_wr_data = reg_sel_ff[16] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar1_0_r11_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar1_0_r11_fo_wr_data),
	.sw_rd(rd_sel_ff[16]),
	.sw_wr(wr_sel_ff[16]),
	.write_protect_en(16),
	.sw_out(bar1_0_r11_fo__swmod_out),
	.swacc_out(bar1_0_r11_fo__swacc_out)
	.hw_value(bar1_0_r11_fo__next_value),
	.hw_pulse(bar1_0_r11_fo__pulse),
	.field_value(bar1_0_r11_fo__curr_value)
	);
always_comb begin
	bar1_0_r11[31:0] = 32'd0;
	bar1_0_r11[15:0] = bar1_0_r11_fo__curr_value;
end
assign reg_rd_data_in[16] = bar1_0_r11;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar1_0_r12//
//REG HIERARCHY: ['basic', 'bar[1][0]', 'r1[2]']//
//REG ABSOLUTE_ADDR:64'h1308//
//REG OFFSET_ADDR:64'h64'h8//
wire [31:0] bar1_0_r12;
wire [31:0] bar1_0_r12_wr_data;
assign bar1_0_r12_wr_data = reg_sel_ff[17] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar1_0_r12_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar1_0_r12_fo_wr_data),
	.sw_rd(rd_sel_ff[17]),
	.sw_wr(wr_sel_ff[17]),
	.write_protect_en(17),
	.sw_out(bar1_0_r12_fo__swmod_out),
	.swacc_out(bar1_0_r12_fo__swacc_out)
	.hw_value(bar1_0_r12_fo__next_value),
	.hw_pulse(bar1_0_r12_fo__pulse),
	.field_value(bar1_0_r12_fo__curr_value)
	);
always_comb begin
	bar1_0_r12[31:0] = 32'd0;
	bar1_0_r12[15:0] = bar1_0_r12_fo__curr_value;
end
assign reg_rd_data_in[17] = bar1_0_r12;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar1_0_r13//
//REG HIERARCHY: ['basic', 'bar[1][0]', 'r1[3]']//
//REG ABSOLUTE_ADDR:64'h130c//
//REG OFFSET_ADDR:64'h64'hc//
wire [31:0] bar1_0_r13;
wire [31:0] bar1_0_r13_wr_data;
assign bar1_0_r13_wr_data = reg_sel_ff[18] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar1_0_r13_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar1_0_r13_fo_wr_data),
	.sw_rd(rd_sel_ff[18]),
	.sw_wr(wr_sel_ff[18]),
	.write_protect_en(18),
	.sw_out(bar1_0_r13_fo__swmod_out),
	.swacc_out(bar1_0_r13_fo__swacc_out)
	.hw_value(bar1_0_r13_fo__next_value),
	.hw_pulse(bar1_0_r13_fo__pulse),
	.field_value(bar1_0_r13_fo__curr_value)
	);
always_comb begin
	bar1_0_r13[31:0] = 32'd0;
	bar1_0_r13[15:0] = bar1_0_r13_fo__curr_value;
end
assign reg_rd_data_in[18] = bar1_0_r13;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar1_1_r10//
//REG HIERARCHY: ['basic', 'bar[1][1]', 'r1[0]']//
//REG ABSOLUTE_ADDR:64'h1400//
//REG OFFSET_ADDR:64'h64'h0//
wire [31:0] bar1_1_r10;
wire [31:0] bar1_1_r10_wr_data;
assign bar1_1_r10_wr_data = reg_sel_ff[19] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar1_1_r10_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar1_1_r10_fo_wr_data),
	.sw_rd(rd_sel_ff[19]),
	.sw_wr(wr_sel_ff[19]),
	.write_protect_en(19),
	.sw_out(bar1_1_r10_fo__swmod_out),
	.swacc_out(bar1_1_r10_fo__swacc_out)
	.hw_value(bar1_1_r10_fo__next_value),
	.hw_pulse(bar1_1_r10_fo__pulse),
	.field_value(bar1_1_r10_fo__curr_value)
	);
always_comb begin
	bar1_1_r10[31:0] = 32'd0;
	bar1_1_r10[15:0] = bar1_1_r10_fo__curr_value;
end
assign reg_rd_data_in[19] = bar1_1_r10;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar1_1_r11//
//REG HIERARCHY: ['basic', 'bar[1][1]', 'r1[1]']//
//REG ABSOLUTE_ADDR:64'h1404//
//REG OFFSET_ADDR:64'h64'h4//
wire [31:0] bar1_1_r11;
wire [31:0] bar1_1_r11_wr_data;
assign bar1_1_r11_wr_data = reg_sel_ff[20] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar1_1_r11_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar1_1_r11_fo_wr_data),
	.sw_rd(rd_sel_ff[20]),
	.sw_wr(wr_sel_ff[20]),
	.write_protect_en(20),
	.sw_out(bar1_1_r11_fo__swmod_out),
	.swacc_out(bar1_1_r11_fo__swacc_out)
	.hw_value(bar1_1_r11_fo__next_value),
	.hw_pulse(bar1_1_r11_fo__pulse),
	.field_value(bar1_1_r11_fo__curr_value)
	);
always_comb begin
	bar1_1_r11[31:0] = 32'd0;
	bar1_1_r11[15:0] = bar1_1_r11_fo__curr_value;
end
assign reg_rd_data_in[20] = bar1_1_r11;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar1_1_r12//
//REG HIERARCHY: ['basic', 'bar[1][1]', 'r1[2]']//
//REG ABSOLUTE_ADDR:64'h1408//
//REG OFFSET_ADDR:64'h64'h8//
wire [31:0] bar1_1_r12;
wire [31:0] bar1_1_r12_wr_data;
assign bar1_1_r12_wr_data = reg_sel_ff[21] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar1_1_r12_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar1_1_r12_fo_wr_data),
	.sw_rd(rd_sel_ff[21]),
	.sw_wr(wr_sel_ff[21]),
	.write_protect_en(21),
	.sw_out(bar1_1_r12_fo__swmod_out),
	.swacc_out(bar1_1_r12_fo__swacc_out)
	.hw_value(bar1_1_r12_fo__next_value),
	.hw_pulse(bar1_1_r12_fo__pulse),
	.field_value(bar1_1_r12_fo__curr_value)
	);
always_comb begin
	bar1_1_r12[31:0] = 32'd0;
	bar1_1_r12[15:0] = bar1_1_r12_fo__curr_value;
end
assign reg_rd_data_in[21] = bar1_1_r12;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar1_1_r13//
//REG HIERARCHY: ['basic', 'bar[1][1]', 'r1[3]']//
//REG ABSOLUTE_ADDR:64'h140c//
//REG OFFSET_ADDR:64'h64'hc//
wire [31:0] bar1_1_r13;
wire [31:0] bar1_1_r13_wr_data;
assign bar1_1_r13_wr_data = reg_sel_ff[22] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar1_1_r13_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar1_1_r13_fo_wr_data),
	.sw_rd(rd_sel_ff[22]),
	.sw_wr(wr_sel_ff[22]),
	.write_protect_en(22),
	.sw_out(bar1_1_r13_fo__swmod_out),
	.swacc_out(bar1_1_r13_fo__swacc_out)
	.hw_value(bar1_1_r13_fo__next_value),
	.hw_pulse(bar1_1_r13_fo__pulse),
	.field_value(bar1_1_r13_fo__curr_value)
	);
always_comb begin
	bar1_1_r13[31:0] = 32'd0;
	bar1_1_r13[15:0] = bar1_1_r13_fo__curr_value;
end
assign reg_rd_data_in[22] = bar1_1_r13;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar1_2_r10//
//REG HIERARCHY: ['basic', 'bar[1][2]', 'r1[0]']//
//REG ABSOLUTE_ADDR:64'h1500//
//REG OFFSET_ADDR:64'h64'h0//
wire [31:0] bar1_2_r10;
wire [31:0] bar1_2_r10_wr_data;
assign bar1_2_r10_wr_data = reg_sel_ff[23] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar1_2_r10_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar1_2_r10_fo_wr_data),
	.sw_rd(rd_sel_ff[23]),
	.sw_wr(wr_sel_ff[23]),
	.write_protect_en(23),
	.sw_out(bar1_2_r10_fo__swmod_out),
	.swacc_out(bar1_2_r10_fo__swacc_out)
	.hw_value(bar1_2_r10_fo__next_value),
	.hw_pulse(bar1_2_r10_fo__pulse),
	.field_value(bar1_2_r10_fo__curr_value)
	);
always_comb begin
	bar1_2_r10[31:0] = 32'd0;
	bar1_2_r10[15:0] = bar1_2_r10_fo__curr_value;
end
assign reg_rd_data_in[23] = bar1_2_r10;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar1_2_r11//
//REG HIERARCHY: ['basic', 'bar[1][2]', 'r1[1]']//
//REG ABSOLUTE_ADDR:64'h1504//
//REG OFFSET_ADDR:64'h64'h4//
wire [31:0] bar1_2_r11;
wire [31:0] bar1_2_r11_wr_data;
assign bar1_2_r11_wr_data = reg_sel_ff[24] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar1_2_r11_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar1_2_r11_fo_wr_data),
	.sw_rd(rd_sel_ff[24]),
	.sw_wr(wr_sel_ff[24]),
	.write_protect_en(24),
	.sw_out(bar1_2_r11_fo__swmod_out),
	.swacc_out(bar1_2_r11_fo__swacc_out)
	.hw_value(bar1_2_r11_fo__next_value),
	.hw_pulse(bar1_2_r11_fo__pulse),
	.field_value(bar1_2_r11_fo__curr_value)
	);
always_comb begin
	bar1_2_r11[31:0] = 32'd0;
	bar1_2_r11[15:0] = bar1_2_r11_fo__curr_value;
end
assign reg_rd_data_in[24] = bar1_2_r11;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar1_2_r12//
//REG HIERARCHY: ['basic', 'bar[1][2]', 'r1[2]']//
//REG ABSOLUTE_ADDR:64'h1508//
//REG OFFSET_ADDR:64'h64'h8//
wire [31:0] bar1_2_r12;
wire [31:0] bar1_2_r12_wr_data;
assign bar1_2_r12_wr_data = reg_sel_ff[25] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar1_2_r12_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar1_2_r12_fo_wr_data),
	.sw_rd(rd_sel_ff[25]),
	.sw_wr(wr_sel_ff[25]),
	.write_protect_en(25),
	.sw_out(bar1_2_r12_fo__swmod_out),
	.swacc_out(bar1_2_r12_fo__swacc_out)
	.hw_value(bar1_2_r12_fo__next_value),
	.hw_pulse(bar1_2_r12_fo__pulse),
	.field_value(bar1_2_r12_fo__curr_value)
	);
always_comb begin
	bar1_2_r12[31:0] = 32'd0;
	bar1_2_r12[15:0] = bar1_2_r12_fo__curr_value;
end
assign reg_rd_data_in[25] = bar1_2_r12;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar1_2_r13//
//REG HIERARCHY: ['basic', 'bar[1][2]', 'r1[3]']//
//REG ABSOLUTE_ADDR:64'h150c//
//REG OFFSET_ADDR:64'h64'hc//
wire [31:0] bar1_2_r13;
wire [31:0] bar1_2_r13_wr_data;
assign bar1_2_r13_wr_data = reg_sel_ff[26] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar1_2_r13_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar1_2_r13_fo_wr_data),
	.sw_rd(rd_sel_ff[26]),
	.sw_wr(wr_sel_ff[26]),
	.write_protect_en(26),
	.sw_out(bar1_2_r13_fo__swmod_out),
	.swacc_out(bar1_2_r13_fo__swacc_out)
	.hw_value(bar1_2_r13_fo__next_value),
	.hw_pulse(bar1_2_r13_fo__pulse),
	.field_value(bar1_2_r13_fo__curr_value)
	);
always_comb begin
	bar1_2_r13[31:0] = 32'd0;
	bar1_2_r13[15:0] = bar1_2_r13_fo__curr_value;
end
assign reg_rd_data_in[26] = bar1_2_r13;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar2_0_r10//
//REG HIERARCHY: ['basic', 'bar[2][0]', 'r1[0]']//
//REG ABSOLUTE_ADDR:64'h1600//
//REG OFFSET_ADDR:64'h64'h0//
wire [31:0] bar2_0_r10;
wire [31:0] bar2_0_r10_wr_data;
assign bar2_0_r10_wr_data = reg_sel_ff[27] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar2_0_r10_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar2_0_r10_fo_wr_data),
	.sw_rd(rd_sel_ff[27]),
	.sw_wr(wr_sel_ff[27]),
	.write_protect_en(27),
	.sw_out(bar2_0_r10_fo__swmod_out),
	.swacc_out(bar2_0_r10_fo__swacc_out)
	.hw_value(bar2_0_r10_fo__next_value),
	.hw_pulse(bar2_0_r10_fo__pulse),
	.field_value(bar2_0_r10_fo__curr_value)
	);
always_comb begin
	bar2_0_r10[31:0] = 32'd0;
	bar2_0_r10[15:0] = bar2_0_r10_fo__curr_value;
end
assign reg_rd_data_in[27] = bar2_0_r10;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar2_0_r11//
//REG HIERARCHY: ['basic', 'bar[2][0]', 'r1[1]']//
//REG ABSOLUTE_ADDR:64'h1604//
//REG OFFSET_ADDR:64'h64'h4//
wire [31:0] bar2_0_r11;
wire [31:0] bar2_0_r11_wr_data;
assign bar2_0_r11_wr_data = reg_sel_ff[28] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar2_0_r11_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar2_0_r11_fo_wr_data),
	.sw_rd(rd_sel_ff[28]),
	.sw_wr(wr_sel_ff[28]),
	.write_protect_en(28),
	.sw_out(bar2_0_r11_fo__swmod_out),
	.swacc_out(bar2_0_r11_fo__swacc_out)
	.hw_value(bar2_0_r11_fo__next_value),
	.hw_pulse(bar2_0_r11_fo__pulse),
	.field_value(bar2_0_r11_fo__curr_value)
	);
always_comb begin
	bar2_0_r11[31:0] = 32'd0;
	bar2_0_r11[15:0] = bar2_0_r11_fo__curr_value;
end
assign reg_rd_data_in[28] = bar2_0_r11;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar2_0_r12//
//REG HIERARCHY: ['basic', 'bar[2][0]', 'r1[2]']//
//REG ABSOLUTE_ADDR:64'h1608//
//REG OFFSET_ADDR:64'h64'h8//
wire [31:0] bar2_0_r12;
wire [31:0] bar2_0_r12_wr_data;
assign bar2_0_r12_wr_data = reg_sel_ff[29] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar2_0_r12_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar2_0_r12_fo_wr_data),
	.sw_rd(rd_sel_ff[29]),
	.sw_wr(wr_sel_ff[29]),
	.write_protect_en(29),
	.sw_out(bar2_0_r12_fo__swmod_out),
	.swacc_out(bar2_0_r12_fo__swacc_out)
	.hw_value(bar2_0_r12_fo__next_value),
	.hw_pulse(bar2_0_r12_fo__pulse),
	.field_value(bar2_0_r12_fo__curr_value)
	);
always_comb begin
	bar2_0_r12[31:0] = 32'd0;
	bar2_0_r12[15:0] = bar2_0_r12_fo__curr_value;
end
assign reg_rd_data_in[29] = bar2_0_r12;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar2_0_r13//
//REG HIERARCHY: ['basic', 'bar[2][0]', 'r1[3]']//
//REG ABSOLUTE_ADDR:64'h160c//
//REG OFFSET_ADDR:64'h64'hc//
wire [31:0] bar2_0_r13;
wire [31:0] bar2_0_r13_wr_data;
assign bar2_0_r13_wr_data = reg_sel_ff[30] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar2_0_r13_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar2_0_r13_fo_wr_data),
	.sw_rd(rd_sel_ff[30]),
	.sw_wr(wr_sel_ff[30]),
	.write_protect_en(30),
	.sw_out(bar2_0_r13_fo__swmod_out),
	.swacc_out(bar2_0_r13_fo__swacc_out)
	.hw_value(bar2_0_r13_fo__next_value),
	.hw_pulse(bar2_0_r13_fo__pulse),
	.field_value(bar2_0_r13_fo__curr_value)
	);
always_comb begin
	bar2_0_r13[31:0] = 32'd0;
	bar2_0_r13[15:0] = bar2_0_r13_fo__curr_value;
end
assign reg_rd_data_in[30] = bar2_0_r13;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar2_1_r10//
//REG HIERARCHY: ['basic', 'bar[2][1]', 'r1[0]']//
//REG ABSOLUTE_ADDR:64'h1700//
//REG OFFSET_ADDR:64'h64'h0//
wire [31:0] bar2_1_r10;
wire [31:0] bar2_1_r10_wr_data;
assign bar2_1_r10_wr_data = reg_sel_ff[31] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar2_1_r10_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar2_1_r10_fo_wr_data),
	.sw_rd(rd_sel_ff[31]),
	.sw_wr(wr_sel_ff[31]),
	.write_protect_en(31),
	.sw_out(bar2_1_r10_fo__swmod_out),
	.swacc_out(bar2_1_r10_fo__swacc_out)
	.hw_value(bar2_1_r10_fo__next_value),
	.hw_pulse(bar2_1_r10_fo__pulse),
	.field_value(bar2_1_r10_fo__curr_value)
	);
always_comb begin
	bar2_1_r10[31:0] = 32'd0;
	bar2_1_r10[15:0] = bar2_1_r10_fo__curr_value;
end
assign reg_rd_data_in[31] = bar2_1_r10;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar2_1_r11//
//REG HIERARCHY: ['basic', 'bar[2][1]', 'r1[1]']//
//REG ABSOLUTE_ADDR:64'h1704//
//REG OFFSET_ADDR:64'h64'h4//
wire [31:0] bar2_1_r11;
wire [31:0] bar2_1_r11_wr_data;
assign bar2_1_r11_wr_data = reg_sel_ff[32] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar2_1_r11_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar2_1_r11_fo_wr_data),
	.sw_rd(rd_sel_ff[32]),
	.sw_wr(wr_sel_ff[32]),
	.write_protect_en(32),
	.sw_out(bar2_1_r11_fo__swmod_out),
	.swacc_out(bar2_1_r11_fo__swacc_out)
	.hw_value(bar2_1_r11_fo__next_value),
	.hw_pulse(bar2_1_r11_fo__pulse),
	.field_value(bar2_1_r11_fo__curr_value)
	);
always_comb begin
	bar2_1_r11[31:0] = 32'd0;
	bar2_1_r11[15:0] = bar2_1_r11_fo__curr_value;
end
assign reg_rd_data_in[32] = bar2_1_r11;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar2_1_r12//
//REG HIERARCHY: ['basic', 'bar[2][1]', 'r1[2]']//
//REG ABSOLUTE_ADDR:64'h1708//
//REG OFFSET_ADDR:64'h64'h8//
wire [31:0] bar2_1_r12;
wire [31:0] bar2_1_r12_wr_data;
assign bar2_1_r12_wr_data = reg_sel_ff[33] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar2_1_r12_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar2_1_r12_fo_wr_data),
	.sw_rd(rd_sel_ff[33]),
	.sw_wr(wr_sel_ff[33]),
	.write_protect_en(33),
	.sw_out(bar2_1_r12_fo__swmod_out),
	.swacc_out(bar2_1_r12_fo__swacc_out)
	.hw_value(bar2_1_r12_fo__next_value),
	.hw_pulse(bar2_1_r12_fo__pulse),
	.field_value(bar2_1_r12_fo__curr_value)
	);
always_comb begin
	bar2_1_r12[31:0] = 32'd0;
	bar2_1_r12[15:0] = bar2_1_r12_fo__curr_value;
end
assign reg_rd_data_in[33] = bar2_1_r12;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar2_1_r13//
//REG HIERARCHY: ['basic', 'bar[2][1]', 'r1[3]']//
//REG ABSOLUTE_ADDR:64'h170c//
//REG OFFSET_ADDR:64'h64'hc//
wire [31:0] bar2_1_r13;
wire [31:0] bar2_1_r13_wr_data;
assign bar2_1_r13_wr_data = reg_sel_ff[34] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar2_1_r13_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar2_1_r13_fo_wr_data),
	.sw_rd(rd_sel_ff[34]),
	.sw_wr(wr_sel_ff[34]),
	.write_protect_en(34),
	.sw_out(bar2_1_r13_fo__swmod_out),
	.swacc_out(bar2_1_r13_fo__swacc_out)
	.hw_value(bar2_1_r13_fo__next_value),
	.hw_pulse(bar2_1_r13_fo__pulse),
	.field_value(bar2_1_r13_fo__curr_value)
	);
always_comb begin
	bar2_1_r13[31:0] = 32'd0;
	bar2_1_r13[15:0] = bar2_1_r13_fo__curr_value;
end
assign reg_rd_data_in[34] = bar2_1_r13;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar2_2_r10//
//REG HIERARCHY: ['basic', 'bar[2][2]', 'r1[0]']//
//REG ABSOLUTE_ADDR:64'h1800//
//REG OFFSET_ADDR:64'h64'h0//
wire [31:0] bar2_2_r10;
wire [31:0] bar2_2_r10_wr_data;
assign bar2_2_r10_wr_data = reg_sel_ff[35] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar2_2_r10_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar2_2_r10_fo_wr_data),
	.sw_rd(rd_sel_ff[35]),
	.sw_wr(wr_sel_ff[35]),
	.write_protect_en(35),
	.sw_out(bar2_2_r10_fo__swmod_out),
	.swacc_out(bar2_2_r10_fo__swacc_out)
	.hw_value(bar2_2_r10_fo__next_value),
	.hw_pulse(bar2_2_r10_fo__pulse),
	.field_value(bar2_2_r10_fo__curr_value)
	);
always_comb begin
	bar2_2_r10[31:0] = 32'd0;
	bar2_2_r10[15:0] = bar2_2_r10_fo__curr_value;
end
assign reg_rd_data_in[35] = bar2_2_r10;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar2_2_r11//
//REG HIERARCHY: ['basic', 'bar[2][2]', 'r1[1]']//
//REG ABSOLUTE_ADDR:64'h1804//
//REG OFFSET_ADDR:64'h64'h4//
wire [31:0] bar2_2_r11;
wire [31:0] bar2_2_r11_wr_data;
assign bar2_2_r11_wr_data = reg_sel_ff[36] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar2_2_r11_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar2_2_r11_fo_wr_data),
	.sw_rd(rd_sel_ff[36]),
	.sw_wr(wr_sel_ff[36]),
	.write_protect_en(36),
	.sw_out(bar2_2_r11_fo__swmod_out),
	.swacc_out(bar2_2_r11_fo__swacc_out)
	.hw_value(bar2_2_r11_fo__next_value),
	.hw_pulse(bar2_2_r11_fo__pulse),
	.field_value(bar2_2_r11_fo__curr_value)
	);
always_comb begin
	bar2_2_r11[31:0] = 32'd0;
	bar2_2_r11[15:0] = bar2_2_r11_fo__curr_value;
end
assign reg_rd_data_in[36] = bar2_2_r11;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar2_2_r12//
//REG HIERARCHY: ['basic', 'bar[2][2]', 'r1[2]']//
//REG ABSOLUTE_ADDR:64'h1808//
//REG OFFSET_ADDR:64'h64'h8//
wire [31:0] bar2_2_r12;
wire [31:0] bar2_2_r12_wr_data;
assign bar2_2_r12_wr_data = reg_sel_ff[37] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar2_2_r12_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar2_2_r12_fo_wr_data),
	.sw_rd(rd_sel_ff[37]),
	.sw_wr(wr_sel_ff[37]),
	.write_protect_en(37),
	.sw_out(bar2_2_r12_fo__swmod_out),
	.swacc_out(bar2_2_r12_fo__swacc_out)
	.hw_value(bar2_2_r12_fo__next_value),
	.hw_pulse(bar2_2_r12_fo__pulse),
	.field_value(bar2_2_r12_fo__curr_value)
	);
always_comb begin
	bar2_2_r12[31:0] = 32'd0;
	bar2_2_r12[15:0] = bar2_2_r12_fo__curr_value;
end
assign reg_rd_data_in[37] = bar2_2_r12;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar2_2_r13//
//REG HIERARCHY: ['basic', 'bar[2][2]', 'r1[3]']//
//REG ABSOLUTE_ADDR:64'h180c//
//REG OFFSET_ADDR:64'h64'hc//
wire [31:0] bar2_2_r13;
wire [31:0] bar2_2_r13_wr_data;
assign bar2_2_r13_wr_data = reg_sel_ff[38] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar2_2_r13_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar2_2_r13_fo_wr_data),
	.sw_rd(rd_sel_ff[38]),
	.sw_wr(wr_sel_ff[38]),
	.write_protect_en(38),
	.sw_out(bar2_2_r13_fo__swmod_out),
	.swacc_out(bar2_2_r13_fo__swacc_out)
	.hw_value(bar2_2_r13_fo__next_value),
	.hw_pulse(bar2_2_r13_fo__pulse),
	.field_value(bar2_2_r13_fo__curr_value)
	);
always_comb begin
	bar2_2_r13[31:0] = 32'd0;
	bar2_2_r13[15:0] = bar2_2_r13_fo__curr_value;
end
assign reg_rd_data_in[38] = bar2_2_r13;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar3_0_r10//
//REG HIERARCHY: ['basic', 'bar[3][0]', 'r1[0]']//
//REG ABSOLUTE_ADDR:64'h1900//
//REG OFFSET_ADDR:64'h64'h0//
wire [31:0] bar3_0_r10;
wire [31:0] bar3_0_r10_wr_data;
assign bar3_0_r10_wr_data = reg_sel_ff[39] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar3_0_r10_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar3_0_r10_fo_wr_data),
	.sw_rd(rd_sel_ff[39]),
	.sw_wr(wr_sel_ff[39]),
	.write_protect_en(39),
	.sw_out(bar3_0_r10_fo__swmod_out),
	.swacc_out(bar3_0_r10_fo__swacc_out)
	.hw_value(bar3_0_r10_fo__next_value),
	.hw_pulse(bar3_0_r10_fo__pulse),
	.field_value(bar3_0_r10_fo__curr_value)
	);
always_comb begin
	bar3_0_r10[31:0] = 32'd0;
	bar3_0_r10[15:0] = bar3_0_r10_fo__curr_value;
end
assign reg_rd_data_in[39] = bar3_0_r10;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar3_0_r11//
//REG HIERARCHY: ['basic', 'bar[3][0]', 'r1[1]']//
//REG ABSOLUTE_ADDR:64'h1904//
//REG OFFSET_ADDR:64'h64'h4//
wire [31:0] bar3_0_r11;
wire [31:0] bar3_0_r11_wr_data;
assign bar3_0_r11_wr_data = reg_sel_ff[40] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar3_0_r11_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar3_0_r11_fo_wr_data),
	.sw_rd(rd_sel_ff[40]),
	.sw_wr(wr_sel_ff[40]),
	.write_protect_en(40),
	.sw_out(bar3_0_r11_fo__swmod_out),
	.swacc_out(bar3_0_r11_fo__swacc_out)
	.hw_value(bar3_0_r11_fo__next_value),
	.hw_pulse(bar3_0_r11_fo__pulse),
	.field_value(bar3_0_r11_fo__curr_value)
	);
always_comb begin
	bar3_0_r11[31:0] = 32'd0;
	bar3_0_r11[15:0] = bar3_0_r11_fo__curr_value;
end
assign reg_rd_data_in[40] = bar3_0_r11;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar3_0_r12//
//REG HIERARCHY: ['basic', 'bar[3][0]', 'r1[2]']//
//REG ABSOLUTE_ADDR:64'h1908//
//REG OFFSET_ADDR:64'h64'h8//
wire [31:0] bar3_0_r12;
wire [31:0] bar3_0_r12_wr_data;
assign bar3_0_r12_wr_data = reg_sel_ff[41] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar3_0_r12_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar3_0_r12_fo_wr_data),
	.sw_rd(rd_sel_ff[41]),
	.sw_wr(wr_sel_ff[41]),
	.write_protect_en(41),
	.sw_out(bar3_0_r12_fo__swmod_out),
	.swacc_out(bar3_0_r12_fo__swacc_out)
	.hw_value(bar3_0_r12_fo__next_value),
	.hw_pulse(bar3_0_r12_fo__pulse),
	.field_value(bar3_0_r12_fo__curr_value)
	);
always_comb begin
	bar3_0_r12[31:0] = 32'd0;
	bar3_0_r12[15:0] = bar3_0_r12_fo__curr_value;
end
assign reg_rd_data_in[41] = bar3_0_r12;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar3_0_r13//
//REG HIERARCHY: ['basic', 'bar[3][0]', 'r1[3]']//
//REG ABSOLUTE_ADDR:64'h190c//
//REG OFFSET_ADDR:64'h64'hc//
wire [31:0] bar3_0_r13;
wire [31:0] bar3_0_r13_wr_data;
assign bar3_0_r13_wr_data = reg_sel_ff[42] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar3_0_r13_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar3_0_r13_fo_wr_data),
	.sw_rd(rd_sel_ff[42]),
	.sw_wr(wr_sel_ff[42]),
	.write_protect_en(42),
	.sw_out(bar3_0_r13_fo__swmod_out),
	.swacc_out(bar3_0_r13_fo__swacc_out)
	.hw_value(bar3_0_r13_fo__next_value),
	.hw_pulse(bar3_0_r13_fo__pulse),
	.field_value(bar3_0_r13_fo__curr_value)
	);
always_comb begin
	bar3_0_r13[31:0] = 32'd0;
	bar3_0_r13[15:0] = bar3_0_r13_fo__curr_value;
end
assign reg_rd_data_in[42] = bar3_0_r13;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar3_1_r10//
//REG HIERARCHY: ['basic', 'bar[3][1]', 'r1[0]']//
//REG ABSOLUTE_ADDR:64'h1a00//
//REG OFFSET_ADDR:64'h64'h0//
wire [31:0] bar3_1_r10;
wire [31:0] bar3_1_r10_wr_data;
assign bar3_1_r10_wr_data = reg_sel_ff[43] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar3_1_r10_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar3_1_r10_fo_wr_data),
	.sw_rd(rd_sel_ff[43]),
	.sw_wr(wr_sel_ff[43]),
	.write_protect_en(43),
	.sw_out(bar3_1_r10_fo__swmod_out),
	.swacc_out(bar3_1_r10_fo__swacc_out)
	.hw_value(bar3_1_r10_fo__next_value),
	.hw_pulse(bar3_1_r10_fo__pulse),
	.field_value(bar3_1_r10_fo__curr_value)
	);
always_comb begin
	bar3_1_r10[31:0] = 32'd0;
	bar3_1_r10[15:0] = bar3_1_r10_fo__curr_value;
end
assign reg_rd_data_in[43] = bar3_1_r10;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar3_1_r11//
//REG HIERARCHY: ['basic', 'bar[3][1]', 'r1[1]']//
//REG ABSOLUTE_ADDR:64'h1a04//
//REG OFFSET_ADDR:64'h64'h4//
wire [31:0] bar3_1_r11;
wire [31:0] bar3_1_r11_wr_data;
assign bar3_1_r11_wr_data = reg_sel_ff[44] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar3_1_r11_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar3_1_r11_fo_wr_data),
	.sw_rd(rd_sel_ff[44]),
	.sw_wr(wr_sel_ff[44]),
	.write_protect_en(44),
	.sw_out(bar3_1_r11_fo__swmod_out),
	.swacc_out(bar3_1_r11_fo__swacc_out)
	.hw_value(bar3_1_r11_fo__next_value),
	.hw_pulse(bar3_1_r11_fo__pulse),
	.field_value(bar3_1_r11_fo__curr_value)
	);
always_comb begin
	bar3_1_r11[31:0] = 32'd0;
	bar3_1_r11[15:0] = bar3_1_r11_fo__curr_value;
end
assign reg_rd_data_in[44] = bar3_1_r11;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar3_1_r12//
//REG HIERARCHY: ['basic', 'bar[3][1]', 'r1[2]']//
//REG ABSOLUTE_ADDR:64'h1a08//
//REG OFFSET_ADDR:64'h64'h8//
wire [31:0] bar3_1_r12;
wire [31:0] bar3_1_r12_wr_data;
assign bar3_1_r12_wr_data = reg_sel_ff[45] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar3_1_r12_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar3_1_r12_fo_wr_data),
	.sw_rd(rd_sel_ff[45]),
	.sw_wr(wr_sel_ff[45]),
	.write_protect_en(45),
	.sw_out(bar3_1_r12_fo__swmod_out),
	.swacc_out(bar3_1_r12_fo__swacc_out)
	.hw_value(bar3_1_r12_fo__next_value),
	.hw_pulse(bar3_1_r12_fo__pulse),
	.field_value(bar3_1_r12_fo__curr_value)
	);
always_comb begin
	bar3_1_r12[31:0] = 32'd0;
	bar3_1_r12[15:0] = bar3_1_r12_fo__curr_value;
end
assign reg_rd_data_in[45] = bar3_1_r12;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar3_1_r13//
//REG HIERARCHY: ['basic', 'bar[3][1]', 'r1[3]']//
//REG ABSOLUTE_ADDR:64'h1a0c//
//REG OFFSET_ADDR:64'h64'hc//
wire [31:0] bar3_1_r13;
wire [31:0] bar3_1_r13_wr_data;
assign bar3_1_r13_wr_data = reg_sel_ff[46] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar3_1_r13_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar3_1_r13_fo_wr_data),
	.sw_rd(rd_sel_ff[46]),
	.sw_wr(wr_sel_ff[46]),
	.write_protect_en(46),
	.sw_out(bar3_1_r13_fo__swmod_out),
	.swacc_out(bar3_1_r13_fo__swacc_out)
	.hw_value(bar3_1_r13_fo__next_value),
	.hw_pulse(bar3_1_r13_fo__pulse),
	.field_value(bar3_1_r13_fo__curr_value)
	);
always_comb begin
	bar3_1_r13[31:0] = 32'd0;
	bar3_1_r13[15:0] = bar3_1_r13_fo__curr_value;
end
assign reg_rd_data_in[46] = bar3_1_r13;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar3_2_r10//
//REG HIERARCHY: ['basic', 'bar[3][2]', 'r1[0]']//
//REG ABSOLUTE_ADDR:64'h1b00//
//REG OFFSET_ADDR:64'h64'h0//
wire [31:0] bar3_2_r10;
wire [31:0] bar3_2_r10_wr_data;
assign bar3_2_r10_wr_data = reg_sel_ff[47] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar3_2_r10_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar3_2_r10_fo_wr_data),
	.sw_rd(rd_sel_ff[47]),
	.sw_wr(wr_sel_ff[47]),
	.write_protect_en(47),
	.sw_out(bar3_2_r10_fo__swmod_out),
	.swacc_out(bar3_2_r10_fo__swacc_out)
	.hw_value(bar3_2_r10_fo__next_value),
	.hw_pulse(bar3_2_r10_fo__pulse),
	.field_value(bar3_2_r10_fo__curr_value)
	);
always_comb begin
	bar3_2_r10[31:0] = 32'd0;
	bar3_2_r10[15:0] = bar3_2_r10_fo__curr_value;
end
assign reg_rd_data_in[47] = bar3_2_r10;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar3_2_r11//
//REG HIERARCHY: ['basic', 'bar[3][2]', 'r1[1]']//
//REG ABSOLUTE_ADDR:64'h1b04//
//REG OFFSET_ADDR:64'h64'h4//
wire [31:0] bar3_2_r11;
wire [31:0] bar3_2_r11_wr_data;
assign bar3_2_r11_wr_data = reg_sel_ff[48] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar3_2_r11_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar3_2_r11_fo_wr_data),
	.sw_rd(rd_sel_ff[48]),
	.sw_wr(wr_sel_ff[48]),
	.write_protect_en(48),
	.sw_out(bar3_2_r11_fo__swmod_out),
	.swacc_out(bar3_2_r11_fo__swacc_out)
	.hw_value(bar3_2_r11_fo__next_value),
	.hw_pulse(bar3_2_r11_fo__pulse),
	.field_value(bar3_2_r11_fo__curr_value)
	);
always_comb begin
	bar3_2_r11[31:0] = 32'd0;
	bar3_2_r11[15:0] = bar3_2_r11_fo__curr_value;
end
assign reg_rd_data_in[48] = bar3_2_r11;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar3_2_r12//
//REG HIERARCHY: ['basic', 'bar[3][2]', 'r1[2]']//
//REG ABSOLUTE_ADDR:64'h1b08//
//REG OFFSET_ADDR:64'h64'h8//
wire [31:0] bar3_2_r12;
wire [31:0] bar3_2_r12_wr_data;
assign bar3_2_r12_wr_data = reg_sel_ff[49] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar3_2_r12_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar3_2_r12_fo_wr_data),
	.sw_rd(rd_sel_ff[49]),
	.sw_wr(wr_sel_ff[49]),
	.write_protect_en(49),
	.sw_out(bar3_2_r12_fo__swmod_out),
	.swacc_out(bar3_2_r12_fo__swacc_out)
	.hw_value(bar3_2_r12_fo__next_value),
	.hw_pulse(bar3_2_r12_fo__pulse),
	.field_value(bar3_2_r12_fo__curr_value)
	);
always_comb begin
	bar3_2_r12[31:0] = 32'd0;
	bar3_2_r12[15:0] = bar3_2_r12_fo__curr_value;
end
assign reg_rd_data_in[49] = bar3_2_r12;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar3_2_r13//
//REG HIERARCHY: ['basic', 'bar[3][2]', 'r1[3]']//
//REG ABSOLUTE_ADDR:64'h1b0c//
//REG OFFSET_ADDR:64'h64'hc//
wire [31:0] bar3_2_r13;
wire [31:0] bar3_2_r13_wr_data;
assign bar3_2_r13_wr_data = reg_sel_ff[50] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'h4d2),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`RW),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar3_2_r13_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar3_2_r13_fo_wr_data),
	.sw_rd(rd_sel_ff[50]),
	.sw_wr(wr_sel_ff[50]),
	.write_protect_en(50),
	.sw_out(bar3_2_r13_fo__swmod_out),
	.swacc_out(bar3_2_r13_fo__swacc_out)
	.hw_value(bar3_2_r13_fo__next_value),
	.hw_pulse(bar3_2_r13_fo__pulse),
	.field_value(bar3_2_r13_fo__curr_value)
	);
always_comb begin
	bar3_2_r13[31:0] = 32'd0;
	bar3_2_r13[15:0] = bar3_2_r13_fo__curr_value;
end
assign reg_rd_data_in[50] = bar3_2_r13;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar2_r10//
//REG HIERARCHY: ['basic', 'bar2', 'r1[0]']//
//REG ABSOLUTE_ADDR:64'h8000//
//REG OFFSET_ADDR:64'h64'h0//
wire [31:0] bar2_r10;
wire [31:0] bar2_r10_wr_data;
assign bar2_r10_wr_data = reg_sel_ff[51] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'hc8),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`W),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar2_r10_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar2_r10_fo_wr_data),
	.sw_rd(rd_sel_ff[51]),
	.sw_wr(wr_sel_ff[51]),
	.write_protect_en(51),
	.sw_out(bar2_r10_fo__swmod_out),
	.swacc_out(bar2_r10_fo__swacc_out)
	.hw_value(bar2_r10_fo__next_value),
	.hw_pulse(bar2_r10_fo__pulse),
	.field_value(bar2_r10_fo__curr_value)
	);
always_comb begin
	bar2_r10[31:0] = 32'd0;
	bar2_r10[15:0] = bar2_r10_fo__curr_value;
end
assign reg_rd_data_in[51] = bar2_r10;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar2_r11//
//REG HIERARCHY: ['basic', 'bar2', 'r1[1]']//
//REG ABSOLUTE_ADDR:64'h8004//
//REG OFFSET_ADDR:64'h64'h4//
wire [31:0] bar2_r11;
wire [31:0] bar2_r11_wr_data;
assign bar2_r11_wr_data = reg_sel_ff[52] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'hc8),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`W),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar2_r11_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar2_r11_fo_wr_data),
	.sw_rd(rd_sel_ff[52]),
	.sw_wr(wr_sel_ff[52]),
	.write_protect_en(52),
	.sw_out(bar2_r11_fo__swmod_out),
	.swacc_out(bar2_r11_fo__swacc_out)
	.hw_value(bar2_r11_fo__next_value),
	.hw_pulse(bar2_r11_fo__pulse),
	.field_value(bar2_r11_fo__curr_value)
	);
always_comb begin
	bar2_r11[31:0] = 32'd0;
	bar2_r11[15:0] = bar2_r11_fo__curr_value;
end
assign reg_rd_data_in[52] = bar2_r11;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar2_r12//
//REG HIERARCHY: ['basic', 'bar2', 'r1[2]']//
//REG ABSOLUTE_ADDR:64'h8008//
//REG OFFSET_ADDR:64'h64'h8//
wire [31:0] bar2_r12;
wire [31:0] bar2_r12_wr_data;
assign bar2_r12_wr_data = reg_sel_ff[53] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'hc8),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`W),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar2_r12_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar2_r12_fo_wr_data),
	.sw_rd(rd_sel_ff[53]),
	.sw_wr(wr_sel_ff[53]),
	.write_protect_en(53),
	.sw_out(bar2_r12_fo__swmod_out),
	.swacc_out(bar2_r12_fo__swacc_out)
	.hw_value(bar2_r12_fo__next_value),
	.hw_pulse(bar2_r12_fo__pulse),
	.field_value(bar2_r12_fo__curr_value)
	);
always_comb begin
	bar2_r12[31:0] = 32'd0;
	bar2_r12[15:0] = bar2_r12_fo__curr_value;
end
assign reg_rd_data_in[53] = bar2_r12;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: bar2_r13//
//REG HIERARCHY: ['basic', 'bar2', 'r1[3]']//
//REG ABSOLUTE_ADDR:64'h800c//
//REG OFFSET_ADDR:64'h64'hc//
wire [31:0] bar2_r13;
wire [31:0] bar2_r13_wr_data;
assign bar2_r13_wr_data = reg_sel_ff[54] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(16),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(16'hc8),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.SW_TYPE(`W),
	.SW_ONREAD_TYPE(`NA),
	.SW_ONWRITE_TYPE(`NA),
	.SWMOD(0),
	.SWACC(0),
	.PULSE(0),
	.HW_TYPE(`HW_RO),
	.PRECEDENCE(sw)
	)
x__bar2_r13_fo
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(bar2_r13_fo_wr_data),
	.sw_rd(rd_sel_ff[54]),
	.sw_wr(wr_sel_ff[54]),
	.write_protect_en(54),
	.sw_out(bar2_r13_fo__swmod_out),
	.swacc_out(bar2_r13_fo__swacc_out)
	.hw_value(bar2_r13_fo__next_value),
	.hw_pulse(bar2_r13_fo__pulse),
	.field_value(bar2_r13_fo__curr_value)
	);
always_comb begin
	bar2_r13[31:0] = 32'd0;
	bar2_r13[15:0] = bar2_r13_fo__curr_value;
end
assign reg_rd_data_in[54] = bar2_r13;
//=================END REG INSTANT==================//
//*******Register&field Instantiate END Here********//


//********EXTERNAL CONNECTION INSTANT START*********//
assign ext_wr_en = wr_en_ff;
assign ext_rd_en = rd_en_ff;
assign ext_addr = addr_ff;
assign ext_wr_data = wr_data_ff;
wire[1-1:0] ext_ack_vld
wire[1-1:0] ext_ack
//xxx connection, external[0];
assign ext_req_vld[0] = ext_sel_ff[0];
assign ext_ack[0] = ext_ack_vld_t[0] & ext_sel_ff[0];
//*********EXTERNAL CONNECTION INSTANT END**********//


//***********Rd_data Split Mux START Here***********//
split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(N), .GROUP_SIZE(64)) rd_split_mux
(.clk(clk), .rst_n(rstn),
.din(reg_rd_data_in), .sel(rd_sel_ff),
.dout(reg_rd_data_vld), .dout_vld(reg_ack_vld)
);
split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(M), .GROUP_SIZE(64)) ext_rd_split_mux
(.clk(clk), .rst_n(rstn),
.din(ext_rd_data), .sel(ext_ack),
.dout(ext_rd_data_vld), .dout_vld(ext_ack_vld)
);
//************Rd_data Split Mux END Here************//


//*******OUTPUT Signal Definitinon START Here*******//
// select which to read out and pull the corresponding vld signal high
assign rd_data_vld = ack_vld_t ? rd_data_t : rd_data;
assign ack_vld = ack_vld_t;
//********OUTPUT Signal Definitinon END Here********//
endmodule