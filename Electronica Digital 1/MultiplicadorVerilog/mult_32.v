
module mult_32(clk , rst , init , A , B , pp , done);

 input rst;
 input clk;
 input init;
 input [15:0] A;
 input [15:0] B;
 output [31:0] pp;
 output done;
 wire w_sh;
 wire w_reset;
 wire w_add;
 wire w_z;
 wire [31:0] w_A;
 wire [15:0] w_B;

 rsr rsr0 (.clk(clk), .in_B(B) , .shift(w_sh) , .load(w_reset) , .s_B(w_B));
 lsr lsr0 (.clk(clk), .in_A(A) , .shift(w_sh) , .load(w_reset) , .s_A(w_A));
 comp comp0(.B(w_B), .z(w_z));
 acc acc0 (.clk(clk), .A(w_A) , .add(w_add), .rst(w_reset), .pp(pp));
 control_mult control0 (.clk(clk), .rst(rst), .lsb_B(w_B[0]), .init(init), .z(w_z),
                        .done(done), .sh(w_sh), .reset(w_reset), .add(w_add));

endmodule


module rsr (clk, in_B , shift , load , s_B);
 input clk;
 input [15:0] in_B;
 input load;
 input shift;
 output reg [15:0] s_B;

 always @(negedge clk)
   if (load)
     s_B <= in_B;
   else if (shift)
     s_B <= s_B >> 1;
endmodule


module lsr (clk , in_A , shift , load , s_A);
 input clk;
 input [15:0] in_A;
 input load;
 input shift;
 output reg [31:0] s_A;

 always @(negedge clk)
   if (load)
     s_A <= {16'b0, in_A};  // Extiende a 32 bits
   else if (shift)
     s_A <= s_A << 1;
endmodule


module comp(B, z);
 input [15:0] B;
 output z;
 assign z = (B == 16'b0);
endmodule


module acc (clk , A, add, rst, pp);
 input clk;
 input [31:0] A;
 input add;
 input rst;
 output reg [31:0] pp;

 always @(negedge clk)
   if (rst)
     pp <= 32'd0;
   else if (add)
     pp <= pp + A;
endmodule


module control_mult( clk , rst , lsb_B , init , z , done , sh , reset , add );
 input clk;
 input rst;
 input lsb_B;
 input init;
 input z;       
 output reg done;
 output reg sh;
 output reg reset;
 output reg add;

 parameter IDLE  = 3'b000;
 parameter CHECK = 3'b001;
 parameter ADD   = 3'b010;
 parameter SHIFT = 3'b011;
 parameter DONE  = 3'b100;

 reg [2:0] state, next_state;
 reg [3:0] bit_count;   

 always @(posedge clk or posedge rst) begin
   if (rst) begin
     state <= IDLE;
     bit_count <= 4'd0;
   end else begin
     state <= next_state;
     if (state == SHIFT)
       bit_count <= bit_count + 1'b1;
     else if (state == IDLE)
       bit_count <= 4'd0;
   end
 end


 always @(*) begin
   next_state = state;
   case (state)
     IDLE:   if (init) next_state = CHECK;
             else      next_state = IDLE;
     CHECK:  if (lsb_B) next_state = ADD;
             else       next_state = SHIFT;
     ADD:    next_state = SHIFT;
     SHIFT:  if (bit_count == 4'd15) next_state = DONE;
             else                    next_state = CHECK;
     DONE:   next_state = IDLE;
     default: next_state = IDLE;
   endcase
 end


 always @(*) begin
   // Valores por defecto
   done = 1'b0;
   sh   = 1'b0;
   reset= 1'b0;
   add  = 1'b0;
   case (state)
     IDLE:   reset = 1'b1;      
     CHECK:  ;                  
     ADD:    add = 1'b1;
     SHIFT:  sh  = 1'b1;
     DONE:   done= 1'b1;
   endcase
 end

endmodule