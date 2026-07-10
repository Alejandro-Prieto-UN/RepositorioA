// Modulo que compara un valor para saber si es igual o mayor a 8
module Comp (
    input  [3:0] a,
    output mayor      
);
    assign mayor = (a >= 4'd8);
endmodule
