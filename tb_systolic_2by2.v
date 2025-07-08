`timescale 1ns/1ns

module tb_systolic_2by2;
    // clock & reset
    reg         clk, rst;

    // streaming inputs
    reg  [7:0]  up1, up2;
    reg  [7:0]  left1, left2;

    // outputs
    wire [7:0]  out1, out2;

    // DUT 인스턴스
    systolic_2by2 dut (
        .clk    (clk),
        .rst    (rst),
        .up1    (up1),
        .up2    (up2),
        .left1  (left1),
        .left2  (left2),
        .out1   (out1),
        .out2   (out2)
    );

    // 5ns period clock
    initial clk = 0;
    always #5 clk = !clk;

    initial begin
        // 초기 reset
        rst = 1;
        #10 rst = 0;

        // --- 벡터 드라이브 순서 (원본과 동일) ---
        // CLK1
        up1   = 8'd9;   up2   = 8'd0;  // B33, 0
        left1 = 8'd0;   left2 = 8'd0;
        #10;

        // CLK2
        up1   = 8'd8;   up2   = 8'd0;  // B32, 0
        left1 = 8'd0;   left2 = 8'd1;  // A11
        #10;

        // CLK3
        up1   = 8'd7;   up2   = 8'd0;  // B31, 0
        left1 = 8'd0;   left2 = 8'd2;  // A12
        #10;

        // CLK4
        up1   = 8'd6;   up2   = 8'd0;  // B23, 0
        left1 = 8'd0;   left2 = 8'd3;  // A13
        #10;

        // CLK5
        up1   = 8'd5;   up2   = 8'd9;  // B22, B33
        left1 = 8'd0;   left2 = 8'd5;  // A21
        #10;

        // CLK6
        up1   = 8'd4;   up2   = 8'd8;  // B21, B32
        left1 = 8'd0;   left2 = 8'd6;  // A22
        #10;

        // CLK7
        up1   = 8'd3;   up2   = 8'd7;  // B13, B31
        left1 = 8'd0;   left2 = 8'd7;  // A23
        #10;

        // CLK8
        up1   = 8'd2;   up2   = 8'd6;  // B12, B23
        left1 = 8'd0;   left2 = 8'd9;  // A31
        #10;

        // CLK9
        up1   = 8'd1;   up2   = 8'd5;  // B11, B22
        left1 = 8'd0;   left2 = 8'd10; // A32
        #10;

        // CLK10
        up1   = 8'd0;   up2   = 8'd4;  // 0, B21
        left1 = 8'd0;   left2 = 8'd11; // A33
        #10;

        // CLK11
        up1   = 8'd0;   up2   = 8'd3;  // 0, B13
        left1 = 8'd0;   left2 = 8'd13; // A41
        #10;

        // CLK12
        up1   = 8'd0;   up2   = 8'd2;  // 0, B12
        left1 = 8'd0;   left2 = 8'd14; // A42
        #10;

        // CLK13
        up1   = 8'd0;   up2   = 8'd1;  // 0, B11
        left1 = 8'd0;   left2 = 8'd15; // A43
        #10;

        $finish;
    end
endmodule
