// Modulo de Unidad de Control para Timer (protocolo tipo NeoPixel/WS2812)
module Control_Timer ( 
    input clk,
    input z, 
    input [1:0] sel,     
    input init_t,
    output reg dout, 
    output reg done,
    output reg rst,
    output reg inc,
    output reg [1:0]sel_tim
);

    parameter START      = 4'b0000;
    parameter CHECK1     = 4'b0001;
    parameter INIT       = 4'b0010;
    parameter CHECK2     = 4'b0011;   
    parameter T0H        = 4'b0100;
    parameter T1H        = 4'b0101;
    parameter DOUT1      = 4'b0110;
    parameter DOUT2      = 4'b0111;
    parameter DOUT3      = 4'b1000;
    parameter COUNT1     = 4'b1001;
    parameter CHECK3     = 4'b1010;
    parameter COUNT2     = 4'b1011;
    parameter COUNT3     = 4'b1100;
    parameter CHECK4     = 4'b1101;
    parameter CHECK5     = 4'b1110;
    parameter DONE       = 4'b1111;


    reg [3:0] state;

    always @(*) begin


        case (state)
            START: begin
                dout    = 0; 
                done    = 0;
                rst     = 0;
                inc     = 0;
                sel_tim = 0;               
            end

            CHECK1: begin
                dout    = 0; 
                done    = 0;
                rst     = 0;
                inc     = 0;
                sel_tim = 0;                 
            end 

            INIT: begin
                dout    = 0; 
                done    = 0;
                rst     = 1;
                inc     = 0;
                sel_tim = 0;  
            end

            CHECK2: begin
                dout    = 0; 
                done    = 0;
                rst     = 0;
                inc     = 0;
                sel_tim = 0;                 
            end

            T0H: begin
                dout    = 0; 
                done    = 0;
                rst     = 0;
                inc     = 0;
                sel_tim = 0; 
            end

            T1H: begin
                dout    = 0; 
                done    = 0;
                rst     = 0;
                inc     = 0;
                sel_tim = 1;
            end

            DOUT1: begin
                dout    = 0; 
                done    = 0;
                rst     = 0;
                inc     = 0;
                sel_tim = 2;       
            end

            DOUT2: begin
                dout    = 1; 
                done    = 0;
                rst     = 0;
                inc     = 0;
                sel_tim = 0;       
            end


            DOUT3: begin
                dout    = 0; 
                done    = 0;
                rst     = 0;
                inc     = 0;
                sel_tim = 0;       
            end

            COUNT1: begin
                dout    = 1; 
                done    = 0;
                rst     = 0;
                inc     = 1;
                sel_tim = 0;       
            end

            CHECK3: begin
                dout    = 1; 
                done    = 0;
                rst     = 0;
                inc     = 0;
                sel_tim = 0;       
            end


            COUNT2: begin
                dout    = 0; 
                done    = 0;
                rst     = 0;
                inc     = 1;
                sel_tim = 3;         
            end


            COUNT3: begin
                dout    = 0; 
                done    = 0;
                rst     = 0;
                inc     = 1;
                sel_tim = 2;    
            end

            CHECK4: begin
                dout    = 0; 
                done    = 0;
                rst     = 0;
                inc     = 0;
                sel_tim = 2;    
            end


            CHECK5: begin
                dout    = 0; 
                done    = 0;
                rst     = 0;
                inc     = 0;
                sel_tim = 3;    
            end


            DONE: begin
                dout    = 0; 
                done    = 1;
                rst     = 0;
                inc     = 0;
                sel_tim = 0; 
            end
            
            default: begin
                dout    = 0; 
                done    = 0;
                rst     = 0;
                inc     = 0;
                sel_tim = 0;                
            end
        endcase
    end


    always @(posedge clk) begin
        case (state)
            START: begin
                state <= CHECK1;
            end

            CHECK1: begin
                if (init_t == 1)
                    state <= INIT;
                else
                    state <= CHECK1;
            end

            INIT: begin
                state <= CHECK2;
            end

            CHECK2: begin
                case (sel)
                    2'b00:   state <= T0H;
                    2'b01:   state <= T1H;
                    2'b10:   state <= DOUT1;
                    default: state <= T0H;
                endcase
            end

            T0H: begin
                state <= DOUT2;
            end

            T1H: begin
                state <= DOUT2;
            end

            DOUT1: begin
                state <= DOUT3;
            end

            DOUT2: begin
                state <= COUNT1;
            end

            DOUT3: begin
                state <= COUNT3;
            end

            COUNT1: begin
                state <= CHECK3;
            end

            CHECK3: begin
                if (z)
                    state <= COUNT2;
                else
                    state <= COUNT1;
            end

            COUNT2: begin
                state <= CHECK5;
            end

            CHECK5: begin
                if (z)
                    state <= DONE;
                else
                    state <= COUNT2;
            end

            COUNT3: begin
                state <= CHECK4;
            end

            CHECK4: begin
  
                if (z)
                    state <= DONE;
                else
                    state <= COUNT3;
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