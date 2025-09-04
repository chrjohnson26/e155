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
    input logic [7:0] s,
    output logic [3:0] switches
);

    always_comb begin
        // If enable 0 then choose s[0:3] and if enable 1 then choose s[4:7]
        case (enable)
            1'b0: switches = s[3:0];
            1'b1: switches = s[7:4];
            default: switches = 4'b0;
        endcase
    end

endmodule