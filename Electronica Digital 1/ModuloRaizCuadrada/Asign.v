//Modulo asigna otro valor al arreglo Resps

module Asign (
    input [15:0] ar,
    input [5:0] i,
    input bit,
    output reg [15:0] ar_out
);

    always @(*) begin

        ar_out = ar;
        ar_out[i]=bit;
    
    end


endmodule