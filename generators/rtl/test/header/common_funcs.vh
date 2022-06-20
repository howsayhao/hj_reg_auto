function reg [31:0] log2;
    input reg [31:0] value;
    log2 = 1;
    while (value > (2**log2))
        log2 = log2 + 1;
endfunction

// Add one more bit when value=2**log2
// used for counter width calculation
function reg[31:0] log2_cnt;
    input reg [31:0] value;
    log2_cnt = 1;
    while (value >= (2**log2_cnt))
        log2_cnt = log2_cnt + 1;
endfunction

function reg [31:0] hj_ecc_width;
    input reg [31:0] dat_width;

    if (dat_width <= 4)
        hj_ecc_width = 4;
    else if (dat_width <= 11)
        hj_ecc_width = 5;
    else if (dat_width <= 26)
        hj_ecc_width = 6;
    else if (dat_width <= 57)
        hj_ecc_width = 7;
    else if (dat_width <= 120)
        hj_ecc_width = 8;
    else if (dat_width <= 247)
        hj_ecc_width = 9;
    else
        hj_ecc_width = 10;
endfunction