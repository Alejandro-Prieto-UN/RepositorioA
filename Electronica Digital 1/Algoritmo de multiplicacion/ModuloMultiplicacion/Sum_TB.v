// Modulo de prueba si las sumatorias 
`timescale 1ns / 1ps

module Sum_TB;
    reg clk;
    reg load;         
    reg sum;         
    reg [31:0] B;
    wire [31:0] S;
    
  
    Sum uut (.clk(clk),.load(load),.sum(sum),.B(B),.S(S));
    
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
        sum=0; 
        B= 32'd0;
        #20
        load=1; 
        sum=0; 
        B= 32'd10;
        #20
        load=0; 
        sum=1; 
        B= 32'd10;
        #20
        sum=1; 
        B= 32'd20;
        #20
        sum=0; 
        B= 32'd20;
        #20 
        sum=1; 
        B= 32'd30;
        #20
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Sum_TB.vcd");
     $dumpvars(-1, uut);
   end

endmodule