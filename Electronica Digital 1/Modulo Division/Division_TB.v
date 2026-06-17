// Modulo de prueba del divisor
`timescale 1ns / 1ps

module Division_TB;
    
    reg clk;
    reg rst;        
    reg [15:0] A;     
    reg [15:0] B;    
    reg init;
    wire [15:0] Res;
    wire [15:0] Cc;    
    wire done; 
  
    Division uut (.clk(clk),.rst(rst),.A(A),.B(B),.init(init),.Res(Res),.Cc(Cc),.done(done));

    parameter PERIOD          = 20;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET          = 0;
    reg [20:0] i;
    event reset_trigger;
    event reset_done_trigger;
 

    initial begin  
      clk = 0; rst = 1; init = 0; A = 16'd122; B = 16'd12;
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
     $dumpfile("Division_TB.vcd");
     $dumpvars(-1, uut);
     #(100000) $finish;
   end

endmodule