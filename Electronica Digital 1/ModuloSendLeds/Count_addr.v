// Modulo de count
module Count_addr (
    input clk,
    input rst,         
    input inc,     
    output reg [15:0] count_addr 
);
    always @(negedge clk) begin
        if (rst) begin
            count_addr <= 16'h0;       
        end 
        else if (inc) begin
            count_addr <= count_addr + 1'b1;   
        end
    end

endmodule