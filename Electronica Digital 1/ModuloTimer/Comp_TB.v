`timescale 1ns / 1ps

module Comp_TB;

    reg [15:0] a;
    reg [15:0] b;
    wire z;

    Comp uut (.a(a),.b(b),.z(z));

    initial begin
        $display("=== TESTBENCH COMPARADOR ===");
        
        a = 16'd10; b = 16'd20;
        #10;
        $display("a=%d, b=%d | z=%b (Esperado: 0)", a, b, z);

        a = 16'd1250; b = 16'd1250;
        #10;
        $display("a=%d, b=%d | z=%b (Esperado: 1)", a, b, z);

        a = 16'd0; b = 16'd5;
        #10;
        $display("a=%d, b=%d | z=%b (Esperado: 0)", a, b, z);

        a = 16'd0; b = 16'd0;
        #10;
        $display("a=%d, b=%d | z=%b (Esperado: 1)", a, b, z);

        $finish;
    end

    initial begin: TEST_CASE
        $dumpfile("Comp_TB.vcd");
        $dumpvars(-1, uut);
    end

endmodule