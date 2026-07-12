//Modulo de corrimiento 
module Shift(
    input clk,
    input load,
    input shift,
    input subs,
    input [2:0] update,      
    input [3:0] a1,
    input [3:0] a2,
    input [3:0] a3,
    input [11:0] in_bcd,     
    output [11:0] arr_corr,    
    output [9:0]  A            
);
    reg [21:0] alldata;        
    assign arr_corr = alldata[21:10];
    assign A = alldata[9:0];

    always @(posedge clk) begin
        if (load) begin
            alldata[21:10] <= {a3, a2, a1};
            alldata[9:0]   <= 10'b0;
        end
        else if (shift) begin
            alldata <= alldata >> 1;
        end
        else if (subs) begin
            if (update[2]) alldata[21:18] <= in_bcd[11:8];   
            if (update[1]) alldata[17:14] <= in_bcd[7:4];    
            if (update[0]) alldata[13:10] <= in_bcd[3:0];    
        end
    end
endmodule
