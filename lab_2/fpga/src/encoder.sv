// encoder.sv
// Christian Johnson
// chrjohnson@hmc.edu
// 9/4/25

/*
    Encoder module for Lab 2
    Converts the 1-bit enable input to a 4-bit output to control which switches are used
*/

module encoder (
    input logic enable,
    input logic [3:0] s1, s2,
    output logic [3:0] switches
);
	
	assign switches = enable ? s2 : s1;

endmodule