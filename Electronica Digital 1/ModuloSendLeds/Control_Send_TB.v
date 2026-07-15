`timescale 1ns / 1ps

module Control_Send_tb;

    reg clk, init_t, rst_cmd, done_led, z;
    wire done, rst, inc, init_led;

    Control_Send uut (.clk(clk),.init_t(init_t),.rst_cmd(rst_cmd),.done_led(done_led),.z(z),
        .done(done),.rst(rst),.inc(inc),.init_led(init_led));

    always #10 clk = ~clk;

    initial begin
        #50000;
        $display("TIMEOUT");
        $finish;
    end

    initial begin
        $display("=== TESTBENCH CONTROL SEND ===");
        clk = 0; init_t = 0; rst_cmd = 0; done_led = 0; z = 0;
        
        #15;
        rst_cmd = 1;
        #20;
        rst_cmd = 0;
        
        @(negedge clk);
        init_t = 1;
        @(negedge clk);
        init_t = 0;

        repeat(5) @(posedge clk);
        done_led = 1; 
        @(posedge clk);
        done_led = 0;

        repeat(5) @(posedge clk);
        z = 1; 
        done_led = 1; 
        @(posedge clk);
        done_led = 0;
        
        repeat(5) @(posedge clk);
        $display("Simulación terminada");
        $finish;
    end

    initial begin
        $dumpfile("Control_Send_TB.vcd");
        $dumpvars(-1, uut);
    end
endmodule