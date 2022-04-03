module slv_fsm
    #(
        parameter   ADDR_WIDTH = 64,
        parameter   DATA_WIDTH = 32,
        parameter   M = 0,
        parameter   N = 1
    )
    (
        clk, rst_n,
        req_vld_m, req_rdy_m, ack_vld_m, ack_rdy_m,
        req_vld_s, req_rdy_s, ack_vld_s, ack_rdy_s,

        rd_en, wr_en, addr, wr_data, rd_data,
        g_srst_up, g_srst_down,
        rd_data_vld_in,
        addr_decode,
        wr_data_ff,
        wr_en_ff,
        rd_en_ff
    );

localparam EXT_NUM = M ? M : 1;
localparam REG_NUM = N ? N : 1;


// state decode
localparam   IDLE = 2'd0; // no operation
localparam   LOCK = 2'd1; // get req_vld_m from master, lock the input signal
localparam   WAIT = 2'd2; // if slave is not ready, wait slave req_rdy_s
localparam   ACK =  2'd3; // wait slave ack_vld_m
//reg_slv_if in
input clk;
input rst_n;
input req_vld_m;
input rd_en;
input wr_en;
input [ADDR_WIDTH-1:0] addr;
input [DATA_WIDTH-1:0] wr_data;
// decoder in
input g_srst_up;
input [DATA_WIDTH-1:0] rd_data_vld_in;
input ack_vld_s;
// internal/external reg control signal
output reg g_srst_down;
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
output ack_vld_m;
output reg req_vld_s;

// machine state value
reg [1:0] next_state;
reg [1:0] state;

//
reg [ADDR_WIDTH-1:0] addr_ff;

// state register
always_ff@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        state <= 2'b0;
    end
    else begin
        state <= next_state;
    end
end

// state transfer logic
always_comb begin
    case(state)
        IDLE:begin
            next_state = req_vld_m ? LOCK : IDLE;
        end
        LOCK:begin
            next_state = ack_vld_m ? IDLE :(req_rdy_s ? ACK : WAIT);
        end
        WAIT:begin
            next_state = req_rdy_s ? ACK : WAIT;
        end
        ACK:begin
            next_state = (ack_vld_m | g_srst_up) ? IDLE : ACK;
        end
        default: next_state = IDLE;
    endcase
end

// output logic
always_ff@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
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

assign ack_rdy_s = (state == ACK);
assign g_srst_down = g_srst_up;
assign rd_data = ack_vld_s ? rd_data_vld_in : rd_data; // ???
assign ack_vld_m = ack_vld_s;
assign addr_decode = (state == IDLE) ? addr : addr_ff;

endmodule