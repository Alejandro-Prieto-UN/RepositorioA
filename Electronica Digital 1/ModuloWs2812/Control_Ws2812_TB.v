`timescale 1ns / 1ps

module Control_Ws2812_TB;

    reg clk, msb, init, rst_cmd, done_t, z;
    wire sh, init_t, dec, ld, done;
    wire [1:0] sel;

    Control_Ws2812 uut (.clk(clk),.msb(msb),.init(init),.rst_cmd(rst_cmd),.done_t(done_t),.z(z),
    .sh(sh),.init_t(init_t),.sel(sel),.dec(dec),.ld(ld),.done(done));


    always #10 clk = ~clk;

    initial begin
        #50000;
        $display("TIMEOUT");
        $finish;
    end

    initial begin
        $display("=== TESTBENCH CONTROL WS2812 ===");
        clk = 0; msb = 0; init = 0; rst_cmd = 0; done_t = 0; z = 1;
        #30;

        @(posedge clk);
        init = 1;
        @(posedge clk);
        init = 0;

        repeat(4) @(posedge clk);
        msb = 1; 
        
        repeat(5) @(posedge clk);
        z = 0;

        repeat(5) @(posedge clk);
        $finish;
    end

    initial begin: TEST_CASE
        $dumpfile("Control_Ws2812_TB.vcd");
        $dumpvars(-1, uut);
    end
endmodule