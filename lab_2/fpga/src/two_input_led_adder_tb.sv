`timescale 1ns/1ns
module two_input_led_adder_tb();

logic clk, reset;
logic [3:0] a, b;
logic [4:0] sum, sum_expected;

logic [31:0] vectornum, errors;
logic [9:0] testvectors[10000:0];

// Initializng adder module
two_input_led_adder adder(a, b, sum)

always
begin
clk=1; #5; 
clk=0; #5;
end

//// Start of test. 
initial
begin
// $readmemb("adder.tv", testvectors);

vectornum=0;
errors=0;

reset=1; #22; 
reset=0;

for (i = 4'd0 ; i < 4'd16; i = i + 4'd1) begin
    for (j = 4'd0 ; j < 4'd16; j =  + 4'd1) begin
        // Setting expected sum
        assign sum_expected = i + j
        // Setting a and b to current value
        assign a = i;
        assign b = j; #5;


        // Asserting that the sum is as expected
        if (sum !== sum_expected) begin
            $display("Error: inputs = %b, %b", a, b);

            $display(" outputs = %b (%b expected)", sum, sum_expected);

            errors = errors + 1;
        end
    end
end

$stop;


end

// always @(posedge clk)
// begin
// #1;

// {a, b, sum_expected} = testvectors[vectornum];



// end



// always @(negedge clk)

// if (~reset) begin

// if (led !== led_expected) begin

// $display("Error: inputs = %b", s);

// $display(" outputs = %b (%b expected)", led, led_expected);

// errors = errors + 1;
// end

// vectornum = vectornum + 1;

// if (testvectors[vectornum] === 7'bx) begin
	
// $display("%d tests completed with %d errors", vectornum, 
// errors);

// $stop;
// end
// end
endmodule