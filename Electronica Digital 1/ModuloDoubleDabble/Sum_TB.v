// Modulo de prueba del modulo de suma
`timescale 1ns / 1ps

module Sum_TB;
    reg [3:0] a;
    wire [3:0] S;

    Sum uut (.a(a), .S(S));

    initial begin
        a = 4'd0; 
        #10;   
        a = 4'd2; 
        #10;   
        a = 4'd5; 
        #10;  
        a = 4'd9; 
        #10;   
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Sum_TB.vcd");
     $dumpvars(-1, uut);
    end

endmodule
