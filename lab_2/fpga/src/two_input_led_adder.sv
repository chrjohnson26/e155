// adder.sv
// Christian Johnson
// chrjohnson@hmc.edu
// 9/5/25

/*
    Module that adds two 3-bit inputs
*/

module two_input_led_adder(input logic [3:0] a, b,
                            output logic [4:0] sum);

    // Adder for LEDs
    assign sum = a + b;
endmodule
