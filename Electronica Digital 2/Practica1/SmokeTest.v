module SmokeTest(
    input [3:0] Sw,
    input [5:0] BTN,
    input clk,
    output reg [3:0] LED,
    output reg [2:0] LED_RGB
); 

    reg [3:0] sum;
    reg [3:0] val1;
    reg [3:0] Or;
    reg [3:0] And;
    reg [3:0] result;
    reg [3:0] Xor;

    always @(posedge clk) begin
        if (BTN == 6'b100000) begin
            val1 <= Sw;    
        end
    end

    always @(*) begin

        LED     = Sw;
        LED_RGB = 3'b000;
        sum     = 4'b0;
        Or      = 4'b0;
        And     = 4'b0;
        result  = 4'b0;
        Xor     = 4'b0;

        // BTN[5]: Carga y muestra el primer operando (val1)
        if (BTN == 6'b100000) begin 
            LED = val1;
            LED_RGB = 3'b111; // Blanco
        end

        // BTN[4]: Suma (Muestra el resultado en los LEDs)
        if (BTN == 6'b010000) begin
            sum = val1 + Sw;
            LED     = sum[3:0]; // Muestra el resultado de la suma
            LED_RGB = 3'b100;    // Rojo
        end

        // BTN[3]: Operación OR y validación con Suma
        if (BTN == 6'b001000) begin
            sum = val1 + Sw;
            Or  = val1 | Sw;
            LED = Or;
            if (sum == Or) begin
                LED_RGB = 3'b010; // Verde (Si coinciden Suma y OR)
            end else begin
                LED_RGB = 3'b110; // Amarillo (Si hay acarreo)
            end       
        end

        // BTN[2]: Operación AND
        if (BTN == 6'b000100) begin
            And = val1 & Sw;
            LED = And;     // Muestra resultado del AND
            if (And != 0) begin
                LED_RGB = 3'b001; // Azul
            end else begin
                LED_RGB = 3'b011; // Cyan
            end
        end 

        // BTN[1]: Teorema De Morgan (NAND)
        if (BTN == 6'b000010) begin
            And = ~(val1 & Sw);
            Or  = ~val1 | ~Sw;
            LED = And;     // Muestra resultado de De Morgan
            if (And == Or) begin
                LED_RGB = 3'b101; // Magenta/Morado
            end
        end

        // BTN[0]: Equipotencia XOR
        if (BTN == 6'b000001) begin
            Xor    = val1 ^ Sw;
            result = (val1 & ~Sw) | (~val1 & Sw);
            LED    = result;    // Muestra resultado de XOR
            if (result == Xor) begin
                LED_RGB = 3'b011; // Cyan / Turquesa
            end
        end

    end

endmodule