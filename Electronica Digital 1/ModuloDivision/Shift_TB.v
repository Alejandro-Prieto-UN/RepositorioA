// Modulo de prueba del corrimiento
`timescale 1ns / 1ps

module Shift_TB;

    reg clk;
    reg load;
    reg [31:0] B;
    reg shift;
    wire [31:0] B_corr;
    
  
    Shift_Left uut (.clk(clk),.load(load),.B(B),.shift(shift),. B_corr(B_corr));
    
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
        shift=0; 
        B= 32'd0;
        #20
        load=1; 
        shift=0; 
        B= 32'd20;
        #20
        load=0; 
        shift=1; 
        #20
        shift=0;  
        #20
        shift=1; 
        #20 
        shift=0; 
        #20
        shift=1; 
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Shift_TB.vcd");
     $dumpvars(-1, uut);
   end

endmodule