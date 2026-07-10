// Modulo de prueba del incrementador
`timescale 1ns / 1ps

module Decrease_TB;
    
    reg clk;
    reg load;         
    reg decrease;
    wire [15:0] i; 
  
    Decrease uut(.clk(clk),.load(load),.decrease(decrease),.i(i));
    
    parameter PERIOD= 20;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET= 0;

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

        load=0; 
        decrease=0;
        #20
        load =1;
        decrease=0;
        #20
        load =0;
        decrease=0;
        #20
        decrease=1;
        #20
        decrease=0;
        #20
        decrease=1;
        #20
        decrease=0;
        #20
        decrease=1;
        #20
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Decrease_TB.vcd");
     $dumpvars(-1, uut);
   end

endmodule