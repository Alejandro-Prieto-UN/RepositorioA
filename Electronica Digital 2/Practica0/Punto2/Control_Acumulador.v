module Control_Acumulador ( 
    input clk,
    input w_start, 
    input w_way, 
    input i_eq_a,
    input acc_eq,
    output reg done, 
    output reg rst,
    output reg inc,
    output reg add
);

    parameter IDLE       = 4'd0;
    parameter LOAD       = 4'd1;
    parameter WAY        = 4'd2;   
    parameter ADD1       = 4'd3;
    parameter INCI       = 4'd4;
    parameter CHECK1     = 4'd5;
    parameter ADD2       = 4'd6;
    parameter CHECK2     = 4'd7;
    parameter DONE       = 4'd8;
    reg [3:0] state;

    always @(*) begin


        case (state)
            IDLE: begin
                done = 0;
                rst  = 0;
                inc  = 0;
                add  = 0;               
            end 

            LOAD: begin
                done = 0;
                rst  = 1;
                inc  = 0;
                add  = 0; 
            end

            WAY: begin
                done = 0;
                rst  = 0;
                inc  = 0;
                add  = 0;                 
            end

            ADD1: begin
                done = 0;
                rst  = 0;
                inc  = 0;
                add  = 1; 
            end

            INCI: begin
                done = 0;
                rst  = 0;
                inc  = 1;
                add  = 0; 
            end

            CHECK1: begin
                done = 0;
                rst  = 0;
                inc  = 0;
                add  = 0;         
            end

            ADD2: begin
                done = 0;
                rst  = 0;
                inc  = 0;
                add  = 1;  
            end

            CHECK2: begin
                done = 0;
                rst  = 0;
                inc  = 0;
                add  = 0;  
            end

            DONE: begin
                done = 1;
                rst  = 0;
                inc  = 0;
                add  = 0;  
            end
            
            default: begin
                done = 0;
                rst  = 0;
                inc  = 0;
                add  = 0;                 
            end
        endcase
    end


    always @(posedge clk) begin
        case (state)
            IDLE: begin
                if (w_start)
                    state <= LOAD;
                else
                    state <= IDLE;
            end

            LOAD: begin
                state <= WAY;
            end

            WAY: begin
                if (w_way)
                    state <= ADD2;
                else
                    state <= ADD1; 
            end

            ADD1: begin    
                state <= INCI; 
            end

            INCI: begin
                state <= CHECK1; 
            end

            CHECK1: begin
                if (i_eq_a)
                    state <= DONE;
                else
                    state <= ADD1;
            end
          
            ADD2: begin
                state <= CHECK2;
            end

            CHECK2: begin
                if (acc_eq)
                    state <= DONE;
                else
                    state <= ADD2; 
            end

            DONE: begin
                state <= IDLE; 
            end
          
            default: begin
                state <= IDLE;
            end
        endcase
    end

endmodule