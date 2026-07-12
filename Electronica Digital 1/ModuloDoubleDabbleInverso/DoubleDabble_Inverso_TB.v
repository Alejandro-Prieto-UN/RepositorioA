// Modulo de prueba del algortimo Double Dabble inverso (BCD a binario)
`timescale 1ns / 1ps

module DoubleDabble_Inverso_TB;

    reg clk;
    reg rst;
    reg init;
    reg [3:0] a1, a2, a3;   
    wire [9:0] A;          
    wire done;

    DoubleDabble_Inverso uut (.clk(clk), .rst(rst), .init(init),.a1(a1),.a2(a2),.a3(a3),.A(A),.done(done));

    parameter PERIOD = 20;
    reg [20:0] i;
    event reset_trigger;
    event reset_done_trigger;

    initial begin
        clk = 0; rst = 1; init = 0;
        a3 = 4'd2; a2 = 4'd5; a1 = 4'd5;
    end

    initial begin
        forever begin
            @(reset_trigger);
            @(negedge clk); rst = 1;
            @(negedge clk); rst = 0;
            -> reset_done_trigger;
        end
    end

    initial begin
        forever begin
            clk = 1'b0; #(PERIOD/2);
            clk = 1'b1; #(PERIOD/2);
        end
    end

    initial begin
        #10 -> reset_trigger;
        @(reset_done_trigger);
        @(posedge clk); init = 0;
        @(posedge clk); init = 1;
        @(posedge clk);
        @(posedge clk);   
        init = 0;

        wait (done);
        $display("BCD a1=%d a2=%d a3=%d  ->  Binario A=%d", a1, a2, a3, A);
        #20;
        $finish;
    end

    initial begin: TEST_CASE
        $dumpfile("DoubleDabble_Inverso_TB.vcd");
        $dumpvars(-1, uut);
        #(100000) $finish;
    end

endmodule