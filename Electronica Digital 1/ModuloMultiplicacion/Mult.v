// Modulo de multiplicacion 32 bits (Top-Level)
module Mult ( 
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
    wire increase;
    wire shift;
    wire reset;
    wire [15:0] B_corr; 
    wire [3:0]  i; 
    wire A_i;    
    wire [3:0]  IncI;   



    Shift_Left u_Shift_Left (.clk(clk),.load(load),.B(B),.shift(shift),.B_corr(B_corr));

    Sum u_Sum (.clk(clk),.load (load),.sum(sum),.B(B_corr),.S(S));


    Increase_I u_Increase_I (.clk(clk),.load(load),.increase(increase),.IncI(IncI));

    
    Multiplex u_Multiplex (.i(i),.A(A),.A_i(a_eq_1));

    
    Comp_Eq u_Comp_Eq (.a_i(IncI),.a_eq_1(i_eq_n));

   
    Control_Mult u_Control_Mult (.clk(clk),.rst(rst),.a_eq_1(a_eq_1),.i_eq_n(i_eq_n),.init(init)
    ,.done(done),.load(load),.sum(sum),.increase(increase),.shift(shift));

endmodule