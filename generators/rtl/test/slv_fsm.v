module slv_fsm
    #(
        parameter   ADDR_WIDTH = 64,
        parameter   DATA_WIDTH = 32,
        parameter   M = 0,
        parameter   N = 1
    )
    (
        clk,
        rstn,
        mst__fsm__req_vld,
        mst__fsm__rd_en,
        mst__fsm__wr_en,
        mst__fsm__addr,
        mst__fsm__wr_data,
        mst__fsm__sync_reset,
        fsm__mst__rd_data,
        fsm__mst__ack_vld,
        //  control signal
        fsm__slv__sync_reset,
        fsm__slv__addr,
        fsm__slv__wr_data,
        fsm__slv__wr_en,
        fsm__slv__rd_en,

        mst__fsm__ack_rdy,
        fsm__slv__ack_rdy,
        fsm__mst__req_rdy,
        slv__fsm__req_rdy,

        fsm__slv__req_vld,

        slv__fsm__rd_data,
        slv__fsm__ack_vld
    );

localparam LP_EXT_NUM = M ? M : 1;
localparam LP_REG_NUM = N ? N : 1;


// state decode
localparam   S_IDLE = 2'd0; // no operation
localparam   S_WAIT_SLV_RDY = 2'd1; // if slave is not ready, S_WAIT_SLV_RDY slave slv__fsm__req_rdy
localparam   S_WAIT_SLV_ACK =  2'd2; // S_WAIT_SLV_RDY slave fsm__mst__ack_vld
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
input mst__fsm__ack_rdy;
input slv__fsm__req_rdy;// LP_EXT_NUM external modules and 1 internal modules slv__fsm__req_rdy = {ext_req_rdy,internal}
output fsm__slv__ack_rdy;
output reg fsm__mst__req_rdy;
output fsm__mst__ack_vld;
output fsm__slv__req_vld;
output [DATA_WIDTH-1:0] fsm__mst__rd_data;

// machine state value
reg [1:0] next_state;
reg [1:0] state;

//define reg for latching output to slave
reg [ADDR_WIDTH-1:0] mst__fsm__addr_ff;
reg [DATA_WIDTH-1:0]mst__fsm__wr_data_ff;
reg mst__fsm__wr_en_ff;
reg mst__fsm__rd_en_ff;
reg fsm__slv__req_vld_ff;
reg fsm__slv__ack_rdy_ff;
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
                                                mst__fsm__req_vld ? (slv__fsm__req_rdy ? (slv__fsm__ack_vld ? S_IDLE : S_WAIT_SLV_ACK) : S_WAIT_SLV_RDY) : S_IDLE);
        end
        S_WAIT_SLV_RDY:begin
            next_state = mst__fsm__sync_reset ? S_IDLE : 
                                                slv__fsm__req_rdy ? slv__fsm__ack_vld ? S_IDLE : S_WAIT_SLV_ACK 
                                                                    : S_WAIT_SLV_RDY;
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
        mst__fsm__wr_en_ff <= (next_state == S_WAIT_SLV_RDY) ? mst__fsm__wr_en : 1'b0;
        mst__fsm__rd_en_ff <= (next_state == S_WAIT_SLV_RDY) ? mst__fsm__rd_en : 1'b0;
    end
end

// for output handshake signal
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        fsm__slv__req_vld_ff <= 0; 
        fsm__mst__req_rdy <= 0;
        fsm__slv__ack_rdy_ff <= 0;
    end
    else begin
        fsm__slv__req_vld_ff <= (next_state == S_WAIT_SLV_RDY) ? 1'b1 : 1'b0;
        fsm__mst__req_rdy <=  (next_state == S_IDLE) ? 1'b1 : 1'b0;
        fsm__slv__ack_rdy_ff <= (next_state == S_WAIT_SLV_ACK) ? 1'b1 : 1'b0;
    end
end

assign fsm__slv__sync_reset = mst__fsm__sync_reset;
assign fsm__mst__rd_data = slv__fsm__ack_vld ? slv__fsm__rd_data : {DATA_WIDTH{1'b0}};
assign fsm__mst__ack_vld = slv__fsm__ack_vld;

// assign fsm_slv output signal, IDLE state: wired to input, other working state to latch
assign fsm__slv__addr = (state == S_IDLE) ? {ADDR_WIDTH{1'b0}} : mst__fsm__addr_ff;
assign fsm__slv__wr_data = (state == S_IDLE) ? {DATA_WIDTH{1'b0}} : mst__fsm__wr_data_ff;
assign fsm__slv__wr_en = (state == S_IDLE) ? 1'b0 : mst__fsm__wr_en_ff;
assign fsm__slv__rd_en = (state == S_IDLE) ? 1'b0 : mst__fsm__rd_en_ff;
// assign handshake output signal
assign fsm__slv__req_vld = fsm__slv__req_vld_ff;
assign fsm__slv__ack_rdy = fsm__slv__ack_rdy_ff;

endmodule