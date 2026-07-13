//Modulo de la raiz cuadrada 
module Raiz_Cuadrada (
    input clk,
    input rst,        
    input [15:0] A,         
    input init,         
    output [13:0] Rf,    
    output done   
);

    wire resp_eq_op;
    wire resp_more_op;
    wire resp_more_eq_op;
    wire i_eq_zero;
    wire load;
    wire shift;     
    wire subs;
    wire assi;
    wire root_bit;
    wire decrease;
    wire [5:0]  i;
    wire [31:0] RA;
    wire [15:0] Op = {Rf, 2'b01};   

    Comp u_Comp_1(.a(RA[31:16]), .b(Op), .igual(resp_eq_op), .mayor(resp_more_op));
    assign resp_more_eq_op = resp_eq_op | resp_more_op;  

    Comp u_Comp_2(.a(i), .b(16'd0), .igual(i_eq_zero), .mayor());

    Decrease u_Decrease(.clk(clk), .load(load), .decrease(decrease), .i(i));

    Reg_RA u_Reg_RA(.clk(clk), .rst(rst), .load(load), .shift(shift), .subs(subs), .A(A), .Op(Op), .RA(RA));

    Reg_Rf u_Reg_Rf(.clk(clk), .rst(rst), .load(load), .assi(assi), .value(root_bit), .Rf(Rf));

    Control_RaizCuadrada u_Control_RaizCuadrada (.clk(clk),.rst(rst),.i_eq_zero(i_eq_zero),.resp_more_eq_op(resp_more_eq_op),.init(init),.load(load),
    .assi(assi),.root_bit(root_bit),.subs(subs),.decrease(decrease), .shift(shift), .done(done));

endmodule