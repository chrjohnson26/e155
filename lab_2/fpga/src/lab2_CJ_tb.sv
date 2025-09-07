// lab2_CJ_tb
// Christian Johnson
// chrjohnson@hmc.edu
// 9/7/25

`timescale 1ns/1ns
module lab2_CJ_tb();

logic clk, reset;
logic [3:0] s1, s2;
logic [4:0] leds, leds_expected;
logic [6:0] seg, seg_expected;
logic anode1, anode2, anode1_expected, anode2_expected;

logic [31:0] testnum, errors;

// Initializng lab2_CJ module
lab2_CJ dut(s1, s2, seg, anode1, anode2, leds);

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
end

always @(posedge clk)
begin
if (~reset) begin
	
	// update the input values

end
end

always @(negedge clk)
if (~reset) begin
    // Check results on negative edge
    if (sum !== sum_expected) begin
        $display("Error: inputs = %d, %d", a, b);
        $display(" outputs = %d (%d expected)", sum, sum_expected);
        errors = errors + 1;
    end
        
    // Increment test counters
    testnum = testnum + 1;
    
    // Update inputs
    j = j + 1;
    if (j >= 15) begin
        j = 0;
        i = i + 1;
    end
    
    // Check if we have covered all tests
    if (testnum === 256) begin
        $display("%d tests completed with %d errors", testnum, errors);
        $stop;
    end
end
endmodule