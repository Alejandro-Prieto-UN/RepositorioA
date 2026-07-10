// Registro de desplazamiento + correccion BCD
// Contiene {a3, a2, a1, A} en un solo registro interno de 22 bits.
// "load" carga A; "shift" desplaza todo 1 bit; "add" aplica la
// correccion +3 a los 3 digitos EN PARALELO (cada uno controlado
// por su propio bit de "update", que viene de los 3 Comp externos).
module Shift(
    input clk,
    input load,
    input shift,
    input sum,
    input [2:0] update,        // update[2]->a3, update[1]->a2, update[0]->a1
    input [9:0] A,
    input [11:0] in_bcd,        // {a3,a2,a1} ya corregidos (+3)
    output [11:0] arr_corr       // {a3,a2,a1} actuales
);
    reg [21:0] alldata;          // {a3(4), a2(4), a1(4), A(10)}
    assign arr_corr = alldata[21:10];

    always @(posedge clk) begin
        if (load) begin
            alldata[21:10] <= 12'b0;
            alldata[9:0]   <= A;
        end
        else if (shift) begin
            alldata <= alldata << 1;
        end
        else if (sum) begin
            if (update[2]) alldata[21:18] <= in_bcd[11:8];   // a3
            if (update[1]) alldata[17:14] <= in_bcd[7:4];    // a2
            if (update[0]) alldata[13:10] <= in_bcd[3:0];    // a1
        end
    end
endmodule
