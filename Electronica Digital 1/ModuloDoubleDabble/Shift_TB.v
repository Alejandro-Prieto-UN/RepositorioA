// Modulo de pruba del modulo shift
`timescale 1ns / 1ps

module Shift_TB;
    reg clk;
    reg load; 
    reg shift; 
    reg sum;
    reg [2:0] update;
    reg [9:0] A;
    reg [11:0] in_bcd;
    wire [11:0] arr_corr;

    Shift uut (.clk(clk),.load(load),.shift(shift),.sum(sum),.update(update),.A(A),.in_bcd(in_bcd),.arr_corr(arr_corr));

    initial clk = 0;
    always #10 clk = ~clk;

    initial begin
        load = 0; 
        shift = 0; 
        sum = 0; 
        update = 3'b000; 
        A = 10'd255; 
        in_bcd = 12'b0;

        @(negedge clk); 
        load = 1;
        @(negedge clk); 
        load = 0;
        @(negedge clk); 
        shift = 1;
        @(negedge clk); 
        shift = 0;
        update = 3'b001;
        in_bcd = 12'd8; 
        @(negedge clk); 
        sum = 1;
        @(negedge clk); 
        sum = 0;
        #20;
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Shift_TB.vcd");
     $dumpvars(-1, uut);
    end

endmodule
