# Interrupt template user guide

## Usage

The interrupt template and RTL generation is integrated in HRDA.

```bash
# generate a SystemRDL template for common interrupt,
# you just need to specify the total input interrupt number
hrda template -rdl --interrupt_template --interrupt_number <interrupt-numbers-you-want-to-merge> -n <template-name>
# generate RTL using the template
hrda generate -f <template-name>.rdl -grtl -gdir <output-directory>
```

## Architecture

Generated `regslv` module has 4 bits for each interrupt:

- `inj`

    software injection, software rw, default 0

    if `inj` is 1 and `en` is 1, whatever the original input interrupt value is, the final out interrupt will be triggered

    this bit is in `injection` register

- `en`

    enable the interrupt, software rw, default 0

    if `en` is 0, the interrupt will be masked

    this bit is in `enable` register

- `typ`

    interrupt type, 0 for level, 1 for edge, software rw, default 0

    this bit is in `intr_type` register

- `stat`

    interrupt status, software rw, write 1 to clear the bit, default 0
    this bit is in `status` register

## Example

If you want to merge 3 interrupts into one, the generated RTL module ports will be like this:

```verilog
module regslv_intr_temp (
    status_0__stat_0__next_value,
    status_0__stat_1__next_value,
    status_0__stat_2__next_value,
    status_0__intr_out,
    clk,
    rst_n,
    soft_rst,
    req_vld,
    wr_en,
    rd_en,
    addr,
    wr_data,
    rd_data,
    ack_vld,
    err,
    err_en
);
```

There are `reg_native_if`, input interrupt ports `status_0__stat_<0/1/2>__next_value`, and output interrupt port `status_0__intr_out`.

Note that because register is 32-bit wide, if the interrupt number exceeds 32, the generated RTL module will have multiple `status` registers, thus multiple output interrupt ports `status_<0/1/..>__intr_out`.
