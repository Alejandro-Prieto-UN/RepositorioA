//Modulo de prueba de la maquina de control de la raiz cuadrada
`timescale 1ns / 1ps
`define SIMULATION

module Control_RaizCuadrada_TB;

    reg clk;
    reg rst;  
    reg i_eq_zero;
    reg resp_more_eq_op;
    reg init;
   
    Control_RaizCuadrada uut (.clk(clk),.rst(rst),.i_eq_zero(i_eq_zero),.resp_more_eq_op(resp_more_eq_op),.init(init));
    
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
        i_eq_zero = 0;
        resp_more_eq_op = 0;
        
        #(PERIOD * 2);
        @(negedge clk);
        rst = 0;             
        
        #(PERIOD);
        
        @(negedge clk);
        init = 1;
        
        @(negedge clk);
        init = 0;            
        
        resp_more_eq_op = 1;
        @(negedge clk);      
        @(negedge clk);      
        resp_more_eq_op = 0;          
        i_eq_zero = 0;          
        
        @(negedge clk);      
        
        @(negedge clk);      
        @(negedge clk);      
        i_eq_zero = 0;          
        
        @(negedge clk);      

        resp_more_eq_op = 1;
        @(negedge clk);      
        @(negedge clk);      
        resp_more_eq_op = 0;
        i_eq_zero = 1;          
        
        @(negedge clk);      
        
        @(negedge clk);      
        
        i_eq_zero = 0; 
        @(negedge clk);      
        
        @(negedge clk);      
        
        #(PERIOD * 2);
        $finish;             
    end

    initial begin : TEST_CASE
        $dumpfile("Control_RaizCuadrada_TB.vcd");
        $dumpvars(-1, uut);
    end

endmodule