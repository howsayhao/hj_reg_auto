`include "field_attr.vh"
`default_nettype none
module regslv_slv_map(
//*************************************INTERNAL FIELD PORT START**************************************//
	// ports of internal regfile
	map_110_TEM21__FIELD_3__next_value,
	map_110_TEM21__FIELD_3__pulse,
	map_110_TEM21__FIELD_3__curr_value,
	map_110_TEM21__FIELD_2__next_value,
	map_110_TEM21__FIELD_2__pulse,
	map_110_TEM21__FIELD_2__curr_value,
	map_110_TEM21__FIELD_1__next_value,
	map_110_TEM21__FIELD_1__pulse,
	map_110_TEM21__FIELD_1__curr_value,
	map_110_TEM22__FIELD_3__next_value,
	map_110_TEM22__FIELD_3__pulse,
	map_110_TEM22__FIELD_3__curr_value,
	map_110_TEM22__FIELD_2__next_value,
	map_110_TEM22__FIELD_2__pulse,
	map_110_TEM22__FIELD_2__curr_value,
	map_110_TEM22__FIELD_1__next_value,
	map_110_TEM22__FIELD_1__pulse,
	map_110_TEM22__FIELD_1__curr_value,
	map_111_TEM21__FIELD_3__next_value,
	map_111_TEM21__FIELD_3__pulse,
	map_111_TEM21__FIELD_3__curr_value,
	map_111_TEM21__FIELD_2__next_value,
	map_111_TEM21__FIELD_2__pulse,
	map_111_TEM21__FIELD_2__curr_value,
	map_111_TEM21__FIELD_1__next_value,
	map_111_TEM21__FIELD_1__pulse,
	map_111_TEM21__FIELD_1__curr_value,
	map_111_TEM22__FIELD_3__next_value,
	map_111_TEM22__FIELD_3__pulse,
	map_111_TEM22__FIELD_3__curr_value,
	map_111_TEM22__FIELD_2__next_value,
	map_111_TEM22__FIELD_2__pulse,
	map_111_TEM22__FIELD_2__curr_value,
	map_111_TEM22__FIELD_1__next_value,
	map_111_TEM22__FIELD_1__pulse,
	map_111_TEM22__FIELD_1__curr_value,
	map_112_TEM21__FIELD_3__next_value,
	map_112_TEM21__FIELD_3__pulse,
	map_112_TEM21__FIELD_3__curr_value,
	map_112_TEM21__FIELD_2__next_value,
	map_112_TEM21__FIELD_2__pulse,
	map_112_TEM21__FIELD_2__curr_value,
	map_112_TEM21__FIELD_1__next_value,
	map_112_TEM21__FIELD_1__pulse,
	map_112_TEM21__FIELD_1__curr_value,
	map_112_TEM22__FIELD_3__next_value,
	map_112_TEM22__FIELD_3__pulse,
	map_112_TEM22__FIELD_3__curr_value,
	map_112_TEM22__FIELD_2__next_value,
	map_112_TEM22__FIELD_2__pulse,
	map_112_TEM22__FIELD_2__curr_value,
	map_112_TEM22__FIELD_1__next_value,
	map_112_TEM22__FIELD_1__pulse,
	map_112_TEM22__FIELD_1__curr_value,
	map_113_TEM21__FIELD_3__next_value,
	map_113_TEM21__FIELD_3__pulse,
	map_113_TEM21__FIELD_3__curr_value,
	map_113_TEM21__FIELD_2__next_value,
	map_113_TEM21__FIELD_2__pulse,
	map_113_TEM21__FIELD_2__curr_value,
	map_113_TEM21__FIELD_1__next_value,
	map_113_TEM21__FIELD_1__pulse,
	map_113_TEM21__FIELD_1__curr_value,
	map_113_TEM22__FIELD_3__next_value,
	map_113_TEM22__FIELD_3__pulse,
	map_113_TEM22__FIELD_3__curr_value,
	map_113_TEM22__FIELD_2__next_value,
	map_113_TEM22__FIELD_2__pulse,
	map_113_TEM22__FIELD_2__curr_value,
	map_113_TEM22__FIELD_1__next_value,
	map_113_TEM22__FIELD_1__pulse,
	map_113_TEM22__FIELD_1__curr_value,
	map_114_TEM21__FIELD_3__next_value,
	map_114_TEM21__FIELD_3__pulse,
	map_114_TEM21__FIELD_3__curr_value,
	map_114_TEM21__FIELD_2__next_value,
	map_114_TEM21__FIELD_2__pulse,
	map_114_TEM21__FIELD_2__curr_value,
	map_114_TEM21__FIELD_1__next_value,
	map_114_TEM21__FIELD_1__pulse,
	map_114_TEM21__FIELD_1__curr_value,
	map_114_TEM22__FIELD_3__next_value,
	map_114_TEM22__FIELD_3__pulse,
	map_114_TEM22__FIELD_3__curr_value,
	map_114_TEM22__FIELD_2__next_value,
	map_114_TEM22__FIELD_2__pulse,
	map_114_TEM22__FIELD_2__curr_value,
	map_114_TEM22__FIELD_1__next_value,
	map_114_TEM22__FIELD_1__pulse,
	map_114_TEM22__FIELD_1__curr_value,
	map_120_TEM21__FIELD_3__next_value,
	map_120_TEM21__FIELD_3__pulse,
	map_120_TEM21__FIELD_3__curr_value,
	map_120_TEM21__FIELD_2__next_value,
	map_120_TEM21__FIELD_2__pulse,
	map_120_TEM21__FIELD_2__curr_value,
	map_120_TEM21__FIELD_1__next_value,
	map_120_TEM21__FIELD_1__pulse,
	map_120_TEM21__FIELD_1__curr_value,
	map_120_TEM22__FIELD_3__next_value,
	map_120_TEM22__FIELD_3__pulse,
	map_120_TEM22__FIELD_3__curr_value,
	map_120_TEM22__FIELD_2__next_value,
	map_120_TEM22__FIELD_2__pulse,
	map_120_TEM22__FIELD_2__curr_value,
	map_120_TEM22__FIELD_1__next_value,
	map_120_TEM22__FIELD_1__pulse,
	map_120_TEM22__FIELD_1__curr_value,
	map_121_TEM21__FIELD_3__next_value,
	map_121_TEM21__FIELD_3__pulse,
	map_121_TEM21__FIELD_3__curr_value,
	map_121_TEM21__FIELD_2__next_value,
	map_121_TEM21__FIELD_2__pulse,
	map_121_TEM21__FIELD_2__curr_value,
	map_121_TEM21__FIELD_1__next_value,
	map_121_TEM21__FIELD_1__pulse,
	map_121_TEM21__FIELD_1__curr_value,
	map_121_TEM22__FIELD_3__next_value,
	map_121_TEM22__FIELD_3__pulse,
	map_121_TEM22__FIELD_3__curr_value,
	map_121_TEM22__FIELD_2__next_value,
	map_121_TEM22__FIELD_2__pulse,
	map_121_TEM22__FIELD_2__curr_value,
	map_121_TEM22__FIELD_1__next_value,
	map_121_TEM22__FIELD_1__pulse,
	map_121_TEM22__FIELD_1__curr_value,
	map_122_TEM21__FIELD_3__next_value,
	map_122_TEM21__FIELD_3__pulse,
	map_122_TEM21__FIELD_3__curr_value,
	map_122_TEM21__FIELD_2__next_value,
	map_122_TEM21__FIELD_2__pulse,
	map_122_TEM21__FIELD_2__curr_value,
	map_122_TEM21__FIELD_1__next_value,
	map_122_TEM21__FIELD_1__pulse,
	map_122_TEM21__FIELD_1__curr_value,
	map_122_TEM22__FIELD_3__next_value,
	map_122_TEM22__FIELD_3__pulse,
	map_122_TEM22__FIELD_3__curr_value,
	map_122_TEM22__FIELD_2__next_value,
	map_122_TEM22__FIELD_2__pulse,
	map_122_TEM22__FIELD_2__curr_value,
	map_122_TEM22__FIELD_1__next_value,
	map_122_TEM22__FIELD_1__pulse,
	map_122_TEM22__FIELD_1__curr_value,
	map_123_TEM21__FIELD_3__next_value,
	map_123_TEM21__FIELD_3__pulse,
	map_123_TEM21__FIELD_3__curr_value,
	map_123_TEM21__FIELD_2__next_value,
	map_123_TEM21__FIELD_2__pulse,
	map_123_TEM21__FIELD_2__curr_value,
	map_123_TEM21__FIELD_1__next_value,
	map_123_TEM21__FIELD_1__pulse,
	map_123_TEM21__FIELD_1__curr_value,
	map_123_TEM22__FIELD_3__next_value,
	map_123_TEM22__FIELD_3__pulse,
	map_123_TEM22__FIELD_3__curr_value,
	map_123_TEM22__FIELD_2__next_value,
	map_123_TEM22__FIELD_2__pulse,
	map_123_TEM22__FIELD_2__curr_value,
	map_123_TEM22__FIELD_1__next_value,
	map_123_TEM22__FIELD_1__pulse,
	map_123_TEM22__FIELD_1__curr_value,
	map_124_TEM21__FIELD_3__next_value,
	map_124_TEM21__FIELD_3__pulse,
	map_124_TEM21__FIELD_3__curr_value,
	map_124_TEM21__FIELD_2__next_value,
	map_124_TEM21__FIELD_2__pulse,
	map_124_TEM21__FIELD_2__curr_value,
	map_124_TEM21__FIELD_1__next_value,
	map_124_TEM21__FIELD_1__pulse,
	map_124_TEM21__FIELD_1__curr_value,
	map_124_TEM22__FIELD_3__next_value,
	map_124_TEM22__FIELD_3__pulse,
	map_124_TEM22__FIELD_3__curr_value,
	map_124_TEM22__FIELD_2__next_value,
	map_124_TEM22__FIELD_2__pulse,
	map_124_TEM22__FIELD_2__curr_value,
	map_124_TEM22__FIELD_1__next_value,
	map_124_TEM22__FIELD_1__pulse,
	map_124_TEM22__FIELD_1__curr_value,
	map_125_TEM21__FIELD_3__next_value,
	map_125_TEM21__FIELD_3__pulse,
	map_125_TEM21__FIELD_3__curr_value,
	map_125_TEM21__FIELD_2__next_value,
	map_125_TEM21__FIELD_2__pulse,
	map_125_TEM21__FIELD_2__curr_value,
	map_125_TEM21__FIELD_1__next_value,
	map_125_TEM21__FIELD_1__pulse,
	map_125_TEM21__FIELD_1__curr_value,
	map_125_TEM22__FIELD_3__next_value,
	map_125_TEM22__FIELD_3__pulse,
	map_125_TEM22__FIELD_3__curr_value,
	map_125_TEM22__FIELD_2__next_value,
	map_125_TEM22__FIELD_2__pulse,
	map_125_TEM22__FIELD_2__curr_value,
	map_125_TEM22__FIELD_1__next_value,
	map_125_TEM22__FIELD_1__pulse,
	map_125_TEM22__FIELD_1__curr_value,
	map_126_TEM21__FIELD_3__next_value,
	map_126_TEM21__FIELD_3__pulse,
	map_126_TEM21__FIELD_3__curr_value,
	map_126_TEM21__FIELD_2__next_value,
	map_126_TEM21__FIELD_2__pulse,
	map_126_TEM21__FIELD_2__curr_value,
	map_126_TEM21__FIELD_1__next_value,
	map_126_TEM21__FIELD_1__pulse,
	map_126_TEM21__FIELD_1__curr_value,
	map_126_TEM22__FIELD_3__next_value,
	map_126_TEM22__FIELD_3__pulse,
	map_126_TEM22__FIELD_3__curr_value,
	map_126_TEM22__FIELD_2__next_value,
	map_126_TEM22__FIELD_2__pulse,
	map_126_TEM22__FIELD_2__curr_value,
	map_126_TEM22__FIELD_1__next_value,
	map_126_TEM22__FIELD_1__pulse,
	map_126_TEM22__FIELD_1__curr_value,
	map_127_TEM21__FIELD_3__next_value,
	map_127_TEM21__FIELD_3__pulse,
	map_127_TEM21__FIELD_3__curr_value,
	map_127_TEM21__FIELD_2__next_value,
	map_127_TEM21__FIELD_2__pulse,
	map_127_TEM21__FIELD_2__curr_value,
	map_127_TEM21__FIELD_1__next_value,
	map_127_TEM21__FIELD_1__pulse,
	map_127_TEM21__FIELD_1__curr_value,
	map_127_TEM22__FIELD_3__next_value,
	map_127_TEM22__FIELD_3__pulse,
	map_127_TEM22__FIELD_3__curr_value,
	map_127_TEM22__FIELD_2__next_value,
	map_127_TEM22__FIELD_2__pulse,
	map_127_TEM22__FIELD_2__curr_value,
	map_127_TEM22__FIELD_1__next_value,
	map_127_TEM22__FIELD_1__pulse,
	map_127_TEM22__FIELD_1__curr_value,
	map_128_TEM21__FIELD_3__next_value,
	map_128_TEM21__FIELD_3__pulse,
	map_128_TEM21__FIELD_3__curr_value,
	map_128_TEM21__FIELD_2__next_value,
	map_128_TEM21__FIELD_2__pulse,
	map_128_TEM21__FIELD_2__curr_value,
	map_128_TEM21__FIELD_1__next_value,
	map_128_TEM21__FIELD_1__pulse,
	map_128_TEM21__FIELD_1__curr_value,
	map_128_TEM22__FIELD_3__next_value,
	map_128_TEM22__FIELD_3__pulse,
	map_128_TEM22__FIELD_3__curr_value,
	map_128_TEM22__FIELD_2__next_value,
	map_128_TEM22__FIELD_2__pulse,
	map_128_TEM22__FIELD_2__curr_value,
	map_128_TEM22__FIELD_1__next_value,
	map_128_TEM22__FIELD_1__pulse,
	map_128_TEM22__FIELD_1__curr_value,
	map_129_TEM21__FIELD_3__next_value,
	map_129_TEM21__FIELD_3__pulse,
	map_129_TEM21__FIELD_3__curr_value,
	map_129_TEM21__FIELD_2__next_value,
	map_129_TEM21__FIELD_2__pulse,
	map_129_TEM21__FIELD_2__curr_value,
	map_129_TEM21__FIELD_1__next_value,
	map_129_TEM21__FIELD_1__pulse,
	map_129_TEM21__FIELD_1__curr_value,
	map_129_TEM22__FIELD_3__next_value,
	map_129_TEM22__FIELD_3__pulse,
	map_129_TEM22__FIELD_3__curr_value,
	map_129_TEM22__FIELD_2__next_value,
	map_129_TEM22__FIELD_2__pulse,
	map_129_TEM22__FIELD_2__curr_value,
	map_129_TEM22__FIELD_1__next_value,
	map_129_TEM22__FIELD_1__pulse,
	map_129_TEM22__FIELD_1__curr_value,
//**************************************INTERNAL FIELD PORT END***************************************//


//****************************************STANDARD PORT START*****************************************//
	clk,
	rst_n,
	req_vld,
	ack_vld,
	err,
	wr_en,
	rd_en,
	addr,
	wr_data,
	rd_data,
	soft_rst
//*****************************************STANDARD PORT END******************************************//
);


//*************************************PARAMETER DEFINITION START*************************************//
	parameter                  ADDR_WIDTH = 64          ;
	parameter                  DATA_WIDTH = 32          ;
	//N:number of internal registers, M:number of external modules
	localparam                 N = 60                    ;
	localparam                 REG_NUM = N ? N : 1      ;
//**************************************PARAMETER DEFINITION END**************************************//


//***************************************PORT DECLARATION START***************************************//
	// dispatch domain @clk
	input                         clk;
	input                         rst_n;
	input                         req_vld;
	output                        ack_vld;
	output                        err;
	input                         wr_en;
	input                         rd_en;
	input     [ADDR_WIDTH-1:0]    addr;
	input     [DATA_WIDTH-1:0]    wr_data;
	output    [DATA_WIDTH-1:0]    rd_data;
	input                         soft_rst;
	wire regslv_clk      = clk;
	wire regslv_rst_n    = rst_n;

	input  [1-1:0]    map_110_TEM21__FIELD_3__next_value;
	input             map_110_TEM21__FIELD_3__pulse;
	output [1-1:0]    map_110_TEM21__FIELD_3__curr_value;
	input  [3-1:0]    map_110_TEM21__FIELD_2__next_value;
	input             map_110_TEM21__FIELD_2__pulse;
	output [3-1:0]    map_110_TEM21__FIELD_2__curr_value;
	input  [1-1:0]    map_110_TEM21__FIELD_1__next_value;
	input             map_110_TEM21__FIELD_1__pulse;
	output [1-1:0]    map_110_TEM21__FIELD_1__curr_value;
	input  [1-1:0]    map_110_TEM22__FIELD_3__next_value;
	input             map_110_TEM22__FIELD_3__pulse;
	output [1-1:0]    map_110_TEM22__FIELD_3__curr_value;
	input  [3-1:0]    map_110_TEM22__FIELD_2__next_value;
	input             map_110_TEM22__FIELD_2__pulse;
	output [3-1:0]    map_110_TEM22__FIELD_2__curr_value;
	input  [1-1:0]    map_110_TEM22__FIELD_1__next_value;
	input             map_110_TEM22__FIELD_1__pulse;
	output [1-1:0]    map_110_TEM22__FIELD_1__curr_value;
	input  [1-1:0]    map_111_TEM21__FIELD_3__next_value;
	input             map_111_TEM21__FIELD_3__pulse;
	output [1-1:0]    map_111_TEM21__FIELD_3__curr_value;
	input  [3-1:0]    map_111_TEM21__FIELD_2__next_value;
	input             map_111_TEM21__FIELD_2__pulse;
	output [3-1:0]    map_111_TEM21__FIELD_2__curr_value;
	input  [1-1:0]    map_111_TEM21__FIELD_1__next_value;
	input             map_111_TEM21__FIELD_1__pulse;
	output [1-1:0]    map_111_TEM21__FIELD_1__curr_value;
	input  [1-1:0]    map_111_TEM22__FIELD_3__next_value;
	input             map_111_TEM22__FIELD_3__pulse;
	output [1-1:0]    map_111_TEM22__FIELD_3__curr_value;
	input  [3-1:0]    map_111_TEM22__FIELD_2__next_value;
	input             map_111_TEM22__FIELD_2__pulse;
	output [3-1:0]    map_111_TEM22__FIELD_2__curr_value;
	input  [1-1:0]    map_111_TEM22__FIELD_1__next_value;
	input             map_111_TEM22__FIELD_1__pulse;
	output [1-1:0]    map_111_TEM22__FIELD_1__curr_value;
	input  [1-1:0]    map_112_TEM21__FIELD_3__next_value;
	input             map_112_TEM21__FIELD_3__pulse;
	output [1-1:0]    map_112_TEM21__FIELD_3__curr_value;
	input  [3-1:0]    map_112_TEM21__FIELD_2__next_value;
	input             map_112_TEM21__FIELD_2__pulse;
	output [3-1:0]    map_112_TEM21__FIELD_2__curr_value;
	input  [1-1:0]    map_112_TEM21__FIELD_1__next_value;
	input             map_112_TEM21__FIELD_1__pulse;
	output [1-1:0]    map_112_TEM21__FIELD_1__curr_value;
	input  [1-1:0]    map_112_TEM22__FIELD_3__next_value;
	input             map_112_TEM22__FIELD_3__pulse;
	output [1-1:0]    map_112_TEM22__FIELD_3__curr_value;
	input  [3-1:0]    map_112_TEM22__FIELD_2__next_value;
	input             map_112_TEM22__FIELD_2__pulse;
	output [3-1:0]    map_112_TEM22__FIELD_2__curr_value;
	input  [1-1:0]    map_112_TEM22__FIELD_1__next_value;
	input             map_112_TEM22__FIELD_1__pulse;
	output [1-1:0]    map_112_TEM22__FIELD_1__curr_value;
	input  [1-1:0]    map_113_TEM21__FIELD_3__next_value;
	input             map_113_TEM21__FIELD_3__pulse;
	output [1-1:0]    map_113_TEM21__FIELD_3__curr_value;
	input  [3-1:0]    map_113_TEM21__FIELD_2__next_value;
	input             map_113_TEM21__FIELD_2__pulse;
	output [3-1:0]    map_113_TEM21__FIELD_2__curr_value;
	input  [1-1:0]    map_113_TEM21__FIELD_1__next_value;
	input             map_113_TEM21__FIELD_1__pulse;
	output [1-1:0]    map_113_TEM21__FIELD_1__curr_value;
	input  [1-1:0]    map_113_TEM22__FIELD_3__next_value;
	input             map_113_TEM22__FIELD_3__pulse;
	output [1-1:0]    map_113_TEM22__FIELD_3__curr_value;
	input  [3-1:0]    map_113_TEM22__FIELD_2__next_value;
	input             map_113_TEM22__FIELD_2__pulse;
	output [3-1:0]    map_113_TEM22__FIELD_2__curr_value;
	input  [1-1:0]    map_113_TEM22__FIELD_1__next_value;
	input             map_113_TEM22__FIELD_1__pulse;
	output [1-1:0]    map_113_TEM22__FIELD_1__curr_value;
	input  [1-1:0]    map_114_TEM21__FIELD_3__next_value;
	input             map_114_TEM21__FIELD_3__pulse;
	output [1-1:0]    map_114_TEM21__FIELD_3__curr_value;
	input  [3-1:0]    map_114_TEM21__FIELD_2__next_value;
	input             map_114_TEM21__FIELD_2__pulse;
	output [3-1:0]    map_114_TEM21__FIELD_2__curr_value;
	input  [1-1:0]    map_114_TEM21__FIELD_1__next_value;
	input             map_114_TEM21__FIELD_1__pulse;
	output [1-1:0]    map_114_TEM21__FIELD_1__curr_value;
	input  [1-1:0]    map_114_TEM22__FIELD_3__next_value;
	input             map_114_TEM22__FIELD_3__pulse;
	output [1-1:0]    map_114_TEM22__FIELD_3__curr_value;
	input  [3-1:0]    map_114_TEM22__FIELD_2__next_value;
	input             map_114_TEM22__FIELD_2__pulse;
	output [3-1:0]    map_114_TEM22__FIELD_2__curr_value;
	input  [1-1:0]    map_114_TEM22__FIELD_1__next_value;
	input             map_114_TEM22__FIELD_1__pulse;
	output [1-1:0]    map_114_TEM22__FIELD_1__curr_value;
	input  [1-1:0]    map_120_TEM21__FIELD_3__next_value;
	input             map_120_TEM21__FIELD_3__pulse;
	output [1-1:0]    map_120_TEM21__FIELD_3__curr_value;
	input  [3-1:0]    map_120_TEM21__FIELD_2__next_value;
	input             map_120_TEM21__FIELD_2__pulse;
	output [3-1:0]    map_120_TEM21__FIELD_2__curr_value;
	input  [1-1:0]    map_120_TEM21__FIELD_1__next_value;
	input             map_120_TEM21__FIELD_1__pulse;
	output [1-1:0]    map_120_TEM21__FIELD_1__curr_value;
	input  [1-1:0]    map_120_TEM22__FIELD_3__next_value;
	input             map_120_TEM22__FIELD_3__pulse;
	output [1-1:0]    map_120_TEM22__FIELD_3__curr_value;
	input  [3-1:0]    map_120_TEM22__FIELD_2__next_value;
	input             map_120_TEM22__FIELD_2__pulse;
	output [3-1:0]    map_120_TEM22__FIELD_2__curr_value;
	input  [1-1:0]    map_120_TEM22__FIELD_1__next_value;
	input             map_120_TEM22__FIELD_1__pulse;
	output [1-1:0]    map_120_TEM22__FIELD_1__curr_value;
	input  [1-1:0]    map_121_TEM21__FIELD_3__next_value;
	input             map_121_TEM21__FIELD_3__pulse;
	output [1-1:0]    map_121_TEM21__FIELD_3__curr_value;
	input  [3-1:0]    map_121_TEM21__FIELD_2__next_value;
	input             map_121_TEM21__FIELD_2__pulse;
	output [3-1:0]    map_121_TEM21__FIELD_2__curr_value;
	input  [1-1:0]    map_121_TEM21__FIELD_1__next_value;
	input             map_121_TEM21__FIELD_1__pulse;
	output [1-1:0]    map_121_TEM21__FIELD_1__curr_value;
	input  [1-1:0]    map_121_TEM22__FIELD_3__next_value;
	input             map_121_TEM22__FIELD_3__pulse;
	output [1-1:0]    map_121_TEM22__FIELD_3__curr_value;
	input  [3-1:0]    map_121_TEM22__FIELD_2__next_value;
	input             map_121_TEM22__FIELD_2__pulse;
	output [3-1:0]    map_121_TEM22__FIELD_2__curr_value;
	input  [1-1:0]    map_121_TEM22__FIELD_1__next_value;
	input             map_121_TEM22__FIELD_1__pulse;
	output [1-1:0]    map_121_TEM22__FIELD_1__curr_value;
	input  [1-1:0]    map_122_TEM21__FIELD_3__next_value;
	input             map_122_TEM21__FIELD_3__pulse;
	output [1-1:0]    map_122_TEM21__FIELD_3__curr_value;
	input  [3-1:0]    map_122_TEM21__FIELD_2__next_value;
	input             map_122_TEM21__FIELD_2__pulse;
	output [3-1:0]    map_122_TEM21__FIELD_2__curr_value;
	input  [1-1:0]    map_122_TEM21__FIELD_1__next_value;
	input             map_122_TEM21__FIELD_1__pulse;
	output [1-1:0]    map_122_TEM21__FIELD_1__curr_value;
	input  [1-1:0]    map_122_TEM22__FIELD_3__next_value;
	input             map_122_TEM22__FIELD_3__pulse;
	output [1-1:0]    map_122_TEM22__FIELD_3__curr_value;
	input  [3-1:0]    map_122_TEM22__FIELD_2__next_value;
	input             map_122_TEM22__FIELD_2__pulse;
	output [3-1:0]    map_122_TEM22__FIELD_2__curr_value;
	input  [1-1:0]    map_122_TEM22__FIELD_1__next_value;
	input             map_122_TEM22__FIELD_1__pulse;
	output [1-1:0]    map_122_TEM22__FIELD_1__curr_value;
	input  [1-1:0]    map_123_TEM21__FIELD_3__next_value;
	input             map_123_TEM21__FIELD_3__pulse;
	output [1-1:0]    map_123_TEM21__FIELD_3__curr_value;
	input  [3-1:0]    map_123_TEM21__FIELD_2__next_value;
	input             map_123_TEM21__FIELD_2__pulse;
	output [3-1:0]    map_123_TEM21__FIELD_2__curr_value;
	input  [1-1:0]    map_123_TEM21__FIELD_1__next_value;
	input             map_123_TEM21__FIELD_1__pulse;
	output [1-1:0]    map_123_TEM21__FIELD_1__curr_value;
	input  [1-1:0]    map_123_TEM22__FIELD_3__next_value;
	input             map_123_TEM22__FIELD_3__pulse;
	output [1-1:0]    map_123_TEM22__FIELD_3__curr_value;
	input  [3-1:0]    map_123_TEM22__FIELD_2__next_value;
	input             map_123_TEM22__FIELD_2__pulse;
	output [3-1:0]    map_123_TEM22__FIELD_2__curr_value;
	input  [1-1:0]    map_123_TEM22__FIELD_1__next_value;
	input             map_123_TEM22__FIELD_1__pulse;
	output [1-1:0]    map_123_TEM22__FIELD_1__curr_value;
	input  [1-1:0]    map_124_TEM21__FIELD_3__next_value;
	input             map_124_TEM21__FIELD_3__pulse;
	output [1-1:0]    map_124_TEM21__FIELD_3__curr_value;
	input  [3-1:0]    map_124_TEM21__FIELD_2__next_value;
	input             map_124_TEM21__FIELD_2__pulse;
	output [3-1:0]    map_124_TEM21__FIELD_2__curr_value;
	input  [1-1:0]    map_124_TEM21__FIELD_1__next_value;
	input             map_124_TEM21__FIELD_1__pulse;
	output [1-1:0]    map_124_TEM21__FIELD_1__curr_value;
	input  [1-1:0]    map_124_TEM22__FIELD_3__next_value;
	input             map_124_TEM22__FIELD_3__pulse;
	output [1-1:0]    map_124_TEM22__FIELD_3__curr_value;
	input  [3-1:0]    map_124_TEM22__FIELD_2__next_value;
	input             map_124_TEM22__FIELD_2__pulse;
	output [3-1:0]    map_124_TEM22__FIELD_2__curr_value;
	input  [1-1:0]    map_124_TEM22__FIELD_1__next_value;
	input             map_124_TEM22__FIELD_1__pulse;
	output [1-1:0]    map_124_TEM22__FIELD_1__curr_value;
	input  [1-1:0]    map_125_TEM21__FIELD_3__next_value;
	input             map_125_TEM21__FIELD_3__pulse;
	output [1-1:0]    map_125_TEM21__FIELD_3__curr_value;
	input  [3-1:0]    map_125_TEM21__FIELD_2__next_value;
	input             map_125_TEM21__FIELD_2__pulse;
	output [3-1:0]    map_125_TEM21__FIELD_2__curr_value;
	input  [1-1:0]    map_125_TEM21__FIELD_1__next_value;
	input             map_125_TEM21__FIELD_1__pulse;
	output [1-1:0]    map_125_TEM21__FIELD_1__curr_value;
	input  [1-1:0]    map_125_TEM22__FIELD_3__next_value;
	input             map_125_TEM22__FIELD_3__pulse;
	output [1-1:0]    map_125_TEM22__FIELD_3__curr_value;
	input  [3-1:0]    map_125_TEM22__FIELD_2__next_value;
	input             map_125_TEM22__FIELD_2__pulse;
	output [3-1:0]    map_125_TEM22__FIELD_2__curr_value;
	input  [1-1:0]    map_125_TEM22__FIELD_1__next_value;
	input             map_125_TEM22__FIELD_1__pulse;
	output [1-1:0]    map_125_TEM22__FIELD_1__curr_value;
	input  [1-1:0]    map_126_TEM21__FIELD_3__next_value;
	input             map_126_TEM21__FIELD_3__pulse;
	output [1-1:0]    map_126_TEM21__FIELD_3__curr_value;
	input  [3-1:0]    map_126_TEM21__FIELD_2__next_value;
	input             map_126_TEM21__FIELD_2__pulse;
	output [3-1:0]    map_126_TEM21__FIELD_2__curr_value;
	input  [1-1:0]    map_126_TEM21__FIELD_1__next_value;
	input             map_126_TEM21__FIELD_1__pulse;
	output [1-1:0]    map_126_TEM21__FIELD_1__curr_value;
	input  [1-1:0]    map_126_TEM22__FIELD_3__next_value;
	input             map_126_TEM22__FIELD_3__pulse;
	output [1-1:0]    map_126_TEM22__FIELD_3__curr_value;
	input  [3-1:0]    map_126_TEM22__FIELD_2__next_value;
	input             map_126_TEM22__FIELD_2__pulse;
	output [3-1:0]    map_126_TEM22__FIELD_2__curr_value;
	input  [1-1:0]    map_126_TEM22__FIELD_1__next_value;
	input             map_126_TEM22__FIELD_1__pulse;
	output [1-1:0]    map_126_TEM22__FIELD_1__curr_value;
	input  [1-1:0]    map_127_TEM21__FIELD_3__next_value;
	input             map_127_TEM21__FIELD_3__pulse;
	output [1-1:0]    map_127_TEM21__FIELD_3__curr_value;
	input  [3-1:0]    map_127_TEM21__FIELD_2__next_value;
	input             map_127_TEM21__FIELD_2__pulse;
	output [3-1:0]    map_127_TEM21__FIELD_2__curr_value;
	input  [1-1:0]    map_127_TEM21__FIELD_1__next_value;
	input             map_127_TEM21__FIELD_1__pulse;
	output [1-1:0]    map_127_TEM21__FIELD_1__curr_value;
	input  [1-1:0]    map_127_TEM22__FIELD_3__next_value;
	input             map_127_TEM22__FIELD_3__pulse;
	output [1-1:0]    map_127_TEM22__FIELD_3__curr_value;
	input  [3-1:0]    map_127_TEM22__FIELD_2__next_value;
	input             map_127_TEM22__FIELD_2__pulse;
	output [3-1:0]    map_127_TEM22__FIELD_2__curr_value;
	input  [1-1:0]    map_127_TEM22__FIELD_1__next_value;
	input             map_127_TEM22__FIELD_1__pulse;
	output [1-1:0]    map_127_TEM22__FIELD_1__curr_value;
	input  [1-1:0]    map_128_TEM21__FIELD_3__next_value;
	input             map_128_TEM21__FIELD_3__pulse;
	output [1-1:0]    map_128_TEM21__FIELD_3__curr_value;
	input  [3-1:0]    map_128_TEM21__FIELD_2__next_value;
	input             map_128_TEM21__FIELD_2__pulse;
	output [3-1:0]    map_128_TEM21__FIELD_2__curr_value;
	input  [1-1:0]    map_128_TEM21__FIELD_1__next_value;
	input             map_128_TEM21__FIELD_1__pulse;
	output [1-1:0]    map_128_TEM21__FIELD_1__curr_value;
	input  [1-1:0]    map_128_TEM22__FIELD_3__next_value;
	input             map_128_TEM22__FIELD_3__pulse;
	output [1-1:0]    map_128_TEM22__FIELD_3__curr_value;
	input  [3-1:0]    map_128_TEM22__FIELD_2__next_value;
	input             map_128_TEM22__FIELD_2__pulse;
	output [3-1:0]    map_128_TEM22__FIELD_2__curr_value;
	input  [1-1:0]    map_128_TEM22__FIELD_1__next_value;
	input             map_128_TEM22__FIELD_1__pulse;
	output [1-1:0]    map_128_TEM22__FIELD_1__curr_value;
	input  [1-1:0]    map_129_TEM21__FIELD_3__next_value;
	input             map_129_TEM21__FIELD_3__pulse;
	output [1-1:0]    map_129_TEM21__FIELD_3__curr_value;
	input  [3-1:0]    map_129_TEM21__FIELD_2__next_value;
	input             map_129_TEM21__FIELD_2__pulse;
	output [3-1:0]    map_129_TEM21__FIELD_2__curr_value;
	input  [1-1:0]    map_129_TEM21__FIELD_1__next_value;
	input             map_129_TEM21__FIELD_1__pulse;
	output [1-1:0]    map_129_TEM21__FIELD_1__curr_value;
	input  [1-1:0]    map_129_TEM22__FIELD_3__next_value;
	input             map_129_TEM22__FIELD_3__pulse;
	output [1-1:0]    map_129_TEM22__FIELD_3__curr_value;
	input  [3-1:0]    map_129_TEM22__FIELD_2__next_value;
	input             map_129_TEM22__FIELD_2__pulse;
	output [3-1:0]    map_129_TEM22__FIELD_2__curr_value;
	input  [1-1:0]    map_129_TEM22__FIELD_1__next_value;
	input             map_129_TEM22__FIELD_1__pulse;
	output [1-1:0]    map_129_TEM22__FIELD_1__curr_value;
//****************************************PORT DECLARATION END****************************************//


//***************************************WIRE DECLARATION START***************************************//
	// declare the handshake signal for fsm
	wire                   slv__fsm__ack_vld;
	reg                    fsm__slv__req_vld;
	// signal for fsm
	wire 						fsm__slv__wr_en;
	wire 						fsm__slv__rd_en;
	wire [ADDR_WIDTH-1:0] 		fsm__slv__addr;
	wire [DATA_WIDTH-1:0] 		fsm__slv__wr_data;
	wire [DATA_WIDTH-1:0]  		slv__fsm__rd_data;
	// signal for internal decoder @regfile domain
	logic [REG_NUM-1:0] 	reg_sel;
	logic                dummy_reg;

	// signal for regfile split mux
	logic [REG_NUM-1:0] [DATA_WIDTH-1:0] regfile_reg_rd_data_in;
	wire                                   req_vld_fsm;
	wire                                   ack_vld_fsm;
	wire                                   wr_en_fsm;
	wire                                   rd_en_fsm;
	wire [ADDR_WIDTH-1:0]                  addr_fsm;
	wire [DATA_WIDTH-1:0]                  wr_data_fsm;
	wire [DATA_WIDTH-1:0]                  rd_data_fsm;
	wire                                   soft_rst_fsm;

	// regfile signal in regfile domain
	wire [REG_NUM-1:0] wr_sel;
	wire [REG_NUM-1:0] rd_sel;
	wire                                   regfile_req_vld      ;
	wire                                   regfile_ack_vld      ;
	wire                                   regfile_rd_ack_vld   ;
	wire                                   regfile_wr_en        ;
	wire                                   regfile_rd_en        ;
	wire [ADDR_WIDTH-1:0]                  regfile_addr         ;
	wire [DATA_WIDTH-1:0]                  regfile_wr_data      ;
	wire [DATA_WIDTH-1:0]                  regfile_rd_data      ;

	assign regfile_req_vld       = fsm__slv__req_vld     ;
	assign slv__fsm__ack_vld     = regfile_ack_vld       ;
	assign regfile_wr_en         = fsm__slv__wr_en       ;
	assign regfile_rd_en         = fsm__slv__rd_en       ;
	assign regfile_addr          = fsm__slv__addr        ;
	assign regfile_wr_data       = fsm__slv__wr_data     ;
	assign slv__fsm__rd_data     = regfile_rd_data       ;

	assign wr_sel = {REG_NUM{regfile_wr_en}} & reg_sel   ;
	assign rd_sel = {REG_NUM{regfile_rd_en}} & reg_sel   ;
	assign regfile_ack_vld = regfile_rd_ack_vld | regfile_wr_en;

	logic [31:0] map_110_TEM21_wr_data;
	logic map_110_TEM21_wr_en;
	logic map_110_TEM21_rd_en;

	logic [31:0] map_110_TEM22_wr_data;
	logic map_110_TEM22_wr_en;
	logic map_110_TEM22_rd_en;

	logic [31:0] map_110_TEM21_alias_wr_data;
	logic map_110_TEM21_alias_wr_en;
	logic map_110_TEM21_alias_rd_en;

	logic [31:0] map_110_TEM22_alias_wr_data;
	logic map_110_TEM22_alias_wr_en;
	logic map_110_TEM22_alias_rd_en;

	logic [31:0] map_111_TEM21_wr_data;
	logic map_111_TEM21_wr_en;
	logic map_111_TEM21_rd_en;

	logic [31:0] map_111_TEM22_wr_data;
	logic map_111_TEM22_wr_en;
	logic map_111_TEM22_rd_en;

	logic [31:0] map_111_TEM21_alias_wr_data;
	logic map_111_TEM21_alias_wr_en;
	logic map_111_TEM21_alias_rd_en;

	logic [31:0] map_111_TEM22_alias_wr_data;
	logic map_111_TEM22_alias_wr_en;
	logic map_111_TEM22_alias_rd_en;

	logic [31:0] map_112_TEM21_wr_data;
	logic map_112_TEM21_wr_en;
	logic map_112_TEM21_rd_en;

	logic [31:0] map_112_TEM22_wr_data;
	logic map_112_TEM22_wr_en;
	logic map_112_TEM22_rd_en;

	logic [31:0] map_112_TEM21_alias_wr_data;
	logic map_112_TEM21_alias_wr_en;
	logic map_112_TEM21_alias_rd_en;

	logic [31:0] map_112_TEM22_alias_wr_data;
	logic map_112_TEM22_alias_wr_en;
	logic map_112_TEM22_alias_rd_en;

	logic [31:0] map_113_TEM21_wr_data;
	logic map_113_TEM21_wr_en;
	logic map_113_TEM21_rd_en;

	logic [31:0] map_113_TEM22_wr_data;
	logic map_113_TEM22_wr_en;
	logic map_113_TEM22_rd_en;

	logic [31:0] map_113_TEM21_alias_wr_data;
	logic map_113_TEM21_alias_wr_en;
	logic map_113_TEM21_alias_rd_en;

	logic [31:0] map_113_TEM22_alias_wr_data;
	logic map_113_TEM22_alias_wr_en;
	logic map_113_TEM22_alias_rd_en;

	logic [31:0] map_114_TEM21_wr_data;
	logic map_114_TEM21_wr_en;
	logic map_114_TEM21_rd_en;

	logic [31:0] map_114_TEM22_wr_data;
	logic map_114_TEM22_wr_en;
	logic map_114_TEM22_rd_en;

	logic [31:0] map_114_TEM21_alias_wr_data;
	logic map_114_TEM21_alias_wr_en;
	logic map_114_TEM21_alias_rd_en;

	logic [31:0] map_114_TEM22_alias_wr_data;
	logic map_114_TEM22_alias_wr_en;
	logic map_114_TEM22_alias_rd_en;

	logic [31:0] map_120_TEM21_wr_data;
	logic map_120_TEM21_wr_en;
	logic map_120_TEM21_rd_en;

	logic [31:0] map_120_TEM22_wr_data;
	logic map_120_TEM22_wr_en;
	logic map_120_TEM22_rd_en;

	logic [31:0] map_120_TEM21_alias_wr_data;
	logic map_120_TEM21_alias_wr_en;
	logic map_120_TEM21_alias_rd_en;

	logic [31:0] map_120_TEM22_alias_wr_data;
	logic map_120_TEM22_alias_wr_en;
	logic map_120_TEM22_alias_rd_en;

	logic [31:0] map_121_TEM21_wr_data;
	logic map_121_TEM21_wr_en;
	logic map_121_TEM21_rd_en;

	logic [31:0] map_121_TEM22_wr_data;
	logic map_121_TEM22_wr_en;
	logic map_121_TEM22_rd_en;

	logic [31:0] map_121_TEM21_alias_wr_data;
	logic map_121_TEM21_alias_wr_en;
	logic map_121_TEM21_alias_rd_en;

	logic [31:0] map_121_TEM22_alias_wr_data;
	logic map_121_TEM22_alias_wr_en;
	logic map_121_TEM22_alias_rd_en;

	logic [31:0] map_122_TEM21_wr_data;
	logic map_122_TEM21_wr_en;
	logic map_122_TEM21_rd_en;

	logic [31:0] map_122_TEM22_wr_data;
	logic map_122_TEM22_wr_en;
	logic map_122_TEM22_rd_en;

	logic [31:0] map_122_TEM21_alias_wr_data;
	logic map_122_TEM21_alias_wr_en;
	logic map_122_TEM21_alias_rd_en;

	logic [31:0] map_122_TEM22_alias_wr_data;
	logic map_122_TEM22_alias_wr_en;
	logic map_122_TEM22_alias_rd_en;

	logic [31:0] map_123_TEM21_wr_data;
	logic map_123_TEM21_wr_en;
	logic map_123_TEM21_rd_en;

	logic [31:0] map_123_TEM22_wr_data;
	logic map_123_TEM22_wr_en;
	logic map_123_TEM22_rd_en;

	logic [31:0] map_123_TEM21_alias_wr_data;
	logic map_123_TEM21_alias_wr_en;
	logic map_123_TEM21_alias_rd_en;

	logic [31:0] map_123_TEM22_alias_wr_data;
	logic map_123_TEM22_alias_wr_en;
	logic map_123_TEM22_alias_rd_en;

	logic [31:0] map_124_TEM21_wr_data;
	logic map_124_TEM21_wr_en;
	logic map_124_TEM21_rd_en;

	logic [31:0] map_124_TEM22_wr_data;
	logic map_124_TEM22_wr_en;
	logic map_124_TEM22_rd_en;

	logic [31:0] map_124_TEM21_alias_wr_data;
	logic map_124_TEM21_alias_wr_en;
	logic map_124_TEM21_alias_rd_en;

	logic [31:0] map_124_TEM22_alias_wr_data;
	logic map_124_TEM22_alias_wr_en;
	logic map_124_TEM22_alias_rd_en;

	logic [31:0] map_125_TEM21_wr_data;
	logic map_125_TEM21_wr_en;
	logic map_125_TEM21_rd_en;

	logic [31:0] map_125_TEM22_wr_data;
	logic map_125_TEM22_wr_en;
	logic map_125_TEM22_rd_en;

	logic [31:0] map_125_TEM21_alias_wr_data;
	logic map_125_TEM21_alias_wr_en;
	logic map_125_TEM21_alias_rd_en;

	logic [31:0] map_125_TEM22_alias_wr_data;
	logic map_125_TEM22_alias_wr_en;
	logic map_125_TEM22_alias_rd_en;

	logic [31:0] map_126_TEM21_wr_data;
	logic map_126_TEM21_wr_en;
	logic map_126_TEM21_rd_en;

	logic [31:0] map_126_TEM22_wr_data;
	logic map_126_TEM22_wr_en;
	logic map_126_TEM22_rd_en;

	logic [31:0] map_126_TEM21_alias_wr_data;
	logic map_126_TEM21_alias_wr_en;
	logic map_126_TEM21_alias_rd_en;

	logic [31:0] map_126_TEM22_alias_wr_data;
	logic map_126_TEM22_alias_wr_en;
	logic map_126_TEM22_alias_rd_en;

	logic [31:0] map_127_TEM21_wr_data;
	logic map_127_TEM21_wr_en;
	logic map_127_TEM21_rd_en;

	logic [31:0] map_127_TEM22_wr_data;
	logic map_127_TEM22_wr_en;
	logic map_127_TEM22_rd_en;

	logic [31:0] map_127_TEM21_alias_wr_data;
	logic map_127_TEM21_alias_wr_en;
	logic map_127_TEM21_alias_rd_en;

	logic [31:0] map_127_TEM22_alias_wr_data;
	logic map_127_TEM22_alias_wr_en;
	logic map_127_TEM22_alias_rd_en;

	logic [31:0] map_128_TEM21_wr_data;
	logic map_128_TEM21_wr_en;
	logic map_128_TEM21_rd_en;

	logic [31:0] map_128_TEM22_wr_data;
	logic map_128_TEM22_wr_en;
	logic map_128_TEM22_rd_en;

	logic [31:0] map_128_TEM21_alias_wr_data;
	logic map_128_TEM21_alias_wr_en;
	logic map_128_TEM21_alias_rd_en;

	logic [31:0] map_128_TEM22_alias_wr_data;
	logic map_128_TEM22_alias_wr_en;
	logic map_128_TEM22_alias_rd_en;

	logic [31:0] map_129_TEM21_wr_data;
	logic map_129_TEM21_wr_en;
	logic map_129_TEM21_rd_en;

	logic [31:0] map_129_TEM22_wr_data;
	logic map_129_TEM22_wr_en;
	logic map_129_TEM22_rd_en;

	logic [31:0] map_129_TEM21_alias_wr_data;
	logic map_129_TEM21_alias_wr_en;
	logic map_129_TEM21_alias_rd_en;

	logic [31:0] map_129_TEM22_alias_wr_data;
	logic map_129_TEM22_alias_wr_en;
	logic map_129_TEM22_alias_rd_en;

//****************************************WIRE DECLARATION END****************************************//


//***************************************ADDRESS DECODER START****************************************//
	// internal regfile decoder @regfile domain
	assign err = dummy_reg;
	always_comb begin
			reg_sel = {REG_NUM{1'b0}};
			dummy_reg = 1'b0;
		unique casez (regfile_addr)
			64'hc:reg_sel[0] = 1'b1;//['map_11[0]', 'TEM21']
			64'h10:reg_sel[1] = 1'b1;//['map_11[0]', 'TEM22']
			64'h10c:reg_sel[2] = 1'b1;//['map_11[0]', 'TEM21_alias']
			64'h110:reg_sel[3] = 1'b1;//['map_11[0]', 'TEM22_alias']
			64'h120:reg_sel[4] = 1'b1;//['map_11[1]', 'TEM21']
			64'h124:reg_sel[5] = 1'b1;//['map_11[1]', 'TEM22']
			64'h220:reg_sel[6] = 1'b1;//['map_11[1]', 'TEM21_alias']
			64'h224:reg_sel[7] = 1'b1;//['map_11[1]', 'TEM22_alias']
			64'h234:reg_sel[8] = 1'b1;//['map_11[2]', 'TEM21']
			64'h238:reg_sel[9] = 1'b1;//['map_11[2]', 'TEM22']
			64'h334:reg_sel[10] = 1'b1;//['map_11[2]', 'TEM21_alias']
			64'h338:reg_sel[11] = 1'b1;//['map_11[2]', 'TEM22_alias']
			64'h348:reg_sel[12] = 1'b1;//['map_11[3]', 'TEM21']
			64'h34c:reg_sel[13] = 1'b1;//['map_11[3]', 'TEM22']
			64'h448:reg_sel[14] = 1'b1;//['map_11[3]', 'TEM21_alias']
			64'h44c:reg_sel[15] = 1'b1;//['map_11[3]', 'TEM22_alias']
			64'h45c:reg_sel[16] = 1'b1;//['map_11[4]', 'TEM21']
			64'h460:reg_sel[17] = 1'b1;//['map_11[4]', 'TEM22']
			64'h55c:reg_sel[18] = 1'b1;//['map_11[4]', 'TEM21_alias']
			64'h560:reg_sel[19] = 1'b1;//['map_11[4]', 'TEM22_alias']
			64'h60c:reg_sel[20] = 1'b1;//['map_12[0]', 'TEM21']
			64'h610:reg_sel[21] = 1'b1;//['map_12[0]', 'TEM22']
			64'h70c:reg_sel[22] = 1'b1;//['map_12[0]', 'TEM21_alias']
			64'h710:reg_sel[23] = 1'b1;//['map_12[0]', 'TEM22_alias']
			64'h720:reg_sel[24] = 1'b1;//['map_12[1]', 'TEM21']
			64'h724:reg_sel[25] = 1'b1;//['map_12[1]', 'TEM22']
			64'h820:reg_sel[26] = 1'b1;//['map_12[1]', 'TEM21_alias']
			64'h824:reg_sel[27] = 1'b1;//['map_12[1]', 'TEM22_alias']
			64'h834:reg_sel[28] = 1'b1;//['map_12[2]', 'TEM21']
			64'h838:reg_sel[29] = 1'b1;//['map_12[2]', 'TEM22']
			64'h934:reg_sel[30] = 1'b1;//['map_12[2]', 'TEM21_alias']
			64'h938:reg_sel[31] = 1'b1;//['map_12[2]', 'TEM22_alias']
			64'h948:reg_sel[32] = 1'b1;//['map_12[3]', 'TEM21']
			64'h94c:reg_sel[33] = 1'b1;//['map_12[3]', 'TEM22']
			64'ha48:reg_sel[34] = 1'b1;//['map_12[3]', 'TEM21_alias']
			64'ha4c:reg_sel[35] = 1'b1;//['map_12[3]', 'TEM22_alias']
			64'ha5c:reg_sel[36] = 1'b1;//['map_12[4]', 'TEM21']
			64'ha60:reg_sel[37] = 1'b1;//['map_12[4]', 'TEM22']
			64'hb5c:reg_sel[38] = 1'b1;//['map_12[4]', 'TEM21_alias']
			64'hb60:reg_sel[39] = 1'b1;//['map_12[4]', 'TEM22_alias']
			64'hb70:reg_sel[40] = 1'b1;//['map_12[5]', 'TEM21']
			64'hb74:reg_sel[41] = 1'b1;//['map_12[5]', 'TEM22']
			64'hc70:reg_sel[42] = 1'b1;//['map_12[5]', 'TEM21_alias']
			64'hc74:reg_sel[43] = 1'b1;//['map_12[5]', 'TEM22_alias']
			64'hc84:reg_sel[44] = 1'b1;//['map_12[6]', 'TEM21']
			64'hc88:reg_sel[45] = 1'b1;//['map_12[6]', 'TEM22']
			64'hd84:reg_sel[46] = 1'b1;//['map_12[6]', 'TEM21_alias']
			64'hd88:reg_sel[47] = 1'b1;//['map_12[6]', 'TEM22_alias']
			64'hd98:reg_sel[48] = 1'b1;//['map_12[7]', 'TEM21']
			64'hd9c:reg_sel[49] = 1'b1;//['map_12[7]', 'TEM22']
			64'he98:reg_sel[50] = 1'b1;//['map_12[7]', 'TEM21_alias']
			64'he9c:reg_sel[51] = 1'b1;//['map_12[7]', 'TEM22_alias']
			64'heac:reg_sel[52] = 1'b1;//['map_12[8]', 'TEM21']
			64'heb0:reg_sel[53] = 1'b1;//['map_12[8]', 'TEM22']
			64'hfac:reg_sel[54] = 1'b1;//['map_12[8]', 'TEM21_alias']
			64'hfb0:reg_sel[55] = 1'b1;//['map_12[8]', 'TEM22_alias']
			64'hfc0:reg_sel[56] = 1'b1;//['map_12[9]', 'TEM21']
			64'hfc4:reg_sel[57] = 1'b1;//['map_12[9]', 'TEM22']
			64'h10c0:reg_sel[58] = 1'b1;//['map_12[9]', 'TEM21_alias']
			64'h10c4:reg_sel[59] = 1'b1;//['map_12[9]', 'TEM22_alias']
			default: dummy_reg = 1'b1;
		endcase
	end
//****************************************ADDRESS DECODER END*****************************************//


//************************************STATE MACHINE INSTANCE START************************************//
	slv_fsm #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
		slv_fsm_slv_map (
		.clk(regslv_clk),
		.rst_n(regslv_rst_n),
		.mst__fsm__req_vld(req_vld_fsm),
		.fsm__mst__ack_vld(ack_vld_fsm),
		.mst__fsm__addr(addr_fsm),
		.mst__fsm__wr_en(wr_en_fsm),
		.mst__fsm__rd_en(rd_en_fsm),
		.mst__fsm__wr_data(wr_data_fsm),
		.fsm__mst__rd_data(rd_data_fsm),
		.fsm__slv__req_vld(fsm__slv__req_vld),
		.slv__fsm__ack_vld(slv__fsm__ack_vld),
		.fsm__slv__addr(fsm__slv__addr),
		.fsm__slv__wr_en(fsm__slv__wr_en),
		.fsm__slv__rd_en(fsm__slv__rd_en),
		.fsm__slv__wr_data(fsm__slv__wr_data),
		.slv__fsm__rd_data(slv__fsm__rd_data),
		.soft_rst(soft_rst_fsm),
		.fsm__slv__sync_reset()
	);
//*************************************STATE MACHINE INSTANCE END*************************************//


//**************************************SPLIT MUX INSTANCE START**************************************//
	// regfile mux @regfile domain
	split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(N+1), .GROUP_SIZE(128), .SKIP_DFF_0(1), .SKIP_DFF_1(1)) rd_split_mux
	(.clk(regslv_clk), .rst_n(regslv_rst_n),
	.din({regfile_reg_rd_data_in,{DATA_WIDTH{1'b0}}}), .sel({rd_sel, dummy_reg & regfile_req_vld}),
	.dout(regfile_rd_data), .dout_vld(regfile_rd_ack_vld)
	);
//***************************************SPLIT MUX INSTANCE END***************************************//


//*****************************************ULTIMATE MUX START*****************************************//
	// select which to read out and transfer the corresponding vld signal @regslv domain
	assign slv__fsm__rd_data = regfile_ack_vld ? regfile_rd_data : 0;
//******************************************ULTIMATE MUX END******************************************//


//**********************************REGSLV CDC DELIVER INSTANT START**********************************//
	assign req_vld_fsm      = req_vld        ;
	assign ack_vld          = ack_vld_fsm    ;
	assign wr_en_fsm        = wr_en          ;
	assign rd_en_fsm        = rd_en          ;
	assign addr_fsm         = addr           ;
	assign wr_data_fsm      = wr_data        ;
	assign rd_data          = rd_data_fsm    ;
	assign soft_rst_fsm = soft_rst;
//***********************************REGSLV CDC DELIVER INSTANT END***********************************//


//**************************************REG/FIELD INSTANCE START**************************************//
	//============================================REG INSTANT=============================================//
	//REG NAME: map_110_TEM21//
	//REG HIERARCHY: ['map_11[0]', 'TEM21']//
	//REG ABSOLUTE_ADDR:64'hc//
	//REG OFFSET_ADDR:64'hc//
	logic [31:0] map_110_TEM21_o;
	assign map_110_TEM21_wr_data = wr_sel[0] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_110_TEM21_wr_en = wr_sel[0];
	assign map_110_TEM21_rd_en = rd_sel[0];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_110_TEM21__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_110_TEM21_wr_data[13:13],map_110_TEM21_alias_wr_data[13:13]}),
		.sw_rd                 ({map_110_TEM21_rd_en,map_110_TEM21_alias_rd_en}),
		.sw_wr                 ({map_110_TEM21_wr_en,map_110_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_110_TEM21__FIELD_3__next_value),
		.hw_pulse              (map_110_TEM21__FIELD_3__pulse),
		.field_value           (map_110_TEM21__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_110_TEM21__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_110_TEM21_wr_data[16:14],map_110_TEM21_alias_wr_data[16:14]}),
		.sw_rd                 ({map_110_TEM21_rd_en,map_110_TEM21_alias_rd_en}),
		.sw_wr                 ({map_110_TEM21_wr_en,map_110_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_110_TEM21__FIELD_2__next_value),
		.hw_pulse              (map_110_TEM21__FIELD_2__pulse),
		.field_value           (map_110_TEM21__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_110_TEM21__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_110_TEM21_wr_data[17:17],map_110_TEM21_alias_wr_data[17:17]}),
		.sw_rd                 ({map_110_TEM21_rd_en,map_110_TEM21_alias_rd_en}),
		.sw_wr                 ({map_110_TEM21_wr_en,map_110_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_110_TEM21__FIELD_1__next_value),
		.hw_pulse              (map_110_TEM21__FIELD_1__pulse),
		.field_value           (map_110_TEM21__FIELD_1__curr_value)
		);
	always_comb begin
		map_110_TEM21_o[31:0] = 32'h0;
		map_110_TEM21_o[13:13] = map_110_TEM21__FIELD_3__curr_value;
		map_110_TEM21_o[16:14] = map_110_TEM21__FIELD_2__curr_value;
		map_110_TEM21_o[17:17] = map_110_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[0] = map_110_TEM21_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_110_TEM22//
	//REG HIERARCHY: ['map_11[0]', 'TEM22']//
	//REG ABSOLUTE_ADDR:64'h10//
	//REG OFFSET_ADDR:64'h10//
	logic [31:0] map_110_TEM22_o;
	assign map_110_TEM22_wr_data = wr_sel[1] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_110_TEM22_wr_en = wr_sel[1];
	assign map_110_TEM22_rd_en = rd_sel[1];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_110_TEM22__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_110_TEM22_wr_data[13:13],map_110_TEM22_alias_wr_data[13:13]}),
		.sw_rd                 ({map_110_TEM22_rd_en,map_110_TEM22_alias_rd_en}),
		.sw_wr                 ({map_110_TEM22_wr_en,map_110_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_110_TEM22__FIELD_3__next_value),
		.hw_pulse              (map_110_TEM22__FIELD_3__pulse),
		.field_value           (map_110_TEM22__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_110_TEM22__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_110_TEM22_wr_data[16:14],map_110_TEM22_alias_wr_data[16:14]}),
		.sw_rd                 ({map_110_TEM22_rd_en,map_110_TEM22_alias_rd_en}),
		.sw_wr                 ({map_110_TEM22_wr_en,map_110_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_110_TEM22__FIELD_2__next_value),
		.hw_pulse              (map_110_TEM22__FIELD_2__pulse),
		.field_value           (map_110_TEM22__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_110_TEM22__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_110_TEM22_wr_data[17:17],map_110_TEM22_alias_wr_data[17:17]}),
		.sw_rd                 ({map_110_TEM22_rd_en,map_110_TEM22_alias_rd_en}),
		.sw_wr                 ({map_110_TEM22_wr_en,map_110_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_110_TEM22__FIELD_1__next_value),
		.hw_pulse              (map_110_TEM22__FIELD_1__pulse),
		.field_value           (map_110_TEM22__FIELD_1__curr_value)
		);
	always_comb begin
		map_110_TEM22_o[31:0] = 32'h0;
		map_110_TEM22_o[13:13] = map_110_TEM22__FIELD_3__curr_value;
		map_110_TEM22_o[16:14] = map_110_TEM22__FIELD_2__curr_value;
		map_110_TEM22_o[17:17] = map_110_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[1] = map_110_TEM22_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_110_TEM21_alias//
	//REG HIERARCHY: ['map_11[0]', 'TEM21_alias']//
	//REG ABSOLUTE_ADDR:64'h10c//
	//REG OFFSET_ADDR:64'h10c//
	logic [31:0] map_110_TEM21_alias_o;
	assign map_110_TEM21_alias_wr_data = wr_sel[2] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_110_TEM21_alias_wr_en = wr_sel[2];
	assign map_110_TEM21_alias_rd_en = rd_sel[2];
	always_comb begin
		map_110_TEM21_alias_o[31:0] = 32'h0;
		map_110_TEM21_alias_o[13:13] = map_110_TEM21__FIELD_3__curr_value;
		map_110_TEM21_alias_o[16:14] = map_110_TEM21__FIELD_2__curr_value;
		map_110_TEM21_alias_o[17:17] = map_110_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[2] = map_110_TEM21_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_110_TEM22_alias//
	//REG HIERARCHY: ['map_11[0]', 'TEM22_alias']//
	//REG ABSOLUTE_ADDR:64'h110//
	//REG OFFSET_ADDR:64'h110//
	logic [31:0] map_110_TEM22_alias_o;
	assign map_110_TEM22_alias_wr_data = wr_sel[3] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_110_TEM22_alias_wr_en = wr_sel[3];
	assign map_110_TEM22_alias_rd_en = rd_sel[3];
	always_comb begin
		map_110_TEM22_alias_o[31:0] = 32'h0;
		map_110_TEM22_alias_o[13:13] = map_110_TEM22__FIELD_3__curr_value;
		map_110_TEM22_alias_o[16:14] = map_110_TEM22__FIELD_2__curr_value;
		map_110_TEM22_alias_o[17:17] = map_110_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[3] = map_110_TEM22_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_111_TEM21//
	//REG HIERARCHY: ['map_11[1]', 'TEM21']//
	//REG ABSOLUTE_ADDR:64'h120//
	//REG OFFSET_ADDR:64'hc//
	logic [31:0] map_111_TEM21_o;
	assign map_111_TEM21_wr_data = wr_sel[4] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_111_TEM21_wr_en = wr_sel[4];
	assign map_111_TEM21_rd_en = rd_sel[4];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_111_TEM21__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_111_TEM21_wr_data[13:13],map_111_TEM21_alias_wr_data[13:13]}),
		.sw_rd                 ({map_111_TEM21_rd_en,map_111_TEM21_alias_rd_en}),
		.sw_wr                 ({map_111_TEM21_wr_en,map_111_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_111_TEM21__FIELD_3__next_value),
		.hw_pulse              (map_111_TEM21__FIELD_3__pulse),
		.field_value           (map_111_TEM21__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_111_TEM21__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_111_TEM21_wr_data[16:14],map_111_TEM21_alias_wr_data[16:14]}),
		.sw_rd                 ({map_111_TEM21_rd_en,map_111_TEM21_alias_rd_en}),
		.sw_wr                 ({map_111_TEM21_wr_en,map_111_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_111_TEM21__FIELD_2__next_value),
		.hw_pulse              (map_111_TEM21__FIELD_2__pulse),
		.field_value           (map_111_TEM21__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_111_TEM21__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_111_TEM21_wr_data[17:17],map_111_TEM21_alias_wr_data[17:17]}),
		.sw_rd                 ({map_111_TEM21_rd_en,map_111_TEM21_alias_rd_en}),
		.sw_wr                 ({map_111_TEM21_wr_en,map_111_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_111_TEM21__FIELD_1__next_value),
		.hw_pulse              (map_111_TEM21__FIELD_1__pulse),
		.field_value           (map_111_TEM21__FIELD_1__curr_value)
		);
	always_comb begin
		map_111_TEM21_o[31:0] = 32'h0;
		map_111_TEM21_o[13:13] = map_111_TEM21__FIELD_3__curr_value;
		map_111_TEM21_o[16:14] = map_111_TEM21__FIELD_2__curr_value;
		map_111_TEM21_o[17:17] = map_111_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[4] = map_111_TEM21_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_111_TEM22//
	//REG HIERARCHY: ['map_11[1]', 'TEM22']//
	//REG ABSOLUTE_ADDR:64'h124//
	//REG OFFSET_ADDR:64'h10//
	logic [31:0] map_111_TEM22_o;
	assign map_111_TEM22_wr_data = wr_sel[5] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_111_TEM22_wr_en = wr_sel[5];
	assign map_111_TEM22_rd_en = rd_sel[5];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_111_TEM22__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_111_TEM22_wr_data[13:13],map_111_TEM22_alias_wr_data[13:13]}),
		.sw_rd                 ({map_111_TEM22_rd_en,map_111_TEM22_alias_rd_en}),
		.sw_wr                 ({map_111_TEM22_wr_en,map_111_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_111_TEM22__FIELD_3__next_value),
		.hw_pulse              (map_111_TEM22__FIELD_3__pulse),
		.field_value           (map_111_TEM22__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_111_TEM22__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_111_TEM22_wr_data[16:14],map_111_TEM22_alias_wr_data[16:14]}),
		.sw_rd                 ({map_111_TEM22_rd_en,map_111_TEM22_alias_rd_en}),
		.sw_wr                 ({map_111_TEM22_wr_en,map_111_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_111_TEM22__FIELD_2__next_value),
		.hw_pulse              (map_111_TEM22__FIELD_2__pulse),
		.field_value           (map_111_TEM22__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_111_TEM22__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_111_TEM22_wr_data[17:17],map_111_TEM22_alias_wr_data[17:17]}),
		.sw_rd                 ({map_111_TEM22_rd_en,map_111_TEM22_alias_rd_en}),
		.sw_wr                 ({map_111_TEM22_wr_en,map_111_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_111_TEM22__FIELD_1__next_value),
		.hw_pulse              (map_111_TEM22__FIELD_1__pulse),
		.field_value           (map_111_TEM22__FIELD_1__curr_value)
		);
	always_comb begin
		map_111_TEM22_o[31:0] = 32'h0;
		map_111_TEM22_o[13:13] = map_111_TEM22__FIELD_3__curr_value;
		map_111_TEM22_o[16:14] = map_111_TEM22__FIELD_2__curr_value;
		map_111_TEM22_o[17:17] = map_111_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[5] = map_111_TEM22_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_111_TEM21_alias//
	//REG HIERARCHY: ['map_11[1]', 'TEM21_alias']//
	//REG ABSOLUTE_ADDR:64'h220//
	//REG OFFSET_ADDR:64'h10c//
	logic [31:0] map_111_TEM21_alias_o;
	assign map_111_TEM21_alias_wr_data = wr_sel[6] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_111_TEM21_alias_wr_en = wr_sel[6];
	assign map_111_TEM21_alias_rd_en = rd_sel[6];
	always_comb begin
		map_111_TEM21_alias_o[31:0] = 32'h0;
		map_111_TEM21_alias_o[13:13] = map_111_TEM21__FIELD_3__curr_value;
		map_111_TEM21_alias_o[16:14] = map_111_TEM21__FIELD_2__curr_value;
		map_111_TEM21_alias_o[17:17] = map_111_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[6] = map_111_TEM21_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_111_TEM22_alias//
	//REG HIERARCHY: ['map_11[1]', 'TEM22_alias']//
	//REG ABSOLUTE_ADDR:64'h224//
	//REG OFFSET_ADDR:64'h110//
	logic [31:0] map_111_TEM22_alias_o;
	assign map_111_TEM22_alias_wr_data = wr_sel[7] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_111_TEM22_alias_wr_en = wr_sel[7];
	assign map_111_TEM22_alias_rd_en = rd_sel[7];
	always_comb begin
		map_111_TEM22_alias_o[31:0] = 32'h0;
		map_111_TEM22_alias_o[13:13] = map_111_TEM22__FIELD_3__curr_value;
		map_111_TEM22_alias_o[16:14] = map_111_TEM22__FIELD_2__curr_value;
		map_111_TEM22_alias_o[17:17] = map_111_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[7] = map_111_TEM22_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_112_TEM21//
	//REG HIERARCHY: ['map_11[2]', 'TEM21']//
	//REG ABSOLUTE_ADDR:64'h234//
	//REG OFFSET_ADDR:64'hc//
	logic [31:0] map_112_TEM21_o;
	assign map_112_TEM21_wr_data = wr_sel[8] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_112_TEM21_wr_en = wr_sel[8];
	assign map_112_TEM21_rd_en = rd_sel[8];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_112_TEM21__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_112_TEM21_wr_data[13:13],map_112_TEM21_alias_wr_data[13:13]}),
		.sw_rd                 ({map_112_TEM21_rd_en,map_112_TEM21_alias_rd_en}),
		.sw_wr                 ({map_112_TEM21_wr_en,map_112_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_112_TEM21__FIELD_3__next_value),
		.hw_pulse              (map_112_TEM21__FIELD_3__pulse),
		.field_value           (map_112_TEM21__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_112_TEM21__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_112_TEM21_wr_data[16:14],map_112_TEM21_alias_wr_data[16:14]}),
		.sw_rd                 ({map_112_TEM21_rd_en,map_112_TEM21_alias_rd_en}),
		.sw_wr                 ({map_112_TEM21_wr_en,map_112_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_112_TEM21__FIELD_2__next_value),
		.hw_pulse              (map_112_TEM21__FIELD_2__pulse),
		.field_value           (map_112_TEM21__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_112_TEM21__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_112_TEM21_wr_data[17:17],map_112_TEM21_alias_wr_data[17:17]}),
		.sw_rd                 ({map_112_TEM21_rd_en,map_112_TEM21_alias_rd_en}),
		.sw_wr                 ({map_112_TEM21_wr_en,map_112_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_112_TEM21__FIELD_1__next_value),
		.hw_pulse              (map_112_TEM21__FIELD_1__pulse),
		.field_value           (map_112_TEM21__FIELD_1__curr_value)
		);
	always_comb begin
		map_112_TEM21_o[31:0] = 32'h0;
		map_112_TEM21_o[13:13] = map_112_TEM21__FIELD_3__curr_value;
		map_112_TEM21_o[16:14] = map_112_TEM21__FIELD_2__curr_value;
		map_112_TEM21_o[17:17] = map_112_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[8] = map_112_TEM21_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_112_TEM22//
	//REG HIERARCHY: ['map_11[2]', 'TEM22']//
	//REG ABSOLUTE_ADDR:64'h238//
	//REG OFFSET_ADDR:64'h10//
	logic [31:0] map_112_TEM22_o;
	assign map_112_TEM22_wr_data = wr_sel[9] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_112_TEM22_wr_en = wr_sel[9];
	assign map_112_TEM22_rd_en = rd_sel[9];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_112_TEM22__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_112_TEM22_wr_data[13:13],map_112_TEM22_alias_wr_data[13:13]}),
		.sw_rd                 ({map_112_TEM22_rd_en,map_112_TEM22_alias_rd_en}),
		.sw_wr                 ({map_112_TEM22_wr_en,map_112_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_112_TEM22__FIELD_3__next_value),
		.hw_pulse              (map_112_TEM22__FIELD_3__pulse),
		.field_value           (map_112_TEM22__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_112_TEM22__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_112_TEM22_wr_data[16:14],map_112_TEM22_alias_wr_data[16:14]}),
		.sw_rd                 ({map_112_TEM22_rd_en,map_112_TEM22_alias_rd_en}),
		.sw_wr                 ({map_112_TEM22_wr_en,map_112_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_112_TEM22__FIELD_2__next_value),
		.hw_pulse              (map_112_TEM22__FIELD_2__pulse),
		.field_value           (map_112_TEM22__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_112_TEM22__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_112_TEM22_wr_data[17:17],map_112_TEM22_alias_wr_data[17:17]}),
		.sw_rd                 ({map_112_TEM22_rd_en,map_112_TEM22_alias_rd_en}),
		.sw_wr                 ({map_112_TEM22_wr_en,map_112_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_112_TEM22__FIELD_1__next_value),
		.hw_pulse              (map_112_TEM22__FIELD_1__pulse),
		.field_value           (map_112_TEM22__FIELD_1__curr_value)
		);
	always_comb begin
		map_112_TEM22_o[31:0] = 32'h0;
		map_112_TEM22_o[13:13] = map_112_TEM22__FIELD_3__curr_value;
		map_112_TEM22_o[16:14] = map_112_TEM22__FIELD_2__curr_value;
		map_112_TEM22_o[17:17] = map_112_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[9] = map_112_TEM22_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_112_TEM21_alias//
	//REG HIERARCHY: ['map_11[2]', 'TEM21_alias']//
	//REG ABSOLUTE_ADDR:64'h334//
	//REG OFFSET_ADDR:64'h10c//
	logic [31:0] map_112_TEM21_alias_o;
	assign map_112_TEM21_alias_wr_data = wr_sel[10] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_112_TEM21_alias_wr_en = wr_sel[10];
	assign map_112_TEM21_alias_rd_en = rd_sel[10];
	always_comb begin
		map_112_TEM21_alias_o[31:0] = 32'h0;
		map_112_TEM21_alias_o[13:13] = map_112_TEM21__FIELD_3__curr_value;
		map_112_TEM21_alias_o[16:14] = map_112_TEM21__FIELD_2__curr_value;
		map_112_TEM21_alias_o[17:17] = map_112_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[10] = map_112_TEM21_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_112_TEM22_alias//
	//REG HIERARCHY: ['map_11[2]', 'TEM22_alias']//
	//REG ABSOLUTE_ADDR:64'h338//
	//REG OFFSET_ADDR:64'h110//
	logic [31:0] map_112_TEM22_alias_o;
	assign map_112_TEM22_alias_wr_data = wr_sel[11] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_112_TEM22_alias_wr_en = wr_sel[11];
	assign map_112_TEM22_alias_rd_en = rd_sel[11];
	always_comb begin
		map_112_TEM22_alias_o[31:0] = 32'h0;
		map_112_TEM22_alias_o[13:13] = map_112_TEM22__FIELD_3__curr_value;
		map_112_TEM22_alias_o[16:14] = map_112_TEM22__FIELD_2__curr_value;
		map_112_TEM22_alias_o[17:17] = map_112_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[11] = map_112_TEM22_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_113_TEM21//
	//REG HIERARCHY: ['map_11[3]', 'TEM21']//
	//REG ABSOLUTE_ADDR:64'h348//
	//REG OFFSET_ADDR:64'hc//
	logic [31:0] map_113_TEM21_o;
	assign map_113_TEM21_wr_data = wr_sel[12] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_113_TEM21_wr_en = wr_sel[12];
	assign map_113_TEM21_rd_en = rd_sel[12];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_113_TEM21__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_113_TEM21_wr_data[13:13],map_113_TEM21_alias_wr_data[13:13]}),
		.sw_rd                 ({map_113_TEM21_rd_en,map_113_TEM21_alias_rd_en}),
		.sw_wr                 ({map_113_TEM21_wr_en,map_113_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_113_TEM21__FIELD_3__next_value),
		.hw_pulse              (map_113_TEM21__FIELD_3__pulse),
		.field_value           (map_113_TEM21__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_113_TEM21__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_113_TEM21_wr_data[16:14],map_113_TEM21_alias_wr_data[16:14]}),
		.sw_rd                 ({map_113_TEM21_rd_en,map_113_TEM21_alias_rd_en}),
		.sw_wr                 ({map_113_TEM21_wr_en,map_113_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_113_TEM21__FIELD_2__next_value),
		.hw_pulse              (map_113_TEM21__FIELD_2__pulse),
		.field_value           (map_113_TEM21__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_113_TEM21__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_113_TEM21_wr_data[17:17],map_113_TEM21_alias_wr_data[17:17]}),
		.sw_rd                 ({map_113_TEM21_rd_en,map_113_TEM21_alias_rd_en}),
		.sw_wr                 ({map_113_TEM21_wr_en,map_113_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_113_TEM21__FIELD_1__next_value),
		.hw_pulse              (map_113_TEM21__FIELD_1__pulse),
		.field_value           (map_113_TEM21__FIELD_1__curr_value)
		);
	always_comb begin
		map_113_TEM21_o[31:0] = 32'h0;
		map_113_TEM21_o[13:13] = map_113_TEM21__FIELD_3__curr_value;
		map_113_TEM21_o[16:14] = map_113_TEM21__FIELD_2__curr_value;
		map_113_TEM21_o[17:17] = map_113_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[12] = map_113_TEM21_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_113_TEM22//
	//REG HIERARCHY: ['map_11[3]', 'TEM22']//
	//REG ABSOLUTE_ADDR:64'h34c//
	//REG OFFSET_ADDR:64'h10//
	logic [31:0] map_113_TEM22_o;
	assign map_113_TEM22_wr_data = wr_sel[13] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_113_TEM22_wr_en = wr_sel[13];
	assign map_113_TEM22_rd_en = rd_sel[13];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_113_TEM22__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_113_TEM22_wr_data[13:13],map_113_TEM22_alias_wr_data[13:13]}),
		.sw_rd                 ({map_113_TEM22_rd_en,map_113_TEM22_alias_rd_en}),
		.sw_wr                 ({map_113_TEM22_wr_en,map_113_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_113_TEM22__FIELD_3__next_value),
		.hw_pulse              (map_113_TEM22__FIELD_3__pulse),
		.field_value           (map_113_TEM22__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_113_TEM22__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_113_TEM22_wr_data[16:14],map_113_TEM22_alias_wr_data[16:14]}),
		.sw_rd                 ({map_113_TEM22_rd_en,map_113_TEM22_alias_rd_en}),
		.sw_wr                 ({map_113_TEM22_wr_en,map_113_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_113_TEM22__FIELD_2__next_value),
		.hw_pulse              (map_113_TEM22__FIELD_2__pulse),
		.field_value           (map_113_TEM22__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_113_TEM22__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_113_TEM22_wr_data[17:17],map_113_TEM22_alias_wr_data[17:17]}),
		.sw_rd                 ({map_113_TEM22_rd_en,map_113_TEM22_alias_rd_en}),
		.sw_wr                 ({map_113_TEM22_wr_en,map_113_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_113_TEM22__FIELD_1__next_value),
		.hw_pulse              (map_113_TEM22__FIELD_1__pulse),
		.field_value           (map_113_TEM22__FIELD_1__curr_value)
		);
	always_comb begin
		map_113_TEM22_o[31:0] = 32'h0;
		map_113_TEM22_o[13:13] = map_113_TEM22__FIELD_3__curr_value;
		map_113_TEM22_o[16:14] = map_113_TEM22__FIELD_2__curr_value;
		map_113_TEM22_o[17:17] = map_113_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[13] = map_113_TEM22_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_113_TEM21_alias//
	//REG HIERARCHY: ['map_11[3]', 'TEM21_alias']//
	//REG ABSOLUTE_ADDR:64'h448//
	//REG OFFSET_ADDR:64'h10c//
	logic [31:0] map_113_TEM21_alias_o;
	assign map_113_TEM21_alias_wr_data = wr_sel[14] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_113_TEM21_alias_wr_en = wr_sel[14];
	assign map_113_TEM21_alias_rd_en = rd_sel[14];
	always_comb begin
		map_113_TEM21_alias_o[31:0] = 32'h0;
		map_113_TEM21_alias_o[13:13] = map_113_TEM21__FIELD_3__curr_value;
		map_113_TEM21_alias_o[16:14] = map_113_TEM21__FIELD_2__curr_value;
		map_113_TEM21_alias_o[17:17] = map_113_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[14] = map_113_TEM21_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_113_TEM22_alias//
	//REG HIERARCHY: ['map_11[3]', 'TEM22_alias']//
	//REG ABSOLUTE_ADDR:64'h44c//
	//REG OFFSET_ADDR:64'h110//
	logic [31:0] map_113_TEM22_alias_o;
	assign map_113_TEM22_alias_wr_data = wr_sel[15] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_113_TEM22_alias_wr_en = wr_sel[15];
	assign map_113_TEM22_alias_rd_en = rd_sel[15];
	always_comb begin
		map_113_TEM22_alias_o[31:0] = 32'h0;
		map_113_TEM22_alias_o[13:13] = map_113_TEM22__FIELD_3__curr_value;
		map_113_TEM22_alias_o[16:14] = map_113_TEM22__FIELD_2__curr_value;
		map_113_TEM22_alias_o[17:17] = map_113_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[15] = map_113_TEM22_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_114_TEM21//
	//REG HIERARCHY: ['map_11[4]', 'TEM21']//
	//REG ABSOLUTE_ADDR:64'h45c//
	//REG OFFSET_ADDR:64'hc//
	logic [31:0] map_114_TEM21_o;
	assign map_114_TEM21_wr_data = wr_sel[16] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_114_TEM21_wr_en = wr_sel[16];
	assign map_114_TEM21_rd_en = rd_sel[16];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_114_TEM21__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_114_TEM21_wr_data[13:13],map_114_TEM21_alias_wr_data[13:13]}),
		.sw_rd                 ({map_114_TEM21_rd_en,map_114_TEM21_alias_rd_en}),
		.sw_wr                 ({map_114_TEM21_wr_en,map_114_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_114_TEM21__FIELD_3__next_value),
		.hw_pulse              (map_114_TEM21__FIELD_3__pulse),
		.field_value           (map_114_TEM21__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_114_TEM21__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_114_TEM21_wr_data[16:14],map_114_TEM21_alias_wr_data[16:14]}),
		.sw_rd                 ({map_114_TEM21_rd_en,map_114_TEM21_alias_rd_en}),
		.sw_wr                 ({map_114_TEM21_wr_en,map_114_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_114_TEM21__FIELD_2__next_value),
		.hw_pulse              (map_114_TEM21__FIELD_2__pulse),
		.field_value           (map_114_TEM21__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_114_TEM21__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_114_TEM21_wr_data[17:17],map_114_TEM21_alias_wr_data[17:17]}),
		.sw_rd                 ({map_114_TEM21_rd_en,map_114_TEM21_alias_rd_en}),
		.sw_wr                 ({map_114_TEM21_wr_en,map_114_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_114_TEM21__FIELD_1__next_value),
		.hw_pulse              (map_114_TEM21__FIELD_1__pulse),
		.field_value           (map_114_TEM21__FIELD_1__curr_value)
		);
	always_comb begin
		map_114_TEM21_o[31:0] = 32'h0;
		map_114_TEM21_o[13:13] = map_114_TEM21__FIELD_3__curr_value;
		map_114_TEM21_o[16:14] = map_114_TEM21__FIELD_2__curr_value;
		map_114_TEM21_o[17:17] = map_114_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[16] = map_114_TEM21_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_114_TEM22//
	//REG HIERARCHY: ['map_11[4]', 'TEM22']//
	//REG ABSOLUTE_ADDR:64'h460//
	//REG OFFSET_ADDR:64'h10//
	logic [31:0] map_114_TEM22_o;
	assign map_114_TEM22_wr_data = wr_sel[17] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_114_TEM22_wr_en = wr_sel[17];
	assign map_114_TEM22_rd_en = rd_sel[17];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_114_TEM22__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_114_TEM22_wr_data[13:13],map_114_TEM22_alias_wr_data[13:13]}),
		.sw_rd                 ({map_114_TEM22_rd_en,map_114_TEM22_alias_rd_en}),
		.sw_wr                 ({map_114_TEM22_wr_en,map_114_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_114_TEM22__FIELD_3__next_value),
		.hw_pulse              (map_114_TEM22__FIELD_3__pulse),
		.field_value           (map_114_TEM22__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_114_TEM22__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_114_TEM22_wr_data[16:14],map_114_TEM22_alias_wr_data[16:14]}),
		.sw_rd                 ({map_114_TEM22_rd_en,map_114_TEM22_alias_rd_en}),
		.sw_wr                 ({map_114_TEM22_wr_en,map_114_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_114_TEM22__FIELD_2__next_value),
		.hw_pulse              (map_114_TEM22__FIELD_2__pulse),
		.field_value           (map_114_TEM22__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_114_TEM22__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_114_TEM22_wr_data[17:17],map_114_TEM22_alias_wr_data[17:17]}),
		.sw_rd                 ({map_114_TEM22_rd_en,map_114_TEM22_alias_rd_en}),
		.sw_wr                 ({map_114_TEM22_wr_en,map_114_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_114_TEM22__FIELD_1__next_value),
		.hw_pulse              (map_114_TEM22__FIELD_1__pulse),
		.field_value           (map_114_TEM22__FIELD_1__curr_value)
		);
	always_comb begin
		map_114_TEM22_o[31:0] = 32'h0;
		map_114_TEM22_o[13:13] = map_114_TEM22__FIELD_3__curr_value;
		map_114_TEM22_o[16:14] = map_114_TEM22__FIELD_2__curr_value;
		map_114_TEM22_o[17:17] = map_114_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[17] = map_114_TEM22_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_114_TEM21_alias//
	//REG HIERARCHY: ['map_11[4]', 'TEM21_alias']//
	//REG ABSOLUTE_ADDR:64'h55c//
	//REG OFFSET_ADDR:64'h10c//
	logic [31:0] map_114_TEM21_alias_o;
	assign map_114_TEM21_alias_wr_data = wr_sel[18] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_114_TEM21_alias_wr_en = wr_sel[18];
	assign map_114_TEM21_alias_rd_en = rd_sel[18];
	always_comb begin
		map_114_TEM21_alias_o[31:0] = 32'h0;
		map_114_TEM21_alias_o[13:13] = map_114_TEM21__FIELD_3__curr_value;
		map_114_TEM21_alias_o[16:14] = map_114_TEM21__FIELD_2__curr_value;
		map_114_TEM21_alias_o[17:17] = map_114_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[18] = map_114_TEM21_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_114_TEM22_alias//
	//REG HIERARCHY: ['map_11[4]', 'TEM22_alias']//
	//REG ABSOLUTE_ADDR:64'h560//
	//REG OFFSET_ADDR:64'h110//
	logic [31:0] map_114_TEM22_alias_o;
	assign map_114_TEM22_alias_wr_data = wr_sel[19] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_114_TEM22_alias_wr_en = wr_sel[19];
	assign map_114_TEM22_alias_rd_en = rd_sel[19];
	always_comb begin
		map_114_TEM22_alias_o[31:0] = 32'h0;
		map_114_TEM22_alias_o[13:13] = map_114_TEM22__FIELD_3__curr_value;
		map_114_TEM22_alias_o[16:14] = map_114_TEM22__FIELD_2__curr_value;
		map_114_TEM22_alias_o[17:17] = map_114_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[19] = map_114_TEM22_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_120_TEM21//
	//REG HIERARCHY: ['map_12[0]', 'TEM21']//
	//REG ABSOLUTE_ADDR:64'h60c//
	//REG OFFSET_ADDR:64'hc//
	logic [31:0] map_120_TEM21_o;
	assign map_120_TEM21_wr_data = wr_sel[20] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_120_TEM21_wr_en = wr_sel[20];
	assign map_120_TEM21_rd_en = rd_sel[20];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_120_TEM21__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_120_TEM21_wr_data[13:13],map_120_TEM21_alias_wr_data[13:13]}),
		.sw_rd                 ({map_120_TEM21_rd_en,map_120_TEM21_alias_rd_en}),
		.sw_wr                 ({map_120_TEM21_wr_en,map_120_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_120_TEM21__FIELD_3__next_value),
		.hw_pulse              (map_120_TEM21__FIELD_3__pulse),
		.field_value           (map_120_TEM21__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_120_TEM21__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_120_TEM21_wr_data[16:14],map_120_TEM21_alias_wr_data[16:14]}),
		.sw_rd                 ({map_120_TEM21_rd_en,map_120_TEM21_alias_rd_en}),
		.sw_wr                 ({map_120_TEM21_wr_en,map_120_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_120_TEM21__FIELD_2__next_value),
		.hw_pulse              (map_120_TEM21__FIELD_2__pulse),
		.field_value           (map_120_TEM21__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_120_TEM21__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_120_TEM21_wr_data[17:17],map_120_TEM21_alias_wr_data[17:17]}),
		.sw_rd                 ({map_120_TEM21_rd_en,map_120_TEM21_alias_rd_en}),
		.sw_wr                 ({map_120_TEM21_wr_en,map_120_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_120_TEM21__FIELD_1__next_value),
		.hw_pulse              (map_120_TEM21__FIELD_1__pulse),
		.field_value           (map_120_TEM21__FIELD_1__curr_value)
		);
	always_comb begin
		map_120_TEM21_o[31:0] = 32'h0;
		map_120_TEM21_o[13:13] = map_120_TEM21__FIELD_3__curr_value;
		map_120_TEM21_o[16:14] = map_120_TEM21__FIELD_2__curr_value;
		map_120_TEM21_o[17:17] = map_120_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[20] = map_120_TEM21_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_120_TEM22//
	//REG HIERARCHY: ['map_12[0]', 'TEM22']//
	//REG ABSOLUTE_ADDR:64'h610//
	//REG OFFSET_ADDR:64'h10//
	logic [31:0] map_120_TEM22_o;
	assign map_120_TEM22_wr_data = wr_sel[21] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_120_TEM22_wr_en = wr_sel[21];
	assign map_120_TEM22_rd_en = rd_sel[21];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_120_TEM22__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_120_TEM22_wr_data[13:13],map_120_TEM22_alias_wr_data[13:13]}),
		.sw_rd                 ({map_120_TEM22_rd_en,map_120_TEM22_alias_rd_en}),
		.sw_wr                 ({map_120_TEM22_wr_en,map_120_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_120_TEM22__FIELD_3__next_value),
		.hw_pulse              (map_120_TEM22__FIELD_3__pulse),
		.field_value           (map_120_TEM22__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_120_TEM22__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_120_TEM22_wr_data[16:14],map_120_TEM22_alias_wr_data[16:14]}),
		.sw_rd                 ({map_120_TEM22_rd_en,map_120_TEM22_alias_rd_en}),
		.sw_wr                 ({map_120_TEM22_wr_en,map_120_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_120_TEM22__FIELD_2__next_value),
		.hw_pulse              (map_120_TEM22__FIELD_2__pulse),
		.field_value           (map_120_TEM22__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_120_TEM22__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_120_TEM22_wr_data[17:17],map_120_TEM22_alias_wr_data[17:17]}),
		.sw_rd                 ({map_120_TEM22_rd_en,map_120_TEM22_alias_rd_en}),
		.sw_wr                 ({map_120_TEM22_wr_en,map_120_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_120_TEM22__FIELD_1__next_value),
		.hw_pulse              (map_120_TEM22__FIELD_1__pulse),
		.field_value           (map_120_TEM22__FIELD_1__curr_value)
		);
	always_comb begin
		map_120_TEM22_o[31:0] = 32'h0;
		map_120_TEM22_o[13:13] = map_120_TEM22__FIELD_3__curr_value;
		map_120_TEM22_o[16:14] = map_120_TEM22__FIELD_2__curr_value;
		map_120_TEM22_o[17:17] = map_120_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[21] = map_120_TEM22_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_120_TEM21_alias//
	//REG HIERARCHY: ['map_12[0]', 'TEM21_alias']//
	//REG ABSOLUTE_ADDR:64'h70c//
	//REG OFFSET_ADDR:64'h10c//
	logic [31:0] map_120_TEM21_alias_o;
	assign map_120_TEM21_alias_wr_data = wr_sel[22] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_120_TEM21_alias_wr_en = wr_sel[22];
	assign map_120_TEM21_alias_rd_en = rd_sel[22];
	always_comb begin
		map_120_TEM21_alias_o[31:0] = 32'h0;
		map_120_TEM21_alias_o[13:13] = map_120_TEM21__FIELD_3__curr_value;
		map_120_TEM21_alias_o[16:14] = map_120_TEM21__FIELD_2__curr_value;
		map_120_TEM21_alias_o[17:17] = map_120_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[22] = map_120_TEM21_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_120_TEM22_alias//
	//REG HIERARCHY: ['map_12[0]', 'TEM22_alias']//
	//REG ABSOLUTE_ADDR:64'h710//
	//REG OFFSET_ADDR:64'h110//
	logic [31:0] map_120_TEM22_alias_o;
	assign map_120_TEM22_alias_wr_data = wr_sel[23] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_120_TEM22_alias_wr_en = wr_sel[23];
	assign map_120_TEM22_alias_rd_en = rd_sel[23];
	always_comb begin
		map_120_TEM22_alias_o[31:0] = 32'h0;
		map_120_TEM22_alias_o[13:13] = map_120_TEM22__FIELD_3__curr_value;
		map_120_TEM22_alias_o[16:14] = map_120_TEM22__FIELD_2__curr_value;
		map_120_TEM22_alias_o[17:17] = map_120_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[23] = map_120_TEM22_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_121_TEM21//
	//REG HIERARCHY: ['map_12[1]', 'TEM21']//
	//REG ABSOLUTE_ADDR:64'h720//
	//REG OFFSET_ADDR:64'hc//
	logic [31:0] map_121_TEM21_o;
	assign map_121_TEM21_wr_data = wr_sel[24] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_121_TEM21_wr_en = wr_sel[24];
	assign map_121_TEM21_rd_en = rd_sel[24];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_121_TEM21__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_121_TEM21_wr_data[13:13],map_121_TEM21_alias_wr_data[13:13]}),
		.sw_rd                 ({map_121_TEM21_rd_en,map_121_TEM21_alias_rd_en}),
		.sw_wr                 ({map_121_TEM21_wr_en,map_121_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_121_TEM21__FIELD_3__next_value),
		.hw_pulse              (map_121_TEM21__FIELD_3__pulse),
		.field_value           (map_121_TEM21__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_121_TEM21__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_121_TEM21_wr_data[16:14],map_121_TEM21_alias_wr_data[16:14]}),
		.sw_rd                 ({map_121_TEM21_rd_en,map_121_TEM21_alias_rd_en}),
		.sw_wr                 ({map_121_TEM21_wr_en,map_121_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_121_TEM21__FIELD_2__next_value),
		.hw_pulse              (map_121_TEM21__FIELD_2__pulse),
		.field_value           (map_121_TEM21__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_121_TEM21__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_121_TEM21_wr_data[17:17],map_121_TEM21_alias_wr_data[17:17]}),
		.sw_rd                 ({map_121_TEM21_rd_en,map_121_TEM21_alias_rd_en}),
		.sw_wr                 ({map_121_TEM21_wr_en,map_121_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_121_TEM21__FIELD_1__next_value),
		.hw_pulse              (map_121_TEM21__FIELD_1__pulse),
		.field_value           (map_121_TEM21__FIELD_1__curr_value)
		);
	always_comb begin
		map_121_TEM21_o[31:0] = 32'h0;
		map_121_TEM21_o[13:13] = map_121_TEM21__FIELD_3__curr_value;
		map_121_TEM21_o[16:14] = map_121_TEM21__FIELD_2__curr_value;
		map_121_TEM21_o[17:17] = map_121_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[24] = map_121_TEM21_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_121_TEM22//
	//REG HIERARCHY: ['map_12[1]', 'TEM22']//
	//REG ABSOLUTE_ADDR:64'h724//
	//REG OFFSET_ADDR:64'h10//
	logic [31:0] map_121_TEM22_o;
	assign map_121_TEM22_wr_data = wr_sel[25] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_121_TEM22_wr_en = wr_sel[25];
	assign map_121_TEM22_rd_en = rd_sel[25];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_121_TEM22__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_121_TEM22_wr_data[13:13],map_121_TEM22_alias_wr_data[13:13]}),
		.sw_rd                 ({map_121_TEM22_rd_en,map_121_TEM22_alias_rd_en}),
		.sw_wr                 ({map_121_TEM22_wr_en,map_121_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_121_TEM22__FIELD_3__next_value),
		.hw_pulse              (map_121_TEM22__FIELD_3__pulse),
		.field_value           (map_121_TEM22__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_121_TEM22__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_121_TEM22_wr_data[16:14],map_121_TEM22_alias_wr_data[16:14]}),
		.sw_rd                 ({map_121_TEM22_rd_en,map_121_TEM22_alias_rd_en}),
		.sw_wr                 ({map_121_TEM22_wr_en,map_121_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_121_TEM22__FIELD_2__next_value),
		.hw_pulse              (map_121_TEM22__FIELD_2__pulse),
		.field_value           (map_121_TEM22__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_121_TEM22__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_121_TEM22_wr_data[17:17],map_121_TEM22_alias_wr_data[17:17]}),
		.sw_rd                 ({map_121_TEM22_rd_en,map_121_TEM22_alias_rd_en}),
		.sw_wr                 ({map_121_TEM22_wr_en,map_121_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_121_TEM22__FIELD_1__next_value),
		.hw_pulse              (map_121_TEM22__FIELD_1__pulse),
		.field_value           (map_121_TEM22__FIELD_1__curr_value)
		);
	always_comb begin
		map_121_TEM22_o[31:0] = 32'h0;
		map_121_TEM22_o[13:13] = map_121_TEM22__FIELD_3__curr_value;
		map_121_TEM22_o[16:14] = map_121_TEM22__FIELD_2__curr_value;
		map_121_TEM22_o[17:17] = map_121_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[25] = map_121_TEM22_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_121_TEM21_alias//
	//REG HIERARCHY: ['map_12[1]', 'TEM21_alias']//
	//REG ABSOLUTE_ADDR:64'h820//
	//REG OFFSET_ADDR:64'h10c//
	logic [31:0] map_121_TEM21_alias_o;
	assign map_121_TEM21_alias_wr_data = wr_sel[26] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_121_TEM21_alias_wr_en = wr_sel[26];
	assign map_121_TEM21_alias_rd_en = rd_sel[26];
	always_comb begin
		map_121_TEM21_alias_o[31:0] = 32'h0;
		map_121_TEM21_alias_o[13:13] = map_121_TEM21__FIELD_3__curr_value;
		map_121_TEM21_alias_o[16:14] = map_121_TEM21__FIELD_2__curr_value;
		map_121_TEM21_alias_o[17:17] = map_121_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[26] = map_121_TEM21_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_121_TEM22_alias//
	//REG HIERARCHY: ['map_12[1]', 'TEM22_alias']//
	//REG ABSOLUTE_ADDR:64'h824//
	//REG OFFSET_ADDR:64'h110//
	logic [31:0] map_121_TEM22_alias_o;
	assign map_121_TEM22_alias_wr_data = wr_sel[27] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_121_TEM22_alias_wr_en = wr_sel[27];
	assign map_121_TEM22_alias_rd_en = rd_sel[27];
	always_comb begin
		map_121_TEM22_alias_o[31:0] = 32'h0;
		map_121_TEM22_alias_o[13:13] = map_121_TEM22__FIELD_3__curr_value;
		map_121_TEM22_alias_o[16:14] = map_121_TEM22__FIELD_2__curr_value;
		map_121_TEM22_alias_o[17:17] = map_121_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[27] = map_121_TEM22_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_122_TEM21//
	//REG HIERARCHY: ['map_12[2]', 'TEM21']//
	//REG ABSOLUTE_ADDR:64'h834//
	//REG OFFSET_ADDR:64'hc//
	logic [31:0] map_122_TEM21_o;
	assign map_122_TEM21_wr_data = wr_sel[28] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_122_TEM21_wr_en = wr_sel[28];
	assign map_122_TEM21_rd_en = rd_sel[28];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_122_TEM21__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_122_TEM21_wr_data[13:13],map_122_TEM21_alias_wr_data[13:13]}),
		.sw_rd                 ({map_122_TEM21_rd_en,map_122_TEM21_alias_rd_en}),
		.sw_wr                 ({map_122_TEM21_wr_en,map_122_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_122_TEM21__FIELD_3__next_value),
		.hw_pulse              (map_122_TEM21__FIELD_3__pulse),
		.field_value           (map_122_TEM21__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_122_TEM21__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_122_TEM21_wr_data[16:14],map_122_TEM21_alias_wr_data[16:14]}),
		.sw_rd                 ({map_122_TEM21_rd_en,map_122_TEM21_alias_rd_en}),
		.sw_wr                 ({map_122_TEM21_wr_en,map_122_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_122_TEM21__FIELD_2__next_value),
		.hw_pulse              (map_122_TEM21__FIELD_2__pulse),
		.field_value           (map_122_TEM21__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_122_TEM21__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_122_TEM21_wr_data[17:17],map_122_TEM21_alias_wr_data[17:17]}),
		.sw_rd                 ({map_122_TEM21_rd_en,map_122_TEM21_alias_rd_en}),
		.sw_wr                 ({map_122_TEM21_wr_en,map_122_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_122_TEM21__FIELD_1__next_value),
		.hw_pulse              (map_122_TEM21__FIELD_1__pulse),
		.field_value           (map_122_TEM21__FIELD_1__curr_value)
		);
	always_comb begin
		map_122_TEM21_o[31:0] = 32'h0;
		map_122_TEM21_o[13:13] = map_122_TEM21__FIELD_3__curr_value;
		map_122_TEM21_o[16:14] = map_122_TEM21__FIELD_2__curr_value;
		map_122_TEM21_o[17:17] = map_122_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[28] = map_122_TEM21_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_122_TEM22//
	//REG HIERARCHY: ['map_12[2]', 'TEM22']//
	//REG ABSOLUTE_ADDR:64'h838//
	//REG OFFSET_ADDR:64'h10//
	logic [31:0] map_122_TEM22_o;
	assign map_122_TEM22_wr_data = wr_sel[29] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_122_TEM22_wr_en = wr_sel[29];
	assign map_122_TEM22_rd_en = rd_sel[29];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_122_TEM22__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_122_TEM22_wr_data[13:13],map_122_TEM22_alias_wr_data[13:13]}),
		.sw_rd                 ({map_122_TEM22_rd_en,map_122_TEM22_alias_rd_en}),
		.sw_wr                 ({map_122_TEM22_wr_en,map_122_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_122_TEM22__FIELD_3__next_value),
		.hw_pulse              (map_122_TEM22__FIELD_3__pulse),
		.field_value           (map_122_TEM22__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_122_TEM22__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_122_TEM22_wr_data[16:14],map_122_TEM22_alias_wr_data[16:14]}),
		.sw_rd                 ({map_122_TEM22_rd_en,map_122_TEM22_alias_rd_en}),
		.sw_wr                 ({map_122_TEM22_wr_en,map_122_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_122_TEM22__FIELD_2__next_value),
		.hw_pulse              (map_122_TEM22__FIELD_2__pulse),
		.field_value           (map_122_TEM22__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_122_TEM22__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_122_TEM22_wr_data[17:17],map_122_TEM22_alias_wr_data[17:17]}),
		.sw_rd                 ({map_122_TEM22_rd_en,map_122_TEM22_alias_rd_en}),
		.sw_wr                 ({map_122_TEM22_wr_en,map_122_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_122_TEM22__FIELD_1__next_value),
		.hw_pulse              (map_122_TEM22__FIELD_1__pulse),
		.field_value           (map_122_TEM22__FIELD_1__curr_value)
		);
	always_comb begin
		map_122_TEM22_o[31:0] = 32'h0;
		map_122_TEM22_o[13:13] = map_122_TEM22__FIELD_3__curr_value;
		map_122_TEM22_o[16:14] = map_122_TEM22__FIELD_2__curr_value;
		map_122_TEM22_o[17:17] = map_122_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[29] = map_122_TEM22_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_122_TEM21_alias//
	//REG HIERARCHY: ['map_12[2]', 'TEM21_alias']//
	//REG ABSOLUTE_ADDR:64'h934//
	//REG OFFSET_ADDR:64'h10c//
	logic [31:0] map_122_TEM21_alias_o;
	assign map_122_TEM21_alias_wr_data = wr_sel[30] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_122_TEM21_alias_wr_en = wr_sel[30];
	assign map_122_TEM21_alias_rd_en = rd_sel[30];
	always_comb begin
		map_122_TEM21_alias_o[31:0] = 32'h0;
		map_122_TEM21_alias_o[13:13] = map_122_TEM21__FIELD_3__curr_value;
		map_122_TEM21_alias_o[16:14] = map_122_TEM21__FIELD_2__curr_value;
		map_122_TEM21_alias_o[17:17] = map_122_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[30] = map_122_TEM21_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_122_TEM22_alias//
	//REG HIERARCHY: ['map_12[2]', 'TEM22_alias']//
	//REG ABSOLUTE_ADDR:64'h938//
	//REG OFFSET_ADDR:64'h110//
	logic [31:0] map_122_TEM22_alias_o;
	assign map_122_TEM22_alias_wr_data = wr_sel[31] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_122_TEM22_alias_wr_en = wr_sel[31];
	assign map_122_TEM22_alias_rd_en = rd_sel[31];
	always_comb begin
		map_122_TEM22_alias_o[31:0] = 32'h0;
		map_122_TEM22_alias_o[13:13] = map_122_TEM22__FIELD_3__curr_value;
		map_122_TEM22_alias_o[16:14] = map_122_TEM22__FIELD_2__curr_value;
		map_122_TEM22_alias_o[17:17] = map_122_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[31] = map_122_TEM22_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_123_TEM21//
	//REG HIERARCHY: ['map_12[3]', 'TEM21']//
	//REG ABSOLUTE_ADDR:64'h948//
	//REG OFFSET_ADDR:64'hc//
	logic [31:0] map_123_TEM21_o;
	assign map_123_TEM21_wr_data = wr_sel[32] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_123_TEM21_wr_en = wr_sel[32];
	assign map_123_TEM21_rd_en = rd_sel[32];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_123_TEM21__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_123_TEM21_wr_data[13:13],map_123_TEM21_alias_wr_data[13:13]}),
		.sw_rd                 ({map_123_TEM21_rd_en,map_123_TEM21_alias_rd_en}),
		.sw_wr                 ({map_123_TEM21_wr_en,map_123_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_123_TEM21__FIELD_3__next_value),
		.hw_pulse              (map_123_TEM21__FIELD_3__pulse),
		.field_value           (map_123_TEM21__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_123_TEM21__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_123_TEM21_wr_data[16:14],map_123_TEM21_alias_wr_data[16:14]}),
		.sw_rd                 ({map_123_TEM21_rd_en,map_123_TEM21_alias_rd_en}),
		.sw_wr                 ({map_123_TEM21_wr_en,map_123_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_123_TEM21__FIELD_2__next_value),
		.hw_pulse              (map_123_TEM21__FIELD_2__pulse),
		.field_value           (map_123_TEM21__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_123_TEM21__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_123_TEM21_wr_data[17:17],map_123_TEM21_alias_wr_data[17:17]}),
		.sw_rd                 ({map_123_TEM21_rd_en,map_123_TEM21_alias_rd_en}),
		.sw_wr                 ({map_123_TEM21_wr_en,map_123_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_123_TEM21__FIELD_1__next_value),
		.hw_pulse              (map_123_TEM21__FIELD_1__pulse),
		.field_value           (map_123_TEM21__FIELD_1__curr_value)
		);
	always_comb begin
		map_123_TEM21_o[31:0] = 32'h0;
		map_123_TEM21_o[13:13] = map_123_TEM21__FIELD_3__curr_value;
		map_123_TEM21_o[16:14] = map_123_TEM21__FIELD_2__curr_value;
		map_123_TEM21_o[17:17] = map_123_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[32] = map_123_TEM21_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_123_TEM22//
	//REG HIERARCHY: ['map_12[3]', 'TEM22']//
	//REG ABSOLUTE_ADDR:64'h94c//
	//REG OFFSET_ADDR:64'h10//
	logic [31:0] map_123_TEM22_o;
	assign map_123_TEM22_wr_data = wr_sel[33] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_123_TEM22_wr_en = wr_sel[33];
	assign map_123_TEM22_rd_en = rd_sel[33];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_123_TEM22__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_123_TEM22_wr_data[13:13],map_123_TEM22_alias_wr_data[13:13]}),
		.sw_rd                 ({map_123_TEM22_rd_en,map_123_TEM22_alias_rd_en}),
		.sw_wr                 ({map_123_TEM22_wr_en,map_123_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_123_TEM22__FIELD_3__next_value),
		.hw_pulse              (map_123_TEM22__FIELD_3__pulse),
		.field_value           (map_123_TEM22__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_123_TEM22__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_123_TEM22_wr_data[16:14],map_123_TEM22_alias_wr_data[16:14]}),
		.sw_rd                 ({map_123_TEM22_rd_en,map_123_TEM22_alias_rd_en}),
		.sw_wr                 ({map_123_TEM22_wr_en,map_123_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_123_TEM22__FIELD_2__next_value),
		.hw_pulse              (map_123_TEM22__FIELD_2__pulse),
		.field_value           (map_123_TEM22__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_123_TEM22__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_123_TEM22_wr_data[17:17],map_123_TEM22_alias_wr_data[17:17]}),
		.sw_rd                 ({map_123_TEM22_rd_en,map_123_TEM22_alias_rd_en}),
		.sw_wr                 ({map_123_TEM22_wr_en,map_123_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_123_TEM22__FIELD_1__next_value),
		.hw_pulse              (map_123_TEM22__FIELD_1__pulse),
		.field_value           (map_123_TEM22__FIELD_1__curr_value)
		);
	always_comb begin
		map_123_TEM22_o[31:0] = 32'h0;
		map_123_TEM22_o[13:13] = map_123_TEM22__FIELD_3__curr_value;
		map_123_TEM22_o[16:14] = map_123_TEM22__FIELD_2__curr_value;
		map_123_TEM22_o[17:17] = map_123_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[33] = map_123_TEM22_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_123_TEM21_alias//
	//REG HIERARCHY: ['map_12[3]', 'TEM21_alias']//
	//REG ABSOLUTE_ADDR:64'ha48//
	//REG OFFSET_ADDR:64'h10c//
	logic [31:0] map_123_TEM21_alias_o;
	assign map_123_TEM21_alias_wr_data = wr_sel[34] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_123_TEM21_alias_wr_en = wr_sel[34];
	assign map_123_TEM21_alias_rd_en = rd_sel[34];
	always_comb begin
		map_123_TEM21_alias_o[31:0] = 32'h0;
		map_123_TEM21_alias_o[13:13] = map_123_TEM21__FIELD_3__curr_value;
		map_123_TEM21_alias_o[16:14] = map_123_TEM21__FIELD_2__curr_value;
		map_123_TEM21_alias_o[17:17] = map_123_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[34] = map_123_TEM21_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_123_TEM22_alias//
	//REG HIERARCHY: ['map_12[3]', 'TEM22_alias']//
	//REG ABSOLUTE_ADDR:64'ha4c//
	//REG OFFSET_ADDR:64'h110//
	logic [31:0] map_123_TEM22_alias_o;
	assign map_123_TEM22_alias_wr_data = wr_sel[35] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_123_TEM22_alias_wr_en = wr_sel[35];
	assign map_123_TEM22_alias_rd_en = rd_sel[35];
	always_comb begin
		map_123_TEM22_alias_o[31:0] = 32'h0;
		map_123_TEM22_alias_o[13:13] = map_123_TEM22__FIELD_3__curr_value;
		map_123_TEM22_alias_o[16:14] = map_123_TEM22__FIELD_2__curr_value;
		map_123_TEM22_alias_o[17:17] = map_123_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[35] = map_123_TEM22_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_124_TEM21//
	//REG HIERARCHY: ['map_12[4]', 'TEM21']//
	//REG ABSOLUTE_ADDR:64'ha5c//
	//REG OFFSET_ADDR:64'hc//
	logic [31:0] map_124_TEM21_o;
	assign map_124_TEM21_wr_data = wr_sel[36] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_124_TEM21_wr_en = wr_sel[36];
	assign map_124_TEM21_rd_en = rd_sel[36];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_124_TEM21__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_124_TEM21_wr_data[13:13],map_124_TEM21_alias_wr_data[13:13]}),
		.sw_rd                 ({map_124_TEM21_rd_en,map_124_TEM21_alias_rd_en}),
		.sw_wr                 ({map_124_TEM21_wr_en,map_124_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_124_TEM21__FIELD_3__next_value),
		.hw_pulse              (map_124_TEM21__FIELD_3__pulse),
		.field_value           (map_124_TEM21__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_124_TEM21__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_124_TEM21_wr_data[16:14],map_124_TEM21_alias_wr_data[16:14]}),
		.sw_rd                 ({map_124_TEM21_rd_en,map_124_TEM21_alias_rd_en}),
		.sw_wr                 ({map_124_TEM21_wr_en,map_124_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_124_TEM21__FIELD_2__next_value),
		.hw_pulse              (map_124_TEM21__FIELD_2__pulse),
		.field_value           (map_124_TEM21__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_124_TEM21__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_124_TEM21_wr_data[17:17],map_124_TEM21_alias_wr_data[17:17]}),
		.sw_rd                 ({map_124_TEM21_rd_en,map_124_TEM21_alias_rd_en}),
		.sw_wr                 ({map_124_TEM21_wr_en,map_124_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_124_TEM21__FIELD_1__next_value),
		.hw_pulse              (map_124_TEM21__FIELD_1__pulse),
		.field_value           (map_124_TEM21__FIELD_1__curr_value)
		);
	always_comb begin
		map_124_TEM21_o[31:0] = 32'h0;
		map_124_TEM21_o[13:13] = map_124_TEM21__FIELD_3__curr_value;
		map_124_TEM21_o[16:14] = map_124_TEM21__FIELD_2__curr_value;
		map_124_TEM21_o[17:17] = map_124_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[36] = map_124_TEM21_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_124_TEM22//
	//REG HIERARCHY: ['map_12[4]', 'TEM22']//
	//REG ABSOLUTE_ADDR:64'ha60//
	//REG OFFSET_ADDR:64'h10//
	logic [31:0] map_124_TEM22_o;
	assign map_124_TEM22_wr_data = wr_sel[37] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_124_TEM22_wr_en = wr_sel[37];
	assign map_124_TEM22_rd_en = rd_sel[37];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_124_TEM22__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_124_TEM22_wr_data[13:13],map_124_TEM22_alias_wr_data[13:13]}),
		.sw_rd                 ({map_124_TEM22_rd_en,map_124_TEM22_alias_rd_en}),
		.sw_wr                 ({map_124_TEM22_wr_en,map_124_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_124_TEM22__FIELD_3__next_value),
		.hw_pulse              (map_124_TEM22__FIELD_3__pulse),
		.field_value           (map_124_TEM22__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_124_TEM22__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_124_TEM22_wr_data[16:14],map_124_TEM22_alias_wr_data[16:14]}),
		.sw_rd                 ({map_124_TEM22_rd_en,map_124_TEM22_alias_rd_en}),
		.sw_wr                 ({map_124_TEM22_wr_en,map_124_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_124_TEM22__FIELD_2__next_value),
		.hw_pulse              (map_124_TEM22__FIELD_2__pulse),
		.field_value           (map_124_TEM22__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_124_TEM22__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_124_TEM22_wr_data[17:17],map_124_TEM22_alias_wr_data[17:17]}),
		.sw_rd                 ({map_124_TEM22_rd_en,map_124_TEM22_alias_rd_en}),
		.sw_wr                 ({map_124_TEM22_wr_en,map_124_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_124_TEM22__FIELD_1__next_value),
		.hw_pulse              (map_124_TEM22__FIELD_1__pulse),
		.field_value           (map_124_TEM22__FIELD_1__curr_value)
		);
	always_comb begin
		map_124_TEM22_o[31:0] = 32'h0;
		map_124_TEM22_o[13:13] = map_124_TEM22__FIELD_3__curr_value;
		map_124_TEM22_o[16:14] = map_124_TEM22__FIELD_2__curr_value;
		map_124_TEM22_o[17:17] = map_124_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[37] = map_124_TEM22_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_124_TEM21_alias//
	//REG HIERARCHY: ['map_12[4]', 'TEM21_alias']//
	//REG ABSOLUTE_ADDR:64'hb5c//
	//REG OFFSET_ADDR:64'h10c//
	logic [31:0] map_124_TEM21_alias_o;
	assign map_124_TEM21_alias_wr_data = wr_sel[38] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_124_TEM21_alias_wr_en = wr_sel[38];
	assign map_124_TEM21_alias_rd_en = rd_sel[38];
	always_comb begin
		map_124_TEM21_alias_o[31:0] = 32'h0;
		map_124_TEM21_alias_o[13:13] = map_124_TEM21__FIELD_3__curr_value;
		map_124_TEM21_alias_o[16:14] = map_124_TEM21__FIELD_2__curr_value;
		map_124_TEM21_alias_o[17:17] = map_124_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[38] = map_124_TEM21_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_124_TEM22_alias//
	//REG HIERARCHY: ['map_12[4]', 'TEM22_alias']//
	//REG ABSOLUTE_ADDR:64'hb60//
	//REG OFFSET_ADDR:64'h110//
	logic [31:0] map_124_TEM22_alias_o;
	assign map_124_TEM22_alias_wr_data = wr_sel[39] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_124_TEM22_alias_wr_en = wr_sel[39];
	assign map_124_TEM22_alias_rd_en = rd_sel[39];
	always_comb begin
		map_124_TEM22_alias_o[31:0] = 32'h0;
		map_124_TEM22_alias_o[13:13] = map_124_TEM22__FIELD_3__curr_value;
		map_124_TEM22_alias_o[16:14] = map_124_TEM22__FIELD_2__curr_value;
		map_124_TEM22_alias_o[17:17] = map_124_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[39] = map_124_TEM22_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_125_TEM21//
	//REG HIERARCHY: ['map_12[5]', 'TEM21']//
	//REG ABSOLUTE_ADDR:64'hb70//
	//REG OFFSET_ADDR:64'hc//
	logic [31:0] map_125_TEM21_o;
	assign map_125_TEM21_wr_data = wr_sel[40] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_125_TEM21_wr_en = wr_sel[40];
	assign map_125_TEM21_rd_en = rd_sel[40];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_125_TEM21__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_125_TEM21_wr_data[13:13],map_125_TEM21_alias_wr_data[13:13]}),
		.sw_rd                 ({map_125_TEM21_rd_en,map_125_TEM21_alias_rd_en}),
		.sw_wr                 ({map_125_TEM21_wr_en,map_125_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_125_TEM21__FIELD_3__next_value),
		.hw_pulse              (map_125_TEM21__FIELD_3__pulse),
		.field_value           (map_125_TEM21__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_125_TEM21__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_125_TEM21_wr_data[16:14],map_125_TEM21_alias_wr_data[16:14]}),
		.sw_rd                 ({map_125_TEM21_rd_en,map_125_TEM21_alias_rd_en}),
		.sw_wr                 ({map_125_TEM21_wr_en,map_125_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_125_TEM21__FIELD_2__next_value),
		.hw_pulse              (map_125_TEM21__FIELD_2__pulse),
		.field_value           (map_125_TEM21__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_125_TEM21__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_125_TEM21_wr_data[17:17],map_125_TEM21_alias_wr_data[17:17]}),
		.sw_rd                 ({map_125_TEM21_rd_en,map_125_TEM21_alias_rd_en}),
		.sw_wr                 ({map_125_TEM21_wr_en,map_125_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_125_TEM21__FIELD_1__next_value),
		.hw_pulse              (map_125_TEM21__FIELD_1__pulse),
		.field_value           (map_125_TEM21__FIELD_1__curr_value)
		);
	always_comb begin
		map_125_TEM21_o[31:0] = 32'h0;
		map_125_TEM21_o[13:13] = map_125_TEM21__FIELD_3__curr_value;
		map_125_TEM21_o[16:14] = map_125_TEM21__FIELD_2__curr_value;
		map_125_TEM21_o[17:17] = map_125_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[40] = map_125_TEM21_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_125_TEM22//
	//REG HIERARCHY: ['map_12[5]', 'TEM22']//
	//REG ABSOLUTE_ADDR:64'hb74//
	//REG OFFSET_ADDR:64'h10//
	logic [31:0] map_125_TEM22_o;
	assign map_125_TEM22_wr_data = wr_sel[41] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_125_TEM22_wr_en = wr_sel[41];
	assign map_125_TEM22_rd_en = rd_sel[41];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_125_TEM22__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_125_TEM22_wr_data[13:13],map_125_TEM22_alias_wr_data[13:13]}),
		.sw_rd                 ({map_125_TEM22_rd_en,map_125_TEM22_alias_rd_en}),
		.sw_wr                 ({map_125_TEM22_wr_en,map_125_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_125_TEM22__FIELD_3__next_value),
		.hw_pulse              (map_125_TEM22__FIELD_3__pulse),
		.field_value           (map_125_TEM22__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_125_TEM22__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_125_TEM22_wr_data[16:14],map_125_TEM22_alias_wr_data[16:14]}),
		.sw_rd                 ({map_125_TEM22_rd_en,map_125_TEM22_alias_rd_en}),
		.sw_wr                 ({map_125_TEM22_wr_en,map_125_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_125_TEM22__FIELD_2__next_value),
		.hw_pulse              (map_125_TEM22__FIELD_2__pulse),
		.field_value           (map_125_TEM22__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_125_TEM22__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_125_TEM22_wr_data[17:17],map_125_TEM22_alias_wr_data[17:17]}),
		.sw_rd                 ({map_125_TEM22_rd_en,map_125_TEM22_alias_rd_en}),
		.sw_wr                 ({map_125_TEM22_wr_en,map_125_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_125_TEM22__FIELD_1__next_value),
		.hw_pulse              (map_125_TEM22__FIELD_1__pulse),
		.field_value           (map_125_TEM22__FIELD_1__curr_value)
		);
	always_comb begin
		map_125_TEM22_o[31:0] = 32'h0;
		map_125_TEM22_o[13:13] = map_125_TEM22__FIELD_3__curr_value;
		map_125_TEM22_o[16:14] = map_125_TEM22__FIELD_2__curr_value;
		map_125_TEM22_o[17:17] = map_125_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[41] = map_125_TEM22_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_125_TEM21_alias//
	//REG HIERARCHY: ['map_12[5]', 'TEM21_alias']//
	//REG ABSOLUTE_ADDR:64'hc70//
	//REG OFFSET_ADDR:64'h10c//
	logic [31:0] map_125_TEM21_alias_o;
	assign map_125_TEM21_alias_wr_data = wr_sel[42] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_125_TEM21_alias_wr_en = wr_sel[42];
	assign map_125_TEM21_alias_rd_en = rd_sel[42];
	always_comb begin
		map_125_TEM21_alias_o[31:0] = 32'h0;
		map_125_TEM21_alias_o[13:13] = map_125_TEM21__FIELD_3__curr_value;
		map_125_TEM21_alias_o[16:14] = map_125_TEM21__FIELD_2__curr_value;
		map_125_TEM21_alias_o[17:17] = map_125_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[42] = map_125_TEM21_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_125_TEM22_alias//
	//REG HIERARCHY: ['map_12[5]', 'TEM22_alias']//
	//REG ABSOLUTE_ADDR:64'hc74//
	//REG OFFSET_ADDR:64'h110//
	logic [31:0] map_125_TEM22_alias_o;
	assign map_125_TEM22_alias_wr_data = wr_sel[43] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_125_TEM22_alias_wr_en = wr_sel[43];
	assign map_125_TEM22_alias_rd_en = rd_sel[43];
	always_comb begin
		map_125_TEM22_alias_o[31:0] = 32'h0;
		map_125_TEM22_alias_o[13:13] = map_125_TEM22__FIELD_3__curr_value;
		map_125_TEM22_alias_o[16:14] = map_125_TEM22__FIELD_2__curr_value;
		map_125_TEM22_alias_o[17:17] = map_125_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[43] = map_125_TEM22_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_126_TEM21//
	//REG HIERARCHY: ['map_12[6]', 'TEM21']//
	//REG ABSOLUTE_ADDR:64'hc84//
	//REG OFFSET_ADDR:64'hc//
	logic [31:0] map_126_TEM21_o;
	assign map_126_TEM21_wr_data = wr_sel[44] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_126_TEM21_wr_en = wr_sel[44];
	assign map_126_TEM21_rd_en = rd_sel[44];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_126_TEM21__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_126_TEM21_wr_data[13:13],map_126_TEM21_alias_wr_data[13:13]}),
		.sw_rd                 ({map_126_TEM21_rd_en,map_126_TEM21_alias_rd_en}),
		.sw_wr                 ({map_126_TEM21_wr_en,map_126_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_126_TEM21__FIELD_3__next_value),
		.hw_pulse              (map_126_TEM21__FIELD_3__pulse),
		.field_value           (map_126_TEM21__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_126_TEM21__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_126_TEM21_wr_data[16:14],map_126_TEM21_alias_wr_data[16:14]}),
		.sw_rd                 ({map_126_TEM21_rd_en,map_126_TEM21_alias_rd_en}),
		.sw_wr                 ({map_126_TEM21_wr_en,map_126_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_126_TEM21__FIELD_2__next_value),
		.hw_pulse              (map_126_TEM21__FIELD_2__pulse),
		.field_value           (map_126_TEM21__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_126_TEM21__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_126_TEM21_wr_data[17:17],map_126_TEM21_alias_wr_data[17:17]}),
		.sw_rd                 ({map_126_TEM21_rd_en,map_126_TEM21_alias_rd_en}),
		.sw_wr                 ({map_126_TEM21_wr_en,map_126_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_126_TEM21__FIELD_1__next_value),
		.hw_pulse              (map_126_TEM21__FIELD_1__pulse),
		.field_value           (map_126_TEM21__FIELD_1__curr_value)
		);
	always_comb begin
		map_126_TEM21_o[31:0] = 32'h0;
		map_126_TEM21_o[13:13] = map_126_TEM21__FIELD_3__curr_value;
		map_126_TEM21_o[16:14] = map_126_TEM21__FIELD_2__curr_value;
		map_126_TEM21_o[17:17] = map_126_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[44] = map_126_TEM21_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_126_TEM22//
	//REG HIERARCHY: ['map_12[6]', 'TEM22']//
	//REG ABSOLUTE_ADDR:64'hc88//
	//REG OFFSET_ADDR:64'h10//
	logic [31:0] map_126_TEM22_o;
	assign map_126_TEM22_wr_data = wr_sel[45] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_126_TEM22_wr_en = wr_sel[45];
	assign map_126_TEM22_rd_en = rd_sel[45];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_126_TEM22__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_126_TEM22_wr_data[13:13],map_126_TEM22_alias_wr_data[13:13]}),
		.sw_rd                 ({map_126_TEM22_rd_en,map_126_TEM22_alias_rd_en}),
		.sw_wr                 ({map_126_TEM22_wr_en,map_126_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_126_TEM22__FIELD_3__next_value),
		.hw_pulse              (map_126_TEM22__FIELD_3__pulse),
		.field_value           (map_126_TEM22__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_126_TEM22__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_126_TEM22_wr_data[16:14],map_126_TEM22_alias_wr_data[16:14]}),
		.sw_rd                 ({map_126_TEM22_rd_en,map_126_TEM22_alias_rd_en}),
		.sw_wr                 ({map_126_TEM22_wr_en,map_126_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_126_TEM22__FIELD_2__next_value),
		.hw_pulse              (map_126_TEM22__FIELD_2__pulse),
		.field_value           (map_126_TEM22__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_126_TEM22__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_126_TEM22_wr_data[17:17],map_126_TEM22_alias_wr_data[17:17]}),
		.sw_rd                 ({map_126_TEM22_rd_en,map_126_TEM22_alias_rd_en}),
		.sw_wr                 ({map_126_TEM22_wr_en,map_126_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_126_TEM22__FIELD_1__next_value),
		.hw_pulse              (map_126_TEM22__FIELD_1__pulse),
		.field_value           (map_126_TEM22__FIELD_1__curr_value)
		);
	always_comb begin
		map_126_TEM22_o[31:0] = 32'h0;
		map_126_TEM22_o[13:13] = map_126_TEM22__FIELD_3__curr_value;
		map_126_TEM22_o[16:14] = map_126_TEM22__FIELD_2__curr_value;
		map_126_TEM22_o[17:17] = map_126_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[45] = map_126_TEM22_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_126_TEM21_alias//
	//REG HIERARCHY: ['map_12[6]', 'TEM21_alias']//
	//REG ABSOLUTE_ADDR:64'hd84//
	//REG OFFSET_ADDR:64'h10c//
	logic [31:0] map_126_TEM21_alias_o;
	assign map_126_TEM21_alias_wr_data = wr_sel[46] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_126_TEM21_alias_wr_en = wr_sel[46];
	assign map_126_TEM21_alias_rd_en = rd_sel[46];
	always_comb begin
		map_126_TEM21_alias_o[31:0] = 32'h0;
		map_126_TEM21_alias_o[13:13] = map_126_TEM21__FIELD_3__curr_value;
		map_126_TEM21_alias_o[16:14] = map_126_TEM21__FIELD_2__curr_value;
		map_126_TEM21_alias_o[17:17] = map_126_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[46] = map_126_TEM21_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_126_TEM22_alias//
	//REG HIERARCHY: ['map_12[6]', 'TEM22_alias']//
	//REG ABSOLUTE_ADDR:64'hd88//
	//REG OFFSET_ADDR:64'h110//
	logic [31:0] map_126_TEM22_alias_o;
	assign map_126_TEM22_alias_wr_data = wr_sel[47] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_126_TEM22_alias_wr_en = wr_sel[47];
	assign map_126_TEM22_alias_rd_en = rd_sel[47];
	always_comb begin
		map_126_TEM22_alias_o[31:0] = 32'h0;
		map_126_TEM22_alias_o[13:13] = map_126_TEM22__FIELD_3__curr_value;
		map_126_TEM22_alias_o[16:14] = map_126_TEM22__FIELD_2__curr_value;
		map_126_TEM22_alias_o[17:17] = map_126_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[47] = map_126_TEM22_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_127_TEM21//
	//REG HIERARCHY: ['map_12[7]', 'TEM21']//
	//REG ABSOLUTE_ADDR:64'hd98//
	//REG OFFSET_ADDR:64'hc//
	logic [31:0] map_127_TEM21_o;
	assign map_127_TEM21_wr_data = wr_sel[48] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_127_TEM21_wr_en = wr_sel[48];
	assign map_127_TEM21_rd_en = rd_sel[48];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_127_TEM21__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_127_TEM21_wr_data[13:13],map_127_TEM21_alias_wr_data[13:13]}),
		.sw_rd                 ({map_127_TEM21_rd_en,map_127_TEM21_alias_rd_en}),
		.sw_wr                 ({map_127_TEM21_wr_en,map_127_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_127_TEM21__FIELD_3__next_value),
		.hw_pulse              (map_127_TEM21__FIELD_3__pulse),
		.field_value           (map_127_TEM21__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_127_TEM21__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_127_TEM21_wr_data[16:14],map_127_TEM21_alias_wr_data[16:14]}),
		.sw_rd                 ({map_127_TEM21_rd_en,map_127_TEM21_alias_rd_en}),
		.sw_wr                 ({map_127_TEM21_wr_en,map_127_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_127_TEM21__FIELD_2__next_value),
		.hw_pulse              (map_127_TEM21__FIELD_2__pulse),
		.field_value           (map_127_TEM21__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_127_TEM21__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_127_TEM21_wr_data[17:17],map_127_TEM21_alias_wr_data[17:17]}),
		.sw_rd                 ({map_127_TEM21_rd_en,map_127_TEM21_alias_rd_en}),
		.sw_wr                 ({map_127_TEM21_wr_en,map_127_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_127_TEM21__FIELD_1__next_value),
		.hw_pulse              (map_127_TEM21__FIELD_1__pulse),
		.field_value           (map_127_TEM21__FIELD_1__curr_value)
		);
	always_comb begin
		map_127_TEM21_o[31:0] = 32'h0;
		map_127_TEM21_o[13:13] = map_127_TEM21__FIELD_3__curr_value;
		map_127_TEM21_o[16:14] = map_127_TEM21__FIELD_2__curr_value;
		map_127_TEM21_o[17:17] = map_127_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[48] = map_127_TEM21_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_127_TEM22//
	//REG HIERARCHY: ['map_12[7]', 'TEM22']//
	//REG ABSOLUTE_ADDR:64'hd9c//
	//REG OFFSET_ADDR:64'h10//
	logic [31:0] map_127_TEM22_o;
	assign map_127_TEM22_wr_data = wr_sel[49] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_127_TEM22_wr_en = wr_sel[49];
	assign map_127_TEM22_rd_en = rd_sel[49];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_127_TEM22__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_127_TEM22_wr_data[13:13],map_127_TEM22_alias_wr_data[13:13]}),
		.sw_rd                 ({map_127_TEM22_rd_en,map_127_TEM22_alias_rd_en}),
		.sw_wr                 ({map_127_TEM22_wr_en,map_127_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_127_TEM22__FIELD_3__next_value),
		.hw_pulse              (map_127_TEM22__FIELD_3__pulse),
		.field_value           (map_127_TEM22__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_127_TEM22__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_127_TEM22_wr_data[16:14],map_127_TEM22_alias_wr_data[16:14]}),
		.sw_rd                 ({map_127_TEM22_rd_en,map_127_TEM22_alias_rd_en}),
		.sw_wr                 ({map_127_TEM22_wr_en,map_127_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_127_TEM22__FIELD_2__next_value),
		.hw_pulse              (map_127_TEM22__FIELD_2__pulse),
		.field_value           (map_127_TEM22__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_127_TEM22__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_127_TEM22_wr_data[17:17],map_127_TEM22_alias_wr_data[17:17]}),
		.sw_rd                 ({map_127_TEM22_rd_en,map_127_TEM22_alias_rd_en}),
		.sw_wr                 ({map_127_TEM22_wr_en,map_127_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_127_TEM22__FIELD_1__next_value),
		.hw_pulse              (map_127_TEM22__FIELD_1__pulse),
		.field_value           (map_127_TEM22__FIELD_1__curr_value)
		);
	always_comb begin
		map_127_TEM22_o[31:0] = 32'h0;
		map_127_TEM22_o[13:13] = map_127_TEM22__FIELD_3__curr_value;
		map_127_TEM22_o[16:14] = map_127_TEM22__FIELD_2__curr_value;
		map_127_TEM22_o[17:17] = map_127_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[49] = map_127_TEM22_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_127_TEM21_alias//
	//REG HIERARCHY: ['map_12[7]', 'TEM21_alias']//
	//REG ABSOLUTE_ADDR:64'he98//
	//REG OFFSET_ADDR:64'h10c//
	logic [31:0] map_127_TEM21_alias_o;
	assign map_127_TEM21_alias_wr_data = wr_sel[50] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_127_TEM21_alias_wr_en = wr_sel[50];
	assign map_127_TEM21_alias_rd_en = rd_sel[50];
	always_comb begin
		map_127_TEM21_alias_o[31:0] = 32'h0;
		map_127_TEM21_alias_o[13:13] = map_127_TEM21__FIELD_3__curr_value;
		map_127_TEM21_alias_o[16:14] = map_127_TEM21__FIELD_2__curr_value;
		map_127_TEM21_alias_o[17:17] = map_127_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[50] = map_127_TEM21_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_127_TEM22_alias//
	//REG HIERARCHY: ['map_12[7]', 'TEM22_alias']//
	//REG ABSOLUTE_ADDR:64'he9c//
	//REG OFFSET_ADDR:64'h110//
	logic [31:0] map_127_TEM22_alias_o;
	assign map_127_TEM22_alias_wr_data = wr_sel[51] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_127_TEM22_alias_wr_en = wr_sel[51];
	assign map_127_TEM22_alias_rd_en = rd_sel[51];
	always_comb begin
		map_127_TEM22_alias_o[31:0] = 32'h0;
		map_127_TEM22_alias_o[13:13] = map_127_TEM22__FIELD_3__curr_value;
		map_127_TEM22_alias_o[16:14] = map_127_TEM22__FIELD_2__curr_value;
		map_127_TEM22_alias_o[17:17] = map_127_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[51] = map_127_TEM22_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_128_TEM21//
	//REG HIERARCHY: ['map_12[8]', 'TEM21']//
	//REG ABSOLUTE_ADDR:64'heac//
	//REG OFFSET_ADDR:64'hc//
	logic [31:0] map_128_TEM21_o;
	assign map_128_TEM21_wr_data = wr_sel[52] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_128_TEM21_wr_en = wr_sel[52];
	assign map_128_TEM21_rd_en = rd_sel[52];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_128_TEM21__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_128_TEM21_wr_data[13:13],map_128_TEM21_alias_wr_data[13:13]}),
		.sw_rd                 ({map_128_TEM21_rd_en,map_128_TEM21_alias_rd_en}),
		.sw_wr                 ({map_128_TEM21_wr_en,map_128_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_128_TEM21__FIELD_3__next_value),
		.hw_pulse              (map_128_TEM21__FIELD_3__pulse),
		.field_value           (map_128_TEM21__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_128_TEM21__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_128_TEM21_wr_data[16:14],map_128_TEM21_alias_wr_data[16:14]}),
		.sw_rd                 ({map_128_TEM21_rd_en,map_128_TEM21_alias_rd_en}),
		.sw_wr                 ({map_128_TEM21_wr_en,map_128_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_128_TEM21__FIELD_2__next_value),
		.hw_pulse              (map_128_TEM21__FIELD_2__pulse),
		.field_value           (map_128_TEM21__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_128_TEM21__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_128_TEM21_wr_data[17:17],map_128_TEM21_alias_wr_data[17:17]}),
		.sw_rd                 ({map_128_TEM21_rd_en,map_128_TEM21_alias_rd_en}),
		.sw_wr                 ({map_128_TEM21_wr_en,map_128_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_128_TEM21__FIELD_1__next_value),
		.hw_pulse              (map_128_TEM21__FIELD_1__pulse),
		.field_value           (map_128_TEM21__FIELD_1__curr_value)
		);
	always_comb begin
		map_128_TEM21_o[31:0] = 32'h0;
		map_128_TEM21_o[13:13] = map_128_TEM21__FIELD_3__curr_value;
		map_128_TEM21_o[16:14] = map_128_TEM21__FIELD_2__curr_value;
		map_128_TEM21_o[17:17] = map_128_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[52] = map_128_TEM21_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_128_TEM22//
	//REG HIERARCHY: ['map_12[8]', 'TEM22']//
	//REG ABSOLUTE_ADDR:64'heb0//
	//REG OFFSET_ADDR:64'h10//
	logic [31:0] map_128_TEM22_o;
	assign map_128_TEM22_wr_data = wr_sel[53] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_128_TEM22_wr_en = wr_sel[53];
	assign map_128_TEM22_rd_en = rd_sel[53];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_128_TEM22__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_128_TEM22_wr_data[13:13],map_128_TEM22_alias_wr_data[13:13]}),
		.sw_rd                 ({map_128_TEM22_rd_en,map_128_TEM22_alias_rd_en}),
		.sw_wr                 ({map_128_TEM22_wr_en,map_128_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_128_TEM22__FIELD_3__next_value),
		.hw_pulse              (map_128_TEM22__FIELD_3__pulse),
		.field_value           (map_128_TEM22__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_128_TEM22__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_128_TEM22_wr_data[16:14],map_128_TEM22_alias_wr_data[16:14]}),
		.sw_rd                 ({map_128_TEM22_rd_en,map_128_TEM22_alias_rd_en}),
		.sw_wr                 ({map_128_TEM22_wr_en,map_128_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_128_TEM22__FIELD_2__next_value),
		.hw_pulse              (map_128_TEM22__FIELD_2__pulse),
		.field_value           (map_128_TEM22__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_128_TEM22__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_128_TEM22_wr_data[17:17],map_128_TEM22_alias_wr_data[17:17]}),
		.sw_rd                 ({map_128_TEM22_rd_en,map_128_TEM22_alias_rd_en}),
		.sw_wr                 ({map_128_TEM22_wr_en,map_128_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_128_TEM22__FIELD_1__next_value),
		.hw_pulse              (map_128_TEM22__FIELD_1__pulse),
		.field_value           (map_128_TEM22__FIELD_1__curr_value)
		);
	always_comb begin
		map_128_TEM22_o[31:0] = 32'h0;
		map_128_TEM22_o[13:13] = map_128_TEM22__FIELD_3__curr_value;
		map_128_TEM22_o[16:14] = map_128_TEM22__FIELD_2__curr_value;
		map_128_TEM22_o[17:17] = map_128_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[53] = map_128_TEM22_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_128_TEM21_alias//
	//REG HIERARCHY: ['map_12[8]', 'TEM21_alias']//
	//REG ABSOLUTE_ADDR:64'hfac//
	//REG OFFSET_ADDR:64'h10c//
	logic [31:0] map_128_TEM21_alias_o;
	assign map_128_TEM21_alias_wr_data = wr_sel[54] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_128_TEM21_alias_wr_en = wr_sel[54];
	assign map_128_TEM21_alias_rd_en = rd_sel[54];
	always_comb begin
		map_128_TEM21_alias_o[31:0] = 32'h0;
		map_128_TEM21_alias_o[13:13] = map_128_TEM21__FIELD_3__curr_value;
		map_128_TEM21_alias_o[16:14] = map_128_TEM21__FIELD_2__curr_value;
		map_128_TEM21_alias_o[17:17] = map_128_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[54] = map_128_TEM21_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_128_TEM22_alias//
	//REG HIERARCHY: ['map_12[8]', 'TEM22_alias']//
	//REG ABSOLUTE_ADDR:64'hfb0//
	//REG OFFSET_ADDR:64'h110//
	logic [31:0] map_128_TEM22_alias_o;
	assign map_128_TEM22_alias_wr_data = wr_sel[55] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_128_TEM22_alias_wr_en = wr_sel[55];
	assign map_128_TEM22_alias_rd_en = rd_sel[55];
	always_comb begin
		map_128_TEM22_alias_o[31:0] = 32'h0;
		map_128_TEM22_alias_o[13:13] = map_128_TEM22__FIELD_3__curr_value;
		map_128_TEM22_alias_o[16:14] = map_128_TEM22__FIELD_2__curr_value;
		map_128_TEM22_alias_o[17:17] = map_128_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[55] = map_128_TEM22_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_129_TEM21//
	//REG HIERARCHY: ['map_12[9]', 'TEM21']//
	//REG ABSOLUTE_ADDR:64'hfc0//
	//REG OFFSET_ADDR:64'hc//
	logic [31:0] map_129_TEM21_o;
	assign map_129_TEM21_wr_data = wr_sel[56] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_129_TEM21_wr_en = wr_sel[56];
	assign map_129_TEM21_rd_en = rd_sel[56];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_129_TEM21__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_129_TEM21_wr_data[13:13],map_129_TEM21_alias_wr_data[13:13]}),
		.sw_rd                 ({map_129_TEM21_rd_en,map_129_TEM21_alias_rd_en}),
		.sw_wr                 ({map_129_TEM21_wr_en,map_129_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_129_TEM21__FIELD_3__next_value),
		.hw_pulse              (map_129_TEM21__FIELD_3__pulse),
		.field_value           (map_129_TEM21__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_129_TEM21__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_129_TEM21_wr_data[16:14],map_129_TEM21_alias_wr_data[16:14]}),
		.sw_rd                 ({map_129_TEM21_rd_en,map_129_TEM21_alias_rd_en}),
		.sw_wr                 ({map_129_TEM21_wr_en,map_129_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_129_TEM21__FIELD_2__next_value),
		.hw_pulse              (map_129_TEM21__FIELD_2__pulse),
		.field_value           (map_129_TEM21__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_129_TEM21__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_129_TEM21_wr_data[17:17],map_129_TEM21_alias_wr_data[17:17]}),
		.sw_rd                 ({map_129_TEM21_rd_en,map_129_TEM21_alias_rd_en}),
		.sw_wr                 ({map_129_TEM21_wr_en,map_129_TEM21_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_129_TEM21__FIELD_1__next_value),
		.hw_pulse              (map_129_TEM21__FIELD_1__pulse),
		.field_value           (map_129_TEM21__FIELD_1__curr_value)
		);
	always_comb begin
		map_129_TEM21_o[31:0] = 32'h0;
		map_129_TEM21_o[13:13] = map_129_TEM21__FIELD_3__curr_value;
		map_129_TEM21_o[16:14] = map_129_TEM21__FIELD_2__curr_value;
		map_129_TEM21_o[17:17] = map_129_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[56] = map_129_TEM21_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_129_TEM22//
	//REG HIERARCHY: ['map_12[9]', 'TEM22']//
	//REG ABSOLUTE_ADDR:64'hfc4//
	//REG OFFSET_ADDR:64'h10//
	logic [31:0] map_129_TEM22_o;
	assign map_129_TEM22_wr_data = wr_sel[57] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_129_TEM22_wr_en = wr_sel[57];
	assign map_129_TEM22_rd_en = rd_sel[57];
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h1),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_129_TEM22__FIELD_3
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_129_TEM22_wr_data[13:13],map_129_TEM22_alias_wr_data[13:13]}),
		.sw_rd                 ({map_129_TEM22_rd_en,map_129_TEM22_alias_rd_en}),
		.sw_wr                 ({map_129_TEM22_wr_en,map_129_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_129_TEM22__FIELD_3__next_value),
		.hw_pulse              (map_129_TEM22__FIELD_3__pulse),
		.field_value           (map_129_TEM22__FIELD_3__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (3),
		.ARST_VALUE            (3'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_129_TEM22__FIELD_2
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_129_TEM22_wr_data[16:14],map_129_TEM22_alias_wr_data[16:14]}),
		.sw_rd                 ({map_129_TEM22_rd_en,map_129_TEM22_alias_rd_en}),
		.sw_wr                 ({map_129_TEM22_wr_en,map_129_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_129_TEM22__FIELD_2__next_value),
		.hw_pulse              (map_129_TEM22__FIELD_2__pulse),
		.field_value           (map_129_TEM22__FIELD_2__curr_value)
		);
	field
		//**************PARAMETER INSTANTIATE***************//
		#( 
		.F_WIDTH               (1),
		.ARST_VALUE            (1'h0),
		.ALIAS_NUM             (2),
		.SW_TYPE               ({`SW_RW,`SW_RW}),
		.SW_ONREAD_TYPE        ({`NA,`NA}),
		.SW_ONWRITE_TYPE       ({`NA,`NA}),
		.HW_TYPE               (`HW_RW),
		.PRECEDENCE            (`SW)
		)
	x__map_129_TEM22__FIELD_1
		//*****************PORT INSTANTIATE*****************//
		(
		.clk                   (regslv_clk),
		.rst_n                 (regslv_rst_n),
		.sync_rst                (1'b0),
		.sw_wr_data            ({map_129_TEM22_wr_data[17:17],map_129_TEM22_alias_wr_data[17:17]}),
		.sw_rd                 ({map_129_TEM22_rd_en,map_129_TEM22_alias_rd_en}),
		.sw_wr                 ({map_129_TEM22_wr_en,map_129_TEM22_alias_wr_en}),
		.write_protect_en      (1'b0),
		.sw_type_alter_signal  (1'b0),
		.swmod_out(),
		.swacc_out(),
		.hw_value              (map_129_TEM22__FIELD_1__next_value),
		.hw_pulse              (map_129_TEM22__FIELD_1__pulse),
		.field_value           (map_129_TEM22__FIELD_1__curr_value)
		);
	always_comb begin
		map_129_TEM22_o[31:0] = 32'h0;
		map_129_TEM22_o[13:13] = map_129_TEM22__FIELD_3__curr_value;
		map_129_TEM22_o[16:14] = map_129_TEM22__FIELD_2__curr_value;
		map_129_TEM22_o[17:17] = map_129_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[57] = map_129_TEM22_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_129_TEM21_alias//
	//REG HIERARCHY: ['map_12[9]', 'TEM21_alias']//
	//REG ABSOLUTE_ADDR:64'h10c0//
	//REG OFFSET_ADDR:64'h10c//
	logic [31:0] map_129_TEM21_alias_o;
	assign map_129_TEM21_alias_wr_data = wr_sel[58] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_129_TEM21_alias_wr_en = wr_sel[58];
	assign map_129_TEM21_alias_rd_en = rd_sel[58];
	always_comb begin
		map_129_TEM21_alias_o[31:0] = 32'h0;
		map_129_TEM21_alias_o[13:13] = map_129_TEM21__FIELD_3__curr_value;
		map_129_TEM21_alias_o[16:14] = map_129_TEM21__FIELD_2__curr_value;
		map_129_TEM21_alias_o[17:17] = map_129_TEM21__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[58] = map_129_TEM21_alias_o;
	//============================================REG INSTANT=============================================//
	//REG NAME: map_129_TEM22_alias//
	//REG HIERARCHY: ['map_12[9]', 'TEM22_alias']//
	//REG ABSOLUTE_ADDR:64'h10c4//
	//REG OFFSET_ADDR:64'h110//
	logic [31:0] map_129_TEM22_alias_o;
	assign map_129_TEM22_alias_wr_data = wr_sel[59] ? regfile_wr_data : {DATA_WIDTH{1'b0}};
	assign map_129_TEM22_alias_wr_en = wr_sel[59];
	assign map_129_TEM22_alias_rd_en = rd_sel[59];
	always_comb begin
		map_129_TEM22_alias_o[31:0] = 32'h0;
		map_129_TEM22_alias_o[13:13] = map_129_TEM22__FIELD_3__curr_value;
		map_129_TEM22_alias_o[16:14] = map_129_TEM22__FIELD_2__curr_value;
		map_129_TEM22_alias_o[17:17] = map_129_TEM22__FIELD_1__curr_value;
	end
	assign regfile_reg_rd_data_in[59] = map_129_TEM22_alias_o;
//***************************************REG/FIELD INSTANCE END***************************************//


//**************************************REG/FIELD INSTANCE START**************************************//
//***************************************REG/FIELD INSTANCE END***************************************//


endmodule
`default_nettype wire