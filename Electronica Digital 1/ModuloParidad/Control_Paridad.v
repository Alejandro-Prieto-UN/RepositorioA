// Modulo de Unidad de Control para algortimo de paridad
module Control_Paridad ( 
    input clk,
    input rst, 
    input cont_eq_zero, 
    input i_eq_n,
    input a_eq_1,
    input init,
    output reg done, 
    output reg load,
    output reg sum,
    output reg increase
    );

    parameter START    = 4'b0000;
    parameter CHECK1   = 4'b0001;
    parameter LOAD     = 4'b0010;
    parameter CHECK2   = 4'b0011;   
    parameter SUM      = 4'b0100;
    parameter INCREASE = 4'b0101;   
    parameter CHECK3   = 4'b0110;
    parameter CHECK4   = 4'b0111;
    parameter PAR      = 4'b1000;
    parameter IMPAR    = 4'b1001;   
    parameter FINISH   = 4'b1010;

    reg [3:0] state;

    always @(*) begin


        case (state)
            START: begin
                load       = 0;
                sum        = 0;
                increase   = 0;
                done       = 0;                
            end

            CHECK1: begin
                load       = 0;
                sum        = 0;
                increase   = 0;
                done       = 0;                
            end              

            LOAD: begin
                load       = 1;
                sum        = 0;
                increase   = 0;
                done       = 0; 
            end

            CHECK2: begin
                load       = 0;
                sum        = 0;
                increase   = 0;
                done       = 0;                 
            end

            SUM: begin
                load       = 0;
                sum        = 1;
                increase   = 0;
                done       = 0;  
            end

            INCREASE: begin
                load       = 0;
                sum        = 0;
                increase   = 1;
                done       = 0; 
            end

            CHECK3: begin
                load       = 0;
                sum        = 0;
                increase   = 0;
                done       = 0;       
            end

            CHECK4: begin
                load       = 0;
                sum        = 0;
                increase   = 0;
                done       = 0; 
            end

            PAR: begin
                load       = 0;
                sum        = 0;
                increase   = 0;
                done       = 0; 
            end

            IMPAR: begin
                load       = 0;
                sum        = 0;
                increase   = 0;
                done       = 0; 
            end            

            FINISH: begin
                load       = 0;
                sum        = 0;
                increase   = 0;
                done       = 1; 
            end

            default: begin
                load       = 0;
                sum        = 0;
                increase   = 0;
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
                    state <= CHECK2; 
                end

                CHECK2: begin
                    if (a_eq_1)
                        state <= SUM;
                    else
                        state <= INCREASE; 
                end

                SUM: begin
                    state <= INCREASE; 
                end

                INCREASE: begin
                    state <= CHECK3; 
                end
              
                CHECK3: begin
                    if (i_eq_n)
                        state <= CHECK4;
                    else
                        state <= CHECK2;
                end

                CHECK4: begin
                    if (cont_eq_zero)
                        state <= IMPAR;
                    else
                        state <= PAR;                   
                end

                PAR: begin
                    state <= FINISH;
                end

                IMPAR: begin
                    state <= FINISH;
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