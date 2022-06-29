module split_mux_2d (clk, rst_n,
                     din, sel,
                     dout, dout_vld);

    parameter WIDTH         = 32;
    parameter CNT           = 31;
    parameter GROUP_SIZE    = 128;
    parameter SKIP_DFF_0    = 0;
    parameter SKIP_DFF_1    = 0;

    input   clk, rst_n;

    input   [CNT-1:0] [WIDTH-1:0]   din;
    input   [CNT-1:0]   sel;
    output  [WIDTH-1:0] dout;
    output  dout_vld;

    reg     [WIDTH*CNT-1:0] din_1d;
    always @(*) begin
        integer i;
        for (i = 0; i < CNT; i = i + 1)
            din_1d[i*WIDTH +: WIDTH] = din[i];
    end

    split_mux #(.WIDTH (WIDTH), .CNT (CNT), .GROUP_SIZE (GROUP_SIZE),
                .SKIP_DFF_0(SKIP_DFF_0),.SKIP_DFF_1(SKIP_DFF_1))
    x_split_mux
        (.clk (clk), .rst_n (rst_n),
         .din (din_1d), .sel (sel),
         .dout (dout), .dout_vld (dout_vld)
         );

endmodule // split_mux_2d