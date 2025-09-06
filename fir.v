// FIR filter 
module fir #(
    parameter N = 4,              // number of taps
    parameter WIDTH = 8           // input bit width
)(
    input clk,
    input rst,
    input signed [WIDTH-1:0] sample_in,
    output reg signed [2*WIDTH+3:0] sample_out
);

    // Example coefficients (adjust as needed)
    // For N=4 taps
    reg signed [WIDTH-1:0] coeff [0:N-1];
    initial begin
        coeff[0] = 8'sd1;
        coeff[1] = 8'sd2;
        coeff[2] = 8'sd3;
        coeff[3] = 8'sd4;
    end

    // Shift register for input samples
    reg signed [WIDTH-1:0] shift_reg [0:N-1];
    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < N; i = i + 1)
                shift_reg[i] <= 0;
            sample_out <= 0;
        end else begin
            // Shift input samples
            for (i = N-1; i > 0; i = i - 1)
                shift_reg[i] <= shift_reg[i-1];
            shift_reg[0] <= sample_in;

            // Multiply and accumulate
            sample_out <= 0;
            for (i = 0; i < N; i = i + 1)
                sample_out <= sample_out + shift_reg[i] * coeff[i];
        end
    end
endmodule
