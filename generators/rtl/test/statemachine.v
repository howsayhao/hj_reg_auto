// machine state decode
PARAMETER   IDLE = 3'd0;
PARAMETER   ACK = 3'd1;
PARAMETER   EXTERN_ACK = 3'd2;

// machine state value
reg [2:0] next_state;
reg [2:0] state;

// state transfer
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        state <= 3'b0;
    end
    else begin
        state <= next_state;
    end
end

// state transfer flow
wire reg_ack_vld;
wire reg_timeout;
wire ext_ack_vld;
wire ext_timeout;
always_comb begin
    case(state)
        IDLE:begin
            if(req_vld && ~external && rd_en) next_state = ACK;
            else if(req_vld && external && rd_en) next_state = EXT_ACK;
            else next_state = IDLE;
        end
        ACK:begin
            if(ack_vld_t || reg_timeout)begin
                next_state = IDLE;
            end
            else next_state = ACK;
        end
        EXT_ACK:begin
            if(ack_vld_t || ext_timeout)begin
                next_state = IDLE;
            end
            else next_state = EXT_ACK;
        end
        default: next_state = IDLE;
    endcase
end



// state output

// for IDLE state: collect the bus information, execute the write operation
// for IDLE  state: if WR, just back to IDLE ,if RD, just wait for ack
reg [ADDR_WIDTH-1:0]addr_ff;
reg [DATA_WIDTH-1:0]wr_data_ff;
reg wr_en_ff;
reg rd_en_ff;
reg [N-1:0] reg_sel_ff;
reg [M-1:0] ext_sel_ff
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        addr_ff <= 0;
        wr_en_ff <= 0;
        rd_en_ff <= 0;
        wr_data_ff <= 0;
        reg_sel_ff <= 0;
        ext_sel_ff <= 0;
    end
    else begin
        case(next_state)
            IDLE:begin
                addr_ff <= addr;
                wr_en_ff <= wr_en;
                rd_en_ff <= rd_en;
                wr_data_ff <= wr_data;
                reg_sel_ff <= reg_sel;
                ext_sel_ff <= ext_sel;
            end
            default:begin
                addr_ff <= addr_ff;
                wr_en_ff <= wr_en_ff;
                rd_en_ff <= rd_en_ff;
                wr_data_ff <= wr_data_ff;
                reg_sel_ff <= reg_sel_ff;
                ext_sel_ff <= ext_sel_ff;
            end
        endcase
    end
end

// for ACK state
// INTERN REG READ time_out detecter
reg reg_timeout;
reg [2:0] reg_time_cnt;
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        reg_timeout <= 1'b0;
        reg_time_cnt <= 3'b0;
    end
    else begin
        if(next_state == ACK)begin
            if(reg_time_cnt == 3'b111)begin
                reg_timeout <= 1'b1;
                reg_time_cnt <= 3'b0;
            end
            else begin
                reg_timeout <= 1'b0;
                reg_time_cnt <= reg_time_cnt + 1'b1;
            end
        end
        else begin
            reg_timeout <= 1'b0;
            reg_time_cnt <= 3'b0;
        end
    end
end

// for EXTERNAL_ACK state
// EXT MODULE READ time_out detecter
reg ext_timeout;
reg [2:0] mem_time_cnt;
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        ext_timeout <= 1'b0;
        mem_time_cnt <= 3'b0;
    end
    else begin
        if(next_state == ACK)begin
            if(mem_time_cnt == 3'b111)begin
                ext_timeout <= 1'b1;
                mem_time_cnt <= 3'b0;
            end
            else begin
                ext_timeout <= 1'b0;
                mem_time_cnt <= mem_time_cnt + 1'b1;
            end
        end
        else begin
            ext_timeout <= 1'b0;
            mem_time_cnt <= 3'b0;
        end
    end
end

// for output select

// for normal register
wire [DATA_WIDTH-1:0] reg_rd_data;
wire reg_ack_vld;

// for external module
wire [DATA_WIDTH-1:0] ext_rd_data_vld;
wire ext_ack_vld;

wire [DATA_WIDTH-1:0] rd_data_t;
wire ack_vld_t;
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        rd_data_t <= 0;
        ack_vld_t <= 1'b0;
    end
    else begin
        case(next_state)
            ACK:begin
                rd_data_t <= reg_ack_vld ? reg_rd_data_vld : 0;
                ack_vld_t <= reg_ack_vld ? 1 : 0;
            end
            EXTERN_ACK:begin
                rd_data_t <= ext_ack_vld ? ext_rd_data_vld : 0;
                ack_vld_t <= ext_ack_vld ? 1 : 0;
            end
            default:begin
                rd_data_t <= rd_data_t;
                ack_vld_t <= 1'b0;
            end
    end
end