// Modulo de prueba del incrementador
`timescale 1ns / 1ps

module Increase_I_TB;
    
    reg clk;
    reg load;         
    reg increase;
    wire [15:0] IncI; 
  
    Increase_I uut (.clk(clk),.load(load),.increase(increase),.IncI(IncI));
    
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
        increase=0;
        #20
        load =1;
        increase=1;
        #20
        load =0;
        increase=0;
        #20
        increase=1;
        #20
        increase=0;
        #20
        increase=1;
        #20
        increase=0;
        #20
        increase=1;
        #20
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Increase_I_TB.vcd");
     $dumpvars(-1, uut);
   end

endmodule