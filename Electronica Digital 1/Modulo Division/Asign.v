//Modulo asigna otro valor al arreglo Cc que tiene el cociente de la division

module Asign (
    input [15:0] arr,
    input [5:0] i,
    input bit,
    output reg [15:0] arr_out
);

    always @(*) begin
        arr_out = arr;
        arr_out[i]=bit; 
    end


endmodule