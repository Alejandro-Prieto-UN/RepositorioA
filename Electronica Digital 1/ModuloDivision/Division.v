// Modulo de division
module Division ( 
    input clk,
    input rst,        
    input [15:0] A,     
    input [15:0] BCc,    
    input init,         
    output [15:0] Res,
    output [15:0] BCc_out,
    output done         
);

    wire i_eq_zero;
    wire res_min_a;
    wire [15:0]W_Res1;
    wire [15:0]W_Res2;
    wire [15:0]W_BCc;
    wire load;
    wire assi;
    wire subs;
    wire decrease;
    wire shift;
    wire [15:0]CA2;
    wire [5:0]i;  


    Shift u_Shift (.clk(clk),.load(load),.arr({W_Res1,BCc}),.shift(shift),.arr_corr({W_Res2,W_BCc}));
    Comp u_Comp_1(.a(W_Res2),.b(A),.igual(),.menor(res_min_a));
    Asign u_Asign_1(.arr(W_BCc),.value(res_min_a),.arr_out(BCc_out));
    Complement_A2 u_Complement_A2(.A(A),.CA2(CA2));

    Sum u_Substrac(.clk(clk),.load(load),.sum(subs),.x(W_Res2),.y(CA2),.S(Res));

    Decrease u_Decrease(.clk(clk),.load(load),.decrease(decrease),.i(i));
    Comp u_Comp_2(.a(i),.b(1'b0),.igual(i_eq_zero),.menor());
   
    Control_Div u_Control_Div(.clk(clk),.rst(rst),.init(init),.i_eq_zero(i_eq_zero),.res_min_a(res_min_a),
    .load(load),.assi(assi),.subs(subs),.decrease(decrease),.shift(shift),.done(done));

endmodule
