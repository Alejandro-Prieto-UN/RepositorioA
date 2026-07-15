//Modulo Top del timer 
module Timer  (
    input init_t,
    input clk,
    input [1:0] sel,
    output dout,
    output done_t
);

    wire [15:0]out;
    wire inc;
    wire rst;
    wire z;
    parameter [15:0] T0h = 16'd10;
    parameter [15:0] T1h = 16'd20;
    parameter [15:0] Res = 16'd1250;
    parameter [15:0] Per = 16'd31;
    wire [1:0]sel_tim;
    wire [15:0]count_out;



    Count_out u_Count_out(.clk(clk),.rst(rst),.inc(inc),.count_out(count_out));

    Multiplex u_Multiplex(.T0h(T0h),.T1h(T1h),.Res(Res),.Per(Per),.sel_tim(sel_tim),.out(out));

    Control_Timer u_Control_Timer(.clk(clk),.z(z),.sel(sel),.init_t(init_t),.dout(dout),.done(done_t),.rst(rst),.inc(inc),.sel_tim(sel_tim));
    
    Comp u_Comp(.a(out),.b(count_out),.z(z));

endmodule
