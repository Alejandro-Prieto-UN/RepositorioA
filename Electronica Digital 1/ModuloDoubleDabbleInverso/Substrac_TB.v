//Modulo de prueba de modulo substrac
`timescale 1ns / 1ps

module Sum_TB;

    reg [3:0] a;
    reg subs;

    wire [3:0] S;
    wire a_more_eq_8;

    Substrac uut (.a(a),.subs(subs),.S(S),.a_more_eq_8(a_more_eq_8));

    initial begin
        a = 4'd3; subs = 0;
        #20;

        a = 4'd3; subs = 1;
        #20;

        a = 4'd10; subs = 0;
        #20;

        a = 4'd10; subs = 1;
        #20;

        a = 4'd8; subs = 1;
        #20;

        $finish;
    end

    initial begin : TEST_CASE
        $dumpfile("Substrac_TB.vcd");
        $dumpvars(-1, uut);
    end

endmodule