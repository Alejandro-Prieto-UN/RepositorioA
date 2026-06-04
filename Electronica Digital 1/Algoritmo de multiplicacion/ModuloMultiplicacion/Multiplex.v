// Modulo de multiplexor
module Multiplex (
    input [15:0] i,
    input [15:0] A,
    output reg A_i   
);

    always @(*) begin
        A_i = A[i];  
    end

endmodule