// Modulo de incremento I
module Increase_I (
    input clk,
    input load,         
    input increase,     
    output reg [3:0] IncI 
);

   
    always @(negedge clk) begin
        if (load) begin
            IncI <= 4'h0;       
        end 
        else if (increase) begin
            IncI <= IncI + 1'b1;   
        end
    end

endmodule