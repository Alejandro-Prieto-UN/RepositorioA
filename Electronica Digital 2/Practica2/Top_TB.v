`timescale 1ns / 1ps

module Top_TB();

    reg [3:0]Sw;
    reg [3:0]BTN;
    reg clk;
    wire [3:0]LED;
    wire [2:0]LED_RGB;


    Top uut (.Sw(Sw),.BTN(BTN),.clk(clk),.LED(LED),.LED_RGB(LED_RGB));

    initial begin
        clk = 0;              // Inicializamos en 0
    end

    always #5 clk = ~clk;


    initial begin
        Sw=4'b1010;
        BTN = 4'b0001;
        #20;
        Sw=4'b0011;
        BTN = 4'b0010;
        #20;
        BTN = 4'b0000;
        #20;
        BTN = 4'b0100;
        #20;
        BTN = 4'b1000;
        #20;
        BTN = 4'b1100;
        #100;
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Top_TB.vcd");
     $dumpvars(-1, uut);
   end

endmodule