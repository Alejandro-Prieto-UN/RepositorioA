// Modulo de multiplexor
module Multiplex (
    input [15:0] i,
    input [15:0] ar,
    output reg ar_i   
);

    always @(*) begin
        ar_i = ar[15-i];  
    end

endmodule