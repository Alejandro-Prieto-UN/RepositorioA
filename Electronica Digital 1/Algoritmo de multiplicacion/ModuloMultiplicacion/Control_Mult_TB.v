`timescale 1ns / 1ps
`define SIMULATION

module Control_Mult_TB;

   reg clk;
   reg rst; 
   reg a_eq_1; 
   reg i_eq_n;
   reg init;

   // Modulo de Unidad de Control para Multiplicador



 Control_Mult uut (.clk(clk),.rst(rst),.a_eq_1(a_eq_1),.i_eq_n(i_eq_n),.init(init));

   parameter PERIOD          = 20;
   parameter real DUTY_CYCLE = 0.5;
   parameter OFFSET          = 0;

   initial  begin  
     #OFFSET;
     forever
       begin
         clk = 1'b0;
         #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
         #(PERIOD*DUTY_CYCLE);
       end
   end

   initial begin 
        #0 rst = 1; init = 0; a_eq_1 = 0; i_eq_n = 0; 
        @ (posedge clk);
        @ (negedge clk);
        rst = 0;
        @ (negedge clk);
        init = 1;
        @ (posedge clk);
        @ (negedge clk);
        a_eq_1 = 0;
        init  = 0;
        @ (posedge clk);
        @ (negedge clk);
        a_eq_1 = 1;
        @ (negedge clk);
        @ (posedge clk);
        a_eq_1 = 0;
        @ (negedge clk);
        @ (posedge clk);
        i_eq_n = 0;
        @ (posedge clk);
        @ (negedge clk);
        @ (negedge clk);
        @ (negedge clk);
        i_eq_n = 1;
        @ (negedge clk);
        @ (negedge clk);

        i_eq_n = 0;           
       end

   initial begin: TEST_CASE
     $dumpfile("Control_Mult_TB.vcd");
     $dumpvars(-1, uut);
     #(1000) $finish;
   end
endmodule