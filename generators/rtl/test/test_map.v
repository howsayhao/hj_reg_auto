`include "test_map.vh"
module test_map{
	input clk,
	input rstn,
	input req_vld,
	input wr_en,rd_en,
	input [ADDR_WIDTH-1:0] addr,
	input [DATA_WIDTH-1:0] wr_data,
	output ack_vld_t,
	output [DATA_WIDTH-1:0] rd_data,
//******EXTERNAL module connection port START*******//
//*******EXTERNAL module connection port END********//
//*******INTERNAL field connection port START*******//
//['root_map', 'test_map_1_inst', 'test1', 'TEM21', 'FIELD_3']
	input [1-1:0] test_map_1_inst_test1_TEM21_FIELD_3__next_value,
	input test_map_1_inst_test1_TEM21_FIELD_3__pulse,
	output [1-1:0] test_map_1_inst_test1_TEM21_FIELD_3__curr_value,
	output test_map_1_inst_test1_TEM21_FIELD_3__swmod_out,
	output test_map_1_inst_test1_TEM21_FIELD_3__swacc_out,
//['root_map', 'test_map_1_inst', 'test1', 'TEM21', 'FIELD_2']
	input [3-1:0] test_map_1_inst_test1_TEM21_FIELD_2__next_value,
	input test_map_1_inst_test1_TEM21_FIELD_2__pulse,
	output [3-1:0] test_map_1_inst_test1_TEM21_FIELD_2__curr_value,
	output test_map_1_inst_test1_TEM21_FIELD_2__swmod_out,
	output test_map_1_inst_test1_TEM21_FIELD_2__swacc_out,
//['root_map', 'test_map_1_inst', 'test1', 'TEM21', 'FIELD_1']
	input [1-1:0] test_map_1_inst_test1_TEM21_FIELD_1__next_value,
	input test_map_1_inst_test1_TEM21_FIELD_1__pulse,
	output [1-1:0] test_map_1_inst_test1_TEM21_FIELD_1__curr_value,
	output test_map_1_inst_test1_TEM21_FIELD_1__swmod_out,
	output test_map_1_inst_test1_TEM21_FIELD_1__swacc_out,
//['root_map', 'test_map_1_inst', 'test1', 'TEM22', 'FIELD_3']
	input [1-1:0] test_map_1_inst_test1_TEM22_FIELD_3__next_value,
	input test_map_1_inst_test1_TEM22_FIELD_3__pulse,
	output [1-1:0] test_map_1_inst_test1_TEM22_FIELD_3__curr_value,
	output test_map_1_inst_test1_TEM22_FIELD_3__swmod_out,
	output test_map_1_inst_test1_TEM22_FIELD_3__swacc_out,
//['root_map', 'test_map_1_inst', 'test1', 'TEM22', 'FIELD_2']
	input [3-1:0] test_map_1_inst_test1_TEM22_FIELD_2__next_value,
	input test_map_1_inst_test1_TEM22_FIELD_2__pulse,
	output [3-1:0] test_map_1_inst_test1_TEM22_FIELD_2__curr_value,
	output test_map_1_inst_test1_TEM22_FIELD_2__swmod_out,
	output test_map_1_inst_test1_TEM22_FIELD_2__swacc_out,
//['root_map', 'test_map_1_inst', 'test1', 'TEM22', 'FIELD_1']
	input [1-1:0] test_map_1_inst_test1_TEM22_FIELD_1__next_value,
	input test_map_1_inst_test1_TEM22_FIELD_1__pulse,
	output [1-1:0] test_map_1_inst_test1_TEM22_FIELD_1__curr_value,
	output test_map_1_inst_test1_TEM22_FIELD_1__swmod_out,
	output test_map_1_inst_test1_TEM22_FIELD_1__swacc_out,
//['root_map', 'test_map_1_inst', 'test1', 'TEM23', 'FIELD_3']
	input [1-1:0] test_map_1_inst_test1_TEM23_FIELD_3__next_value,
	input test_map_1_inst_test1_TEM23_FIELD_3__pulse,
	output [1-1:0] test_map_1_inst_test1_TEM23_FIELD_3__curr_value,
	output test_map_1_inst_test1_TEM23_FIELD_3__swmod_out,
	output test_map_1_inst_test1_TEM23_FIELD_3__swacc_out,
//['root_map', 'test_map_1_inst', 'test1', 'TEM23', 'FIELD_2']
	input [3-1:0] test_map_1_inst_test1_TEM23_FIELD_2__next_value,
	input test_map_1_inst_test1_TEM23_FIELD_2__pulse,
	output [3-1:0] test_map_1_inst_test1_TEM23_FIELD_2__curr_value,
	output test_map_1_inst_test1_TEM23_FIELD_2__swmod_out,
	output test_map_1_inst_test1_TEM23_FIELD_2__swacc_out,
//['root_map', 'test_map_1_inst', 'test1', 'TEM23', 'FIELD_1']
	input [1-1:0] test_map_1_inst_test1_TEM23_FIELD_1__next_value,
	input test_map_1_inst_test1_TEM23_FIELD_1__pulse,
	output [1-1:0] test_map_1_inst_test1_TEM23_FIELD_1__curr_value,
	output test_map_1_inst_test1_TEM23_FIELD_1__swmod_out,
	output test_map_1_inst_test1_TEM23_FIELD_1__swacc_out,
//['root_map', 'test_map_2_inst', 'shared_2', 'FIELD_1']
	input [3-1:0] test_map_2_inst_shared_2_FIELD_1__next_value,
	input test_map_2_inst_shared_2_FIELD_1__pulse,
	output [3-1:0] test_map_2_inst_shared_2_FIELD_1__curr_value,
	output test_map_2_inst_shared_2_FIELD_1__swmod_out,
	output test_map_2_inst_shared_2_FIELD_1__swacc_out
//********INTERNAL field connection port END********//
};
//*********PARAMETER Definition START Here**********//
PARAMETER ADDR_WIDTH = 64;
PARAMETER DATA_WIDTH = 32;
//N:number of internal registers, M:number of external modules
PARAMETER N = 8;
PARAMETER M = 0;
//**********PARAMETER Definition END Here***********//


//**************WIRE DECLARATION START**************//
//declare the portwidth of external module
wire external;
wire [N-1:0] [DATAWIDTH-1:0] reg_rd_data_in;
wire [N-1:0] reg_sel;
reg [N-1:0] reg_sel_ff;
wire dummy_reg;
reg dummy_reg_ff;
//***************WIRE DECLARATION END***************//


//***********Address Decoding START Here************//
always_comb begin
	unique case (addr)
		reg_sel = {8{1'b0}};
		ext_reg_sel = {0{1'b0}};
		dummy_reg = 1'b0;
		`test_map_1_inst_test1_TEM21:reg_sel[0] = 1'b1;//['test_map_1_inst', 'test1', 'TEM21']
		`test_map_1_inst_test1_TEM22:reg_sel[1] = 1'b1;//['test_map_1_inst', 'test1', 'TEM22']
		`test_map_1_inst_test1_TEM23:reg_sel[2] = 1'b1;//['test_map_1_inst', 'test1', 'TEM23']
		`test_map_1_inst_test1_TEM21_alias:reg_sel[3] = 1'b1;//['test_map_1_inst', 'test1', 'TEM21_alias']
		`test_map_1_inst_test1_TEM22_alias:reg_sel[4] = 1'b1;//['test_map_1_inst', 'test1', 'TEM22_alias']
		`test_map_1_inst_test1_TEM23_alias:reg_sel[5] = 1'b1;//['test_map_1_inst', 'test1', 'TEM23_alias']
		`test_map_2_inst_shared_2:reg_sel[6] = 1'b1;//['test_map_2_inst', 'shared_2']
		`test_map_3_inst_shared_3:reg_sel[7] = 1'b1;//['test_map_3_inst', 'shared_3']
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
//REG NAME: test_map_1_inst_test1_TEM21//
//REG HIERARCHY: ['root_map', 'test_map_1_inst', 'test1', 'TEM21']//
//REG ABSOLUTE_ADDR:64'hc//
//REG OFFSET_ADDR:64'h64'hc//
wire [31:0] test_map_1_inst_test1_TEM21;
wire [31:0] test_map_1_inst_test1_TEM21_wr_data;
assign test_map_1_inst_test1_TEM21_wr_data = reg_sel_ff[0] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(1),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(1'h1),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.ALIAS_NUM(1),
	.SW_TYPE({`RW,`RW}),
	.SW_ONREAD_TYPE({`RCLR,`RCLR}),
	.SW_ONWRITE_TYPE({`WOT,`WOT}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_map_1_inst_test1_TEM21__FIELD_3
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data({test_map_1_inst_test1_TEM21_wr_data[13:13],test_map_1_inst_test1_TEM21_alias_wr_data[13:13]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[3]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[3]}),
	.write_protect_en(),
	.sw_out(test_map_1_inst_test1_TEM21__FIELD_3__swmod_out),
	.swacc_out(test_map_1_inst_test1_TEM21__FIELD_3__swacc_out)
	.hw_value(test_map_1_inst_test1_TEM21__FIELD_3__next_value),
	.hw_pulse(test_map_1_inst_test1_TEM21__FIELD_3__pulse),
	.field_value(test_map_1_inst_test1_TEM21__FIELD_3__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(3),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(3'h0),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.ALIAS_NUM(1),
	.SW_TYPE({`RW,`RW}),
	.SW_ONREAD_TYPE({`RSET,`RCLR}),
	.SW_ONWRITE_TYPE({`WOSET,`WOT}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_map_1_inst_test1_TEM21__FIELD_2
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data({test_map_1_inst_test1_TEM21_wr_data[16:14],test_map_1_inst_test1_TEM21_alias_wr_data[16:14]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[3]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[3]}),
	.write_protect_en(),
	.sw_out(test_map_1_inst_test1_TEM21__FIELD_2__swmod_out),
	.swacc_out(test_map_1_inst_test1_TEM21__FIELD_2__swacc_out)
	.hw_value(test_map_1_inst_test1_TEM21__FIELD_2__next_value),
	.hw_pulse(test_map_1_inst_test1_TEM21__FIELD_2__pulse),
	.field_value(test_map_1_inst_test1_TEM21__FIELD_2__curr_value)
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
	.ALIAS_NUM(1),
	.SW_TYPE({`R,`RW}),
	.SW_ONREAD_TYPE({`RCLR,`RCLR}),
	.SW_ONWRITE_TYPE({`NA,`WOT}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_map_1_inst_test1_TEM21__FIELD_1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data({test_map_1_inst_test1_TEM21_wr_data[17:17],test_map_1_inst_test1_TEM21_alias_wr_data[17:17]}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[3]}),
	.sw_wr({wr_sel_ff[0],wr_sel_ff[3]}),
	.write_protect_en(),
	.sw_out(test_map_1_inst_test1_TEM21__FIELD_1__swmod_out),
	.swacc_out(test_map_1_inst_test1_TEM21__FIELD_1__swacc_out)
	.hw_value(test_map_1_inst_test1_TEM21__FIELD_1__next_value),
	.hw_pulse(test_map_1_inst_test1_TEM21__FIELD_1__pulse),
	.field_value(test_map_1_inst_test1_TEM21__FIELD_1__curr_value)
	);
always_comb begin
	test_map_1_inst_test1_TEM21[31:0] = 32'd0;
	test_map_1_inst_test1_TEM21[13:13] = test_map_1_inst_test1_TEM21_FIELD_3__curr_value;
	test_map_1_inst_test1_TEM21[16:14] = test_map_1_inst_test1_TEM21_FIELD_2__curr_value;
	test_map_1_inst_test1_TEM21[17:17] = test_map_1_inst_test1_TEM21_FIELD_1__curr_value;
end
assign reg_rd_data_in[0] = test_map_1_inst_test1_TEM21;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: test_map_1_inst_test1_TEM22//
//REG HIERARCHY: ['root_map', 'test_map_1_inst', 'test1', 'TEM22']//
//REG ABSOLUTE_ADDR:64'h10//
//REG OFFSET_ADDR:64'h64'h10//
wire [31:0] test_map_1_inst_test1_TEM22;
wire [31:0] test_map_1_inst_test1_TEM22_wr_data;
assign test_map_1_inst_test1_TEM22_wr_data = reg_sel_ff[1] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(1),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(1'h1),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.ALIAS_NUM(1),
	.SW_TYPE({`RW,`RW}),
	.SW_ONREAD_TYPE({`RCLR,`RCLR}),
	.SW_ONWRITE_TYPE({`WOT,`WOT}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_map_1_inst_test1_TEM22__FIELD_3
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data({test_map_1_inst_test1_TEM22_wr_data[13:13],test_map_1_inst_test1_TEM22_alias_wr_data[13:13]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[4]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[4]}),
	.write_protect_en(),
	.sw_out(test_map_1_inst_test1_TEM22__FIELD_3__swmod_out),
	.swacc_out(test_map_1_inst_test1_TEM22__FIELD_3__swacc_out)
	.hw_value(test_map_1_inst_test1_TEM22__FIELD_3__next_value),
	.hw_pulse(test_map_1_inst_test1_TEM22__FIELD_3__pulse),
	.field_value(test_map_1_inst_test1_TEM22__FIELD_3__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(3),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(3'h0),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.ALIAS_NUM(1),
	.SW_TYPE({`RW,`RW}),
	.SW_ONREAD_TYPE({`RSET,`RCLR}),
	.SW_ONWRITE_TYPE({`WOSET,`WOT}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_map_1_inst_test1_TEM22__FIELD_2
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data({test_map_1_inst_test1_TEM22_wr_data[16:14],test_map_1_inst_test1_TEM22_alias_wr_data[16:14]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[4]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[4]}),
	.write_protect_en(),
	.sw_out(test_map_1_inst_test1_TEM22__FIELD_2__swmod_out),
	.swacc_out(test_map_1_inst_test1_TEM22__FIELD_2__swacc_out)
	.hw_value(test_map_1_inst_test1_TEM22__FIELD_2__next_value),
	.hw_pulse(test_map_1_inst_test1_TEM22__FIELD_2__pulse),
	.field_value(test_map_1_inst_test1_TEM22__FIELD_2__curr_value)
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
	.ALIAS_NUM(1),
	.SW_TYPE({`R,`RW}),
	.SW_ONREAD_TYPE({`RCLR,`RCLR}),
	.SW_ONWRITE_TYPE({`NA,`WOT}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_map_1_inst_test1_TEM22__FIELD_1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data({test_map_1_inst_test1_TEM22_wr_data[17:17],test_map_1_inst_test1_TEM22_alias_wr_data[17:17]}),
	.sw_rd({rd_sel_ff[1],rd_sel_ff[4]}),
	.sw_wr({wr_sel_ff[1],wr_sel_ff[4]}),
	.write_protect_en(),
	.sw_out(test_map_1_inst_test1_TEM22__FIELD_1__swmod_out),
	.swacc_out(test_map_1_inst_test1_TEM22__FIELD_1__swacc_out)
	.hw_value(test_map_1_inst_test1_TEM22__FIELD_1__next_value),
	.hw_pulse(test_map_1_inst_test1_TEM22__FIELD_1__pulse),
	.field_value(test_map_1_inst_test1_TEM22__FIELD_1__curr_value)
	);
always_comb begin
	test_map_1_inst_test1_TEM22[31:0] = 32'd0;
	test_map_1_inst_test1_TEM22[13:13] = test_map_1_inst_test1_TEM22_FIELD_3__curr_value;
	test_map_1_inst_test1_TEM22[16:14] = test_map_1_inst_test1_TEM22_FIELD_2__curr_value;
	test_map_1_inst_test1_TEM22[17:17] = test_map_1_inst_test1_TEM22_FIELD_1__curr_value;
end
assign reg_rd_data_in[1] = test_map_1_inst_test1_TEM22;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: test_map_1_inst_test1_TEM23//
//REG HIERARCHY: ['root_map', 'test_map_1_inst', 'test1', 'TEM23']//
//REG ABSOLUTE_ADDR:64'h14//
//REG OFFSET_ADDR:64'h64'h14//
wire [31:0] test_map_1_inst_test1_TEM23;
wire [31:0] test_map_1_inst_test1_TEM23_wr_data;
assign test_map_1_inst_test1_TEM23_wr_data = reg_sel_ff[2] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(1),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(1'h1),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.ALIAS_NUM(1),
	.SW_TYPE({`RW,`RW}),
	.SW_ONREAD_TYPE({`RCLR,`RCLR}),
	.SW_ONWRITE_TYPE({`WOT,`WOT}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_map_1_inst_test1_TEM23__FIELD_3
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data({test_map_1_inst_test1_TEM23_wr_data[13:13],test_map_1_inst_test1_TEM23_alias_wr_data[13:13]}),
	.sw_rd({rd_sel_ff[2],rd_sel_ff[5]}),
	.sw_wr({wr_sel_ff[2],wr_sel_ff[5]}),
	.write_protect_en(),
	.sw_out(test_map_1_inst_test1_TEM23__FIELD_3__swmod_out),
	.swacc_out(test_map_1_inst_test1_TEM23__FIELD_3__swacc_out)
	.hw_value(test_map_1_inst_test1_TEM23__FIELD_3__next_value),
	.hw_pulse(test_map_1_inst_test1_TEM23__FIELD_3__pulse),
	.field_value(test_map_1_inst_test1_TEM23__FIELD_3__curr_value)
	);
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(3),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(3'h0),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.ALIAS_NUM(1),
	.SW_TYPE({`RW,`RW}),
	.SW_ONREAD_TYPE({`RSET,`RCLR}),
	.SW_ONWRITE_TYPE({`WOSET,`WOT}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_map_1_inst_test1_TEM23__FIELD_2
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data({test_map_1_inst_test1_TEM23_wr_data[16:14],test_map_1_inst_test1_TEM23_alias_wr_data[16:14]}),
	.sw_rd({rd_sel_ff[2],rd_sel_ff[5]}),
	.sw_wr({wr_sel_ff[2],wr_sel_ff[5]}),
	.write_protect_en(),
	.sw_out(test_map_1_inst_test1_TEM23__FIELD_2__swmod_out),
	.swacc_out(test_map_1_inst_test1_TEM23__FIELD_2__swacc_out)
	.hw_value(test_map_1_inst_test1_TEM23__FIELD_2__next_value),
	.hw_pulse(test_map_1_inst_test1_TEM23__FIELD_2__pulse),
	.field_value(test_map_1_inst_test1_TEM23__FIELD_2__curr_value)
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
	.ALIAS_NUM(1),
	.SW_TYPE({`R,`RW}),
	.SW_ONREAD_TYPE({`RCLR,`RCLR}),
	.SW_ONWRITE_TYPE({`NA,`WOT}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_map_1_inst_test1_TEM23__FIELD_1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data({test_map_1_inst_test1_TEM23_wr_data[17:17],test_map_1_inst_test1_TEM23_alias_wr_data[17:17]}),
	.sw_rd({rd_sel_ff[2],rd_sel_ff[5]}),
	.sw_wr({wr_sel_ff[2],wr_sel_ff[5]}),
	.write_protect_en(),
	.sw_out(test_map_1_inst_test1_TEM23__FIELD_1__swmod_out),
	.swacc_out(test_map_1_inst_test1_TEM23__FIELD_1__swacc_out)
	.hw_value(test_map_1_inst_test1_TEM23__FIELD_1__next_value),
	.hw_pulse(test_map_1_inst_test1_TEM23__FIELD_1__pulse),
	.field_value(test_map_1_inst_test1_TEM23__FIELD_1__curr_value)
	);
always_comb begin
	test_map_1_inst_test1_TEM23[31:0] = 32'd0;
	test_map_1_inst_test1_TEM23[13:13] = test_map_1_inst_test1_TEM23_FIELD_3__curr_value;
	test_map_1_inst_test1_TEM23[16:14] = test_map_1_inst_test1_TEM23_FIELD_2__curr_value;
	test_map_1_inst_test1_TEM23[17:17] = test_map_1_inst_test1_TEM23_FIELD_1__curr_value;
end
assign reg_rd_data_in[2] = test_map_1_inst_test1_TEM23;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: test_map_1_inst_test1_TEM21_alias//
//REG HIERARCHY: ['root_map', 'test_map_1_inst', 'test1', 'TEM21_alias']//
//REG ABSOLUTE_ADDR:64'h10c//
//REG OFFSET_ADDR:64'h64'h10c//
wire [31:0] test_map_1_inst_test1_TEM21_alias;
wire [31:0] test_map_1_inst_test1_TEM21_alias_wr_data;
assign test_map_1_inst_test1_TEM21_alias_wr_data = reg_sel_ff[3] && wr_en_ff ? wr_data_ff : 0;
always_comb begin
	test_map_1_inst_test1_TEM21_alias[31:0] = 32'd0;
	test_map_1_inst_test1_TEM21_alias[13:13] = test_map_1_inst_test1_TEM21_alias_FIELD_3__curr_value;
	test_map_1_inst_test1_TEM21_alias[16:14] = test_map_1_inst_test1_TEM21_alias_FIELD_2__curr_value;
	test_map_1_inst_test1_TEM21_alias[17:17] = test_map_1_inst_test1_TEM21_alias_FIELD_1__curr_value;
end
assign reg_rd_data_in[3] = test_map_1_inst_test1_TEM21_alias;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: test_map_1_inst_test1_TEM22_alias//
//REG HIERARCHY: ['root_map', 'test_map_1_inst', 'test1', 'TEM22_alias']//
//REG ABSOLUTE_ADDR:64'h110//
//REG OFFSET_ADDR:64'h64'h110//
wire [31:0] test_map_1_inst_test1_TEM22_alias;
wire [31:0] test_map_1_inst_test1_TEM22_alias_wr_data;
assign test_map_1_inst_test1_TEM22_alias_wr_data = reg_sel_ff[4] && wr_en_ff ? wr_data_ff : 0;
always_comb begin
	test_map_1_inst_test1_TEM22_alias[31:0] = 32'd0;
	test_map_1_inst_test1_TEM22_alias[13:13] = test_map_1_inst_test1_TEM22_alias_FIELD_3__curr_value;
	test_map_1_inst_test1_TEM22_alias[16:14] = test_map_1_inst_test1_TEM22_alias_FIELD_2__curr_value;
	test_map_1_inst_test1_TEM22_alias[17:17] = test_map_1_inst_test1_TEM22_alias_FIELD_1__curr_value;
end
assign reg_rd_data_in[4] = test_map_1_inst_test1_TEM22_alias;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: test_map_1_inst_test1_TEM23_alias//
//REG HIERARCHY: ['root_map', 'test_map_1_inst', 'test1', 'TEM23_alias']//
//REG ABSOLUTE_ADDR:64'h114//
//REG OFFSET_ADDR:64'h64'h114//
wire [31:0] test_map_1_inst_test1_TEM23_alias;
wire [31:0] test_map_1_inst_test1_TEM23_alias_wr_data;
assign test_map_1_inst_test1_TEM23_alias_wr_data = reg_sel_ff[5] && wr_en_ff ? wr_data_ff : 0;
always_comb begin
	test_map_1_inst_test1_TEM23_alias[31:0] = 32'd0;
	test_map_1_inst_test1_TEM23_alias[13:13] = test_map_1_inst_test1_TEM23_alias_FIELD_3__curr_value;
	test_map_1_inst_test1_TEM23_alias[16:14] = test_map_1_inst_test1_TEM23_alias_FIELD_2__curr_value;
	test_map_1_inst_test1_TEM23_alias[17:17] = test_map_1_inst_test1_TEM23_alias_FIELD_1__curr_value;
end
assign reg_rd_data_in[5] = test_map_1_inst_test1_TEM23_alias;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: test_map_2_inst_shared_2//
//REG HIERARCHY: ['root_map', 'test_map_2_inst', 'shared_2']//
//REG ABSOLUTE_ADDR:64'h118//
//REG OFFSET_ADDR:64'h64'h0//
wire [31:0] test_map_2_inst_shared_2;
wire [31:0] test_map_2_inst_shared_2_wr_data;
assign test_map_2_inst_shared_2_wr_data = reg_sel_ff[6] && wr_en_ff ? wr_data_ff : 0;
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(3),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(3'h4),
	.SRST_VALUE(),
	.USE_EXT_ASYNC_VALUE(),
	.USE_EXT_SYNC_VALUE(),
	.ALIAS_NUM(1),
	.SW_TYPE({`RW,`R}),
	.SW_ONREAD_TYPE({`RSET,`RCLR}),
	.SW_ONWRITE_TYPE({`WZT,`NA}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(`HW_RW),
	.PRECEDENCE(`SW)
	)
x__test_map_2_inst_shared_2__FIELD_1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data({test_map_2_inst_shared_2_wr_data[16:14],test_map_3_inst_shared_3_wr_data[16:14]}),
	.sw_rd({rd_sel_ff[6],rd_sel_ff[7]}),
	.sw_wr({wr_sel_ff[6],wr_sel_ff[7]}),
	.write_protect_en(),
	.sw_out(test_map_2_inst_shared_2__FIELD_1__swmod_out),
	.swacc_out(test_map_2_inst_shared_2__FIELD_1__swacc_out)
	.hw_value(test_map_2_inst_shared_2__FIELD_1__next_value),
	.hw_pulse(test_map_2_inst_shared_2__FIELD_1__pulse),
	.field_value(test_map_2_inst_shared_2__FIELD_1__curr_value)
	);
always_comb begin
	test_map_2_inst_shared_2[31:0] = 32'd0;
	test_map_2_inst_shared_2[16:14] = test_map_2_inst_shared_2_FIELD_1__curr_value;
end
assign reg_rd_data_in[6] = test_map_2_inst_shared_2;
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: test_map_3_inst_shared_3//
//REG HIERARCHY: ['root_map', 'test_map_3_inst', 'shared_3']//
//REG ABSOLUTE_ADDR:64'h11c//
//REG OFFSET_ADDR:64'h64'h0//
wire [31:0] test_map_3_inst_shared_3;
wire [31:0] test_map_3_inst_shared_3_wr_data;
assign test_map_3_inst_shared_3_wr_data = reg_sel_ff[7] && wr_en_ff ? wr_data_ff : 0;
always_comb begin
	test_map_3_inst_shared_3[31:0] = 32'd0;
	test_map_3_inst_shared_3[16:14] = test_map_3_inst_shared_3_FIELD_1__curr_value;
end
assign reg_rd_data_in[7] = test_map_3_inst_shared_3;
//=================END REG INSTANT==================//
//*******Register&field Instantiate END Here********//




//***********Rd_data Split Mux START Here***********//
split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(N), .GROUP_SIZE(64)) rd_split_mux
(.clk(clk), .rst_n(rstn),
.din(reg_rd_data_in), .sel(rd_sel_ff),
.dout(reg_rd_data_vld), .dout_vld(reg_ack_vld)
);
//************Rd_data Split Mux END Here************//


//*******OUTPUT Signal Definitinon START Here*******//
// select which to read out and pull the corresponding vld signal high
assign rd_data_vld = ack_vld_t ? rd_data_t : rd_data;
assign ack_vld = ack_vld_t;
//********OUTPUT Signal Definitinon END Here********//
endmodule