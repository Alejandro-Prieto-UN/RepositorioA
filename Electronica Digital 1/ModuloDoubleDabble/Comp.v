// Modulo que compara un valor con 5 en decimal 
module Comp (
    input  [3:0] a,
    output mayor     
);
    assign mayor = (a >= 4'd5);

endmodule
