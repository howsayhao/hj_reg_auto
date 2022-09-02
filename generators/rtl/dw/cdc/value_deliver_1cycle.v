module value_deliver_1cycle (
    scan_enable,
    clk_a, rst_a_n, pulse_in, value_in,
    clk_b, rst_b_n, pulse_out, value_out
);
    parameter               VENDOR = `CELL_WRAPPER_DEFAULT_VENDOR;
    parameter               WIDTH = 8;

    input                   scan_enable;
    input                   clk_a;
    input                   rst_a_n;
    input                   pulse_in;
    input   [WIDTH-1:0]     value_in;
    input                   clk_b;
    input                   rst_b_n;
    output  reg             pulse_out;
    output  reg [WIDTH-1:0] value_out;

    wire                    pulse_out_int;
    reg     [WIDTH-1:0]     value_in_ff;

    pulse_deliver pulse_deliver (
        .scan_enable        (scan_enable),
        .clk_a              (clk_a),
        .rst_a_n            (rst_a_n),
        .pulse_in           (pulse_in),
        .clk_b              (clk_b),
        .rst_b_n            (rst_b_n),
        .pulse_out          (pulse_out_int)
    );

    always @(posedge clk_a or negedge rst_a_n) begin
        if (~rst_a_n) begin
            value_in_ff[WIDTH-1:0] <= {WIDTH{1'b0}};
        end
        else if (pulse_in) begin
            value_in_ff[WIDTH-1:0] <= value_in[WIDTH-1:0];
        end
    end

    always @(posedge clk_b or negedge rst_b_n) begin
        if (~rst_b_n)
            pulse_out <= 1'b0;
        else
            pulse_out <= pulse_out_int;
    end

    always @(posedge clk_b or negedge rst_b_n) begin
        if (~rst_b_n) begin
            value_out[WIDTH-1:0] <= {WIDTH{1'b0}};
        end
        else if (pulse_out_int) begin
            value_out[WIDTH-1:0] <= value_in_ff[WIDTH-1:0];
        end
        else begin
            value_out[WIDTH-1:0] <= {WIDTH{1'b0}};
        end
    end
endmodule