// Modulo de prueba de la maquina de control (Double Dabble)
`timescale 1ns / 1ps

module Control_DoubleDabble_TB;

    reg clk;
    reg rst;
    reg init;
    reg Zero;
    wire load, shift, add, dec, done;

    Control_DoubleDabble uut (.clk(clk), .rst(rst), .init(init), .Zero(Zero),
                              .load(load), .shift(shift), .add(add), .dec(dec), .done(done));

    initial clk = 0;
    always #10 clk = ~clk;

    initial begin
        rst = 1; init = 0; Zero = 0;
        @(negedge clk); rst = 0;
        @(negedge clk); init = 1;
        @(negedge clk); init = 0;

        repeat (6) @(negedge clk);

        Zero = 1;
        repeat (3) @(negedge clk);
        Zero = 0;

        #40;
        $finish;
    end

    initial begin: TEST_CASE
     $dumpfile("Control_DoubleDabble_TB.vcd");
     $dumpvars(-1, uut);
    end

endmodule
