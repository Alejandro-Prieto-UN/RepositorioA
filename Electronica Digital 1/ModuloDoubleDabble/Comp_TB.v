// Modulo de prueba del modulo del comparador
`timescale 1ns / 1ps

module Comp_TB;
    reg [3:0] a;
    wire mayor;

    Comp uut (.a(a), .mayor(mayor));

    initial begin
        a = 4'd0; #10;
        a = 4'd4; #10;
        a = 4'd5; #10;   
        a = 4'd9; #10;
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Comp_TB.vcd");
     $dumpvars(-1, uut);
    end

endmodule
