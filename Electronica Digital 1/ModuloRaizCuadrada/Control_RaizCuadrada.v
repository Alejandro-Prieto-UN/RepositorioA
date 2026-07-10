// Modulo de Unidad de Control para algoritmo de raiz cuadrada
module Control_RaizCuadrada ( 
    input clk,
    input rst,  
    input i_eq_zero,
    input resp_more_eq_op,
    input init, 
    output reg load,
    output reg assi,
    output reg root_bit,   // valor fijo (0 o 1) que se escribe en Rf[0] cuando assi=1
    output reg subs,
    output reg decrease,
    output reg shift,
    output reg done
    );

    parameter START    = 4'b0000;
    parameter CHECK1   = 4'b0001;
    parameter LOAD     = 4'b0010;
    parameter SHIFT1   = 4'b0011;   
    parameter SHIFT2   = 4'b0100;
    parameter ASSIGN1  = 4'b0101;   
    parameter CHECK2   = 4'b0110;
    parameter ASSIGN2  = 4'b0111;
    parameter SUBSTRAC = 4'b1000;
    parameter ASSIGN3  = 4'b1001;
    parameter DECREASE = 4'b1010;   
    parameter CHECK3   = 4'b1011;
    parameter FINISH   = 4'b1100;

    reg [3:0] state;

    always @(*) begin
        load       = 0;
        shift      = 0;
        decrease   = 0;
        assi       = 0;
        root_bit   = 0;
        subs       = 0;
        done       = 0;

        case (state)
            LOAD:     load  = 1;
            // SHIFT1 es puente: solo SHIFT2 corre los registros, para que
            // el primer bloque de 2 bits no se corra el doble que los demas.
            SHIFT2:   shift = 1;
            SUBSTRAC: subs  = 1;
            // El bit de la raiz se escribe DESPUES de decidir (no en ASSIGN1),
            // y con un valor fijo por rama: no se relee la comparacion en vivo
            // porque despues de restar, Resp ya cambio y esa lectura ya no
            // corresponde a la decision que se tomo en CHECK2.
            ASSIGN2:  begin assi = 1; root_bit = 0; end  // no hubo resta -> bit 0
            ASSIGN3:  begin assi = 1; root_bit = 1; end  // hubo resta   -> bit 1
            DECREASE: decrease = 1;
            FINISH:   done  = 1;
            default: ; // START, CHECK1, SHIFT1, ASSIGN1, CHECK2, CHECK3: sin senal
        endcase
    end

    always @(posedge clk) begin
        if (rst) begin
            state <= START; 
        end 
        else begin
            case (state)
                START:    state <= CHECK1;
                CHECK1:   state <= init ? LOAD : CHECK1;
                LOAD:     state <= SHIFT1;
                SHIFT1:   state <= SHIFT2;
                SHIFT2:   state <= ASSIGN1;
                ASSIGN1:  state <= CHECK2;
                // se resta cuando Resp >= Op
                CHECK2:   state <= resp_more_eq_op ? SUBSTRAC : ASSIGN2;
                ASSIGN2:  state <= DECREASE;
                SUBSTRAC: state <= ASSIGN3;
                ASSIGN3:  state <= DECREASE;
                DECREASE: state <= CHECK3;
                CHECK3:   state <= i_eq_zero ? FINISH : SHIFT2;
                FINISH:   state <= START;
                default:  state <= START;
            endcase
        end
    end

endmodule