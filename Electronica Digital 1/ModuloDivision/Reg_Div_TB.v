//MOdulo de prueba del modulo Reg_Div
`timescale 1ns / 1ps

module Reg_Div_TB;
    reg clk;
    reg rst;
    reg load;          
    reg shift;         
    reg subs;          
    reg assi;          
    reg [15:0] B;       
    reg [15:0] CA2;     
    reg min_a;          
    wire [31:0] Q;

    Reg_Div uut (.clk(clk),.rst(rst),.load(load),.shift(shift),.subs(subs),.assi(assi),.B(B),.CA2(CA2),.min_a(min_a),.Q(Q));

    parameter PERIOD = 20;

    initial begin
        clk = 0;
        forever #(PERIOD/2) clk = ~clk;
    end

    initial begin
        rst = 1;
        load = 0;
        shift = 0;
        subs = 0;
        assi = 0;
        B = 16'd0;
        CA2 = 16'd0;
        min_a = 0;

        #25; 
        rst = 0;

        @(posedge clk);
        load = 1;
        B = 16'h00FF; 
        @(posedge clk);
        load = 0;     

        @(posedge clk);
        shift = 1;
        @(posedge clk);
        shift = 0;

        @(posedge clk);
        subs = 1;
        CA2 = 16'h0005; 
        @(posedge clk);
        subs = 0;

        @(posedge clk);
        assi = 1;
        min_a = 0; 
        @(posedge clk);
        assi = 0;

        #(PERIOD * 3);
        $finish;
    end

    initial begin: TEST_CASE
        $dumpfile("Reg_Div_TB.vcd");
        $dumpvars(-1, uut);
    end

endmodule
