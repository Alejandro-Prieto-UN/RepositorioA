`timescale 1ns / 1ps

module Count_addr_TB;

    reg clk;
    reg rst;
    reg inc;
    wire [15:0] count_addr;


    Count_addr uut (.clk(clk),.rst(rst),.inc(inc),.count_addr(count_addr));

    always #10 clk = ~clk;

    initial begin
        $display("=== TESTBENCH MÓDULO COUNT_ADDR ===");
        clk = 0; rst = 0; inc = 0;
        #30;

        @(posedge clk);
        rst = 1;
        @(posedge clk);
        rst = 0;
        $display("Valor despues de Reset: %d", count_addr);

        @(posedge clk);
        inc = 1;
        repeat(4) @(posedge clk);
        inc = 0;
        $display("Valor despues de 4 incrementos: %d", count_addr);

        #40 $finish;
    end

    initial begin
        $dumpfile("Count_addr_TB.vcd");
        $dumpvars(-1, uut);
    end
endmodule