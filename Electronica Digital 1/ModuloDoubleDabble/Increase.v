//Modulo del incrementador 
module Increase (
    input clk,
    input load,
    input increase,          
    output i_eq_n
);
    reg [4:0] i;
    assign i_eq_n = (i == 4'd10);

    always @(posedge clk) begin
        if (load)
            i <= 4'd0;
        else if (increase)
            i <= i + 1'b1;
    end
endmodule
