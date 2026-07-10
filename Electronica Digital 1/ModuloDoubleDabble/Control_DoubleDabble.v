// Modulo de Unidad de Control para el algoritmo Double Dabble
// Version corregida: en vez de CHECK2->SUM1->CHECK3->SUM2->CHECK4->SUM3
// (que ademas perdia la correccion porque se capturaba con sum=0),
// aqui hay UN SOLO estado ADD donde los 3 digitos se corrigen en
// paralelo (Shift.v aplica update[2:0] a los 3 al mismo tiempo),
// y un estado SHIFT separado que solo desplaza.
module Control_DoubleDabble(
    input clk,
    input rst,
    input init,
    input i_eq_n,          // vienen de Increase.v (contador en 0)
    output reg load,
    output reg shift,
    output reg sum,
    output reg increase,
    output reg done
    );

    parameter START = 3'b000;
    parameter SHIFT  = 3'b001;
    parameter CHECK  = 3'b010;
    parameter SUM    = 3'b011;
    parameter FINISH = 3'b100;
    reg [2:0] state;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= START;
        end
        else begin
            case (state)
                START: begin
                    if (init)
                        state <= SHIFT;
                    else
                        state <= START;
                end

                SHIFT: begin
                    state <= CHECK;
                end

                CHECK: begin
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

    always @(*) begin
        case (state)
            START: begin
                load  = 1;    // carga A y resetea el contador
                shift = 0;
                sum   = 0;
                increase   = 0;
                done  = 0;
            end

            SHIFT: begin
                load  = 0;
                shift = 1;
                sum   = 0;
                increase   = 1;    // desplaza y decrementa el contador juntos
                done  = 0;
            end

            CHECK: begin
                load  = 0;
                shift = 0;
                sum   = 0;
                increase   = 0;
                done  = 0;
            end

            SUM: begin
                load  = 0;
                shift = 0;
                sum   = 1;    // corrige a1,a2,a3 EN PARALELO
                increase   = 0;
                done  = 0;
            end

            FINISH: begin
                load  = 0;
                shift = 0;
                sum   = 0;
                increase   = 0;
                done  = 1;
            end

            default: begin
                load  = 0;
                shift = 0;
                sum   = 0;
                increase   = 0;
                done  = 0;
            end
        endcase
    end

endmodule