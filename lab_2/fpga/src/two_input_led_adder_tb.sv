// two_input_led_adder_tb
// Christian Johnson
// chrjohnson@hmc.edu
// 9/6/25

`timescale 1ns/1ns
module two_input_led_adder_tb();

logic clk, reset;
logic [3:0] a, b;
logic [4:0] sum, sum_expected;

logic [31:0] testnum, errors;

logic [3:0] i, j;

// Initializng adder module
two_input_led_adder adder(a, b, sum);

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
i = 0;
j = 0;

reset=1; #22; 
reset=0;
end

always @(posedge clk)
begin
if (~reset) begin
    // Apply new test inputs
    a = i;
    b = j;
    sum_expected = i + j;
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