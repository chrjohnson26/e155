// top.sv
// Christian Johnson
// chrjohnson@hmc.edu
// 8/30/25

/*
    top module instantiates other modules for lab 1
*/

module top(input logic clk, reset,
            input logic [3:0] s,
            output logic [2:0] led,
            output logic [6:0] seg);

    // Instantiate led_controller module
    led_controller lc(clk, s, led);

    // Instantiate segment module
    segment segmt(clk, reset, s, seg);

endmodule