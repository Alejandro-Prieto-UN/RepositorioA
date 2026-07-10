// Unidad de Control para BCD -> Binario.
// El orden shift-luego-resta YA ERA correcto en tu version; lo que
// arreglamos es que ahora los 3 digitos se corrigen en UN SOLO
// estado SUBS (en paralelo), en vez de CHECK2->SUBS1->CHECK3->SUBS2->CHECK4->SUBS3.
module Control_DoubleDabble_Inverso(
    input clk,
    input rst,
    input init,
    input Zero,          // desde Increase.v (contador en 0)
    output reg load,
    output reg shift,
    output reg subs,
    output reg dec,
    output reg done
    );

    parameter START    = 3'b000;
    parameter CHECK1   = 3'b001;
    parameter LOAD     = 3'b010;
    parameter SHIFT    = 3'b011;
    parameter SUBS     = 3'b100;
    parameter INCREASE = 3'b101;
    parameter CHECK5   = 3'b110;
    parameter FINISH   = 3'b111;
    reg [2:0] state;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= START;
        end
        else begin
            case (state)
                START:    state <= CHECK1;
                CHECK1:   state <= init ? LOAD : CHECK1;
                LOAD:     state <= SHIFT;
                SHIFT:    state <= SUBS;
                SUBS:     state <= INCREASE;
                INCREASE: state <= CHECK5;
                CHECK5:   state <= Zero ? FINISH : SHIFT;
                FINISH:   state <= START;
                default:  state <= START;
            endcase
        end
    end

    always @(*) begin
        load  = 0;
        shift = 0;
        subs  = 0;
        dec   = 0;
        done  = 0;
        case (state)
            LOAD:     load  = 1;
            SHIFT:    shift = 1;
            SUBS:     subs  = 1;   // corrige a1,a2,a3 EN PARALELO
            INCREASE: dec   = 1;
            FINISH:   done  = 1;
        endcase
    end

endmodule