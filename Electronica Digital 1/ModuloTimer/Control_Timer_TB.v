`timescale 1ns / 1ps

module Control_Timer_TB;

    reg clk;
    reg z;
    reg [1:0] sel;
    reg init_t;
    wire dout;
    wire done;
    wire rst;
    wire inc;
    wire [1:0] sel_tim;

    Control_Timer uut (.clk(clk),.z(z),.sel(sel),.init_t(init_t),.dout(dout),.done(done),.rst(rst),.inc(inc),.sel_tim(sel_tim));


    always begin
        #10 clk = ~clk;
    end

    reg [31:0] state_name;
    always @(*) begin
        case (uut.state)
            4'b0000: state_name = "STRT";
            4'b0001: state_name = "CHK1";
            4'b0010: state_name = "INIT";
            4'b0011: state_name = "CHK2";
            4'b0100: state_name = "T0H ";
            4'b0101: state_name = "T1H ";
            4'b0110: state_name = "DUT1";
            4'b0111: state_name = "DUT2";
            4'b1000: state_name = "DUT3";
            4'b1001: state_name = "CNT1";
            4'b1010: state_name = "CHK3";
            4'b1011: state_name = "CNT2";
            4'b1100: state_name = "CNT3";
            4'b1101: state_name = "CHK4";
            4'b1110: state_name = "CHK5";
            4'b1111: state_name = "DONE";
            default: state_name = "xxxx";
        endcase
    end

    initial begin
        $display("=== TESTBENCH UNIDAD DE CONTROL (TIMER) ===");
        clk = 0;
        z = 0;
        sel = 2'b00;
        init_t = 0;
        #40;

        $display("\n--- Iniciando ciclo para SEL = 00 ---");
        @(posedge clk);
        init_t = 1;
        @(posedge clk);
        init_t = 0; 

        repeat (6) @(posedge clk);
        
        $display("Emulando fin de tiempo en alto (z = 1)");
        @(posedge clk);
        z = 1;
        @(posedge clk);
        z = 0; 
        
        repeat (3) @(posedge clk);
        $display("Emulando fin de ciclo completo (z = 1)");
        @(posedge clk);
        z = 1;
        @(posedge clk);
        z = 0;

        repeat (3) @(posedge clk);
        $finish;
    end

    initial begin
        $monitor("Tiempo=%3t ns | init_t=%b | sel=%b | FSM=%s | dout=%b | done=%b | rst=%b | inc=%b", 
                 $time, init_t, sel, state_name, dout, done, rst, inc);
    end

    initial begin: TEST_CASE
        $dumpfile("Control_Timer_TB.vcd");
        $dumpvars(-1, uut);
    end

endmodule