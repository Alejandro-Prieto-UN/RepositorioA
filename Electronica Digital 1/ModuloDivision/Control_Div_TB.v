//Modulo de prueba de la maquina de control del dividor
`timescale 1ns / 1ps
`define SIMULATION

module Control_Div_TB;

   reg clk;
   reg rst;
   reg init;  
   reg res_eq_1; 
   reg i_more_n;
   
   Control_Div uut(.clk(clk),.rst(rst),.init(init),.res_eq_1(res_eq_1),.i_more_n(i_more_n));

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
        #0 rst = 1; init = 0; res_eq_1= 0; i_more_n = 0; 
        @ (posedge clk);
        @ (negedge clk);
        rst = 0;
        @ (negedge clk);
        init = 1;
        @ (posedge clk);
        @ (negedge clk);
        res_eq_1 = 0;
        i_more_n = 0;
        init  = 0;
        @ (posedge clk);
        @ (negedge clk);
        res_eq_1 = 1;
        i_more_n = 0;
        @ (negedge clk);
        @ (posedge clk);
        res_eq_1 = 0;
        i_more_n = 1;
        @ (negedge clk);
        @ (posedge clk);
        res_eq_1 = 1;
        i_more_n = 0;
        @ (negedge clk);
        @ (posedge clk);
        res_eq_1 = 0;
        i_more_n = 1;
        @ (negedge clk);
        @ (posedge clk);
        res_eq_1 = 1;
        i_more_n = 0;  
        @ (negedge clk);
        @ (posedge clk);
        res_eq_1 = 0;
        i_more_n = 0;        
       end

   initial begin: TEST_CASE
     $dumpfile("Control_Div_TB.vcd");
     $dumpvars(-1, uut);
     #(1000) $finish;
   end
endmodule