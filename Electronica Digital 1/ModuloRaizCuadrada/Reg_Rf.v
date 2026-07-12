// Modulo del registro de la raiz (Rf)
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
