//  a registerfile module template which could contain 
//  registers (registerfiles are splited into registers) and memories
module template_slv(
    // reg_native_if
    input clk,
    input rstn,
    input req_vld,
    input wr_en,rd_en,
    input [ADDR_WIDTH-1:0] addr, //offset in the module
    input [DATA_WIDTH-1:0] wr_data,
    output ack_vld,
    output [DATA_WIDTH-1:0] rd_data,

    // for external memory interface
    input ext_mem_rd_data,
    input ext_mem_ack,
    output ext_mem_addr,
    output ext_mem_sel_ff,
    output ext_mem_wr_ff,
    output ext_mem_wr_data

    //for access forward interface
    input ack_vld_fwd,
    input [DATA_WIDTH-1:0]rd_data_fwd,
    output req_vld_fwd,
    output wr_en_fwd,rd_en_fwd,
    output addr_fwd,
    output wr_data_fwd

);

PARAMETER ADDR_WIDTH = 64;
PARAMETER DATA_WIDTH = 32;

PARAMETER N = 0
PARAMETER M = 0

// access forward interface map which is declared in the top
/* these may be modified later  */
assign req_vld_fwd = req_vld;
assign wr_en_fwd = wr_en;
assign rd_en_fwd = rd_en;
assign addr_fwd = addr;
assign wr_data_fwd = wr_data;

// decoder
// NUM_OF_REG = number of registers = N
wire [N-1:0] reg_sel;
reg [N-1:0] reg_sel_ff;

wire dummy_reg;
reg dummy_reg_ff;

// NUM_OF_MEM = number of memories = M
wire [M-1:0] ext_mem_sel;
reg [M-1:0] ext_mem_sel_ff;

// NUM_OF_EXT_REG = number of external registers = O

// combination logic for the decoder
// addr are splited into normal regs and memories
always_comb begin
    unique case (addr_ff)
        reg_sel = {N{1'b0}};
        ext_mem_sel = {M{1'b0}};
        dummy_reg = 1'b0;
        `REG_ADDR_0: reg_sel[0] = 1'b1;// shared register shared1_A
        `REG_ADDR_1: reg_sel[1] = 1'b1;//normal register normalA
        `REG_ADDR_2: reg_sel[2] = 1'b1;// shared register shared1_B
        `REG_ADDR_3, `REG_ADDR_4: reg_sel[3] = 1'b1;// shared register shared2
        `MEM_REG_ADDR_1, `MEM_REG_ADDR_2, `MEM_REG_ADDR_3, `MEM_REG_ADDR_4: ext_mem_sel[0] = 1'b1;// memory1 which has 4 registers
        `MEM_REG_ADDR_5, `MEM_REG_ADDR_6, `MEM_REG_ADDR_7: ext_mem_sel[1] = 1'b1;// memory2 which has 3 registers
        // other reg_sel[i] assignment
        // ...
        // ...
        default: dummy_reg = 1'b1;
    endcase
end

// flag to mark if select the external memory/register
// if the address matches the memory addr or cannot be decode(forward), the external flag will be asserted
wire external;
// if 1024 mem_addrs the or gate stage will be limited in less than 10 stages
assign external = |ext_mem_sel


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
            else if(req_vld && external && rd_en) next_state = MEM_ACK;
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
reg [ADDR_WIDTH-1:0]addr_ff;
reg [DATA_WIDTH-1:0]wr_data_ff;
reg wr_ff;
reg rd_ff;
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        addr_ff <= 0;
        wr_ff <= 0;
        rd_ff <= 0;
        wr_data_ff <= 0;
    end
    else begin
        case(next_state)
            IDLE:begin
                addr_ff <= addr;
                wr_ff <= wr_en;
                rd_ff <= rd_en;
                wr_data_ff <= wr_data;
            end
            default:begin
                addr_ff <= addr_ff;
                wr_ff <= wr_ff;
                rd_ff <= rd_ff;
                wr_data_ff <= wr_data_ff;
            end
        endcase
    end
end

// for DECODE state: decode the address to judge the registers' existance and type
//this is for storing the input in the DFF
reg [N-1:0] rd_sel_ff;
reg [N-1:0] wr_sel_ff;
reg [N-1:0] reg_sel_ff;
reg [M-1:0] mem_sel_ff;
reg [M-1:0] ext_mem_wr_ff;

always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        rd_sel_ff <= 0;
        wr_sel_ff <= 0;
        ext_mem_wr_ff <= 0;
        reg_sel_ff <= 0;
        mem_sel_ff <= 0;
    end
    else begin
        case(next_state)
            DECODE:begin
                rd_sel_ff <= reg_sel & {N{rd_ff}};
                wr_sel_ff <= reg_sel & {N{wr_ff}};
                ext_mem_wr_ff <= ext_mem_sel & {M{wr_ff}};
                reg_sel_ff <= reg_sel;
                mem_sel_ff <= ext_mem_sel;
            end
            default:begin
                rd_sel_ff <= rd_sel_ff;
                wr_sel_ff <= wr_sel_ff;
                ext_mem_wr_ff <= ext_mem_wr_ff;
                reg_sel_ff <= 0;
                mem_sel_ff <= 0;
            end
        endcase
    end
end

// for INTERN  state: if WR, just back to IDLE ,if RD, just wait for ack
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
            if(time_cnt == 3'b111)begin
                rd_timeout <= 1'b1;
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
// MEM READ time_out detecter
reg ext_timeout;
reg [2:0] mem_time_cnt;
always_ff@(posedge clk or negedge rstn)begin
    if(!rstn)begin
        ext_timeout <= 1'b0;
        mem_time_cnt <= 3'b0;
    end
    else begin
        if(next_state == ACK)begin
            if(time_cnt == 3'b111)begin
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
                rd_data_t <= reg_ack_vld ? reg_rd_data : 0;
                ack_vld_t <= reg_ack_vld ? 1 : 0;
            end
            EXTERN_ACK:begin
                rd_data_t <= ext_ack_vld ? mem_rd_data : 0;
                ack_vld_t <= ext_ack_vld ? 1 : 0;
            end
            default:begin
                rd_data_t <= rd_data_t;
                ack_vld_t <= 1'b0;
            end
    end
end




// instance accessed by slv
// this is for normal register "normalA"
wire [DATA_WIDTH-1:0] normalA;
wire [DATA_WIDTH-1:0] normalA_wr_data;
assign normalA_wr_data = reg_sel_ff[1] && wr_sel_ff[1] && req_vld_ff[1] ? wr_data_ff : 0;
// normalA_field1@(27:16)
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(12),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(12'h4d2),
	.SRST_VALUE(0),
	.USE_EXT_ASYNC_VALUE(0),
	.USE_EXT_SYNC_VALUE(0),
	.SW_TYPE(`RW),
	.HW_TYPE(`WIRED),
	.WR_PRIORITY(`SW)
	)
x__normalA__field1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(normalA_wr_data[27:16]),
	.sw_rd(rd_sel_ff[1]),
	.sw_wr(wr_sel_ff[1]),
	.write_protect_en(),
	.hw_value(normalA__field1__next_value),
	.hw_pulse(normalA__field1__pulse),
	.field_value(normalA__field1__curr_value)
	);
    // end field instantiate

// normalA_field2@(7:0)
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(8),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(8'hd2),
	.SRST_VALUE(0),
	.USE_EXT_ASYNC_VALUE(0),
	.USE_EXT_SYNC_VALUE(0),
	.SW_TYPE(`RW),
	.HW_TYPE(`WIRED),
	.WR_PRIORITY(`SW)
	)
x__normalA__field2
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data(normalA_wr_data[7:0]),
	.sw_rd(rd_sel_ff[1]),
	.sw_wr(wr_sel_ff[1]),
	.write_protect_en(),
	.hw_value(normalA__field2__next_value),
	.hw_pulse(normalA__field2__pulse),
	.field_value(normalA__field2__curr_value)
	);
    // end field instantiate

// allocate the fields output into register
always_comb begin
    normalA[31:0] = 32'd0;
    normalA[27:16] = normalA__field1__curr_value;
    normalA[7:0] = normalA__field2__curr_value;
end
assign reg_rd_data_in[31:0] = normalA;

// shared registers are instantiated as the same above
// shared1_A and shared1_B instantiated only one field
wire [DATA_WIDTH-1:0] shared1_A;
wire [DATA_WIDTH-1:0] shared1_A_wr_data;
assign shared1_A_wr_data = reg_sel_ff[0] && wr_sel_ff[0] && req_vld_ff[0] ? wr_data_ff : 0;

wire [DATA_WIDTH-1:0] shared1_B;
wire [DATA_WIDTH-1:0] shared1_B_wr_data;
assign shared1_B_wr_data = reg_sel_ff[2] && wr_sel_ff[2] && req_vld_ff[2] ? wr_data_ff : 0;

// shared1_A_field1@(31:0)
field
	//**************PARAMETER INSTANTIATE***************//
	#( 
	.F_WDITH(12),
	.SRST_CNT(0),
	.SRST_WIDTH(1),
	.ARST_VALUE(32'h4d2),
	.SRST_VALUE(0),
	.USE_EXT_ASYNC_VALUE(0),
	.USE_EXT_SYNC_VALUE(0),
    .ALIAS_NUM(2),
	.SW_TYPE({`RW,`RO}),
    .SW_ONREAD_TYPE({`RCLR,`NA}),
    .SW_ONWRITE_TYPE({`WOCLR,`NA}),
    .SWMOD({1,0}),
    .SWACC({1,0}),
    .PULSE({1,0}),
	.HW_TYPE({`RW,`RO}),
	.PRECEDENCE(`SW)
	)
x__shared1__field1
	//*****************PORT INSTANTIATE*****************//
	(
	.clk(clk),
	.rst(rst_n),
	.syn_rst(),
	.ext_async_reset_value(),
	.ext_sync_reset_value(),
	.sw_wr_data({shared1_A_wr_data,shared1_B_wr_data}),
	.sw_rd({rd_sel_ff[0],rd_sel_ff[2]}),
	.sw_wr(wr_sel_ff[0],wr_sel_ff[2]}),
	.write_protect_en(),
	.hw_value(shared1_A__field1__next_value),
	.hw_pulse(shared1_A__field1__pulse),
	.field_value(shared1_A__field1__curr_value)
	);
    // end field instantiate


assign reg_rd_data_in[63:32] = shared1;
assign reg_rd_data_in[95:64] = shared2;

// this is for external memory, the number of external memory blocks is M
// the access width of registers in memory is limited in 16 and 32 bits or the power of 16 bits
wire [DATA_WIDTH:1] ext_mem_rd_data[M-1:0];

wire [DATA_WIDTH:1] ext_mem_wr_data = wr_data_ff;
wire [ADDR_WIDTH:1] ext_mem_addr = reg_addr_ff;

wire [M-1] ext_mem_ack;
wire [M-1] mem_ack;
assign mem_ack = ext_mem_ack & mem_sel_ff;
//memory1's corresponding ext block is ext[0] access_width = 16
wire [DATA_WIDTH-1:0] memory1;
always_comb begin
    memory1[31:0] = 32'd0;
    memoriy1[15:0] = ext_mem_rd_data[0]
end
assign mem_rd_data_in[31:0] = memory1;
//memory2's corresponding ext block is ext[1] access_width = 32
wire [DATA_WIDTH-1:0] memory2;
always_comb begin
    memoriy1[31:0] = ext_mem_rd_data[1]
end
assign mem_rd_data_in[63:32] = memory2;
// end external memory interface



// output define
// for normal register
wire [DATA_WIDTH-1:0] reg_rd_data;
wire reg_ack_vld;
split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(N), .GROUP_SIZE(64)) rd_split_mux
   (.clk(clk), .rst_n(rstn),
    .din(reg_rd_data_in), .sel(rd_sel_ff),
    .dout(reg_rd_data), .dout_vld(reg_ack_vld)
    );
// store the mux out

// MEM_ACK state
wire [DATA_WIDTH-1:0] mem_rd_data;
wire ext_ack_vld;
split_mux_2d #(.WIDTH(DATA_WIDTH), .CNT(M), .GROUP_SIZE(64)) mem_rd_split_mux
   (.clk(clk), .rst_n(rstn),
    .din(mem_rd_data_in), .sel(mem_ack),
    .dout(mem_rd_data), .dout_vld(ext_ack_vld)
    );
// store the memory mux out


// select which to read out and pull the corresponding vld signal high
assign rd_data = ack_vld_fwd ? rd_data_fwd : (ack_vld_t ? rd_data_t : rd_data_ff);
assign ack_vld = ack_vld_fwd | ack_vld_t;

endmodule