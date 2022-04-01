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
        req_vld,
        rd_en,
        wr_en,
        addr,
        wr_data,
        global_sync_reset_in,
        rd_data_vld_in,
        ack_vld_in,
        //  control signal
        global_sync_reset_out,
        addr_decode,
        wr_data_ff,
        wr_en_ff,
        rd_en_ff,

        ack_rdy_m,
        ack_rdy_s,
        req_rdy_m,
        req_rdy_s,

        req_vld_s,

        rd_data,
        ack_vld
    );

localparam EXT_NUM = M ? M : 1;
localparam REG_NUM = N ? N : 1;


// state decode
localparam   IDLE = 2'd0; // no operation
localparam   LOCK = 2'd1; // get req_vld from master, lock the input signal
localparam   WAIT = 2'd2; // if slave is not ready, wait slave req_rdy_s
localparam   ACK =  2'd3; // wait slave ack_vld
//reg_slv_if in
input clk;
input rstn;
input req_vld;
input rd_en;
input wr_en;
input [ADDR_WIDTH-1:0] addr;
input [DATA_WIDTH-1:0] wr_data;
// decoder in
input global_sync_reset_in;
input [DATA_WIDTH-1:0] rd_data_vld_in;
input ack_vld_in;
// internal/external reg control signal
output reg global_sync_reset_out;
output [ADDR_WIDTH-1:0] addr_decode;
output reg [DATA_WIDTH-1:0] wr_data_ff;
output reg wr_en_ff;
output reg rd_en_ff;
// reg_slv_if handshake
input ack_rdy_m;
output reg ack_rdy_s;
output reg req_rdy_m;
// EXT_NUM external modules and 1 internal modules req_rdy_s = {ext_req_rdy,internal}
input req_rdy_s;

output [DATA_WIDTH-1:0] rd_data;
output ack_vld;
output reg req_vld_s;

// machine state value
reg [1:0] next_state;
reg [1:0] state;

//
reg [ADDR_WIDTH-1:0] addr_ff;

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
        IDLE:begin
            next_state = req_vld ? LOCK : IDLE;
        end
        LOCK:begin
            next_state = ack_vld ? IDLE :(req_rdy_s ? ACK : WAIT);
        end
        WAIT:begin
            next_state = req_rdy_s ? ACK : WAIT;
        end
        ACK:begin
            next_state = (ack_vld | global_sync_reset_in) ? IDLE : ACK;
        end
        default: next_state = IDLE;
    endcase
end

always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        req_vld_s <= 0;
        req_rdy_m <= 0;
        addr_ff <= 0;
        wr_en_ff <= 0;
        rd_en_ff <= 0;
        wr_data_ff <= 0;
    end
    else begin
        req_rdy_m <=  (next_state == IDLE) ? 1'b1 : 1'b0;
        addr_ff <= (next_state == LOCK) ? addr : addr_ff;
        req_vld_s <= (next_state == LOCK || next_state == WAIT) ? 1'b1 : 1'b0;
        wr_en_ff <= (next_state == LOCK || next_state == WAIT) ? wr_en : 1'b0;
        rd_en_ff <= (next_state == LOCK || next_state == WAIT) ? rd_en : 1'b0;
        wr_data_ff <= (next_state == LOCK) ? wr_data : wr_data_ff;
    end
end

// for output DFF
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        ack_rdy_s <= 0;
    end
    else begin
        ack_rdy_s <= (next_state == ACK) ? 1'b1 : 1'b0;
    end
end

assign global_sync_reset_out = global_sync_reset_in;
assign rd_data = ack_vld_in ? rd_data_vld_in : rd_data;
assign ack_vld = ack_vld_in ? 1'b1 : 1'b0;

assign addr_decode = (state == IDLE) ? addr : addr_ff;

endmodule