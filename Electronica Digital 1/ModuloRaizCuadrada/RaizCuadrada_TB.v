`timescale 1ns / 1ps

module RaizCuadrada_TB;

    reg  clk;
    reg  rst;
    reg  [15:0] A;
    reg  init;
    wire [13:0] Rf;
    wire done;

    integer errors = 0;
    integer tests  = 0;

    Raiz_Cuadrada uut (
        .clk(clk), .rst(rst), .A(A), .init(init), .Rf(Rf), .done(done)
    );

    parameter PERIOD = 20;

    // Generacion de reloj
    initial begin
        clk = 0;
        forever #(PERIOD/2) clk = ~clk;
    end

    // Raiz cuadrada entera de referencia (solo para el testbench, NO sintetizable)
    function [13:0] isqrt;
        input [15:0] value;
        integer r;
        begin
            r = 0;
            while ((r + 1) * (r + 1) <= value)
                r = r + 1;
            isqrt = r[13:0];
        end
    endfunction

    // Corre un caso: carga A, dispara init, espera "done" y compara Rf
    task run_test;
        input [15:0] value;
        reg   [13:0] expected;
        begin
            expected = isqrt(value);
            tests = tests + 1;

            A = value;
            @(negedge clk);
            init = 1;
            @(negedge clk);
            init = 0;

            wait (done == 1'b1);
            @(negedge clk);

            if (Rf !== expected) begin
                errors = errors + 1;
                $display("FALLO  A=%0d  Rf=%0d  esperado=%0d", value, Rf, expected);
            end
            else begin
                $display("OK     A=%0d  ->  raiz=%0d", value, Rf);
            end

            @(negedge clk);
        end
    endtask

    initial begin
        rst  = 1;
        A    = 0;
        init = 0;
        repeat (2) @(negedge clk);
        rst = 0;
        repeat (2) @(negedge clk);

        run_test(16'd0);      // raiz exacta = 0
        run_test(16'd1);      // raiz exacta = 1
        run_test(16'd4);      // raiz exacta = 2
        run_test(16'd8);      // no exacta -> 2 (resto 4)
        run_test(16'd9);      // raiz exacta = 3
        run_test(16'd15);     // no exacta -> 3 (resto 6)
        run_test(16'd16);     // raiz exacta = 4
        run_test(16'd255);    // no exacta -> 15 (resto 30)
        run_test(16'd1000);   // no exacta -> 31 (resto 39)
        run_test(16'd65535);  // maximo de 16 bits -> 255 (resto 510)

        $display("----------------------------------------");
        if (errors == 0)
            $display("TODAS LAS PRUEBAS PASARON (%0d/%0d)", tests, tests);
        else
            $display("%0d de %0d PRUEBAS FALLARON", errors, tests);

        $finish;
    end

    // Captura de formas de onda
    initial begin
        $dumpfile("RaizCuadrada_TB.vcd");
        $dumpvars(-1, uut);
    end

endmodule