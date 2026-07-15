`timescale 1ns / 1ps

module Shift_TB;

    reg clk;
    reg ld;
    reg [23:0] RGB;
    reg sh;
    wire [23:0] corr;

    Shift uut (.clk(clk),.ld(ld),.RGB(RGB),.sh(sh),.corr(corr));

    always #10 clk = ~clk;

    initial begin
        $display("=== TESTBENCH MÓDULO SHIFT ===");
        clk = 0; ld = 0; sh = 0; RGB = 24'hA5B6C7;
        #30;

        @(posedge clk);
        ld = 1;
        @(posedge clk);
        ld = 0;
        $display("Dato cargado: %h", corr);

        @(posedge clk);
        sh = 1;
        repeat(3) @(posedge clk);
        sh = 0;
        $display("Dato desplazado: %h", corr);

        #40 $finish;
    end

    initial begin: TEST_CASE
        $dumpfile("Shift_TB.vcd");
        $dumpvars(-1, uut);
    end
endmodule