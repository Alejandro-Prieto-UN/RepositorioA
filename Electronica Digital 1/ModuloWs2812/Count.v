// Modulo de count
module Count(
    input clk,
    input ld,         
    input dec,     
    output reg [15:0] z
);

   
    always @(negedge clk) begin
        if (ld) begin
            z <= 16'h0;       
        end 
        else if (dec) begin
            z <= z - 1'b1;   
        end
    end

endmodule