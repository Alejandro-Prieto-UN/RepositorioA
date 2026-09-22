`timescale 1ns / 1ps

module Secuencial_TB;
    reg clk;
    reg rst;
    reg start;
    reg [3:0] x;
    reg [4:0] a;
    reg way;
    wire [5:0] acc;
    wire done; 

    Secuencial uut (.clk(clk),.rst(rst),.start(start),.x(x),.a(a),
        .way(way),.acc(acc),.done(done));
    
    parameter PERIOD = 20;

    initial begin
        clk = 1'b0;
        forever #(PERIOD/2) clk = ~clk;
    end


    initial begin
        rst = 1; start = 0; x = 4'd2; a = 5'd3; way = 1'b0;
        #40;
        rst = 0;
        #20;
        start = 1; 
        #20;
        start = 0;
        
        #500;
        $finish;
    end

    initial begin
        $dumpfile("Secuencial_TB.vcd");
        $dumpvars(0, Secuencial_TB);
    end
endmodule