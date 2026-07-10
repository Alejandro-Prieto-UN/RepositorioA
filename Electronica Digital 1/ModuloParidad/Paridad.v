// Modulo de Paridad
module Paridad ( 
    input clk,
    input rst,        
    input [15:0] A,       
    input init,         
    output [4:0]Cont,    
    output done        
);
    wire a_eq_1;
    wire i_eq_n;
    wire cont_eq_zero; 
    wire load;
    wire sum;
    wire increase;
    wire [3:0] i;   

    Multiplex u_Multiplex (.i(i),.A(A),.A_i(a_eq_1));

    Sum u_Sum (.clk(clk),.load (load),.sum(sum),.B(a_eq_1),.S(Cont));


    Increase u_Increase (.clk(clk),.load(load),.increase(increase),.Inc(i));

    
    Comp u_Comp_cont_eq_zero (.i(Cont),.val(0),.ans(cont_eq_zero));
    
    Comp u_Comp_i_eq_n (.i(i),.val(3'd15),.ans(i_eq_n));

   
    Control_Paridad u_Control_Paridad(.clk(clk),.rst(rst),.cont_eq_zero(cont_eq_zero),.i_eq_n(i_eq_n),.a_eq_1(a_eq_1),
    .init(init),.done(done),.load(load),.sum(sum),.increase(increase));

endmodule
