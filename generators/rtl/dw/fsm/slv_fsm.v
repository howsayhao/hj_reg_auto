module slv_fsm
(
    clk,
    rst_n,
    if_soft_rst,
    if_req_vld,
    if_ack_vld,
    if_rd_data,
    if_err,
    if_wr_en,
    if_rd_en,
    dummy_acc,
    reg_acc,
    reg_rd_data,
    reg_rd_data_vld
);
    parameter   DATA_WIDTH              = 32;

    localparam  S_IDLE                  = 3'd0;
    localparam  S_DUMMY_ACK             = 3'd1;
    localparam  S_REG_WRITE_ACK         = 3'd2;
    localparam  S_REG_READ_ACK          = 3'd3;
    localparam  S_WRITE_ACCESS          = 3'd4;
    localparam  S_READ_ACCESS           = 3'd5;

    input   logic                       clk;
    input   logic                       rst_n;
    input   logic                       if_soft_rst;
    input   logic                       if_req_vld;
    output  logic                       if_ack_vld;
    output  logic   [DATA_WIDTH-1:0]    if_rd_data;
    output  logic                       if_err;
    input   logic                       if_wr_en;
    input   logic                       if_rd_en;
    input   logic                       dummy_acc;
    input   logic                       reg_acc;
    input   logic   [DATA_WIDTH-1:0]    reg_rd_data;
    input   logic                       reg_rd_data_vld;

    logic   [2:0]                       state;
    logic   [2:0]                       next_state;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state   <= S_IDLE;
        else if (if_soft_rst)
            state   <= S_IDLE;
        else
            state   <= next_state;
    end

    always_comb begin
        if (if_soft_rst)
            next_state = S_IDLE;
        else
            case (state)
                S_IDLE: begin
                    if (if_req_vld)
                        if (if_wr_en)
                            if (dummy_acc)
                                next_state = S_DUMMY_ACK;
                            else if (reg_acc)
                                next_state = S_REG_WRITE_ACK;
                            else
                                next_state = S_WRITE_ACCESS;
                        else if (if_rd_en)
                            if (dummy_acc)
                                next_state = S_DUMMY_ACK;
                            else if (reg_rd_data_vld)
                                next_state = S_REG_READ_ACK;
                            else
                                next_state = S_READ_ACCESS;
                        else
                            next_state = S_IDLE;
                    else
                        next_state = S_IDLE;
                end
                S_DUMMY_ACK: next_state = S_IDLE;
                S_REG_WRITE_ACK: next_state = S_IDLE;
                S_REG_READ_ACK: next_state = S_IDLE;
                S_WRITE_ACCESS: begin
                    if (dummy_acc | reg_acc)
                        next_state = S_IDLE;
                    else
                        next_state = S_WRITE_ACCESS;
                end
                S_READ_ACCESS: begin
                    if (dummy_acc | reg_rd_data_vld)
                        next_state = S_IDLE;
                    else
                        next_state = S_READ_ACCESS;
                end
                default: next_state = S_IDLE;
            endcase
    end

    always_comb begin
        if_ack_vld  = 1'b0;
        if_rd_data  = {DATA_WIDTH{1'b0}};
        if_err      = 1'b0;

        case (state)
            S_DUMMY_ACK: begin
                if_ack_vld  = 1'b1;
                if_err  = 1'b1;
            end
            S_REG_WRITE_ACK: begin
                if_ack_vld  = 1'b1;
            end
            S_REG_READ_ACK: begin
                if_ack_vld  = 1'b1;
                if_rd_data  = reg_rd_data;
            end
            S_WRITE_ACCESS: begin
                if (dummy_acc) begin
                    if_ack_vld  = 1'b1;
                    if_err  = 1'b1;
                end
                else if (reg_acc)
                    if_ack_vld  = 1'b1;
            end
            S_READ_ACCESS: begin
                if (dummy_acc) begin
                    if_ack_vld  = 1'b1;
                    if_err  = 1'b1;
                end
                else if (reg_rd_data_vld) begin
                    if_ack_vld  = 1'b1;
                    if_rd_data  = reg_rd_data;
                end
            end
            default: begin
                if_ack_vld  = 1'b0;
                if_rd_data  = {DATA_WIDTH{1'b0}};
                if_err      = 1'b0;
            end
        endcase
    end
endmodule