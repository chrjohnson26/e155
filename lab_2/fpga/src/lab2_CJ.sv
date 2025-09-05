// lab2_CJ.sv
// Christian Johnson
// chrjohnson@hmc.edu
// 9/4/25

/*
    Top-level module for Lab 2
    Connects the 7-segment display module to the FPGA board
*/

module lab2_CJ (input logic [7:0] s,
                output logic [6:0] seg,
                output logic anode1, anode2,
                );

    logic int_osc;
    logic [25:0] counter;
    logic enable = 1'b0;
    logic [3:0] cur_s;
    logic [4:0] sum;

    // Adder for LEDs
    assign sum = s[3:0] + s[7:4];

    // Generate the clock using the onboard high-speed oscillator
    HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

    // Counter to choose which display
    always_ff @(posedge int_osc) begin
         if (counter == 25'2400) begin
            enable <= ~enable;
            counter <= 0;
        end else begin
			counter <= counter + 1'b1;
		end
    end

    // Encoder to choose which inputs to choose
    encoder enc(enable, s, cur_s);

    // Instantiate segment module
    segment sgmt(cur_s, seg);

    // Decoder to choose which output anode to power
    decoder dec(enable, anode1, anode2);
endmodule