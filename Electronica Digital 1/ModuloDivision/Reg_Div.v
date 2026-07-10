/*Modulo que controla el registro de division hace el corrimiento , suma el complemento A2 (resta)
 y asigna un bit*/ 
 
module Reg_Div (
    input clk,
    input rst,
    input load,          
    input shift,         
    input subs,          
    input assi,          
    input [15:0] B,       
    input [15:0] CA2,     
    input min_a,          
    output reg [31:0] Q
);

    always @(negedge clk or posedge rst) begin
        if (rst) begin
            Q <= 32'd0;
        end
        else if (load) begin
            Q <= {16'b0, B};
        end
        else if (shift) begin
            Q <= Q << 1;
        end
        else if (subs) begin
            Q[31:16] <= Q[31:16] + CA2;
        end
        else if (assi) begin
            Q[0] <= ~min_a;
        end
    end

endmodule
