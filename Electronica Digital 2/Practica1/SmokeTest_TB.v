`timescale 1ns / 1ps

module SmokeTest_TB();

    reg clk;
    reg [3:0] Sw;
    reg [5:0] BTN;
    wire [3:0] LED;
    wire [2:0] LED_RGB;


    SmokeTest uut (.clk(clk),.Sw(Sw),.BTN(BTN),.LED(LED),.LED_RGB(LED_RGB));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Secuencia de Pruebas
    initial begin
        Sw  = 4'b0000;
        BTN = 6'b000000;
        #20;
        Sw  = 4'b1010;
        BTN = 6'b100000;
        #20
        Sw  = 4'b0011;
        BTN = 6'b000000;
        #20;
        BTN = 6'b010000;
        #20;
        BTN = 6'b000001;
        #20;
        BTN = 6'b010000;
        #20;
        BTN = 6'b000000;
        #20;
        BTN = 6'b001000; 
        #20;
        BTN = 6'b000010;
        #20;
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("SmokeTest_TB.vcd");
     $dumpvars(-1, uut);
   end

endmodule