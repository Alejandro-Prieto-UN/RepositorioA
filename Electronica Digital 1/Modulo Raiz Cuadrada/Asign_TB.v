// Modulo de prueba de modulo de asignacion
`timescale 1ns / 1ps

module Asign_TB;
    reg [15:0] ar;
    reg [5:0] i;
    reg bit;
    wire ar_out;
  
    Asign_Cc uut (.ar(ar),.i(i),.bit(bit),.ar_out(ar_out));

    initial begin
        ar=16'b00001111;
        i=16'd0;
        bit=0;
        #20
        i=16'd1;
        bit=0;
        #20
        i=16'd2;
        bit=0;
        #20
        i=16'd3;
        bit=0;
        #20
        i=16'd4;
        bit=0;
        #20
        i=16'd5;
        bit=1;
        #20
        i=16'd6;
        bit=1;
        #20
        i=16'd7;
        bit=1;
        #20
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Asign_TB.vcd");
     $dumpvars(-1, uut);
   end

endmodule