// lab2_CJ_tb
// Christian Johnson
// chrjohnson@hmc.edu
// 9/7/25

`timescale 1ns/1ns
module lab2_CJ_tb();

logic [3:0] s1, s2;
logic [6:0] seg;
logic anode1, anode2;
logic [31:0] errors;

// Instantiate lab2_CJ module
lab2_CJ dut(.s1(s1), .s2(s2), .seg(seg), .anode1(anode1), .anode2(anode2));

// Test vectors with known expected outputs
logic [6:0] expected_s1_seg, expected_s2_seg;

initial begin
    errors = 0;
    $display("Testing lab2_CJ time multiplexing functionality");
    $display("Time\t\tS1\tS2\tAnode1\tAnode2\tSeg\t\tExpected");
    
    // Test case 1: Different values for s1 and s2
    s1 = 4'b0001; // Display "1"
    s2 = 4'b0010; // Display "2"
    expected_s1_seg = 7'b0000110; // Expected for "1"
    expected_s2_seg = 7'b1011011; // Expected for "2"
    
    // Wait for a few multiplexing cycles to observe switching
    repeat(10) begin
        // Wait for enable to change to 0 (display s1)
        wait(anode1 == 0 && anode2 == 1);
        #100; // Small delay to ensure stable output
        
        $display("%0t\t\t%b\t%b\t%b\t%b\t%b\t%b (s1)", 
                 $time, s1, s2, anode1, anode2, seg, expected_s1_seg);
                 
        if (seg !== expected_s1_seg) begin
            $display("ERROR: Expected %b for s1=%b, got %b", expected_s1_seg, s1, seg);
            errors = errors + 1;
        end
        
        // Wait for enable to change to 1 (display s2)
        wait(anode1 == 1 && anode2 == 0);
        #100; // Small delay to ensure stable output
        
        $display("%0t\t\t%b\t%b\t%b\t%b\t%b\t%b (s2)", 
                 $time, s1, s2, anode1, anode2, seg, expected_s2_seg);
                 
        if (seg !== expected_s2_seg) begin
            $display("ERROR: Expected %b for s2=%b, got %b", expected_s2_seg, s2, seg);
            errors = errors + 1;
        end
    end
    
    // Test case 2: Same values for s1 and s2 (should always show same output)
    s1 = 4'b0101; // Display "5"
    s2 = 4'b0101; // Display "5"
    expected_s1_seg = 7'b1101101; // Expected for "5"
    expected_s2_seg = 7'b1101101; // Expected for "5"
    
    $display("\nTesting with same values s1=s2=5:");
    repeat(5) begin
        wait(anode1 == 0 && anode2 == 1);
        #100;
        if (seg !== expected_s1_seg) begin
            $display("ERROR: Expected %b for s1=%b, got %b", expected_s1_seg, s1, seg);
            errors = errors + 1;
        end
        
        wait(anode1 == 1 && anode2 == 0);
        #100;
        if (seg !== expected_s2_seg) begin
            $display("ERROR: Expected %b for s2=%b, got %b", expected_s2_seg, s2, seg);
            errors = errors + 1;
        end
    end
    
    $display("\nTime multiplexing test completed with %d errors", errors);
    if (errors == 0) 
        $display("✓ All tests PASSED");
    else 
        $display("✗ %d tests FAILED", errors);
    
    $stop;
end

endmodule