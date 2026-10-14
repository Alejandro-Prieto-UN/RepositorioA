// Modulo de incremento I
module Increase (
    input clk,
    input load,         
    input increase,     
    output reg [3:0] Inc 
);

   
    always @(negedge clk) begin
        if (load) begin
            Inc <= 4'h0;       
        end 
        else if (increase) begin
            Inc <= Inc + 1'b1;   
        end
    end

endmodule