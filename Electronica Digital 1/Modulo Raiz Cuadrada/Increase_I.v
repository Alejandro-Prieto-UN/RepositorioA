// Modulo de incremento I
module Increase_I (
    input clk,
    input load,         
    input increase,     
    output reg [15:0] IncI 
);

   
    always @(negedge clk) begin
        if (load) begin
            IncI <= 16'h0000;       
        end 
        else if (increase) begin
            IncI <= IncI + 3'd2;   
        end
    end

endmodule