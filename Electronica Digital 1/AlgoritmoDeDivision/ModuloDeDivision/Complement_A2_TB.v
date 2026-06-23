// Modulo de prueba del complemento a2

module Complement_A2_TB;
    reg [15:0] a;
    wire [15:0] ca2;

  
    Complement_A2 uut (.A(a),.CA2(ca2));

    initial begin

        a=6'd8;
        #10
        a=6'd4;
        #10
        a=6'd5;
        #10;
        a=6'd7;
        #10;
        a=6'd3;
        #10;
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Complement_A2_TB.vcd");
     $dumpvars(-1, uut);
   end

endmodule