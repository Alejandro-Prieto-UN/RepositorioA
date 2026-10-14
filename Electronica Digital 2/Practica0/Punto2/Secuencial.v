module Secuencial (
    input clk,
    input rst,
    input start,
    input [3:0] x,
    input [4:0] a,      
    input way,         
    output [5:0] acc,
    output done
);
    wire add;
    wire inc;
    wire i_eq_a;
    wire acc_eq;
    wire [5:0] i;
    wire ctrl_rst;  
    wire rst_total;  
    assign rst_total = rst | ctrl_rst;

    
    Comp u_Comp_i (.a(i),.b(a),.igual(i_eq_a),
        .mayor());

    Comp u_Comp_acc (.a(acc),.b(6'd20),.igual(),
        .mayor(acc_eq));

    Increase u_Increase (.clk(clk),.rst(rst_total),
        .inc(inc),.i(i));

    Acumulador u_Acumulador (.clk(clk),.rst(rst_total),.add(add),.x(x),
        .a(a),.i(i),.way(way),.acc(acc));

    Control_Acumulador u_Control_Acumulador (.clk(clk),.w_start(start),
        .w_way(way),.i_eq_a(i_eq_a),.acc_eq(acc_eq),.done(done),
        .rst(ctrl_rst),.inc(inc),.add(add));

endmodule