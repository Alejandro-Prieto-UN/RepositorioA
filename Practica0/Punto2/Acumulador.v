// Modulo de sumatoria
module Acumulador (
    input clk,
    input rst,         
    input add,          
    input [3:0] x,
    input [4:0] a,
    input [5:0] i,
    input way,
    output reg [5:0] acc 
);

    
    always @(negedge clk) begin

        if(rst) begin
            acc=6'd0;
        end
        
        else if(way==1'b0) begin
            
            if (i<a && add)begin
                
                acc=acc+x;

            end
        end
        else if(way==1'b1) begin
            
            if (acc<6'd20 && add)begin
                
                acc=acc+x;

                end
            end 
        end

endmodule