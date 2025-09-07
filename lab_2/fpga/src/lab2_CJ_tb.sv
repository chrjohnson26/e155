// lab2_CJ_tb.sv
// Christian Johnson
// chrjohnson@hmc.edu
// 9/7/25

`timescale 1ns/1ns
module lab2_CJ_tb();

logic clk, reset;
logic [3:0] s1, s2;

logic [6:0] seg, seg_expected;
logic anode1, anode2, anode1_expected, anode2_expected;
logic [4:0] led, led_expected;

logic [31:0] testnum, errors;

// Initializng top module
lab2_CJ dut(clk, reset, s1, s2, seg, anode1, anode2, led);

always
begin
clk=1; #5; 
clk=0; #5;
end

//// Start of test. 
initial
begin
testnum=0;
errors=0;

reset=1; #22; 
reset=0;

repeat(10) begin
	s1 = 1;
	s2 = 2;
	
	wait(anode1 == 0 && anode2 == 1);
	#50;
	seg_expected = 7'b1111001;  // Display 1
	anode1_expected = 0;
	anode2_expected = 1;
	led_expected = 3;
	if (seg_expected !== seg || anode1_expected !== anode1 || anode2_expected !== anode2 || led !== led_expected) begin
		$display("Error inputs = %b, %b", s1, s2);
        $display(" seg = %b (%b expected)", seg, seg_expected);
		$display(" anodes = %b,%b (%b,%b expected)", anode1, anode2, anode1_expected, anode2_expected);
		errors = errors + 1;
	end
	
	wait(anode1 == 1 && anode2 == 0);
	#50;
	seg_expected = 7'b0100100;  // Display 2
	anode1_expected = 1;
	anode2_expected = 0;
	if (seg_expected !== seg || anode1_expected !== anode1 || anode2_expected !== anode2 || led !== led_expected) begin
		$display("Error inputs = %b, %b", s1, s2);
        $display(" seg = %b (%b expected)", seg, seg_expected);
		$display(" anodes = %b,%b (%b,%b expected)", anode1, anode2, anode1_expected, anode2_expected);
		errors = errors + 1;
	end


	s1 = 15;
	s2 = 14;
	
	wait(anode1 == 0 && anode2 == 1);
	#50;
	seg_expected = 7'b0001110;  // Display 1
	anode1_expected = 0;
	anode2_expected = 1;
	led_expected =29;
	if (seg_expected !== seg || anode1_expected !== anode1 || anode2_expected !== anode2 || led !== led_expected) begin
		$display("Error inputs = %b, %b", s1, s2);
        $display(" seg = %b (%b expected)", seg, seg_expected);
		$display(" anodes = %b,%b (%b,%b expected)", anode1, anode2, anode1_expected, anode2_expected);
		errors = errors + 1;
	end
	
	wait(anode1 == 1 && anode2 == 0);
	#50;
	seg_expected = 7'b0000110;  // Display 2
	anode1_expected = 1;
	anode2_expected = 0;
	if (seg_expected !== seg || anode1_expected !== anode1 || anode2_expected !== anode2 || led !== led_expected) begin
		$display("Error inputs = %b, %b", s1, s2);
        $display(" seg = %b (%b expected)", seg, seg_expected);
		$display(" anodes = %b,%b (%b,%b expected)", anode1, anode2, anode1_expected, anode2_expected);
		errors = errors + 1;
	end
end

end
endmodule