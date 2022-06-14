`include "xregister.vh"
`default_nettype none
module regmst_template_mst (
    // regmst is at register native clock domain
    clk, rst_n,
    // APB interface to upstream SoC interconnect
    psel, penable, pready, pslverr, pwrite, paddr, pwdata, prdata,
    // reg_native_if to the downstream regdisp module
    ext_req_vld, ext_ack_vld, ext_wr_en, ext_rd_en, ext_addr, ext_wr_data, ext_rd_data,
    // soft reset signal to downstream modules
    soft_rst_o
);
    parameter       ADDR_WIDTH  = 64;
    parameter       DATA_WIDTH  = 32;
    localparam      REG_NUM     = 4;

    input   logic                       clk;
    input   logic                       rst_n;

    input   logic                       psel;
    input   logic                       penable;
    output  logic                       pready;
    output  logic                       pslverr;
    input   logic                       pwrite;
    input   logic   [ADDR_WIDTH-1:0]    paddr;
    input   logic   [DATA_WIDTH-1:0]    pwdata;
    output  logic   [DATA_WIDTH-1:0]    prdata;

    output  logic                       ext_req_vld;
    input   logic                       ext_ack_vld;
    output  logic                       ext_wr_en;
    output  logic                       ext_rd_en;
    output  logic   [ADDR_WIDTH-1:0]    ext_addr;
    output  logic   [DATA_WIDTH-1:0]    ext_wr_data;
    input   logic   [DATA_WIDTH-1:0]    ext_rd_data;
    output  logic                       soft_rst_o;

    logic   [REG_NUM-1:0]               dec_db_reg_sel;
    logic                               dec_ext_sel;
    logic 	                            dec_dummy_reg_sel;

    logic                               fsm_req_vld;
    logic                               fsm_ack_vld;
    logic                               fsm_wr_en;
    logic 	                            fsm_rd_en;
    logic   [ADDR_WIDTH-1:0]            fsm_addr;
    logic   [DATA_WIDTH-1:0]            fsm_wr_data;
    logic   [DATA_WIDTH-1:0]            fsm_rd_data;

    logic   [DATA_WIDTH-1:0]            tmr_cnt;
    logic                               tmr_tmout;
    logic                               tmr_rst;

    logic   [31:0]                      db_err_addr__snap_0_wr_data;
    logic                               db_err_addr__snap_0_wr_en;
    logic                               db_err_addr__snap_0_rd_en;
    logic   [31:0]                      db_err_addr__snap_1_wr_data;
    logic                               db_err_addr__snap_1_wr_en;
    logic                               db_err_addr__snap_1_rd_en;
    logic   [31:0]                      db_err_addr__snap_0_o;
    logic   [31:0]                      db_err_addr__snap_1_o;
    logic   [63:0]                      db_err_addr_o;
    logic   [1:0]                       db_err_addr_snapshot_snap_wr_en;
    logic   [1:0]                       db_err_addr_snapshot_snap_rd_en;
    logic   [63:0]                      db_err_addr_snapshot_snap_wr_data;
    logic   [63:0]                      db_err_addr_snapshot_snap_rd_data;
    logic   [63:0]                      db_err_addr_snapshot_reg_wr_data;
    logic   [63:0]                      db_err_addr_snapshot_reg_rd_data;
    logic                               db_err_addr_snapshot_reg_wr_en;
    logic                               db_err_addr_snapshot_reg_rd_en;
    logic   [63:0]                      db_err_addr__ADDR__next_value;
    logic                               db_err_addr__ADDR__pulse;
    logic   [63:0]                      db_err_addr__ADDR__curr_value;

    logic   [31:0]                      db_tmr_thr_wr_data;
    logic                               db_tmr_thr_wr_en;
    logic                               db_tmr_thr_rd_en;
    logic   [31:0]                      db_tmr_thr_o;
    logic   [31:0]                      db_tmr_thr__CNT__curr_value;

    logic   [31:0]                      db_err_stat_wr_data;
    logic                               db_err_stat_wr_en;
    logic                               db_err_stat_rd_en;
    logic   [31:0]                      db_err_stat_o;
    logic                               db_err_stat__SOFT_RST__curr_value;
    logic                               db_err_stat__ERR_OCCUR__curr_value;
    logic                               db_err_stat__ERR_OCCUR__next_value;
    logic                               db_err_stat__ERR_OCCUR__pulse;
    logic                               db_err_stat__ERR_ACC_TYPE__curr_value;
    logic                               db_err_stat__ERR_ACC_TYPE__next_value;
    logic                               db_err_stat__ERR_ACC_TYPE__pulse;

    logic   [REG_NUM:0] [DATA_WIDTH-1:0]    reg_rd_split_mux_din;
    logic   [REG_NUM:0]                     reg_rd_split_mux_sel;
    logic                                   reg_rd_split_mux_dout_vld;
    logic                                   dummy_reg_rd_sel;
    logic   [REG_NUM-1:0] [DATA_WIDTH-1:0]  db_reg_rd_data;
    logic   [REG_NUM-1:0]                   db_reg_wr_sel;
    logic   [REG_NUM-1:0]                   db_reg_rd_sel;
    logic                                   db_reg_ack_vld;
    logic   [DATA_WIDTH-1:0]                int_rd_data;

//****************************************ADDRESS DECODER START*****************************************//
    // distinguish access requests to:
    //      internel debug registers
    //      external regdisp module
    //      empty address slot (dummy register)
    always_comb begin
        dec_db_reg_sel      = {REG_NUM {1'b0}};
        dec_ext_sel         = 1'b0;
        dec_dummy_reg_sel   = 1'b0;
        unique casez (paddr[63:2])
            62'h0???????, 62'h1???????, 62'h2???????, 62'h3???????, 62'h4???????, 62'h5???????, 62'h6???????, 62'h7???????, 62'h8000000?, 62'h8000001?, 62'h8000002?, 62'h8000003?, 62'h80000040, 62'h80000041, 62'h80000042, 62'h80000043: dec_ext_sel = 1'b1;
            62'h80000400: dec_db_reg_sel[0] = 1'b1;
            62'h80000401: dec_db_reg_sel[1] = 1'b1;
            62'h80000402: dec_db_reg_sel[2] = 1'b1;
            62'h80000403: dec_db_reg_sel[3] = 1'b1;
            default: dec_dummy_reg_sel  = 1'b1;
        endcase
    end
//****************************************ADDRESS DECODER END*****************************************//

//****************************************FSM INSTANCE START*****************************************//
    mst_fsm #(
        .ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
    mst_fsm (
        .clk                    (clk),
        .rst_n                  (rst_n),
        .psel                   (psel),
        .penable                (penable),
        .pready                 (pready),
        .pslverr                (pslverr),
        .paddr                  (paddr),
        .pwrite                 (pwrite),
        .pwdata                 (pwdata),
        .prdata                 (prdata),
        .fsm_req_vld            (fsm_req_vld),
        .fsm_ack_vld            (fsm_ack_vld),
        .fsm_addr               (fsm_addr),
        .fsm_wr_en              (fsm_wr_en),
        .fsm_rd_en              (fsm_rd_en),
        .fsm_wr_data            (fsm_wr_data),
        .fsm_rd_data            (fsm_rd_data),
        .tmr_tmout              (tmr_tmout),
        .tmr_rst                (tmr_rst)
    );
//*****************************************FSM INSTANCE END*******************************************//

//*******************************************TIMER START**********************************************//
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n || tmr_rst)
            tmr_cnt <= {DATA_WIDTH{1'b0}};
        else if (tmr_cnt < db_tmr_thr_o)
            tmr_cnt <= tmr_cnt + 1'b1;
    end

    assign  tmr_tmout = (tmr_cnt == db_tmr_thr_o);
//********************************************TIMER END***********************************************//

//*********************************DEBUG REGISTERS INSTANCE START*************************************//
    // debug register: db_err_addr (64-bit)
    // description:
    //      address of the access where timeout event occurs
    // absolute address:
    // base offset:
    // reset value: 0x0
    // include 2 snapshot registers:
    //      snapshot register 0: db_err_addr__snap_0
    //          absolute address:
    //          base offset:
    //      snapshot register 1: db_err_addr__snap_1
    //          absolute address:
    //          base offset:

    field #(
        .F_WIDTH                (64),
        .ARST_VALUE             (64'h0),
        .SW_TYPE                ({`SW_RO}),
        .SW_ONREAD_TYPE         ({`NA}),
        .SW_ONWRITE_TYPE        ({`NA}),
        .HW_TYPE                (`HW_RW),
        .PRECEDENCE             (`SW))
    x__db_err_addr__ADDR (
        .clk                    (clk),
        .rst_n                  (rst_n),
        .sync_rst               (1'b0),
        .sw_wr_data             (db_err_addr_snapshot_reg_wr_data[63:0]),
        .sw_rd                  (db_err_addr_snapshot_reg_rd_en),
        .sw_wr                  (db_err_addr_snapshot_reg_wr_en),
        .write_protect_en       (1'b0),
        .sw_type_alter_signal   (1'b0),
        .swmod_out              (),
        .swacc_out              (),
        .hw_value               (db_err_addr__ADDR__next_value),
        .hw_pulse               (db_err_addr__ADDR__pulse),
        .field_value            (db_err_addr__ADDR__curr_value)
    );
    always_comb begin
        db_err_addr_o[63:0]     = 64'h0;
        db_err_addr_o[63:0]     = db_err_addr__ADDR__curr_value;
    end
    assign  db_err_addr_snapshot_reg_rd_data    = db_err_addr_o;

    assign  db_err_addr_snapshot_snap_wr_en     = {db_err_addr__snap_1_wr_en, db_err_addr__snap_0_wr_en};
    assign  db_err_addr_snapshot_snap_rd_en     = {db_err_addr__snap_1_rd_en, db_err_addr__snap_0_rd_en};
    assign  db_err_addr_snapshot_snap_wr_data   = {db_err_addr__snap_1_wr_data, db_err_addr__snap_0_wr_data};
    assign  {db_err_addr__snap_1_o, db_err_addr__snap_0_o}  = db_err_addr_snapshot_snap_rd_data;

    snapshot_reg #(.DATA_WIDTH(32), .REG_WIDTH(64))
    db_err_addr_snapshot (
        .clk                     (clk),
        .rst_n                   (rst_n),
        .mst__fsm__sync_reset    (soft_rst_o),
        .snap_wr_en              (db_err_addr_snapshot_snap_wr_en),
        .snap_rd_en              (db_err_addr_snapshot_snap_rd_en),
        .snap_wr_data            (db_err_addr_snapshot_snap_wr_data),
        .snap_rd_data            (db_err_addr_snapshot_snap_rd_data),
        .reg_wr_en               (db_err_addr_snapshot_reg_wr_en),
        .reg_rd_en               (db_err_addr_snapshot_reg_rd_en),
        .reg_wr_data             (db_err_addr_snapshot_reg_wr_data),
        .reg_rd_data             (db_err_addr_snapshot_reg_rd_data)
    );

    // debug register: db_tmr_thr (32-bit)
    // description:
    //      overflow threshold of the timer that
    //      counts for access cycles since regmst receives an APB transaction
    // absolute address:
    // base offset:
    // reset value: 0x63 (0d99)
    field #(
        .F_WIDTH                (32),
        .ARST_VALUE             (32'h63),
        .SW_TYPE                ({`SW_RW}),
        .SW_ONREAD_TYPE         ({`NA}),
        .SW_ONWRITE_TYPE        ({`NA}),
        .HW_TYPE                (`HW_RW),
        .PRECEDENCE             (`SW))
    x__db_tmr_thr__CNT (
        .clk                    (clk),
        .rst_n                  (rst_n),
        .sync_rst               (1'b0),
        .sw_wr_data             (db_tmr_thr_wr_data[31:0]),
        .sw_rd                  (db_tmr_thr_rd_en),
        .sw_wr                  (db_tmr_thr_wr_en),
        .write_protect_en       (1'b0),
        .sw_type_alter_signal   (1'b0),
        .swmod_out              (),
        .swacc_out              (),
        .hw_value               (32'b0),
        .hw_pulse               (1'b0),
        .field_value            (db_tmr_thr__CNT__curr_value)
    );

    always_comb begin
        db_tmr_thr_o[31:0]      = 32'h0;
        db_tmr_thr_o[31:0]      = db_tmr_thr__CNT__curr_value;
    end

    // debug register: db_err_stat
    // description:
    //      record error status.
    //      when field SOFT_RST is asserted, all FSM in downstream modules are reset
    //      so that access won't be stuck at waiting for response
    // absolute address:
    // base offset:
    // reset value: 0x0
    field #(
        .F_WIDTH                (1),
        .ARST_VALUE             (1'h0),
        .SW_TYPE                ({`SW_RW}),
        .SW_ONREAD_TYPE         ({`NA}),
        .SW_ONWRITE_TYPE        ({`NA}),
        .HW_TYPE                (`HW_RW),
        .PRECEDENCE             (`SW))
    x__db_err_stat__SOFT_RST (
        .clk                    (clk),
        .rst_n                  (rst_n),
        .sync_rst               (1'b0),
        .sw_wr_data             (db_err_stat_wr_data[0:0]),
        .sw_rd                  (db_err_stat_rd_en),
        .sw_wr                  (db_err_stat_wr_en),
        .write_protect_en       (1'b0),
        .sw_type_alter_signal   (1'b0),
        .swmod_out              (),
        .swacc_out              (),
        .hw_value               (1'b0),
        .hw_pulse               (1'b0),
        .field_value            (db_err_stat__SOFT_RST__curr_value)
    );
    // soft reset signal is from register db_err_stat bit 0 (SOFT_RST)
    assign  soft_rst_o          = db_err_stat__SOFT_RST__curr_value;

    field #(
        .F_WIDTH                (1),
        .ARST_VALUE             (1'h0),
        .SW_TYPE                ({`SW_RW}),
        .SW_ONREAD_TYPE         ({`NA}),
        .SW_ONWRITE_TYPE        ({`NA}),
        .HW_TYPE                (`HW_RW),
        .PRECEDENCE             (`SW))
    x__db_err_stat__ERR_OCCUR (
        .clk                    (clk),
        .rst_n                  (rst_n),
        .sync_rst               (1'b0),
        .sw_wr_data             (db_err_stat_wr_data[1:1]),
        .sw_rd                  (db_err_stat_rd_en),
        .sw_wr                  (db_err_stat_wr_en),
        .write_protect_en       (1'b0),
        .sw_type_alter_signal   (1'b0),
        .swmod_out              (),
        .swacc_out              (),
        .hw_value               (db_err_stat__ERR_OCCUR__next_value),
        .hw_pulse               (db_err_stat__ERR_OCCUR__pulse),
        .field_value            (db_err_stat__ERR_OCCUR__curr_value)
    );
    // timeout event is recorded in field ERR_OCCUR
    assign  db_err_stat__ERR_OCCUR__pulse           = tmr_tmout;
    assign  db_err_stat__ERR_OCCUR__next_value      = tmr_tmout;

    field #(
        .F_WIDTH                (1),
        .ARST_VALUE             (1'h0),
        .SW_TYPE                ({`SW_RO}),
        .SW_ONREAD_TYPE         ({`NA}),
        .SW_ONWRITE_TYPE        ({`NA}),
        .HW_TYPE                (`HW_RW),
        .PRECEDENCE             (`SW))
    x__db_err_stat__ERR_ACC_TYPE (
        .clk                    (clk),
        .rst_n                  (rst_n),
        .sync_rst               (1'b0),
        .sw_wr_data             (db_err_stat_wr_data[2:2]),
        .sw_rd                  (db_err_stat_rd_en),
        .sw_wr                  (db_err_stat_wr_en),
        .write_protect_en       (1'b0),
        .sw_type_alter_signal   (1'b0),
        .swmod_out              (),
        .swacc_out              (),
        .hw_value               (db_err_stat__ERR_ACC_TYPE__next_value),
        .hw_pulse               (db_err_stat__ERR_ACC_TYPE__pulse),
        .field_value            (db_err_stat__ERR_ACC_TYPE__curr_value)
    );
    // field ERR_ACC_TYPE records whether error occurs in write or read transaction
    assign  db_err_stat__ERR_ACC_TYPE__pulse        = tmr_tmout;
    assign  db_err_stat__ERR_ACC_TYPE__next_value   = pwrite;

    always_comb begin
        db_err_stat_o[31:0]     = 32'h0;
        db_err_stat_o[0:0]      = db_err_stat__SOFT_RST__curr_value;
        db_err_stat_o[1:1]      = db_err_stat__ERR_OCCUR__curr_value;
        db_err_stat_o[2:2]      = db_err_stat__ERR_ACC_TYPE__curr_value;
    end

//**********************************DEBUG REGISTERS INSTANCE END**************************************//

//*************************INTERNAL/EXTERNAL MUX/IMUX INSTANCE START**********************************//
    // internal register multiplexor: rd_data and ack_vld from debug registers
    assign  db_reg_rd_data[0]           = db_err_addr__snap_0_o;
    assign  db_reg_rd_data[1]           = db_err_addr__snap_1_o;
    assign  db_reg_rd_data[2]           = db_tmr_thr_o;
    assign  db_reg_rd_data[3]           = db_err_stat_o;

    assign  reg_rd_split_mux_din        = {db_reg_rd_data, {DATA_WIDTH{1'b0}}};
    assign  reg_rd_split_mux_sel        = {db_reg_rd_sel, dummy_reg_rd_sel};
    split_mux_2d #(
        .WIDTH(DATA_WIDTH), .CNT(REG_NUM+1),
        .GROUP_SIZE(128), .SKIP_DFF_0(1), .SKIP_DFF_1(1))
    reg_rd_split_mux (
        .clk                    (clk),
        .rst_n                  (rst_n),
        .din                    (reg_rd_split_mux_din),
        .sel                    (reg_rd_split_mux_sel),
        .dout                   (int_rd_data),
        .dout_vld               (reg_rd_split_mux_dout_vld));

    assign  db_reg_ack_vld  = reg_rd_split_mux_dout_vld | fsm_wr_en;

    // internal register inverse multiplexor: to debug registers
    assign  db_reg_wr_sel               = {REG_NUM{fsm_wr_en}} & dec_db_reg_sel;
    assign  db_reg_rd_sel               = {REG_NUM{fsm_rd_en}} & dec_db_reg_sel;
    assign  dummy_reg_rd_sel            = dec_dummy_reg_sel & fsm_req_vld;

    assign  db_err_addr__snap_0_wr_data = db_reg_wr_sel[0] ? fsm_wr_data : {DATA_WIDTH{1'b0}};
    assign  db_err_addr__snap_0_wr_en   = db_reg_wr_sel[0];
    assign  db_err_addr__snap_0_rd_en   = db_reg_rd_sel[0];

    assign  db_err_addr__snap_1_wr_data = db_reg_wr_sel[1] ? fsm_wr_data : {DATA_WIDTH{1'b0}};
    assign  db_err_addr__snap_1_wr_en   = db_reg_wr_sel[1];
    assign  db_err_addr__snap_1_rd_en   = db_reg_rd_sel[1];

    assign  db_tmr_thr_wr_data          = db_reg_wr_sel[2] ? fsm_wr_data : {DATA_WIDTH{1'b0}};
    assign  db_tmr_thr_wr_en            = db_reg_wr_sel[2];
    assign  db_tmr_thr_rd_en            = db_reg_rd_sel[2];

    assign  db_err_stat_wr_data         = db_reg_wr_sel[3] ? fsm_wr_data : {DATA_WIDTH{1'b0}};
    assign  db_err_stat_wr_en           = db_reg_wr_sel[3];
    assign  db_err_stat_rd_en           = db_reg_rd_sel[3];

    // ultimate multiplexor: to mst_fsm
    assign  fsm_rd_data     = db_reg_ack_vld ? int_rd_data : (ext_ack_vld ? ext_rd_data : {DATA_WIDTH{1'b0}});
    assign  fsm_ack_vld     = db_reg_ack_vld | ext_ack_vld;

    // ultimate inverse multiplexor: to the external downstream regdisp module
    assign  ext_req_vld                 = fsm_req_vld & dec_ext_sel;
    assign  ext_wr_en                   = fsm_wr_en & dec_ext_sel;
    assign  ext_rd_en                   = fsm_rd_en & dec_ext_sel;
    assign  ext_addr                    = dec_ext_sel ? fsm_addr : {ADDR_WIDTH{1'b0}};
    assign  ext_wr_data                 = dec_ext_sel ? fsm_wr_data : {DATA_WIDTH{1'b0}};
//**************************INTERNAL/EXTERNAL MUX/IMUX INSTANCE END***********************************//
endmodule
`default_nettype wire