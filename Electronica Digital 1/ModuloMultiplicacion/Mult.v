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
    wire [15:0] B_corr; 
    wire [3:0] Inc;   



    Shift u_Shift (.clk(clk),.load(load),.B(B),.shift(shift),.B_corr(B_corr));

    Sum u_Sum (.clk(clk),.load (load),.sum(sum),.B(B_corr),.S(S));


    Increase u_Increase (.clk(clk),.load(load),.increase(increase),.Inc(Inc));

    
    Multiplex u_Multiplex (.i(Inc),.A(A),.A_i(a_eq_1));

    
    Comp u_Comp (.i(Inc),.i_eq_n(i_eq_n));

   
    Control_Mult u_Control_Mult (.clk(clk),.rst(rst),.a_eq_1(a_eq_1),.i_eq_n(i_eq_n),.init(init)
    ,.done(done),.load(load),.sum(sum),.increase(increase),.shift(shift));

endmodule