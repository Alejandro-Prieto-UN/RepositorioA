// Modulo de Unidad de Control para algoritmo de raiz cuadrada
module Control_RaizCuadrada ( 
    input clk,
    input rst,  
    input i_eq_zero,
    input resp_more_eq_op,
    input init, 
    output reg load,
    output reg assi,
    output reg root_bit,
    output reg subs,
    output reg decrease,
    output reg shift,
    output reg done
    );

    parameter START    = 4'b0000;
    parameter CHECK1   = 4'b0001;
    parameter LOAD     = 4'b0010; 
    parameter SHIFT    = 4'b0011;   
    parameter ASSIGN1  = 4'b0100;   
    parameter CHECK2   = 4'b0101;   
    parameter ASSIGN2  = 4'b0110;   
    parameter SUBSTRAC = 4'b0111;   
    parameter ASSIGN3  = 4'b1000;   
    parameter DECREASE = 4'b1001;   
    parameter CHECK3   = 4'b1010;   
    parameter FINISH   = 4'b1011;   

    reg [3:0] state;

    always @(*) begin
        case (state)
            START: begin
                load       = 0;
                assi       = 0;
                root_bit   = 0;
                subs       = 0;
                decrease   = 0;
                shift      = 0;
                done       = 0;                
            end

            CHECK1: begin
                load       = 0;
                assi       = 0;
                root_bit   = 0;
                subs       = 0;
                decrease   = 0;
                shift      = 0;
                done       = 0;                
            end

            LOAD: begin
                load       = 1;
                assi       = 0;
                root_bit   = 0;
                subs       = 0;
                decrease   = 0;
                shift      = 0;
                done       = 0; 
            end

            SHIFT: begin 
                load       = 0;
                assi       = 0;
                root_bit   = 0;
                subs       = 0;
                decrease   = 0;
                shift      = 1;
                done       = 0; 
            end

            ASSIGN1: begin
                load       = 0;
                assi       = 0;
                root_bit   = 0;
                subs       = 0;
                decrease   = 0;
                shift      = 0;
                done       = 0; 
            end

            CHECK2: begin
                load       = 0;
                assi       = 0;
                root_bit   = 0;
                subs       = 0;
                decrease   = 0;
                shift      = 0;
                done       = 0; 
            end

            ASSIGN2: begin
                load       = 0;
                assi       = 1;
                root_bit   = 0;  
                subs       = 0;
                decrease   = 0;
                shift      = 0;
                done       = 0; 
            end

            SUBSTRAC: begin
                load       = 0;
                assi       = 0;
                root_bit   = 0;
                subs       = 1;
                decrease   = 0;
                shift      = 0;
                done       = 0; 
            end

            ASSIGN3: begin
                load       = 0;
                assi       = 1;
                root_bit   = 1;  
                subs       = 0;
                decrease   = 0;
                shift      = 0;
                done       = 0; 
            end

            DECREASE: begin
                load       = 0;
                assi       = 0;
                root_bit   = 0;
                subs       = 0;
                decrease   = 1;
                shift      = 0;
                done       = 0; 
            end

            CHECK3: begin
                load       = 0;
                assi       = 0;
                root_bit   = 0;
                subs       = 0;
                decrease   = 0;
                shift      = 0;
                done       = 0; 
            end

            FINISH: begin
                load       = 0;
                assi       = 0;
                root_bit   = 0;
                subs       = 0;
                decrease   = 0;
                shift      = 0;
                done       = 1; 
            end

            default: begin
                load       = 0;
                assi       = 0;
                root_bit   = 0;
                subs       = 0;
                decrease   = 0;
                shift      = 0;
                done       = 0; 
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
                    state <= ASSIGN1;
                end

                ASSIGN1: begin
                    state <= CHECK2;
                end

                CHECK2: begin
                    if (resp_more_eq_op)
                        state <= SUBSTRAC;
                    else
                        state <= ASSIGN2;
                end

                ASSIGN2: begin
                    state <= DECREASE;
                end

                SUBSTRAC: begin
                    state <= ASSIGN3;
                end

                ASSIGN3: begin
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