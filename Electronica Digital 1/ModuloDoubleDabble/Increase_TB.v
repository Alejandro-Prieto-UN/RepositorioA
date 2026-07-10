// Modulo de prueba del incremetador
`timescale 1ns / 1ps

module Increase_TB;
    reg clk; 
    reg load; 
    reg increase ;
    wire i_eq_n ;

    Increase uut (.clk(clk),.load(load),.increase(increase),.i_eq_n(i_eq_n));

    initial clk = 0;
    always #10 clk = ~clk;

    initial begin
        load = 0; increase = 0;
        @(negedge clk); 
        load = 1;
        @(negedge clk); 
        load = 0;

        repeat (10) begin
            increase = 1;
            @(negedge clk);
        end
        increase = 0;
        #20;
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Increase_TB.vcd");
     $dumpvars(-1, uut);
    end

endmodule
