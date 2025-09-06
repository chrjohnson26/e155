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

    always_comb begin
        case (enable)
            1'b0: begin
				// If the enable is 0 then we set the anode1 to low and anode 2 to high
                anode1 = 1'b0;
                anode2 = 1'b1;
            end
            1'b1: begin
				// If the enable is 1 then we ste the anode2 to high and anode 2 to low
                anode1 = 1'b1;
                anode2 = 1'b0;
            end
            default: begin
                anode1 = 1'bx;
                anode2 = 1'bx;
            end
        endcase
    end
endmodule