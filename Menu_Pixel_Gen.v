module MenuPixelGen1(
    input [9:0] h_cnt,
    input [9:0] v_cnt,
    input valid,
    input [3:0]CurState,
    input clk,
    output reg [3:0] vgaRed,
    output reg [3:0] vgaGreen,
    output reg [3:0] vgaBlue
);

parameter PureRed = 12'hF00;
parameter PureGreen = 12'h0F0;
parameter PureBlue = 12'h00F;

//MO - Minus One Hex - Lighter
parameter MORed = 12'hE00;
parameter MOGreen = 12'h0E0;
parameter MOBlue = 12'h00E;

//MO - Minus Two Hex - +Lighter
parameter MTwRed = 12'hD00;
parameter MTwGreen = 12'h0D0;
parameter MTwBlue = 12'h00D;

parameter Black = 12'h000;
parameter White = 12'hFFF;
parameter Purple = 12'h83C;

parameter ChosenBlue = 12'h02D;
parameter ChosenGreen = 12'h2C0;
parameter ChosenOrange = 12'hE90;

//X & Y starts from the top
parameter SizeofPixel = 10;
parameter SizeofBlock = 40;
parameter MAXBorderx = 640-SizeofBlock;
parameter MAXBordery = 480-SizeofBlock;

//Colors of each Background of Option and its Text
reg [11:0] ColorWordTitle = Black;
reg [11:0] ColorBGOpt1 = Black;
reg [11:0] ColorWordOpt1 = Black;
reg [11:0] ColorBGOpt2 = Black;
reg [11:0] ColorWordOpt2 = Black;
reg [11:0] ColorBGOpt3 = Black;
reg [11:0] ColorWordOpt3 = Black;
reg [11:0] ColorBGOpt4 = Black;
reg [11:0] ColorWordOpt4 = Black;
reg [11:0] ColorBGOpt5 = Black;
reg [11:0] ColorWordOpt5 = Black;

always@(clk)begin
    if(!valid) begin
        ColorWordTitle <= Black;
        ColorBGOpt1 <= Black;
        ColorWordOpt1 <= Black;
        ColorBGOpt2 <= Black;
        ColorWordOpt2 <= Black;
        ColorBGOpt3 <= Black;
        ColorWordOpt3 <= Black;
        ColorBGOpt4 <= Black;
        ColorWordOpt4 <= Black;
        ColorBGOpt5 <= Black;
        ColorWordOpt5 <= Black;
    end
    else begin
        if(CurState==4'd2) begin
            ColorWordTitle <= White;
            ColorBGOpt1 <= Black;
            ColorWordOpt1 <= White;
            ColorBGOpt2 <= White;
            ColorWordOpt2 <= Black;
            ColorBGOpt3 <= Black;
            ColorWordOpt3 <= White;
            ColorBGOpt4 <= Black;
            ColorWordOpt4 <= White;
            ColorBGOpt5 <= Black;
            ColorWordOpt5 <= White;
        end
        else if(CurState==4'd3) begin
            ColorWordTitle <= White;
            ColorBGOpt1 <= Black;
            ColorWordOpt1 <= White;
            ColorBGOpt2 <= Black;
            ColorWordOpt2 <= White;
            ColorBGOpt3 <= White;
            ColorWordOpt3 <= Black;
            ColorBGOpt4 <= Black;
            ColorWordOpt4 <= White;
            ColorBGOpt5 <= Black;
            ColorWordOpt5 <= White;
        end
        else if(CurState==4'd4) begin
            ColorWordTitle <= White;
            ColorBGOpt1 <= Black;
            ColorWordOpt1 <= White;
            ColorBGOpt2 <= Black;
            ColorWordOpt2 <= White;
            ColorBGOpt3 <= Black;
            ColorWordOpt3 <= White;
            ColorBGOpt4 <= White;
            ColorWordOpt4 <= Black;
            ColorBGOpt5 <= Black;
            ColorWordOpt5 <= White;
        end
        else if(CurState==4'd5) begin
            ColorWordTitle <= White;
            ColorBGOpt1 <= Black;
            ColorWordOpt1 <= White;
            ColorBGOpt2 <= Black;
            ColorWordOpt2 <= White;
            ColorBGOpt3 <= Black;
            ColorWordOpt3 <= White;
            ColorBGOpt4 <= Black;
            ColorWordOpt4 <= White;
            ColorBGOpt5 <= White;
            ColorWordOpt5 <= Black;
        end
        else if(CurState==4'd1) begin
            ColorWordTitle <= White;
            ColorBGOpt1 <= White;
            ColorWordOpt1 <= Black;
            ColorBGOpt2 <= Black;
            ColorWordOpt2 <= White;
            ColorBGOpt3 <= Black;
            ColorWordOpt3 <= White;
            ColorBGOpt4 <= Black;
            ColorWordOpt4 <= White;
            ColorBGOpt5 <= Black;
            ColorWordOpt5 <= White;
        end
        else begin
            ColorWordTitle <= PureRed;
            ColorBGOpt1 <= Black;
            ColorWordOpt1 <= PureRed;
            ColorBGOpt2 <= Black;
            ColorWordOpt2 <= PureRed;
            ColorBGOpt3 <= Black;
            ColorWordOpt3 <= PureRed;
            ColorBGOpt4 <= Black;
            ColorWordOpt4 <= PureRed;
            ColorBGOpt5 <= Black;
            ColorWordOpt5 <= PureRed;
        end
    end
end


//1 Pixel is 10 Pixels in VGA
//For word, map VT323 (from Drawio) to Pixel (Slowly)
//getting the word to Pixel by pixilart (website)
//Y is always the same, so change when differnet option
//Focus only X because using columns
//Get Color from "https://studio.code.org/projects/applab/qiyLvNCBDuOYbaBB8oe0isTwNDYTOeGA5cpWlhHNTzM"

always@(clk) begin
    if(!valid) begin
        {vgaRed, vgaGreen, vgaBlue} <= Black;
    end
    else begin
//        if( (h_cnt<40) || (h_cnt>600) || (v_cnt<40) || (v_cnt>440) ) begin
        if( (h_cnt<SizeofBlock) || (h_cnt>MAXBorderx) || (v_cnt<SizeofBlock) || (v_cnt>MAXBordery) ) begin
//            {vgaRed, vgaGreen, vgaBlue} = ChosenGreen; //Blue Border
            {vgaRed, vgaGreen, vgaBlue} <= ChosenBlue; //Blue Border
        end
        else begin
//================================================================================================================================================Title
            if(v_cnt<120 && v_cnt>60 && h_cnt<440 && h_cnt>200) begin //Title
                //Start text from (220, 70)-> (440,120)?
                //PinkSalmon Column
                if( 
                ( 
                (215+9<=h_cnt && h_cnt<=215+16) || (215+100<=h_cnt && h_cnt<=215+103) || (215+140<=h_cnt && h_cnt<=215+151) 
                )
                && 70+8<=v_cnt && v_cnt<=70+11) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordTitle; 
                end
                //Orange Column
                else if( 
                ( 
                (215+8<=h_cnt && h_cnt<=215+17) || (215+100<=h_cnt && h_cnt<=215+103) || (215+138<=h_cnt && h_cnt<=215+141)
                || (215+150<=h_cnt && h_cnt<=215+153) 
                )
                && 70+12<=v_cnt && v_cnt<=70+15) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordTitle; 
                end
                //Purple Column
                else if( 
                ( 
                (215+6<=h_cnt && h_cnt<=215+9) || (215+16<=h_cnt && h_cnt<=215+19) || (215+27<=h_cnt && h_cnt<=215+30)
                || (215+33<=h_cnt && h_cnt<=215+42) || (215+100<=h_cnt && h_cnt<=215+103) || (215+51<=h_cnt && h_cnt<=215+61) 
                || (215+69<=h_cnt && h_cnt<=215+81) 
                || (215+90<=h_cnt && h_cnt<=215+97) || (215+110<=h_cnt && h_cnt<=215+121) || (215+136<=h_cnt && h_cnt<=215+139) 
                || (215+158<=h_cnt && h_cnt<=215+170) || (215+176<=h_cnt && h_cnt<=215+177) || (215+180<=h_cnt && h_cnt<=215+183) 
                || (215+186<=h_cnt && h_cnt<=215+189) || (215+198<=h_cnt && h_cnt<=215+209) 
                )
                && 70+16<=v_cnt && v_cnt<=70+19) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordTitle; 
                end
                //LightBlue Column
                else if( 
                ( 
                (215+5<=h_cnt && h_cnt<=215+8) || (215+17<=h_cnt && h_cnt<=215+20) || (215+29<=h_cnt && h_cnt<=215+34)
                || (215+41<=h_cnt && h_cnt<=215+44) || (215+49<=h_cnt && h_cnt<=215+52) || (215+61<=h_cnt && h_cnt<=215+64) 
                || (215+79<=h_cnt && h_cnt<=215+82) || (215+88<=h_cnt && h_cnt<=215+91) || (215+98<=h_cnt && h_cnt<=215+103) 
                || (215+108<=h_cnt && h_cnt<=215+111) || (215+120<=h_cnt && h_cnt<=215+123) || (215+136<=h_cnt && h_cnt<=215+149) 
                || (215+146<=h_cnt && h_cnt<=215+153) || (215+168<=h_cnt && h_cnt<=215+171) || (215+176<=h_cnt && h_cnt<=215+179) 
                || (215+182<=h_cnt && h_cnt<=215+185) || (215+188<=h_cnt && h_cnt<=215+191) || (215+196<=h_cnt && h_cnt<=215+199)
                || (215+208<=h_cnt && h_cnt<=215+211)
                )
                && 70+20<=v_cnt && v_cnt<=70+23) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordTitle; 
                end
                //Yellow Column
                else if( 
                ( 
                (215+5<=h_cnt && h_cnt<=215+20) || (215+29<=h_cnt && h_cnt<=215+32) || (215+47<=h_cnt && h_cnt<=215+51)
                || (215+69<=h_cnt && h_cnt<=215+82) || (215+86<=h_cnt && h_cnt<=215+89) || (215+100<=h_cnt && h_cnt<=215+103) 
                || (215+106<=h_cnt && h_cnt<=215+123) || (215+136<=h_cnt && h_cnt<=215+139) || (215+150<=h_cnt && h_cnt<=215+153) 
                || (215+158<=h_cnt && h_cnt<=215+171) || (215+176<=h_cnt && h_cnt<=215+179) || (215+182<=h_cnt && h_cnt<=215+185) 
                || (215+188<=h_cnt && h_cnt<=215+191) || (215+194<=h_cnt && h_cnt<=215+211)
                )
                && 70+24<=v_cnt && v_cnt<=70+27) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordTitle; 
                end
                //DarkRed Column
                else if( 
                ( 
                (215+3<=h_cnt && h_cnt<=215+6) || (215+19<=h_cnt && h_cnt<=215+22) || (215+29<=h_cnt && h_cnt<=215+32)
                || (215+49<=h_cnt && h_cnt<=215+52) || (215+61<=h_cnt && h_cnt<=215+64) || (215+67<=h_cnt && h_cnt<=215+70) 
                || (215+79<=h_cnt && h_cnt<=215+82) || (215+88<=h_cnt && h_cnt<=215+91) || (215+98<=h_cnt && h_cnt<=215+103) 
                || (215+108<=h_cnt && h_cnt<=215+111) || (215+138<=h_cnt && h_cnt<=215+141) || (215+150<=h_cnt && h_cnt<=215+153) 
                || (215+156<=h_cnt && h_cnt<=215+159) || (215+168<=h_cnt && h_cnt<=215+171) || (215+176<=h_cnt && h_cnt<=215+179) 
                || (215+182<=h_cnt && h_cnt<=215+185) || (215+188<=h_cnt && h_cnt<=215+191) || (215+196<=h_cnt && h_cnt<=215+199)
                )
                && 70+28<=v_cnt && v_cnt<=70+31) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordTitle; 
                end
                //Green Column
                else if( 
                ( 
                (215+3<=h_cnt && h_cnt<=215+6) || (215+19<=h_cnt && h_cnt<=215+22) || (215+25<=h_cnt && h_cnt<=215+36)
                || (215+51<=h_cnt && h_cnt<=215+62) || (215+69<=h_cnt && h_cnt<=215+78) || (215+81<=h_cnt && h_cnt<=215+84) 
                || (215+90<=h_cnt && h_cnt<=215+98) || (215+100<=h_cnt && h_cnt<=215+103) || (215+110<=h_cnt && h_cnt<=215+121) 
                || (215+140<=h_cnt && h_cnt<=215+151) || (215+158<=h_cnt && h_cnt<=215+167) || (215+170<=h_cnt && h_cnt<=215+173) 
                || (215+176<=h_cnt && h_cnt<=215+179) || (215+182<=h_cnt && h_cnt<=215+185) || (215+188<=h_cnt && h_cnt<=215+191) 
                || (215+198<=h_cnt && h_cnt<=215+209) 
                )
                && 70+32<=v_cnt && v_cnt<=70+35) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordTitle; 
                end
                else begin
//                    {vgaRed, vgaGreen, vgaBlue} = ChosenOrange; 
                    {vgaRed, vgaGreen, vgaBlue} <= ChosenOrange; 
                end
            end
//================================================================================================================================================First Option
            else if(v_cnt<180 && v_cnt>140 && h_cnt<560 && h_cnt>80) begin //First Option
                //Start text from (240, 140)-> (400,180)
                //PinkSalmon Column
                if( 
                ( 
                (240+3<=h_cnt && h_cnt<=240+14) || (240+55<=h_cnt && h_cnt<=240+58) || (240+93<=h_cnt && h_cnt<=240+103) 
                )
                && 140+8<=v_cnt && v_cnt<=140+11) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt1; 
                end
                //Orange Column
                else if( 
                ( 
                (240+1<=h_cnt && h_cnt<=240+5) || (240+55<=h_cnt && h_cnt<=240+58) || (240+91<=h_cnt && h_cnt<=240+94)
                || (240+102<=h_cnt && h_cnt<=240+105) 
                )
                && 140+12<=v_cnt && v_cnt<=140+15) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt1; 
                end
                //Purple Column
                else if( 
                ( 
                (240+1<=h_cnt && h_cnt<=240+5) || (240+19<=h_cnt && h_cnt<=240+23) || (240+25<=h_cnt && h_cnt<=240+32)
                || (240+41<=h_cnt && h_cnt<=240+48) || (240+55<=h_cnt && h_cnt<=240+58) || (240+63<=h_cnt && h_cnt<=240+68) 
                || (240+73<=h_cnt && h_cnt<=240+80) || (240+89<=h_cnt && h_cnt<=240+92) || (240+112<=h_cnt && h_cnt<=240+119) 
                || (240+126<=h_cnt && h_cnt<=240+127) || (240+130<=h_cnt && h_cnt<=240+133) || (240+136<=h_cnt && h_cnt<=240+139) 
                || (240+148<=h_cnt && h_cnt<=240+155) 
                )
                && 140+16<=v_cnt && v_cnt<=140+19) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt1; 
                end
                //LightBlue Column
                else if( 
                ( 
                (240+3<=h_cnt && h_cnt<=240+14) || (240+19<=h_cnt && h_cnt<=240+24) || (240+31<=h_cnt && h_cnt<=240+34)
                || (240+47<=h_cnt && h_cnt<=240+50) || (240+55<=h_cnt && h_cnt<=240+58) || (240+61<=h_cnt && h_cnt<=240+64) 
                || (240+71<=h_cnt && h_cnt<=240+74) || (240+81<=h_cnt && h_cnt<=240+84) || (240+89<=h_cnt && h_cnt<=240+92) 
                || (240+98<=h_cnt && h_cnt<=240+105) || (240+118<=h_cnt && h_cnt<=240+121) || (240+126<=h_cnt && h_cnt<=240+129) 
                || (240+132<=h_cnt && h_cnt<=240+135) || (240+138<=h_cnt && h_cnt<=240+141) || (240+146<=h_cnt && h_cnt<=240+149) 
                || (240+156<=h_cnt && h_cnt<=240+159)  
                )
                && 140+20<=v_cnt && v_cnt<=140+23) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt1; 
                end
                //Yellow Column
                else if( 
                ( 
                (240+13<=h_cnt && h_cnt<=240+17) || (240+19<=h_cnt && h_cnt<=240+23) || (240+31<=h_cnt && h_cnt<=240+34)
                || (240+39<=h_cnt && h_cnt<=240+50) || (240+55<=h_cnt && h_cnt<=240+62) || (240+69<=h_cnt && h_cnt<=240+84) 
                || (240+89<=h_cnt && h_cnt<=240+92) || (240+102<=h_cnt && h_cnt<=240+105) || (240+110<=h_cnt && h_cnt<=240+121) 
                || (240+126<=h_cnt && h_cnt<=240+129) || (240+132<=h_cnt && h_cnt<=240+135) || (240+138<=h_cnt && h_cnt<=240+141) 
                || (240+144<=h_cnt && h_cnt<=240+159)  
                )
                && 140+24<=v_cnt && v_cnt<=140+27) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt1; 
                end
                //DarkRed Column
                else if( 
                ( 
                (240+1<=h_cnt && h_cnt<=240+4) || (240+13<=h_cnt && h_cnt<=240+16) || (240+19<=h_cnt && h_cnt<=240+22)
                || (240+31<=h_cnt && h_cnt<=240+34) || (240+37<=h_cnt && h_cnt<=240+40) || (240+47<=h_cnt && h_cnt<=240+50) 
                || (240+55<=h_cnt && h_cnt<=240+58) || (240+61<=h_cnt && h_cnt<=240+64) || (240+71<=h_cnt && h_cnt<=240+74) 
                || (240+91<=h_cnt && h_cnt<=240+94) || (240+102<=h_cnt && h_cnt<=240+105) || (240+109<=h_cnt && h_cnt<=240+111) 
                || (240+118<=h_cnt && h_cnt<=240+121) || (240+126<=h_cnt && h_cnt<=240+129) || (240+132<=h_cnt && h_cnt<=240+135) 
                || (240+138<=h_cnt && h_cnt<=240+141) || (240+146<=h_cnt && h_cnt<=240+149)
                )
                && 140+28<=v_cnt && v_cnt<=140+31) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt1; 
                end
                //Green Column
                else if( 
                ( 
                (240+3<=h_cnt && h_cnt<=240+14) || (240+19<=h_cnt && h_cnt<=240+22) || (240+31<=h_cnt && h_cnt<=240+34)
                || (240+39<=h_cnt && h_cnt<=240+46) || (240+49<=h_cnt && h_cnt<=240+52) || (240+55<=h_cnt && h_cnt<=240+58) 
                || (240+63<=h_cnt && h_cnt<=240+68) || (240+73<=h_cnt && h_cnt<=240+82) || (240+93<=h_cnt && h_cnt<=240+103) 
                || (240+110<=h_cnt && h_cnt<=240+117) || (240+120<=h_cnt && h_cnt<=240+123) || (240+126<=h_cnt && h_cnt<=240+129) 
                || (240+132<=h_cnt && h_cnt<=240+135) || (240+138<=h_cnt && h_cnt<=240+141) || (240+148<=h_cnt && h_cnt<=240+157) 
                )
                && 140+32<=v_cnt && v_cnt<=140+35) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt1; 
                end
                else begin
//                    {vgaRed, vgaGreen, vgaBlue} = White; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorBGOpt1; 
                end
            end
//================================================================================================================================================Second Option
            else if(v_cnt<240 && v_cnt>200 && h_cnt<560 && h_cnt>80) begin //Second Option
                //Start text from (240, 200)-> (400,240)
                //PinkSalmon Column
                if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+15) || (240+58<=h_cnt && h_cnt<=240+61) || (240+95<=h_cnt && h_cnt<=240+106) 
                || (240+111<=h_cnt && h_cnt<=240+118) || (240+147<=h_cnt && h_cnt<=240+150)
                )
                && 200+8<=v_cnt && v_cnt<=200+11) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt2; 
                end
                //Orange Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+7) || (240+58<=h_cnt && h_cnt<=240+61) || (240+93<=h_cnt && h_cnt<=240+96)
                || (240+115<=h_cnt && h_cnt<=240+118) || (240+147<=h_cnt && h_cnt<=240+150) 
                )
                && 200+12<=v_cnt && v_cnt<=200+15) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt2; 
                end
                //Purple Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+7) || (240+18<=h_cnt && h_cnt<=240+19) || (240+22<=h_cnt && h_cnt<=240+25)
                || (240+28<=h_cnt && h_cnt<=240+31) || (240+36<=h_cnt && h_cnt<=240+39) || (240+42<=h_cnt && h_cnt<=240+47) 
                || (240+53<=h_cnt && h_cnt<=240+66) || (240+69<=h_cnt && h_cnt<=240+72) || (240+84<=h_cnt && h_cnt<=240+87) 
                || (240+93<=h_cnt && h_cnt<=240+96) || (240+115<=h_cnt && h_cnt<=240+118) || (240+127<=h_cnt && h_cnt<=240+136) 
                || (240+143<=h_cnt && h_cnt<=240+156) 
                )
                && 200+16<=v_cnt && v_cnt<=200+19) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt2; 
                end
                //LightBlue Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+15) || (240+18<=h_cnt && h_cnt<=240+21) || (240+24<=h_cnt && h_cnt<=240+27)
                || (240+30<=h_cnt && h_cnt<=240+33) || (240+36<=h_cnt && h_cnt<=240+41) || (240+46<=h_cnt && h_cnt<=240+49) 
                || (240+57<=h_cnt && h_cnt<=240+60) || (240+71<=h_cnt && h_cnt<=240+74) || (240+82<=h_cnt && h_cnt<=240+85) 
                || (240+95<=h_cnt && h_cnt<=240+106) || (240+115<=h_cnt && h_cnt<=240+118) || (240+125<=h_cnt && h_cnt<=240+128) 
                || (240+135<=h_cnt && h_cnt<=240+138) || (240+147<=h_cnt && h_cnt<=240+150)
                )
                && 200+20<=v_cnt && v_cnt<=200+23) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt2; 
                end
                //Yellow Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+7) || (240+18<=h_cnt && h_cnt<=240+21) || (240+24<=h_cnt && h_cnt<=240+27)
                || (240+30<=h_cnt && h_cnt<=240+33) || (240+36<=h_cnt && h_cnt<=240+39) || (240+47<=h_cnt && h_cnt<=240+50) 
                || (240+57<=h_cnt && h_cnt<=240+60) || (240+73<=h_cnt && h_cnt<=240+76) || (240+80<=h_cnt && h_cnt<=240+83) 
                || (240+105<=h_cnt && h_cnt<=240+108) || (240+115<=h_cnt && h_cnt<=240+118) || (240+123<=h_cnt && h_cnt<=240+126) 
                || (240+137<=h_cnt && h_cnt<=240+140) || (240+147<=h_cnt && h_cnt<=240+150)  
                )
                && 200+24<=v_cnt && v_cnt<=200+27) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt2; 
                end
                //DarkRed Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+7) || (240+18<=h_cnt && h_cnt<=240+21) || (240+24<=h_cnt && h_cnt<=240+27)
                || (240+30<=h_cnt && h_cnt<=240+33) || (240+36<=h_cnt && h_cnt<=240+39) || (240+45<=h_cnt && h_cnt<=240+48) 
                || (240+57<=h_cnt && h_cnt<=240+60) || (240+75<=h_cnt && h_cnt<=240+81) || (240+93<=h_cnt && h_cnt<=240+96) 
                || (240+105<=h_cnt && h_cnt<=240+108) || (240+115<=h_cnt && h_cnt<=240+118) || (240+125<=h_cnt && h_cnt<=240+128) 
                || (240+135<=h_cnt && h_cnt<=240+138) || (240+147<=h_cnt && h_cnt<=240+150)
                )
                && 200+28<=v_cnt && v_cnt<=200+31) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt2; 
                end
                //Green Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+15) || (240+18<=h_cnt && h_cnt<=240+21) || (240+24<=h_cnt && h_cnt<=240+27)
                || (240+30<=h_cnt && h_cnt<=240+33) || (240+36<=h_cnt && h_cnt<=240+46) || (240+59<=h_cnt && h_cnt<=240+66) 
                || (240+76<=h_cnt && h_cnt<=240+79) || (240+95<=h_cnt && h_cnt<=240+106) || (240+111<=h_cnt && h_cnt<=240+122) 
                || (240+127<=h_cnt && h_cnt<=240+136) || (240+149<=h_cnt && h_cnt<=240+156)
                )
                && 200+32<=v_cnt && v_cnt<=200+35) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt2; 
                end
                //Blue Column
                else if( 
                ( 
                (240+36<=h_cnt && h_cnt<=240+39) || (240+72<=h_cnt && h_cnt<=240+77)
                )
                && 200+36<=v_cnt && v_cnt<=200+39) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt2; 
                end
                else begin
//                    {vgaRed, vgaGreen, vgaBlue} = White; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorBGOpt2; 
                end
            end
//================================================================================================================================================Third Option
            else if(v_cnt<300 && v_cnt>260 && h_cnt<560 && h_cnt>80) begin //Third Option
                //Start text from (240, 260)-> (400,300)
                //PinkSalmon Column
                if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+15) || (240+58<=h_cnt && h_cnt<=240+61) || (240+95<=h_cnt && h_cnt<=240+106) 
                || (240+111<=h_cnt && h_cnt<=240+118) || (240+147<=h_cnt && h_cnt<=240+150)
                )
                && 260+8<=v_cnt && v_cnt<=260+11) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt3; 
                end
                //Orange Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+7) || (240+58<=h_cnt && h_cnt<=240+61) || (240+93<=h_cnt && h_cnt<=240+96)
                || (240+115<=h_cnt && h_cnt<=240+118) || (240+147<=h_cnt && h_cnt<=240+150) 
                )
                && 260+12<=v_cnt && v_cnt<=260+15) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt3; 
                end
                //Purple Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+7) || (240+18<=h_cnt && h_cnt<=240+19) || (240+22<=h_cnt && h_cnt<=240+25)
                || (240+28<=h_cnt && h_cnt<=240+31) || (240+36<=h_cnt && h_cnt<=240+39) || (240+42<=h_cnt && h_cnt<=240+47) 
                || (240+53<=h_cnt && h_cnt<=240+66) || (240+69<=h_cnt && h_cnt<=240+72) || (240+84<=h_cnt && h_cnt<=240+87) 
                || (240+93<=h_cnt && h_cnt<=240+96) || (240+115<=h_cnt && h_cnt<=240+118) || (240+127<=h_cnt && h_cnt<=240+136) 
                || (240+143<=h_cnt && h_cnt<=240+156) 
                )
                && 260+16<=v_cnt && v_cnt<=260+19) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt3; 
                end
                //LightBlue Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+15) || (240+18<=h_cnt && h_cnt<=240+21) || (240+24<=h_cnt && h_cnt<=240+27)
                || (240+30<=h_cnt && h_cnt<=240+33) || (240+36<=h_cnt && h_cnt<=240+41) || (240+46<=h_cnt && h_cnt<=240+49) 
                || (240+57<=h_cnt && h_cnt<=240+60) || (240+71<=h_cnt && h_cnt<=240+74) || (240+82<=h_cnt && h_cnt<=240+85) 
                || (240+95<=h_cnt && h_cnt<=240+106) || (240+115<=h_cnt && h_cnt<=240+118) || (240+125<=h_cnt && h_cnt<=240+128) 
                || (240+135<=h_cnt && h_cnt<=240+138) || (240+147<=h_cnt && h_cnt<=240+150)
                )
                && 260+20<=v_cnt && v_cnt<=260+23) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt3; 
                end
                //Yellow Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+7) || (240+18<=h_cnt && h_cnt<=240+21) || (240+24<=h_cnt && h_cnt<=240+27)
                || (240+30<=h_cnt && h_cnt<=240+33) || (240+36<=h_cnt && h_cnt<=240+39) || (240+47<=h_cnt && h_cnt<=240+50) 
                || (240+57<=h_cnt && h_cnt<=240+60) || (240+73<=h_cnt && h_cnt<=240+76) || (240+80<=h_cnt && h_cnt<=240+83) 
                || (240+105<=h_cnt && h_cnt<=240+108) || (240+115<=h_cnt && h_cnt<=240+118) || (240+123<=h_cnt && h_cnt<=240+126) 
                || (240+137<=h_cnt && h_cnt<=240+140) || (240+147<=h_cnt && h_cnt<=240+150)  
                )
                && 260+24<=v_cnt && v_cnt<=260+27) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt3; 
                end
                //DarkRed Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+7) || (240+18<=h_cnt && h_cnt<=240+21) || (240+24<=h_cnt && h_cnt<=240+27)
                || (240+30<=h_cnt && h_cnt<=240+33) || (240+36<=h_cnt && h_cnt<=240+39) || (240+45<=h_cnt && h_cnt<=240+48) 
                || (240+57<=h_cnt && h_cnt<=240+60) || (240+75<=h_cnt && h_cnt<=240+81) || (240+93<=h_cnt && h_cnt<=240+96) 
                || (240+105<=h_cnt && h_cnt<=240+108) || (240+115<=h_cnt && h_cnt<=240+118) || (240+125<=h_cnt && h_cnt<=240+128) 
                || (240+135<=h_cnt && h_cnt<=240+138) || (240+147<=h_cnt && h_cnt<=240+150)
                )
                && 260+28<=v_cnt && v_cnt<=260+31) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt3; 
                end
                //Green Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+15) || (240+18<=h_cnt && h_cnt<=240+21) || (240+24<=h_cnt && h_cnt<=240+27)
                || (240+30<=h_cnt && h_cnt<=240+33) || (240+36<=h_cnt && h_cnt<=240+46) || (240+59<=h_cnt && h_cnt<=240+66) 
                || (240+76<=h_cnt && h_cnt<=240+79) || (240+95<=h_cnt && h_cnt<=240+106) || (240+111<=h_cnt && h_cnt<=240+122) 
                || (240+127<=h_cnt && h_cnt<=240+136) || (240+149<=h_cnt && h_cnt<=240+156)
                )
                && 260+32<=v_cnt && v_cnt<=260+35) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt3; 
                end
                //Blue Column
                else if( 
                ( 
                (240+36<=h_cnt && h_cnt<=240+39) || (240+72<=h_cnt && h_cnt<=240+77)
                )
                && 260+36<=v_cnt && v_cnt<=260+39) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt3; 
                end
                else begin
//                    {vgaRed, vgaGreen, vgaBlue} = White; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorBGOpt3; 
                end
            end
//================================================================================================================================================Fourth Option
            else if(v_cnt<360 && v_cnt>320 && h_cnt<560 && h_cnt>80) begin //Fourth Option
                //Start text from (240, 320)-> (400,360)
                //PinkSalmon Column
                if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+15) || (240+58<=h_cnt && h_cnt<=240+61) || (240+95<=h_cnt && h_cnt<=240+106) 
                || (240+111<=h_cnt && h_cnt<=240+118) || (240+147<=h_cnt && h_cnt<=240+150)
                )
                && 320+8<=v_cnt && v_cnt<=320+11) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt4; 
                end
                //Orange Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+7) || (240+58<=h_cnt && h_cnt<=240+61) || (240+93<=h_cnt && h_cnt<=240+96)
                || (240+115<=h_cnt && h_cnt<=240+118) || (240+147<=h_cnt && h_cnt<=240+150) 
                )
                && 320+12<=v_cnt && v_cnt<=320+15) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt4; 
                end
                //Purple Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+7) || (240+18<=h_cnt && h_cnt<=240+19) || (240+22<=h_cnt && h_cnt<=240+25)
                || (240+28<=h_cnt && h_cnt<=240+31) || (240+36<=h_cnt && h_cnt<=240+39) || (240+42<=h_cnt && h_cnt<=240+47) 
                || (240+53<=h_cnt && h_cnt<=240+66) || (240+69<=h_cnt && h_cnt<=240+72) || (240+84<=h_cnt && h_cnt<=240+87) 
                || (240+93<=h_cnt && h_cnt<=240+96) || (240+115<=h_cnt && h_cnt<=240+118) || (240+127<=h_cnt && h_cnt<=240+136) 
                || (240+143<=h_cnt && h_cnt<=240+156) 
                )
                && 320+16<=v_cnt && v_cnt<=320+19) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt4; 
                end
                //LightBlue Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+15) || (240+18<=h_cnt && h_cnt<=240+21) || (240+24<=h_cnt && h_cnt<=240+27)
                || (240+30<=h_cnt && h_cnt<=240+33) || (240+36<=h_cnt && h_cnt<=240+41) || (240+46<=h_cnt && h_cnt<=240+49) 
                || (240+57<=h_cnt && h_cnt<=240+60) || (240+71<=h_cnt && h_cnt<=240+74) || (240+82<=h_cnt && h_cnt<=240+85) 
                || (240+95<=h_cnt && h_cnt<=240+106) || (240+115<=h_cnt && h_cnt<=240+118) || (240+125<=h_cnt && h_cnt<=240+128) 
                || (240+135<=h_cnt && h_cnt<=240+138) || (240+147<=h_cnt && h_cnt<=240+150)
                )
                && 320+20<=v_cnt && v_cnt<=320+23) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt4; 
                end
                //Yellow Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+7) || (240+18<=h_cnt && h_cnt<=240+21) || (240+24<=h_cnt && h_cnt<=240+27)
                || (240+30<=h_cnt && h_cnt<=240+33) || (240+36<=h_cnt && h_cnt<=240+39) || (240+47<=h_cnt && h_cnt<=240+50) 
                || (240+57<=h_cnt && h_cnt<=240+60) || (240+73<=h_cnt && h_cnt<=240+76) || (240+80<=h_cnt && h_cnt<=240+83) 
                || (240+105<=h_cnt && h_cnt<=240+108) || (240+115<=h_cnt && h_cnt<=240+118) || (240+123<=h_cnt && h_cnt<=240+126) 
                || (240+137<=h_cnt && h_cnt<=240+140) || (240+147<=h_cnt && h_cnt<=240+150)  
                )
                && 320+24<=v_cnt && v_cnt<=320+27) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt4; 
                end
                //DarkRed Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+7) || (240+18<=h_cnt && h_cnt<=240+21) || (240+24<=h_cnt && h_cnt<=240+27)
                || (240+30<=h_cnt && h_cnt<=240+33) || (240+36<=h_cnt && h_cnt<=240+39) || (240+45<=h_cnt && h_cnt<=240+48) 
                || (240+57<=h_cnt && h_cnt<=240+60) || (240+75<=h_cnt && h_cnt<=240+81) || (240+93<=h_cnt && h_cnt<=240+96) 
                || (240+105<=h_cnt && h_cnt<=240+108) || (240+115<=h_cnt && h_cnt<=240+118) || (240+125<=h_cnt && h_cnt<=240+128) 
                || (240+135<=h_cnt && h_cnt<=240+138) || (240+147<=h_cnt && h_cnt<=240+150)
                )
                && 320+28<=v_cnt && v_cnt<=320+31) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt4; 
                end
                //Green Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+15) || (240+18<=h_cnt && h_cnt<=240+21) || (240+24<=h_cnt && h_cnt<=240+27)
                || (240+30<=h_cnt && h_cnt<=240+33) || (240+36<=h_cnt && h_cnt<=240+46) || (240+59<=h_cnt && h_cnt<=240+66) 
                || (240+76<=h_cnt && h_cnt<=240+79) || (240+95<=h_cnt && h_cnt<=240+106) || (240+111<=h_cnt && h_cnt<=240+122) 
                || (240+127<=h_cnt && h_cnt<=240+136) || (240+149<=h_cnt && h_cnt<=240+156)
                )
                && 320+32<=v_cnt && v_cnt<=320+35) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt4; 
                end
                //Blue Column
                else if( 
                ( 
                (240+36<=h_cnt && h_cnt<=240+39) || (240+72<=h_cnt && h_cnt<=240+77)
                )
                && 320+36<=v_cnt && v_cnt<=320+39) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt4; 
                end
                else begin
//                    {vgaRed, vgaGreen, vgaBlue} = White; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorBGOpt4; 
                end
            end
//================================================================================================================================================Fifth Option
            else if(v_cnt<420 && v_cnt>380 && h_cnt<560 && h_cnt>80) begin //Fifth Option
                //Start text from (240, 380)-> (400,420)
                //PinkSalmon Column
                if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+15) || (240+58<=h_cnt && h_cnt<=240+61) || (240+95<=h_cnt && h_cnt<=240+106) 
                || (240+111<=h_cnt && h_cnt<=240+118) || (240+147<=h_cnt && h_cnt<=240+150)
                )
                && 380+8<=v_cnt && v_cnt<=380+11) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt5; 
                end
                //Orange Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+7) || (240+58<=h_cnt && h_cnt<=240+61) || (240+93<=h_cnt && h_cnt<=240+96)
                || (240+115<=h_cnt && h_cnt<=240+118) || (240+147<=h_cnt && h_cnt<=240+150) 
                )
                && 380+12<=v_cnt && v_cnt<=380+15) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt5; 
                end
                //Purple Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+7) || (240+18<=h_cnt && h_cnt<=240+19) || (240+22<=h_cnt && h_cnt<=240+25)
                || (240+28<=h_cnt && h_cnt<=240+31) || (240+36<=h_cnt && h_cnt<=240+39) || (240+42<=h_cnt && h_cnt<=240+47) 
                || (240+53<=h_cnt && h_cnt<=240+66) || (240+69<=h_cnt && h_cnt<=240+72) || (240+84<=h_cnt && h_cnt<=240+87) 
                || (240+93<=h_cnt && h_cnt<=240+96) || (240+115<=h_cnt && h_cnt<=240+118) || (240+127<=h_cnt && h_cnt<=240+136) 
                || (240+143<=h_cnt && h_cnt<=240+156) 
                )
                && 380+16<=v_cnt && v_cnt<=380+19) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt5; 
                end
                //LightBlue Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+15) || (240+18<=h_cnt && h_cnt<=240+21) || (240+24<=h_cnt && h_cnt<=240+27)
                || (240+30<=h_cnt && h_cnt<=240+33) || (240+36<=h_cnt && h_cnt<=240+41) || (240+46<=h_cnt && h_cnt<=240+49) 
                || (240+57<=h_cnt && h_cnt<=240+60) || (240+71<=h_cnt && h_cnt<=240+74) || (240+82<=h_cnt && h_cnt<=240+85) 
                || (240+95<=h_cnt && h_cnt<=240+106) || (240+115<=h_cnt && h_cnt<=240+118) || (240+125<=h_cnt && h_cnt<=240+128) 
                || (240+135<=h_cnt && h_cnt<=240+138) || (240+147<=h_cnt && h_cnt<=240+150)
                )
                && 380+20<=v_cnt && v_cnt<=380+23) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt5; 
                end
                //Yellow Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+7) || (240+18<=h_cnt && h_cnt<=240+21) || (240+24<=h_cnt && h_cnt<=240+27)
                || (240+30<=h_cnt && h_cnt<=240+33) || (240+36<=h_cnt && h_cnt<=240+39) || (240+47<=h_cnt && h_cnt<=240+50) 
                || (240+57<=h_cnt && h_cnt<=240+60) || (240+73<=h_cnt && h_cnt<=240+76) || (240+80<=h_cnt && h_cnt<=240+83) 
                || (240+105<=h_cnt && h_cnt<=240+108) || (240+115<=h_cnt && h_cnt<=240+118) || (240+123<=h_cnt && h_cnt<=240+126) 
                || (240+137<=h_cnt && h_cnt<=240+140) || (240+147<=h_cnt && h_cnt<=240+150)  
                )
                && 380+24<=v_cnt && v_cnt<=380+27) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt5; 
                end
                //DarkRed Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+7) || (240+18<=h_cnt && h_cnt<=240+21) || (240+24<=h_cnt && h_cnt<=240+27)
                || (240+30<=h_cnt && h_cnt<=240+33) || (240+36<=h_cnt && h_cnt<=240+39) || (240+45<=h_cnt && h_cnt<=240+48) 
                || (240+57<=h_cnt && h_cnt<=240+60) || (240+75<=h_cnt && h_cnt<=240+81) || (240+93<=h_cnt && h_cnt<=240+96) 
                || (240+105<=h_cnt && h_cnt<=240+108) || (240+115<=h_cnt && h_cnt<=240+118) || (240+125<=h_cnt && h_cnt<=240+128) 
                || (240+135<=h_cnt && h_cnt<=240+138) || (240+147<=h_cnt && h_cnt<=240+150)
                )
                && 380+28<=v_cnt && v_cnt<=380+31) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt5; 
                end
                //Green Column
                else if( 
                ( 
                (240+4<=h_cnt && h_cnt<=240+15) || (240+18<=h_cnt && h_cnt<=240+21) || (240+24<=h_cnt && h_cnt<=240+27)
                || (240+30<=h_cnt && h_cnt<=240+33) || (240+36<=h_cnt && h_cnt<=240+46) || (240+59<=h_cnt && h_cnt<=240+66) 
                || (240+76<=h_cnt && h_cnt<=240+79) || (240+95<=h_cnt && h_cnt<=240+106) || (240+111<=h_cnt && h_cnt<=240+122) 
                || (240+127<=h_cnt && h_cnt<=240+136) || (240+149<=h_cnt && h_cnt<=240+156)
                )
                && 380+32<=v_cnt && v_cnt<=380+35) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt5; 
                end
                //Blue Column
                else if( 
                ( 
                (240+36<=h_cnt && h_cnt<=240+39) || (240+72<=h_cnt && h_cnt<=240+77)
                )
                && 380+36<=v_cnt && v_cnt<=380+39) begin
//                    {vgaRed, vgaGreen, vgaBlue} = Black; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorWordOpt5; 
                end
                else begin
//                    {vgaRed, vgaGreen, vgaBlue} = White; 
                    {vgaRed, vgaGreen, vgaBlue} <= ColorBGOpt5; 
                end
            end
//================================================================================================================================================The Rest
            else begin
                {vgaRed, vgaGreen, vgaBlue} <= Black;
            end
            
                
        end      
    end
end

endmodule