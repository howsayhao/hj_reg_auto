module slv_fsm
    #(
        parameter   ADDR_WIDTH = 64,
        parameter   DATA_WIDTH = 32
    )
    (
        clk,
        rst_n,
        //  upstream control signal
        mst__fsm__req_vld,
        fsm__mst__ack_vld,
        mst__fsm__addr,
        mst__fsm__wr_en,
        mst__fsm__rd_en,
        fsm__mst__rd_data,
        mst__fsm__wr_data,
        //  downstream control signal
        fsm__slv__req_vld,
        slv__fsm__ack_vld,
        fsm__slv__addr,
        fsm__slv__wr_en,
        fsm__slv__wr_data,
        fsm__slv__rd_en,
        slv__fsm__rd_data,
        //  sync signal
        soft_rst,
        fsm__slv__sync_reset
    );


// state decode
localparam   S_IDLE         =   1'd0; // no operation
localparam   S_WAIT_SLV_ACK =   1'd1; // wait for slave fsm__mst__ack_vld

input                           clk                     ;
input                           rst_n                    ;
// upstream reg_native_if
input                           mst__fsm__req_vld       ;
output                          fsm__mst__ack_vld       ;
input   [ADDR_WIDTH-1:0]        mst__fsm__addr          ;
input                           mst__fsm__wr_en         ;
input                           mst__fsm__rd_en         ;
input   [DATA_WIDTH-1:0]        mst__fsm__wr_data       ;
input   [DATA_WIDTH-1:0]        slv__fsm__rd_data       ;
// downstream reg_native_if
output                          fsm__slv__req_vld       ;
input                           slv__fsm__ack_vld       ;
output  [ADDR_WIDTH-1:0]        fsm__slv__addr          ;
output                          fsm__slv__wr_en         ;
output                          fsm__slv__rd_en         ;
output  [DATA_WIDTH-1:0]        fsm__slv__wr_data       ;
output  [DATA_WIDTH-1:0]        fsm__mst__rd_data       ;

input                           soft_rst                ;
output  reg                     fsm__slv__sync_reset    ;
// machine state value
reg                             next_state              ;
reg                             state                   ;

//define reg for latching output to slave
reg     [ADDR_WIDTH-1:0]        mst__fsm__addr_ff       ;
reg     [DATA_WIDTH-1:0]        mst__fsm__wr_data_ff    ;
reg                             mst__fsm__wr_en_ff      ;
reg                             mst__fsm__rd_en_ff      ;
reg                             fsm__slv__req_vld_ff    ;
// to see if the module selected is accessable

// state transfer
always_ff@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        state <= 1'b0       ;
    end
    else begin
        state <= next_state ;
    end
end

// state transfer flow
always_comb begin
    case(state)
        // if soft_rst, next_state back to IDLE, else check req_vld from the master as well as req_rdy and ack_vld from the slave
        S_IDLE:begin
            next_state = soft_rst ? S_IDLE :
                                                !mst__fsm__req_vld ? S_IDLE :
                                                                     slv__fsm__ack_vld ? S_IDLE : S_WAIT_SLV_ACK    ;
        end
        S_WAIT_SLV_ACK:begin
            next_state = soft_rst ? S_IDLE :
                                                slv__fsm__ack_vld ? S_IDLE : S_WAIT_SLV_ACK                         ;
        end
        default: next_state = S_IDLE                                                                                ;
    endcase
end
// for output control signal latch
always_ff@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        mst__fsm__addr_ff           <= 0;
        mst__fsm__wr_data_ff        <= 0;
        mst__fsm__wr_en_ff          <= 0;
        mst__fsm__rd_en_ff          <= 0;
    end
    else begin
        mst__fsm__addr_ff           <= (state == S_IDLE && next_state != S_IDLE) ? mst__fsm__addr       : mst__fsm__addr_ff ;
        mst__fsm__wr_data_ff        <= (state == S_IDLE && next_state != S_IDLE) ? mst__fsm__wr_data    : fsm__slv__wr_data ;
        // internal operation signal (wr_en/rd_en) only need latch for 1 cycle
        mst__fsm__wr_en_ff          <= (state == S_IDLE && next_state != S_IDLE) ? mst__fsm__wr_en      : 1'b0              ;
        mst__fsm__rd_en_ff          <= (state == S_IDLE && next_state != S_IDLE) ? mst__fsm__rd_en      : 1'b0              ;
    end
end

// for output handshake signal
always_ff@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        fsm__slv__req_vld_ff <= 0;
    end
    else begin
        if(state == S_IDLE && next_state == S_WAIT_SLV_ACK) fsm__slv__req_vld_ff <= 1'b1;
        else fsm__slv__req_vld_ff <= 1'b0;
    end
end

always_ff@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        fsm__slv__sync_reset <= 1'b0;
    end
    else begin
        fsm__slv__sync_reset <= soft_rst;
    end
end

assign fsm__slv__req_vld = fsm__slv__req_vld_ff;
assign fsm__mst__ack_vld = slv__fsm__ack_vld;
// assign fsm_slv output signal, IDLE state: wired to input, other working state to latch
assign fsm__slv__addr       = (state == S_IDLE) ? {ADDR_WIDTH{1'b0}} : mst__fsm__addr_ff;
assign fsm__slv__wr_en      = (state == S_IDLE) ? 1'b0 : mst__fsm__wr_en_ff;
assign fsm__slv__rd_en      = (state == S_IDLE) ? 1'b0 : mst__fsm__rd_en_ff;
assign fsm__slv__wr_data    = (state == S_IDLE) ? {DATA_WIDTH{1'b0}} : mst__fsm__wr_data_ff;
assign fsm__mst__rd_data    = slv__fsm__ack_vld ? slv__fsm__rd_data : {DATA_WIDTH{1'b0}};

endmodule