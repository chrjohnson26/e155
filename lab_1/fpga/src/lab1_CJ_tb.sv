`timescale 1ps/1ps
module lab1_CJ_tb();

logic clk, reset;
logic [3:0] s;
logic [2:0] led;
logic [6:0] seg;

logic [31:0] vectornum, errors;
logic [9:0] testvectors[10000:0];

lab1_CJ dut(s, led, seg);

always
begin
clk=1; #5; 
clk=0; #5;
end

//// Start of test. 
initial
begin
$readmemb("lab1_CJ.tv", testvectors);
vectornum=0;
errors=0;

reset=1; #22; 
reset=0;
end

always @(posedge clk)
begin
#1;

{s, led_expected, seg_expected} = testvectors[vectornum];
end

always @(negedge clk)

if (~reset) begin

if (led !== led_expected | seg !== seg_expected) begin

errors = errors + 1;
end

vectornum = vectornum + 1;

if (testvectors[vectornum] === 14'bx) begin

    $display("Error: inputs = %b", s);
    $display(" outputs = %b %b (%b %b expected)", led, seg, led_expected, seg_expected);
	
$display("%d tests completed with %d errors", vectornum, 
errors);

$stop;
end
end
endmodule