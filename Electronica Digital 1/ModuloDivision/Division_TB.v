// Modulo de prueba del divisor
`timescale 1ns / 1ps

module Division_TB;
    
    reg clk;
    reg rst;        
    reg [15:0] A;     
    reg [15:0] BCc;    
    reg init;
    wire [15:0] Res;
    wire [15:0] BCc_out;    
    wire done; 
  
    Division uut (.clk(clk),.rst(rst),.A(A),.BCc(BCc),.init(init),.Res(Res),.BCc_out(BCc_out),.done(done));

    parameter PERIOD          = 20;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET          = 0;
    reg [20:0] i;
    event reset_trigger;
    event reset_done_trigger;
 

   initial begin
        // 1. Valores iniciales con Reset activo
        clk = 0;
        rst = 1;
        init = 0;
        A = 16'd122;     // El dividendo (007A en tu GTKWave)
        BCc = 16'd5;     // El divisor
        #20;             // Esperamos un ciclo
        
        // 2. Quitamos el reset
        rst = 0;
        #20;
        
        // 3. ¡EL CAMBIO CLAVE! Activamos el pulso de inicio
        init = 1;        // Esto saca a la FSM de CHECK1 y la manda a LOAD
        #20;             // Lo dejamos encendido un ciclo de reloj
        init = 0;        // Lo apagamos para que la división corra sola
        
        // 4. Dejamos pasar tiempo suficiente para que termine de dividir
        #800;
        $finish;
    end

    initial begin 
	  forever begin 
	   @ (reset_trigger);
		@ (negedge clk);
		rst = 1;
		@ (negedge clk);
		rst = 0;
		-> reset_done_trigger;
		end
	end

    initial  begin 
     #OFFSET;
     forever
       begin
         clk = 1'b0;
         #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
         #(PERIOD*DUTY_CYCLE);
       end
   end


initial begin
        #10 -> reset_trigger;
        @ (reset_done_trigger);
        @ (posedge clk);
        init = 0;
        @ (posedge clk);
        init = 1;
        
        for(i=0; i<2; i=i+1) begin
         @ (posedge clk);
        end

          init = 0;
          
        for(i=0; i<17; i=i+1) begin
         @ (posedge clk);
        end

   end	

    initial begin: TEST_CASE
     $dumpfile("Division_TB.vcd");
     $dumpvars(-1, uut);
     #(100000) $finish;
   end

endmodule