module systolic_2by2(
    input clk, rst,
    input [7:0] up1, up2,
    input [7:0] left1, left2,
    output [7:0] out1, out2
);

    wire [7:0] wire1, wire2, wire3, wire4, wire5, wire6, wire7, wire8, wire9, wire10, wire11, wire12, wire13, wire14, wire15, wire16, wire17;

    /*  in_a : 왼쪽에서 들어옴, in_b : 위쪽에서 들어옴
             up1   up2    
              |      |      
        0 => PE11  PE12 => out_a:wire1/wire2 /  | out_down:wire3/wire4/
    left2 => PE21  PE22 => in_b:wire3/wire4/w   | out_a: wire6/wire7/ | out_down:wire8/wire9/wire10
              |      |  

    왼쪽에서 in_a가 들어오고 위쪽에서 in_b가 들어오고
    아래쪽으로 in_a 그대로 또는 init * in_a + in_b가 out_down으로 나간다
    */

    // 위쪽 두개는 위의 것을 그냥 전달, 따라서 in_a = 0, init : 임의 값1, in_b는 up1, up2 
    // out_down = in_a * init + in_b = in_b
    SinglePEv1_comb PE11(.clk(clk), .rst(rst), .in_a(8'b0), .in_b(up1), .init(8'b1), .out_a(wire1), .out_down(wire3));   
    SinglePEv1_comb PE12(.clk(clk), .rst(rst), .in_a(wire1), .in_b(up2), .init(8'b1), .out_a(wire2), .out_down(wire4));    
    
    SinglePEv1_comb PE21(.clk(clk), .rst(rst), .in_a(left2), .in_b(8'b0), .init(wire3), .out_a(wire6), .out_down(wire8)); 
    SinglePEv1_comb PE22(.clk(clk), .rst(rst), .in_a(wire6), .in_b(8'b0), .init(wire4), .out_a(wire7), .out_down(wire9)); 
    
    assign out1 = wire8;
    assign out2 = wire9;
    // C11, C12 를 위한 stream given : 13 cycle =>  out1 누산: C11 | out2 누산 : C21
    // C22, C12 를 위한 stream given : 13 cycle => out1 누산 : C22 | out2 누산 : C12

endmodule
