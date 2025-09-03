// lab1_CJ.sv
// Christian Johnson
// chrjohnson@hmc.edu
// 8/30/25

/*
    top module instantiates other modules for lab 1
*/

module top(input logic [3:0] s,
            output logic [2:0] led,
            output logic [6:0] seg);

    // Instantiate led_controller module
    led_controller lc(s, led);

    // Instantiate segment module
    segment segmt(s, seg);

endmodule