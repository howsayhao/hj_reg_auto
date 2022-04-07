module mst_fsm
    #(
        parameter   ADDR_WIDTH = 64,
        parameter   DATA_WIDTH = 32,
        parameter   M = 0,
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


        req_vld,
        rd_en,
        wr_en,
        addr,
        wr_data,
        // for interrupt this signal may be float
        clear,
        // these may be float for no slv_module
        slv__fsm__rd_data,
        slv__fsm__ack_vld,
        //  control signal
        addr_ff,
        wr_data_ff,
        wr_en_ff,
        rd_en_ff,
        global_sync_reset,
        interrput,

        fsm__slv__ack_rdy,
        slv__fsm__req_rdy
    );

localparam SLV_NUM = M ? M : 1;


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


output req_vld;
output rd_en;
output wr_en;
output [ADDR_WIDTH-1:0]addr;
output [DATA_WIDTH-1:0]wr_data;
// for interrupt this signal may be float
input clear;
// decode dispatch
input slv_sel;
input [DATA_WIDTH-1:0]slv__fsm__rd_data;
input slv__fsm__ack_vld;
// output control signal
output reg [ADDR_WIDTH-1:0] addr_ff;
output reg [DATA_WIDTH-1:0] wr_data_ff;
output reg wr_en_ff;
output reg rd_en_ff;
output global_sync_reset;
output reg interrput;
// reg_slv_if handshake
output reg fsm__slv__ack_rdy;
// SLV_NUM external modules
input slv__fsm__req_rdy;

reg slv__fsm__ack_vld_ff;
reg [DATA_WIDTH-1:0]slv__fsm__rd_data_ff;


// state decode
// localparam   S_IDLE = 2'd0;
localparam   S_SETUP = 2'd0;
localparam   S_WAIT_RDY = 2'd1; //slave is not ready to get command, lock the control signal
localparam   S_WAIT_ACK = 2'd2; //slave is get command, free the control signal and wait for ack
localparam   S_ACCESS =  2'd3; // return result to APB bus

reg state;
reg next_state;


// S_WAIT_RDY time: TIMECNT * Tclk
reg [16-1:0] cnt;
reg op_time_out;

reg [ADDR_WIDTH-1:0] leaf_node;
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
                else if(slv__fsm__req_rdy) next_state = S_WAIT_ACK;
                else next_state = S_WAIT_RDY;
        end
        S_WAIT_RDY:begin
            if(slv__fsm__ack_vld) next_state = S_SETUP;
            else if(slv__fsm__req_rdy) next_state = S_SETUP;
            else next_state = S_WAIT_RDY;
        end
        S_WAIT_ACK:begin
            if(slv__fsm__ack_vld) next_state = S_SETUP;
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
        addr_ff <= 0;
        wr_data_ff <= 0;
        wr_en_ff <= 1'b0;
        rd_en_ff <= 1'b0;
    end
    else begin
        addr_ff <= (state == S_SETUP && next_state != S_SETUP) ? PADDR : addr_ff;
        wr_data_ff <= (state == S_SETUP && next_state != S_SETUP) ? PWDATA : wr_data_ff;
        wr_en_ff <= (next_state == S_WAIT_SLV_RDY) ? PWRITE : 1'b0;
        rd_en_ff <= (next_state == S_WAIT_SLV_RDY) ? !PWRITE : 1'b0;
    end
end

//handshake for slv
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        fsm__slv__req_vld_ff <= 0;
        fsm__slv__ack_rdy_ff <= 0;
    end
    else begin
        fsm__slv__req_vld_ff <= (next_state == S_WAIT_SLV_RDY) ? 1'b1 : 1'b0;
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

// for time out interrupt and lef_node record
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        interrupt <= 1'b0;
        leaf_node <= 0;
    end
    else begin
        if(op_time_out)
            interrupt <= 1'b1;
            leaf_node <= addr_ff;
        else if(clear)
            interrupt <= 1'b0;
            leaf_node <= 0;
        else
            interrupt <= interrupt;
            leaf_node <= leaf_node;
    end
end

assign global_sync_reset = op_time_out;

// assign handshake output signal
assign fsm__slv__req_vld = fsm__slv__req_vld_ff;
assign fsm__slv__ack_rdy = fsm__slv__ack_rdy_ff;

// APB output
// if ack_vld in SETUP, ready should last for 2 cycle
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        slv__fsm__ack_vld_ff <= 1'b0;
        slv__fsm__rd_data_ff <= 0;
    end
    else begin
        slv__fsm__ack_vld_ff <= state == S_SETUP ? slv__fsm__ack_vld;
        slv__fsm__rd_data_ff <= slv__fsm__rd_data;
    end
end


assign PREADY = (next_state != S_SETUP) ? 1'b1 : 1'b0;
assign PRDATA = slv__fsm__ack_vld ? slv__fsm__rd_data : {DATA_WIDTH{1'b0}};
assign PSLVERR = op_time_out;
endmodule