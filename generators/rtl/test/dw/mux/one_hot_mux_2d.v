module one_hot_mux_2d
    (
        din,
        sel,
        dout,
        err
    );

`include "common_funcs.vh"

    parameter WIDTH = 32;
    parameter CNT = 5;
    parameter ONE_HOT_CHECK = 0;

    parameter FORCE_ENCODE = 0;

    input   [CNT-1:0] [WIDTH-1:0]   din ;
    input   [CNT-1:0]               sel;
    output  [WIDTH-1:0]             dout;
    output  err;

    wire    [CNT-1:0] [WIDTH-1:0]   data_2d ;
    wire    [WIDTH-1:0] [CNT-1:0]   data_2d_t;
    wire    [WIDTH-1:0]             dout;
    wire    err;


    genvar cnt, w;

    generate
        if (FORCE_ENCODE) begin:imp_encode
            localparam SEL_WIDTH = log2(CNT);

            reg [SEL_WIDTH-1:0] sel_en;
            always @(*) begin
                integer i;
                sel_en = {SEL_WIDTH{1'b0}};
                for (i = 0; i < CNT; i = i + 1)
                    if (sel[i]) sel_en = i;
            end

            assign dout = |sel ? din[sel_en] : {WIDTH{1'b0}};
        end
        else begin:imp_one_hot
            for (cnt=0; cnt<CNT; cnt=cnt+1) begin: create_2d
                assign data_2d[cnt] = sel[cnt] ? din[cnt] : {WIDTH{1'b0}};
            end

            for (cnt=0; cnt<CNT; cnt=cnt+1) begin: transform_2d_outter
                for (w=0; w<WIDTH; w=w+1) begin: transform_2d_inner
                    assign data_2d_t[w][cnt] = data_2d[cnt][w];
                end
            end

            for (w = 0; w < WIDTH; w = w + 1) begin: or_all_din
                assign dout[w] = |data_2d_t[w];
            end
        end // block: imp_one_hot
    endgenerate


    generate
        if (ONE_HOT_CHECK) begin:onehot_checker
            wire [CNT-1:0] sel_m1, sel_msk;

            assign sel_m1   = sel - 1'b1;
            assign sel_msk  = ~(sel_m1 ^ sel);
            assign err = |(sel_msk & sel);

            //one_hot_error: assert property (not err)
            // else
            // $fatal("**Error: %m one hot fail");
        end
        else begin:no_onehot_checker
            assign err = 1'b0;
        end
    endgenerate


endmodule