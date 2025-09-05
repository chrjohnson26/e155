// decoder_tb.sv
// Christian Johnson
// 9/5/25

/*
    Test bench for a 1-bit decoder
*/
`timescale 1ns/1ns
module decoder_tb();

logic clk, reset;
logic [3:0] s;
logic [6:0] seg, seg_expected;

logic enable;
logic anode1, anode2, anode1_expected, anode2_expected;

logic [31:0] vectornum, errors;
logic [9:0] testvectors[10000:0];

decoder dec(enable, anode1, anode2);

always
begin
clk=1; #5; 
clk=0; #5;
end
//// Start of test.  
initial 
begin 
    $readmemb("decoder.tv", testvectors); 
    vectornum=0; 
    errors=0; 
    reset=1; #22; 
    reset=0; 
    end 
    always @(posedge clk) begin 
        #1; 
        {enable, anode1_expected, anode2_expected} = testvectors[vectornum]; 
        end 
        always @(negedge clk) 
        if (~reset) begin 
            if (anode1 !== anode1_expected, anode2 !== anode2_expected) 
            begin 
                $display("Error: inputs = %b", enable); 
                $display(" outputs = %b, %b (%b, %b expected)", anode1, anode2, anode1_expected, anode2_expected); 
                errors = errors + 1;
            end 
            vectornum = vectornum + 1; 
            if (testvectors[vectornum] === 11'bx) 
            begin 
                $display("%d tests completed with %d errors", vectornum, errors); 
                $stop;
        end 
    end 
endmodule