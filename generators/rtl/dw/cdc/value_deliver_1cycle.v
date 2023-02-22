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

    reg     [WIDTH-1:0]     value_in_ff;
    reg                     pulse_in_ff;
    wire                    pulse_int_1;
    reg                     pulse_int_2;
    wire                    pulse_int_3;
    reg                     pulse_int_4;
    wire                    pulse_out_int;

    // deliver pulse: toggle synchronizer
    always @(posedge clk_a or negedge rst_a_n) begin
        if (!rst_a_n)
            pulse_in_ff <= 1'b0;
        else
            pulse_in_ff <= pulse_in;
    end

    assign pulse_int_1 = pulse_int_2 ^ pulse_in_ff;
    always @(posedge clk_a or negedge rst_a_n) begin
        if (!rst_a_n)
            pulse_int_2 <= 1'b0;
        else
            pulse_int_2 <= pulse_int_1;
    end

    cdc_synczr_rst_1bit a2b (
        .clk (clk_b),
        .async_rst_n (rst_b_n),
        .scan_enable (scan_enable),
        .sync_in (pulse_int_2),
        .sync_out (pulse_int_3)
    );

    always @(posedge clk_b or negedge rst_b_n) begin
        if (!rst_b_n)
            pulse_int_4 <= 1'b0;
        else
            pulse_int_4 <= pulse_int_3;
    end
    assign pulse_out_int = pulse_int_4 ^ pulse_int_3;

    // deliver value
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