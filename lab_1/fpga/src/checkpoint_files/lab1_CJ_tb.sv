module lab1_CJ_tb();
logic clk, reset;
// 'clk' & 'reset' are common names for the clock and the reset, 
 // but they're not reserved.

logic [3:0] s;
logic [2:0] led;
logic [6:0] seg;

logic [31:0] vectornum, errors;
 
logic [9:0] testvectors[10000:0];

led_controller lc(s, led);

always
// 'always' statement causes the statements in the block to be 
// continuously re-evaluated.
begin
 //// Create clock with period of 10 time units. 
// Set the clk signal HIGH(1) for 5 units, LOW(0) for 5 units 
clk=1; #5; 
clk=0; #5;
end

//// Start of test. 
initial
// 'initial' is used only in testbench simulation.
begin
//// Load vectors stored as 0s and 1s (binary) in .tv file.
$readmemb("alu_decoder.tv", testvectors);
// $readmemb reads binarys, $readmemh reads hexadecimals.
// Initialize the number of vectors applied & the amount of 
// errors detected.
vectornum=0; 
errors=0;
// Both signals hold 0 at the beginning of the test.
//// Pulse reset for 22 time units(2.2 cycles) so the reset 
// signal falls after a clk edge.
reset=1; #22; 
reset=0;
// The signal starts HIGH(1) for 22 time units then remains 
//LOW(0) 
// for the rest of the test.
end
//// Apply test vectors on rising edge of clk.
always @(posedge clk)
// Notice that this 'always' has the sensitivity list that controls when all
// statements in the block will start to be evaluated. '@(posedge clk)' means 
// at positive or rising edge of clock. 
begin
//// Apply testvectors 1 time unit after rising edge of clock to 
// avoid data changes concurrently with the clock.
#1;
//// Break the current 5-bit test vector into 3 inputs and 2 
// expected outputs.
{a, b, c, d, e, f, g, y2_expected, y1_expected, y0_expected} = testvectors[vectornum];
end
//// Check results on falling edge of clk.
always @(negedge clk)
// This line of code lets the program execute the following indented 
// statements in the block at the negative edge of clock.
//// Don’t do anything during reset. Otherwise, check result.
if (~reset) begin
//// Detect error by checking if outputs from DUT match 
// expectation.
if (y0 !== y0_expected || y1 !== y1_expected || y2 !== y2_expected) begin
// If error is detected, print all 3 inputs, 2 outputs, 
// 2 expected outputs.
$display("Error: inputs = %b", {a, b, c, d, e, f, g});
// '$display' prints any statement inside the quotation to 
// the simulator window.
// %b, %d, and %h indicate values in binary, decimal, and 
// hexadecimal, respectively.
// {a, b, cin} create a vector containing three signals.
$display(" outputs = %b %b %b (%b %b %b expected)", y2, y1, y0, y2_expected, y1_expected, y0_expected);
//// Increment the count of errors.
errors = errors + 1;
end
//// In any event, increment the count of vectors.
vectornum = vectornum + 1;
//// When the test vector becomes all 'x', that means all the 
// vectors that were initially loaded have been processed, thus 
// the test is complete.
if (testvectors[vectornum] === 10'bx) begin
// '==='&'!==' can compare unknown & floating values (X&Z),unlike 
// '=='&'!=', which can only compare 0s and 1s.
// 5'bx is 5-bit binary of x's or xxxxx.
// If the current testvector is xxxxx, report the number of 
// vectors applied & errors detected.
$display("%d tests completed with %d errors", vectornum, 
errors);
// Then stop the simulation.
$stop;
end
end
// In summary, new inputs are applied on the positive clock edge and the 
// outputs are checked against the expected outputs on the negative clock 
// edge. Errors are reported simultaneously. The process repeats until there 
// are no more valid test vectors in the testvectors arrays. At the end of 
//the 
// simulation, the module prints the total number of test vectors applied and 
// the total number of errors detected. 
endmodule