`timescale 1ns / 1ps

module Division_TB;
    
    reg clk;
    reg rst;
    reg [15:0] A;
    reg [15:0] B;
    reg init;
    wire [15:0] Res;
    wire [15:0] Cc;
    wire done;
  
    Division uut (.clk(clk), .rst(rst), .A(A), .B(B), .init(init), .Res(Res), .Cc(Cc), .done(done));

    parameter PERIOD = 20;

j
    initial begin
        clk = 0;
        forever #(PERIOD/2) clk = ~clk;
    end

    initial begin

        rst = 1;
        A = 16'd12;
        B = 16'd144;
        init = 0;
        
        #(PERIOD*2);        
        rst = 0;            
        
        #(PERIOD*2);       
        
        init = 1;           
        #(PERIOD*3);
        init = 0;           
        
        #(PERIOD*30); 

        #5000;

        #(PERIOD*2);         
        $finish;
    end

    // Captura de formas de onda
    initial begin
        $dumpfile("Division_TB.vcd");
        $dumpvars(-1, uut);
        #(100000) $finish;
    end

endmodule