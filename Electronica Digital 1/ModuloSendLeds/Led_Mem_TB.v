`timescale 1ns / 1ps

module Led_Mem_tb;

    reg [15:0] addr;

    wire [23:0] RGB;
    integer i;

    LED_MEM uut (.addr(addr),.RGB(RGB));

    initial begin
        $display("=== TESTBENCH MEMORIA DE LEDs ===");
        
        for (i = 0; i <= 5; i = i + 1) begin
            addr = i;
            #10; 
            
            $display("Casillero %d -> Color entregado: %h", addr, RGB);
        end

        #20;
        $display("=== PRUEBA FINALIZADA ===");
        $finish;
    end

    initial begin
        $dumpfile("Led_Mem_TB.vcd");
        $dumpvars(-1, uut);
    end

endmodule