`ifndef __field_attr_vh__
`define __field_attr_vh__

// SW_TYPE
`define SW_RO    4'd0 // Read only
`define SW_RW    4'd1 // Read Write
`define SW_RW1   4'd2 // Read, Write once after reset
`define SW_WO    4'd3 // Write only
`define SW_W1    4'd4 // Write once after reset

// SW_ONREAD_TYPE
`define NA       4'd0 // No Read side-effect
`define RCLR     4'd1 // Clear on Read
`define RSET     4'd2 // Set on Read

// SW_ONWRITE_TYPE
`define NA       4'd0 // No Write side-effect
`define WOCLR    4'd1 // Write 1 to Clear
`define WOSET    4'd2 // Write 1 to Set
`define WOT      4'd3 // Write 1 to Toggle
`define WZS      4'd4 // Write 0 to Set
`define WZC      4'd5 // Write 0 to Clear
`define WZT      4'd6 // Write 0 to Toggle

// HW_TYPE
`define HW_NA    4'd0 // Hardware not accessible
`define HW_RO    4'd1 // Read only
`define HW_WO    4'd2 // Write only
`define HW_RW    4'd3 // Read, Write on hw_pulse
`define HW_CLR   4'd4 // Bitwise Clear, hw_pulse input is ignored.
`define HW_SET   4'd5 // Bitwise Set, hw_pulse input is ignored.

`define SW 0
`define HW 1

`endif
