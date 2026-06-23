// Modulo de restas sucesivas 
module Substrac (
    input clk,
    input load,         
    input subs,          
    input [31:0] B1,
    input [31:0] B2,
    output reg [31:0] arr_Subs 
);

    
    always @(negedge clk) begin
        if (load) begin
            arr_Subs <= B1; 
        end 
        else if (subs) begin
            arr_Subs <= arr_Subs - B2;          
        end
    end

endmodule