// Modulo de prueba del algoritmo double dabble 
`timescale 1ns / 1ps

module DoubleDabble_TB;
    
    reg clk;
    reg rst;        
    reg [15:0] A;        
    reg init;         
    wire [3:0] a1;
    wire [3:0] a2;
    wire [3:0] a3;    
    wire done;  
  
    DoubleDabble uut (.clk(clk),.rst(rst),.A(A),.init(init),.a1(a1),.a2(a2),.a3(a3),.done(done));

    parameter PERIOD          = 20;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET          = 0;
    reg [20:0] i;
    event reset_trigger;
    event reset_done_trigger;
 

    initial begin  
      clk = 0; rst = 1; init = 0; A = 10'd399;
    end

    initial begin 
	  forever begin 
	   @ (reset_trigger);
		@ (negedge clk);
		rst = 1;
		@ (negedge clk);
		rst = 0;
		-> reset_done_trigger;
		end
	end

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
        #10 -> reset_trigger;
        @ (reset_done_trigger);
        @ (posedge clk);
        init = 0;
        @ (posedge clk);
        init = 1;
        
        for(i=0; i<2; i=i+1) begin
         @ (posedge clk);
        end

          init = 0;
          
        for(i=0; i<17; i=i+1) begin
         @ (posedge clk);
        end

   end	

    initial begin: TEST_CASE
     $dumpfile("DoubleDabble_TB.vcd");
     $dumpvars(-1, uut);
     #(100000) $finish;
   end

endmodule