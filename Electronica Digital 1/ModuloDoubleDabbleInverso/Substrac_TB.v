// Modulo de prueba del modulo de resta
`timescale 1ns / 1ps

module Substrac_TB;
    reg [3:0] a;
    wire [3:0] S;

    Substrac uut (.a(a),.S(S));

    initial begin
        a = 4'd10; 
        #10;   
        a = 4'd12; 
        #10;   
        a = 4'd15; 
        #10;  
        a = 4'd9; 
        #10;   
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Substrac_TB.vcd");
     $dumpvars(-1, uut);
    end

endmodule

