`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:UESTC
// Engineer:Onion
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


module beep(
           input clk,	//外部输入50MHz时钟信号
           input [11:0]sw,
           input [15:0]buttons,
           output reg beep	//蜂鸣器控制信号，1--响，0--不响
       );

//-------------------------------------
reg[19:0] cnt1;		//20位计数器
reg[19:0] cnt2;
//cnt计数器进行0-999999的循环计数，即btnclk时钟的1000_000分频，对应cnt一个周期为50Hz

always @ (posedge clk &sw[0] )

begin
    if(buttons[0])
    begin
        if(cnt2< 20'd303372)
            cnt2 = cnt2+1'b1;
        else
            cnt2 = 20'd0;
        //产生频率为50Hz，占空比为50%的蜂鸣器发声信号
        //always @ (posedge clk&sw[6])
        if(cnt2< 20'd151686)
            beep = 1'b1;	//蜂鸣器响
        else
            beep = 1'b0;		//蜂鸣器不响
    end

    if(buttons[1])
    begin
        if(cnt2< 20'd255104)
            cnt2 = cnt2+1'b1;
        else
            cnt2 = 20'd0;
        if(cnt2< 20'd127552)
            beep = 1'b1;    //蜂鸣器响
        else
            beep = 1'b0;        //蜂鸣器不响
    end

    if(buttons[2])
    begin
        if(cnt2< 20'd227272)
            cnt2 = cnt2+1'b1;
        else
            cnt2 = 20'd0;
        if(cnt2< 20'd113636)
            beep = 1'b1;    //蜂鸣器响
        else
            beep = 1'b0;        //蜂鸣器不响
    end

    if(buttons[3])
    begin
        if(cnt2< 20'd202476)
            cnt2 = cnt2+1'b1;
        else
            cnt2 = 20'd0;
        if(cnt2< 20'd101238)
            beep = 1'b1;    //蜂鸣器响
        else
            beep = 1'b0;        //蜂鸣器不响
    end

    if(buttons[3]&sw[1])
    begin
        if(cnt2< 20'd214516)
            cnt2 = cnt2+1'b1;
        else
            cnt2 = 20'd0;
        if(cnt2< 20'd107258)
            beep = 1'b1;    //蜂鸣器响
        else
            beep = 1'b0;        //蜂鸣器不响
    end

    if(buttons[4])
    begin   //c4
        if(cnt2< 20'd191112)
            cnt2 = cnt2+1'b1;
        else
            cnt2 = 20'd0;
        if(cnt2< 20'd95556)
            beep = 1'b1;    //蜂鸣器响
        else
            beep = 1'b0;        //蜂鸣器不响
    end

    if(buttons[5])
    begin
        if(cnt2< 20'd170262)
            cnt2 = cnt2+1'b1;
        else
            cnt2 = 20'd0;
        if(cnt2< 20'd85131)
            beep = 1'b1;    //蜂鸣器响
        else
            beep = 1'b0;        //蜂鸣器不响
    end

    if(buttons[6])
    begin
        if(cnt2< 20'd151686)
            cnt2 = cnt2+1'b1;
        else
            cnt2 = 20'd0;
        if(cnt2< 20'd75843)
            beep = 1'b1;    //蜂鸣器响
        else
            beep = 1'b0;        //蜂鸣器不响
    end

    if(buttons[7])
    begin
        if(cnt2< 20'd143172)
            cnt2 = cnt2+1'b1;
        else
            cnt2 = 20'd0;
        if(cnt2< 20'd71586)
            beep = 1'b1;    //蜂鸣器响
        else
            beep = 1'b0;        //蜂鸣器不响
    end

    if(buttons[8])
    begin
        if(cnt2< 20'd127552)
            cnt2 = cnt2+1'b1;
        else
            cnt2 = 20'd0;
        if(cnt2< 20'd63776)
            beep = 1'b1;    //蜂鸣器响
        else
            beep = 1'b0;        //蜂鸣器不响
    end

    if(buttons[9])
    begin //A4
        if(cnt2< 20'd113636)
            cnt2 = cnt2+1'b1;
        else
            cnt2 = 20'd0;
        if(cnt2< 20'd56818)
            beep = 1'b1;    //蜂鸣器响
        else
            beep = 1'b0;        //蜂鸣器不响
    end

    if(buttons[10])
    begin  //B4
        if(cnt2< 20'd101238)
            cnt2 = cnt2+1'b1;
        else
            cnt2 = 20'd0;
        if(cnt2< 20'd50619)
            beep = 1'b1;    //蜂鸣器响
        else
            beep = 1'b0;        //蜂鸣器不响
    end

    if(buttons[11])
    begin
        if(cnt2< 20'd95556)
            cnt2 = cnt2+1'b1;
        else
            cnt2 = 20'd0;
        if(cnt2< 20'd47778)
            beep = 1'b1;    //蜂鸣器响
        else
            beep = 1'b0;        //蜂鸣器不响
    end

    if(buttons[12])
    begin
        if(cnt2< 20'd85131)
            cnt2 = cnt2+1'b1;
        else
            cnt2 = 20'd0;
        if(cnt2< 20'd42565)
            beep = 1'b1;    //蜂鸣器响
        else
            beep = 1'b0;        //蜂鸣器不响
    end

    if(buttons[13])
    begin
        if(cnt2< 20'd75843)
            cnt2 = cnt2+1'b1;
        else
            cnt2 = 20'd0;
        if(cnt2< 20'd37921)
            beep = 1'b1;    //蜂鸣器响
        else
            beep = 1'b0;        //蜂鸣器不响
    end

    if(buttons[14])
    begin
        if(cnt2< 20'd63776)
            cnt2 = cnt2+1'b1;
        else
            cnt2 = 20'd0;
        if(cnt2< 20'd31888)
            beep = 1'b1;    //蜂鸣器响
        else
            beep = 1'b0;        //蜂鸣器不响
    end

    if(buttons[15])
    begin
        if(cnt2< 20'd56818)
            cnt2 = cnt2+1'b1;
        else
            cnt2 = 20'd0;
        if(cnt2< 20'd28409)
            beep = 1'b1;    //蜂鸣器响
        else
            beep = 1'b0;        //蜂鸣器不响
    end



end
endmodule
