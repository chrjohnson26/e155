`timescale 1ns/1ns
module segment_tb();

logic clk, reset;
logic [3:0] s;
logic [6:0] seg, seg_expected;

logic [31:0] vectornum, errors;
logic [9:0] testvectors[10000:0];

segment sgmt(s, seg);

always
begin
clk=1; #5; 
clk=0; #5;
end

//// Start of test. 
initial
begin
$readmemb("segment.tv", testvectors);
vectornum=0;
errors=0;

reset=1; #22; 
reset=0;
end

always @(posedge clk)
begin
#1;

{s, seg_expected} = testvectors[vectornum];
end

always @(negedge clk)

if (~reset) begin

if (seg !== seg_expected) begin

errors = errors + 1;
end

vectornum = vectornum + 1;

if (testvectors[vectornum] === 10'bx) begin
	
$display("%d tests completed with %d errors", vectornum, 
errors);

$stop;
end
end
endmodule