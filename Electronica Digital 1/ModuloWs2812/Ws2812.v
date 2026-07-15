module Ws2812 (
    input clk,
    input [23:0] RGB,
    input init,
    input rst_cmd,
    output dout,
    output done
);
    wire ld;
    wire init_t;
    wire sh;
    wire z;
    wire [1:0] sel;
    wire dec;
    wire [23:0] corr;
    wire done_t;

    Shift u_Shift(.clk(clk),.ld(ld),.RGB(RGB),.sh(sh),.corr(corr));

    Count u_Count(.clk(clk),.ld(ld),.dec(dec),.z(z));

    Control_Ws2812 u_Control_Ws2812(.msb(corr[23]),.init(init),.rst_cmd(rst_cmd),.done_t(done_t),.z(z),.sh(sh),.init_t(init_t),.sel(sel)
    ,.dec(dec),.ld(ld),.done(done));

    Timer u_Timer(.init_t(init_t),.clk(clk),.sel(sel),.dout(dout),.done_t(done_t));

endmodule
    