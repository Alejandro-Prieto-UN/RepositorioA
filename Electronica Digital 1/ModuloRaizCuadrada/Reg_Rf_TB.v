//Modulo de prueba del resgistro de Rf
`timescale 1ns / 1ps
`define SIMULATION

module Reg_Rf_TB;
    
    reg clk;
    reg rst;
    reg load;
    reg assi;
    reg value;
    wire [13:0] Rf;

    Reg_Rf uut (.clk(clk),.rst(rst),.load(load),.assi(assi),.value(value),.Rf(Rf));

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
        #0 rst = 1; load = 0; assi = 0; value = 0;

        @ (posedge clk);
        @ (negedge clk);
        rst = 0;
        
        @ (negedge clk);
        load = 1; 
        
        @ (posedge clk);
        @ (negedge clk);
        load = 0;
        
        @ (negedge clk);
        value = 1'b1; 
        assi = 1;
        
        @ (posedge clk);
        @ (negedge clk);
        value = 1'b0;
        
        @ (posedge clk);
        @ (negedge clk);
        assi = 0;
        
        #100;           
    end

    initial begin: TEST_CASE
        $dumpfile("Reg_Rf_TB.vcd");
        $dumpvars(-1, uut);
        #(500) $finish;
    end
endmodule
