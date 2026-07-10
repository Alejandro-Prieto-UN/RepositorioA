// Modulo que compara dos valores para saber si son iguales
module Comp (
    input [3:0]i,
    input [3:0]val,
    output reg ans 
);

    always @(*) begin
        if (i == val)
          ans = 1;
        else
          ans = 0;
    end


endmodule
