// Modulo de multiplicacion 32 bits (Top-Level)
module Mult_32 ( 
    input clk,
    input rst,        
    input [15:0] A,     
    input [15:0] B,    
    input init,         
    output [31:0] S,    
    output done        
);

    wire a_eq_1;
    wire i_eq_n; 
    wire load;
    wire sum;
    wire increase_i;
    wire shift;
    wire reset;
    wire [15:0] B_corr; 
    wire [3:0]  i_count; 
    wire A_i_bit;       



    Shift_Left u_Shift_Left (.clk(clk),.load(load),.B(B),.shift(shift),.B_corr(B_corr));

    Sum u_Sum (.clk(clk),.load (load),.sum(sum),.B({16'b0, B_corr}),.S(S));


    Increase_I u_Increase_I (.clk(clk),.load(load),.increase (increase_i),.IncI(i_count));

    
    Multiplex u_Multiplex (.i(i_count),.A(A),.A_i(A_i_bit));

    
    Comp_Eq u_Comp_Eq (.a_i(A_i_bit),.a_eq_1(a_eq_1));

   
    Control_Mult u_Control_Mult (.clk(clk),.rst(rst),.a_eq_1(a_eq_1),.i_eq_n(i_eq_n),.init(init)
    ,.done(done),.load(load),.sum(sum),.increase_i(increase_i),.shift(shift),.reset(reset));

endmodule