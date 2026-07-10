//Modulo Top del algoritmo de division
module Division ( 
    input clk,
    input rst,        
    input [15:0] A,     
    input [15:0] B,     
    input init,         
    output [15:0] Res, 
    output [15:0] Cc,   
    output done         
);

    wire i_eq_zero;
    wire reg_div_min_a;
    wire load;
    wire assi;
    wire subs;
    wire decrease;
    wire shift;
    wire [15:0] CA2;
    wire [31:0] Reg_Div;
    wire [5:0]  i;

    Comp u_Comp_1(.a(Reg_Div[31:16]),.b(A),.igual(),.menor(reg_div_min_a));

    Complement_A2 u_Complement_A2(.A(A),.CA2(CA2));

    Decrease u_Decrease(.clk(clk),.load(load),.decrease(decrease),.i(i));

    Comp u_Comp_2(.a(i), .b(16'd0), .igual(i_eq_zero), .menor());

    Reg_Div u_Reg_Div(.clk(clk),.rst(rst),.load(load),.shift(shift),.subs(subs),.assi(assi)
    ,.B(B),.CA2(CA2),.min_a(reg_div_min_a),.Q(Reg_Div));

    Control_Div u_Control_Div(.clk(clk),.rst(rst),.init(init),.i_eq_zero(i_eq_zero),.reg_div_min_a(reg_div_min_a),.
    load(load),.assi(assi),.subs(subs),.decrease(decrease),.shift(shift),.done(done));

    assign Res = Reg_Div[31:16];
    assign Cc  = Reg_Div[15:0];

endmodule
