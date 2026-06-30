// Modulo de division
module Division ( 
    input clk,
    input rst,        
    input [15:0] A,     
    input [15:0] B,    
    input init,         
    output [15:0] Res,
    output [31:0] Cc,
    output done         
);
    
    wire i_eq_zero;
    wire reg_div_min_a;
    wire load;
    wire assi;
    wire subs;
    wire decrease;
    wire shift;
    wire [15:0]CA2;
    wire [31:0]Reg_Div;
    wire [5:0]i;

  

    Shift u_Shift (.clk(clk),.load(load),.arr({16'b0,B}),.shift(shift),.arr_corr(Reg_Div));
    Comp u_Comp_1(.a(Reg_Div[31:16]),.b(A),.igual(),.menor(reg_div_min_a));
    Asign u_Asign(.arr(Reg_Div),.value(reg_div_min_a),.assi(assi),.arr_out(Reg_Div));
    Complement_A2 u_Complement_A2(.A(A),.CA2(CA2));

    Sum u_Substrac(.clk(clk),.load(load),.sum(subs),.a(Reg_Div[31:16]),.b(CA2),.S(Reg_Div[31:16]));

    Decrease u_Decrease(.clk(clk),.load(load),.decrease(decrease),.i(i));
    Comp u_Comp_2(.a(i),.b(1'b0),.igual(i_eq_zero),.menor());
   
    Control_Div u_Control_Div(.clk(clk),.rst(rst),.init(init),.i_eq_zero(i_eq_zero),.reg_div_min_a(reg_div_min_a),
    .load(load),.assi(assi),.subs(subs),.decrease(decrease),.shift(shift),.done(done));

endmodule
