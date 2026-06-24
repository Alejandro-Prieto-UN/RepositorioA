// Modulo de prueba de modulo de asignacion
`timescale 1ns / 1ps

module Asign_TB;
    reg [15:0] arr;
    reg value;
    wire arr_out;
  
    Asign uut (.arr(arr),.value(value),.arr_out(arr_out));

    initial begin
        arr=16'b00001111;
        value=0;
        #20
        value=0;
        #20
        value=0;
        #20
        value=0;
        #20
        value=0;
        #20
        value=1;
        #20
        value=1;
        #20
        value=1;
        #20
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Asign_TB.vcd");
     $dumpvars(-1, uut);
   end

endmodule