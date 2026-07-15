module LED_MEM (
    input [15:0] addr,    
    output reg [23:0] RGB 
);

    always @(*) begin
        case (addr)
            16'd0: RGB = 24'hFF0000; 
            16'd1: RGB = 24'h00FF00; 
            16'd2: RGB = 24'h0000FF; 
            16'd3: RGB = 24'hFFFF00; 
            16'd4: RGB = 24'hFF00FF; 
            
            default: RGB = 24'h000000; 
        endcase
    end

endmodule