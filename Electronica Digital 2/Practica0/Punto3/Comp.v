// Modulo que compara dos valores para saber si son iguales
module Comp(
    input [3:0]i,
    output reg i_eq_n 
);

    always @(*) begin
        if (i == 15)
          i_eq_n = 1;
        else
          i_eq_n = 0;
    end


endmodule