//Modulo asigna otro valor al arreglo Cc que tiene el cociente de la division

module Asign_Cc (
    input [15:0] Cc,
    input [5:0] i,
    input bit,
    output reg [15:0] Cc_out
);

    always @(*) begin
        Cc_out = Cc;
        Cc_out[i]=bit; 
    end


endmodule