// Modulo de prueba del mmultiplexor
`timescale 1ns / 1ps

module Multiplex_TB;

    reg [15:0] i;
    reg [15:0] A;
    wire A_i; 
  
    Multiplex uut (.i(i),.A(A),.A_i(A_i));


    initial begin
        A=32'b1010111; 
        i= 32'd1;
        #20 
        i= 32'd2;
        #20
        i= 32'd2;
        #20
        i= 32'd3;
        #20
        i= 32'd4;
        #20 
        i= 32'd5;
        #20
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Multiplex_TB.vcd");
     $dumpvars(-1, uut);
   end

endmodule