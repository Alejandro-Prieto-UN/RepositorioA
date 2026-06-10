// Modulo que compara dos valores para saber si son iguales
module Comp_Eq (
    input [3:0]a_i,
    output reg a_eq_1 
);

    always @(*) begin
        if (a_i == 1)
          a_eq_1 = 1;
        else
        a_eq_1 = 0;
    end


endmodule