// Modulo de corrimiento a la izquierda
module Shift(
    input clk,
    input load,
    input [31:0] arr,
    input shift,
    output reg [31:0] arr_corr 
);

  
    always @(negedge clk) begin
        if (load) begin
            arr_corr <= arr;       
        end 
        else if (shift) begin
            arr_corr <= arr_corr << 1; 
        end
       
    end

endmodule