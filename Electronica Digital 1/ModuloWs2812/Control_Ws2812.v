// Modulo de Unidad de Control para algoritmo de raiz cuadrada
module Control_Ws2812 ( 
    input clk,
    input msb,
    input init,  
    input rst_cmd,
    input done_t,
    input z,
    output reg sh,
    output reg init_t,
    output reg [1:0] sel,
    output reg dec,
    output reg ld,
    output reg done
    );

    parameter START        = 4'b0000;
    parameter CHECK1       = 4'b0001;
    parameter LOAD         = 4'b0010; 
    parameter CASE         = 4'b0011;   
    parameter RGB1         = 4'b0100;   
    parameter RGB2         = 4'b0101;   
    parameter RES          = 4'b0110;   
    parameter COUNT        = 4'b0111;   
    parameter CHECK2       = 4'b1000;   
    parameter DONE         = 4'b1001;    

    reg [3:0] state;

    always @(*) begin
        case (state)
            START: begin
                sh      = 0;
                init_t  = 0;
                sel     = 0;
                dec     = 0;
                ld      = 0;
                done    = 0;                
            end

            CHECK1: begin
                sh      = 0;
                init_t  = 0;
                sel     = 0;
                dec     = 0;
                ld      = 0;
                done    = 0;                
            end

            LOAD: begin
                sh      = 0;
                init_t  = 0;
                sel     = 0;
                dec     = 0;
                ld      = 1;
                done    = 0;                
            end

            CASE: begin
                sh      = 0;
                init_t  = 0;
                sel     = 0;
                dec     = 0;
                ld      = 0;
                done    = 0;                
            end

            RGB1: begin
                sh      = 0;
                init_t  = 1;
                sel     = 1;
                dec     = 0;
                ld      = 0;
                done    = 0;                
            end

            RGB2: begin
                sh      = 0;
                init_t  = 1;
                sel     = 0;
                dec     = 0;
                ld      = 0;
                done    = 0;                
            end

            RES: begin
                sh      = 0;
                init_t  = 1;
                sel     = 2;
                dec     = 0;
                ld      = 0;
                done    = 0;                
            end

            COUNT: begin
                sh      = 1;
                init_t  = 0;
                sel     = 0;
                dec     = 1;
                ld      = 0;
                done    = 0;                
            end

            CHECK2: begin
                sh      = 0;
                init_t  = 0;
                sel     = 0;
                dec     = 0;
                ld      = 0;
                done    = 0;                
            end

            DONE: begin
                sh      = 0;
                init_t  = 0;
                sel     = 0;
                dec     = 0;
                ld      = 0;
                done    = 1;                
            end

            default: begin
                sh      = 0;
                init_t  = 0;
                sel     = 0;
                dec     = 0;
                ld      = 0;
                done    = 0;                
            end
        endcase
    end

    always @(posedge clk) begin
        case (state)
            START: begin
                state <= CHECK1;
            end

            CHECK1: begin
                if (init)
                    state <= LOAD;
                else
                    state <= CHECK1;
            end

            LOAD: begin
                state <= CASE;
            end

            CASE: begin
                if (rst_cmd)
                    state <= RES;
                else if (msb)
                    state <= RGB1;
                else
                    state <= RGB2;
            end

            RGB1: begin
                state <= COUNT;
            end

            RGB2: begin
                state <= COUNT;
            end

            COUNT: begin
                state <= CHECK2;
            end

            CHECK2: begin
                if (z==0)
                    state <= DONE;
                else
                    state <= CASE; 
            end

            RES: begin
                state <= DONE;
            end

            DONE: begin
                state <= START;
            end

            default: begin
                state <= START;
            end
        endcase
    end

endmodule