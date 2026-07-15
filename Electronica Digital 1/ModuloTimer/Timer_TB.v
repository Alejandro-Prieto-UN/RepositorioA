`timescale 1ns / 1ps

module Timer_TB;

    reg clk;
    reg init_t;
    reg [1:0] sel;
    wire dout;
    wire done_t;


    Timer uut (.clk(clk),.init_t(init_t),.sel(sel),.dout(dout),.done_t(done_t));

    always begin
        #10 clk = ~clk;
    end


    initial begin
        #5000000; 
        $display("\n[ERROR] TIMEOUT: La simulación se atascó esperando done_t.");
        $display("Forzando cierre para que puedas analizar el archivo en GTKWave...");
        $finish;
    end

    initial begin
        $display("=== TESTBENCH INTEGRADO DEL TIMER ===");
        clk = 0;
        init_t = 0;
        sel = 2'b00;
        #100;

        $display("\n--- Caso de Prueba 1: Bit 0 (sel = 00) ---");
        @(posedge clk);
        sel = 2'b00;
        init_t = 1;
        @(posedge clk);
        init_t = 0;

        @(posedge done_t); 
        #40; 

        $display("\n--- Caso de Prueba 2: Bit 1 (sel = 01) ---");
        @(posedge clk);
        sel = 2'b01;
        init_t = 1;
        @(posedge clk);
        init_t = 0;

        @(posedge done_t);
        #40;

        $display("\n--- Caso de Prueba 3: Reset de Linea (sel = 10) ---");
        @(posedge clk);
        sel = 2'b10;
        init_t = 1;
        @(posedge clk);
        init_t = 0;

        @(posedge done_t); 
        #40;

        $display("\n=== SIMULACION COMPLETA DEL TIMER CONCLUIDA CON EXITO ===");
        $finish;
    end

    initial begin: TEST_CASE
        $dumpfile("Timer_TB.vcd");
        $dumpvars(-1, uut); 
    end

endmodule