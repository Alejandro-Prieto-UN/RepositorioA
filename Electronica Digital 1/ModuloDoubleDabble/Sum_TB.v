// Modulo de prueba de la suma +3
`timescale 1ns / 1ps

module Sum_TB;
    reg [3:0] a;
    wire [3:0] S;

    Sum uut (.a(a), .S(S));

    initial begin
        a = 4'd0; #10;   // S = 3
        a = 4'd2; #10;   // S = 5
        a = 4'd5; #10;   // S = 8
        a = 4'd9; #10;   // S = 12 (0xC) -> se descarta si a<5, aqui es informativo
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Sum_TB.vcd");
     $dumpvars(-1, uut);
    end

endmodule
