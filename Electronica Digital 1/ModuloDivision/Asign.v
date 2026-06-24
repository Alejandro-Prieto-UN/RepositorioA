//Modulo asigna otro valor al arreglo Cc que tiene el cociente de la division

module Asign (
    input [15:0] arr,
    input value,
    output reg [15:0] arr_out
);

    always @(*) begin
        arr_out = arr;
        arr_out[0]=~value; 
    end


endmodule