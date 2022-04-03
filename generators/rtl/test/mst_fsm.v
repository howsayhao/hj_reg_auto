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
        req_vld,
        rd_en,
        wr_en,
        addr,
        wr_data,
        // for interrupt this signal may be float
        clear,
        // these may be float for no slv_module
        dummy_reg,
        slv_sel,
        rd_data_vld_in,
        ack_vld_in,
        //  control signal
        addr_ff,
        wr_data_ff,
        wr_en_ff,
        rd_en_ff,
        slv_sel_ff,
        dummy_reg_ff,
        global_sync_reset,
        interrput,

        ack_rdy_m,
        ack_rdy_s,
        req_rdy_m,
        req_rdy_s,

        rd_data,
        ack_vld
    );

localparam SLV_NUM = M ? M : 1;


input clk;
input rstn;
input req_vld;
input rd_en;
input wr_en;
input [ADDR_WIDTH-1:0]addr;
input [DATA_WIDTH-1:0]wr_data;
// for interrupt this signal may be float
input clear;
// these may be float for no slv_module
input dummy_reg;
// decode dispatch
input [SLV_NUM-1:0] slv_sel;
input rd_data_vld_in;
input ack_vld_in;
// output control signal
output reg [ADDR_WIDTH-1:0] addr_ff;
output reg [DATA_WIDTH-1:0] wr_data_ff;
output reg wr_en_ff;
output reg rd_en_ff;
output reg [SLV_NUM-1:0] slv_sel_ff;
output reg dummy_reg_ff;
output global_sync_reset;
output reg interrput;
// reg_slv_if handshake
input ack_rdy_m;
output reg ack_rdy_s;
output reg req_rdy_m;
// SLV_NUM external modules
input [SLV_NUM-1:0] req_rdy_s;

output reg [DATA_WIDTH-1:0]rd_data;
output reg ack_vld;

// state decode
localparam   IDLE = 2'd0;
localparam   LOCK = 2'd1;
localparam   WAIT = 2'd2;
localparam   ACK =  2'd3; // wait slave ack_vld
reg state;
reg next_state;


// wait time: TIMECNT * Tclk
reg [16-1:0] cnt;
reg time_out;

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
        IDLE:begin
            next_state = req_vld ? LOCK : IDLE;
        end
        LOCK:begin
            next_state = req_rdy ? ACK : WAIT;
        end
        WAIT:begin
            next_state = req_rdy ? ACK : WAIT;
        end
        ACK:begin
            if(ack_rdy_m & (ack_vld | time_out))begin
                next_state = IDLE;
            end
            else next_state = WAIT;
        end
        default: next_state = IDLE;
    endcase
end

//for IDLE state
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        req_rdy_m <= 0;
        addr_ff <= 0;
        wr_en_ff <= 0;
        rd_en_ff <= 0;
        wr_data_ff <= 0;
        dummy_reg_ff <= 0;
        slv_sel_ff <= 0;
    end
    else begin
        req_rdy_m <=  (next_state == IDLE) ? 1'b1 : 1'b0;
        addr_ff <= (next_state == LOCK) ? addr : addr_ff;
        wr_en_ff <= (next_state == LOCK || next_state == WAIT) ? wr_en : 1'b0;
        rd_en_ff <= (next_state == LOCK || next_state == WAIT) ? rd_en : 1'b0;
        wr_data_ff <= (next_state == LOCK) ? wr_data : wr_data_ff;
        dummy_reg_ff <= (next_state == LOCK) ? dummy_reg : dummy_reg_ff;
        slv_sel_ff <= (next_state == LOCK) ? ext_sel : ext_sel_ff;
    end
end


always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        cnt <= 0;
        time_out <= 1'b0;
    end
    else begin
        cnt <= (next_state == WAIT || next_state == ACK) ? ((cnt == TIMECNT) ? 1'b0 : cnt + 1'b1 ) : 1'b0;
        time_out <= (next_state == WAIT || next_state == ACK) ? ((cnt == TIMECNT) ? 1'b1 : 1'b0 ) : 1'b0;
    end
end

// for time out interrupt and lef_node record
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        interrupt <= 1'b0;
        leaf_node <= 0;
    end
    else begin
        if(time_out)
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

assign global_sync_reset = time_out;

// for output ack_rdy_s , rd_data, ack_vld
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        ack_rdy_s <= 0;
        rd_data <= 0;
    end
    else begin
        ack_rdy_s <= (next_state == ACK) ? 1'b1 : 1'b0;
        rd_data <= (next_state == ACK) ? ( ack_vld_in ? rd_data_vld_in : (time_out ? 32'hdead_beef : rd_data)) : rd_data;
        ack_vld <= (next_state == ACK) ? ack_vld_in | time_out ? 1'b1 : 1'b0;
    end
end

endmodule