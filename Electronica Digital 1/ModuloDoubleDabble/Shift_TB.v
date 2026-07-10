// Modulo de prueba del registro Shift (load, shift, add en paralelo)
`timescale 1ns / 1ps

module Shift_TB;
    reg clk;
    reg load, shift, add;
    reg [2:0] update;
    reg [9:0] A;
    reg [11:0] in_bcd;
    wire [11:0] arr_corr;

    Shift uut (.clk(clk), .load(load), .shift(shift), .add(add),
               .update(update), .A(A), .in_bcd(in_bcd), .arr_corr(arr_corr));

    initial clk = 0;
    always #10 clk = ~clk;

    initial begin
        load = 0; shift = 0; add = 0; update = 3'b000; A = 10'd255; in_bcd = 12'b0;

        @(negedge clk); load = 1;
        @(negedge clk); load = 0;
        // arr_corr[9:0]... en realidad arr_corr es solo BCD, A vive internamente

        // desplazar un bit
        @(negedge clk); shift = 1;
        @(negedge clk); shift = 0;

        // simular que a1 (bits [3:0]) >= 5 y forzar correccion
        update = 3'b001;
        in_bcd = 12'd8; // valor de prueba
        @(negedge clk); add = 1;
        @(negedge clk); add = 0;

        #20;
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Shift_TB.vcd");
     $dumpvars(-1, uut);
    end

endmodule
