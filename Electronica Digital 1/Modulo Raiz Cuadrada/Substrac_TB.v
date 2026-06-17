`timescale 1ns / 1ps

module Substrac_TB;
    reg clk;
    reg load;         
    reg subs;          
    reg [31:0] B1;
    reg [31:0] B2;
    wire [31:0] arr_Subs; 
    
    Substrac uut (.clk(clk), .load(load), .subs(subs), .B1(B1), .B2(B2), .arr_Subs(arr_Subs));
    
    parameter PERIOD = 20;
    parameter real DUTY_CYCLE = 0.5;

    // Reloj estable
    initial begin  
        forever begin
            clk = 1'b0;
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
            #(PERIOD*DUTY_CYCLE);
        end
    end

    initial begin
        load = 0; subs = 0; B1 = 32'd0; B2 = 32'd0;
        #5; 

        load = 1; subs = 0; 
        B1 = 32'd30; B2 = 32'd5; 
        #20;
        load = 0; subs = 1; 
        #20; 
        #20; 
        #20; 
        #20; 
        
        subs = 0;
        #20;
        $finish;
    end

    initial begin: TEST_CASE
        $dumpfile("Substrac_TB.vcd");
        $dumpvars(0, uut);
    end

endmodule