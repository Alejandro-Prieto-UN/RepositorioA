module Top (
    input [3:0] Sw,
    input [3:0] BTN,
    input clk,
    output reg [3:0] LED,
    output reg [2:0] LED_RGB
);

reg [1:0] Operacion = 2'b00;
reg [3:0] G_A = 4'b0000;
reg [3:0] G_B = 4'b0000;
wire [3:0] OP;
reg [3:0] BTN_prev = 4'b0000;

always @(posedge clk) begin
    BTN_prev <= BTN; 
    if (BTN[0] && !BTN_prev[0]) begin
        G_A <= Sw;
    end
    if (BTN[1] && !BTN_prev[1]) begin
        G_B <= Sw;
    end

if (BTN[2] && !BTN_prev[2]) begin
        Operacion[0] <= ~Operacion[0];
    end

    if (BTN[3] && !BTN_prev[3]) begin
        Operacion[1] <= ~Operacion[1];
    end
end


always @(*) begin
    if (BTN[0] == 1'b1) begin
        LED = Sw;
    end else if (BTN[1] == 1'b1) begin
        LED = Sw;
    end else begin
        LED = OP;
    end

    if (Operacion == 2'b00) begin
        LED_RGB = 3'b010;
    end else if (Operacion == 2'b01) begin
        LED_RGB = 3'b100; 
    end else if (Operacion == 2'b10) begin
        LED_RGB = 3'b101; 
    end else if (Operacion == 2'b11) begin
        LED_RGB = 3'b111; 
    end else begin
        LED_RGB = 3'b000;
    end
end


ALU uut_ALU (.A(G_A),.B(G_B),.Botones(Operacion),.OP(OP));

endmodule