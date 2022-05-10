module value_transmitter
    (
        clk_a               ,
        rst_a_n             ,
        pulse_in            ,
        value_in            ,
        clk_b               ,
        rst_b_n             ,
        value_out_ack       ,
        pulse_out           ,
        value_out
    );

    parameter WIDTH = 8;

    input                   clk_a                   ;
    input                   rst_a_n                 ;

    input                   pulse_in                ;
    input   [WIDTH-1:0]     value_in                ;

    input                   clk_b                   ;
    input                   rst_b_n                 ;

    // value_out_ack indicates that the siganl can be delatch
    input                   value_out_ack           ;
    output                  pulse_out               ;
    output  [WIDTH-1:0]     value_out               ;

    reg                     pulse_in_ff             ;
    reg     [WIDTH-1:0]     value_in_ff             ;

    reg                     pulse_out_int           ;
    reg     [WIDTH-1:0]     value_out_int           ;
    reg                     pulse_out_ff            ;
    reg     [WIDTH-1:0]     value_out_ff            ;

// domain clk_a
    always_ff@(posedge clk_a or negedge rst_a_n)begin
        if(~rst_a_n)
            pulse_in_ff <=  0;
        else if(pulse_in)
            pulse_in_ff <= 1'b1;
        else
            pulse_in_ff <= 0;
    end

    always_ff@(posedge clk_a or negedge rst_a_n)begin
        if(~rst_a_n)
            value_in_ff <=  0;
        else if(pulse_in)
            value_in_ff <= value_in;
        else
            value_in_ff <= value_in_ff;
    end

// domain clk_b
    always_ff@(posedge clk_b or negedge rst_b_n)begin
        if(~rst_b_n)
            pulse_out_ff <=  0;
        else if(pulse_out_int)
            pulse_out_ff <= 1'b1;
        else
            pulse_out_ff <= 0;
    end

    always_ff@(posedge clk_b or negedge rst_b_n)begin
        if(~rst_b_n)
            value_out_ff <=0;
        else if(pulse_out_int)
            value_out_ff <= value_out_int;
        else if(value_out_ack)
            value_out_ff <= 0;
        else
            value_out_ff <= value_out_ff;
    end

    assign pulse_out = pulse_out_ff;
    assign value_out = value_out_ff;

	value_deliver
		#(.WIDTH(WIDTH))
		value_deliver_ins
		(
        .scan_enable                            (1'b0                           ),
		.clk_a                                  (clk_a                          ),
		.clk_b                                  (clk_b                          ),
		.rst_a_n                                (rst_a_n                        ),
		.rst_b_n                                (rst_b_n                        ),
		.pulse_in                               (pulse_in_ff                    ),
		.value_in                               (value_in_ff                    ),
		.pulse_out                              (pulse_out_int                  ),
		.value_out                              (value_out_int                  )
	);

endmodule