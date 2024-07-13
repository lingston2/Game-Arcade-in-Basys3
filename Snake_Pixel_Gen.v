module LocateRandomApple(
    input clk,
    output [9:0] TargetX ,
    output [9:0] TargetY
);
parameter MaxX = 60;
parameter MaxY = 42;
parameter MinX = 2;
parameter MinY = 2;
reg[6:0] CounterX = 2;
reg[5:0] CounterY = 2;

    always@(posedge clk) begin
        if(CounterX<MaxX)
            CounterX <= CounterX+2; //640 - 4
        else
            CounterX <= 2;
        if(CounterY<MaxY)
            CounterY <= CounterY+1; //480 - 3
        else
            CounterY <= 2;
    end
 
    assign TargetX = CounterX*10;
    assign TargetY = CounterY*10;
   
endmodule


module SnakeGame(
    input clkTarget,
    input clkVGA,
    input mainCLK,
    input [9:0] h_cnt,
    input [9:0] v_cnt,
    input valid,
    input [2:0]CurState,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output reg Consume = 1'b0,
    output reg [6:0] length = 4'd1,
    input reset
);



reg [3:0]CurRed = 4'b0000;
reg [3:0]CurGreen = 4'b0000;
reg [3:0]CurBlue = 4'b0000;

wire[9:0] RandomX;
wire[9:0] RandomY;

LocateRandomApple LRA1(clkTarget, RandomX, RandomY);

reg[9:0] AppleX;
reg[9:0] AppleY;

reg [9:0]SnakeXMemory[128-1:0];
reg [9:0]SnakeYMemory[128-1:0];
reg [9:0]SnakeXMemoryHead = 10'd300;
reg [9:0]SnakeYMemoryHead = 10'd300;
reg [6:0]SnakeXCounter;
reg [6:0]SnakeYCounter;
reg [6:0]SnakeCounter=0;
reg [6:0]SnakeOn1;
reg SnakeOn2[128-1:0]; //What Lenght its On.
reg [6:0]SnakeOnCounter=0; //For Iteration
reg [6:0]SnakeOnCounter2=0; //For Enable
reg Start = 1'b1;
reg FlagLoop;
reg FlagLoopFinish=0;
reg SnakeHeadLoc;
reg AppleLoc;
reg BorderLoc;
reg SnakeLoc;
reg BorderHit;
reg BodyCheck1;
reg BodyCheck2;
reg BodyCheck3;
reg BodyCheck4;
reg BodyCheck5;
reg BodyCheck6;
reg BodyCheck7;
reg BodyCheck8;
reg BodyCheck9;
reg BodyCheck10;
reg BodyCheck11;
reg BodyCheck12;
reg BodyCheck13;
reg BodyCheck14;
reg BodyCheck15;
reg BodyCheck16;
reg BodyCheck17;
reg BodyCheck18;
reg BodyCheck19;
reg BodyCheck20;
reg BodyCheck21;
reg BodyCheck22;
reg BodyCheck23;
reg BodyCheck24;
reg BodyCheck25;
reg BodyCheck26;
reg BodyCheck27;
reg BodyCheck28;
reg BodyCheck29;
reg BodyCheck30;
reg BodyCheck31;
reg BodyHit;
parameter SnakeStartingPointX=320;
parameter SnakeStartingPointY=240;
reg snakebody;

reg GameOverStatus = 1'b0;

always@(posedge mainCLK)begin
    //For Eating Own Body
        BodyCheck1 <= ((SnakeXMemory[0]==SnakeXMemory[1]) && (SnakeYMemory[0]==SnakeYMemory[1]) ) ? 1'b1 : 1'b0;
        BodyCheck2 <= ((SnakeXMemory[0]==SnakeXMemory[2]) && (SnakeYMemory[0]==SnakeYMemory[2]) ) ? 1'b1 : 1'b0;
        BodyCheck3 <= ((SnakeXMemory[0]==SnakeXMemory[3]) && (SnakeYMemory[0]==SnakeYMemory[3]) ) ? 1'b1 : 1'b0;
        BodyCheck4 <= ((SnakeXMemory[0]==SnakeXMemory[4]) && (SnakeYMemory[0]==SnakeYMemory[4]) ) ? 1'b1 : 1'b0;
        BodyCheck5 <= ((SnakeXMemory[0]==SnakeXMemory[5]) && (SnakeYMemory[0]==SnakeYMemory[5]) ) ? 1'b1 : 1'b0;
        BodyCheck6 <= ((SnakeXMemory[0]==SnakeXMemory[6]) && (SnakeYMemory[0]==SnakeYMemory[6]) ) ? 1'b1 : 1'b0;
        BodyCheck7 <= ((SnakeXMemory[0]==SnakeXMemory[7]) && (SnakeYMemory[0]==SnakeYMemory[7]) ) ? 1'b1 : 1'b0;
        BodyCheck8 <= ((SnakeXMemory[0]==SnakeXMemory[8]) && (SnakeYMemory[0]==SnakeYMemory[8]) ) ? 1'b1 : 1'b0;
        BodyCheck9 <= ((SnakeXMemory[0]==SnakeXMemory[9]) && (SnakeYMemory[0]==SnakeYMemory[9]) ) ? 1'b1 : 1'b0;
        BodyCheck10 <= ((SnakeXMemory[0]==SnakeXMemory[10]) && (SnakeYMemory[0]==SnakeYMemory[10]) ) ? 1'b1 : 1'b0;
        BodyCheck11 <= ((SnakeXMemory[0]==SnakeXMemory[11]) && (SnakeYMemory[0]==SnakeYMemory[11]) ) ? 1'b1 : 1'b0;
        BodyCheck12 <= ((SnakeXMemory[0]==SnakeXMemory[12]) && (SnakeYMemory[0]==SnakeYMemory[12]) ) ? 1'b1 : 1'b0;
        BodyCheck13 <= ((SnakeXMemory[0]==SnakeXMemory[13]) && (SnakeYMemory[0]==SnakeYMemory[13]) ) ? 1'b1 : 1'b0;
        BodyCheck14 <= ((SnakeXMemory[0]==SnakeXMemory[14]) && (SnakeYMemory[0]==SnakeYMemory[14]) ) ? 1'b1 : 1'b0;
        BodyCheck15 <= ((SnakeXMemory[0]==SnakeXMemory[15]) && (SnakeYMemory[0]==SnakeYMemory[15]) ) ? 1'b1 : 1'b0;
        BodyCheck16 <= ((SnakeXMemory[0]==SnakeXMemory[16]) && (SnakeYMemory[0]==SnakeYMemory[16]) ) ? 1'b1 : 1'b0;
        BodyCheck17 <= ((SnakeXMemory[0]==SnakeXMemory[17]) && (SnakeYMemory[0]==SnakeYMemory[17]) ) ? 1'b1 : 1'b0;
        BodyCheck18 <= ((SnakeXMemory[0]==SnakeXMemory[18]) && (SnakeYMemory[0]==SnakeYMemory[18]) ) ? 1'b1 : 1'b0;
        BodyCheck19 <= ((SnakeXMemory[0]==SnakeXMemory[19]) && (SnakeYMemory[0]==SnakeYMemory[19]) ) ? 1'b1 : 1'b0;
        BodyCheck20 <= ((SnakeXMemory[0]==SnakeXMemory[20]) && (SnakeYMemory[0]==SnakeYMemory[20]) ) ? 1'b1 : 1'b0;
        BodyCheck21 <= ((SnakeXMemory[0]==SnakeXMemory[21]) && (SnakeYMemory[0]==SnakeYMemory[21]) ) ? 1'b1 : 1'b0;
        BodyCheck22 <= ((SnakeXMemory[0]==SnakeXMemory[22]) && (SnakeYMemory[0]==SnakeYMemory[22]) ) ? 1'b1 : 1'b0;
        BodyCheck23 <= ((SnakeXMemory[0]==SnakeXMemory[23]) && (SnakeYMemory[0]==SnakeYMemory[23]) ) ? 1'b1 : 1'b0;
        BodyCheck24 <= ((SnakeXMemory[0]==SnakeXMemory[24]) && (SnakeYMemory[0]==SnakeYMemory[24]) ) ? 1'b1 : 1'b0;
        BodyCheck25 <= ((SnakeXMemory[0]==SnakeXMemory[25]) && (SnakeYMemory[0]==SnakeYMemory[25]) ) ? 1'b1 : 1'b0;
        BodyCheck26 <= ((SnakeXMemory[0]==SnakeXMemory[26]) && (SnakeYMemory[0]==SnakeYMemory[26]) ) ? 1'b1 : 1'b0;
        BodyCheck27 <= ((SnakeXMemory[0]==SnakeXMemory[27]) && (SnakeYMemory[0]==SnakeYMemory[27]) ) ? 1'b1 : 1'b0;
        BodyCheck28 <= ((SnakeXMemory[0]==SnakeXMemory[28]) && (SnakeYMemory[0]==SnakeYMemory[28]) ) ? 1'b1 : 1'b0;
        BodyCheck29 <= ((SnakeXMemory[0]==SnakeXMemory[29]) && (SnakeYMemory[0]==SnakeYMemory[29]) ) ? 1'b1 : 1'b0;
        BodyCheck30 <= ((SnakeXMemory[0]==SnakeXMemory[30]) && (SnakeYMemory[0]==SnakeYMemory[30]) ) ? 1'b1 : 1'b0;
        BodyCheck31 <= ((SnakeXMemory[0]==SnakeXMemory[31]) && (SnakeYMemory[0]==SnakeYMemory[31]) ) ? 1'b1 : 1'b0;
   end

always@(posedge clkVGA)begin
        SnakeHeadLoc <= ((SnakeXMemory[0]<=h_cnt) && (h_cnt < (SnakeXMemory[0]+10) )) && ((SnakeYMemory[0]<=v_cnt) && (v_cnt < (SnakeYMemory[0]+10) )) ? 1'b1 : 1'b0;
		AppleLoc <=  ( (h_cnt >= AppleX && h_cnt < (AppleX + 10)) &&  (v_cnt >= AppleY && v_cnt < (AppleY + 10)) ) ? 1'b1 : 1'b0;
		BorderLoc <= ((h_cnt<20) || (h_cnt>620) || (v_cnt<20) || (v_cnt>460)) ? 1'b1 : 1'b0;
		Consume <= SnakeHeadLoc && AppleLoc;
		BorderHit <= ((SnakeXMemory[0]<20) || (620 < SnakeXMemory[0]+10) || (SnakeYMemory[0]<20) || (460 < SnakeYMemory[0]+10)) ? 1'b1 : 1'b0;
		BodyHit <= ( BodyCheck1 || BodyCheck2 || BodyCheck3 || BodyCheck4 || BodyCheck5 || BodyCheck6 || BodyCheck7 || BodyCheck8 || BodyCheck9 || BodyCheck10 
		|| BodyCheck11 || BodyCheck12 || BodyCheck13 || BodyCheck14 || BodyCheck15 
		|| BodyCheck16 || BodyCheck17 || BodyCheck18 || BodyCheck19 || BodyCheck20 || BodyCheck21 || BodyCheck22 || BodyCheck23 || BodyCheck24 || BodyCheck25 
		|| BodyCheck26 || BodyCheck27 || BodyCheck28 || BodyCheck29 || BodyCheck30 || BodyCheck31
		) ? 1'b1 : 1'b0;

end
//assign Consume = SnakeHeadLoc && AppleLoc;

//For Consume Apple
reg consumeHandshake = 1'b1;
reg realConsume = 1'b0;
always@(posedge mainCLK)begin
    if( consumeHandshake == 1'b1)begin
        if (Consume == 1'b1)begin
            realConsume <= 1'b1;
        end else begin
            realConsume <= realConsume;
        end
    end else begin
        realConsume <= 1'b0;
    end
end


//For HitBorder & Body = Gameover
always@(posedge mainCLK)begin
    if(Start==1'b1 || reset == 1'b1)begin
        GameOverStatus<=1'b0;
    end
    else begin
        if(BorderHit==1'b1 || BodyHit==1'b1 || GameOverStatus==1'b1)begin
            GameOverStatus<=1'b1;
        end
        else begin
            GameOverStatus<=1'b0;
        end
    end
end

//Main Engine
always@(posedge clkTarget)begin
    if(Start==1'b1)begin
        AppleX<=10'd200;
        AppleY<=10'd100;
        SnakeXMemory[0] <= 10'd300;
        SnakeYMemory[0] <= 10'd300;
        Start<=0;
    end else if (reset == 1'b1)begin
        AppleX<=10'd200;
        AppleY<=10'd100;
        SnakeXMemory[0] <= 10'd300;
        SnakeYMemory[0] <= 10'd300;
        Start<=0;
        length <= 4'd1;
    end
    else begin

    if(realConsume == 1'b1)begin
            AppleX<=RandomX;
            AppleY<=RandomY;
            consumeHandshake <= 1'b0;
            length <= length + 1'b1;
            SnakeOn2[length]<=1'b1;
            
    end else begin
        consumeHandshake <= 1'b1;
    end        
        if(CurState==3'd0)begin//Up
            if(SnakeYMemory[0]<=10)
                SnakeYMemory[0]<=10;
            else
                SnakeYMemory[0] <= (SnakeYMemory[0] - 10);
        end
        else if(CurState==3'd1)begin//Down
            if(460<=SnakeYMemory[0])
                SnakeYMemory[0]<=460;
            else
                SnakeYMemory[0] <= (SnakeYMemory[0] + 10);
        end 
        else if(CurState==3'd2)begin//Left
            if(SnakeXMemory[0]<=10)
                SnakeXMemory[0]<=10;
            else
                SnakeXMemory[0] <= (SnakeXMemory[0] - 10);
        end 
        else begin//Right
            if(620<=SnakeXMemory[0])
                SnakeXMemory[0]<=620;
            else
                SnakeXMemory[0] <= (SnakeXMemory[0] + 10);
        end
    end

// testing
//AppleX<=RandomX;
//AppleY<=RandomY;
end

//Printing
always@(posedge clkVGA)begin
    
    if(valid) begin
        //Print Border
        if(((h_cnt<20) || (h_cnt>620) || (v_cnt<20) || (v_cnt>460)) ) begin
            if(GameOverStatus==1'b1)
                CurBlue<= 4'b0000;
            else
                CurBlue<= 4'b1111;
        end
        else begin
            CurBlue<=4'b0000;
        end
        
        //Print Apple
        if( BorderLoc==0&&((AppleX<=h_cnt) && (h_cnt<AppleX+10)) && ((AppleY<=v_cnt) && (v_cnt<AppleY+10)) ) begin
            CurRed<=4'b1111;
        end
        else begin
            if(GameOverStatus==1'b1)
                CurRed<= 4'b1111;
            else
                CurRed<= 4'b0000;  
        end
        
//        if( ((SnakeXMemory[0]+2<=h_cnt) && (h_cnt<SnakeXMemory[0]+12)) && ((SnakeYMemory[0]<=v_cnt) && (v_cnt<SnakeYMemory[0]+10)) || snakebody == 1'b1 )begin
        if( ((SnakeXMemory[0]<=h_cnt) && (h_cnt<SnakeXMemory[0]+10)) && ((SnakeYMemory[0]<=v_cnt) && (v_cnt<SnakeYMemory[0]+10)) || snakebody == 1'b1 )begin
            if(GameOverStatus==1'b1)
                CurGreen<= 4'b0000;
            else
                CurGreen <= 4'b1111;
        end else begin
            CurGreen <= 4'b0000;
        end
        
    end
    else begin
        CurRed <= 4'b0000;
        CurBlue <= 4'b0000;
        CurGreen <= 4'b0000;
    end
end


//Testing: If not Reg
assign vgaRed = CurRed;
assign vgaGreen = CurGreen;
assign vgaBlue = CurBlue;


/////////////////////////////////////////BODY UPDATE///////////////////////////////////////////


always@(posedge clkTarget)begin
    if(reset == 1'b1)begin
        SnakeXMemory[1] <= 10'd700;
        SnakeYMemory[1] <= 10'd700;
        SnakeXMemory[2] <= 10'd700;
        SnakeYMemory[2] <= 10'd700;
        SnakeXMemory[3] <= 10'd700;
        SnakeYMemory[3] <= 10'd700;
        SnakeXMemory[4] <= 10'd700;
        SnakeYMemory[4] <= 10'd700;
        SnakeXMemory[5] <= 10'd700;
        SnakeYMemory[5] <= 10'd700;
        SnakeXMemory[6] <= 10'd700;
        SnakeYMemory[6] <= 10'd700;
        SnakeXMemory[7] <= 10'd700;
        SnakeYMemory[7] <= 10'd700;
        SnakeXMemory[8] <= 10'd700;
        SnakeYMemory[8] <= 10'd700;
        SnakeXMemory[9] <= 10'd700;
        SnakeYMemory[9] <= 10'd700;
        SnakeXMemory[10] <= 10'd700;
        SnakeYMemory[10] <= 10'd700;
        SnakeXMemory[11] <= 10'd700;
        SnakeYMemory[11] <= 10'd700;
        SnakeXMemory[12] <= 10'd700;
        SnakeYMemory[12] <= 10'd700;
        SnakeXMemory[13] <= 10'd700;
        SnakeYMemory[13] <= 10'd700;
        SnakeXMemory[14] <= 10'd700;
        SnakeYMemory[14] <= 10'd700;
        SnakeXMemory[15] <= 10'd700;
        SnakeYMemory[15] <= 10'd700;
        SnakeXMemory[16] <= 10'd700;
        SnakeYMemory[16] <= 10'd700;
        SnakeXMemory[17] <= 10'd700;
        SnakeYMemory[17] <= 10'd700;
        SnakeXMemory[18] <= 10'd700;
        SnakeYMemory[18] <= 10'd700;
        SnakeXMemory[19] <= 10'd700;
        SnakeYMemory[19] <= 10'd700;
        SnakeXMemory[20] <= 10'd700;
        SnakeYMemory[20] <= 10'd700;
        SnakeXMemory[21] <= 10'd700;
        SnakeYMemory[21] <= 10'd700;
        SnakeXMemory[22] <= 10'd700;
        SnakeYMemory[22] <= 10'd700;
        SnakeXMemory[23] <= 10'd700;
        SnakeYMemory[23] <= 10'd700;
        SnakeXMemory[24] <= 10'd700;
        SnakeYMemory[24] <= 10'd700;
        SnakeXMemory[25] <= 10'd700;
        SnakeYMemory[25] <= 10'd700;
        SnakeXMemory[26] <= 10'd700;
        SnakeYMemory[26] <= 10'd700;
        SnakeXMemory[27] <= 10'd700;
        SnakeYMemory[27] <= 10'd700;
        SnakeXMemory[28] <= 10'd700;
        SnakeYMemory[28] <= 10'd700;
        SnakeXMemory[29] <= 10'd700;
        SnakeYMemory[29] <= 10'd700;
        SnakeXMemory[30] <= 10'd700;
        SnakeYMemory[30] <= 10'd700;
        SnakeXMemory[31] <= 10'd700;
        SnakeYMemory[31] <= 10'd700;
    end
    else begin
        if (length >= 2) begin
            SnakeXMemory[1] <= SnakeXMemory[0];
            SnakeYMemory[1] <= SnakeYMemory[0];
        end
        if (length >= 3) begin
            SnakeXMemory[2] <= SnakeXMemory[1];
            SnakeYMemory[2] <= SnakeYMemory[1];
        end
        if (length >= 4) begin
            SnakeXMemory[3] <= SnakeXMemory[2];
            SnakeYMemory[3] <= SnakeYMemory[2];
        end
        if (length >= 5) begin
            SnakeXMemory[4] <= SnakeXMemory[3];
            SnakeYMemory[4] <= SnakeYMemory[3];
        end
        if (length >= 6) begin
            SnakeXMemory[5] <= SnakeXMemory[4];
            SnakeYMemory[5] <= SnakeYMemory[4];
        end
        if (length >= 7) begin
            SnakeXMemory[6] <= SnakeXMemory[5];
            SnakeYMemory[6] <= SnakeYMemory[5];
        end
        if (length >= 8) begin
            SnakeXMemory[7] <= SnakeXMemory[6];
            SnakeYMemory[7] <= SnakeYMemory[6];
        end
        if (length >= 9) begin
            SnakeXMemory[8] <= SnakeXMemory[7];
            SnakeYMemory[8] <= SnakeYMemory[7];
        end
        if (length >= 10) begin
            SnakeXMemory[9] <= SnakeXMemory[8];
            SnakeYMemory[9] <= SnakeYMemory[8];
        end
        if (length >= 11) begin
            SnakeXMemory[10] <= SnakeXMemory[9];
            SnakeYMemory[10] <= SnakeYMemory[9];
        end
        if (length >= 12) begin
            SnakeXMemory[11] <= SnakeXMemory[10];
            SnakeYMemory[11] <= SnakeYMemory[10];
        end
        if (length >= 13) begin
            SnakeXMemory[12] <= SnakeXMemory[11];
            SnakeYMemory[12] <= SnakeYMemory[11];
        end
        if (length >= 14) begin
            SnakeXMemory[13] <= SnakeXMemory[12];
            SnakeYMemory[13] <= SnakeYMemory[12];
        end
        if (length >= 15) begin
            SnakeXMemory[14] <= SnakeXMemory[13];
            SnakeYMemory[14] <= SnakeYMemory[13];
        end
        if (length >= 16) begin
            SnakeXMemory[15] <= SnakeXMemory[14];
            SnakeYMemory[15] <= SnakeYMemory[14];
        end
        if (length >= 17) begin
            SnakeXMemory[16] <= SnakeXMemory[15];
            SnakeYMemory[16] <= SnakeYMemory[15];
        end
        if (length >= 18) begin
            SnakeXMemory[17] <= SnakeXMemory[16];
            SnakeYMemory[17] <= SnakeYMemory[16];
        end
        if (length >= 19) begin
            SnakeXMemory[18] <= SnakeXMemory[17];
            SnakeYMemory[18] <= SnakeYMemory[17];
        end
        if (length >= 20) begin
            SnakeXMemory[19] <= SnakeXMemory[18];
            SnakeYMemory[19] <= SnakeYMemory[18];
        end
        if (length >= 21) begin
            SnakeXMemory[20] <= SnakeXMemory[19];
            SnakeYMemory[20] <= SnakeYMemory[19];
        end
        if (length >= 22) begin
            SnakeXMemory[21] <= SnakeXMemory[20];
            SnakeYMemory[21] <= SnakeYMemory[20];
        end
        if (length >= 23) begin
            SnakeXMemory[22] <= SnakeXMemory[21];
            SnakeYMemory[22] <= SnakeYMemory[21];
        end
        if (length >= 24) begin
            SnakeXMemory[23] <= SnakeXMemory[22];
            SnakeYMemory[23] <= SnakeYMemory[22];
        end
        if (length >= 25) begin
            SnakeXMemory[24] <= SnakeXMemory[23];
            SnakeYMemory[24] <= SnakeYMemory[23];
        end
        if (length >= 26) begin
            SnakeXMemory[25] <= SnakeXMemory[24];
            SnakeYMemory[25] <= SnakeYMemory[24];
        end
        if (length >= 27) begin
            SnakeXMemory[26] <= SnakeXMemory[25];
            SnakeYMemory[26] <= SnakeYMemory[25];
        end
        if (length >= 29) begin
            SnakeXMemory[27] <= SnakeXMemory[26];
            SnakeYMemory[27] <= SnakeYMemory[26];
        end
        if (length >= 29) begin
            SnakeXMemory[28] <= SnakeXMemory[27];
            SnakeYMemory[28] <= SnakeYMemory[27];
        end
        if (length >= 30) begin
            SnakeXMemory[29] <= SnakeXMemory[28];
            SnakeYMemory[29] <= SnakeYMemory[28];
        end
        if (length >= 31) begin
            SnakeXMemory[30] <= SnakeXMemory[29];
            SnakeYMemory[30] <= SnakeYMemory[29];
        end
        if (length >= 32) begin
            SnakeXMemory[31] <= SnakeXMemory[30];
            SnakeYMemory[31] <= SnakeYMemory[30];
        end
    end
end


////////////////////////////////////////////////////////////////////////////////////////////////

/////////////BODY DETECTOR///////////////////////////////////////////////////
reg snakebody1;
reg snakebody2;
reg snakebody3;
reg snakebody4;
reg snakebody5;
reg snakebody6;
reg snakebody7;
reg snakebody8;
reg snakebody9;
reg snakebody10;
reg snakebody11;
reg snakebody12;
reg snakebody13;
reg snakebody14;
reg snakebody15;
reg snakebody16;
reg snakebody17;
reg snakebody18;
reg snakebody19;
reg snakebody20;
reg snakebody21;
reg snakebody22;
reg snakebody23;
reg snakebody24;
reg snakebody25;
reg snakebody26;
reg snakebody27;
reg snakebody28;
reg snakebody29;
reg snakebody30;
reg snakebody31;


always@(posedge clkVGA)begin
    snakebody1 <= (length >= 2 && SnakeOn2[1]&& ((SnakeXMemory[1]-2 <= h_cnt) && (h_cnt < SnakeXMemory[1] + 10-2)) && ((SnakeYMemory[1] <= v_cnt) && (v_cnt < SnakeYMemory[1] + 10)) ) ? 1'b1 : 1'b0;
    snakebody2 <= (length >= 3 && SnakeOn2[2]&& ((SnakeXMemory[2]-2 <= h_cnt) && (h_cnt < SnakeXMemory[2] + 10-2)) && ((SnakeYMemory[2] <= v_cnt) && (v_cnt < SnakeYMemory[2] + 10)) ) ? 1'b1 : 1'b0;
    snakebody3 <= (length >= 4 && SnakeOn2[3]&& ((SnakeXMemory[3]-2 <= h_cnt) && (h_cnt < SnakeXMemory[3] + 10-2)) && ((SnakeYMemory[3] <= v_cnt) && (v_cnt < SnakeYMemory[3] + 10)) ) ? 1'b1 : 1'b0;
    snakebody4 <= (length >= 5 && SnakeOn2[4]&& ((SnakeXMemory[4]-2 <= h_cnt) && (h_cnt < SnakeXMemory[4] + 10-2)) && ((SnakeYMemory[4] <= v_cnt) && (v_cnt < SnakeYMemory[4] + 10)) ) ? 1'b1 : 1'b0;
    snakebody5 <= (length >= 6 && SnakeOn2[5]&& ((SnakeXMemory[5]-2 <= h_cnt) && (h_cnt < SnakeXMemory[5] + 10-2)) && ((SnakeYMemory[5] <= v_cnt) && (v_cnt < SnakeYMemory[5] + 10)) ) ? 1'b1 : 1'b0;
    snakebody6 <= (length >= 7 && SnakeOn2[6]&& ((SnakeXMemory[6]-2 <= h_cnt) && (h_cnt < SnakeXMemory[6] + 10-2)) && ((SnakeYMemory[6] <= v_cnt) && (v_cnt < SnakeYMemory[6] + 10)) ) ? 1'b1 : 1'b0;
    snakebody7 <= (length >= 8 && SnakeOn2[7]&& ((SnakeXMemory[7]-2 <= h_cnt) && (h_cnt < SnakeXMemory[7] + 10-2)) && ((SnakeYMemory[7] <= v_cnt) && (v_cnt < SnakeYMemory[7] + 10)) ) ? 1'b1 : 1'b0;
    snakebody8 <= (length >= 9 && SnakeOn2[8]&& ((SnakeXMemory[8]-2 <= h_cnt) && (h_cnt < SnakeXMemory[8] + 10-2)) && ((SnakeYMemory[8] <= v_cnt) && (v_cnt < SnakeYMemory[8] + 10)) ) ? 1'b1 : 1'b0;
    snakebody9 <= (length >= 10 && SnakeOn2[9]&& ((SnakeXMemory[9]-2 <= h_cnt) && (h_cnt < SnakeXMemory[9] + 10-2)) && ((SnakeYMemory[9] <= v_cnt) && (v_cnt < SnakeYMemory[9] + 10)) ) ? 1'b1 : 1'b0;
    snakebody10 <= (length >= 11 && SnakeOn2[10]&& ((SnakeXMemory[10]-2 <= h_cnt) && (h_cnt < SnakeXMemory[10] + 10-2)) && ((SnakeYMemory[10] <= v_cnt) && (v_cnt < SnakeYMemory[10] + 10)) ) ? 1'b1 : 1'b0;
    snakebody11 <= (length >= 12 && SnakeOn2[11]&& ((SnakeXMemory[11]-2 <= h_cnt) && (h_cnt < SnakeXMemory[11] + 10-2)) && ((SnakeYMemory[11] <= v_cnt) && (v_cnt < SnakeYMemory[11] + 10)) ) ? 1'b1 : 1'b0;
    snakebody12 <= (length >= 13 && SnakeOn2[12]&& ((SnakeXMemory[12]-2 <= h_cnt) && (h_cnt < SnakeXMemory[12] + 10-2)) && ((SnakeYMemory[12] <= v_cnt) && (v_cnt < SnakeYMemory[12] + 10)) ) ? 1'b1 : 1'b0;
    snakebody13 <= (length >= 14 && SnakeOn2[13]&& ((SnakeXMemory[13]-2 <= h_cnt) && (h_cnt < SnakeXMemory[13] + 10-2)) && ((SnakeYMemory[13] <= v_cnt) && (v_cnt < SnakeYMemory[13] + 10)) ) ? 1'b1 : 1'b0;
    snakebody14 <= (length >= 15 && SnakeOn2[14]&& ((SnakeXMemory[14]-2 <= h_cnt) && (h_cnt < SnakeXMemory[14] + 10-2)) && ((SnakeYMemory[14] <= v_cnt) && (v_cnt < SnakeYMemory[14] + 10)) ) ? 1'b1 : 1'b0;
    snakebody15 <= (length >= 16 && SnakeOn2[15]&& ((SnakeXMemory[15]-2 <= h_cnt) && (h_cnt < SnakeXMemory[15] + 10-2)) && ((SnakeYMemory[15] <= v_cnt) && (v_cnt < SnakeYMemory[15] + 10)) ) ? 1'b1 : 1'b0;
    
    snakebody16 <= (length >= 17 && SnakeOn2[16]&& ((SnakeXMemory[16]-2 <= h_cnt) && (h_cnt < SnakeXMemory[16] + 10-2)) && ((SnakeYMemory[16] <= v_cnt) && (v_cnt < SnakeYMemory[16] + 10)) ) ? 1'b1 : 1'b0;
    snakebody17 <= (length >= 18 && SnakeOn2[17]&& ((SnakeXMemory[17]-2 <= h_cnt) && (h_cnt < SnakeXMemory[17] + 10-2)) && ((SnakeYMemory[17] <= v_cnt) && (v_cnt < SnakeYMemory[17] + 10)) ) ? 1'b1 : 1'b0;
    snakebody18 <= (length >= 19 && SnakeOn2[18]&& ((SnakeXMemory[18]-2 <= h_cnt) && (h_cnt < SnakeXMemory[18] + 10-2)) && ((SnakeYMemory[18] <= v_cnt) && (v_cnt < SnakeYMemory[18] + 10)) ) ? 1'b1 : 1'b0;
    snakebody19 <= (length >= 20 && SnakeOn2[19]&& ((SnakeXMemory[19]-2 <= h_cnt) && (h_cnt < SnakeXMemory[19] + 10-2)) && ((SnakeYMemory[19] <= v_cnt) && (v_cnt < SnakeYMemory[19] + 10)) ) ? 1'b1 : 1'b0;
    snakebody20 <= (length >= 21 && SnakeOn2[20]&& ((SnakeXMemory[20]-2 <= h_cnt) && (h_cnt < SnakeXMemory[20] + 10-2)) && ((SnakeYMemory[20] <= v_cnt) && (v_cnt < SnakeYMemory[20] + 10)) ) ? 1'b1 : 1'b0;
    snakebody21 <= (length >= 22 && SnakeOn2[21]&& ((SnakeXMemory[21]-2 <= h_cnt) && (h_cnt < SnakeXMemory[21] + 10-2)) && ((SnakeYMemory[21] <= v_cnt) && (v_cnt < SnakeYMemory[21] + 10)) ) ? 1'b1 : 1'b0;
    snakebody22 <= (length >= 23 && SnakeOn2[22]&& ((SnakeXMemory[22]-2 <= h_cnt) && (h_cnt < SnakeXMemory[22] + 10-2)) && ((SnakeYMemory[22] <= v_cnt) && (v_cnt < SnakeYMemory[22] + 10)) ) ? 1'b1 : 1'b0;
    snakebody23 <= (length >= 24 && SnakeOn2[23]&& ((SnakeXMemory[23]-2 <= h_cnt) && (h_cnt < SnakeXMemory[23] + 10-2)) && ((SnakeYMemory[23] <= v_cnt) && (v_cnt < SnakeYMemory[23] + 10)) ) ? 1'b1 : 1'b0;
    snakebody24 <= (length >= 25 && SnakeOn2[24]&& ((SnakeXMemory[24]-2 <= h_cnt) && (h_cnt < SnakeXMemory[24] + 10-2)) && ((SnakeYMemory[24] <= v_cnt) && (v_cnt < SnakeYMemory[24] + 10)) ) ? 1'b1 : 1'b0;
    snakebody25 <= (length >= 26 && SnakeOn2[25]&& ((SnakeXMemory[25]-2 <= h_cnt) && (h_cnt < SnakeXMemory[25] + 10-2)) && ((SnakeYMemory[25] <= v_cnt) && (v_cnt < SnakeYMemory[25] + 10)) ) ? 1'b1 : 1'b0;
    snakebody26 <= (length >= 27 && SnakeOn2[26]&& ((SnakeXMemory[26]-2 <= h_cnt) && (h_cnt < SnakeXMemory[26] + 10-2)) && ((SnakeYMemory[26] <= v_cnt) && (v_cnt < SnakeYMemory[26] + 10)) ) ? 1'b1 : 1'b0;
    snakebody27 <= (length >= 28 && SnakeOn2[27]&& ((SnakeXMemory[27]-2 <= h_cnt) && (h_cnt < SnakeXMemory[27] + 10-2)) && ((SnakeYMemory[27] <= v_cnt) && (v_cnt < SnakeYMemory[27] + 10)) ) ? 1'b1 : 1'b0;
    snakebody28 <= (length >= 29 && SnakeOn2[28]&& ((SnakeXMemory[28]-2 <= h_cnt) && (h_cnt < SnakeXMemory[28] + 10-2)) && ((SnakeYMemory[28] <= v_cnt) && (v_cnt < SnakeYMemory[28] + 10)) ) ? 1'b1 : 1'b0;
    snakebody29 <= (length >= 30 && SnakeOn2[29]&& ((SnakeXMemory[29]-2 <= h_cnt) && (h_cnt < SnakeXMemory[29] + 10-2)) && ((SnakeYMemory[29] <= v_cnt) && (v_cnt < SnakeYMemory[29] + 10)) ) ? 1'b1 : 1'b0;
    snakebody30 <= (length >= 31 && SnakeOn2[30]&& ((SnakeXMemory[30]-2 <= h_cnt) && (h_cnt < SnakeXMemory[30] + 10-2)) && ((SnakeYMemory[30] <= v_cnt) && (v_cnt < SnakeYMemory[30] + 10)) ) ? 1'b1 : 1'b0;
    snakebody31 <= (length >= 32 && SnakeOn2[31]&& ((SnakeXMemory[31]-2 <= h_cnt) && (h_cnt < SnakeXMemory[31] + 10-2)) && ((SnakeYMemory[31] <= v_cnt) && (v_cnt < SnakeYMemory[31] + 10)) ) ? 1'b1 : 1'b0;
    snakebody <= (snakebody1 || snakebody2 || snakebody3 || snakebody4 || snakebody5 || snakebody6 || snakebody7 || snakebody8 || snakebody9 || snakebody10 || snakebody11 || snakebody12 || snakebody13 || snakebody14 || snakebody15
    || snakebody16 || snakebody17 || snakebody18 || snakebody19 || snakebody20 || snakebody21 || snakebody22 || snakebody23 || snakebody24 || snakebody25 
    || snakebody26 || snakebody27 || snakebody28 || snakebody29 || snakebody30 || snakebody31
    ) ? 1'b1 : 1'b0;
    
end

/////////////////////////////////////////////////////////////////////////////////////
             
endmodule


module direction_SG(clk,w,a,s,d,state,length,r,reset);
input clk,w,a,s,d,r;
output reset;
reg reset = 1'b0;
input [3:0] length;
parameter [2:0] up = 3'b0;
parameter [2:0] down = 3'd1;
parameter [2:0] left = 3'd2;
parameter [2:0] right = 3'd3;
output reg [2:0] state = up;
always@(posedge clk)begin
    if(w == 1'b1 && s == 1'b0 && a == 1'b0 && d == 1'b0 && r == 1'b0 )begin
        reset <= 1'b0;
        if(state != down || length == 1) begin
            state <= up;
        end else begin 
            state <= state;
        end
    end else if ( s == 1'b1 && w == 1'b0 && a == 1'b0 && d == 1'b0 && r == 1'b0 ) begin
        reset <= 1'b0;
        if(state != up || length == 1)begin
            state <= down;
        end else begin
            state <= state;
        end
    end else if ( a == 1'b1 && w == 1'b0 && s == 1'b0 && d == 1'b0 && r == 1'b0 ) begin
        reset <= 1'b0;
        if(state != right || length == 1)begin
            state <= left;
        end else begin
            state <= state;
        end
        
    end else if ( d == 1'b1 && w == 1'b0 && s == 1'b0 && a == 1'b0 && r == 1'b0 ) begin
        reset <= 1'b0;
        if(state != left || length == 1)begin
            state <= right;
        end else begin
            state <= state;
        end
    end else if ( r == 1'b1 && w == 1'b0 && s == 1'b0 && a == 1'b0 && d == 1'b0) begin
        reset <= 1'b1;
    end else begin
        reset <= 1'b0;
        state <= state;
    end 
end

endmodule