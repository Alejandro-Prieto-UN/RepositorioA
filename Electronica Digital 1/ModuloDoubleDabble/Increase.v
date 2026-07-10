// Contador de iteraciones del algoritmo.
// Antes contaba HACIA ARRIBA y se comparaba contra una constante (16)
// usando el modulo Comp de 16 bits -- con un contador de 4 bits eso
// nunca llegaba a coincidir y el algoritmo se quedaba pegado.
// Ahora cuenta HACIA ABAJO desde 10 (numero de bits de A) y expone
// directamente la bandera "Zero" cuando termina.
module Increase (
    input clk,
    input load,
    input increase,          // antes "increase"; ahora decrementa
    output i_eq_n
);
     // 10 desplazamientos, uno por bit de A[9:0]
    reg [4:0] i;
    assign i_eq_n = (i == 4'd10);

    always @(posedge clk) begin
        if (load)
            i <= 4'd0;
        else if (increase)
            i <= i + 1'b1;
    end
endmodule
