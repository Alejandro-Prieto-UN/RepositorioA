// Modulo de prueba comparador igual a 1
`timescale 1ns / 1ps

module Comp_TB;
    reg i;
  
    Comp_Eq uut (.i(i));

    initial begin

        i = 0; #10;
        i = 1; #10;
        i = 0; #10;
        i = 1; #10;
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Comp_TB.vcd");
     $dumpvars(-1, uut);
   end

endmodule