module mst_fsm (
    pclk, presetn,
    // APB interface
    psel, penable, pready, pslverr, paddr, pwrite, pwdata, prdata,
    // reg_native_if
    fsm_req_vld, fsm_ack_vld, fsm_addr, fsm_wr_en, fsm_rd_en, fsm_wr_data, fsm_rd_data,
    // timer
    tmr_tmout, tmr_rst,
    // dummy reg access assertion
    err_acc_dummy
);

    parameter       ADDR_WIDTH          = 64;
    parameter       DATA_WIDTH          = 32;
    localparam      S_IDLE              = 2'd0,
                    S_WAIT              = 2'd1,
                    S_ACK               = 2'd2;

    input   logic                       pclk;
    input   logic                       presetn;
    input   logic                       psel;
    input   logic                       penable;
    output  logic                       pready;
    output  logic                       pslverr;
    input   logic   [ADDR_WIDTH-1:0]    paddr;
    input   logic                       pwrite;
    input   logic   [DATA_WIDTH-1:0]    pwdata;
    output  logic   [DATA_WIDTH-1:0]    prdata;

    output  logic                       fsm_req_vld;
    input   logic                       fsm_ack_vld;
    output  logic   [ADDR_WIDTH-1:0]    fsm_addr;
    output  logic                       fsm_wr_en;
    output  logic                       fsm_rd_en;
    output  logic   [DATA_WIDTH-1:0]    fsm_wr_data;
    input   logic   [DATA_WIDTH-1:0]    fsm_rd_data;

    input   logic                       tmr_tmout;
    output  logic                       tmr_rst;
    input   logic                       err_acc_dummy;

    logic           [DATA_WIDTH-1:0]    fsm_rd_data_ff;
    logic   [1:0]   state;
    logic   [1:0]   next_state;

    // state register
    always_ff @(posedge pclk or negedge presetn) begin
        if (!presetn) begin
            state <= S_IDLE;
        end else begin
            state <= next_state;
        end
    end

    // state transfer
    always_comb begin
        case(state)
            S_IDLE: begin
                if (psel & ~penable)
                    if (fsm_ack_vld)
                        next_state = S_ACK;
                    else
                        next_state = S_WAIT;
                else
                    next_state = S_IDLE;
            end
            S_WAIT: begin
                if (fsm_ack_vld | tmr_tmout)
                    next_state = S_IDLE;
                else
                    next_state = S_WAIT;
            end
            S_ACK: begin
                next_state = S_IDLE;
            end
            default: next_state = S_IDLE;
        endcase
    end

    // output
    // all forwarding reg_native_if signals are pulse
    assign  fsm_req_vld     = psel & ~penable;
    assign  fsm_wr_en       = psel & ~penable & pwrite;
    assign  fsm_rd_en       = psel & ~penable & ~pwrite;
    assign  fsm_addr        = (psel & ~penable) ? paddr : {ADDR_WIDTH{1'b0}};
    assign  fsm_wr_data     = (psel & ~penable) ? pwdata : {DATA_WIDTH{1'b0}};

    always_ff @(posedge pclk or negedge presetn) begin
        if (!presetn)
            fsm_rd_data_ff  <= {DATA_WIDTH{1'b0}};
        else
            fsm_rd_data_ff  <= fsm_rd_data;
    end

    always_comb begin
        prdata = {DATA_WIDTH{1'b0}};

        if (state == S_WAIT)
            if (tmr_tmout)
                prdata = 32'hdead_1eaf;
            else if (fsm_ack_vld)
                prdata = fsm_rd_data;
        else if (state == S_ACK)
                prdata = fsm_rd_data_ff;
    end

    assign  pready          = (state == S_ACK) || ((state == S_WAIT) && (next_state == S_IDLE));
    assign  pslverr         = tmr_tmout | err_acc_dummy;
    assign  tmr_rst         = (next_state == S_IDLE);
endmodule