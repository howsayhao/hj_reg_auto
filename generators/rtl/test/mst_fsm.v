module mst_fsm
    #(
        parameter   ADDR_WIDTH = 64,
        parameter   DATA_WIDTH = 32,
        parameter TIMECNT = 99
    )
    (
        clk,
        rstn,
        PADDR,
        PWRITE,
        PSEL,
        PENABLE,
        PWDATA,
        PRDATA,
        PREADY,
        PSLVERR,

        // for interrupt this signal may be float
        clear,
        //  control signal
        fsm__slv__addr,
        fsm__slv__wr_data,
        fsm__slv__wr_en,
        fsm__slv__rd_en,
        fsm__slv__sync_reset,
        interrupt,

        fsm__slv__req_vld,
        fsm__slv__ack_rdy,
        slv__fsm__req_rdy,
        fsm__mst__req_rdy,

        external_reg_selected,
        // these may be float for no slv_module
        slv__fsm__rd_data,
        slv__fsm__ack_vld,
        // for CDC situation
        cdc_pulse_out
    );


input clk;
input rstn;

input [ADDR_WIDTH-1:0] PADDR;
input PWRITE;
input PSEL;
input PENABLE;
input [DATA_WIDTH-1:0] PWDATA;
output [DATA_WIDTH-1:0] PRDATA;
output PREADY;
output PSLVERR;


output fsm__slv__req_vld;
// for interrupt this signal may be float
input clear;
// decode dispatch
input [DATA_WIDTH-1:0]slv__fsm__rd_data;
input slv__fsm__ack_vld;
// output control signal
output reg [ADDR_WIDTH-1:0] fsm__slv__addr;
output reg [DATA_WIDTH-1:0] fsm__slv__wr_data;
output reg fsm__slv__wr_en;
output reg fsm__slv__rd_en;
output fsm__slv__sync_reset;
output reg interrupt;
// reg_slv_if handshake
output fsm__slv__ack_rdy;
output fsm__mst__req_rdy;
// SLV_NUM external modules
input external_reg_selected;
input slv__fsm__req_rdy;

output reg cdc_pulse_out;

reg slv__fsm__ack_vld_ff;
reg fsm__slv__req_vld_ff;
reg fsm__slv__ack_rdy_ff;
reg [DATA_WIDTH-1:0]slv__fsm__rd_data_ff;


// state decode
// localparam   S_IDLE = 2'd0;
localparam   S_SETUP = 2'd0;
localparam   S_WAIT_SLV_RDY = 2'd1; //slave is not ready to get command, lock the control signal
localparam   S_WAIT_SLV_ACK = 2'd2; //slave is get command, free the control signal and wait for ack
localparam   S_ACCESS =  2'd3; // return result to APB bus

reg [1:0] state;
reg [1:0] next_state;


// S_WAIT_SLV_RDY time: TIMECNT * Tclk
reg [16-1:0] cnt;
reg op_time_out;

reg [ADDR_WIDTH-1:0] leaf_node;

// generate value pulse_out
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn) cdc_pulse_out <= 1'b0;
    else if(next_state != state) cdc_pulse_out <= 1'b1;
    else cdc_pulse_out <= 1'b0;
end

// state transfer
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        state <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

// state transfer flow
always_comb begin
    case(state)
        S_SETUP:begin
            if(PSEL & !PENABLE)
                if(slv__fsm__ack_vld) next_state = S_ACCESS;
                else if(external_reg_selected & slv__fsm__req_rdy) next_state = S_WAIT_SLV_ACK;
                else next_state = S_WAIT_SLV_RDY;
        end
        S_WAIT_SLV_RDY:begin
            if(slv__fsm__ack_vld | op_time_out) next_state = S_SETUP;
            else if(external_reg_selected & slv__fsm__req_rdy) next_state = S_WAIT_SLV_ACK;
            else next_state = S_WAIT_SLV_RDY;
        end
        S_WAIT_SLV_ACK:begin
            if(slv__fsm__ack_vld | op_time_out) next_state = S_SETUP;
        end
        S_ACCESS:begin
             next_state = S_SETUP;
        end
        default: next_state = S_SETUP;
    endcase
end

// write/read control signal
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        fsm__slv__addr <= 0;
        fsm__slv__wr_data <= 0;
        fsm__slv__wr_en <= 1'b0;
        fsm__slv__rd_en <= 1'b0;
    end
    else begin
        fsm__slv__addr <= (state == S_SETUP && next_state != S_SETUP) ? PADDR : fsm__slv__addr;
        fsm__slv__wr_data <= (state == S_SETUP && next_state != S_SETUP) ? PWDATA : fsm__slv__wr_data;

        // case1: external_reg_selected && state == S_SETUP && next_state == S_WAIT_SLV_ACK
        //        when APB launches a requistion for external_reg while external_reg is rdy, latch the control signal for 1 cycle
        // case2: next_state == S_WAIT_SLV_RDY
        //        when APB launches a requistion for external_reg while external_reg is not rdy, latch the control signal until slv_rdy back
        fsm__slv__wr_en <= (external_reg_selected && state == S_SETUP && next_state == S_WAIT_SLV_ACK) ? PWRITE :
                                                                                                         (next_state == S_WAIT_SLV_RDY) ? PWRITE : 1'b0;
        fsm__slv__rd_en <= (external_reg_selected && state == S_SETUP && next_state == S_WAIT_SLV_ACK) ? !PWRITE :
                                                                                                         (next_state == S_WAIT_SLV_RDY) ? !PWRITE : 1'b0;
    end
end

//handshake for slv
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        fsm__slv__req_vld_ff <= 0;
        fsm__slv__ack_rdy_ff <= 0;
    end
    else begin
        // case1: external_reg_selected && state == S_SETUP && next_state == S_WAIT_SLV_ACK
        //        when APB launches a requistion for external_reg while external_reg is rdy, latch the control signal for 1 cycle
        // case2: next_state == S_WAIT_SLV_RDY
        //        when APB launches a requistion for external_reg while external_reg is not rdy, latch the control signal until slv_rdy back
        fsm__slv__req_vld_ff <= (external_reg_selected && state == S_SETUP && next_state == S_WAIT_SLV_ACK) ? 1'b1 :
                                                                                                              (next_state == S_WAIT_SLV_RDY) ? 1'b1 : 1'b0;
        fsm__slv__ack_rdy_ff <= (next_state == S_WAIT_SLV_ACK) ? 1'b1 : 1'b0;
    end
end

always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        cnt <= 0;
        op_time_out <= 1'b0;
    end
    else begin
        cnt <= (next_state != S_SETUP) ? (cnt == TIMECNT ? 1'b0 : cnt + 1'b1 ) : 1'b0;
        op_time_out <= (next_state != S_SETUP) ? (cnt == TIMECNT ? 1'b1 : 1'b0 ) : 1'b0;
    end
end

// for time-out interrupt and leaf_node record
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        interrupt <= 1'b0;
        leaf_node <= 0;
    end
    else begin
        if(op_time_out) begin
            interrupt <= 1'b1;
            leaf_node <= fsm__slv__addr;
        end
        else if(clear) begin
            interrupt <= 1'b0;
            leaf_node <= 0;
        end
        else begin
            interrupt <= interrupt;
            leaf_node <= leaf_node;
        end
    end
end

assign fsm__slv__sync_reset = op_time_out;

// assign handshake output signal
assign fsm__slv__req_vld = fsm__slv__req_vld_ff;
assign fsm__slv__ack_rdy = fsm__slv__ack_rdy_ff;
assign fsm__mst__req_rdy = (state == S_SETUP) ? 1'b1 : 1'b0;

// APB output
// if ack_vld in SETUP, ready should last for 2 cycle
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        slv__fsm__ack_vld_ff <= 1'b0;
        slv__fsm__rd_data_ff <= 0;
    end
    else begin
        slv__fsm__ack_vld_ff <= slv__fsm__ack_vld;
        slv__fsm__rd_data_ff <= slv__fsm__rd_data;
    end
end


assign PREADY = (state == S_ACCESS) ? slv__fsm__ack_vld_ff : slv__fsm__ack_vld | op_time_out;
assign PRDATA = (state == S_ACCESS) ? slv__fsm__rd_data_ff :
                                      op_time_out ? 32'hdead_1eaf : slv__fsm__rd_data;
assign PSLVERR = op_time_out;
endmodule