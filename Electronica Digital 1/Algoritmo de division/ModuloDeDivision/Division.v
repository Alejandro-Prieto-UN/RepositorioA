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
    wire increase_i;
    wire shift;
    wire reset;
    wire [15:0] Res_corr; 
    wire [5:0]  i; 
    wire B_i;
    wire IncI;
    wire [15:0]CA2;  
    wire Cc_i;
    wire Cc_out;



    Comp u_Comp_1(.a(16'd16),.b(bit1),.igual(res_eq_1),.mayor());
    Comp u_Comp_2(.a(i),.b(n),.igual(),.mayor(i_more_n));
    Shift_Left u_Shift_Left(.clk(clk),.load(load),.B(B),.shift(shift),.Res_corr(Res_corr));
    Complement_A2 u_Complement_A2(.A(A),.CA2(CA2));
    Multiplex u_Multiplex_B(.i(i),.ar(B),.ar_i(B_i));
    Multiplex u_Multiplex_Res(.i(i),.ar(Cc),.ar_i(Cc_i));
    Increase_I u_Increase_I(.clk(clk),.load(load),.increase_i(increase_i),.IncI(IncI));
    Asign_Cc u_Asign_Cc_0(.Cc(Cc),.i(i),.bit(1),.Cc_out(Cc_out));
    Asign_Cc u_Asign_Cc_1(.Cc(Cc),.i(i),.bit(0),.Cc_out(Cc_out));
    Control_Div u_Control_Dic(.clk(clk),.rst(rst),.init(init),.load(load),.assi(assi)
    ,.sum(sum),.increase_i(increase_i),.shift(shift),.done(done),.res_eq_1(res_eq_1),
    .i_more_n(i_more_n));

endmodule
