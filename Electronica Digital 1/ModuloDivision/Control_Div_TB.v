//Modulo de prueba de la maquina de control del dividor
`timescale 1ns / 1ps
`define SIMULATION

module Control_Div_TB;

    reg clk;
    reg rst;
    reg init;
    reg i_eq_zero;
    reg res_min_a;
   
   Control_Div uut(.clk(clk),.rst(rst),.init(init),.i_eq_zero(i_eq_zero),.res_min_a(res_min_a));

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

        rst = 1; init = 0; i_eq_zero = 0; res_min_a = 0; 
        #40; 
        rst = 0;
        #20;
        init = 1; 
        #20; 
        init = 0; 
        res_min_a = 0; 
        i_eq_zero = 0;
        #160;
        res_min_a = 1; 
        #100; 
        i_eq_zero = 1;
        #40;
        $finish;
   end

   initial begin: TEST_CASE
     $dumpfile("Control_Div_TB.vcd");
     $dumpvars(-1, uut);
     #(1000) $finish;
   end
endmodule