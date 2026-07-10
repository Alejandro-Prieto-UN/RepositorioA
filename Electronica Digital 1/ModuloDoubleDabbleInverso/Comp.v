// Comparador de un digito BCD (4 bits) contra 8
module Comp (
    input  [3:0] a,
    output mayor      // 1 si a >= 8
);
    assign mayor = (a >= 4'd8);
endmodule
