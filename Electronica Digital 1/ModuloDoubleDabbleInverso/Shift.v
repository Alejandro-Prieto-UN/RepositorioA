// Registro de desplazamiento para BCD -> Binario.
// Carga los 3 digitos BCD en la parte alta y 0 en la parte baja
// (que ira acumulando el resultado binario). En cada "shift" se
// desplaza TODO a la derecha; en cada "subs" se corrige (-3) a los
// digitos que lo necesiten, LOS 3 EN PARALELO segun "update".
module Shift(
    input clk,
    input load,
    input shift,
    input subs,
    input [2:0] update,      // update[2]->a3, update[1]->a2, update[0]->a1
    input [3:0] a1,
    input [3:0] a2,
    input [3:0] a3,
    input [11:0] in_bcd,      // {a3,a2,a1} ya corregidos (-3)
    output [11:0] arr_corr,    // {a3,a2,a1} actuales (para Comp/Substrac)
    output [9:0]  A            // resultado binario (valido cuando done=1)
);
    reg [21:0] alldata;         // {a3(4), a2(4), a1(4), binario(10)}
    assign arr_corr = alldata[21:10];
    assign A = alldata[9:0];

    always @(posedge clk) begin
        if (load) begin
            alldata[21:10] <= {a3, a2, a1};
            alldata[9:0]   <= 10'b0;
        end
        else if (shift) begin
            alldata <= alldata >> 1;
        end
        else if (subs) begin
            if (update[2]) alldata[21:18] <= in_bcd[11:8];   // a3
            if (update[1]) alldata[17:14] <= in_bcd[7:4];    // a2
            if (update[0]) alldata[13:10] <= in_bcd[3:0];    // a1
        end
    end
endmodule
