// Modulo de correccion: suma 3 a un digito BCD
// (antes mezclaba la comparacion y la suma en un solo modulo con
//  puertos de 16/32 bits que no correspondian al ancho real de un digito;
//  ahora solo suma, y Comp.v decide si aplicar el resultado)
module Sum (
    input  [3:0] a,
    output [3:0] S
);
    assign S = a + 4'd3;
endmodule
