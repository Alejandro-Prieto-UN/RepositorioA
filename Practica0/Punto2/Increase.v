// Modulo de incremento I
module Increase (
    input clk,
    input rst,         
    input inc,     
    output reg [5:0] i 
);

   
    always @(negedge clk) begin
        if (rst) begin
            i <= 6'b0;         
        end 
        else if (inc) begin
            i <= i + 1'b1;   
        end
    end

endmodule