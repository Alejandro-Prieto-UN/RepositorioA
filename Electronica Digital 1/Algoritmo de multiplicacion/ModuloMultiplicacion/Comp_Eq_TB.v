// Modulo de prueba comparador igual a 1
`timescale 1ns / 1ps

module Comp_Eq_TB;
    reg a_i;
  
    Comp_Eq uut (.a_i(a_i));

    initial begin

        a_i = 0; #10;
        a_i = 1; #10;
        a_i = 0; #10;
        a_i = 1; #10;
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Comp_Eq_TB.vcd");
     $dumpvars(-1, uut);
   end

endmodule