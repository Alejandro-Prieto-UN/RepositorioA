// Top del algoritmo DoubleDabble Inverso (BCD -> Binario).
// OJO: a diferencia de tu version anterior, aqui a1,a2,a3 son
// ENTRADAS (los 3 digitos BCD) y A es la SALIDA (el binario resultante).
// Esa era la inconsistencia real: un conversor BCD->binario no puede
// tener el binario como entrada.
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
    wire dec;
    wire Zero;
    wire [11:0] bcd_reg;   // {a3,a2,a1} actuales
    wire [11:0] bcd_sub;   // {a3,a2,a1} ya corregidos (-3)
    wire m_a1, m_a2, m_a3; // 1 si el digito correspondiente es >= 8

    Shift u_Shift (.clk(clk), .load(load), .shift(shift), .subs(subs),
                   .update({m_a3, m_a2, m_a1}), .a1(a1), .a2(a2), .a3(a3),
                   .in_bcd(bcd_sub), .arr_corr(bcd_reg), .A(A));

    // un Comp y un Substrac por digito, los 3 en paralelo cada ciclo
    Comp u_Comp_a1 (.a(bcd_reg[3:0]),   .mayor(m_a1));
    Comp u_Comp_a2 (.a(bcd_reg[7:4]),   .mayor(m_a2));
    Comp u_Comp_a3 (.a(bcd_reg[11:8]),  .mayor(m_a3));

    Substrac u_Sub_a1 (.a(bcd_reg[3:0]),  .S(bcd_sub[3:0]));
    Substrac u_Sub_a2 (.a(bcd_reg[7:4]),  .S(bcd_sub[7:4]));
    Substrac u_Sub_a3 (.a(bcd_reg[11:8]), .S(bcd_sub[11:8]));

    Increase u_Increase (.clk(clk), .rst(rst), .load(load), .dec(dec), .Zero(Zero));

    Control_DoubleDabble_Inverso u_Control (.clk(clk), .rst(rst), .init(init),
                          .Zero(Zero), .load(load), .shift(shift), .subs(subs),
                          .dec(dec), .done(done));

endmodule
