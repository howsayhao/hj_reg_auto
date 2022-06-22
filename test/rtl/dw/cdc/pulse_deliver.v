module pulse_deliver
    (scan_enable,
     clk_a, rst_a_n, pulse_in,
     clk_b, rst_b_n, pulse_out);

    parameter WIDTH = 1;
    parameter TRACK = 9;

    input scan_enable;
    input clk_a, rst_a_n;
    input [WIDTH-1:0] pulse_in;
    input clk_b, rst_b_n;
    output reg [WIDTH-1:0] pulse_out;

    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin:inst
            pulse_deliver_1bit #(.TRACK (TRACK)) pulse_deliver_1bit
            (.scan_enable (scan_enable),
             .clk_a (clk_a), .rst_a_n (rst_a_n), .pulse_in (pulse_in[i]),
             .clk_b (clk_b), .rst_b_n (rst_b_n), .pulse_out (pulse_out[i]));
        end
    endgenerate

endmodule