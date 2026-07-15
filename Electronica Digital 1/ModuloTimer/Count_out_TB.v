`timescale 1ns / 1ps

module Count_out_tb;

    reg clk;
    reg rst;
    reg inc;
    wire [15:0] count_out;

    Count_out uut (.clk(clk),.rst(rst),.inc(inc),.count_out(count_out));

    always begin
        #10 clk = ~clk;
    end

    initial begin
        $display("=== TESTBENCH CONTADOR ===");
        clk = 0;
        rst = 1; 
        inc = 0;
        #30;

        @(posedge clk);
        rst = 0;
        $display("Reset desactivado. count_out=%d", count_out);

        @(posedge clk);
        inc = 1;
        
        repeat (5) @(posedge clk);
        $display("Incrementando... count_out=%d (Esperado: 5)", count_out);

        @(posedge clk);
        inc = 0;
        repeat (2) @(posedge clk);
        $display("Incremento desactivado. count_out=%d (Esperado: 5)", count_out);

        @(posedge clk);
        inc = 1;
        repeat (3) @(posedge clk);
        $display("Incrementando nuevamente... count_out=%d (Esperado: 8)", count_out);

        @(posedge clk);
        rst = 1;
        @(negedge clk); 
        #2;
        $display("Reset activado. count_out=%d (Esperado: 0)", count_out);

        $finish;
    end

     initial begin: TEST_CASE
        $dumpfile("Comp_TB.vcd");
        $dumpvars(-1, uut);
    end

endmodule