// naming convention:
//      module name:
//          regdisp_{upstream_addrmap_inst_name}
//
module regdisp_template (
    clk,
    rst_n,
    // upstream reg_native_if
    upstream__req_vld,
    upstream__ack_vld,
    upstream__addr,
    upstream__wr_en,
    upstream__rd_en,
    upstream__wr_data,
    upstream__rd_data,
    // downstream reg_native_if
    // for regslv
    // for 3rd party IP
    // for external memories
    downstream__req_vld,
    downstream__ack_vld,
    downstream__addr,
    downstream__wr_en,
    downstream__rd_en,
    downstream__wr_data,
    downstream__rd_data
);

// decode upstream address
always_comb begin
    if_sel = {FORWARD_NUM{1'b0}};
    no_sel = 1'b0;
    unique casez (upstream__addr)
        64'h0???: if_sel[0] = 1'b1;
        64'h1???: if_sel[1] = 1'b1;
        64'h2???: if_sel[2] = 1'b1;
        default: no_sel = 1'b1;
    endcase
end

generate

endgenerate

endmodule