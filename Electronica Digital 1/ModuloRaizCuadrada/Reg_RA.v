// Registro combinado Resp:A (32 bits).
//  - load : carga A en la mitad baja, Resp en 0
//  - shift: corre 2 bits a la izquierda (se procesan 2 bits de A por iteracion)
//  - subs : resta el divisor de prueba Op de la mitad alta (Resp)
module Reg_RA (
    input clk,
    input rst,
    input load,
    input shift,
    input subs,
    input [15:0] A,
    input [15:0] Op,
    output reg [31:0] RA
);

    always @(negedge clk or posedge rst) begin
        if (rst) begin
            RA <= 32'd0;
        end
        else if (load) begin
            RA <= {16'd0, A};
        end
        else if (shift) begin
            RA <= RA << 2;
        end
        else if (subs) begin
            RA[31:16] <= RA[31:16] - Op;
        end
    end

endmodule
