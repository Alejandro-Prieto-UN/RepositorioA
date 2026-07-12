// Modulo de top del algortimo Double Dabble inverso (BCD a Binario)
module DoubleDabble_Inverso (
    input clk,
    input rst,
    input init,
    input [3:0] a1,
    input [3:0] a2,
    input [3:0] a3,
    output [9:0] A,
    output done
);

    wire load;
    wire shift;
    wire subs;
    wire increase;
    wire i_eq_n;
    wire [11:0] bcd_reg;   
    wire [11:0] bcd_sub;   
    wire m_a1, m_a2, m_a3;

    Shift u_Shift (.clk(clk),.load(load),.shift(shift),.subs(subs),.update({m_a3, m_a2, m_a1}),.a1(a1),.a2(a2),.a3(a3),
    .in_bcd(bcd_sub),.arr_corr(bcd_reg),.A(A));

    Comp u_Comp_a1 (.a(bcd_reg[3:0]),.mayor(m_a1));
    Comp u_Comp_a2 (.a(bcd_reg[7:4]),.mayor(m_a2));
    Comp u_Comp_a3 (.a(bcd_reg[11:8]),.mayor(m_a3));

    Substrac u_Sub_a1 (.a(bcd_reg[3:0]),.S(bcd_sub[3:0]));
    Substrac u_Sub_a2 (.a(bcd_reg[7:4]),.S(bcd_sub[7:4]));
    Substrac u_Sub_a3 (.a(bcd_reg[11:8]),.S(bcd_sub[11:8]));

    Increase u_Increase (.clk(clk),.load(load),.increase(increase),.i_eq_n(i_eq_n));

    Control_DoubleDabble_Inverso u_Control (.clk(clk),.rst(rst),.init(init),
    .i_eq_n(i_eq_n),.load(load),.shift(shift),.subs(subs),.increase(increase),.done(done));

endmodule
