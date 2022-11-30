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
    input         clk,     // ʱ��
    input  [11:0] sw,      // ����
    input  [ 3:0] col,     // ��������
    output [ 3:0] row,     // ��������
    output [ 5:0] led,     // LED 
    output [ 7:0] seg,     // һλ������Ϣ
    output [ 5:0] posits,  // �����λ
    output        beep
);

  wire clk1k, clk50;
  divclk clock (
      .clk(clk),
      .clk_ms(clk1k),
      .btnclk(clk50)
  );  //����ʱ�ӷ�Ƶģ��

  wire [15:0] buttons;
  v_ajxd button (
      .clk(clk1k),
      .btn_clk(clk50),
      .col(col),
      .row(row),
      .btn_out(buttons)
  );  //���ð���ģ��

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
  );  // ������ʾ������תΪ BCD ��
  ip_disp screen (
      .clk(clk),
      .rst(0),
      .dispdata(bcd),
      .seg(seg),
      .an(posits)
  );  // ���������ģ�� 

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
      end else if (br[2]) begin  // ��λ
        inputnumber = inputnumber / 10;
        bin = inputnumber;
      end else if (br[1]) begin  // �������㣡
        resultnumber = 0;
        bin = resultnumber;
        inputnumber = 0;
      end else if (br[0]) begin  // �ӷ�
        resultnumber = resultnumber + inputnumber;
        bin = resultnumber;
        inputnumber = 0;
      end else if (br[4]) begin  // ����
        resultnumber = resultnumber - inputnumber;
        bin = resultnumber;
        inputnumber = 0;
      end else if (br[8]) begin  // �˷�
        resultnumber = resultnumber * inputnumber;
        bin = resultnumber;
        inputnumber = 0;
      end else if (br[12]) begin  // ����
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
  );  //������ģ��



endmodule
