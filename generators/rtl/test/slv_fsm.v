module slv_fsm
    #(
        parameter   ADDR_WIDTH = 64,
        parameter   DATA_WIDTH = 32,
        parameter   M = 0,
        parameter   N = 1
    )
    (
        clk, rst_n,
        // global synchronous reset
        glb_srst_up, glb_srst_down,
        // req and ack handshake of reg_native_if between upstream and current regslv module
        req_vld_up, req_rdy_up, ack_vld_up, ack_rdy_up,
        // control signals and info of reg_native_if between upstream and current regslv module
        rd_en_up, wr_en_up, addr_up, wr_data_up, rd_data_up,
        // req and ack handshake of reg_native_if between current regslv and downstream modules
        req_vld_down, req_rdy_down, ack_vld_down, ack_rdy_down,
        // control signals and info of reg_native_if between current regslv and downstream modules
        rd_en_down, wr_en_down, addr_down, wr_data_down, rd_data_down
    );

localparam EXT_NUM = M ? M : 1;
localparam REG_NUM = N ? N : 1;

localparam  IDLE = 2'b00, // no operation
            LOCK = 2'b01, // get req_vld_up from master, lock the input signal
            WAIT = 2'b10, // if slave is not ready, wait slave req_rdy_down
            ACK =  2'b11; // wait slave ack_vld_up

input logic clk;
input logic rst_n;

input logic glb_srst_up;
output logic glb_srst_down;

input logic req_vld_up;
output logic req_rdy_up;
output logic ack_vld_up;
input logic ack_rdy_up;

input logic rd_en_up;
input logic wr_en_up;
input logic [ADDR_WIDTH-1:0] addr_up;
output logic [DATA_WIDTH-1:0] rd_data_up;
input logic [DATA_WIDTH-1:0] wr_data_up;

output logic req_vld_down;
input logic req_rdy_down;
input logic ack_vld_down;
output logic ack_rdy_down;

output logic rd_en_down;
output logic wr_en_down;
output logic [ADDR_WIDTH-1:0] addr_down;
input logic [DATA_WIDTH-1:0] rd_data_down;
output logic [DATA_WIDTH-1:0] wr_data_down;

logic [1:0] state;
logic [1:0] next_state;

// state register
always_ff @(posedge clk or negedge rst_n) begin
    if(~rst_n || glb_srst_up)
        state <= IDLE;
    else
        state <= next_state;
end

// state transition logic
always_comb begin
    case(state)
        IDLE:begin
            next_state = req_vld_up ? LOCK : IDLE;
        end
        LOCK:begin
            next_state = ack_vld_up ? IDLE : (req_rdy_down ? ACK : WAIT);
        end
        WAIT:begin
            next_state = req_rdy_down ? ACK : WAIT;
        end
        ACK:begin
            next_state = ack_vld_up ? IDLE : ACK;
        end
        default: next_state = IDLE;
    endcase
end

// output logic
always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        wr_data_down <= 0;
    else
        wr_data_down <= (next_state == LOCK) ? wr_data_up : wr_data_down;
end

assign req_rdy_up = (state == IDLE);
assign req_vld_down = (state == LOCK || state == WAIT);
assign wr_en_down = (state == LOCK || state == WAIT) ? wr_en_up : 1'b0;
assign rd_en_down = (state == LOCK || state == WAIT) ? rd_en_up : 1'b0;

assign ack_rdy_down = (state == ACK);
assign glb_srst_down = glb_srst_up;
assign rd_data_up = ack_vld_down ? rd_data_down : rd_data_up; // ???
assign ack_vld_up = ack_vld_down;
assign addr_down = addr_up;

endmodule