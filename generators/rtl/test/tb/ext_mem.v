module ext_mem (
    // reg_native if ports
    clk,
    req_vld, req_rdy,
    wr_en, rd_en,
    addr, wr_data, rd_data,
    ack_vld, ack_rdy
);

    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 6;
    parameter MEM_ENTRIES = 1 << ADDR_WIDTH;
    // FIXME: This delay is arbitrary
    parameter DELAY = 0;

    localparam  VALID = 1'b1,
                INVALID = 1'b0;

    input       clk;

    input       req_vld;
    output      req_rdy;

    input       wr_en;
    input       rd_en;

    input [ADDR_WIDTH-1:0]    addr;
    input [DATA_WIDTH-1:0]    wr_data;
    output [DATA_WIDTH-1:0]   rd_data;

    output      ack_vld;
    input       ack_rdy;

    reg req_rdy;
    reg ack_vld;
    reg req_vld_ff;
    reg wr_en_ff;
    reg rd_en_ff;
    reg [ADDR_WIDTH-1:0]  addr_ff;
    reg [DATA_WIDTH-1:0]  wr_data_ff;
    reg [DATA_WIDTH-1:0]  rd_data;
    reg [DATA_WIDTH-1:0]  mem [0:MEM_ENTRIES-1];

    // All inputs are registered
    always @(posedge clk) begin
        req_vld_ff = req_vld;
        wr_en_ff = wr_en;
        rd_en_ff = rd_en;
        addr_ff = addr;
        wr_data_ff = wr_data;
    end

    // Write Operation : wr_en = 1, req_vld = 1
    always @(posedge clk) begin : MEM_WRITE
        if (req_vld_ff && wr_en_ff)
            mem[addr_ff] <= wr_data_ff;
            // $display($time, " Writing %m addr=%h wr_data=%h", addr_ff, wr_data_ff);
    end

    // Read Operation : rd_en = 1, req_vld = 1
    always @(posedge clk) begin : MEM_READ
        if (req_vld_ff && rd_en_ff)
            rd_data <= mem[addr_ff];
            // $display($time, " Reading %m addr=%h rd_data=%h", addr_ff, mem[addr_ff]);
    end

    // Req handshake: req_vld, req_rdy
    always @(posedge clk) begin: REQ
        // assert req_rdy for one cycle
        if (req_vld && ~req_rdy)
            req_rdy = VALID;
        else
            req_rdy = INVALID;
    end

    // Ack handshake: ack_vld, ack_rdy
    always @(posedge clk) begin : ACK
        if (req_vld_ff && (wr_en_ff || rd_en_ff) && ~ack_rdy)
            ack_vld <= VALID;
        else
            ack_vld <= INVALID;
    end
endmodule