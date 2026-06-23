// Modulo de sumatoria
module Sum (
    input clk,
    input load,
    input [15:0]x,         
    input sum,          
    input [15:0] y,
    output reg [31:0] S 
);

    
    always @(negedge clk) begin
        if (load) begin
            S <= 32'h00000000;
            S <= x;    
        end 
        else if (sum) begin
            S <= S + y;          
        end
    end

endmodule