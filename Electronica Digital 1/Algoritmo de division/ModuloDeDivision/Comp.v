//Modulo que compara dos valores dependendiendo de lo que se requiera comparar

module Comp(
    input[5:0] a,
    input [5:0] b,
    output reg igual,
    output reg mayor
);

    always @(*) begin
        igual = (a == b);
        mayor = (a>b); 
    end


endmodule