//Modulo de pruba de la maquina de control de Double Dabble Inverso
`timescale 1ns / 1ps
`define SIMULATION

module Control_DoubleDabble_Inverso_TB;
    
    reg clk;
    reg rst;
    reg init; 
    reg a1_more_eq_8;
    reg a2_more_eq_8;
    reg a3_more_eq_8;
    reg i_eq_n;
   
   Control_DoubleDabble_Inverso uut (.clk(clk),.rst(rst),.init(init),.a1_more_eq_8(a1_more_eq_8)
   ,.a2_more_eq_8(a2_more_eq_8),.a3_more_eq_8(a3_more_eq_8),.i_eq_n(i_eq_n));

   parameter PERIOD          = 20;
   parameter real DUTY_CYCLE = 0;
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
        #0 rst = 1; init = 0; a1_more_eq_8 = 0; a2_more_eq_8=0;
        a3_more_eq_8=0; i_eq_n=0;

        @ (posedge clk);
        @ (negedge clk);
        rst = 0;
        @ (negedge clk);
        init = 1;
        @ (posedge clk);
        @ (negedge clk);
        a1_more_eq_8 = 0;
        a2_more_eq_8 = 0;
        a3_more_eq_8 = 0;
        i_eq_n=0;
        init  = 0;
        @ (posedge clk);
        @ (negedge clk);
        a1_more_eq_8 = 1;
        a2_more_eq_8 = 0;
        a3_more_eq_8 = 0;
        i_eq_n=0;
        @ (negedge clk);
        @ (posedge clk);
        a1_more_eq_8 = 0;
        a2_more_eq_8 = 1;
        a3_more_eq_8 = 0;
        i_eq_n=0;
        @ (negedge clk);
        @ (posedge clk);
        a1_more_eq_8 = 0;
        a2_more_eq_8 = 0;
        a3_more_eq_8 = 1;
        i_eq_n=0;
        @ (posedge clk);
        @ (negedge clk);
        @ (negedge clk);
        @ (negedge clk);
        a1_more_eq_8 = 0;
        a2_more_eq_8 = 0;
        a3_more_eq_8 = 0;
        i_eq_n=1;
        @ (negedge clk);
        @ (negedge clk);
        i_eq_n = 0;
        #5000;           
       end

   initial begin: TEST_CASE
     $dumpfile("Control_DoubleDabble_Inverso_TB.vcd");
     $dumpvars(-1, uut);
     #(1000) $finish;
   end
endmodule