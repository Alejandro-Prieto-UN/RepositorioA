// Modulo de top del algortimo Double Dabble (Binario a BCD)
module DoubleDabble (
    input clk,
    input rst,
    input [9:0] A,
    input init,
    output [3:0] a1,
    output [3:0] a2,
    output [3:0] a3,
    output done
);

    wire load;
    wire shift;
    wire sum;
    wire increase;
    wire i_eq_n;
    wire [11:0] bcd_reg;    
    wire [11:0] bcd_add;    
    wire m_a1, m_a2, m_a3;  

    Shift u_Shift (.clk(clk), .load(load), .shift(shift),.sum(sum),.update({m_a3, m_a2, m_a1}),.A(A),.in_bcd(bcd_add),.arr_corr(bcd_reg));

    Comp u_Comp_a1 (.a(bcd_reg[3:0]),.mayor(m_a1));
    Comp u_Comp_a2 (.a(bcd_reg[7:4]),.mayor(m_a2));
    Comp u_Comp_a3 (.a(bcd_reg[11:8]),.mayor(m_a3));

    Sum u_Sum_a1 (.a(bcd_reg[3:0]),.S(bcd_add[3:0]));
    Sum u_Sum_a2 (.a(bcd_reg[7:4]),.S(bcd_add[7:4]));
    Sum u_Sum_a3 (.a(bcd_reg[11:8]),.S(bcd_add[11:8]));

    Increase u_Increase (.clk(clk),.load(load),.increase(increase),.i_eq_n(i_eq_n));

    Control_DoubleDabble u_Control_DoubleDabble (.clk(clk),.rst(rst),.init(init),.i_eq_n(i_eq_n),.load(load),.shift(shift), 
    .sum(sum),.increase(increase), .done(done));

    assign a1 = bcd_reg[3:0];
    assign a2 = bcd_reg[7:4];
    assign a3 = bcd_reg[11:8];

endmodule
