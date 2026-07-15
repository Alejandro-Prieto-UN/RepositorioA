`timescale 1ns / 1ps

module Ws2812_TB;

    reg clk;
    reg [23:0] RGB;
    reg init;
    reg rst_cmd;
    wire dout;
    wire done;


    Ws2812 uut (.clk(clk),.RGB(RGB),.init(init),.rst_cmd(rst_cmd),.dout(dout),.done(done));

    always #10 clk = ~clk;

    initial begin
        #1000000;
        $display("TIMEOUT de seguridad activado.");
        $finish;
    end

    initial begin
        $display("=== TESTBENCH TOP MODULE WS2812 ===");
        clk = 0; RGB = 24'hFF00AA; init = 0; rst_cmd = 0;
        #50;

        $display("Iniciando transmisión de color...");
        @(negedge clk);
        init = 1;
        @(negedge clk);
        init = 0;

        @(posedge done);
        $display("Transmisión finalizada.");

        #100;
        $finish;
    end

    initial begin: TEST_CASE
        $dumpfile("Ws2812_TB.vcd");
        $dumpvars(-1, uut);
    end
endmodule