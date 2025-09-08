// lab2_CJ.sv
// Christian Johnson
// chrjohnson@hmc.edu
// 9/4/25

/*
    Top-level module for Lab 2
    Connects the 7-segment display module to the FPGA board
*/

module lab2_CJ (input logic reset,
				input logic [3:0] s1, s2,
                output logic [6:0] seg,
                output logic anode1, anode2,
				output logic [4:0] leds
                );

    logic int_osc;
    logic [25:0] counter;
    logic enable = 1'b0;
    logic [3:0] cur_s;
    logic [4:0] sum;

    // Adder logic
    two_input_led_adder adder(s1, s2, leds);

    // Generate the clock using the onboard high-speed oscillator
    HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

    // Counter to choose which display
    always_ff @(posedge int_osc) begin
        if (reset) begin
            counter <= 0;
            enable <= 1'b0;
			sum <= 0;
        end else if (counter == 26'd100000) begin
            enable <= ~enable;
            counter <= 0;
        end else begin
            counter <= counter + 26'b1;
        end
    end

    // Encoder to choose which inputs to choose
    encoder enc(enable, s1, s2, cur_s);

    // Instantiate segment module
    segment sgmt(cur_s, seg);

    // Decoder to choose which output anode to power
    decoder dec(enable, anode1, anode2);
endmodule