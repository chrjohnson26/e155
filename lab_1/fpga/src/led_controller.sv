// Lab 1
// Christian Johnson
// chrjohnson@hmc.edu
// 8/30/2025

/*
    System Verilog practice interfacing with three LEDs on the dev board 
*/

module led_controller(input logic clk,
            input logic [3:0] s,
            output logic [2:0] led);
    

    logic int_osc;
    logic [25:0] counter;


    // To generate the clock use the onboard high-speed oscillator
	HSOSC hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));

    // led[0]
    assign led[0] = s[1] ^ s[0];
        
    // led[1]
    assign led[1] = s[2] & s[3];

    // led[2]
    // hf_osc is oscillating at 48MHz, we want led[2] to blink at 2.4Hz
    // So we want the MSB to turn on every 24MHz / 2.4 Hz = 20 MHz
    always_ff @(posedge int_osc) begin
        if (counter == 25'd20000000) begin
            led[2] <= ~led[2];
            counter <= 0;
        end
        counter <= counter + 1;
    end

    // assign led[2] = (counter == 7'd2000000);

endmodule
