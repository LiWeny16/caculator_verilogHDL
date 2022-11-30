`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:UESTC
// Engineer:Onion&&Tsjinsins
//
// Create Date: 2021/12/12 23:57:47
// Design Name:bigonion
// Module Name: beep
// Project Name:
// Target Devices:
// Tool Versions:1.2.1
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module main (
    input         clk,     // 时钟
    input  [11:0] sw,      // 开关
    input  [ 3:0] col,     // 按键各列
    output [ 3:0] row,     // 按键各行
    output [ 5:0] led,     // LED 
    output [ 7:0] seg,     // 一位段码信息
    output [ 5:0] posits,  // 段码各位
    output        beep
);

  wire clk1k, clk50;
  divclk clock (
      .clk(clk),
      .clk_ms(clk1k),
      .btnclk(clk50)
  );  //调用时钟分频模块

  wire [15:0] buttons;
  v_ajxd button (
      .clk(clk1k),
      .btn_clk(clk50),
      .col(col),
      .row(row),
      .btn_out(buttons)
  );  //调用按键模块

  reg [23:0] inputnumber = 0;
  reg [23:0] resultnumber = 0;
  reg [23:0] bin;

  wire [23:0] bcd;
  wire neg;
  assign led[0] = neg;
  bin2bcd trans (
      .bin(bin),
      .bcd(bcd),
      .neg(neg)
  );  // 把欲显示的数字转为 BCD 码
  ip_disp screen (
      .clk(clk),
      .rst(0),
      .dispdata(bcd),
      .seg(seg),
      .an(posits)
  );  // 调用数码管模块 

  reg  [15:0] b0 = 0;
  reg  [15:0] b1 = 0;
  wire [15:0] br;
  assign br = b0 & ~b1;
  always @(posedge clk1k) begin
    b0 <= buttons;
    b1 <= b0;
    if (br)
      if (br[3]) begin  // 0
        if (inputnumber < 'd100000) inputnumber = inputnumber * 10;
        bin = inputnumber;
      end else if (br[7]) begin  // 1
        if (inputnumber < 'd100000) inputnumber = inputnumber * 10 + 1;
        bin = inputnumber;
      end else if (br[6]) begin  // 2
        if (inputnumber < 'd100000) inputnumber = inputnumber * 10 + 2;
        bin = inputnumber;
      end else if (br[5]) begin  // 3
        if (inputnumber < 'd100000) inputnumber = inputnumber * 10 + 3;
        bin = inputnumber;
      end else if (br[11]) begin  // 4
        if (inputnumber < 'd100000) inputnumber = inputnumber * 10 + 4;
        bin = inputnumber;
      end else if (br[10]) begin  // 5
        if (inputnumber < 'd100000) inputnumber = inputnumber * 10 + 5;
        bin = inputnumber;
      end else if (br[9]) begin  // 6
        if (inputnumber < 'd100000) inputnumber = inputnumber * 10 + 6;
        bin = inputnumber;
      end else if (br[15]) begin  // 7
        if (inputnumber < 'd100000) inputnumber = inputnumber * 10 + 7;
        bin = inputnumber;
      end else if (br[14]) begin  // 8
        if (inputnumber < 'd100000) inputnumber = inputnumber * 10 + 8;
        bin = inputnumber;
      end else if (br[13]) begin  // 9
        if (inputnumber < 'd100000) inputnumber = inputnumber * 10 + 9;
        bin = inputnumber;
      end else if (br[2]) begin  // 退位
        inputnumber = inputnumber / 10;
        bin = inputnumber;
      end else if (br[1]) begin  // 归归归归归零！
        resultnumber = 0;
        bin = resultnumber;
        inputnumber = 0;
      end else if (br[0]) begin  // 加法
        resultnumber = resultnumber + inputnumber;
        bin = resultnumber;
        inputnumber = 0;
      end else if (br[4]) begin  // 减法
        resultnumber = resultnumber - inputnumber;
        bin = resultnumber;
        inputnumber = 0;
      end else if (br[8]) begin  // 乘法
        resultnumber = resultnumber * inputnumber;
        bin = resultnumber;
        inputnumber = 0;
      end else if (br[12]) begin  // 除法
        if (resultnumber[23] == 0) resultnumber = resultnumber / inputnumber;
        else resultnumber = 'h1000000 - ('h1000000 - resultnumber) / inputnumber;
        bin = resultnumber;
        inputnumber = 0;
      end
  end

  beep uut1 (
      .clk(clk),
      .beep(beep),
      .sw(sw),
      .buttons(buttons)
  );  //蜂鸣器模块



endmodule
