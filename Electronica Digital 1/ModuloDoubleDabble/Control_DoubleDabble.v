// MOdulo de control del algoritmo Double Dabble 
module Control_DoubleDabble(
    input clk,
    input rst,
    input init,
    input i_eq_n,          
    output reg load,
    output reg shift,
    output reg sum,
    output reg increase,
    output reg done
    );
    
    parameter START    = 3'b000;
    parameter CHECK1   = 3'b001;
    parameter LOAD     = 3'b010;
    parameter SHIFT    = 3'b011;
    parameter INCREASE = 3'b100;
    parameter CHECK2   = 3'b101;
    parameter SUM      = 3'b110;
    parameter FINISH   = 3'b111;
    reg [2:0] state;


    always @(*) begin
        case (state)
            START: begin
                load       = 0;
                shift      = 0;
                sum        = 0;
                increase   = 0;    
                done       = 0;
            end


            CHECK1: begin
                load       = 0;
                shift      = 0;
                sum        = 0;
                increase   = 0;    
                done       = 0;
            end

            LOAD: begin
                load       = 1;
                shift      = 0;
                sum        = 0;
                increase   = 0;    
                done       = 0;
            end


            SHIFT: begin
                load       = 0;
                shift      = 1;
                sum        = 0;
                increase   = 0;    
                done       = 0;
            end


            INCREASE: begin
                load       = 0;
                shift      = 0;
                sum        = 0;
                increase   = 1;    
                done       = 0;
            end

            CHECK2: begin
                load       = 0;
                shift      = 0;
                sum        = 0;
                increase   = 0;    
                done       = 0;
            end


            SUM: begin
                load       = 0;
                shift      = 0;
                sum        = 1;
                increase   = 0;    
                done       = 0;
            end

            FINISH: begin
                load       = 0;
                shift      = 0;
                sum        = 0;
                increase   = 0;    
                done       = 1;
            end

            default: begin
                load       = 0;
                shift      = 0;
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
                    state <= SHIFT;
                end


                SHIFT: begin
                    state <= INCREASE;
                end

                INCREASE: begin
                    state <= CHECK2;
                end


                CHECK2: begin
                    if (i_eq_n)
                        state <= FINISH;
                    else
                        state <= SUM;
                end
                
                SUM: begin
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
