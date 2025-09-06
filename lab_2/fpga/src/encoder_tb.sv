// encoder_tb
// Christian Johnson
// chrjohnson@hmc.edu
// 9/6/25

`timescale 1ns/1ns
module encoder_tb();

logic clk, reset;
logic enable;
logic [3:0] s1, s2;
logic [3:0] switches, switches_expected;

logic [31:0] testnum, errors;

logic [3:0] i, j;
logic z;

// Initializng encoder module
encoder enc(enable, s1, s2, switches);

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
z = 0;

reset=1; #22; 
reset=0;
end

always @(posedge clk)
begin
if (~reset) begin
    // Apply new test inputs
	enable = z;
    s1 = i;
    s2 = j;
    switches_expected = z ? s2 : s1;
end
end

always @(negedge clk)
if (~reset) begin
    // Check results on negative edge
    if (switches !== switches_expected) begin
        $display("Error: inputs = %d, %d", s1, s2);
        $display(" outputs = %d (%d expected)", switches, switches_expected);
        errors = errors + 1;
    end
        
    // Increment test counters
    testnum = testnum + 1;
    
    // Update inputs
    j = j + 1;
	z = ~z;
    if (j >= 15) begin
        j = 0;
        i = i + 1;
    end
	
	
    
    // Check if we have covered all tests
    if (testnum >= 256) begin
        $display("%d tests completedd with %d errors", testnum, errors);
        $stop;
    end
end
endmodule