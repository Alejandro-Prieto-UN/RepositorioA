// Modulo que compara dos valores para saber si son iguales
module Comp_Eq (
    input a_i,
    output reg a_eq_1 
);

    always @(*) begin
        a_eq_1 = (a_i == 1'b1); 
    end


endmodule