//Modulo de raiz cuadrada 

module Raiz_Cuadrada (
    input clk,
    input rst,        
    input [15:0] A,         
    input init,         
    output [15:0] Rf,    
    output done   
    
);
    wire resp_more_eq_op;
    wire resp_more_eq_rf;
    wire i_more_eq_n;
    wire a_eq_1;
    wire load;
    wire shift;
    wire sum;
    wire subs;
    wire assi;
    wire increase_i;
    wire IncI;
    wire Resp;
    wire Resp_corr;
    wire Resp1;
    wire Resp0;
    wire Rf;
    wire Rf_corr;
    wire Rf_corr1;
    wire Op;
    wire Op_out;
    wire A_i;

    Shift_Left u_Shift_Left_1(.clk(clk),.load(load),.B(Resp),.shift(shift),.B_corr(Resp_corr));
    Shift_Left u_Shift_Left_2(.clk(clk),.load(load),.B(Rf),.shift(shift),.B_corr(Rf_corr));
    Increase_I u_Increase_I(.clk(clk),.load(load),.increase(increase),.IncI(IncI));
    Sum u_Sum(.clk(clk),.load (load),.sum(sum),.B(Rf_corr),.S(Rf_corr1));
    Comp u_Comp_I_N(.a(),.b(),.igual(),.mayor(i_more_eq_n));
    Comp u_Comp_Resp_Rf(.a(Resp),.b(Rf),.igual(),.mayor(resp_more_eq_rf));
    Comp u_Comp_Resp_Op(.a(Resp),.b(Op),.igual(),.mayor(resp_more_eq_op));
    Comp u_Comp_A_1(.a(A_i),.b(1'b1),.igual(),.mayor(a_eq_1));
    Asign u_Asign_Op(.ar(Op),.i(1'b0),.bit(1'b0),.ar_out(Op_out));
    Asign u_Asign_Rf(.ar(Rf),.i(1'b0),.bit(1'b1),.ar_out(Op_out));
    Asign u_Asign_Resp1(.ar(Rf),.i(1'b1),.bit(A_i),.ar_out(Resp1));
    Asign u_Asign_Resp0(.ar(Rf),.i(1'b0),.bit(A_i),.ar_out(Resp0));
    Substrac u_Substrac_Op(.clk(clk),.load(load),.subs(subs),.B1(Resp),.B2(Op),.Subs());
    Substrac u_Substrac_Rf(.clk(clk),.load(load),.subs(subs),.B1(Resp),.B2(Rf),.Subs());












    
endmodule