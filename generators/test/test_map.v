//===================REG INSTANT====================//
//REG NAME: test_map_1_inst_test1_TEM21//
//REG HIERARCHY: ['root_map', 'test_map_1_inst', 'test1', 'TEM21']//
//REG ABSOLUTE_ADDR:64'hc//
//REG OFFSET_ADDR:64'h64'hc//
wire [31:0] test_map_1_inst_test1_TEM21;
wire [31:0] test_map_1_inst_test1_TEM21_wr_data;
assign test_map_1_inst_test1_TEM21_wr_data = reg_sel_ff[0] && wr_sel_ff[0] && req_vld_ff[0] ? wr_data_ff : 0;
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
	.SW_TYPE({rw,rw}),
	.SW_ONREAD_TYPE({rclr,rclr}),
	.SW_ONWRITE_TYPE({wot,wot}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(rw),
	.PRECEDENCE(sw)
	)
x__test_map_1_inst_test1_TEM21_FIELD_3
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
	.hw_value(test_map_1_inst_test1_TEM21_FIELD_3__next_value),
	.hw_pulse(test_map_1_inst_test1_TEM21_FIELD_3__pulse),
	.field_value(test_map_1_inst_test1_TEM21_FIELD_3__curr_value)
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
	.SW_TYPE({rw,rw}),
	.SW_ONREAD_TYPE({rset,rclr}),
	.SW_ONWRITE_TYPE({woset,wot}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(rw),
	.PRECEDENCE(sw)
	)
x__test_map_1_inst_test1_TEM21_FIELD_2
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
	.hw_value(test_map_1_inst_test1_TEM21_FIELD_2__next_value),
	.hw_pulse(test_map_1_inst_test1_TEM21_FIELD_2__pulse),
	.field_value(test_map_1_inst_test1_TEM21_FIELD_2__curr_value)
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
	.SW_TYPE({r,rw}),
	.SW_ONREAD_TYPE({rclr,rclr}),
	.SW_ONWRITE_TYPE({`NA,wot}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(rw),
	.PRECEDENCE(sw)
	)
x__test_map_1_inst_test1_TEM21_FIELD_1
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
	.hw_value(test_map_1_inst_test1_TEM21_FIELD_1__next_value),
	.hw_pulse(test_map_1_inst_test1_TEM21_FIELD_1__pulse),
	.field_value(test_map_1_inst_test1_TEM21_FIELD_1__curr_value)
	);
always_comb begin
	test_map_1_inst_test1_TEM21[31:0] = 32'd0
	test_map_1_inst_test1_TEM21[13:13] = test_map_1_inst_test1_TEM21_FIELD_3__curr_value
	test_map_1_inst_test1_TEM21[16:14] = test_map_1_inst_test1_TEM21_FIELD_2__curr_value
	test_map_1_inst_test1_TEM21[17:17] = test_map_1_inst_test1_TEM21_FIELD_1__curr_value
end
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: test_map_1_inst_test1_TEM22//
//REG HIERARCHY: ['root_map', 'test_map_1_inst', 'test1', 'TEM22']//
//REG ABSOLUTE_ADDR:64'h10//
//REG OFFSET_ADDR:64'h64'h10//
wire [31:0] test_map_1_inst_test1_TEM22;
wire [31:0] test_map_1_inst_test1_TEM22_wr_data;
assign test_map_1_inst_test1_TEM22_wr_data = reg_sel_ff[1] && wr_sel_ff[1] && req_vld_ff[1] ? wr_data_ff : 0;
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
	.SW_TYPE({rw,rw}),
	.SW_ONREAD_TYPE({rclr,rclr}),
	.SW_ONWRITE_TYPE({wot,wot}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(rw),
	.PRECEDENCE(sw)
	)
x__test_map_1_inst_test1_TEM22_FIELD_3
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
	.hw_value(test_map_1_inst_test1_TEM22_FIELD_3__next_value),
	.hw_pulse(test_map_1_inst_test1_TEM22_FIELD_3__pulse),
	.field_value(test_map_1_inst_test1_TEM22_FIELD_3__curr_value)
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
	.SW_TYPE({rw,rw}),
	.SW_ONREAD_TYPE({rset,rclr}),
	.SW_ONWRITE_TYPE({woset,wot}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(rw),
	.PRECEDENCE(sw)
	)
x__test_map_1_inst_test1_TEM22_FIELD_2
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
	.hw_value(test_map_1_inst_test1_TEM22_FIELD_2__next_value),
	.hw_pulse(test_map_1_inst_test1_TEM22_FIELD_2__pulse),
	.field_value(test_map_1_inst_test1_TEM22_FIELD_2__curr_value)
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
	.SW_TYPE({r,rw}),
	.SW_ONREAD_TYPE({rclr,rclr}),
	.SW_ONWRITE_TYPE({`NA,wot}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(rw),
	.PRECEDENCE(sw)
	)
x__test_map_1_inst_test1_TEM22_FIELD_1
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
	.hw_value(test_map_1_inst_test1_TEM22_FIELD_1__next_value),
	.hw_pulse(test_map_1_inst_test1_TEM22_FIELD_1__pulse),
	.field_value(test_map_1_inst_test1_TEM22_FIELD_1__curr_value)
	);
always_comb begin
	test_map_1_inst_test1_TEM22[31:0] = 32'd0
	test_map_1_inst_test1_TEM22[13:13] = test_map_1_inst_test1_TEM22_FIELD_3__curr_value
	test_map_1_inst_test1_TEM22[16:14] = test_map_1_inst_test1_TEM22_FIELD_2__curr_value
	test_map_1_inst_test1_TEM22[17:17] = test_map_1_inst_test1_TEM22_FIELD_1__curr_value
end
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: test_map_1_inst_test1_TEM23//
//REG HIERARCHY: ['root_map', 'test_map_1_inst', 'test1', 'TEM23']//
//REG ABSOLUTE_ADDR:64'h14//
//REG OFFSET_ADDR:64'h64'h14//
wire [31:0] test_map_1_inst_test1_TEM23;
wire [31:0] test_map_1_inst_test1_TEM23_wr_data;
assign test_map_1_inst_test1_TEM23_wr_data = reg_sel_ff[2] && wr_sel_ff[2] && req_vld_ff[2] ? wr_data_ff : 0;
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
	.SW_TYPE({rw,rw}),
	.SW_ONREAD_TYPE({rclr,rclr}),
	.SW_ONWRITE_TYPE({wot,wot}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(rw),
	.PRECEDENCE(sw)
	)
x__test_map_1_inst_test1_TEM23_FIELD_3
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
	.hw_value(test_map_1_inst_test1_TEM23_FIELD_3__next_value),
	.hw_pulse(test_map_1_inst_test1_TEM23_FIELD_3__pulse),
	.field_value(test_map_1_inst_test1_TEM23_FIELD_3__curr_value)
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
	.SW_TYPE({rw,rw}),
	.SW_ONREAD_TYPE({rset,rclr}),
	.SW_ONWRITE_TYPE({woset,wot}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(rw),
	.PRECEDENCE(sw)
	)
x__test_map_1_inst_test1_TEM23_FIELD_2
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
	.hw_value(test_map_1_inst_test1_TEM23_FIELD_2__next_value),
	.hw_pulse(test_map_1_inst_test1_TEM23_FIELD_2__pulse),
	.field_value(test_map_1_inst_test1_TEM23_FIELD_2__curr_value)
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
	.SW_TYPE({r,rw}),
	.SW_ONREAD_TYPE({rclr,rclr}),
	.SW_ONWRITE_TYPE({`NA,wot}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(rw),
	.PRECEDENCE(sw)
	)
x__test_map_1_inst_test1_TEM23_FIELD_1
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
	.hw_value(test_map_1_inst_test1_TEM23_FIELD_1__next_value),
	.hw_pulse(test_map_1_inst_test1_TEM23_FIELD_1__pulse),
	.field_value(test_map_1_inst_test1_TEM23_FIELD_1__curr_value)
	);
always_comb begin
	test_map_1_inst_test1_TEM23[31:0] = 32'd0
	test_map_1_inst_test1_TEM23[13:13] = test_map_1_inst_test1_TEM23_FIELD_3__curr_value
	test_map_1_inst_test1_TEM23[16:14] = test_map_1_inst_test1_TEM23_FIELD_2__curr_value
	test_map_1_inst_test1_TEM23[17:17] = test_map_1_inst_test1_TEM23_FIELD_1__curr_value
end
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: test_map_1_inst_test1_TEM21_alias//
//REG HIERARCHY: ['root_map', 'test_map_1_inst', 'test1', 'TEM21_alias']//
//REG ABSOLUTE_ADDR:64'h10c//
//REG OFFSET_ADDR:64'h64'h10c//
wire [31:0] test_map_1_inst_test1_TEM21_alias;
wire [31:0] test_map_1_inst_test1_TEM21_alias_wr_data;
assign test_map_1_inst_test1_TEM21_alias_wr_data = reg_sel_ff[3] && wr_sel_ff[3] && req_vld_ff[3] ? wr_data_ff : 0;
always_comb begin
	test_map_1_inst_test1_TEM21_alias[31:0] = 32'd0
	test_map_1_inst_test1_TEM21_alias[13:13] = test_map_1_inst_test1_TEM21_alias_FIELD_3__curr_value
	test_map_1_inst_test1_TEM21_alias[16:14] = test_map_1_inst_test1_TEM21_alias_FIELD_2__curr_value
	test_map_1_inst_test1_TEM21_alias[17:17] = test_map_1_inst_test1_TEM21_alias_FIELD_1__curr_value
end
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: test_map_1_inst_test1_TEM22_alias//
//REG HIERARCHY: ['root_map', 'test_map_1_inst', 'test1', 'TEM22_alias']//
//REG ABSOLUTE_ADDR:64'h110//
//REG OFFSET_ADDR:64'h64'h110//
wire [31:0] test_map_1_inst_test1_TEM22_alias;
wire [31:0] test_map_1_inst_test1_TEM22_alias_wr_data;
assign test_map_1_inst_test1_TEM22_alias_wr_data = reg_sel_ff[4] && wr_sel_ff[4] && req_vld_ff[4] ? wr_data_ff : 0;
always_comb begin
	test_map_1_inst_test1_TEM22_alias[31:0] = 32'd0
	test_map_1_inst_test1_TEM22_alias[13:13] = test_map_1_inst_test1_TEM22_alias_FIELD_3__curr_value
	test_map_1_inst_test1_TEM22_alias[16:14] = test_map_1_inst_test1_TEM22_alias_FIELD_2__curr_value
	test_map_1_inst_test1_TEM22_alias[17:17] = test_map_1_inst_test1_TEM22_alias_FIELD_1__curr_value
end
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: test_map_1_inst_test1_TEM23_alias//
//REG HIERARCHY: ['root_map', 'test_map_1_inst', 'test1', 'TEM23_alias']//
//REG ABSOLUTE_ADDR:64'h114//
//REG OFFSET_ADDR:64'h64'h114//
wire [31:0] test_map_1_inst_test1_TEM23_alias;
wire [31:0] test_map_1_inst_test1_TEM23_alias_wr_data;
assign test_map_1_inst_test1_TEM23_alias_wr_data = reg_sel_ff[5] && wr_sel_ff[5] && req_vld_ff[5] ? wr_data_ff : 0;
always_comb begin
	test_map_1_inst_test1_TEM23_alias[31:0] = 32'd0
	test_map_1_inst_test1_TEM23_alias[13:13] = test_map_1_inst_test1_TEM23_alias_FIELD_3__curr_value
	test_map_1_inst_test1_TEM23_alias[16:14] = test_map_1_inst_test1_TEM23_alias_FIELD_2__curr_value
	test_map_1_inst_test1_TEM23_alias[17:17] = test_map_1_inst_test1_TEM23_alias_FIELD_1__curr_value
end
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: test_map_2_inst_shared_2//
//REG HIERARCHY: ['root_map', 'test_map_2_inst', 'shared_2']//
//REG ABSOLUTE_ADDR:64'h118//
//REG OFFSET_ADDR:64'h64'h0//
wire [31:0] test_map_2_inst_shared_2;
wire [31:0] test_map_2_inst_shared_2_wr_data;
assign test_map_2_inst_shared_2_wr_data = reg_sel_ff[6] && wr_sel_ff[6] && req_vld_ff[6] ? wr_data_ff : 0;
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
	.SW_TYPE({rw,r}),
	.SW_ONREAD_TYPE({rset,rclr}),
	.SW_ONWRITE_TYPE({wzt,`NA}),
	.SWMOD({0, 0}),
	.SWACC({0, 0}),
	.PULSE({0, 0}),
	.HW_TYPE(rw),
	.PRECEDENCE(sw)
	)
x__test_map_2_inst_shared_2_FIELD_1
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
	.hw_value(test_map_2_inst_shared_2_FIELD_1__next_value),
	.hw_pulse(test_map_2_inst_shared_2_FIELD_1__pulse),
	.field_value(test_map_2_inst_shared_2_FIELD_1__curr_value)
	);
always_comb begin
	test_map_2_inst_shared_2[31:0] = 32'd0
	test_map_2_inst_shared_2[16:14] = test_map_2_inst_shared_2_FIELD_1__curr_value
end
//=================END REG INSTANT==================//
//===================REG INSTANT====================//
//REG NAME: test_map_3_inst_shared_3//
//REG HIERARCHY: ['root_map', 'test_map_3_inst', 'shared_3']//
//REG ABSOLUTE_ADDR:64'h11c//
//REG OFFSET_ADDR:64'h64'h0//
wire [31:0] test_map_3_inst_shared_3;
wire [31:0] test_map_3_inst_shared_3_wr_data;
assign test_map_3_inst_shared_3_wr_data = reg_sel_ff[7] && wr_sel_ff[7] && req_vld_ff[7] ? wr_data_ff : 0;
always_comb begin
	test_map_3_inst_shared_3[31:0] = 32'd0
	test_map_3_inst_shared_3[16:14] = test_map_3_inst_shared_3_FIELD_1__curr_value
end
//=================END REG INSTANT==================//
