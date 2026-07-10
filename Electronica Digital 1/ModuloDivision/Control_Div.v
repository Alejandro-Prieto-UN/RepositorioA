// Modulo de control del algoritmo de division
module Control_Div(
    input clk,
    input rst,
    input init,
    input i_eq_zero,
    input reg_div_min_a,
    output reg load,
    output reg assi,
    output reg subs,
    output reg decrease,
    output reg shift,
    output reg done
    );
    
    parameter START      = 4'b0000; 
    parameter CHECK1     = 4'b0001; 
    parameter LOAD       = 4'b0010; 
    parameter SHIFT      = 4'b0011; 
    parameter CHECK2     = 4'b0100; 
    parameter ASSIGN1    = 4'b0101; 
    parameter ASSIGN2    = 4'b0110; 
    parameter SUBS       = 4'b0111; 
    parameter DECREASE   = 4'b1000; 
    parameter CHECK3     = 4'b1001; 
    parameter FINISH     = 4'b1010; 
    
    reg [3:0] state;

    always @(*) begin
        case (state)

            START: begin
                load      =  0;
                shift     =  0;
                decrease  =  0;
                subs      =  0;
                assi      =  0;
                done      =  0;                   
            end

            CHECK1: begin
                load      =  0;
                shift     =  0;
                decrease  =  0;
                subs      =  0;
                assi      =  0;
                done      =  0;
            end 

            LOAD: begin
                load      =  1;
                shift     =  0;
                decrease  =  0;
                subs      =  0;
                assi      =  0;
                done      =  0; 
            end


            SHIFT: begin
                load      =  0;
                shift     =  1;
                decrease  =  0;
                subs      =  0;
                assi      =  0;
                done      =  0;  
            end

            CHECK2: begin
                load      =  0;
                shift     =  0;
                decrease  =  0;
                subs      =  0;
                assi      =  0;
                done      =  0; 
            end

            ASSIGN1: begin
                load      =  0;
                shift     =  0;
                decrease  =  0;
                subs      =  0;
                assi      =  1;
                done      =  0;  
            end

            ASSIGN2: begin
                load      =  0;
                shift     =  0;
                decrease  =  0;
                subs      =  0;
                assi      =  1;                
                done      =  0;  
            end

            SUBS: begin
                load      =  0;
                shift     =  0;
                decrease  =  0;
                subs      =  1;
                assi      =  0;
                done      =  0;    
            end

            DECREASE: begin
                load      =  0;
                shift     =  0;
                decrease  =  1;
                subs      =  0;
                assi      =  0;
                done      =  0;  
            end

            CHECK3: begin
                load      =  0;
                shift     =  0;
                decrease  =  0;
                subs      =  0;
                assi      =  0;
                done      =  0; 
            end

            FINISH: begin
                load      =  0;
                shift     =  0;
                decrease  =  0;
                subs      =  0;
                assi      =  0;
                done      =  1; 
            end

            default: begin
                load      =  0;
                shift     =  0;
                decrease  =  0;
                subs      =  0;
                assi      =  0;
                done      =  0;               
            end
        endcase
    end


 always @(posedge clk) begin
        if (rst) begin
            state <= START; 
        end 
        else begin
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
                    state <= SHIFT; 
                end

                
                SHIFT: begin
                    state <= CHECK2; 
                end

                CHECK2: begin
                    if (reg_div_min_a)
                        state <= ASSIGN1;
                    else
                        state <= ASSIGN2; 
                end

                ASSIGN1: begin
                     state <= DECREASE;
                end

                ASSIGN2: begin
                    state <= SUBS; 
                end
              
                SUBS: begin
                    state <= DECREASE; 
                end

                DECREASE: begin
                    state <= CHECK3; 
                end

                CHECK3: begin
                    if (i_eq_zero)
                        state <= FINISH;
                    else
                        state <= SHIFT;     
                end

                FINISH: begin
                    state <= START; 
                end
              
                default: begin
                    state <= START;
                end

            endcase
        end
    end
endmodule