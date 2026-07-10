`timescale 1ns / 1ps
`define SIMULATION

module Control_Paridad_TB;

    reg clk;
    reg rst;
    reg cont_eq_zero; 
    reg i_eq_n;
    reg a_eq_1;
    reg init;
   
    Control_Paridad uut (.clk(clk),.rst(rst),.cont_eq_zero(cont_eq_zero),.i_eq_n(i_eq_n),.a_eq_1(a_eq_1),.init(init));

   parameter PERIOD          = 20;
   parameter real DUTY_CYCLE = 0.5;
   parameter OFFSET          = 0;

   initial begin  
     #OFFSET;
     forever begin
         clk = 1'b0;
         #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
         #(PERIOD*DUTY_CYCLE);
     end
   end

   initial begin 
        rst = 1; 
        init = 0; 
        a_eq_1 = 0; 
        i_eq_n = 0; 
        cont_eq_zero = 0;
        
        #(PERIOD * 2);
        @(negedge clk);
        rst = 0;             
        
        #(PERIOD);
        
        @(negedge clk);
        init = 1;
        
        @(negedge clk);
        init = 0;            
        
        a_eq_1 = 1;
        @(negedge clk);      
        @(negedge clk);      
        a_eq_1 = 0;          
        i_eq_n = 0;          
        
        @(negedge clk);      
        
        @(negedge clk);      
        @(negedge clk);      
        i_eq_n = 0;          
        
        @(negedge clk);      

        a_eq_1 = 1;
        @(negedge clk);      
        @(negedge clk);      
        a_eq_1 = 0;
        i_eq_n = 1;          
        
        @(negedge clk);      
        
        @(negedge clk);      
        
        cont_eq_zero = 0; 
        @(negedge clk);      
        
        @(negedge clk);      
        
        #(PERIOD * 2);
        $finish;             
   end

   initial begin: TEST_CASE
     $dumpfile("Control_Paridad_TB.vcd");
     $dumpvars(0, Control_Paridad_TB);
   end

endmodule