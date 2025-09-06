`timescale 1ns/1ps
module fir_tb;

    reg clk;
    reg rst;
    reg signed [7:0] sample_in;
    wire signed [19:0] sample_out;

    // DUT
    fir #(.N(4), .WIDTH(8)) dut (
        .clk(clk),
        .rst(rst),
        .sample_in(sample_in),
        .sample_out(sample_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz
    end

    // Stimulus
    initial begin
        rst = 1; sample_in = 0;
        #20 rst = 0;

        // Impulse
        sample_in = 8'sd1; #10;
        sample_in = 8'sd0; #100;

        // Step input
        sample_in = 8'sd5; #100;

        // Ramp
        sample_in = 8'sd1; #10;
        sample_in = 8'sd2; #10;
        sample_in = 8'sd3; #10;
        sample_in = 8'sd4; #10;
        sample_in = 8'sd5; #100;

        $stop;
    end
endmodule
