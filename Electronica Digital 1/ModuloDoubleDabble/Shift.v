// Modulo que hace el corriemiento a la izquierda y la suma 
module Shift(
    input clk,
    input load,
    input shift,
    input sum,
    input [2:0] update,        
    input [9:0] A,
    input [11:0] in_bcd,        
    output [11:0] arr_corr      
);
    reg [21:0] alldata;         
    assign arr_corr = alldata[21:10];

    always @(posedge clk) begin
        if (load) begin
            alldata[21:10] <= 12'b0;
            alldata[9:0]   <= A;
        end
        else if (shift) begin
            alldata <= alldata << 1;
        end
        else if (sum) begin
            if (update[2]) alldata[21:18] <= in_bcd[11:8];   // a3
            if (update[1]) alldata[17:14] <= in_bcd[7:4];    // a2
            if (update[0]) alldata[13:10] <= in_bcd[3:0];    // a1
        end
    end
endmodule
