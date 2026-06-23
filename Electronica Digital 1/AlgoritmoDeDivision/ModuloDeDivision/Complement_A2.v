// Modulo que devuelve el complemento a2 de un numero
module Complement_A2 (
    input [15:0] A,
    output  reg [15:0] CA2   
);

    always @(*) begin
        CA2 = (~A) + 1'b1;  
    end

endmodule