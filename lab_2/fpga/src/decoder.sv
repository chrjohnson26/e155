// decoder.sv
// Christian Johnson
// chrjohnson@hmc.edu
// 9/4/25

/*
    Decoder module for Lab 2
    Converts the 1-bit enable input to control which anode to power
*/
module decoder (
    input logic enable,
    output logic anode1,
    output logic anode2);

	assign anode1 = enable;
	assign anode2 = ~enable;
endmodule