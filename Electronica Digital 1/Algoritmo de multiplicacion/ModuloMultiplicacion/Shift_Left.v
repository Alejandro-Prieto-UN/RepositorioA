// Modulo de corrimiento a la izquierda
module Shift_Left (
    input clk,
    input load,
    input [15:0] B,
    input shift,
    output reg [15:0] B_corr 
);

  
    always @(negedge clk) begin
        if (load) begin
            B_corr <= B;       
        end 
        else if (shift) begin
            B_corr <= B_corr << 1; 
        end
       
    end

endmodule