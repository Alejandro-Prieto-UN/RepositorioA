// Modulo que recibe un valor y le suma 3 en decimal
module Sum (
    input  [3:0] a,
    output [3:0] S
);
    assign S = a + 4'd3;
endmodule
