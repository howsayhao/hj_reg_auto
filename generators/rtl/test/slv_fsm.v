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
        // these may be float for no internal/external
        dummy_reg,
        reg_sel,
        ext_sel,
        rd_data_vld_in,
        ack_vld_in,
        //  control signal
        global_sync_reset_out,
        addr_ff,
        wr_data_ff,
        wr_en_ff,
        rd_en_ff,
        reg_sel_ff,
        ext_sel_ff,
        dummy_reg_ff,

        ack_rdy_m,
        ack_rdy_s,
        req_rdy_m,
        req_rdy_s,

        rd_data,
        ack_vld
    );

localparam EXT_NUM = M ? M : 1;
localparam REG_NUM = N ? N : 1;


// state decode
localparam   IDLE = 2'd0;
localparam   WAIT = 2'd1;
localparam   ACK = 2'd2;
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
input dummy_reg;
input [REG_NUM-1:0] reg_sel;
input [EXT_NUM-1:0] ext_sel;
input [DATA_WIDTH-1:0] rd_data_vld_in;
input ack_vld_in;
// internal/external reg control signal
output reg global_sync_reset_out;
output reg [ADDR_WIDTH-1:0] addr_ff;
output reg [DATA_WIDTH-1:0] wr_data_ff;
output reg wr_en_ff;
output reg rd_en_ff;
output reg [REG_NUM-1:0] reg_sel_ff;
output reg [EXT_NUM-1:0] ext_sel_ff;
output reg dummy_reg_ff;
// reg_slv_if handshake
input ack_rdy_m;
output reg ack_rdy_s;
output reg req_rdy_m;
// EXT_NUM external modules and 1 internal modules req_rdy_s = {ext_req_rdy,internal}
input [EXT_NUM:0] req_rdy_s;

output reg [DATA_WIDTH-1:0] rd_data;
output reg ack_vld;

// machine state value
reg [1:0] next_state;
reg [1:0] state;

assign req_rdy = |{req_rdy_s & {ext_sel,1'b1}};

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
            if(req_vld & req_rdy) next_state = ACK;
            else if(req_vld) next_state = WAIT;
            else next_state = IDLE;
        end
        WAIT:begin
            if(req_rdy) next_state = ACK;
            else next_state = WAIT;
        end
        ACK:begin
            if(ack_vld & ack_rdy_m | global_sync_reset_in)begin
                next_state = IDLE;
            end
            else next_state = ACK;
        end
        default: next_state = IDLE;
    endcase
end

// state output
// for IDLE state: collect the bus information, execute the write operation
// for IDLE  state: if WR, just back to WACK ,if RD, wait for RACK
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        req_rdy_m <= 0;
        addr_ff <= 0;
        wr_en_ff <= 0;
        rd_en_ff <= 0;
        wr_data_ff <= 0;
        reg_sel_ff <= 0;
        dummy_reg_ff <= 0;
        ext_sel_ff <= 0;
    end
    else begin
        case(state)
            IDLE:begin
                req_rdy_m <= 1'b1;
                addr_ff <= addr;
                wr_en_ff <= wr_en;
                rd_en_ff <= rd_en;
                wr_data_ff <= wr_data;
                reg_sel_ff <= reg_sel;
                dummy_reg_ff <= dummy_reg;
                ext_sel_ff <= ext_sel;
            end
            default:begin
                req_rdy_m <= 0;
                addr_ff <= addr_ff;
                wr_en_ff <= wr_en_ff;
                rd_en_ff <= rd_en_ff;
                wr_data_ff <= wr_data_ff;
                reg_sel_ff <= reg_sel_ff;
                dummy_reg_ff <= dummy_reg_ff;
                ext_sel_ff <= ext_sel_ff;
            end
        endcase
    end
end

// for output DFF
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        rd_data <= 0;
        ack_vld <= 1'b0;
        ack_rdy_s <= 0;
    end
    else begin
        case(next_state)
            ACK:begin
                if(ack_vld_in) begin
                    rd_data <= rd_data_vld_in;
                    ack_vld <= 1;
                end
                ack_rdy_s <= 1;
            end
            default:begin
                rd_data <= rd_data;
                ack_vld <= 1'b0;
                ack_rdy_s <= 0;
            end
        endcase
    end
end

assign global_sync_reset_out = global_sync_reset_in;

endmodule