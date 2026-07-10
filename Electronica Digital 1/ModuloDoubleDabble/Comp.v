// Modulo comparador de un digito BCD contra 5
// (antes comparaba dos valores de 16 bits para dos cosas distintas:
//  el chequeo de correccion y el conteo de iteraciones; ahora solo
//  hace el chequeo de correccion, y el conteo lo hace Increase.v)
module Comp (
    input  [3:0] a,
    output mayor     // 1 si a >= 5
);
    assign mayor = (a >= 4'd5);

endmodule
