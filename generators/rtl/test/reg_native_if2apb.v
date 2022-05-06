module reg_native_if2apb(
    clk,
    rstn,
    req_vld,
    ack_vld,
    wr_en,
    rd_en,
    addr,
    wr_data,
    rd_data,
    PSEL,
    PENABLE,
    PREADY,
    PWRITE,
    PADDR,
    PWDATA,
    PRDATA
)

input   clk         ;
input   rstn        ;
input   req_vld     ;
output  ack_vld     ;
input   wr_en       ;
input   rd_en       ;
input   addr        ;
input   wr_data     ;
input   rd_data     ;
output  PSEL        ;
output  PENABLE     ;
input   PREADY      ;
output  PWRITE      ;
output  PADDR       ;
output  PWDATA      ;
input   PRDATA      ;

wire transfer = req_vld;

// state decode
localparam   S_IDLE = 2'd0;
localparam   S_SETUP = 2'd1;
localparam   S_ACCESS =  2'd2; // return result to APB bus

reg [1:0] state;
reg [1:0] next_state;

always_ff@(posedge PCLK or negedge PRESETn)begin
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
        S_IDLE:begin
            if(transfer)
             next_state = S_SETUP;
        end
        S_SETUP:begin
            next_state = S_ACCESS;
        end
        S_ACCESS:begin
            if(PREADY)
             next_state = S_SETUP;
        end
        default: next_state = S_SETUP;
    endcase
end

assign PSEL = (state == S_IDLE) ? 1'b0 : 1'b1;
assign PENABLE = (state == S_ACCESS) ? 1'b1 : 1'b0;
assign PWRITE = wr_en;
assign PADDR = addr;
assign PWDATA = wr_data;
assign rd_data = PRDATA;
assign ack_vld = PREADY;