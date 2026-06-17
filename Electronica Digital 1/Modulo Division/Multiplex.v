// Modulo de multiplexor
module Multiplex (
    input [15:0] i,
    input [15:0] arr,
    output reg arr_i   
);

    always @(*) begin
        arr_i = arr[15-i];  
    end

endmodule