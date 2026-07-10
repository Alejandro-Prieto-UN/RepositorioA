// Contador de iteraciones (cuenta hacia abajo desde 10, uno por bit de A)
module Increase (
    input clk,
    input rst,
    input load,
    input dec,
    output Zero
);
    parameter N = 10;
    reg [4:0] count;
    assign Zero = (count == 0);

    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 5'd0;
        else if (load)
            count <= N[4:0];
        else if (dec)
            count <= count - 1'b1;
    end
endmodule
