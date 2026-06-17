// Modulo de incremento I
module Increase_I (
    input clk,
    input load,         
    input increase,     
    output reg [3:0] i 
);

   
    always @(negedge clk) begin
        if (load) begin
            i <= 4'h0;       
        end 
        else if (increase) begin
            i <= i + 1'b1;   
        end
    end

endmodule