
module testbench();
	logic [3:0] s;
	logic [2:0] led;
	logic [6:0] seg;
	integer i;

	// Instantiate led_controller
	led_controller lc(
		.s(s),
		.led(led)
	);

	// Instantiate segment
	segment segmt(
		.s(s),
		.seg(seg)
	);

	initial begin
		$display("Testing led_controller and segment modules");
		$display("s\tled[2:0]\tseg[6:0]");
		for (i = 0; i < 16; i = i + 1) begin
			s = i;
			#1;
			$display("%b\t%b\t%b", s, led, seg);
		end
		$display("Testbench completed.");
		$stop;
	end
endmodule