// top.sv
// Christian Johnson
// chrjohnson@hmc.edu
// 8/30/25

/*
    top module instantiates other modules for lab 1
*/

module top(input logic clk, reset,
            input logic s[3:0],
            output logic led[2:0],
            output logic seg[6:0]);

    // Instantiate led_controller module
    led_controller lc(clk, s, led);

    // Instantiate segment module
    segment seg(clk, reset, s, seg);

endmodule