// Modulo de prueba comparador igual a 1
`timescale 1ns / 1ps

module Comp_TB;
    reg [15:0] a;
    reg [15:0] b;
    wire igual;
    wire mayor;
  
    Comp uut (.a(a),.b(b),.igual(igual),.mayor(mayor));

    initial begin

        a=16'd8;
        b=16'd8;
        #10
        a=16'd10;
        b=16'd8;
        #10
        a=16'd11;
        b=16'd24;
        #10;
        a=16'd33;
        b=16'd33;
        #10;
        a=16'd23;
        b=16'd3;
        #10;
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Comp_TB.vcd");
     $dumpvars(-1, uut);
   end

endmodule