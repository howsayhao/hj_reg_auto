module one_hot_mux_ff(clk, rst_n,
    din, sel, sel_ff, dout_ff);
    parameter WIDTH     = 32;
    parameter CNT       = 5;
    parameter SKIP_DFF  = 0;

    input   logic   [WIDTH*CNT-1:0] din;
    input   logic   [CNT-1:0]       sel;
    input   logic   clk, rst_n;
    output  logic   sel_ff;
    output  logic   [WIDTH-1:0] dout_ff;

    logic [WIDTH-1:0] dout;

    generate
        if (SKIP_DFF) begin:wo_dff
            assign sel_ff = |sel;
            assign dout_ff = dout;
        end
        else begin:with_dff
            always @(posedge clk or negedge rst_n)
                if (!rst_n) begin
                    sel_ff <= 1'b0;
                    dout_ff <= {WIDTH{1'b0}};
                end
                else begin
                    sel_ff  <= |sel;
                    dout_ff <= dout;
                end
            end // block: with_dff
    endgenerate

    one_hot_mux #(.WIDTH (WIDTH), .CNT (CNT), .ONE_HOT_CHECK (0))
    one_hot_mux (.din (din),
                 .sel (sel),
                 .dout (dout),
                 .err ());
endmodule