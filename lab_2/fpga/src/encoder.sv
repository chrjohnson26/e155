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

    always_comb begin
        // If enable 0 then choose s1 and if enable 1 then choose s2
        case (enable)
            1'b0: switches = s1;
            1'b1: switches = s2;
            default: switches = 4'bx;
        endcase
    end

endmodule