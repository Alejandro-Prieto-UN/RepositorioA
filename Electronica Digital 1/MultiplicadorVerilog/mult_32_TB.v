`timescale 1ns / 1ps
`define SIMULATION

module mult_32_TB;
 reg clk;
 reg rst;
 reg start;
 reg [15:0] in_A;
 reg [15:0] in_B;
 wire [31:0] pp;
 wire done;

 mult_32 uut (.clk(clk), .rst(rst), .init(start), .A(in_A), .B(in_B), .pp(pp), .done(done));

 parameter PERIOD = 20;
 parameter real DUTY_CYCLE = 0.5;
 parameter OFFSET = 0;

 event reset_trigger;
 event reset_done_trigger;

 initial begin
   forever begin
     @(reset_trigger);
     @(negedge clk);
     rst = 1;
     @(negedge clk);
     rst = 0;
     -> reset_done_trigger;
   end
 end

 initial begin
   clk = 0;
   start = 0;
   in_A = 16'h0005;
   in_B = 16'h0003;
 end


 initial begin
   #OFFSET;
   forever begin
     clk = 1'b0;
     #(PERIOD - (PERIOD * DUTY_CYCLE));
     clk = 1'b1;
     #(PERIOD * DUTY_CYCLE);
   end
 end

 initial begin
   #10 -> reset_trigger;
   @(reset_done_trigger);
   @(posedge clk);
   start = 0;
   @(posedge clk);
   start = 1;
   repeat(2) @(posedge clk);
   start = 0;

   repeat(20) @(posedge clk);
   $display("Resultado: %d x %d = %d", in_A, in_B, pp);
   #100;
   $finish;
 end

 initial begin
   $dumpfile("mult_32_TB.vcd");
   $dumpvars(-1, uut);
   #((PERIOD * DUTY_CYCLE) * 200) $finish;
 end

endmodule