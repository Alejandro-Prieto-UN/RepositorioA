// Modulo de multiplexor
module Multiplex (
    input [15:0] T0h,
    input [15:0] T1h,
    input [15:0]Res,
    input [15:0] Per,
    input[1:0]sel_tim,
    output reg [15:0] out   
);

    always @(*) begin
        case(sel_tim)
        2'b00: out =T0h;
        2'b01: out =T1h;
        2'b10: out =Res;
        2'b11: out =Per;
        default: out = T0h;
        endcase
    end

endmodule