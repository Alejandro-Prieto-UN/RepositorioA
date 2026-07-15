// Modulo de corrimiento a la izquierda
module Shift(
    input clk,
    input ld,
    input [23:0] RGB,
    input sh,
    output reg [23:0] corr 
);

  
    always @(negedge clk ) begin
        if (ld) begin
            corr <= RGB;       
        end 
        else if (sh) begin
            corr <= corr << 1; 
        end
       
    end

endmodule