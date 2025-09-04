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
                anode1 = 1'b1;
                anode2 = 1'b0;
            end
            1'b1: begin
                anode1 = 1'b0;
                anode2 = 1'b1;
            end
            default: begin
                anode1 = 1'b0;
                anode2 = 1'b0;
            end
        endcase
    end
endmodule