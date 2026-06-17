module Control_Div(
    input clk,
    input rst,
    input init,
    input res_eq_1,
    input i_more_n,
    output reg load,
    output reg assi,
    output reg sum,
    output reg increase,
    output reg shift,
    output reg done
    );
    
    parameter START      = 4'b0000; 
    parameter CHECK1     = 4'b0001; 
    parameter LOAD       = 4'b0010; 
    parameter ASSIGN1    = 4'b0011; 
    parameter SUM1       = 4'b0100; 
    parameter CHECK2     = 4'b0101; 
    parameter ASSIGN2    = 4'b0110; 
    parameter SUM2       = 4'b0111; 
    parameter ASSIGN3    = 4'b1000; 
    parameter INCREASE_I = 4'b1001; 
    parameter CHECK3     = 4'b1010; 
    parameter SHIFT      = 4'b1011; 
    parameter ASSIGN4    = 4'b1100; 
    parameter SUM3       = 4'b1101; 
    parameter FINISH     = 4'b1110; 
    
    reg [3:0] state;

    always @(*) begin
        case (state)

            START: begin
                load   =  0;
                assi   =  0;
                sum    =  0;
                increase= 0;
                shift  =  0;
                done   =  0;                   
            end

            CHECK1: begin
                load   =  0;
                assi   =  0;
                sum    =  0;
                increase= 0;
                shift  =  0;
                done   =  0; 
            end 

            LOAD: begin
                load   =  1;
                assi   =  0;
                sum    =  0;
                increase= 0;
                shift  =  0;
                done   =  0; 
            end


            ASSIGN1: begin
                load   =  0;
                assi   =  1;
                sum    =  1;
                increase= 0;
                shift  =  0;
                done   =  0;  
            end

            SUM1: begin
                load   =  0;
                assi   =  0;
                sum    =  1;
                increase= 0;
                shift  =  0;
                done   =  0; 
            end

            CHECK2: begin
                load   =  0;
                assi   =  0;
                sum    =  0;
                increase= 0;
                shift  =  0;
                done   =  0;  
            end

            ASSIGN2: begin
                load   =  0;
                assi   =  1;
                sum    =  1;
                increase= 0;
                shift  =  0;
                done   =  0;  
            end

            SUM2: begin
                load   =  0;
                assi   =  0;
                sum    =  1;
                increase= 0;
                shift  =  0;
                done   =  0;   
            end

            ASSIGN3: begin
                load   =  0;
                assi   =  1;
                sum    =  0;
                increase= 0;
                shift  =  0;
                done   =  0; 
            end

            INCREASE_I: begin
                load   =  0;
                assi   =  0;
                sum    =  0;
                increase= 1;
                shift  =  0;
                done   =  0;
            end

            CHECK3: begin
                load   =  0;
                assi   =  0;
                sum    =  0;
                increase= 0;
                shift  =  0;
                done   =  0;
            end

            SHIFT: begin
                load   =  0;
                assi   =  0;
                sum    =  0;
                increase= 0;
                shift  =  1;
                done   =  0;
            end

            ASSIGN4: begin
                load   =  0;
                assi   =  1;
                sum    =  0;
                increase= 0;
                shift  =  0;
                done   =  0;
            end

            SUM3: begin
                load   =  0;
                assi   =  0;
                sum    =  1;
                increase= 0;
                shift  =  0;
                done   =  0;
            end

            FINISH: begin
                load   =  0;
                assi   =  0;
                sum    =  0;
                increase= 0;
                shift  =  0;
                done   =  1;
            end
            
            default: begin
                load   =  0;
                assi   =  0;
                sum    =  0;
                increase= 0;
                shift  =  0;
                done   =  0;                
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
                    state <= SUM1; 
                end

                
                ASSIGN1: begin
                    state <= SUM1; 
                end

                SUM1: begin
                    state <= CHECK2;
                end

                CHECK2: begin
                    if (res_eq_1)
                        state <= ASSIGN2;
                    else
                        state <= ASSIGN3; 
                end

                ASSIGN1: begin
                    state <= SUM2; 
                end
              
                SUM2: begin
                    state <= INCREASE_I; 
                end

                ASSIGN2: begin
                    state <= INCREASE_I; 
                end

                INCREASE_I: begin
                    state <= CHECK3; 
                end


                CHECK3: begin
                    if (i_more_n)
                        state <= FINISH;
                    else
                        state <= SHIFT;      
                end


                SHIFT: begin
                    state <= ASSIGN3; 
                end
                
                ASSIGN3: begin
                    state <= SUM3; 
                end

                SUM3: begin
                    state <= CHECK2; 
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