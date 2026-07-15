// Modulo de Unidad de Control para Timer (protocolo tipo NeoPixel/WS2812)
module Control_Send ( 
    input clk,
    input init_t,
    input rst_cmd, 
    input done_led,     
    input z, 
    output reg done,
    output reg rst,
    output reg inc,
    output reg init_led
);

    parameter START      = 4'b0000;
    parameter INIT       = 4'b0001;
    parameter CHECK1     = 4'b0010;
    parameter CHECK2     = 4'b0011;   
    parameter LED1       = 4'b0100;
    parameter LED2       = 4'b0101;
    parameter DOUT1      = 4'b0110;
    parameter INCREASE   = 4'b1000;
    parameter CHECK3     = 4'b1001;
    parameter DONE       = 4'b1010;
    reg [3:0] state;

    always @(*) begin


        case (state)
            START: begin
                done      = 0;
                rst       = 1;
                inc       = 0;
                init_led  = 0;              
            end

            INIT: begin
                done      = 0;
                rst       = 0;
                inc       = 0;
                init_led  = 0;               
            end 

            CHECK1: begin
                done      = 0;
                rst       = 0;
                inc       = 0;
                init_led  = 0; 
            end

            LED1: begin
                done      = 0;
                rst       = 0;
                inc       = 0;
                init_led  = 1;                 
            end

            LED2: begin
                done      = 0;
                rst       = 0;
                inc       = 0;
                init_led  = 0; 
            end

            CHECK2: begin
                done      = 0;
                rst       = 0;
                inc       = 0;
                init_led  = 0; 
            end

            INCREASE: begin
                done      = 0;
                rst       = 0;
                inc       = 1;
                init_led  = 0;      
            end

            CHECK3: begin
                done      = 0;
                rst       = 0;
                inc       = 0;
                init_led  = 0;       
            end


            DONE: begin
                done      = 1;
                rst       = 0;
                inc       = 0;
                init_led  = 0;       
            end
            
            default: begin
                done      = 0;
                rst       = 0;
                inc       = 0;
                init_led  = 0;                
            end
        endcase
    end


    always @(posedge clk) begin

        if(rst_cmd)begin
            state <=START;
        end else begin

        case (state)
            START: begin
                state <= INIT;
            end

            INIT: begin
                state <= CHECK1;
            end

            CHECK1: begin
                if(init_t)
                    state <= LED1;
                else
                    state <= CHECK1;
            end

            LED1: begin
                state <= LED2;

            end

            LED2: begin
                state <= CHECK2;
            end

            CHECK2: begin
                if(done_led)
                    state <= INCREASE;
                else
                    state <= CHECK2;
            end

            INCREASE: begin
                state <= CHECK3;
            end

            CHECK3: begin
                if(z)
                    state <= DONE;
                else
                    state <= LED1;
            end

            DONE: begin
                state <= CHECK1;
            end

            default: begin
                state <= START;
            end
        endcase
    end
end

endmodule