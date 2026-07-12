//Modulo de prueba de la maquina de control del algoritno Double Dabble inverso
`timescale 1ns / 1ps
`define SIMULATION

module Control_DoubleDabble_Inverso_TB;
    reg clk;
    reg rst;
    reg init; 
    reg i_eq_n;
    wire load;
    wire shift;
    wire subs;
    wire increase;
    wire done;
    
    
    Control_DoubleDabble_Inverso uut (.clk(clk),.rst(rst),.init(init),.i_eq_n(i_eq_n),.load(load),.shift(shift),.subs(subs),
    .increase(increase),.done(done));
    
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
        #0 rst = 1; init = 0; i_eq_n = 0;

        @ (posedge clk);
        @ (negedge clk);
        rst = 0;
        
        @ (negedge clk);
        init = 1; 
        
        @ (posedge clk);
        @ (negedge clk);
        init = 0;
        
         #150;
        
        @ (negedge clk);
        i_eq_n = 1; 
        
        @ (negedge clk);
        @ (negedge clk);
        i_eq_n = 0;
        
        #500;           
    end
    
    initial begin: TEST_CASE
        $dumpfile("Control_DoubleDabble_Inverso_TB.vcd");
        $dumpvars(-1, uut);
        #(1000) $finish;
    end
    
endmodule
