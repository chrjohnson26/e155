module seven_seg_mux (
    input  logic clk,                  // Oscillator clock input
    input  logic [3:0] in0,            // First 4-bit input
    input  logic [3:0] in1,            // Second 4-bit input
    output logic [6:0] seg0,           // First 7-segment output
    output logic [6:0] seg1            // Second 7-segment output
);

    logic [3:0] mux_in;
    logic [6:0] seg_out;
    logic mux_sel;

    // Simple clock divider for multiplexing (you may adjust division factor)
    logic [15:0] div_cnt;
    always_ff @(posedge clk) begin
        div_cnt <= div_cnt + 1;
        mux_sel <= div_cnt[15]; // Use MSB for slow mux select signal
    end

    // Multiplex input selection
    always_comb begin
        mux_in = mux_sel ? in1 : in0;
    end

    // Instantiate the seven segment decoder
    seven_segment_decoder decoder_inst (
        .bin_in(mux_in),
        .seg_out(seg_out)
    );

    // Latch outputs for display persistence
    always_ff @(posedge clk) begin
        if (mux_sel)
            seg1 <= seg_out;
        else
            seg0 <= seg_out;
    end

endmodule