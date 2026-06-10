// Modulo de sumatoria
module Sum (
    input clk,
    input load,         
    input sum,          
    input [15:0] B,
    output reg [31:0] S 
);

    
    always @(negedge clk) begin
        if (load) begin
            S <= 32'h00000000;    
        end 
        else if (sum) begin
            S <= S + B;          
        end
    end

endmodule