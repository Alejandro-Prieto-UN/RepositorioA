// Registro de la raiz (Rf).
//  - load : reinicia Rf a 0
//  - assi : corre 1 bit a la izquierda E inserta el nuevo bit en un solo paso
//           (Rf <= {Rf[12:0], value}). Asi "Op = {Rf,01}" siempre usa el Rf
//           tal como quedo en la iteracion anterior, sin corrimiento previo.
module Reg_Rf (
    input clk,
    input rst,
    input load,
    input assi,
    input value,
    output reg [13:0] Rf
);

    always @(negedge clk or posedge rst) begin
        if (rst) begin
            Rf <= 14'd0;
        end
        else if (load) begin
            Rf <= 14'd0;
        end
        else if (assi) begin
            Rf <= {Rf[12:0], value};
        end
    end

endmodule
