// Modulo de division
module Division ( 
    input clk,
    input rst,        
    input [15:0] A,     
    input [15:0] B,    
    input init,         
    output [15:0] Res,
    output [15:0]  Cc,
    output done        
);

    wire res_eq_1;
    wire i_more_n; 
    wire load;
    wire assi;
    wire sum;
    wire increase;
    wire shift;
    wire reset;
    wire [15:0] Res_corr;
    wire [15:0] Res_out;
    wire [5:0]  i; 
    wire B_i;
    wire [15:0]CA2;  
    wire Cc_i;
    wire Cc_out;

    Asign u_Asign_1(.arr(Res),.i(0),.bit(B[15]),.arr_out(Res_out_1));
    Complement_A2 u_Complement_A2(.A(A),.CA2(CA2));
    Sum u_Sum_1(.clk(clk),.load(load),.sum(sum),.x(Res_out_1),.y(CA),.S(Res_out_2));
    Comp u_Comp_1(.a(Res[15]),.b(1'b1),.igual(res_eq_1),.mayor());

    Asign u_Asign_2(.arr(Cc),.i(15-i),.bit(B[15]),.arr_out());
    Sum u_Sum_2(.clk(clk),.load(load),.sum(sum),.x(Res_out_2),.y(A),.S(Res_out_3));

    Asign u_Asign_3(.arr(Cc),.i(15-i),.bit(res_eq_1),.arr_out(Cc_out));
    Increase_I u_Increase_I(.clk(clk),.load(load),.increase(increase),.i(i));
    Comp u_Comp_2(.a(i),.b(5'd16),.igual(),.mayor(i_more_n));
    
    
    Shift_Left u_Shift_Left(.clk(clk),.load(load),.arr(Res),.shift(shift),.arr_corr(Res_corr));
    
    Multiplex u_Multiplex_B(.i(i),.arr(B),.arr_i(B_i));
    Multiplex u_Multiplex_CC(.i(i),.arr(Cc),.arr_i(Cc_i));
  
    Asign u_Asign_4(.arr(Cc),.i(i),.bit(res_eq_1),.arr_out(Cc_out));

    Control_Div u_Control_Div(.clk(clk),.rst(rst),.init(init),.res_eq_1(res_eq_1),
    .i_more_n(i_more_n),.load(load),.assi(assi),.sum(sum),.increase(increase),.shift(shift),
    .done(done));

endmodule
