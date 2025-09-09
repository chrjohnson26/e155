module multiplexed_seven_segment (
    input  logic        clk,         // Clock input for multiplexing
    input  logic        rst_n,       // Active low reset
    input  logic [3:0]  in0,         // First 4-bit input
    input  logic [3:0]  in1,         // Second 4-bit input
    output logic [6:0]  seg0,        // Seven segment output for first display
    output logic [6:0]  seg1         // Seven segment output for second display
);

    // Internal signals
    logic        sel;                  // Multiplex selector
    logic [3:0]  mux_in;               // Selected input
    logic [6:0]  decoded;              // Decoded output

    // Multiplex selector flips every clock cycle
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            sel <= 1'b0;
        else
            sel <= ~sel;
    end

    // Select input based on sel
    always_comb begin
        mux_in = (sel) ? in1 : in0;
    end

    // Seven segment decoder (common anode: segment ON = 0)
    always_comb begin
        case (mux_in)
            4'h0: decoded = 7'b0000001;
            4'h1: decoded = 7'b1001111;
            4'h2: decoded = 7'b0010010;
            4'h3: decoded = 7'b0000110;
            4'h4: decoded = 7'b1001100;
            4'h5: decoded = 7'b0100100;
            4'h6: decoded = 7'b0100000;
            4'h7: decoded = 7'b0001111;
            4'h8: decoded = 7'b0000000;
            4'h9: decoded = 7'b0000100;
            4'hA: decoded = 7'b0001000;
            4'hB: decoded = 7'b1100000;
            4'hC: decoded = 7'b0110001;
            4'hD: decoded = 7'b1000010;
            4'hE: decoded = 7'b0110000;
            4'hF: decoded = 7'b0111000;
            default: decoded = 7'b1111111;
        endcase
    end

    // Latch decoded value for each output on alternate clock edges
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            seg0 <= 7'b1111111;
            seg1 <= 7'b1111111;
        end else begin
            if (sel)
                seg1 <= decoded;
            else
                seg0 <= decoded;
        end
    end

endmodule