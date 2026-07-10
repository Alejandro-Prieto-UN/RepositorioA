// Modulo de incremento I
module Decrease (
    input clk,
    input load,         
    input decrease,     
    output reg [5:0] i 
);

   
    always @(negedge clk) begin
        if (load) begin
            i <= 6'd8;         
        end 
        else if (decrease) begin
            i <= i - 1'b1;   
        end
    end

endmodule