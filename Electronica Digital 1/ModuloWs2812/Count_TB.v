`timescale 1ns / 1ps

module Count_TB;

    reg clk;
    reg ld;
    reg dec;
    wire [15:0] z;

    Count uut (.clk(clk),.ld(ld),.dec(dec),.z(z));

    always #10 clk = ~clk;

    initial begin
        $display("=== TESTBENCH MÓDULO COUNT ===");
        clk = 0; ld = 0; dec = 0;
        #30;

        @(posedge clk);
        ld = 1;
        @(posedge clk);
        ld = 0;
        $display("Valor despues de ld: %d", z);

        @(posedge clk);
        dec = 1;
        repeat(5) @(posedge clk);
        dec = 0;
        $display("Valor despues de decrementar: %d", z);

        #40 $finish;
    end

    initial begin: TEST_CASE
        $dumpfile("Count_TB.vcd");
        $dumpvars(-1, uut);
    end
endmodule