// Modulo de prueba del multiplexor

module Multiplex_TB;

    reg [15:0] i;
    reg [15:0] arr;
    wire arr_i; 
  
    Multiplex uut (.i(i),.arr(arr),.arr_i(arr_i));


    initial begin
        ar=16'b1101101110101010; 
        #20
        i=16'd0; 
        #20 
        i=16'd1;
        #20 
        i=16'd2;
        #20
        i=16'd3;
        #20
        i=16'd4;
        #20
        i=16'd5;
        #20 
        i=16'd6;
        #20
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Multiplex_TB.vcd");
     $dumpvars(-1, uut);
   end

endmodule