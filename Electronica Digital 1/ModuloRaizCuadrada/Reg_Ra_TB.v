//Modulo de prueba del Redistro de Ra
`timescale 1ns / 1ps
`define SIMULATION

module Reg_RA_TB;
    
    reg clk;
    reg rst;
    reg load;
    reg shift;
    reg subs;
    reg [15:0] A;
    reg [15:0] Op;
    wire [31:0] RA;

    Reg_RA uut (.clk(clk),.rst(rst),.load(load),.shift(shift),.subs(subs),.A(A),.Op(Op),.RA(RA));

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
        #0 rst = 1; load = 0; shift = 0; subs = 0; A = 16'd0; Op = 16'd0;

        @ (posedge clk);
        @ (negedge clk);
        rst = 0;
        
        @ (negedge clk);
        A = 16'hABCD;
        load = 1; 
        
        @ (posedge clk);
        @ (negedge clk);
        load = 0;
        
        @ (negedge clk);
        shift = 1;
        
        @ (posedge clk);
        @ (negedge clk);
        shift = 0;
        
        @ (negedge clk);
        Op = 16'h0002;
        subs = 1;
        
        @ (posedge clk);
        @ (negedge clk);
        subs = 0;
        
        #100;           
    end

    initial begin: TEST_CASE
        $dumpfile("Reg_RA_TB.vcd");
        $dumpvars(-1, uut);
        #(500) $finish;
    end
endmodule