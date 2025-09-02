// Lab 1
// Christian Johnson
// chrjohnson@hmc.edu
// 8/30/2025

/*
    System Verilog practice interfacing with three LEDs on the dev board 
*/

/*
	led_controller controls three LEDs based on four switch inputs
*/
module led_controller(input logic [3:0] s,
            output logic [2:0] led);
    

    logic int_osc;
    logic [25:0] counter;
	logic led2_reg = 1'b0;


    // To generate the clock use the onboard high-speed oscillator
    HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

    // led[0]
    assign led[0] = s[1] ^ s[0];

    // led[1]
    assign led[1] = s[2] & s[3];

    // led[2]
    // hf_osc is oscillating at 48MHz, we want led[2] to blink at 2.4Hz
    // So we want the MSB to turn on every 24MHz / 2.4 Hz = 10 MHz
    always_ff @(posedge int_osc) begin
         if (counter == 25'd10000000) begin
             led2_reg <= ~led2_reg;
             counter <= 0;
        end else begin
		counter <= counter + 1'b1;
		end
    end

    assign led[2] = led2_reg;

endmodule