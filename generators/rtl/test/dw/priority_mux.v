module priority_mux (din, sel, dout);

    parameter   WIDTH   = 32;
    parameter   CNT     = 5;

    input   [WIDTH*CNT-1:0] din;
    input   [CNT-1:0]       sel;
    output  [WIDTH-1:0]     dout;

    wire    [CNT-1:0]       sel_oh;

    logic   [CNT-1:0] [WIDTH-1:0]   din_2d;

    genvar c;
    generate
        for (c = 0; c < CNT; c++) begin:convert_2d
            assign din_2d[c] = din[c*WIDTH +: WIDTH];
        end
    endgenerate

    priority_mux_2d #(.CNT (CNT), .WIDTH (WIDTH)) x_priority_mux_2d
    (.din (din_2d), .sel (sel),
     .dout (dout));



endmodule