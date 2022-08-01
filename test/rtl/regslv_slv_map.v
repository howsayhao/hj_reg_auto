`include "field_attr.vh"
`default_nettype none

module regslv_slv_map (
    map_11_0_TEM21__FIELD_3__curr_value,
    map_11_0_TEM21__FIELD_3__pulse,
    map_11_0_TEM21__FIELD_3__next_value,
    map_11_0_TEM21__FIELD_3__swacc,
    map_11_0_TEM21__FIELD_3__swmod,
    map_11_0_TEM21__FIELD_2__curr_value,
    map_11_0_TEM21__FIELD_2__pulse,
    map_11_0_TEM21__FIELD_2__next_value,
    map_11_0_TEM21__FIELD_1__curr_value,
    map_11_0_TEM21__FIELD_1__pulse,
    map_11_0_TEM21__FIELD_1__next_value,
    map_11_0_TEM22__FIELD_3__curr_value,
    map_11_0_TEM22__FIELD_3__pulse,
    map_11_0_TEM22__FIELD_3__next_value,
    map_11_0_TEM22__FIELD_2__curr_value,
    map_11_0_TEM22__FIELD_2__pulse,
    map_11_0_TEM22__FIELD_2__next_value,
    map_11_0_TEM22__FIELD_1__curr_value,
    map_11_0_TEM22__FIELD_1__pulse,
    map_11_0_TEM22__FIELD_1__next_value,
    map_11_1_TEM21__FIELD_3__curr_value,
    map_11_1_TEM21__FIELD_3__pulse,
    map_11_1_TEM21__FIELD_3__next_value,
    map_11_1_TEM21__FIELD_3__swacc,
    map_11_1_TEM21__FIELD_3__swmod,
    map_11_1_TEM21__FIELD_2__curr_value,
    map_11_1_TEM21__FIELD_2__pulse,
    map_11_1_TEM21__FIELD_2__next_value,
    map_11_1_TEM21__FIELD_1__curr_value,
    map_11_1_TEM21__FIELD_1__pulse,
    map_11_1_TEM21__FIELD_1__next_value,
    map_11_1_TEM22__FIELD_3__curr_value,
    map_11_1_TEM22__FIELD_3__pulse,
    map_11_1_TEM22__FIELD_3__next_value,
    map_11_1_TEM22__FIELD_2__curr_value,
    map_11_1_TEM22__FIELD_2__pulse,
    map_11_1_TEM22__FIELD_2__next_value,
    map_11_1_TEM22__FIELD_1__curr_value,
    map_11_1_TEM22__FIELD_1__pulse,
    map_11_1_TEM22__FIELD_1__next_value,
    map_11_2_TEM21__FIELD_3__curr_value,
    map_11_2_TEM21__FIELD_3__pulse,
    map_11_2_TEM21__FIELD_3__next_value,
    map_11_2_TEM21__FIELD_3__swacc,
    map_11_2_TEM21__FIELD_3__swmod,
    map_11_2_TEM21__FIELD_2__curr_value,
    map_11_2_TEM21__FIELD_2__pulse,
    map_11_2_TEM21__FIELD_2__next_value,
    map_11_2_TEM21__FIELD_1__curr_value,
    map_11_2_TEM21__FIELD_1__pulse,
    map_11_2_TEM21__FIELD_1__next_value,
    map_11_2_TEM22__FIELD_3__curr_value,
    map_11_2_TEM22__FIELD_3__pulse,
    map_11_2_TEM22__FIELD_3__next_value,
    map_11_2_TEM22__FIELD_2__curr_value,
    map_11_2_TEM22__FIELD_2__pulse,
    map_11_2_TEM22__FIELD_2__next_value,
    map_11_2_TEM22__FIELD_1__curr_value,
    map_11_2_TEM22__FIELD_1__pulse,
    map_11_2_TEM22__FIELD_1__next_value,
    map_11_3_TEM21__FIELD_3__curr_value,
    map_11_3_TEM21__FIELD_3__pulse,
    map_11_3_TEM21__FIELD_3__next_value,
    map_11_3_TEM21__FIELD_3__swacc,
    map_11_3_TEM21__FIELD_3__swmod,
    map_11_3_TEM21__FIELD_2__curr_value,
    map_11_3_TEM21__FIELD_2__pulse,
    map_11_3_TEM21__FIELD_2__next_value,
    map_11_3_TEM21__FIELD_1__curr_value,
    map_11_3_TEM21__FIELD_1__pulse,
    map_11_3_TEM21__FIELD_1__next_value,
    map_11_3_TEM22__FIELD_3__curr_value,
    map_11_3_TEM22__FIELD_3__pulse,
    map_11_3_TEM22__FIELD_3__next_value,
    map_11_3_TEM22__FIELD_2__curr_value,
    map_11_3_TEM22__FIELD_2__pulse,
    map_11_3_TEM22__FIELD_2__next_value,
    map_11_3_TEM22__FIELD_1__curr_value,
    map_11_3_TEM22__FIELD_1__pulse,
    map_11_3_TEM22__FIELD_1__next_value,
    map_11_4_TEM21__FIELD_3__curr_value,
    map_11_4_TEM21__FIELD_3__pulse,
    map_11_4_TEM21__FIELD_3__next_value,
    map_11_4_TEM21__FIELD_3__swacc,
    map_11_4_TEM21__FIELD_3__swmod,
    map_11_4_TEM21__FIELD_2__curr_value,
    map_11_4_TEM21__FIELD_2__pulse,
    map_11_4_TEM21__FIELD_2__next_value,
    map_11_4_TEM21__FIELD_1__curr_value,
    map_11_4_TEM21__FIELD_1__pulse,
    map_11_4_TEM21__FIELD_1__next_value,
    map_11_4_TEM22__FIELD_3__curr_value,
    map_11_4_TEM22__FIELD_3__pulse,
    map_11_4_TEM22__FIELD_3__next_value,
    map_11_4_TEM22__FIELD_2__curr_value,
    map_11_4_TEM22__FIELD_2__pulse,
    map_11_4_TEM22__FIELD_2__next_value,
    map_11_4_TEM22__FIELD_1__curr_value,
    map_11_4_TEM22__FIELD_1__pulse,
    map_11_4_TEM22__FIELD_1__next_value,
    map_12_0_TEM21__FIELD_3__curr_value,
    map_12_0_TEM21__FIELD_3__pulse,
    map_12_0_TEM21__FIELD_3__next_value,
    map_12_0_TEM21__FIELD_3__swacc,
    map_12_0_TEM21__FIELD_3__swmod,
    map_12_0_TEM21__FIELD_2__curr_value,
    map_12_0_TEM21__FIELD_2__pulse,
    map_12_0_TEM21__FIELD_2__next_value,
    map_12_0_TEM21__FIELD_1__curr_value,
    map_12_0_TEM21__FIELD_1__pulse,
    map_12_0_TEM21__FIELD_1__next_value,
    map_12_0_TEM22__FIELD_3__curr_value,
    map_12_0_TEM22__FIELD_3__pulse,
    map_12_0_TEM22__FIELD_3__next_value,
    map_12_0_TEM22__FIELD_2__curr_value,
    map_12_0_TEM22__FIELD_2__pulse,
    map_12_0_TEM22__FIELD_2__next_value,
    map_12_0_TEM22__FIELD_1__curr_value,
    map_12_0_TEM22__FIELD_1__pulse,
    map_12_0_TEM22__FIELD_1__next_value,
    map_12_1_TEM21__FIELD_3__curr_value,
    map_12_1_TEM21__FIELD_3__pulse,
    map_12_1_TEM21__FIELD_3__next_value,
    map_12_1_TEM21__FIELD_3__swacc,
    map_12_1_TEM21__FIELD_3__swmod,
    map_12_1_TEM21__FIELD_2__curr_value,
    map_12_1_TEM21__FIELD_2__pulse,
    map_12_1_TEM21__FIELD_2__next_value,
    map_12_1_TEM21__FIELD_1__curr_value,
    map_12_1_TEM21__FIELD_1__pulse,
    map_12_1_TEM21__FIELD_1__next_value,
    map_12_1_TEM22__FIELD_3__curr_value,
    map_12_1_TEM22__FIELD_3__pulse,
    map_12_1_TEM22__FIELD_3__next_value,
    map_12_1_TEM22__FIELD_2__curr_value,
    map_12_1_TEM22__FIELD_2__pulse,
    map_12_1_TEM22__FIELD_2__next_value,
    map_12_1_TEM22__FIELD_1__curr_value,
    map_12_1_TEM22__FIELD_1__pulse,
    map_12_1_TEM22__FIELD_1__next_value,
    map_12_2_TEM21__FIELD_3__curr_value,
    map_12_2_TEM21__FIELD_3__pulse,
    map_12_2_TEM21__FIELD_3__next_value,
    map_12_2_TEM21__FIELD_3__swacc,
    map_12_2_TEM21__FIELD_3__swmod,
    map_12_2_TEM21__FIELD_2__curr_value,
    map_12_2_TEM21__FIELD_2__pulse,
    map_12_2_TEM21__FIELD_2__next_value,
    map_12_2_TEM21__FIELD_1__curr_value,
    map_12_2_TEM21__FIELD_1__pulse,
    map_12_2_TEM21__FIELD_1__next_value,
    map_12_2_TEM22__FIELD_3__curr_value,
    map_12_2_TEM22__FIELD_3__pulse,
    map_12_2_TEM22__FIELD_3__next_value,
    map_12_2_TEM22__FIELD_2__curr_value,
    map_12_2_TEM22__FIELD_2__pulse,
    map_12_2_TEM22__FIELD_2__next_value,
    map_12_2_TEM22__FIELD_1__curr_value,
    map_12_2_TEM22__FIELD_1__pulse,
    map_12_2_TEM22__FIELD_1__next_value,
    map_12_3_TEM21__FIELD_3__curr_value,
    map_12_3_TEM21__FIELD_3__pulse,
    map_12_3_TEM21__FIELD_3__next_value,
    map_12_3_TEM21__FIELD_3__swacc,
    map_12_3_TEM21__FIELD_3__swmod,
    map_12_3_TEM21__FIELD_2__curr_value,
    map_12_3_TEM21__FIELD_2__pulse,
    map_12_3_TEM21__FIELD_2__next_value,
    map_12_3_TEM21__FIELD_1__curr_value,
    map_12_3_TEM21__FIELD_1__pulse,
    map_12_3_TEM21__FIELD_1__next_value,
    map_12_3_TEM22__FIELD_3__curr_value,
    map_12_3_TEM22__FIELD_3__pulse,
    map_12_3_TEM22__FIELD_3__next_value,
    map_12_3_TEM22__FIELD_2__curr_value,
    map_12_3_TEM22__FIELD_2__pulse,
    map_12_3_TEM22__FIELD_2__next_value,
    map_12_3_TEM22__FIELD_1__curr_value,
    map_12_3_TEM22__FIELD_1__pulse,
    map_12_3_TEM22__FIELD_1__next_value,
    map_12_4_TEM21__FIELD_3__curr_value,
    map_12_4_TEM21__FIELD_3__pulse,
    map_12_4_TEM21__FIELD_3__next_value,
    map_12_4_TEM21__FIELD_3__swacc,
    map_12_4_TEM21__FIELD_3__swmod,
    map_12_4_TEM21__FIELD_2__curr_value,
    map_12_4_TEM21__FIELD_2__pulse,
    map_12_4_TEM21__FIELD_2__next_value,
    map_12_4_TEM21__FIELD_1__curr_value,
    map_12_4_TEM21__FIELD_1__pulse,
    map_12_4_TEM21__FIELD_1__next_value,
    map_12_4_TEM22__FIELD_3__curr_value,
    map_12_4_TEM22__FIELD_3__pulse,
    map_12_4_TEM22__FIELD_3__next_value,
    map_12_4_TEM22__FIELD_2__curr_value,
    map_12_4_TEM22__FIELD_2__pulse,
    map_12_4_TEM22__FIELD_2__next_value,
    map_12_4_TEM22__FIELD_1__curr_value,
    map_12_4_TEM22__FIELD_1__pulse,
    map_12_4_TEM22__FIELD_1__next_value,
    map_12_5_TEM21__FIELD_3__curr_value,
    map_12_5_TEM21__FIELD_3__pulse,
    map_12_5_TEM21__FIELD_3__next_value,
    map_12_5_TEM21__FIELD_3__swacc,
    map_12_5_TEM21__FIELD_3__swmod,
    map_12_5_TEM21__FIELD_2__curr_value,
    map_12_5_TEM21__FIELD_2__pulse,
    map_12_5_TEM21__FIELD_2__next_value,
    map_12_5_TEM21__FIELD_1__curr_value,
    map_12_5_TEM21__FIELD_1__pulse,
    map_12_5_TEM21__FIELD_1__next_value,
    map_12_5_TEM22__FIELD_3__curr_value,
    map_12_5_TEM22__FIELD_3__pulse,
    map_12_5_TEM22__FIELD_3__next_value,
    map_12_5_TEM22__FIELD_2__curr_value,
    map_12_5_TEM22__FIELD_2__pulse,
    map_12_5_TEM22__FIELD_2__next_value,
    map_12_5_TEM22__FIELD_1__curr_value,
    map_12_5_TEM22__FIELD_1__pulse,
    map_12_5_TEM22__FIELD_1__next_value,
    map_12_6_TEM21__FIELD_3__curr_value,
    map_12_6_TEM21__FIELD_3__pulse,
    map_12_6_TEM21__FIELD_3__next_value,
    map_12_6_TEM21__FIELD_3__swacc,
    map_12_6_TEM21__FIELD_3__swmod,
    map_12_6_TEM21__FIELD_2__curr_value,
    map_12_6_TEM21__FIELD_2__pulse,
    map_12_6_TEM21__FIELD_2__next_value,
    map_12_6_TEM21__FIELD_1__curr_value,
    map_12_6_TEM21__FIELD_1__pulse,
    map_12_6_TEM21__FIELD_1__next_value,
    map_12_6_TEM22__FIELD_3__curr_value,
    map_12_6_TEM22__FIELD_3__pulse,
    map_12_6_TEM22__FIELD_3__next_value,
    map_12_6_TEM22__FIELD_2__curr_value,
    map_12_6_TEM22__FIELD_2__pulse,
    map_12_6_TEM22__FIELD_2__next_value,
    map_12_6_TEM22__FIELD_1__curr_value,
    map_12_6_TEM22__FIELD_1__pulse,
    map_12_6_TEM22__FIELD_1__next_value,
    map_12_7_TEM21__FIELD_3__curr_value,
    map_12_7_TEM21__FIELD_3__pulse,
    map_12_7_TEM21__FIELD_3__next_value,
    map_12_7_TEM21__FIELD_3__swacc,
    map_12_7_TEM21__FIELD_3__swmod,
    map_12_7_TEM21__FIELD_2__curr_value,
    map_12_7_TEM21__FIELD_2__pulse,
    map_12_7_TEM21__FIELD_2__next_value,
    map_12_7_TEM21__FIELD_1__curr_value,
    map_12_7_TEM21__FIELD_1__pulse,
    map_12_7_TEM21__FIELD_1__next_value,
    map_12_7_TEM22__FIELD_3__curr_value,
    map_12_7_TEM22__FIELD_3__pulse,
    map_12_7_TEM22__FIELD_3__next_value,
    map_12_7_TEM22__FIELD_2__curr_value,
    map_12_7_TEM22__FIELD_2__pulse,
    map_12_7_TEM22__FIELD_2__next_value,
    map_12_7_TEM22__FIELD_1__curr_value,
    map_12_7_TEM22__FIELD_1__pulse,
    map_12_7_TEM22__FIELD_1__next_value,
    map_12_8_TEM21__FIELD_3__curr_value,
    map_12_8_TEM21__FIELD_3__pulse,
    map_12_8_TEM21__FIELD_3__next_value,
    map_12_8_TEM21__FIELD_3__swacc,
    map_12_8_TEM21__FIELD_3__swmod,
    map_12_8_TEM21__FIELD_2__curr_value,
    map_12_8_TEM21__FIELD_2__pulse,
    map_12_8_TEM21__FIELD_2__next_value,
    map_12_8_TEM21__FIELD_1__curr_value,
    map_12_8_TEM21__FIELD_1__pulse,
    map_12_8_TEM21__FIELD_1__next_value,
    map_12_8_TEM22__FIELD_3__curr_value,
    map_12_8_TEM22__FIELD_3__pulse,
    map_12_8_TEM22__FIELD_3__next_value,
    map_12_8_TEM22__FIELD_2__curr_value,
    map_12_8_TEM22__FIELD_2__pulse,
    map_12_8_TEM22__FIELD_2__next_value,
    map_12_8_TEM22__FIELD_1__curr_value,
    map_12_8_TEM22__FIELD_1__pulse,
    map_12_8_TEM22__FIELD_1__next_value,
    map_12_9_TEM21__FIELD_3__curr_value,
    map_12_9_TEM21__FIELD_3__pulse,
    map_12_9_TEM21__FIELD_3__next_value,
    map_12_9_TEM21__FIELD_3__swacc,
    map_12_9_TEM21__FIELD_3__swmod,
    map_12_9_TEM21__FIELD_2__curr_value,
    map_12_9_TEM21__FIELD_2__pulse,
    map_12_9_TEM21__FIELD_2__next_value,
    map_12_9_TEM21__FIELD_1__curr_value,
    map_12_9_TEM21__FIELD_1__pulse,
    map_12_9_TEM21__FIELD_1__next_value,
    map_12_9_TEM22__FIELD_3__curr_value,
    map_12_9_TEM22__FIELD_3__pulse,
    map_12_9_TEM22__FIELD_3__next_value,
    map_12_9_TEM22__FIELD_2__curr_value,
    map_12_9_TEM22__FIELD_2__pulse,
    map_12_9_TEM22__FIELD_2__next_value,
    map_12_9_TEM22__FIELD_1__curr_value,
    map_12_9_TEM22__FIELD_1__pulse,
    map_12_9_TEM22__FIELD_1__next_value,
    clk,
    rst_n,
    soft_rst,
    req_vld,
    wr_en,
    rd_en,
    addr,
    wr_data,
    rd_data,
    ack_vld,
    err,
    regslv_clk,
    regslv_rst_n,
    err_en
);
    parameter       ADDR_WIDTH                  = 64;
    parameter       DATA_WIDTH                  = 32;
    parameter       INSERT_REG_FF               = 1;

    localparam      REG_NUM                     = 90;
    
    output  logic   [0:0]       map_11_0_TEM21__FIELD_3__curr_value;
    input   logic                               map_11_0_TEM21__FIELD_3__pulse;
    input   logic   [0:0]       map_11_0_TEM21__FIELD_3__next_value;
    output  logic   [1:0]                       map_11_0_TEM21__FIELD_3__swacc;
    output  logic                               map_11_0_TEM21__FIELD_3__swmod;
    output  logic   [2:0]       map_11_0_TEM21__FIELD_2__curr_value;
    input   logic                               map_11_0_TEM21__FIELD_2__pulse;
    input   logic   [2:0]       map_11_0_TEM21__FIELD_2__next_value;
    output  logic   [0:0]       map_11_0_TEM21__FIELD_1__curr_value;
    input   logic                               map_11_0_TEM21__FIELD_1__pulse;
    input   logic   [0:0]       map_11_0_TEM21__FIELD_1__next_value;
    output  logic   [0:0]       map_11_0_TEM22__FIELD_3__curr_value;
    input   logic                               map_11_0_TEM22__FIELD_3__pulse;
    input   logic   [0:0]       map_11_0_TEM22__FIELD_3__next_value;
    output  logic   [2:0]       map_11_0_TEM22__FIELD_2__curr_value;
    input   logic                               map_11_0_TEM22__FIELD_2__pulse;
    input   logic   [2:0]       map_11_0_TEM22__FIELD_2__next_value;
    output  logic   [0:0]       map_11_0_TEM22__FIELD_1__curr_value;
    input   logic                               map_11_0_TEM22__FIELD_1__pulse;
    input   logic   [0:0]       map_11_0_TEM22__FIELD_1__next_value;
    output  logic   [0:0]       map_11_1_TEM21__FIELD_3__curr_value;
    input   logic                               map_11_1_TEM21__FIELD_3__pulse;
    input   logic   [0:0]       map_11_1_TEM21__FIELD_3__next_value;
    output  logic   [1:0]                       map_11_1_TEM21__FIELD_3__swacc;
    output  logic                               map_11_1_TEM21__FIELD_3__swmod;
    output  logic   [2:0]       map_11_1_TEM21__FIELD_2__curr_value;
    input   logic                               map_11_1_TEM21__FIELD_2__pulse;
    input   logic   [2:0]       map_11_1_TEM21__FIELD_2__next_value;
    output  logic   [0:0]       map_11_1_TEM21__FIELD_1__curr_value;
    input   logic                               map_11_1_TEM21__FIELD_1__pulse;
    input   logic   [0:0]       map_11_1_TEM21__FIELD_1__next_value;
    output  logic   [0:0]       map_11_1_TEM22__FIELD_3__curr_value;
    input   logic                               map_11_1_TEM22__FIELD_3__pulse;
    input   logic   [0:0]       map_11_1_TEM22__FIELD_3__next_value;
    output  logic   [2:0]       map_11_1_TEM22__FIELD_2__curr_value;
    input   logic                               map_11_1_TEM22__FIELD_2__pulse;
    input   logic   [2:0]       map_11_1_TEM22__FIELD_2__next_value;
    output  logic   [0:0]       map_11_1_TEM22__FIELD_1__curr_value;
    input   logic                               map_11_1_TEM22__FIELD_1__pulse;
    input   logic   [0:0]       map_11_1_TEM22__FIELD_1__next_value;
    output  logic   [0:0]       map_11_2_TEM21__FIELD_3__curr_value;
    input   logic                               map_11_2_TEM21__FIELD_3__pulse;
    input   logic   [0:0]       map_11_2_TEM21__FIELD_3__next_value;
    output  logic   [1:0]                       map_11_2_TEM21__FIELD_3__swacc;
    output  logic                               map_11_2_TEM21__FIELD_3__swmod;
    output  logic   [2:0]       map_11_2_TEM21__FIELD_2__curr_value;
    input   logic                               map_11_2_TEM21__FIELD_2__pulse;
    input   logic   [2:0]       map_11_2_TEM21__FIELD_2__next_value;
    output  logic   [0:0]       map_11_2_TEM21__FIELD_1__curr_value;
    input   logic                               map_11_2_TEM21__FIELD_1__pulse;
    input   logic   [0:0]       map_11_2_TEM21__FIELD_1__next_value;
    output  logic   [0:0]       map_11_2_TEM22__FIELD_3__curr_value;
    input   logic                               map_11_2_TEM22__FIELD_3__pulse;
    input   logic   [0:0]       map_11_2_TEM22__FIELD_3__next_value;
    output  logic   [2:0]       map_11_2_TEM22__FIELD_2__curr_value;
    input   logic                               map_11_2_TEM22__FIELD_2__pulse;
    input   logic   [2:0]       map_11_2_TEM22__FIELD_2__next_value;
    output  logic   [0:0]       map_11_2_TEM22__FIELD_1__curr_value;
    input   logic                               map_11_2_TEM22__FIELD_1__pulse;
    input   logic   [0:0]       map_11_2_TEM22__FIELD_1__next_value;
    output  logic   [0:0]       map_11_3_TEM21__FIELD_3__curr_value;
    input   logic                               map_11_3_TEM21__FIELD_3__pulse;
    input   logic   [0:0]       map_11_3_TEM21__FIELD_3__next_value;
    output  logic   [1:0]                       map_11_3_TEM21__FIELD_3__swacc;
    output  logic                               map_11_3_TEM21__FIELD_3__swmod;
    output  logic   [2:0]       map_11_3_TEM21__FIELD_2__curr_value;
    input   logic                               map_11_3_TEM21__FIELD_2__pulse;
    input   logic   [2:0]       map_11_3_TEM21__FIELD_2__next_value;
    output  logic   [0:0]       map_11_3_TEM21__FIELD_1__curr_value;
    input   logic                               map_11_3_TEM21__FIELD_1__pulse;
    input   logic   [0:0]       map_11_3_TEM21__FIELD_1__next_value;
    output  logic   [0:0]       map_11_3_TEM22__FIELD_3__curr_value;
    input   logic                               map_11_3_TEM22__FIELD_3__pulse;
    input   logic   [0:0]       map_11_3_TEM22__FIELD_3__next_value;
    output  logic   [2:0]       map_11_3_TEM22__FIELD_2__curr_value;
    input   logic                               map_11_3_TEM22__FIELD_2__pulse;
    input   logic   [2:0]       map_11_3_TEM22__FIELD_2__next_value;
    output  logic   [0:0]       map_11_3_TEM22__FIELD_1__curr_value;
    input   logic                               map_11_3_TEM22__FIELD_1__pulse;
    input   logic   [0:0]       map_11_3_TEM22__FIELD_1__next_value;
    output  logic   [0:0]       map_11_4_TEM21__FIELD_3__curr_value;
    input   logic                               map_11_4_TEM21__FIELD_3__pulse;
    input   logic   [0:0]       map_11_4_TEM21__FIELD_3__next_value;
    output  logic   [1:0]                       map_11_4_TEM21__FIELD_3__swacc;
    output  logic                               map_11_4_TEM21__FIELD_3__swmod;
    output  logic   [2:0]       map_11_4_TEM21__FIELD_2__curr_value;
    input   logic                               map_11_4_TEM21__FIELD_2__pulse;
    input   logic   [2:0]       map_11_4_TEM21__FIELD_2__next_value;
    output  logic   [0:0]       map_11_4_TEM21__FIELD_1__curr_value;
    input   logic                               map_11_4_TEM21__FIELD_1__pulse;
    input   logic   [0:0]       map_11_4_TEM21__FIELD_1__next_value;
    output  logic   [0:0]       map_11_4_TEM22__FIELD_3__curr_value;
    input   logic                               map_11_4_TEM22__FIELD_3__pulse;
    input   logic   [0:0]       map_11_4_TEM22__FIELD_3__next_value;
    output  logic   [2:0]       map_11_4_TEM22__FIELD_2__curr_value;
    input   logic                               map_11_4_TEM22__FIELD_2__pulse;
    input   logic   [2:0]       map_11_4_TEM22__FIELD_2__next_value;
    output  logic   [0:0]       map_11_4_TEM22__FIELD_1__curr_value;
    input   logic                               map_11_4_TEM22__FIELD_1__pulse;
    input   logic   [0:0]       map_11_4_TEM22__FIELD_1__next_value;
    output  logic   [0:0]       map_12_0_TEM21__FIELD_3__curr_value;
    input   logic                               map_12_0_TEM21__FIELD_3__pulse;
    input   logic   [0:0]       map_12_0_TEM21__FIELD_3__next_value;
    output  logic   [1:0]                       map_12_0_TEM21__FIELD_3__swacc;
    output  logic                               map_12_0_TEM21__FIELD_3__swmod;
    output  logic   [2:0]       map_12_0_TEM21__FIELD_2__curr_value;
    input   logic                               map_12_0_TEM21__FIELD_2__pulse;
    input   logic   [2:0]       map_12_0_TEM21__FIELD_2__next_value;
    output  logic   [0:0]       map_12_0_TEM21__FIELD_1__curr_value;
    input   logic                               map_12_0_TEM21__FIELD_1__pulse;
    input   logic   [0:0]       map_12_0_TEM21__FIELD_1__next_value;
    output  logic   [0:0]       map_12_0_TEM22__FIELD_3__curr_value;
    input   logic                               map_12_0_TEM22__FIELD_3__pulse;
    input   logic   [0:0]       map_12_0_TEM22__FIELD_3__next_value;
    output  logic   [2:0]       map_12_0_TEM22__FIELD_2__curr_value;
    input   logic                               map_12_0_TEM22__FIELD_2__pulse;
    input   logic   [2:0]       map_12_0_TEM22__FIELD_2__next_value;
    output  logic   [0:0]       map_12_0_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_0_TEM22__FIELD_1__pulse;
    input   logic   [0:0]       map_12_0_TEM22__FIELD_1__next_value;
    output  logic   [0:0]       map_12_1_TEM21__FIELD_3__curr_value;
    input   logic                               map_12_1_TEM21__FIELD_3__pulse;
    input   logic   [0:0]       map_12_1_TEM21__FIELD_3__next_value;
    output  logic   [1:0]                       map_12_1_TEM21__FIELD_3__swacc;
    output  logic                               map_12_1_TEM21__FIELD_3__swmod;
    output  logic   [2:0]       map_12_1_TEM21__FIELD_2__curr_value;
    input   logic                               map_12_1_TEM21__FIELD_2__pulse;
    input   logic   [2:0]       map_12_1_TEM21__FIELD_2__next_value;
    output  logic   [0:0]       map_12_1_TEM21__FIELD_1__curr_value;
    input   logic                               map_12_1_TEM21__FIELD_1__pulse;
    input   logic   [0:0]       map_12_1_TEM21__FIELD_1__next_value;
    output  logic   [0:0]       map_12_1_TEM22__FIELD_3__curr_value;
    input   logic                               map_12_1_TEM22__FIELD_3__pulse;
    input   logic   [0:0]       map_12_1_TEM22__FIELD_3__next_value;
    output  logic   [2:0]       map_12_1_TEM22__FIELD_2__curr_value;
    input   logic                               map_12_1_TEM22__FIELD_2__pulse;
    input   logic   [2:0]       map_12_1_TEM22__FIELD_2__next_value;
    output  logic   [0:0]       map_12_1_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_1_TEM22__FIELD_1__pulse;
    input   logic   [0:0]       map_12_1_TEM22__FIELD_1__next_value;
    output  logic   [0:0]       map_12_2_TEM21__FIELD_3__curr_value;
    input   logic                               map_12_2_TEM21__FIELD_3__pulse;
    input   logic   [0:0]       map_12_2_TEM21__FIELD_3__next_value;
    output  logic   [1:0]                       map_12_2_TEM21__FIELD_3__swacc;
    output  logic                               map_12_2_TEM21__FIELD_3__swmod;
    output  logic   [2:0]       map_12_2_TEM21__FIELD_2__curr_value;
    input   logic                               map_12_2_TEM21__FIELD_2__pulse;
    input   logic   [2:0]       map_12_2_TEM21__FIELD_2__next_value;
    output  logic   [0:0]       map_12_2_TEM21__FIELD_1__curr_value;
    input   logic                               map_12_2_TEM21__FIELD_1__pulse;
    input   logic   [0:0]       map_12_2_TEM21__FIELD_1__next_value;
    output  logic   [0:0]       map_12_2_TEM22__FIELD_3__curr_value;
    input   logic                               map_12_2_TEM22__FIELD_3__pulse;
    input   logic   [0:0]       map_12_2_TEM22__FIELD_3__next_value;
    output  logic   [2:0]       map_12_2_TEM22__FIELD_2__curr_value;
    input   logic                               map_12_2_TEM22__FIELD_2__pulse;
    input   logic   [2:0]       map_12_2_TEM22__FIELD_2__next_value;
    output  logic   [0:0]       map_12_2_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_2_TEM22__FIELD_1__pulse;
    input   logic   [0:0]       map_12_2_TEM22__FIELD_1__next_value;
    output  logic   [0:0]       map_12_3_TEM21__FIELD_3__curr_value;
    input   logic                               map_12_3_TEM21__FIELD_3__pulse;
    input   logic   [0:0]       map_12_3_TEM21__FIELD_3__next_value;
    output  logic   [1:0]                       map_12_3_TEM21__FIELD_3__swacc;
    output  logic                               map_12_3_TEM21__FIELD_3__swmod;
    output  logic   [2:0]       map_12_3_TEM21__FIELD_2__curr_value;
    input   logic                               map_12_3_TEM21__FIELD_2__pulse;
    input   logic   [2:0]       map_12_3_TEM21__FIELD_2__next_value;
    output  logic   [0:0]       map_12_3_TEM21__FIELD_1__curr_value;
    input   logic                               map_12_3_TEM21__FIELD_1__pulse;
    input   logic   [0:0]       map_12_3_TEM21__FIELD_1__next_value;
    output  logic   [0:0]       map_12_3_TEM22__FIELD_3__curr_value;
    input   logic                               map_12_3_TEM22__FIELD_3__pulse;
    input   logic   [0:0]       map_12_3_TEM22__FIELD_3__next_value;
    output  logic   [2:0]       map_12_3_TEM22__FIELD_2__curr_value;
    input   logic                               map_12_3_TEM22__FIELD_2__pulse;
    input   logic   [2:0]       map_12_3_TEM22__FIELD_2__next_value;
    output  logic   [0:0]       map_12_3_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_3_TEM22__FIELD_1__pulse;
    input   logic   [0:0]       map_12_3_TEM22__FIELD_1__next_value;
    output  logic   [0:0]       map_12_4_TEM21__FIELD_3__curr_value;
    input   logic                               map_12_4_TEM21__FIELD_3__pulse;
    input   logic   [0:0]       map_12_4_TEM21__FIELD_3__next_value;
    output  logic   [1:0]                       map_12_4_TEM21__FIELD_3__swacc;
    output  logic                               map_12_4_TEM21__FIELD_3__swmod;
    output  logic   [2:0]       map_12_4_TEM21__FIELD_2__curr_value;
    input   logic                               map_12_4_TEM21__FIELD_2__pulse;
    input   logic   [2:0]       map_12_4_TEM21__FIELD_2__next_value;
    output  logic   [0:0]       map_12_4_TEM21__FIELD_1__curr_value;
    input   logic                               map_12_4_TEM21__FIELD_1__pulse;
    input   logic   [0:0]       map_12_4_TEM21__FIELD_1__next_value;
    output  logic   [0:0]       map_12_4_TEM22__FIELD_3__curr_value;
    input   logic                               map_12_4_TEM22__FIELD_3__pulse;
    input   logic   [0:0]       map_12_4_TEM22__FIELD_3__next_value;
    output  logic   [2:0]       map_12_4_TEM22__FIELD_2__curr_value;
    input   logic                               map_12_4_TEM22__FIELD_2__pulse;
    input   logic   [2:0]       map_12_4_TEM22__FIELD_2__next_value;
    output  logic   [0:0]       map_12_4_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_4_TEM22__FIELD_1__pulse;
    input   logic   [0:0]       map_12_4_TEM22__FIELD_1__next_value;
    output  logic   [0:0]       map_12_5_TEM21__FIELD_3__curr_value;
    input   logic                               map_12_5_TEM21__FIELD_3__pulse;
    input   logic   [0:0]       map_12_5_TEM21__FIELD_3__next_value;
    output  logic   [1:0]                       map_12_5_TEM21__FIELD_3__swacc;
    output  logic                               map_12_5_TEM21__FIELD_3__swmod;
    output  logic   [2:0]       map_12_5_TEM21__FIELD_2__curr_value;
    input   logic                               map_12_5_TEM21__FIELD_2__pulse;
    input   logic   [2:0]       map_12_5_TEM21__FIELD_2__next_value;
    output  logic   [0:0]       map_12_5_TEM21__FIELD_1__curr_value;
    input   logic                               map_12_5_TEM21__FIELD_1__pulse;
    input   logic   [0:0]       map_12_5_TEM21__FIELD_1__next_value;
    output  logic   [0:0]       map_12_5_TEM22__FIELD_3__curr_value;
    input   logic                               map_12_5_TEM22__FIELD_3__pulse;
    input   logic   [0:0]       map_12_5_TEM22__FIELD_3__next_value;
    output  logic   [2:0]       map_12_5_TEM22__FIELD_2__curr_value;
    input   logic                               map_12_5_TEM22__FIELD_2__pulse;
    input   logic   [2:0]       map_12_5_TEM22__FIELD_2__next_value;
    output  logic   [0:0]       map_12_5_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_5_TEM22__FIELD_1__pulse;
    input   logic   [0:0]       map_12_5_TEM22__FIELD_1__next_value;
    output  logic   [0:0]       map_12_6_TEM21__FIELD_3__curr_value;
    input   logic                               map_12_6_TEM21__FIELD_3__pulse;
    input   logic   [0:0]       map_12_6_TEM21__FIELD_3__next_value;
    output  logic   [1:0]                       map_12_6_TEM21__FIELD_3__swacc;
    output  logic                               map_12_6_TEM21__FIELD_3__swmod;
    output  logic   [2:0]       map_12_6_TEM21__FIELD_2__curr_value;
    input   logic                               map_12_6_TEM21__FIELD_2__pulse;
    input   logic   [2:0]       map_12_6_TEM21__FIELD_2__next_value;
    output  logic   [0:0]       map_12_6_TEM21__FIELD_1__curr_value;
    input   logic                               map_12_6_TEM21__FIELD_1__pulse;
    input   logic   [0:0]       map_12_6_TEM21__FIELD_1__next_value;
    output  logic   [0:0]       map_12_6_TEM22__FIELD_3__curr_value;
    input   logic                               map_12_6_TEM22__FIELD_3__pulse;
    input   logic   [0:0]       map_12_6_TEM22__FIELD_3__next_value;
    output  logic   [2:0]       map_12_6_TEM22__FIELD_2__curr_value;
    input   logic                               map_12_6_TEM22__FIELD_2__pulse;
    input   logic   [2:0]       map_12_6_TEM22__FIELD_2__next_value;
    output  logic   [0:0]       map_12_6_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_6_TEM22__FIELD_1__pulse;
    input   logic   [0:0]       map_12_6_TEM22__FIELD_1__next_value;
    output  logic   [0:0]       map_12_7_TEM21__FIELD_3__curr_value;
    input   logic                               map_12_7_TEM21__FIELD_3__pulse;
    input   logic   [0:0]       map_12_7_TEM21__FIELD_3__next_value;
    output  logic   [1:0]                       map_12_7_TEM21__FIELD_3__swacc;
    output  logic                               map_12_7_TEM21__FIELD_3__swmod;
    output  logic   [2:0]       map_12_7_TEM21__FIELD_2__curr_value;
    input   logic                               map_12_7_TEM21__FIELD_2__pulse;
    input   logic   [2:0]       map_12_7_TEM21__FIELD_2__next_value;
    output  logic   [0:0]       map_12_7_TEM21__FIELD_1__curr_value;
    input   logic                               map_12_7_TEM21__FIELD_1__pulse;
    input   logic   [0:0]       map_12_7_TEM21__FIELD_1__next_value;
    output  logic   [0:0]       map_12_7_TEM22__FIELD_3__curr_value;
    input   logic                               map_12_7_TEM22__FIELD_3__pulse;
    input   logic   [0:0]       map_12_7_TEM22__FIELD_3__next_value;
    output  logic   [2:0]       map_12_7_TEM22__FIELD_2__curr_value;
    input   logic                               map_12_7_TEM22__FIELD_2__pulse;
    input   logic   [2:0]       map_12_7_TEM22__FIELD_2__next_value;
    output  logic   [0:0]       map_12_7_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_7_TEM22__FIELD_1__pulse;
    input   logic   [0:0]       map_12_7_TEM22__FIELD_1__next_value;
    output  logic   [0:0]       map_12_8_TEM21__FIELD_3__curr_value;
    input   logic                               map_12_8_TEM21__FIELD_3__pulse;
    input   logic   [0:0]       map_12_8_TEM21__FIELD_3__next_value;
    output  logic   [1:0]                       map_12_8_TEM21__FIELD_3__swacc;
    output  logic                               map_12_8_TEM21__FIELD_3__swmod;
    output  logic   [2:0]       map_12_8_TEM21__FIELD_2__curr_value;
    input   logic                               map_12_8_TEM21__FIELD_2__pulse;
    input   logic   [2:0]       map_12_8_TEM21__FIELD_2__next_value;
    output  logic   [0:0]       map_12_8_TEM21__FIELD_1__curr_value;
    input   logic                               map_12_8_TEM21__FIELD_1__pulse;
    input   logic   [0:0]       map_12_8_TEM21__FIELD_1__next_value;
    output  logic   [0:0]       map_12_8_TEM22__FIELD_3__curr_value;
    input   logic                               map_12_8_TEM22__FIELD_3__pulse;
    input   logic   [0:0]       map_12_8_TEM22__FIELD_3__next_value;
    output  logic   [2:0]       map_12_8_TEM22__FIELD_2__curr_value;
    input   logic                               map_12_8_TEM22__FIELD_2__pulse;
    input   logic   [2:0]       map_12_8_TEM22__FIELD_2__next_value;
    output  logic   [0:0]       map_12_8_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_8_TEM22__FIELD_1__pulse;
    input   logic   [0:0]       map_12_8_TEM22__FIELD_1__next_value;
    output  logic   [0:0]       map_12_9_TEM21__FIELD_3__curr_value;
    input   logic                               map_12_9_TEM21__FIELD_3__pulse;
    input   logic   [0:0]       map_12_9_TEM21__FIELD_3__next_value;
    output  logic   [1:0]                       map_12_9_TEM21__FIELD_3__swacc;
    output  logic                               map_12_9_TEM21__FIELD_3__swmod;
    output  logic   [2:0]       map_12_9_TEM21__FIELD_2__curr_value;
    input   logic                               map_12_9_TEM21__FIELD_2__pulse;
    input   logic   [2:0]       map_12_9_TEM21__FIELD_2__next_value;
    output  logic   [0:0]       map_12_9_TEM21__FIELD_1__curr_value;
    input   logic                               map_12_9_TEM21__FIELD_1__pulse;
    input   logic   [0:0]       map_12_9_TEM21__FIELD_1__next_value;
    output  logic   [0:0]       map_12_9_TEM22__FIELD_3__curr_value;
    input   logic                               map_12_9_TEM22__FIELD_3__pulse;
    input   logic   [0:0]       map_12_9_TEM22__FIELD_3__next_value;
    output  logic   [2:0]       map_12_9_TEM22__FIELD_2__curr_value;
    input   logic                               map_12_9_TEM22__FIELD_2__pulse;
    input   logic   [2:0]       map_12_9_TEM22__FIELD_2__next_value;
    output  logic   [0:0]       map_12_9_TEM22__FIELD_1__curr_value;
    input   logic                               map_12_9_TEM22__FIELD_1__pulse;
    input   logic   [0:0]       map_12_9_TEM22__FIELD_1__next_value;

    input   logic                               clk;
    input   logic                               rst_n;

    input   logic                               req_vld;
    input   logic                               wr_en;
    input   logic                               rd_en;
    input   logic   [ADDR_WIDTH-1:0]            addr;
    input   logic   [DATA_WIDTH-1:0]            wr_data;
    input   logic                               soft_rst;
    output  logic   [DATA_WIDTH-1:0]            rd_data;
    output  logic                               ack_vld;
    output  logic                               err;
    // at internal register clock domain
    input   logic                               regslv_clk;
    input   logic                               regslv_rst_n;
    input   logic                               err_en;

    logic                                       int_req_vld;
    logic                                       int_wr_en;
    logic                                       int_rd_en;
    logic   [ADDR_WIDTH-1:0]                    int_addr;
    logic   [DATA_WIDTH-1:0]                    int_wr_data;
    logic                                       int_soft_rst;
    logic   [DATA_WIDTH-1:0]                    int_rd_data;
    logic                                       int_ack_vld;
    logic                                       int_err;

    logic   [REG_NUM-1:0] [DATA_WIDTH-1:0]      reg_sw_rd_data;
    logic   [REG_NUM-1:0] [DATA_WIDTH-1:0]      reg_rd_data_mux_din;
    logic   [REG_NUM-1:0]                       reg_rd_data_mux_sel;
    logic   [DATA_WIDTH-1:0]                    reg_rd_data_mux_dout;
    logic                                       reg_rd_data_mux_dout_vld;
    logic                                       reg_rd_data_vld;
    logic   [DATA_WIDTH-1:0]                    reg_rd_data;

//***********************************CLOCK DOMAIN CROSSING********************************************//
    localparam      FORWARD_DELIVER_NUM         = ADDR_WIDTH + DATA_WIDTH + 4;
    localparam      BACKWARD_DELIVER_NUM        = DATA_WIDTH + 2;
    logic   [FORWARD_DELIVER_NUM-1:0]           pulse_deliver_forward_pulse_in;
    logic   [FORWARD_DELIVER_NUM-1:0]           pulse_deliver_forward_pulse_out;
    logic   [BACKWARD_DELIVER_NUM-1:0]          pulse_deliver_backward_pulse_in;
    logic   [BACKWARD_DELIVER_NUM-1:0]          pulse_deliver_backward_pulse_out;

    // deliver reg_native_if pulse from native to 3rd party IP clock domain
    assign  pulse_deliver_forward_pulse_in      = {req_vld, addr, wr_en, rd_en, wr_data, soft_rst};
    pulse_deliver #(.WIDTH (FORWARD_DELIVER_NUM))
    pulse_deliver_forward (
        .scan_enable                            (1'b0),
        .clk_a                                  (clk),
        .rst_a_n                                (rst_n),
        .pulse_in                               (pulse_deliver_forward_pulse_in),
        .clk_b                                  (regslv_clk),
        .rst_b_n                                (regslv_rst_n),
        .pulse_out                              (pulse_deliver_forward_pulse_out));
    assign  {int_req_vld, int_addr, int_wr_en, int_rd_en, int_wr_data, int_soft_rst}  = pulse_deliver_forward_pulse_out;

    // deliver reg_native_if pulse from 3rd party IP to native clock domain
    assign  pulse_deliver_backward_pulse_in     = {int_ack_vld, int_err, int_rd_data};
    pulse_deliver #(.WIDTH (BACKWARD_DELIVER_NUM))
    pulse_deliver_backward (
        .scan_enable                            (1'b0),
        .clk_a                                  (regslv_clk),
        .rst_a_n                                (regslv_rst_n),
        .pulse_in                               (pulse_deliver_backward_pulse_in),
        .clk_b                                  (clk),
        .rst_b_n                                (rst_n),
        .pulse_out                              (pulse_deliver_backward_pulse_out));
    assign  {ack_vld, err, rd_data}             = pulse_deliver_backward_pulse_out;

//**************************************ADDRESS DECODER***********************************************//
    logic   [REG_NUM-1:0]                       dec_reg_sel;
    logic                                       dec_dummy_sel;
    logic                                       reg_acc;
    logic                                       dummy_acc;
    logic   [REG_NUM-1:0]                       reg_sw_wr_sel;
    logic   [REG_NUM-1:0]                       reg_sw_rd_sel;
    logic   [DATA_WIDTH-1:0]                    reg_sw_wr_data;

    always_comb begin
        if (int_req_vld & ~int_soft_rst) begin
            dec_reg_sel = {REG_NUM{1'b0}};
            dec_dummy_sel = 1'b0;

            unique casez (int_addr)
                64'h0: dec_reg_sel[0] = 1'b1;
                64'h4: dec_reg_sel[1] = 1'b1;
                64'h8: dec_reg_sel[2] = 1'b1;
                64'hc: dec_reg_sel[3] = 1'b1;
                64'h10: dec_reg_sel[4] = 1'b1;
                64'h14: dec_reg_sel[5] = 1'b1;
                64'h18: dec_reg_sel[6] = 1'b1;
                64'h1c: dec_reg_sel[7] = 1'b1;
                64'h20: dec_reg_sel[8] = 1'b1;
                64'h24: dec_reg_sel[9] = 1'b1;
                64'h28: dec_reg_sel[10] = 1'b1;
                64'h2c: dec_reg_sel[11] = 1'b1;
                64'h30: dec_reg_sel[12] = 1'b1;
                64'h34: dec_reg_sel[13] = 1'b1;
                64'h38: dec_reg_sel[14] = 1'b1;
                64'h3c: dec_reg_sel[15] = 1'b1;
                64'h40: dec_reg_sel[16] = 1'b1;
                64'h44: dec_reg_sel[17] = 1'b1;
                64'h48: dec_reg_sel[18] = 1'b1;
                64'h4c: dec_reg_sel[19] = 1'b1;
                64'h50: dec_reg_sel[20] = 1'b1;
                64'h54: dec_reg_sel[21] = 1'b1;
                64'h58: dec_reg_sel[22] = 1'b1;
                64'h5c: dec_reg_sel[23] = 1'b1;
                64'h60: dec_reg_sel[24] = 1'b1;
                64'h64: dec_reg_sel[25] = 1'b1;
                64'h68: dec_reg_sel[26] = 1'b1;
                64'h6c: dec_reg_sel[27] = 1'b1;
                64'h70: dec_reg_sel[28] = 1'b1;
                64'h74: dec_reg_sel[29] = 1'b1;
                64'h80: dec_reg_sel[30] = 1'b1;
                64'h84: dec_reg_sel[31] = 1'b1;
                64'h88: dec_reg_sel[32] = 1'b1;
                64'h8c: dec_reg_sel[33] = 1'b1;
                64'h90: dec_reg_sel[34] = 1'b1;
                64'h94: dec_reg_sel[35] = 1'b1;
                64'h98: dec_reg_sel[36] = 1'b1;
                64'h9c: dec_reg_sel[37] = 1'b1;
                64'ha0: dec_reg_sel[38] = 1'b1;
                64'ha4: dec_reg_sel[39] = 1'b1;
                64'ha8: dec_reg_sel[40] = 1'b1;
                64'hac: dec_reg_sel[41] = 1'b1;
                64'hb0: dec_reg_sel[42] = 1'b1;
                64'hb4: dec_reg_sel[43] = 1'b1;
                64'hb8: dec_reg_sel[44] = 1'b1;
                64'hbc: dec_reg_sel[45] = 1'b1;
                64'hc0: dec_reg_sel[46] = 1'b1;
                64'hc4: dec_reg_sel[47] = 1'b1;
                64'hc8: dec_reg_sel[48] = 1'b1;
                64'hcc: dec_reg_sel[49] = 1'b1;
                64'hd0: dec_reg_sel[50] = 1'b1;
                64'hd4: dec_reg_sel[51] = 1'b1;
                64'hd8: dec_reg_sel[52] = 1'b1;
                64'hdc: dec_reg_sel[53] = 1'b1;
                64'he0: dec_reg_sel[54] = 1'b1;
                64'he4: dec_reg_sel[55] = 1'b1;
                64'he8: dec_reg_sel[56] = 1'b1;
                64'hec: dec_reg_sel[57] = 1'b1;
                64'hf0: dec_reg_sel[58] = 1'b1;
                64'hf4: dec_reg_sel[59] = 1'b1;
                64'hf8: dec_reg_sel[60] = 1'b1;
                64'hfc: dec_reg_sel[61] = 1'b1;
                64'h100: dec_reg_sel[62] = 1'b1;
                64'h104: dec_reg_sel[63] = 1'b1;
                64'h108: dec_reg_sel[64] = 1'b1;
                64'h10c: dec_reg_sel[65] = 1'b1;
                64'h110: dec_reg_sel[66] = 1'b1;
                64'h114: dec_reg_sel[67] = 1'b1;
                64'h118: dec_reg_sel[68] = 1'b1;
                64'h11c: dec_reg_sel[69] = 1'b1;
                64'h120: dec_reg_sel[70] = 1'b1;
                64'h124: dec_reg_sel[71] = 1'b1;
                64'h128: dec_reg_sel[72] = 1'b1;
                64'h12c: dec_reg_sel[73] = 1'b1;
                64'h130: dec_reg_sel[74] = 1'b1;
                64'h134: dec_reg_sel[75] = 1'b1;
                64'h138: dec_reg_sel[76] = 1'b1;
                64'h13c: dec_reg_sel[77] = 1'b1;
                64'h140: dec_reg_sel[78] = 1'b1;
                64'h144: dec_reg_sel[79] = 1'b1;
                64'h148: dec_reg_sel[80] = 1'b1;
                64'h14c: dec_reg_sel[81] = 1'b1;
                64'h150: dec_reg_sel[82] = 1'b1;
                64'h154: dec_reg_sel[83] = 1'b1;
                64'h158: dec_reg_sel[84] = 1'b1;
                64'h15c: dec_reg_sel[85] = 1'b1;
                64'h160: dec_reg_sel[86] = 1'b1;
                64'h164: dec_reg_sel[87] = 1'b1;
                64'h168: dec_reg_sel[88] = 1'b1;
                64'h16c: dec_reg_sel[89] = 1'b1;
                default: dec_dummy_sel = 1'b1;
            endcase
        end
        else begin
            dec_reg_sel = {REG_NUM{1'b0}};
            dec_dummy_sel = 1'b0;
        end
    end

    generate
        if (INSERT_REG_FF) begin: g_reg_ff
            always_ff @(posedge regslv_clk or negedge regslv_rst_n) begin
                if (!regslv_rst_n) begin
                    reg_sw_wr_sel                       <= {REG_NUM{1'b0}};
                    reg_sw_rd_sel                       <= {REG_NUM{1'b0}};
                    reg_sw_wr_data                      <= {DATA_WIDTH{1'b0}};
                    dummy_acc                           <= 1'b0;
                end
                else if (int_soft_rst) begin
                    reg_sw_wr_sel                       <= {REG_NUM{1'b0}};
                    reg_sw_rd_sel                       <= {REG_NUM{1'b0}};
                    reg_sw_wr_data                      <= {DATA_WIDTH{1'b0}};
                    dummy_acc                           <= 1'b0;
                end
                else begin
                    reg_sw_wr_sel                       <= {REG_NUM{int_wr_en}} & dec_reg_sel;
                    reg_sw_rd_sel                       <= {REG_NUM{int_rd_en}} & dec_reg_sel;
                    reg_sw_wr_data                      <= int_wr_data;
                    dummy_acc                           <= dec_dummy_sel;
                end
            end
        end
        else begin: g_no_reg_ff
            assign  reg_sw_wr_sel                       = {REG_NUM{int_wr_en}} & dec_reg_sel;
            assign  reg_sw_rd_sel                       = {REG_NUM{int_rd_en}} & dec_reg_sel;
            assign  reg_sw_wr_data                      = int_wr_data;
            assign  dummy_acc                           = dec_dummy_sel;
        end
    endgenerate

    assign  reg_acc                             = (|reg_sw_wr_sel) | (|reg_sw_rd_sel);

//*******************************************FSM******************************************************//
    slv_fsm #(.DATA_WIDTH (DATA_WIDTH))
    slv_fsm (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .if_soft_rst                            (int_soft_rst),
        .if_req_vld                             (int_req_vld),
        .if_ack_vld                             (int_ack_vld),
        .if_rd_data                             (int_rd_data),
        .if_err                                 (int_err),
        .if_err_en                              (err_en),
        .if_wr_en                               (int_wr_en),
        .if_rd_en                               (int_rd_en),
        .dummy_acc                              (dummy_acc),
        .reg_acc                                (reg_acc),
        .reg_rd_data                            (reg_rd_data),
        .reg_rd_data_vld                        (reg_rd_data_vld));

//***********************************FIELDS AND REGISTERS*********************************************//
    logic                                       map_11_0_TEM21__sw_wr_en;
    logic                                       map_11_0_TEM21__sw_rd_en;
    logic   [63:0]                map_11_0_TEM21__sw_wr_data;
    logic   [63:0]                map_11_0_TEM21__sw_rd_data;
    logic                                       map_11_0_TEM21_alias__sw_wr_en;
    logic                                       map_11_0_TEM21_alias__sw_rd_en;
    logic   [63:0]                map_11_0_TEM21_alias__sw_wr_data;
    logic   [63:0]                map_11_0_TEM21_alias__sw_rd_data;
    logic                                       map_11_0_TEM22__sw_wr_en;
    logic                                       map_11_0_TEM22__sw_rd_en;
    logic   [31:0]                map_11_0_TEM22__sw_wr_data;
    logic   [31:0]                map_11_0_TEM22__sw_rd_data;
    logic                                       map_11_0_TEM22_alias__sw_wr_en;
    logic                                       map_11_0_TEM22_alias__sw_rd_en;
    logic   [31:0]                map_11_0_TEM22_alias__sw_wr_data;
    logic   [31:0]                map_11_0_TEM22_alias__sw_rd_data;
    logic                                       map_11_1_TEM21__sw_wr_en;
    logic                                       map_11_1_TEM21__sw_rd_en;
    logic   [63:0]                map_11_1_TEM21__sw_wr_data;
    logic   [63:0]                map_11_1_TEM21__sw_rd_data;
    logic                                       map_11_1_TEM21_alias__sw_wr_en;
    logic                                       map_11_1_TEM21_alias__sw_rd_en;
    logic   [63:0]                map_11_1_TEM21_alias__sw_wr_data;
    logic   [63:0]                map_11_1_TEM21_alias__sw_rd_data;
    logic                                       map_11_1_TEM22__sw_wr_en;
    logic                                       map_11_1_TEM22__sw_rd_en;
    logic   [31:0]                map_11_1_TEM22__sw_wr_data;
    logic   [31:0]                map_11_1_TEM22__sw_rd_data;
    logic                                       map_11_1_TEM22_alias__sw_wr_en;
    logic                                       map_11_1_TEM22_alias__sw_rd_en;
    logic   [31:0]                map_11_1_TEM22_alias__sw_wr_data;
    logic   [31:0]                map_11_1_TEM22_alias__sw_rd_data;
    logic                                       map_11_2_TEM21__sw_wr_en;
    logic                                       map_11_2_TEM21__sw_rd_en;
    logic   [63:0]                map_11_2_TEM21__sw_wr_data;
    logic   [63:0]                map_11_2_TEM21__sw_rd_data;
    logic                                       map_11_2_TEM21_alias__sw_wr_en;
    logic                                       map_11_2_TEM21_alias__sw_rd_en;
    logic   [63:0]                map_11_2_TEM21_alias__sw_wr_data;
    logic   [63:0]                map_11_2_TEM21_alias__sw_rd_data;
    logic                                       map_11_2_TEM22__sw_wr_en;
    logic                                       map_11_2_TEM22__sw_rd_en;
    logic   [31:0]                map_11_2_TEM22__sw_wr_data;
    logic   [31:0]                map_11_2_TEM22__sw_rd_data;
    logic                                       map_11_2_TEM22_alias__sw_wr_en;
    logic                                       map_11_2_TEM22_alias__sw_rd_en;
    logic   [31:0]                map_11_2_TEM22_alias__sw_wr_data;
    logic   [31:0]                map_11_2_TEM22_alias__sw_rd_data;
    logic                                       map_11_3_TEM21__sw_wr_en;
    logic                                       map_11_3_TEM21__sw_rd_en;
    logic   [63:0]                map_11_3_TEM21__sw_wr_data;
    logic   [63:0]                map_11_3_TEM21__sw_rd_data;
    logic                                       map_11_3_TEM21_alias__sw_wr_en;
    logic                                       map_11_3_TEM21_alias__sw_rd_en;
    logic   [63:0]                map_11_3_TEM21_alias__sw_wr_data;
    logic   [63:0]                map_11_3_TEM21_alias__sw_rd_data;
    logic                                       map_11_3_TEM22__sw_wr_en;
    logic                                       map_11_3_TEM22__sw_rd_en;
    logic   [31:0]                map_11_3_TEM22__sw_wr_data;
    logic   [31:0]                map_11_3_TEM22__sw_rd_data;
    logic                                       map_11_3_TEM22_alias__sw_wr_en;
    logic                                       map_11_3_TEM22_alias__sw_rd_en;
    logic   [31:0]                map_11_3_TEM22_alias__sw_wr_data;
    logic   [31:0]                map_11_3_TEM22_alias__sw_rd_data;
    logic                                       map_11_4_TEM21__sw_wr_en;
    logic                                       map_11_4_TEM21__sw_rd_en;
    logic   [63:0]                map_11_4_TEM21__sw_wr_data;
    logic   [63:0]                map_11_4_TEM21__sw_rd_data;
    logic                                       map_11_4_TEM21_alias__sw_wr_en;
    logic                                       map_11_4_TEM21_alias__sw_rd_en;
    logic   [63:0]                map_11_4_TEM21_alias__sw_wr_data;
    logic   [63:0]                map_11_4_TEM21_alias__sw_rd_data;
    logic                                       map_11_4_TEM22__sw_wr_en;
    logic                                       map_11_4_TEM22__sw_rd_en;
    logic   [31:0]                map_11_4_TEM22__sw_wr_data;
    logic   [31:0]                map_11_4_TEM22__sw_rd_data;
    logic                                       map_11_4_TEM22_alias__sw_wr_en;
    logic                                       map_11_4_TEM22_alias__sw_rd_en;
    logic   [31:0]                map_11_4_TEM22_alias__sw_wr_data;
    logic   [31:0]                map_11_4_TEM22_alias__sw_rd_data;
    logic                                       map_12_0_TEM21__sw_wr_en;
    logic                                       map_12_0_TEM21__sw_rd_en;
    logic   [63:0]                map_12_0_TEM21__sw_wr_data;
    logic   [63:0]                map_12_0_TEM21__sw_rd_data;
    logic                                       map_12_0_TEM21_alias__sw_wr_en;
    logic                                       map_12_0_TEM21_alias__sw_rd_en;
    logic   [63:0]                map_12_0_TEM21_alias__sw_wr_data;
    logic   [63:0]                map_12_0_TEM21_alias__sw_rd_data;
    logic                                       map_12_0_TEM22__sw_wr_en;
    logic                                       map_12_0_TEM22__sw_rd_en;
    logic   [31:0]                map_12_0_TEM22__sw_wr_data;
    logic   [31:0]                map_12_0_TEM22__sw_rd_data;
    logic                                       map_12_0_TEM22_alias__sw_wr_en;
    logic                                       map_12_0_TEM22_alias__sw_rd_en;
    logic   [31:0]                map_12_0_TEM22_alias__sw_wr_data;
    logic   [31:0]                map_12_0_TEM22_alias__sw_rd_data;
    logic                                       map_12_1_TEM21__sw_wr_en;
    logic                                       map_12_1_TEM21__sw_rd_en;
    logic   [63:0]                map_12_1_TEM21__sw_wr_data;
    logic   [63:0]                map_12_1_TEM21__sw_rd_data;
    logic                                       map_12_1_TEM21_alias__sw_wr_en;
    logic                                       map_12_1_TEM21_alias__sw_rd_en;
    logic   [63:0]                map_12_1_TEM21_alias__sw_wr_data;
    logic   [63:0]                map_12_1_TEM21_alias__sw_rd_data;
    logic                                       map_12_1_TEM22__sw_wr_en;
    logic                                       map_12_1_TEM22__sw_rd_en;
    logic   [31:0]                map_12_1_TEM22__sw_wr_data;
    logic   [31:0]                map_12_1_TEM22__sw_rd_data;
    logic                                       map_12_1_TEM22_alias__sw_wr_en;
    logic                                       map_12_1_TEM22_alias__sw_rd_en;
    logic   [31:0]                map_12_1_TEM22_alias__sw_wr_data;
    logic   [31:0]                map_12_1_TEM22_alias__sw_rd_data;
    logic                                       map_12_2_TEM21__sw_wr_en;
    logic                                       map_12_2_TEM21__sw_rd_en;
    logic   [63:0]                map_12_2_TEM21__sw_wr_data;
    logic   [63:0]                map_12_2_TEM21__sw_rd_data;
    logic                                       map_12_2_TEM21_alias__sw_wr_en;
    logic                                       map_12_2_TEM21_alias__sw_rd_en;
    logic   [63:0]                map_12_2_TEM21_alias__sw_wr_data;
    logic   [63:0]                map_12_2_TEM21_alias__sw_rd_data;
    logic                                       map_12_2_TEM22__sw_wr_en;
    logic                                       map_12_2_TEM22__sw_rd_en;
    logic   [31:0]                map_12_2_TEM22__sw_wr_data;
    logic   [31:0]                map_12_2_TEM22__sw_rd_data;
    logic                                       map_12_2_TEM22_alias__sw_wr_en;
    logic                                       map_12_2_TEM22_alias__sw_rd_en;
    logic   [31:0]                map_12_2_TEM22_alias__sw_wr_data;
    logic   [31:0]                map_12_2_TEM22_alias__sw_rd_data;
    logic                                       map_12_3_TEM21__sw_wr_en;
    logic                                       map_12_3_TEM21__sw_rd_en;
    logic   [63:0]                map_12_3_TEM21__sw_wr_data;
    logic   [63:0]                map_12_3_TEM21__sw_rd_data;
    logic                                       map_12_3_TEM21_alias__sw_wr_en;
    logic                                       map_12_3_TEM21_alias__sw_rd_en;
    logic   [63:0]                map_12_3_TEM21_alias__sw_wr_data;
    logic   [63:0]                map_12_3_TEM21_alias__sw_rd_data;
    logic                                       map_12_3_TEM22__sw_wr_en;
    logic                                       map_12_3_TEM22__sw_rd_en;
    logic   [31:0]                map_12_3_TEM22__sw_wr_data;
    logic   [31:0]                map_12_3_TEM22__sw_rd_data;
    logic                                       map_12_3_TEM22_alias__sw_wr_en;
    logic                                       map_12_3_TEM22_alias__sw_rd_en;
    logic   [31:0]                map_12_3_TEM22_alias__sw_wr_data;
    logic   [31:0]                map_12_3_TEM22_alias__sw_rd_data;
    logic                                       map_12_4_TEM21__sw_wr_en;
    logic                                       map_12_4_TEM21__sw_rd_en;
    logic   [63:0]                map_12_4_TEM21__sw_wr_data;
    logic   [63:0]                map_12_4_TEM21__sw_rd_data;
    logic                                       map_12_4_TEM21_alias__sw_wr_en;
    logic                                       map_12_4_TEM21_alias__sw_rd_en;
    logic   [63:0]                map_12_4_TEM21_alias__sw_wr_data;
    logic   [63:0]                map_12_4_TEM21_alias__sw_rd_data;
    logic                                       map_12_4_TEM22__sw_wr_en;
    logic                                       map_12_4_TEM22__sw_rd_en;
    logic   [31:0]                map_12_4_TEM22__sw_wr_data;
    logic   [31:0]                map_12_4_TEM22__sw_rd_data;
    logic                                       map_12_4_TEM22_alias__sw_wr_en;
    logic                                       map_12_4_TEM22_alias__sw_rd_en;
    logic   [31:0]                map_12_4_TEM22_alias__sw_wr_data;
    logic   [31:0]                map_12_4_TEM22_alias__sw_rd_data;
    logic                                       map_12_5_TEM21__sw_wr_en;
    logic                                       map_12_5_TEM21__sw_rd_en;
    logic   [63:0]                map_12_5_TEM21__sw_wr_data;
    logic   [63:0]                map_12_5_TEM21__sw_rd_data;
    logic                                       map_12_5_TEM21_alias__sw_wr_en;
    logic                                       map_12_5_TEM21_alias__sw_rd_en;
    logic   [63:0]                map_12_5_TEM21_alias__sw_wr_data;
    logic   [63:0]                map_12_5_TEM21_alias__sw_rd_data;
    logic                                       map_12_5_TEM22__sw_wr_en;
    logic                                       map_12_5_TEM22__sw_rd_en;
    logic   [31:0]                map_12_5_TEM22__sw_wr_data;
    logic   [31:0]                map_12_5_TEM22__sw_rd_data;
    logic                                       map_12_5_TEM22_alias__sw_wr_en;
    logic                                       map_12_5_TEM22_alias__sw_rd_en;
    logic   [31:0]                map_12_5_TEM22_alias__sw_wr_data;
    logic   [31:0]                map_12_5_TEM22_alias__sw_rd_data;
    logic                                       map_12_6_TEM21__sw_wr_en;
    logic                                       map_12_6_TEM21__sw_rd_en;
    logic   [63:0]                map_12_6_TEM21__sw_wr_data;
    logic   [63:0]                map_12_6_TEM21__sw_rd_data;
    logic                                       map_12_6_TEM21_alias__sw_wr_en;
    logic                                       map_12_6_TEM21_alias__sw_rd_en;
    logic   [63:0]                map_12_6_TEM21_alias__sw_wr_data;
    logic   [63:0]                map_12_6_TEM21_alias__sw_rd_data;
    logic                                       map_12_6_TEM22__sw_wr_en;
    logic                                       map_12_6_TEM22__sw_rd_en;
    logic   [31:0]                map_12_6_TEM22__sw_wr_data;
    logic   [31:0]                map_12_6_TEM22__sw_rd_data;
    logic                                       map_12_6_TEM22_alias__sw_wr_en;
    logic                                       map_12_6_TEM22_alias__sw_rd_en;
    logic   [31:0]                map_12_6_TEM22_alias__sw_wr_data;
    logic   [31:0]                map_12_6_TEM22_alias__sw_rd_data;
    logic                                       map_12_7_TEM21__sw_wr_en;
    logic                                       map_12_7_TEM21__sw_rd_en;
    logic   [63:0]                map_12_7_TEM21__sw_wr_data;
    logic   [63:0]                map_12_7_TEM21__sw_rd_data;
    logic                                       map_12_7_TEM21_alias__sw_wr_en;
    logic                                       map_12_7_TEM21_alias__sw_rd_en;
    logic   [63:0]                map_12_7_TEM21_alias__sw_wr_data;
    logic   [63:0]                map_12_7_TEM21_alias__sw_rd_data;
    logic                                       map_12_7_TEM22__sw_wr_en;
    logic                                       map_12_7_TEM22__sw_rd_en;
    logic   [31:0]                map_12_7_TEM22__sw_wr_data;
    logic   [31:0]                map_12_7_TEM22__sw_rd_data;
    logic                                       map_12_7_TEM22_alias__sw_wr_en;
    logic                                       map_12_7_TEM22_alias__sw_rd_en;
    logic   [31:0]                map_12_7_TEM22_alias__sw_wr_data;
    logic   [31:0]                map_12_7_TEM22_alias__sw_rd_data;
    logic                                       map_12_8_TEM21__sw_wr_en;
    logic                                       map_12_8_TEM21__sw_rd_en;
    logic   [63:0]                map_12_8_TEM21__sw_wr_data;
    logic   [63:0]                map_12_8_TEM21__sw_rd_data;
    logic                                       map_12_8_TEM21_alias__sw_wr_en;
    logic                                       map_12_8_TEM21_alias__sw_rd_en;
    logic   [63:0]                map_12_8_TEM21_alias__sw_wr_data;
    logic   [63:0]                map_12_8_TEM21_alias__sw_rd_data;
    logic                                       map_12_8_TEM22__sw_wr_en;
    logic                                       map_12_8_TEM22__sw_rd_en;
    logic   [31:0]                map_12_8_TEM22__sw_wr_data;
    logic   [31:0]                map_12_8_TEM22__sw_rd_data;
    logic                                       map_12_8_TEM22_alias__sw_wr_en;
    logic                                       map_12_8_TEM22_alias__sw_rd_en;
    logic   [31:0]                map_12_8_TEM22_alias__sw_wr_data;
    logic   [31:0]                map_12_8_TEM22_alias__sw_rd_data;
    logic                                       map_12_9_TEM21__sw_wr_en;
    logic                                       map_12_9_TEM21__sw_rd_en;
    logic   [63:0]                map_12_9_TEM21__sw_wr_data;
    logic   [63:0]                map_12_9_TEM21__sw_rd_data;
    logic                                       map_12_9_TEM21_alias__sw_wr_en;
    logic                                       map_12_9_TEM21_alias__sw_rd_en;
    logic   [63:0]                map_12_9_TEM21_alias__sw_wr_data;
    logic   [63:0]                map_12_9_TEM21_alias__sw_rd_data;
    logic                                       map_12_9_TEM22__sw_wr_en;
    logic                                       map_12_9_TEM22__sw_rd_en;
    logic   [31:0]                map_12_9_TEM22__sw_wr_data;
    logic   [31:0]                map_12_9_TEM22__sw_rd_data;
    logic                                       map_12_9_TEM22_alias__sw_wr_en;
    logic                                       map_12_9_TEM22_alias__sw_rd_en;
    logic   [31:0]                map_12_9_TEM22_alias__sw_wr_data;
    logic   [31:0]                map_12_9_TEM22_alias__sw_rd_data;
    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_11_0_TEM21_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[1:0]),
        .snap_rd_en                             (reg_sw_rd_sel[1:0]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[1:0]),
        .reg_wr_en                              (map_11_0_TEM21__sw_wr_en),
        .reg_rd_en                              (map_11_0_TEM21__sw_rd_en),
        .reg_wr_data                            (map_11_0_TEM21__sw_wr_data),
        .reg_rd_data                            (map_11_0_TEM21__sw_rd_data)
    );

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b1}}),
        .SWACC                                  ({2{1'b1}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_0_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_0_TEM21__sw_wr_data[13:13], map_11_0_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_11_0_TEM21__sw_rd_en, map_11_0_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_0_TEM21__sw_wr_en, map_11_0_TEM21_alias__sw_wr_en}),
        .swmod_out                              (map_11_0_TEM21__FIELD_3__swmod),
        .swacc_out                              (map_11_0_TEM21__FIELD_3__swacc),
        .hw_value                               (map_11_0_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_11_0_TEM21__FIELD_3__pulse),
        .field_value                            (map_11_0_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_0_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_0_TEM21__sw_wr_data[16:14], map_11_0_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_11_0_TEM21__sw_rd_en, map_11_0_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_0_TEM21__sw_wr_en, map_11_0_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_0_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_11_0_TEM21__FIELD_2__pulse),
        .field_value                            (map_11_0_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_0_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_0_TEM21__sw_wr_data[17:17], map_11_0_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_11_0_TEM21__sw_rd_en, map_11_0_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_0_TEM21__sw_wr_en, map_11_0_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_0_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_11_0_TEM21__FIELD_1__pulse),
        .field_value                            (map_11_0_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_11_0_TEM21__sw_rd_data = 64'h0;
        map_11_0_TEM21__sw_rd_data[13:13] = map_11_0_TEM21__FIELD_3__curr_value;
        map_11_0_TEM21__sw_rd_data[16:14] = map_11_0_TEM21__FIELD_2__curr_value;
        map_11_0_TEM21__sw_rd_data[17:17] = map_11_0_TEM21__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_11_0_TEM21_alias_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[3:2]),
        .snap_rd_en                             (reg_sw_rd_sel[3:2]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[3:2]),
        .reg_wr_en                              (map_11_0_TEM21_alias__sw_wr_en),
        .reg_rd_en                              (map_11_0_TEM21_alias__sw_rd_en),
        .reg_wr_data                            (map_11_0_TEM21_alias__sw_wr_data),
        .reg_rd_data                            (map_11_0_TEM21_alias__sw_rd_data)
    );

    always_comb begin
        map_11_0_TEM21_alias__sw_rd_data = 64'h0;
        map_11_0_TEM21_alias__sw_rd_data[13:13] = map_11_0_TEM21__FIELD_3__curr_value;
        map_11_0_TEM21_alias__sw_rd_data[16:14] = map_11_0_TEM21__FIELD_2__curr_value;
        map_11_0_TEM21_alias__sw_rd_data[17:17] = map_11_0_TEM21__FIELD_1__curr_value;
    end

    assign  map_11_0_TEM22__sw_wr_en              = reg_sw_wr_sel[4];
    assign  map_11_0_TEM22__sw_rd_en              = reg_sw_rd_sel[4];
    assign  map_11_0_TEM22__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[4]   = map_11_0_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_0_TEM22__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_0_TEM22__sw_wr_data[13:13], map_11_0_TEM22_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_11_0_TEM22__sw_rd_en, map_11_0_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_0_TEM22__sw_wr_en, map_11_0_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_0_TEM22__FIELD_3__next_value),
        .hw_pulse                               (map_11_0_TEM22__FIELD_3__pulse),
        .field_value                            (map_11_0_TEM22__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_0_TEM22__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_0_TEM22__sw_wr_data[16:14], map_11_0_TEM22_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_11_0_TEM22__sw_rd_en, map_11_0_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_0_TEM22__sw_wr_en, map_11_0_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_0_TEM22__FIELD_2__next_value),
        .hw_pulse                               (map_11_0_TEM22__FIELD_2__pulse),
        .field_value                            (map_11_0_TEM22__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_0_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_0_TEM22__sw_wr_data[17:17], map_11_0_TEM22_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_11_0_TEM22__sw_rd_en, map_11_0_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_0_TEM22__sw_wr_en, map_11_0_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_0_TEM22__FIELD_1__next_value),
        .hw_pulse                               (map_11_0_TEM22__FIELD_1__pulse),
        .field_value                            (map_11_0_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_11_0_TEM22__sw_rd_data = 32'h0;
        map_11_0_TEM22__sw_rd_data[13:13] = map_11_0_TEM22__FIELD_3__curr_value;
        map_11_0_TEM22__sw_rd_data[16:14] = map_11_0_TEM22__FIELD_2__curr_value;
        map_11_0_TEM22__sw_rd_data[17:17] = map_11_0_TEM22__FIELD_1__curr_value;
    end

    assign  map_11_0_TEM22_alias__sw_wr_en              = reg_sw_wr_sel[5];
    assign  map_11_0_TEM22_alias__sw_rd_en              = reg_sw_rd_sel[5];
    assign  map_11_0_TEM22_alias__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[5]   = map_11_0_TEM22_alias__sw_rd_data;

    always_comb begin
        map_11_0_TEM22_alias__sw_rd_data = 32'h0;
        map_11_0_TEM22_alias__sw_rd_data[13:13] = map_11_0_TEM22__FIELD_3__curr_value;
        map_11_0_TEM22_alias__sw_rd_data[16:14] = map_11_0_TEM22__FIELD_2__curr_value;
        map_11_0_TEM22_alias__sw_rd_data[17:17] = map_11_0_TEM22__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_11_1_TEM21_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[7:6]),
        .snap_rd_en                             (reg_sw_rd_sel[7:6]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[7:6]),
        .reg_wr_en                              (map_11_1_TEM21__sw_wr_en),
        .reg_rd_en                              (map_11_1_TEM21__sw_rd_en),
        .reg_wr_data                            (map_11_1_TEM21__sw_wr_data),
        .reg_rd_data                            (map_11_1_TEM21__sw_rd_data)
    );

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b1}}),
        .SWACC                                  ({2{1'b1}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_1_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_1_TEM21__sw_wr_data[13:13], map_11_1_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_11_1_TEM21__sw_rd_en, map_11_1_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_1_TEM21__sw_wr_en, map_11_1_TEM21_alias__sw_wr_en}),
        .swmod_out                              (map_11_1_TEM21__FIELD_3__swmod),
        .swacc_out                              (map_11_1_TEM21__FIELD_3__swacc),
        .hw_value                               (map_11_1_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_11_1_TEM21__FIELD_3__pulse),
        .field_value                            (map_11_1_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_1_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_1_TEM21__sw_wr_data[16:14], map_11_1_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_11_1_TEM21__sw_rd_en, map_11_1_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_1_TEM21__sw_wr_en, map_11_1_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_1_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_11_1_TEM21__FIELD_2__pulse),
        .field_value                            (map_11_1_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_1_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_1_TEM21__sw_wr_data[17:17], map_11_1_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_11_1_TEM21__sw_rd_en, map_11_1_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_1_TEM21__sw_wr_en, map_11_1_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_1_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_11_1_TEM21__FIELD_1__pulse),
        .field_value                            (map_11_1_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_11_1_TEM21__sw_rd_data = 64'h0;
        map_11_1_TEM21__sw_rd_data[13:13] = map_11_1_TEM21__FIELD_3__curr_value;
        map_11_1_TEM21__sw_rd_data[16:14] = map_11_1_TEM21__FIELD_2__curr_value;
        map_11_1_TEM21__sw_rd_data[17:17] = map_11_1_TEM21__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_11_1_TEM21_alias_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[9:8]),
        .snap_rd_en                             (reg_sw_rd_sel[9:8]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[9:8]),
        .reg_wr_en                              (map_11_1_TEM21_alias__sw_wr_en),
        .reg_rd_en                              (map_11_1_TEM21_alias__sw_rd_en),
        .reg_wr_data                            (map_11_1_TEM21_alias__sw_wr_data),
        .reg_rd_data                            (map_11_1_TEM21_alias__sw_rd_data)
    );

    always_comb begin
        map_11_1_TEM21_alias__sw_rd_data = 64'h0;
        map_11_1_TEM21_alias__sw_rd_data[13:13] = map_11_1_TEM21__FIELD_3__curr_value;
        map_11_1_TEM21_alias__sw_rd_data[16:14] = map_11_1_TEM21__FIELD_2__curr_value;
        map_11_1_TEM21_alias__sw_rd_data[17:17] = map_11_1_TEM21__FIELD_1__curr_value;
    end

    assign  map_11_1_TEM22__sw_wr_en              = reg_sw_wr_sel[10];
    assign  map_11_1_TEM22__sw_rd_en              = reg_sw_rd_sel[10];
    assign  map_11_1_TEM22__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[10]   = map_11_1_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_1_TEM22__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_1_TEM22__sw_wr_data[13:13], map_11_1_TEM22_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_11_1_TEM22__sw_rd_en, map_11_1_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_1_TEM22__sw_wr_en, map_11_1_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_1_TEM22__FIELD_3__next_value),
        .hw_pulse                               (map_11_1_TEM22__FIELD_3__pulse),
        .field_value                            (map_11_1_TEM22__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_1_TEM22__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_1_TEM22__sw_wr_data[16:14], map_11_1_TEM22_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_11_1_TEM22__sw_rd_en, map_11_1_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_1_TEM22__sw_wr_en, map_11_1_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_1_TEM22__FIELD_2__next_value),
        .hw_pulse                               (map_11_1_TEM22__FIELD_2__pulse),
        .field_value                            (map_11_1_TEM22__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_1_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_1_TEM22__sw_wr_data[17:17], map_11_1_TEM22_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_11_1_TEM22__sw_rd_en, map_11_1_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_1_TEM22__sw_wr_en, map_11_1_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_1_TEM22__FIELD_1__next_value),
        .hw_pulse                               (map_11_1_TEM22__FIELD_1__pulse),
        .field_value                            (map_11_1_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_11_1_TEM22__sw_rd_data = 32'h0;
        map_11_1_TEM22__sw_rd_data[13:13] = map_11_1_TEM22__FIELD_3__curr_value;
        map_11_1_TEM22__sw_rd_data[16:14] = map_11_1_TEM22__FIELD_2__curr_value;
        map_11_1_TEM22__sw_rd_data[17:17] = map_11_1_TEM22__FIELD_1__curr_value;
    end

    assign  map_11_1_TEM22_alias__sw_wr_en              = reg_sw_wr_sel[11];
    assign  map_11_1_TEM22_alias__sw_rd_en              = reg_sw_rd_sel[11];
    assign  map_11_1_TEM22_alias__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[11]   = map_11_1_TEM22_alias__sw_rd_data;

    always_comb begin
        map_11_1_TEM22_alias__sw_rd_data = 32'h0;
        map_11_1_TEM22_alias__sw_rd_data[13:13] = map_11_1_TEM22__FIELD_3__curr_value;
        map_11_1_TEM22_alias__sw_rd_data[16:14] = map_11_1_TEM22__FIELD_2__curr_value;
        map_11_1_TEM22_alias__sw_rd_data[17:17] = map_11_1_TEM22__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_11_2_TEM21_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[13:12]),
        .snap_rd_en                             (reg_sw_rd_sel[13:12]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[13:12]),
        .reg_wr_en                              (map_11_2_TEM21__sw_wr_en),
        .reg_rd_en                              (map_11_2_TEM21__sw_rd_en),
        .reg_wr_data                            (map_11_2_TEM21__sw_wr_data),
        .reg_rd_data                            (map_11_2_TEM21__sw_rd_data)
    );

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b1}}),
        .SWACC                                  ({2{1'b1}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_2_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_2_TEM21__sw_wr_data[13:13], map_11_2_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_11_2_TEM21__sw_rd_en, map_11_2_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_2_TEM21__sw_wr_en, map_11_2_TEM21_alias__sw_wr_en}),
        .swmod_out                              (map_11_2_TEM21__FIELD_3__swmod),
        .swacc_out                              (map_11_2_TEM21__FIELD_3__swacc),
        .hw_value                               (map_11_2_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_11_2_TEM21__FIELD_3__pulse),
        .field_value                            (map_11_2_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_2_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_2_TEM21__sw_wr_data[16:14], map_11_2_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_11_2_TEM21__sw_rd_en, map_11_2_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_2_TEM21__sw_wr_en, map_11_2_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_2_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_11_2_TEM21__FIELD_2__pulse),
        .field_value                            (map_11_2_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_2_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_2_TEM21__sw_wr_data[17:17], map_11_2_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_11_2_TEM21__sw_rd_en, map_11_2_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_2_TEM21__sw_wr_en, map_11_2_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_2_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_11_2_TEM21__FIELD_1__pulse),
        .field_value                            (map_11_2_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_11_2_TEM21__sw_rd_data = 64'h0;
        map_11_2_TEM21__sw_rd_data[13:13] = map_11_2_TEM21__FIELD_3__curr_value;
        map_11_2_TEM21__sw_rd_data[16:14] = map_11_2_TEM21__FIELD_2__curr_value;
        map_11_2_TEM21__sw_rd_data[17:17] = map_11_2_TEM21__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_11_2_TEM21_alias_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[15:14]),
        .snap_rd_en                             (reg_sw_rd_sel[15:14]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[15:14]),
        .reg_wr_en                              (map_11_2_TEM21_alias__sw_wr_en),
        .reg_rd_en                              (map_11_2_TEM21_alias__sw_rd_en),
        .reg_wr_data                            (map_11_2_TEM21_alias__sw_wr_data),
        .reg_rd_data                            (map_11_2_TEM21_alias__sw_rd_data)
    );

    always_comb begin
        map_11_2_TEM21_alias__sw_rd_data = 64'h0;
        map_11_2_TEM21_alias__sw_rd_data[13:13] = map_11_2_TEM21__FIELD_3__curr_value;
        map_11_2_TEM21_alias__sw_rd_data[16:14] = map_11_2_TEM21__FIELD_2__curr_value;
        map_11_2_TEM21_alias__sw_rd_data[17:17] = map_11_2_TEM21__FIELD_1__curr_value;
    end

    assign  map_11_2_TEM22__sw_wr_en              = reg_sw_wr_sel[16];
    assign  map_11_2_TEM22__sw_rd_en              = reg_sw_rd_sel[16];
    assign  map_11_2_TEM22__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[16]   = map_11_2_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_2_TEM22__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_2_TEM22__sw_wr_data[13:13], map_11_2_TEM22_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_11_2_TEM22__sw_rd_en, map_11_2_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_2_TEM22__sw_wr_en, map_11_2_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_2_TEM22__FIELD_3__next_value),
        .hw_pulse                               (map_11_2_TEM22__FIELD_3__pulse),
        .field_value                            (map_11_2_TEM22__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_2_TEM22__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_2_TEM22__sw_wr_data[16:14], map_11_2_TEM22_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_11_2_TEM22__sw_rd_en, map_11_2_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_2_TEM22__sw_wr_en, map_11_2_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_2_TEM22__FIELD_2__next_value),
        .hw_pulse                               (map_11_2_TEM22__FIELD_2__pulse),
        .field_value                            (map_11_2_TEM22__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_2_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_2_TEM22__sw_wr_data[17:17], map_11_2_TEM22_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_11_2_TEM22__sw_rd_en, map_11_2_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_2_TEM22__sw_wr_en, map_11_2_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_2_TEM22__FIELD_1__next_value),
        .hw_pulse                               (map_11_2_TEM22__FIELD_1__pulse),
        .field_value                            (map_11_2_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_11_2_TEM22__sw_rd_data = 32'h0;
        map_11_2_TEM22__sw_rd_data[13:13] = map_11_2_TEM22__FIELD_3__curr_value;
        map_11_2_TEM22__sw_rd_data[16:14] = map_11_2_TEM22__FIELD_2__curr_value;
        map_11_2_TEM22__sw_rd_data[17:17] = map_11_2_TEM22__FIELD_1__curr_value;
    end

    assign  map_11_2_TEM22_alias__sw_wr_en              = reg_sw_wr_sel[17];
    assign  map_11_2_TEM22_alias__sw_rd_en              = reg_sw_rd_sel[17];
    assign  map_11_2_TEM22_alias__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[17]   = map_11_2_TEM22_alias__sw_rd_data;

    always_comb begin
        map_11_2_TEM22_alias__sw_rd_data = 32'h0;
        map_11_2_TEM22_alias__sw_rd_data[13:13] = map_11_2_TEM22__FIELD_3__curr_value;
        map_11_2_TEM22_alias__sw_rd_data[16:14] = map_11_2_TEM22__FIELD_2__curr_value;
        map_11_2_TEM22_alias__sw_rd_data[17:17] = map_11_2_TEM22__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_11_3_TEM21_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[19:18]),
        .snap_rd_en                             (reg_sw_rd_sel[19:18]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[19:18]),
        .reg_wr_en                              (map_11_3_TEM21__sw_wr_en),
        .reg_rd_en                              (map_11_3_TEM21__sw_rd_en),
        .reg_wr_data                            (map_11_3_TEM21__sw_wr_data),
        .reg_rd_data                            (map_11_3_TEM21__sw_rd_data)
    );

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b1}}),
        .SWACC                                  ({2{1'b1}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_3_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_3_TEM21__sw_wr_data[13:13], map_11_3_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_11_3_TEM21__sw_rd_en, map_11_3_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_3_TEM21__sw_wr_en, map_11_3_TEM21_alias__sw_wr_en}),
        .swmod_out                              (map_11_3_TEM21__FIELD_3__swmod),
        .swacc_out                              (map_11_3_TEM21__FIELD_3__swacc),
        .hw_value                               (map_11_3_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_11_3_TEM21__FIELD_3__pulse),
        .field_value                            (map_11_3_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_3_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_3_TEM21__sw_wr_data[16:14], map_11_3_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_11_3_TEM21__sw_rd_en, map_11_3_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_3_TEM21__sw_wr_en, map_11_3_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_3_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_11_3_TEM21__FIELD_2__pulse),
        .field_value                            (map_11_3_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_3_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_3_TEM21__sw_wr_data[17:17], map_11_3_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_11_3_TEM21__sw_rd_en, map_11_3_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_3_TEM21__sw_wr_en, map_11_3_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_3_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_11_3_TEM21__FIELD_1__pulse),
        .field_value                            (map_11_3_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_11_3_TEM21__sw_rd_data = 64'h0;
        map_11_3_TEM21__sw_rd_data[13:13] = map_11_3_TEM21__FIELD_3__curr_value;
        map_11_3_TEM21__sw_rd_data[16:14] = map_11_3_TEM21__FIELD_2__curr_value;
        map_11_3_TEM21__sw_rd_data[17:17] = map_11_3_TEM21__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_11_3_TEM21_alias_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[21:20]),
        .snap_rd_en                             (reg_sw_rd_sel[21:20]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[21:20]),
        .reg_wr_en                              (map_11_3_TEM21_alias__sw_wr_en),
        .reg_rd_en                              (map_11_3_TEM21_alias__sw_rd_en),
        .reg_wr_data                            (map_11_3_TEM21_alias__sw_wr_data),
        .reg_rd_data                            (map_11_3_TEM21_alias__sw_rd_data)
    );

    always_comb begin
        map_11_3_TEM21_alias__sw_rd_data = 64'h0;
        map_11_3_TEM21_alias__sw_rd_data[13:13] = map_11_3_TEM21__FIELD_3__curr_value;
        map_11_3_TEM21_alias__sw_rd_data[16:14] = map_11_3_TEM21__FIELD_2__curr_value;
        map_11_3_TEM21_alias__sw_rd_data[17:17] = map_11_3_TEM21__FIELD_1__curr_value;
    end

    assign  map_11_3_TEM22__sw_wr_en              = reg_sw_wr_sel[22];
    assign  map_11_3_TEM22__sw_rd_en              = reg_sw_rd_sel[22];
    assign  map_11_3_TEM22__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[22]   = map_11_3_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_3_TEM22__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_3_TEM22__sw_wr_data[13:13], map_11_3_TEM22_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_11_3_TEM22__sw_rd_en, map_11_3_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_3_TEM22__sw_wr_en, map_11_3_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_3_TEM22__FIELD_3__next_value),
        .hw_pulse                               (map_11_3_TEM22__FIELD_3__pulse),
        .field_value                            (map_11_3_TEM22__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_3_TEM22__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_3_TEM22__sw_wr_data[16:14], map_11_3_TEM22_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_11_3_TEM22__sw_rd_en, map_11_3_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_3_TEM22__sw_wr_en, map_11_3_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_3_TEM22__FIELD_2__next_value),
        .hw_pulse                               (map_11_3_TEM22__FIELD_2__pulse),
        .field_value                            (map_11_3_TEM22__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_3_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_3_TEM22__sw_wr_data[17:17], map_11_3_TEM22_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_11_3_TEM22__sw_rd_en, map_11_3_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_3_TEM22__sw_wr_en, map_11_3_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_3_TEM22__FIELD_1__next_value),
        .hw_pulse                               (map_11_3_TEM22__FIELD_1__pulse),
        .field_value                            (map_11_3_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_11_3_TEM22__sw_rd_data = 32'h0;
        map_11_3_TEM22__sw_rd_data[13:13] = map_11_3_TEM22__FIELD_3__curr_value;
        map_11_3_TEM22__sw_rd_data[16:14] = map_11_3_TEM22__FIELD_2__curr_value;
        map_11_3_TEM22__sw_rd_data[17:17] = map_11_3_TEM22__FIELD_1__curr_value;
    end

    assign  map_11_3_TEM22_alias__sw_wr_en              = reg_sw_wr_sel[23];
    assign  map_11_3_TEM22_alias__sw_rd_en              = reg_sw_rd_sel[23];
    assign  map_11_3_TEM22_alias__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[23]   = map_11_3_TEM22_alias__sw_rd_data;

    always_comb begin
        map_11_3_TEM22_alias__sw_rd_data = 32'h0;
        map_11_3_TEM22_alias__sw_rd_data[13:13] = map_11_3_TEM22__FIELD_3__curr_value;
        map_11_3_TEM22_alias__sw_rd_data[16:14] = map_11_3_TEM22__FIELD_2__curr_value;
        map_11_3_TEM22_alias__sw_rd_data[17:17] = map_11_3_TEM22__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_11_4_TEM21_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[25:24]),
        .snap_rd_en                             (reg_sw_rd_sel[25:24]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[25:24]),
        .reg_wr_en                              (map_11_4_TEM21__sw_wr_en),
        .reg_rd_en                              (map_11_4_TEM21__sw_rd_en),
        .reg_wr_data                            (map_11_4_TEM21__sw_wr_data),
        .reg_rd_data                            (map_11_4_TEM21__sw_rd_data)
    );

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b1}}),
        .SWACC                                  ({2{1'b1}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_4_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_4_TEM21__sw_wr_data[13:13], map_11_4_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_11_4_TEM21__sw_rd_en, map_11_4_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_4_TEM21__sw_wr_en, map_11_4_TEM21_alias__sw_wr_en}),
        .swmod_out                              (map_11_4_TEM21__FIELD_3__swmod),
        .swacc_out                              (map_11_4_TEM21__FIELD_3__swacc),
        .hw_value                               (map_11_4_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_11_4_TEM21__FIELD_3__pulse),
        .field_value                            (map_11_4_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_4_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_4_TEM21__sw_wr_data[16:14], map_11_4_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_11_4_TEM21__sw_rd_en, map_11_4_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_4_TEM21__sw_wr_en, map_11_4_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_4_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_11_4_TEM21__FIELD_2__pulse),
        .field_value                            (map_11_4_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_4_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_4_TEM21__sw_wr_data[17:17], map_11_4_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_11_4_TEM21__sw_rd_en, map_11_4_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_4_TEM21__sw_wr_en, map_11_4_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_4_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_11_4_TEM21__FIELD_1__pulse),
        .field_value                            (map_11_4_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_11_4_TEM21__sw_rd_data = 64'h0;
        map_11_4_TEM21__sw_rd_data[13:13] = map_11_4_TEM21__FIELD_3__curr_value;
        map_11_4_TEM21__sw_rd_data[16:14] = map_11_4_TEM21__FIELD_2__curr_value;
        map_11_4_TEM21__sw_rd_data[17:17] = map_11_4_TEM21__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_11_4_TEM21_alias_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[27:26]),
        .snap_rd_en                             (reg_sw_rd_sel[27:26]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[27:26]),
        .reg_wr_en                              (map_11_4_TEM21_alias__sw_wr_en),
        .reg_rd_en                              (map_11_4_TEM21_alias__sw_rd_en),
        .reg_wr_data                            (map_11_4_TEM21_alias__sw_wr_data),
        .reg_rd_data                            (map_11_4_TEM21_alias__sw_rd_data)
    );

    always_comb begin
        map_11_4_TEM21_alias__sw_rd_data = 64'h0;
        map_11_4_TEM21_alias__sw_rd_data[13:13] = map_11_4_TEM21__FIELD_3__curr_value;
        map_11_4_TEM21_alias__sw_rd_data[16:14] = map_11_4_TEM21__FIELD_2__curr_value;
        map_11_4_TEM21_alias__sw_rd_data[17:17] = map_11_4_TEM21__FIELD_1__curr_value;
    end

    assign  map_11_4_TEM22__sw_wr_en              = reg_sw_wr_sel[28];
    assign  map_11_4_TEM22__sw_rd_en              = reg_sw_rd_sel[28];
    assign  map_11_4_TEM22__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[28]   = map_11_4_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_4_TEM22__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_4_TEM22__sw_wr_data[13:13], map_11_4_TEM22_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_11_4_TEM22__sw_rd_en, map_11_4_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_4_TEM22__sw_wr_en, map_11_4_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_4_TEM22__FIELD_3__next_value),
        .hw_pulse                               (map_11_4_TEM22__FIELD_3__pulse),
        .field_value                            (map_11_4_TEM22__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_4_TEM22__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_4_TEM22__sw_wr_data[16:14], map_11_4_TEM22_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_11_4_TEM22__sw_rd_en, map_11_4_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_4_TEM22__sw_wr_en, map_11_4_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_4_TEM22__FIELD_2__next_value),
        .hw_pulse                               (map_11_4_TEM22__FIELD_2__pulse),
        .field_value                            (map_11_4_TEM22__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_11_4_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_11_4_TEM22__sw_wr_data[17:17], map_11_4_TEM22_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_11_4_TEM22__sw_rd_en, map_11_4_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_11_4_TEM22__sw_wr_en, map_11_4_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_11_4_TEM22__FIELD_1__next_value),
        .hw_pulse                               (map_11_4_TEM22__FIELD_1__pulse),
        .field_value                            (map_11_4_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_11_4_TEM22__sw_rd_data = 32'h0;
        map_11_4_TEM22__sw_rd_data[13:13] = map_11_4_TEM22__FIELD_3__curr_value;
        map_11_4_TEM22__sw_rd_data[16:14] = map_11_4_TEM22__FIELD_2__curr_value;
        map_11_4_TEM22__sw_rd_data[17:17] = map_11_4_TEM22__FIELD_1__curr_value;
    end

    assign  map_11_4_TEM22_alias__sw_wr_en              = reg_sw_wr_sel[29];
    assign  map_11_4_TEM22_alias__sw_rd_en              = reg_sw_rd_sel[29];
    assign  map_11_4_TEM22_alias__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[29]   = map_11_4_TEM22_alias__sw_rd_data;

    always_comb begin
        map_11_4_TEM22_alias__sw_rd_data = 32'h0;
        map_11_4_TEM22_alias__sw_rd_data[13:13] = map_11_4_TEM22__FIELD_3__curr_value;
        map_11_4_TEM22_alias__sw_rd_data[16:14] = map_11_4_TEM22__FIELD_2__curr_value;
        map_11_4_TEM22_alias__sw_rd_data[17:17] = map_11_4_TEM22__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_0_TEM21_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[31:30]),
        .snap_rd_en                             (reg_sw_rd_sel[31:30]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[31:30]),
        .reg_wr_en                              (map_12_0_TEM21__sw_wr_en),
        .reg_rd_en                              (map_12_0_TEM21__sw_rd_en),
        .reg_wr_data                            (map_12_0_TEM21__sw_wr_data),
        .reg_rd_data                            (map_12_0_TEM21__sw_rd_data)
    );

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b1}}),
        .SWACC                                  ({2{1'b1}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_0_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_0_TEM21__sw_wr_data[13:13], map_12_0_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_0_TEM21__sw_rd_en, map_12_0_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_0_TEM21__sw_wr_en, map_12_0_TEM21_alias__sw_wr_en}),
        .swmod_out                              (map_12_0_TEM21__FIELD_3__swmod),
        .swacc_out                              (map_12_0_TEM21__FIELD_3__swacc),
        .hw_value                               (map_12_0_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_0_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_0_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_0_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_0_TEM21__sw_wr_data[16:14], map_12_0_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_0_TEM21__sw_rd_en, map_12_0_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_0_TEM21__sw_wr_en, map_12_0_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_0_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_0_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_0_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_0_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_0_TEM21__sw_wr_data[17:17], map_12_0_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_0_TEM21__sw_rd_en, map_12_0_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_0_TEM21__sw_wr_en, map_12_0_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_0_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_0_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_0_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_0_TEM21__sw_rd_data = 64'h0;
        map_12_0_TEM21__sw_rd_data[13:13] = map_12_0_TEM21__FIELD_3__curr_value;
        map_12_0_TEM21__sw_rd_data[16:14] = map_12_0_TEM21__FIELD_2__curr_value;
        map_12_0_TEM21__sw_rd_data[17:17] = map_12_0_TEM21__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_0_TEM21_alias_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[33:32]),
        .snap_rd_en                             (reg_sw_rd_sel[33:32]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[33:32]),
        .reg_wr_en                              (map_12_0_TEM21_alias__sw_wr_en),
        .reg_rd_en                              (map_12_0_TEM21_alias__sw_rd_en),
        .reg_wr_data                            (map_12_0_TEM21_alias__sw_wr_data),
        .reg_rd_data                            (map_12_0_TEM21_alias__sw_rd_data)
    );

    always_comb begin
        map_12_0_TEM21_alias__sw_rd_data = 64'h0;
        map_12_0_TEM21_alias__sw_rd_data[13:13] = map_12_0_TEM21__FIELD_3__curr_value;
        map_12_0_TEM21_alias__sw_rd_data[16:14] = map_12_0_TEM21__FIELD_2__curr_value;
        map_12_0_TEM21_alias__sw_rd_data[17:17] = map_12_0_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_0_TEM22__sw_wr_en              = reg_sw_wr_sel[34];
    assign  map_12_0_TEM22__sw_rd_en              = reg_sw_rd_sel[34];
    assign  map_12_0_TEM22__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[34]   = map_12_0_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_0_TEM22__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_0_TEM22__sw_wr_data[13:13], map_12_0_TEM22_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_0_TEM22__sw_rd_en, map_12_0_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_0_TEM22__sw_wr_en, map_12_0_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_0_TEM22__FIELD_3__next_value),
        .hw_pulse                               (map_12_0_TEM22__FIELD_3__pulse),
        .field_value                            (map_12_0_TEM22__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_0_TEM22__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_0_TEM22__sw_wr_data[16:14], map_12_0_TEM22_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_0_TEM22__sw_rd_en, map_12_0_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_0_TEM22__sw_wr_en, map_12_0_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_0_TEM22__FIELD_2__next_value),
        .hw_pulse                               (map_12_0_TEM22__FIELD_2__pulse),
        .field_value                            (map_12_0_TEM22__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_0_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_0_TEM22__sw_wr_data[17:17], map_12_0_TEM22_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_0_TEM22__sw_rd_en, map_12_0_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_0_TEM22__sw_wr_en, map_12_0_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_0_TEM22__FIELD_1__next_value),
        .hw_pulse                               (map_12_0_TEM22__FIELD_1__pulse),
        .field_value                            (map_12_0_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_0_TEM22__sw_rd_data = 32'h0;
        map_12_0_TEM22__sw_rd_data[13:13] = map_12_0_TEM22__FIELD_3__curr_value;
        map_12_0_TEM22__sw_rd_data[16:14] = map_12_0_TEM22__FIELD_2__curr_value;
        map_12_0_TEM22__sw_rd_data[17:17] = map_12_0_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_0_TEM22_alias__sw_wr_en              = reg_sw_wr_sel[35];
    assign  map_12_0_TEM22_alias__sw_rd_en              = reg_sw_rd_sel[35];
    assign  map_12_0_TEM22_alias__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[35]   = map_12_0_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_0_TEM22_alias__sw_rd_data = 32'h0;
        map_12_0_TEM22_alias__sw_rd_data[13:13] = map_12_0_TEM22__FIELD_3__curr_value;
        map_12_0_TEM22_alias__sw_rd_data[16:14] = map_12_0_TEM22__FIELD_2__curr_value;
        map_12_0_TEM22_alias__sw_rd_data[17:17] = map_12_0_TEM22__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_1_TEM21_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[37:36]),
        .snap_rd_en                             (reg_sw_rd_sel[37:36]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[37:36]),
        .reg_wr_en                              (map_12_1_TEM21__sw_wr_en),
        .reg_rd_en                              (map_12_1_TEM21__sw_rd_en),
        .reg_wr_data                            (map_12_1_TEM21__sw_wr_data),
        .reg_rd_data                            (map_12_1_TEM21__sw_rd_data)
    );

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b1}}),
        .SWACC                                  ({2{1'b1}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_1_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_1_TEM21__sw_wr_data[13:13], map_12_1_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_1_TEM21__sw_rd_en, map_12_1_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_1_TEM21__sw_wr_en, map_12_1_TEM21_alias__sw_wr_en}),
        .swmod_out                              (map_12_1_TEM21__FIELD_3__swmod),
        .swacc_out                              (map_12_1_TEM21__FIELD_3__swacc),
        .hw_value                               (map_12_1_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_1_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_1_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_1_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_1_TEM21__sw_wr_data[16:14], map_12_1_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_1_TEM21__sw_rd_en, map_12_1_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_1_TEM21__sw_wr_en, map_12_1_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_1_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_1_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_1_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_1_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_1_TEM21__sw_wr_data[17:17], map_12_1_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_1_TEM21__sw_rd_en, map_12_1_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_1_TEM21__sw_wr_en, map_12_1_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_1_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_1_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_1_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_1_TEM21__sw_rd_data = 64'h0;
        map_12_1_TEM21__sw_rd_data[13:13] = map_12_1_TEM21__FIELD_3__curr_value;
        map_12_1_TEM21__sw_rd_data[16:14] = map_12_1_TEM21__FIELD_2__curr_value;
        map_12_1_TEM21__sw_rd_data[17:17] = map_12_1_TEM21__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_1_TEM21_alias_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[39:38]),
        .snap_rd_en                             (reg_sw_rd_sel[39:38]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[39:38]),
        .reg_wr_en                              (map_12_1_TEM21_alias__sw_wr_en),
        .reg_rd_en                              (map_12_1_TEM21_alias__sw_rd_en),
        .reg_wr_data                            (map_12_1_TEM21_alias__sw_wr_data),
        .reg_rd_data                            (map_12_1_TEM21_alias__sw_rd_data)
    );

    always_comb begin
        map_12_1_TEM21_alias__sw_rd_data = 64'h0;
        map_12_1_TEM21_alias__sw_rd_data[13:13] = map_12_1_TEM21__FIELD_3__curr_value;
        map_12_1_TEM21_alias__sw_rd_data[16:14] = map_12_1_TEM21__FIELD_2__curr_value;
        map_12_1_TEM21_alias__sw_rd_data[17:17] = map_12_1_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_1_TEM22__sw_wr_en              = reg_sw_wr_sel[40];
    assign  map_12_1_TEM22__sw_rd_en              = reg_sw_rd_sel[40];
    assign  map_12_1_TEM22__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[40]   = map_12_1_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_1_TEM22__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_1_TEM22__sw_wr_data[13:13], map_12_1_TEM22_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_1_TEM22__sw_rd_en, map_12_1_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_1_TEM22__sw_wr_en, map_12_1_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_1_TEM22__FIELD_3__next_value),
        .hw_pulse                               (map_12_1_TEM22__FIELD_3__pulse),
        .field_value                            (map_12_1_TEM22__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_1_TEM22__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_1_TEM22__sw_wr_data[16:14], map_12_1_TEM22_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_1_TEM22__sw_rd_en, map_12_1_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_1_TEM22__sw_wr_en, map_12_1_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_1_TEM22__FIELD_2__next_value),
        .hw_pulse                               (map_12_1_TEM22__FIELD_2__pulse),
        .field_value                            (map_12_1_TEM22__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_1_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_1_TEM22__sw_wr_data[17:17], map_12_1_TEM22_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_1_TEM22__sw_rd_en, map_12_1_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_1_TEM22__sw_wr_en, map_12_1_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_1_TEM22__FIELD_1__next_value),
        .hw_pulse                               (map_12_1_TEM22__FIELD_1__pulse),
        .field_value                            (map_12_1_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_1_TEM22__sw_rd_data = 32'h0;
        map_12_1_TEM22__sw_rd_data[13:13] = map_12_1_TEM22__FIELD_3__curr_value;
        map_12_1_TEM22__sw_rd_data[16:14] = map_12_1_TEM22__FIELD_2__curr_value;
        map_12_1_TEM22__sw_rd_data[17:17] = map_12_1_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_1_TEM22_alias__sw_wr_en              = reg_sw_wr_sel[41];
    assign  map_12_1_TEM22_alias__sw_rd_en              = reg_sw_rd_sel[41];
    assign  map_12_1_TEM22_alias__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[41]   = map_12_1_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_1_TEM22_alias__sw_rd_data = 32'h0;
        map_12_1_TEM22_alias__sw_rd_data[13:13] = map_12_1_TEM22__FIELD_3__curr_value;
        map_12_1_TEM22_alias__sw_rd_data[16:14] = map_12_1_TEM22__FIELD_2__curr_value;
        map_12_1_TEM22_alias__sw_rd_data[17:17] = map_12_1_TEM22__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_2_TEM21_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[43:42]),
        .snap_rd_en                             (reg_sw_rd_sel[43:42]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[43:42]),
        .reg_wr_en                              (map_12_2_TEM21__sw_wr_en),
        .reg_rd_en                              (map_12_2_TEM21__sw_rd_en),
        .reg_wr_data                            (map_12_2_TEM21__sw_wr_data),
        .reg_rd_data                            (map_12_2_TEM21__sw_rd_data)
    );

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b1}}),
        .SWACC                                  ({2{1'b1}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_2_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_2_TEM21__sw_wr_data[13:13], map_12_2_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_2_TEM21__sw_rd_en, map_12_2_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_2_TEM21__sw_wr_en, map_12_2_TEM21_alias__sw_wr_en}),
        .swmod_out                              (map_12_2_TEM21__FIELD_3__swmod),
        .swacc_out                              (map_12_2_TEM21__FIELD_3__swacc),
        .hw_value                               (map_12_2_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_2_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_2_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_2_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_2_TEM21__sw_wr_data[16:14], map_12_2_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_2_TEM21__sw_rd_en, map_12_2_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_2_TEM21__sw_wr_en, map_12_2_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_2_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_2_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_2_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_2_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_2_TEM21__sw_wr_data[17:17], map_12_2_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_2_TEM21__sw_rd_en, map_12_2_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_2_TEM21__sw_wr_en, map_12_2_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_2_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_2_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_2_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_2_TEM21__sw_rd_data = 64'h0;
        map_12_2_TEM21__sw_rd_data[13:13] = map_12_2_TEM21__FIELD_3__curr_value;
        map_12_2_TEM21__sw_rd_data[16:14] = map_12_2_TEM21__FIELD_2__curr_value;
        map_12_2_TEM21__sw_rd_data[17:17] = map_12_2_TEM21__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_2_TEM21_alias_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[45:44]),
        .snap_rd_en                             (reg_sw_rd_sel[45:44]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[45:44]),
        .reg_wr_en                              (map_12_2_TEM21_alias__sw_wr_en),
        .reg_rd_en                              (map_12_2_TEM21_alias__sw_rd_en),
        .reg_wr_data                            (map_12_2_TEM21_alias__sw_wr_data),
        .reg_rd_data                            (map_12_2_TEM21_alias__sw_rd_data)
    );

    always_comb begin
        map_12_2_TEM21_alias__sw_rd_data = 64'h0;
        map_12_2_TEM21_alias__sw_rd_data[13:13] = map_12_2_TEM21__FIELD_3__curr_value;
        map_12_2_TEM21_alias__sw_rd_data[16:14] = map_12_2_TEM21__FIELD_2__curr_value;
        map_12_2_TEM21_alias__sw_rd_data[17:17] = map_12_2_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_2_TEM22__sw_wr_en              = reg_sw_wr_sel[46];
    assign  map_12_2_TEM22__sw_rd_en              = reg_sw_rd_sel[46];
    assign  map_12_2_TEM22__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[46]   = map_12_2_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_2_TEM22__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_2_TEM22__sw_wr_data[13:13], map_12_2_TEM22_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_2_TEM22__sw_rd_en, map_12_2_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_2_TEM22__sw_wr_en, map_12_2_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_2_TEM22__FIELD_3__next_value),
        .hw_pulse                               (map_12_2_TEM22__FIELD_3__pulse),
        .field_value                            (map_12_2_TEM22__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_2_TEM22__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_2_TEM22__sw_wr_data[16:14], map_12_2_TEM22_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_2_TEM22__sw_rd_en, map_12_2_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_2_TEM22__sw_wr_en, map_12_2_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_2_TEM22__FIELD_2__next_value),
        .hw_pulse                               (map_12_2_TEM22__FIELD_2__pulse),
        .field_value                            (map_12_2_TEM22__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_2_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_2_TEM22__sw_wr_data[17:17], map_12_2_TEM22_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_2_TEM22__sw_rd_en, map_12_2_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_2_TEM22__sw_wr_en, map_12_2_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_2_TEM22__FIELD_1__next_value),
        .hw_pulse                               (map_12_2_TEM22__FIELD_1__pulse),
        .field_value                            (map_12_2_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_2_TEM22__sw_rd_data = 32'h0;
        map_12_2_TEM22__sw_rd_data[13:13] = map_12_2_TEM22__FIELD_3__curr_value;
        map_12_2_TEM22__sw_rd_data[16:14] = map_12_2_TEM22__FIELD_2__curr_value;
        map_12_2_TEM22__sw_rd_data[17:17] = map_12_2_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_2_TEM22_alias__sw_wr_en              = reg_sw_wr_sel[47];
    assign  map_12_2_TEM22_alias__sw_rd_en              = reg_sw_rd_sel[47];
    assign  map_12_2_TEM22_alias__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[47]   = map_12_2_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_2_TEM22_alias__sw_rd_data = 32'h0;
        map_12_2_TEM22_alias__sw_rd_data[13:13] = map_12_2_TEM22__FIELD_3__curr_value;
        map_12_2_TEM22_alias__sw_rd_data[16:14] = map_12_2_TEM22__FIELD_2__curr_value;
        map_12_2_TEM22_alias__sw_rd_data[17:17] = map_12_2_TEM22__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_3_TEM21_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[49:48]),
        .snap_rd_en                             (reg_sw_rd_sel[49:48]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[49:48]),
        .reg_wr_en                              (map_12_3_TEM21__sw_wr_en),
        .reg_rd_en                              (map_12_3_TEM21__sw_rd_en),
        .reg_wr_data                            (map_12_3_TEM21__sw_wr_data),
        .reg_rd_data                            (map_12_3_TEM21__sw_rd_data)
    );

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b1}}),
        .SWACC                                  ({2{1'b1}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_3_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_3_TEM21__sw_wr_data[13:13], map_12_3_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_3_TEM21__sw_rd_en, map_12_3_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_3_TEM21__sw_wr_en, map_12_3_TEM21_alias__sw_wr_en}),
        .swmod_out                              (map_12_3_TEM21__FIELD_3__swmod),
        .swacc_out                              (map_12_3_TEM21__FIELD_3__swacc),
        .hw_value                               (map_12_3_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_3_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_3_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_3_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_3_TEM21__sw_wr_data[16:14], map_12_3_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_3_TEM21__sw_rd_en, map_12_3_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_3_TEM21__sw_wr_en, map_12_3_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_3_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_3_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_3_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_3_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_3_TEM21__sw_wr_data[17:17], map_12_3_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_3_TEM21__sw_rd_en, map_12_3_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_3_TEM21__sw_wr_en, map_12_3_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_3_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_3_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_3_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_3_TEM21__sw_rd_data = 64'h0;
        map_12_3_TEM21__sw_rd_data[13:13] = map_12_3_TEM21__FIELD_3__curr_value;
        map_12_3_TEM21__sw_rd_data[16:14] = map_12_3_TEM21__FIELD_2__curr_value;
        map_12_3_TEM21__sw_rd_data[17:17] = map_12_3_TEM21__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_3_TEM21_alias_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[51:50]),
        .snap_rd_en                             (reg_sw_rd_sel[51:50]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[51:50]),
        .reg_wr_en                              (map_12_3_TEM21_alias__sw_wr_en),
        .reg_rd_en                              (map_12_3_TEM21_alias__sw_rd_en),
        .reg_wr_data                            (map_12_3_TEM21_alias__sw_wr_data),
        .reg_rd_data                            (map_12_3_TEM21_alias__sw_rd_data)
    );

    always_comb begin
        map_12_3_TEM21_alias__sw_rd_data = 64'h0;
        map_12_3_TEM21_alias__sw_rd_data[13:13] = map_12_3_TEM21__FIELD_3__curr_value;
        map_12_3_TEM21_alias__sw_rd_data[16:14] = map_12_3_TEM21__FIELD_2__curr_value;
        map_12_3_TEM21_alias__sw_rd_data[17:17] = map_12_3_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_3_TEM22__sw_wr_en              = reg_sw_wr_sel[52];
    assign  map_12_3_TEM22__sw_rd_en              = reg_sw_rd_sel[52];
    assign  map_12_3_TEM22__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[52]   = map_12_3_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_3_TEM22__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_3_TEM22__sw_wr_data[13:13], map_12_3_TEM22_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_3_TEM22__sw_rd_en, map_12_3_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_3_TEM22__sw_wr_en, map_12_3_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_3_TEM22__FIELD_3__next_value),
        .hw_pulse                               (map_12_3_TEM22__FIELD_3__pulse),
        .field_value                            (map_12_3_TEM22__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_3_TEM22__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_3_TEM22__sw_wr_data[16:14], map_12_3_TEM22_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_3_TEM22__sw_rd_en, map_12_3_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_3_TEM22__sw_wr_en, map_12_3_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_3_TEM22__FIELD_2__next_value),
        .hw_pulse                               (map_12_3_TEM22__FIELD_2__pulse),
        .field_value                            (map_12_3_TEM22__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_3_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_3_TEM22__sw_wr_data[17:17], map_12_3_TEM22_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_3_TEM22__sw_rd_en, map_12_3_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_3_TEM22__sw_wr_en, map_12_3_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_3_TEM22__FIELD_1__next_value),
        .hw_pulse                               (map_12_3_TEM22__FIELD_1__pulse),
        .field_value                            (map_12_3_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_3_TEM22__sw_rd_data = 32'h0;
        map_12_3_TEM22__sw_rd_data[13:13] = map_12_3_TEM22__FIELD_3__curr_value;
        map_12_3_TEM22__sw_rd_data[16:14] = map_12_3_TEM22__FIELD_2__curr_value;
        map_12_3_TEM22__sw_rd_data[17:17] = map_12_3_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_3_TEM22_alias__sw_wr_en              = reg_sw_wr_sel[53];
    assign  map_12_3_TEM22_alias__sw_rd_en              = reg_sw_rd_sel[53];
    assign  map_12_3_TEM22_alias__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[53]   = map_12_3_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_3_TEM22_alias__sw_rd_data = 32'h0;
        map_12_3_TEM22_alias__sw_rd_data[13:13] = map_12_3_TEM22__FIELD_3__curr_value;
        map_12_3_TEM22_alias__sw_rd_data[16:14] = map_12_3_TEM22__FIELD_2__curr_value;
        map_12_3_TEM22_alias__sw_rd_data[17:17] = map_12_3_TEM22__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_4_TEM21_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[55:54]),
        .snap_rd_en                             (reg_sw_rd_sel[55:54]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[55:54]),
        .reg_wr_en                              (map_12_4_TEM21__sw_wr_en),
        .reg_rd_en                              (map_12_4_TEM21__sw_rd_en),
        .reg_wr_data                            (map_12_4_TEM21__sw_wr_data),
        .reg_rd_data                            (map_12_4_TEM21__sw_rd_data)
    );

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b1}}),
        .SWACC                                  ({2{1'b1}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_4_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_4_TEM21__sw_wr_data[13:13], map_12_4_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_4_TEM21__sw_rd_en, map_12_4_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_4_TEM21__sw_wr_en, map_12_4_TEM21_alias__sw_wr_en}),
        .swmod_out                              (map_12_4_TEM21__FIELD_3__swmod),
        .swacc_out                              (map_12_4_TEM21__FIELD_3__swacc),
        .hw_value                               (map_12_4_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_4_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_4_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_4_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_4_TEM21__sw_wr_data[16:14], map_12_4_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_4_TEM21__sw_rd_en, map_12_4_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_4_TEM21__sw_wr_en, map_12_4_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_4_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_4_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_4_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_4_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_4_TEM21__sw_wr_data[17:17], map_12_4_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_4_TEM21__sw_rd_en, map_12_4_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_4_TEM21__sw_wr_en, map_12_4_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_4_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_4_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_4_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_4_TEM21__sw_rd_data = 64'h0;
        map_12_4_TEM21__sw_rd_data[13:13] = map_12_4_TEM21__FIELD_3__curr_value;
        map_12_4_TEM21__sw_rd_data[16:14] = map_12_4_TEM21__FIELD_2__curr_value;
        map_12_4_TEM21__sw_rd_data[17:17] = map_12_4_TEM21__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_4_TEM21_alias_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[57:56]),
        .snap_rd_en                             (reg_sw_rd_sel[57:56]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[57:56]),
        .reg_wr_en                              (map_12_4_TEM21_alias__sw_wr_en),
        .reg_rd_en                              (map_12_4_TEM21_alias__sw_rd_en),
        .reg_wr_data                            (map_12_4_TEM21_alias__sw_wr_data),
        .reg_rd_data                            (map_12_4_TEM21_alias__sw_rd_data)
    );

    always_comb begin
        map_12_4_TEM21_alias__sw_rd_data = 64'h0;
        map_12_4_TEM21_alias__sw_rd_data[13:13] = map_12_4_TEM21__FIELD_3__curr_value;
        map_12_4_TEM21_alias__sw_rd_data[16:14] = map_12_4_TEM21__FIELD_2__curr_value;
        map_12_4_TEM21_alias__sw_rd_data[17:17] = map_12_4_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_4_TEM22__sw_wr_en              = reg_sw_wr_sel[58];
    assign  map_12_4_TEM22__sw_rd_en              = reg_sw_rd_sel[58];
    assign  map_12_4_TEM22__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[58]   = map_12_4_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_4_TEM22__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_4_TEM22__sw_wr_data[13:13], map_12_4_TEM22_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_4_TEM22__sw_rd_en, map_12_4_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_4_TEM22__sw_wr_en, map_12_4_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_4_TEM22__FIELD_3__next_value),
        .hw_pulse                               (map_12_4_TEM22__FIELD_3__pulse),
        .field_value                            (map_12_4_TEM22__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_4_TEM22__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_4_TEM22__sw_wr_data[16:14], map_12_4_TEM22_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_4_TEM22__sw_rd_en, map_12_4_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_4_TEM22__sw_wr_en, map_12_4_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_4_TEM22__FIELD_2__next_value),
        .hw_pulse                               (map_12_4_TEM22__FIELD_2__pulse),
        .field_value                            (map_12_4_TEM22__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_4_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_4_TEM22__sw_wr_data[17:17], map_12_4_TEM22_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_4_TEM22__sw_rd_en, map_12_4_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_4_TEM22__sw_wr_en, map_12_4_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_4_TEM22__FIELD_1__next_value),
        .hw_pulse                               (map_12_4_TEM22__FIELD_1__pulse),
        .field_value                            (map_12_4_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_4_TEM22__sw_rd_data = 32'h0;
        map_12_4_TEM22__sw_rd_data[13:13] = map_12_4_TEM22__FIELD_3__curr_value;
        map_12_4_TEM22__sw_rd_data[16:14] = map_12_4_TEM22__FIELD_2__curr_value;
        map_12_4_TEM22__sw_rd_data[17:17] = map_12_4_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_4_TEM22_alias__sw_wr_en              = reg_sw_wr_sel[59];
    assign  map_12_4_TEM22_alias__sw_rd_en              = reg_sw_rd_sel[59];
    assign  map_12_4_TEM22_alias__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[59]   = map_12_4_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_4_TEM22_alias__sw_rd_data = 32'h0;
        map_12_4_TEM22_alias__sw_rd_data[13:13] = map_12_4_TEM22__FIELD_3__curr_value;
        map_12_4_TEM22_alias__sw_rd_data[16:14] = map_12_4_TEM22__FIELD_2__curr_value;
        map_12_4_TEM22_alias__sw_rd_data[17:17] = map_12_4_TEM22__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_5_TEM21_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[61:60]),
        .snap_rd_en                             (reg_sw_rd_sel[61:60]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[61:60]),
        .reg_wr_en                              (map_12_5_TEM21__sw_wr_en),
        .reg_rd_en                              (map_12_5_TEM21__sw_rd_en),
        .reg_wr_data                            (map_12_5_TEM21__sw_wr_data),
        .reg_rd_data                            (map_12_5_TEM21__sw_rd_data)
    );

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b1}}),
        .SWACC                                  ({2{1'b1}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_5_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_5_TEM21__sw_wr_data[13:13], map_12_5_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_5_TEM21__sw_rd_en, map_12_5_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_5_TEM21__sw_wr_en, map_12_5_TEM21_alias__sw_wr_en}),
        .swmod_out                              (map_12_5_TEM21__FIELD_3__swmod),
        .swacc_out                              (map_12_5_TEM21__FIELD_3__swacc),
        .hw_value                               (map_12_5_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_5_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_5_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_5_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_5_TEM21__sw_wr_data[16:14], map_12_5_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_5_TEM21__sw_rd_en, map_12_5_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_5_TEM21__sw_wr_en, map_12_5_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_5_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_5_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_5_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_5_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_5_TEM21__sw_wr_data[17:17], map_12_5_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_5_TEM21__sw_rd_en, map_12_5_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_5_TEM21__sw_wr_en, map_12_5_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_5_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_5_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_5_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_5_TEM21__sw_rd_data = 64'h0;
        map_12_5_TEM21__sw_rd_data[13:13] = map_12_5_TEM21__FIELD_3__curr_value;
        map_12_5_TEM21__sw_rd_data[16:14] = map_12_5_TEM21__FIELD_2__curr_value;
        map_12_5_TEM21__sw_rd_data[17:17] = map_12_5_TEM21__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_5_TEM21_alias_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[63:62]),
        .snap_rd_en                             (reg_sw_rd_sel[63:62]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[63:62]),
        .reg_wr_en                              (map_12_5_TEM21_alias__sw_wr_en),
        .reg_rd_en                              (map_12_5_TEM21_alias__sw_rd_en),
        .reg_wr_data                            (map_12_5_TEM21_alias__sw_wr_data),
        .reg_rd_data                            (map_12_5_TEM21_alias__sw_rd_data)
    );

    always_comb begin
        map_12_5_TEM21_alias__sw_rd_data = 64'h0;
        map_12_5_TEM21_alias__sw_rd_data[13:13] = map_12_5_TEM21__FIELD_3__curr_value;
        map_12_5_TEM21_alias__sw_rd_data[16:14] = map_12_5_TEM21__FIELD_2__curr_value;
        map_12_5_TEM21_alias__sw_rd_data[17:17] = map_12_5_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_5_TEM22__sw_wr_en              = reg_sw_wr_sel[64];
    assign  map_12_5_TEM22__sw_rd_en              = reg_sw_rd_sel[64];
    assign  map_12_5_TEM22__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[64]   = map_12_5_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_5_TEM22__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_5_TEM22__sw_wr_data[13:13], map_12_5_TEM22_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_5_TEM22__sw_rd_en, map_12_5_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_5_TEM22__sw_wr_en, map_12_5_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_5_TEM22__FIELD_3__next_value),
        .hw_pulse                               (map_12_5_TEM22__FIELD_3__pulse),
        .field_value                            (map_12_5_TEM22__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_5_TEM22__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_5_TEM22__sw_wr_data[16:14], map_12_5_TEM22_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_5_TEM22__sw_rd_en, map_12_5_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_5_TEM22__sw_wr_en, map_12_5_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_5_TEM22__FIELD_2__next_value),
        .hw_pulse                               (map_12_5_TEM22__FIELD_2__pulse),
        .field_value                            (map_12_5_TEM22__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_5_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_5_TEM22__sw_wr_data[17:17], map_12_5_TEM22_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_5_TEM22__sw_rd_en, map_12_5_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_5_TEM22__sw_wr_en, map_12_5_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_5_TEM22__FIELD_1__next_value),
        .hw_pulse                               (map_12_5_TEM22__FIELD_1__pulse),
        .field_value                            (map_12_5_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_5_TEM22__sw_rd_data = 32'h0;
        map_12_5_TEM22__sw_rd_data[13:13] = map_12_5_TEM22__FIELD_3__curr_value;
        map_12_5_TEM22__sw_rd_data[16:14] = map_12_5_TEM22__FIELD_2__curr_value;
        map_12_5_TEM22__sw_rd_data[17:17] = map_12_5_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_5_TEM22_alias__sw_wr_en              = reg_sw_wr_sel[65];
    assign  map_12_5_TEM22_alias__sw_rd_en              = reg_sw_rd_sel[65];
    assign  map_12_5_TEM22_alias__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[65]   = map_12_5_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_5_TEM22_alias__sw_rd_data = 32'h0;
        map_12_5_TEM22_alias__sw_rd_data[13:13] = map_12_5_TEM22__FIELD_3__curr_value;
        map_12_5_TEM22_alias__sw_rd_data[16:14] = map_12_5_TEM22__FIELD_2__curr_value;
        map_12_5_TEM22_alias__sw_rd_data[17:17] = map_12_5_TEM22__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_6_TEM21_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[67:66]),
        .snap_rd_en                             (reg_sw_rd_sel[67:66]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[67:66]),
        .reg_wr_en                              (map_12_6_TEM21__sw_wr_en),
        .reg_rd_en                              (map_12_6_TEM21__sw_rd_en),
        .reg_wr_data                            (map_12_6_TEM21__sw_wr_data),
        .reg_rd_data                            (map_12_6_TEM21__sw_rd_data)
    );

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b1}}),
        .SWACC                                  ({2{1'b1}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_6_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_6_TEM21__sw_wr_data[13:13], map_12_6_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_6_TEM21__sw_rd_en, map_12_6_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_6_TEM21__sw_wr_en, map_12_6_TEM21_alias__sw_wr_en}),
        .swmod_out                              (map_12_6_TEM21__FIELD_3__swmod),
        .swacc_out                              (map_12_6_TEM21__FIELD_3__swacc),
        .hw_value                               (map_12_6_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_6_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_6_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_6_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_6_TEM21__sw_wr_data[16:14], map_12_6_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_6_TEM21__sw_rd_en, map_12_6_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_6_TEM21__sw_wr_en, map_12_6_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_6_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_6_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_6_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_6_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_6_TEM21__sw_wr_data[17:17], map_12_6_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_6_TEM21__sw_rd_en, map_12_6_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_6_TEM21__sw_wr_en, map_12_6_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_6_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_6_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_6_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_6_TEM21__sw_rd_data = 64'h0;
        map_12_6_TEM21__sw_rd_data[13:13] = map_12_6_TEM21__FIELD_3__curr_value;
        map_12_6_TEM21__sw_rd_data[16:14] = map_12_6_TEM21__FIELD_2__curr_value;
        map_12_6_TEM21__sw_rd_data[17:17] = map_12_6_TEM21__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_6_TEM21_alias_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[69:68]),
        .snap_rd_en                             (reg_sw_rd_sel[69:68]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[69:68]),
        .reg_wr_en                              (map_12_6_TEM21_alias__sw_wr_en),
        .reg_rd_en                              (map_12_6_TEM21_alias__sw_rd_en),
        .reg_wr_data                            (map_12_6_TEM21_alias__sw_wr_data),
        .reg_rd_data                            (map_12_6_TEM21_alias__sw_rd_data)
    );

    always_comb begin
        map_12_6_TEM21_alias__sw_rd_data = 64'h0;
        map_12_6_TEM21_alias__sw_rd_data[13:13] = map_12_6_TEM21__FIELD_3__curr_value;
        map_12_6_TEM21_alias__sw_rd_data[16:14] = map_12_6_TEM21__FIELD_2__curr_value;
        map_12_6_TEM21_alias__sw_rd_data[17:17] = map_12_6_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_6_TEM22__sw_wr_en              = reg_sw_wr_sel[70];
    assign  map_12_6_TEM22__sw_rd_en              = reg_sw_rd_sel[70];
    assign  map_12_6_TEM22__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[70]   = map_12_6_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_6_TEM22__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_6_TEM22__sw_wr_data[13:13], map_12_6_TEM22_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_6_TEM22__sw_rd_en, map_12_6_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_6_TEM22__sw_wr_en, map_12_6_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_6_TEM22__FIELD_3__next_value),
        .hw_pulse                               (map_12_6_TEM22__FIELD_3__pulse),
        .field_value                            (map_12_6_TEM22__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_6_TEM22__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_6_TEM22__sw_wr_data[16:14], map_12_6_TEM22_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_6_TEM22__sw_rd_en, map_12_6_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_6_TEM22__sw_wr_en, map_12_6_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_6_TEM22__FIELD_2__next_value),
        .hw_pulse                               (map_12_6_TEM22__FIELD_2__pulse),
        .field_value                            (map_12_6_TEM22__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_6_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_6_TEM22__sw_wr_data[17:17], map_12_6_TEM22_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_6_TEM22__sw_rd_en, map_12_6_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_6_TEM22__sw_wr_en, map_12_6_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_6_TEM22__FIELD_1__next_value),
        .hw_pulse                               (map_12_6_TEM22__FIELD_1__pulse),
        .field_value                            (map_12_6_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_6_TEM22__sw_rd_data = 32'h0;
        map_12_6_TEM22__sw_rd_data[13:13] = map_12_6_TEM22__FIELD_3__curr_value;
        map_12_6_TEM22__sw_rd_data[16:14] = map_12_6_TEM22__FIELD_2__curr_value;
        map_12_6_TEM22__sw_rd_data[17:17] = map_12_6_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_6_TEM22_alias__sw_wr_en              = reg_sw_wr_sel[71];
    assign  map_12_6_TEM22_alias__sw_rd_en              = reg_sw_rd_sel[71];
    assign  map_12_6_TEM22_alias__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[71]   = map_12_6_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_6_TEM22_alias__sw_rd_data = 32'h0;
        map_12_6_TEM22_alias__sw_rd_data[13:13] = map_12_6_TEM22__FIELD_3__curr_value;
        map_12_6_TEM22_alias__sw_rd_data[16:14] = map_12_6_TEM22__FIELD_2__curr_value;
        map_12_6_TEM22_alias__sw_rd_data[17:17] = map_12_6_TEM22__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_7_TEM21_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[73:72]),
        .snap_rd_en                             (reg_sw_rd_sel[73:72]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[73:72]),
        .reg_wr_en                              (map_12_7_TEM21__sw_wr_en),
        .reg_rd_en                              (map_12_7_TEM21__sw_rd_en),
        .reg_wr_data                            (map_12_7_TEM21__sw_wr_data),
        .reg_rd_data                            (map_12_7_TEM21__sw_rd_data)
    );

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b1}}),
        .SWACC                                  ({2{1'b1}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_7_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_7_TEM21__sw_wr_data[13:13], map_12_7_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_7_TEM21__sw_rd_en, map_12_7_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_7_TEM21__sw_wr_en, map_12_7_TEM21_alias__sw_wr_en}),
        .swmod_out                              (map_12_7_TEM21__FIELD_3__swmod),
        .swacc_out                              (map_12_7_TEM21__FIELD_3__swacc),
        .hw_value                               (map_12_7_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_7_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_7_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_7_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_7_TEM21__sw_wr_data[16:14], map_12_7_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_7_TEM21__sw_rd_en, map_12_7_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_7_TEM21__sw_wr_en, map_12_7_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_7_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_7_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_7_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_7_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_7_TEM21__sw_wr_data[17:17], map_12_7_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_7_TEM21__sw_rd_en, map_12_7_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_7_TEM21__sw_wr_en, map_12_7_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_7_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_7_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_7_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_7_TEM21__sw_rd_data = 64'h0;
        map_12_7_TEM21__sw_rd_data[13:13] = map_12_7_TEM21__FIELD_3__curr_value;
        map_12_7_TEM21__sw_rd_data[16:14] = map_12_7_TEM21__FIELD_2__curr_value;
        map_12_7_TEM21__sw_rd_data[17:17] = map_12_7_TEM21__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_7_TEM21_alias_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[75:74]),
        .snap_rd_en                             (reg_sw_rd_sel[75:74]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[75:74]),
        .reg_wr_en                              (map_12_7_TEM21_alias__sw_wr_en),
        .reg_rd_en                              (map_12_7_TEM21_alias__sw_rd_en),
        .reg_wr_data                            (map_12_7_TEM21_alias__sw_wr_data),
        .reg_rd_data                            (map_12_7_TEM21_alias__sw_rd_data)
    );

    always_comb begin
        map_12_7_TEM21_alias__sw_rd_data = 64'h0;
        map_12_7_TEM21_alias__sw_rd_data[13:13] = map_12_7_TEM21__FIELD_3__curr_value;
        map_12_7_TEM21_alias__sw_rd_data[16:14] = map_12_7_TEM21__FIELD_2__curr_value;
        map_12_7_TEM21_alias__sw_rd_data[17:17] = map_12_7_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_7_TEM22__sw_wr_en              = reg_sw_wr_sel[76];
    assign  map_12_7_TEM22__sw_rd_en              = reg_sw_rd_sel[76];
    assign  map_12_7_TEM22__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[76]   = map_12_7_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_7_TEM22__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_7_TEM22__sw_wr_data[13:13], map_12_7_TEM22_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_7_TEM22__sw_rd_en, map_12_7_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_7_TEM22__sw_wr_en, map_12_7_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_7_TEM22__FIELD_3__next_value),
        .hw_pulse                               (map_12_7_TEM22__FIELD_3__pulse),
        .field_value                            (map_12_7_TEM22__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_7_TEM22__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_7_TEM22__sw_wr_data[16:14], map_12_7_TEM22_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_7_TEM22__sw_rd_en, map_12_7_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_7_TEM22__sw_wr_en, map_12_7_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_7_TEM22__FIELD_2__next_value),
        .hw_pulse                               (map_12_7_TEM22__FIELD_2__pulse),
        .field_value                            (map_12_7_TEM22__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_7_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_7_TEM22__sw_wr_data[17:17], map_12_7_TEM22_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_7_TEM22__sw_rd_en, map_12_7_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_7_TEM22__sw_wr_en, map_12_7_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_7_TEM22__FIELD_1__next_value),
        .hw_pulse                               (map_12_7_TEM22__FIELD_1__pulse),
        .field_value                            (map_12_7_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_7_TEM22__sw_rd_data = 32'h0;
        map_12_7_TEM22__sw_rd_data[13:13] = map_12_7_TEM22__FIELD_3__curr_value;
        map_12_7_TEM22__sw_rd_data[16:14] = map_12_7_TEM22__FIELD_2__curr_value;
        map_12_7_TEM22__sw_rd_data[17:17] = map_12_7_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_7_TEM22_alias__sw_wr_en              = reg_sw_wr_sel[77];
    assign  map_12_7_TEM22_alias__sw_rd_en              = reg_sw_rd_sel[77];
    assign  map_12_7_TEM22_alias__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[77]   = map_12_7_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_7_TEM22_alias__sw_rd_data = 32'h0;
        map_12_7_TEM22_alias__sw_rd_data[13:13] = map_12_7_TEM22__FIELD_3__curr_value;
        map_12_7_TEM22_alias__sw_rd_data[16:14] = map_12_7_TEM22__FIELD_2__curr_value;
        map_12_7_TEM22_alias__sw_rd_data[17:17] = map_12_7_TEM22__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_8_TEM21_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[79:78]),
        .snap_rd_en                             (reg_sw_rd_sel[79:78]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[79:78]),
        .reg_wr_en                              (map_12_8_TEM21__sw_wr_en),
        .reg_rd_en                              (map_12_8_TEM21__sw_rd_en),
        .reg_wr_data                            (map_12_8_TEM21__sw_wr_data),
        .reg_rd_data                            (map_12_8_TEM21__sw_rd_data)
    );

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b1}}),
        .SWACC                                  ({2{1'b1}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_8_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_8_TEM21__sw_wr_data[13:13], map_12_8_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_8_TEM21__sw_rd_en, map_12_8_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_8_TEM21__sw_wr_en, map_12_8_TEM21_alias__sw_wr_en}),
        .swmod_out                              (map_12_8_TEM21__FIELD_3__swmod),
        .swacc_out                              (map_12_8_TEM21__FIELD_3__swacc),
        .hw_value                               (map_12_8_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_8_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_8_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_8_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_8_TEM21__sw_wr_data[16:14], map_12_8_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_8_TEM21__sw_rd_en, map_12_8_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_8_TEM21__sw_wr_en, map_12_8_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_8_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_8_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_8_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_8_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_8_TEM21__sw_wr_data[17:17], map_12_8_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_8_TEM21__sw_rd_en, map_12_8_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_8_TEM21__sw_wr_en, map_12_8_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_8_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_8_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_8_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_8_TEM21__sw_rd_data = 64'h0;
        map_12_8_TEM21__sw_rd_data[13:13] = map_12_8_TEM21__FIELD_3__curr_value;
        map_12_8_TEM21__sw_rd_data[16:14] = map_12_8_TEM21__FIELD_2__curr_value;
        map_12_8_TEM21__sw_rd_data[17:17] = map_12_8_TEM21__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_8_TEM21_alias_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[81:80]),
        .snap_rd_en                             (reg_sw_rd_sel[81:80]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[81:80]),
        .reg_wr_en                              (map_12_8_TEM21_alias__sw_wr_en),
        .reg_rd_en                              (map_12_8_TEM21_alias__sw_rd_en),
        .reg_wr_data                            (map_12_8_TEM21_alias__sw_wr_data),
        .reg_rd_data                            (map_12_8_TEM21_alias__sw_rd_data)
    );

    always_comb begin
        map_12_8_TEM21_alias__sw_rd_data = 64'h0;
        map_12_8_TEM21_alias__sw_rd_data[13:13] = map_12_8_TEM21__FIELD_3__curr_value;
        map_12_8_TEM21_alias__sw_rd_data[16:14] = map_12_8_TEM21__FIELD_2__curr_value;
        map_12_8_TEM21_alias__sw_rd_data[17:17] = map_12_8_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_8_TEM22__sw_wr_en              = reg_sw_wr_sel[82];
    assign  map_12_8_TEM22__sw_rd_en              = reg_sw_rd_sel[82];
    assign  map_12_8_TEM22__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[82]   = map_12_8_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_8_TEM22__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_8_TEM22__sw_wr_data[13:13], map_12_8_TEM22_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_8_TEM22__sw_rd_en, map_12_8_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_8_TEM22__sw_wr_en, map_12_8_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_8_TEM22__FIELD_3__next_value),
        .hw_pulse                               (map_12_8_TEM22__FIELD_3__pulse),
        .field_value                            (map_12_8_TEM22__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_8_TEM22__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_8_TEM22__sw_wr_data[16:14], map_12_8_TEM22_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_8_TEM22__sw_rd_en, map_12_8_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_8_TEM22__sw_wr_en, map_12_8_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_8_TEM22__FIELD_2__next_value),
        .hw_pulse                               (map_12_8_TEM22__FIELD_2__pulse),
        .field_value                            (map_12_8_TEM22__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_8_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_8_TEM22__sw_wr_data[17:17], map_12_8_TEM22_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_8_TEM22__sw_rd_en, map_12_8_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_8_TEM22__sw_wr_en, map_12_8_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_8_TEM22__FIELD_1__next_value),
        .hw_pulse                               (map_12_8_TEM22__FIELD_1__pulse),
        .field_value                            (map_12_8_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_8_TEM22__sw_rd_data = 32'h0;
        map_12_8_TEM22__sw_rd_data[13:13] = map_12_8_TEM22__FIELD_3__curr_value;
        map_12_8_TEM22__sw_rd_data[16:14] = map_12_8_TEM22__FIELD_2__curr_value;
        map_12_8_TEM22__sw_rd_data[17:17] = map_12_8_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_8_TEM22_alias__sw_wr_en              = reg_sw_wr_sel[83];
    assign  map_12_8_TEM22_alias__sw_rd_en              = reg_sw_rd_sel[83];
    assign  map_12_8_TEM22_alias__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[83]   = map_12_8_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_8_TEM22_alias__sw_rd_data = 32'h0;
        map_12_8_TEM22_alias__sw_rd_data[13:13] = map_12_8_TEM22__FIELD_3__curr_value;
        map_12_8_TEM22_alias__sw_rd_data[16:14] = map_12_8_TEM22__FIELD_2__curr_value;
        map_12_8_TEM22_alias__sw_rd_data[17:17] = map_12_8_TEM22__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_9_TEM21_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[85:84]),
        .snap_rd_en                             (reg_sw_rd_sel[85:84]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[85:84]),
        .reg_wr_en                              (map_12_9_TEM21__sw_wr_en),
        .reg_rd_en                              (map_12_9_TEM21__sw_rd_en),
        .reg_wr_data                            (map_12_9_TEM21__sw_wr_data),
        .reg_rd_data                            (map_12_9_TEM21__sw_rd_data)
    );

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b1}}),
        .SWACC                                  ({2{1'b1}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_9_TEM21__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_9_TEM21__sw_wr_data[13:13], map_12_9_TEM21_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_9_TEM21__sw_rd_en, map_12_9_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_9_TEM21__sw_wr_en, map_12_9_TEM21_alias__sw_wr_en}),
        .swmod_out                              (map_12_9_TEM21__FIELD_3__swmod),
        .swacc_out                              (map_12_9_TEM21__FIELD_3__swacc),
        .hw_value                               (map_12_9_TEM21__FIELD_3__next_value),
        .hw_pulse                               (map_12_9_TEM21__FIELD_3__pulse),
        .field_value                            (map_12_9_TEM21__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_9_TEM21__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_9_TEM21__sw_wr_data[16:14], map_12_9_TEM21_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_9_TEM21__sw_rd_en, map_12_9_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_9_TEM21__sw_wr_en, map_12_9_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_9_TEM21__FIELD_2__next_value),
        .hw_pulse                               (map_12_9_TEM21__FIELD_2__pulse),
        .field_value                            (map_12_9_TEM21__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_9_TEM21__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_9_TEM21__sw_wr_data[17:17], map_12_9_TEM21_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_9_TEM21__sw_rd_en, map_12_9_TEM21_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_9_TEM21__sw_wr_en, map_12_9_TEM21_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_9_TEM21__FIELD_1__next_value),
        .hw_pulse                               (map_12_9_TEM21__FIELD_1__pulse),
        .field_value                            (map_12_9_TEM21__FIELD_1__curr_value));

    always_comb begin
        map_12_9_TEM21__sw_rd_data = 64'h0;
        map_12_9_TEM21__sw_rd_data[13:13] = map_12_9_TEM21__FIELD_3__curr_value;
        map_12_9_TEM21__sw_rd_data[16:14] = map_12_9_TEM21__FIELD_2__curr_value;
        map_12_9_TEM21__sw_rd_data[17:17] = map_12_9_TEM21__FIELD_1__curr_value;
    end

    snapshot_reg #(.DATA_WIDTH(DATA_WIDTH), .REG_WIDTH(64))
    map_12_9_TEM21_alias_snapshot_reg (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .soft_rst                               (int_soft_rst),
        .snap_wr_en                             (reg_sw_wr_sel[87:86]),
        .snap_rd_en                             (reg_sw_rd_sel[87:86]),
        .snap_wr_data                           ({2{reg_sw_wr_data}}),
        .snap_rd_data                           (reg_sw_rd_data[87:86]),
        .reg_wr_en                              (map_12_9_TEM21_alias__sw_wr_en),
        .reg_rd_en                              (map_12_9_TEM21_alias__sw_rd_en),
        .reg_wr_data                            (map_12_9_TEM21_alias__sw_wr_data),
        .reg_rd_data                            (map_12_9_TEM21_alias__sw_rd_data)
    );

    always_comb begin
        map_12_9_TEM21_alias__sw_rd_data = 64'h0;
        map_12_9_TEM21_alias__sw_rd_data[13:13] = map_12_9_TEM21__FIELD_3__curr_value;
        map_12_9_TEM21_alias__sw_rd_data[16:14] = map_12_9_TEM21__FIELD_2__curr_value;
        map_12_9_TEM21_alias__sw_rd_data[17:17] = map_12_9_TEM21__FIELD_1__curr_value;
    end

    assign  map_12_9_TEM22__sw_wr_en              = reg_sw_wr_sel[88];
    assign  map_12_9_TEM22__sw_rd_en              = reg_sw_rd_sel[88];
    assign  map_12_9_TEM22__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[88]   = map_12_9_TEM22__sw_rd_data;

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h1),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_9_TEM22__FIELD_3 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_9_TEM22__sw_wr_data[13:13], map_12_9_TEM22_alias__sw_wr_data[13:13]}),
        .sw_rd                                  ({map_12_9_TEM22__sw_rd_en, map_12_9_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_9_TEM22__sw_wr_en, map_12_9_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_9_TEM22__FIELD_3__next_value),
        .hw_pulse                               (map_12_9_TEM22__FIELD_3__pulse),
        .field_value                            (map_12_9_TEM22__FIELD_3__curr_value));

    field #(
        .F_WIDTH                                (3),
        .ARST_VALUE                             (3'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_9_TEM22__FIELD_2 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_9_TEM22__sw_wr_data[16:14], map_12_9_TEM22_alias__sw_wr_data[16:14]}),
        .sw_rd                                  ({map_12_9_TEM22__sw_rd_en, map_12_9_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_9_TEM22__sw_wr_en, map_12_9_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_9_TEM22__FIELD_2__next_value),
        .hw_pulse                               (map_12_9_TEM22__FIELD_2__pulse),
        .field_value                            (map_12_9_TEM22__FIELD_2__curr_value));

    field #(
        .F_WIDTH                                (1),
        .ARST_VALUE                             (1'h0),
        .ALIAS_NUM                              (2),
        .SRST_CNT                               (0),
        .SW_TYPE                                ({`SW_RW, `SW_RW}),
        .SW_ONREAD_TYPE                         ({`NA, `NA}),
        .SW_ONWRITE_TYPE                        ({`NA, `NA}),
        .SWMOD                                  ({2{1'b0}}),
        .SWACC                                  ({2{1'b0}}),
        .PULSE                                  ({2{1'b0}}),
        .HW_TYPE                                (`HW_RW),
        .PRECEDENCE                             (`SW))
    x__map_12_9_TEM22__FIELD_1 (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .sync_rst                               (1'b0),
        .sw_wr_data                             ({map_12_9_TEM22__sw_wr_data[17:17], map_12_9_TEM22_alias__sw_wr_data[17:17]}),
        .sw_rd                                  ({map_12_9_TEM22__sw_rd_en, map_12_9_TEM22_alias__sw_rd_en}),
        .sw_wr                                  ({map_12_9_TEM22__sw_wr_en, map_12_9_TEM22_alias__sw_wr_en}),
        .swmod_out                              (),
        .swacc_out                              (),
        .hw_value                               (map_12_9_TEM22__FIELD_1__next_value),
        .hw_pulse                               (map_12_9_TEM22__FIELD_1__pulse),
        .field_value                            (map_12_9_TEM22__FIELD_1__curr_value));

    always_comb begin
        map_12_9_TEM22__sw_rd_data = 32'h0;
        map_12_9_TEM22__sw_rd_data[13:13] = map_12_9_TEM22__FIELD_3__curr_value;
        map_12_9_TEM22__sw_rd_data[16:14] = map_12_9_TEM22__FIELD_2__curr_value;
        map_12_9_TEM22__sw_rd_data[17:17] = map_12_9_TEM22__FIELD_1__curr_value;
    end

    assign  map_12_9_TEM22_alias__sw_wr_en              = reg_sw_wr_sel[89];
    assign  map_12_9_TEM22_alias__sw_rd_en              = reg_sw_rd_sel[89];
    assign  map_12_9_TEM22_alias__sw_wr_data            = reg_sw_wr_data;
    assign  reg_sw_rd_data[89]   = map_12_9_TEM22_alias__sw_rd_data;

    always_comb begin
        map_12_9_TEM22_alias__sw_rd_data = 32'h0;
        map_12_9_TEM22_alias__sw_rd_data[13:13] = map_12_9_TEM22__FIELD_3__curr_value;
        map_12_9_TEM22_alias__sw_rd_data[16:14] = map_12_9_TEM22__FIELD_2__curr_value;
        map_12_9_TEM22_alias__sw_rd_data[17:17] = map_12_9_TEM22__FIELD_1__curr_value;
    end

//*************************************READ DATA MUX**************************************************//
    assign  reg_rd_data_mux_din                 = reg_sw_rd_data;
    assign  reg_rd_data_mux_sel                 = reg_sw_rd_sel;
    assign  reg_rd_data_vld                     = reg_rd_data_mux_dout_vld;
    assign  reg_rd_data                         = reg_rd_data_mux_dout;

    split_mux_2d #(
        .WIDTH                                  (DATA_WIDTH),
        .CNT                                    (REG_NUM),
        .GROUP_SIZE                             (128),
        .SKIP_DFF_0                             (1),
        .SKIP_DFF_1                             (1))
    reg_rd_data_mux (
        .clk                                    (regslv_clk),
        .rst_n                                  (regslv_rst_n),
        .din                                    (reg_rd_data_mux_din),
        .sel                                    (reg_rd_data_mux_sel),
        .dout                                   (reg_rd_data_mux_dout),
        .dout_vld                               (reg_rd_data_mux_dout_vld));
endmodule
`default_nettype wire