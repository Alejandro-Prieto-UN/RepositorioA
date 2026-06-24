// Modulo de sumatoria
module Sum (
    input clk,
    input load,
    input [15:0]a,         
    input sum,          
    input [15:0]b,
    output reg [31:0] S 
);

    
    always @(negedge clk) begin
        if (load) begin
            S <= a;    
        end 
        else if (sum) begin
            S <= S + b;          
        end
    end

endmodule