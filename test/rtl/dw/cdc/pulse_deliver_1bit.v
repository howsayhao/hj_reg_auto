module pulse_deliver_1bit
    (scan_enable,
     clk_a, rst_a_n, pulse_in,
     clk_b, rst_b_n, pulse_out);

    parameter TRACK = 9;

    input   scan_enable;
    input   clk_a, rst_a_n, pulse_in;
    input   clk_b, rst_b_n;
    output reg  pulse_out;

    wire    deliver_in_idle,
            posedge_detected, negedge_detected;
    wire    a_to_b_sync, b_to_a_sync;
    reg     a_to_b, a_to_b_ff,
            b_to_a, b_to_a_ff;

    reg pulse_in_ff;

    // Domain A
    always @(posedge clk_a or negedge rst_a_n)
        if (!rst_a_n)
            pulse_in_ff <= 1'b0;
        else
            pulse_in_ff <= pulse_in;

    assign deliver_in_idle = (~a_to_b_ff) & (~b_to_a_sync);
    always @(*)
        if (deliver_in_idle && pulse_in_ff)
            // pulse_in is ignored when deliver in progress
            a_to_b = 1'b1;
        else if (a_to_b_ff && b_to_a_sync)
            a_to_b = 1'b0;
        else
            a_to_b = a_to_b_ff;

    always @(posedge clk_a or negedge rst_a_n)
        if (!rst_a_n)
            a_to_b_ff <= 1'b0;
        else
            a_to_b_ff <= a_to_b;

    cdc_synczr_rst_1bit #(.TRACK (TRACK)) b2a
        (.clk (clk_a), .async_rst_n (rst_a_n), .scan_enable (scan_enable),
         .sync_in (b_to_a_ff), .sync_out (b_to_a_sync));



    // Domain B
    assign posedge_detected = (a_to_b_sync ^ b_to_a_ff) & a_to_b_sync;
    assign negedge_detected = (a_to_b_sync ^ b_to_a_ff) & (~a_to_b_sync);
    always @(*)
        if (posedge_detected)
            b_to_a = 1'b1;
        else if (negedge_detected)
            b_to_a = 1'b0;
        else
            b_to_a = b_to_a_ff;

    always @(posedge clk_b or negedge rst_b_n)
        if (!rst_b_n)
            b_to_a_ff <= 1'b0;
        else
            b_to_a_ff <= b_to_a;

    cdc_synczr_rst_1bit #(.TRACK (TRACK)) a2b
        (.clk (clk_b), .async_rst_n (rst_b_n), .scan_enable (scan_enable),
         .sync_in (a_to_b_ff), .sync_out (a_to_b_sync));

    always @(posedge clk_b or negedge rst_b_n)
        if (!rst_b_n)
            pulse_out <= 1'b0;
        else
            pulse_out <= posedge_detected;


endmodule