// Modulo de prueba del contador descendente
`timescale 1ns / 1ps

module Increase_TB;
    reg clk, rst, load, dec;
    wire Zero;

    Increase uut (.clk(clk), .rst(rst), .load(load), .dec(dec), .Zero(Zero));

    initial clk = 0;
    always #10 clk = ~clk;

    initial begin
        rst = 1; load = 0; dec = 0;
        @(negedge clk); rst = 0; load = 1;
        @(negedge clk); load = 0;

        repeat (10) begin
            dec = 1;
            @(negedge clk);
        end
        dec = 0;
        // aqui Zero deberia estar en 1
        #20;
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Increase_TB.vcd");
     $dumpvars(-1, uut);
    end

endmodule
