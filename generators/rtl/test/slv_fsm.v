module slv_fsm
    #(
        parameter   ADDR_WIDTH = 64,
        parameter   DATA_WIDTH = 32
    )
    (
        clk,
        rstn,
        mst__fsm__req_vld,
        fsm__mst__ack_vld,
        mst__fsm__addr,
        mst__fsm__wr_en,
        mst__fsm__rd_en,
        fsm__mst__rd_data,
        mst__fsm__wr_data,
        //  control signal
        fsm__slv__req_vld,
        slv__fsm__ack_vld,
        fsm__slv__addr,
        fsm__slv__wr_en,
        fsm__slv__wr_data,
        fsm__slv__rd_en,
        slv__fsm__rd_data,

        external_reg_selected,
        ext_ack_is_back,

        mst__fsm__sync_reset,
        fsm__slv__sync_reset
    );


// state decode
localparam   S_IDLE = 2'd0; // no operation
localparam   S_WAIT_SLV_ACK =  2'd1; // S_WAIT_SLV_RDY slave fsm__mst__ack_vld
//reg_slv_if in
input clk;
input rstn;
input mst__fsm__rd_en;
input mst__fsm__wr_en;
input [ADDR_WIDTH-1:0] mst__fsm__addr;
input [DATA_WIDTH-1:0] mst__fsm__wr_data;
// decoder in
input mst__fsm__sync_reset;
input [DATA_WIDTH-1:0] slv__fsm__rd_data;
input slv__fsm__ack_vld;
// internal/external reg control signal
output reg fsm__slv__sync_reset;
output [ADDR_WIDTH-1:0] fsm__slv__addr;
output [DATA_WIDTH-1:0] fsm__slv__wr_data;
output fsm__slv__wr_en;
output fsm__slv__rd_en;
// reg_slv_if handshake
input mst__fsm__req_vld;
output fsm__mst__ack_vld;
output fsm__slv__req_vld;
output [DATA_WIDTH-1:0] fsm__mst__rd_data;
//
input external_reg_selected;
input ext_ack_is_back;

// machine state value
reg [1:0] next_state;
reg [1:0] state;

//define reg for latching output to slave
reg [ADDR_WIDTH-1:0] mst__fsm__addr_ff;
reg [DATA_WIDTH-1:0]mst__fsm__wr_data_ff;
reg mst__fsm__wr_en_ff;
reg mst__fsm__rd_en_ff;
reg fsm__slv__req_vld_ff;
// to see if the module selected is accessable

// state transfer
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        state <= 2'b0;
    end
    else begin
        state <= next_state;
    end
end

// state transfer flow
always_comb begin
    case(state)
        // if mst__fsm__sync_reset, next_state back to IDLE, else check req_vld from the master as well as req_rdy and ack_vld from the slave
        S_IDLE:begin
            next_state = mst__fsm__sync_reset ? S_IDLE :
                                                !mst__fsm__req_vld ? S_IDLE :
                                                                     slv__fsm__ack_vld ? S_IDLE : S_WAIT_SLV_ACK;
        end
        S_WAIT_SLV_ACK:begin
            next_state = mst__fsm__sync_reset ? S_IDLE :
                                                slv__fsm__ack_vld ? S_IDLE : S_WAIT_SLV_ACK;
        end
        default: next_state = S_IDLE;
    endcase
end
// for output control signal latch
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        mst__fsm__addr_ff <= 0;
        mst__fsm__wr_data_ff <= 0;
        mst__fsm__wr_en_ff <= 0;
        mst__fsm__rd_en_ff <= 0;
    end
    else begin
        mst__fsm__addr_ff <= (state == S_IDLE && next_state != S_IDLE) ? mst__fsm__addr : mst__fsm__addr_ff;
        mst__fsm__wr_data_ff <= (state == S_IDLE && next_state != S_IDLE) ? mst__fsm__wr_data : fsm__slv__wr_data;

        // internal operation only need latch for 1 cycle
        mst__fsm__wr_en_ff <= (state == S_IDLE && next_state != S_IDLE) ? mst__fsm__wr_en :
                                                                          (next_state == S_WAIT_SLV_ACK) ? mst__fsm__wr_en & external_reg_selected : 1'b0;
        mst__fsm__rd_en_ff <= (state == S_IDLE && next_state != S_IDLE) ? mst__fsm__rd_en :
                                                                          (next_state == S_WAIT_SLV_ACK) ? mst__fsm__rd_en & external_reg_selected : 1'b0;
    end
end

// for output handshake signal
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        fsm__slv__req_vld_ff <= 0;
    end
    else begin
        if(ext_ack_is_back) fsm__slv__req_vld_ff <= 1'b0;
        else if(state == S_IDLE && next_state == S_WAIT_SLV_ACK) fsm__slv__req_vld_ff <= 1'b1;
        else if(next_state == S_IDLE) fsm__slv__req_vld_ff <= 1'b0;
        else fsm__slv__req_vld_ff <= fsm__slv__req_vld_ff;
    end
end

assign fsm__slv__sync_reset = mst__fsm__sync_reset;
assign fsm__mst__rd_data = slv__fsm__ack_vld ? slv__fsm__rd_data : {DATA_WIDTH{1'b0}};
assign fsm__mst__ack_vld = slv__fsm__ack_vld;
assign fsm__slv__req_vld = fsm__slv__req_vld_ff;

// assign fsm_slv output signal, IDLE state: wired to input, other working state to latch
assign fsm__slv__addr = (state == S_IDLE) ? {ADDR_WIDTH{1'b0}} : mst__fsm__addr_ff;
assign fsm__slv__wr_data = (state == S_IDLE) ? {DATA_WIDTH{1'b0}} : mst__fsm__wr_data_ff;
assign fsm__slv__wr_en = (state == S_IDLE) ? 1'b0 : mst__fsm__wr_en_ff;
assign fsm__slv__rd_en = (state == S_IDLE) ? 1'b0 : mst__fsm__rd_en_ff;

endmodule