`timescale 1ns / 1ps

module Multiplex_tb;

    reg [15:0] T0h;
    reg [15:0] T1h;
    reg [15:0] Res;
    reg [15:0] Per;
    reg [1:0] sel_tim;
    wire [15:0] out;

    Multiplex uut (.T0h(T0h),.T1h(T1h),.Res(Res),.Per(Per),.sel_tim(sel_tim),.out(out));

    initial begin
        $display("=== TESTBENCH MULTIPLEXOR ===");
        
        T0h = 16'hAAAA;
        T1h = 16'hBBBB;
        Res = 16'hCCCC;
        Per = 16'hDDDD;

        sel_tim = 2'b00; #10;
        $display("sel_tim=%b | out=%h (Esperado: AAAA)", sel_tim, out);

        sel_tim = 2'b01; #10;
        $display("sel_tim=%b | out=%h (Esperado: BBBB)", sel_tim, out);

        sel_tim = 2'b10; #10;
        $display("sel_tim=%b | out=%h (Esperado: CCCC)", sel_tim, out);

        sel_tim = 2'b11; #10;
        $display("sel_tim=%b | out=%h (Esperado: DDDD)", sel_tim, out);

        $finish;
    end

    initial begin: TEST_CASE
        $dumpfile("Multiplex_TB.vcd");
        $dumpvars(-1, uut);
    end

endmodule