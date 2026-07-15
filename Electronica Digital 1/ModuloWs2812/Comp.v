//Modulo que compara dos valores dependendiendo de lo que se requiera comparar
module Comp(
    input [15:0] a,
    input [15:0] b,
    output reg z
);

    always @(*) begin
        z = (a == b);
    end

endmodule