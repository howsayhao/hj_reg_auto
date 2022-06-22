module cdc_synczr_rst_1bit
    (
        clk,
        sync_in,
        sync_out,
        scan_enable,
        async_rst_n
    );

    parameter TRACK = 9;

    input   clk, scan_enable;
    input   async_rst_n;
    input   sync_in;
    output  sync_out;

    reg     sync_in_ff;
    reg     sync_in_ff1;
    reg     sync_out;

    always @(posedge clk or negedge async_rst_n) begin
        if (!async_rst_n) begin
            sync_in_ff  <= 1'b0;
            sync_in_ff1 <= 1'b0;
            sync_out    <= 1'b0;
        end
        else begin
            sync_in_ff  <= sync_in;
            sync_in_ff1 <= sync_in_ff;
            sync_out    <= sync_in_ff1;
        end
    end
endmodule