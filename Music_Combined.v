`define NC3 32'd130 //C3_freq
`define ND3 32'd146 //D3_freq
`define NE3 32'd164 //E3_freq
`define NF3 32'd174 //F3_freq
`define NG3 32'd195 //G3_freq
`define NA3 32'd220 //A3_freq
`define NB3 32'd246 //B3_freq

`define NC4 32'd261 //C4_freq
`define ND4 32'd293 //D4_freq
`define NE4 32'd329 //E4_freq
`define NF4 32'd349 //F4_freq
`define NG4 32'd391 //G4_freq
`define NA4 32'd440 //A4_freq
`define NB4 32'd493 //B4_freq

`define NC5 32'd523 //C5_freq
`define ND5 32'd587 //D5_freq
`define NE5 32'd659 //E5_freq
`define NF5 32'd698 //F5_freq
`define NG5 32'd783 //G5_freq
`define NA5 32'd880 //A5_freq
`define NB5 32'd987 //C5_freq

`define NC6 32'd1046 //C6_freq
`define ND6 32'd1174 //D6_freq
`define NE6 32'd1319 //E6_freq
`define NF6 32'd1396 //F6_freq
`define NG6 32'd1567 //G6_freq
`define NA6 32'd1769 //A6_freq
`define NB6 32'd1975 //C6_freq

`define NSIL 32'd20000 //slience (over freq.)

//Specials: Entertainer
`define NbA3 32'd207 //bA3_freq
`define NsD4 32'd311 //sD4_freq
`define NsD6 32'd1244 //sD6_freq
`define NsF5 32'd739 //sF5_freq

//Specials: AuMatin or MorningMood
`define NsG4 32'd415 //sG4_freq
`define NsF4 32'd369 //sF4_freq
`define NsG5 32'd830 //sG5_freq
//`define NsF5 32'd739 //sF5_freq (Repeat)


module Music_Ent (
	input [7:0] ibeatNum,	
	output reg [31:0] tone
);

always @(*) begin
	case (ibeatNum)		// 1/4 beat
		8'd0 : tone = `NSIL;	//Start
		
		8'd1 : tone = `ND6;//1
		8'd2 : tone = `NE6;
		8'd3 : tone = `NC6;
		8'd4 : tone = `NA5;	
		8'd5 : tone = `NA5;
		8'd6 : tone = `NB5;
		8'd7 : tone = `NG5;
		8'd8 : tone = `NG5;	
		
		8'd9 : tone = `ND5;//2
		8'd10 : tone = `NE5;
		8'd11 : tone = `NC5;
		8'd12 : tone = `NA4; 
		8'd13 : tone = `NA4;
		8'd14 : tone = `NB4;
		8'd15 : tone = `NG4;
		8'd16 : tone = `NG4;
		
		8'd17 : tone = `ND4;//3
		8'd18 : tone = `NE4;
		8'd19 : tone = `NC4;
		8'd20 : tone = `NA3; 
		8'd21 : tone = `NA3;
		8'd22 : tone = `NB3;
		8'd23 : tone = `NA3;
		8'd24 : tone = `NbA3;
		
		8'd25 : tone = `NG3;//4
		8'd26 : tone = `NG3;
		8'd27 : tone = `NSIL;
		8'd28 : tone = `NSIL; 
		8'd29 : tone = `NG5;
		8'd30 : tone = `NG5;
		8'd31 : tone = `ND4;
		8'd32 : tone = `NsD4;
		
		8'd33 : tone = `NE4;//5
		8'd34 : tone = `NC5;
		8'd35 : tone = `NC5;
		8'd36 : tone = `NE4; 
		8'd37 : tone = `NC5;
		8'd38 : tone = `NC5;
		8'd39 : tone = `NE4;
		8'd40 : tone = `NC5;
		
		8'd41 : tone = `NC5;//6
		8'd42 : tone = `NC5;
		8'd43 : tone = `NC5;
		8'd44 : tone = `NC5;
		8'd45 : tone = `NC5; 
		8'd46 : tone = `NC5;
		8'd47 : tone = `NC6;
		8'd48 : tone = `ND6;
		
		8'd49 : tone = `NsD6;//7
		8'd50 : tone = `NE6;
		8'd51 : tone = `NC6;
		8'd52 : tone = `ND6;
		8'd53 : tone = `NE6; 
		8'd54 : tone = `NE6;
		8'd55 : tone = `NB5;
		8'd56 : tone = `ND6;
		
		8'd57 : tone = `ND6;//8
		8'd58 : tone = `NC6;
		8'd59 : tone = `NC6;
		8'd60 : tone = `NC6;
		8'd61 : tone = `NC6; 
		8'd62 : tone = `NSIL;
		8'd63 : tone = `NSIL;
		8'd64 : tone = `ND4;
		
		8'd65 : tone = `NsD4;//9
		8'd66 : tone = `NE4;
		8'd67 : tone = `NC5;
		8'd68 : tone = `NC5;
		8'd69 : tone = `NE4; 
		8'd70 : tone = `NC5;
		8'd71 : tone = `NC5;
		8'd72 : tone = `NE4;
		
		8'd73 : tone = `NC5;//10
		8'd74 : tone = `NC5;
		8'd75 : tone = `NC5;
		8'd76 : tone = `NC5;
		8'd77 : tone = `NC5;
		8'd78 : tone = `NC5;
		8'd79 : tone = `NC5;
		8'd80 : tone = `NA5;
		
		8'd81 : tone = `NG5;//11
		8'd82 : tone = `NsF5;
		8'd83 : tone = `NA5;
		8'd84 : tone = `NC6;
		8'd85 : tone = `NE6;
		8'd86 : tone = `NE6;
		8'd87 : tone = `ND6;
		8'd88 : tone = `NC6;
		
		8'd89 : tone = `NA5;//12
		8'd90 : tone = `ND6;
		8'd91 : tone = `ND6;
		8'd92 : tone = `ND6;
		8'd93 : tone = `ND6;
		8'd94 : tone = `NSIL;
		8'd95 : tone = `NSIL;
		8'd96 : tone = `ND4;
		
		8'd97 : tone = `NsD4;//13
		8'd98 : tone = `NE4;
		8'd99 : tone = `NC5;
		8'd100 : tone = `NC5;
		8'd101 : tone = `NE4;
		8'd102 : tone = `NC5;
		8'd103 : tone = `NC5;
		8'd104 : tone = `NE4;
		
		8'd105 : tone = `NC5;//14
		8'd106 : tone = `NC5;
		8'd107 : tone = `NC5;
		8'd108 : tone = `NC5;
		8'd109 : tone = `NC5;
		8'd110 : tone = `NC5;
		8'd111 : tone = `NC5;
		8'd112 : tone = `NC6;
		
		8'd113 : tone = `ND6;//15
		8'd114 : tone = `NsD6;
		8'd115 : tone = `NE6;
		8'd116 : tone = `NC6;
		8'd117 : tone = `ND6;
		8'd118 : tone = `NE6;
		8'd119 : tone = `NE6;
		8'd120 : tone = `NB5;
		
		8'd121 : tone = `ND6;//16
		8'd122 : tone = `ND6;
		8'd123 : tone = `NC6;
		8'd124 : tone = `NC6;
		8'd125 : tone = `NC6;
		8'd126 : tone = `NC6;
		8'd127 : tone = `NSIL;
		8'd128 : tone = `NSIL;
		
		8'd129 : tone = `NC6;//17
		8'd130 : tone = `ND6;
		8'd131 : tone = `NE6;
		8'd132 : tone = `NC6;
		8'd133 : tone = `ND6;
		8'd134 : tone = `NE6;
		8'd135 : tone = `NE6;
		8'd136 : tone = `ND6;
		
		8'd137 : tone = `ND6;//18
		8'd138 : tone = `NC6;
		8'd139 : tone = `NE6;
		8'd140 : tone = `NC6;
		8'd141 : tone = `ND6;
		8'd142 : tone = `NE6;
		8'd143 : tone = `NE6;
		8'd144 : tone = `NC6;
		
		8'd145 : tone = `ND6;//19
		8'd146 : tone = `NC6;
		8'd147 : tone = `NE6;
		8'd148 : tone = `NC6;
		8'd149 : tone = `ND6;
		8'd150 : tone = `NE6;
		8'd151 : tone = `NE6;
		8'd152 : tone = `NB5;
		
		8'd153 : tone = `ND6;//20
		8'd154 : tone = `ND6;
		8'd155 : tone = `NC6;
		8'd156 : tone = `NC6;
		8'd157 : tone = `NC6;
		8'd158 : tone = `NC6;
		8'd159 : tone = `NSIL;
		8'd160 : tone = `NSIL;
		//Entertainer Finish
		
		8'd161 : tone = `NSIL;
		default : tone = `NSIL;
	endcase
end

endmodule

module Music_AM_MM (
	input [7:0] ibeatNum,	
	output reg [31:0] tone
);

always @(*) begin
	case (ibeatNum)		// 3/4 beat
		8'd0 : tone = `NSIL;	//Start
		
		8'd1 : tone = `NG5;//1
		8'd2 : tone = `NE5;
		8'd3 : tone = `ND5;
		8'd4 : tone = `NC5;	
		8'd5 : tone = `ND5;
		8'd6 : tone = `NE5;
		
		8'd7 : tone = `NG5;//2
		8'd8 : tone = `NE5;
		8'd9 : tone = `ND5;
		8'd10 : tone = `NC5;
		8'd11 : tone = `ND5; 
		8'd12 : tone = `NE5; 
		
		8'd13 : tone = `NG5;//3
		8'd14 : tone = `NE5;
		8'd15 : tone = `NG5;
		8'd16 : tone = `NA5;
		8'd17 : tone = `NE5;
		8'd18 : tone = `NA5;
		
		8'd19 : tone = `NG5;//4
		8'd20 : tone = `NE5;
		8'd21 : tone = `ND5;
		8'd22 : tone = `NC5;
		8'd23 : tone = `NC5;
		8'd24 : tone = `NC5;
		
		8'd25 : tone = `NG4;//5
		8'd26 : tone = `NE4;
		8'd27 : tone = `ND4;
		8'd28 : tone = `NC4;
		8'd29 : tone = `ND4;
		8'd30 : tone = `NE4;
		
		8'd31 : tone = `NG4;//6
		8'd32 : tone = `NE4;
		8'd33 : tone = `ND4;
		8'd34 : tone = `NC4;
		8'd35 : tone = `ND4;
		8'd36 : tone = `NE4; 
		
		8'd37 : tone = `NG4;//7
		8'd38 : tone = `NE4;
		8'd39 : tone = `NG4;
		8'd40 : tone = `NA4;
		8'd41 : tone = `NE4;
		8'd42 : tone = `NA4;
		
		8'd43 : tone = `NB4;//8
		8'd44 : tone = `NsG4;
		8'd45 : tone = `NsF4;
		8'd46 : tone = `NE4;
		8'd47 : tone = `NE4;
		8'd48 : tone = `NE4;
		
		8'd49 : tone = `NB5;//9
		8'd50 : tone = `NsG5;
		8'd51 : tone = `NsF5;
		8'd52 : tone = `NE5;
		8'd53 : tone = `NsF5; 
		8'd54 : tone = `NsG5;
		
		8'd55 : tone = `NB5;//10
		8'd56 : tone = `NsG5;
		8'd57 : tone = `NsF5;
		8'd58 : tone = `NE5;
		8'd59 : tone = `NsF5;
		8'd60 : tone = `NsG5;
		
		8'd61 : tone = `NB5;//11		 
		8'd62 : tone = `NsG5;
		8'd63 : tone = `NB5;
		8'd64 : tone = `NC6;
		8'd65 : tone = `NsG5;
		8'd66 : tone = `NC6;
		
		8'd67 : tone = `NB5;//12
		8'd68 : tone = `NsG5;
		8'd69 : tone = `NsF5; 
		8'd70 : tone = `NE5;
		8'd71 : tone = `NE5;
		8'd72 : tone = `NE5;
		
		8'd73 : tone = `NB4;//13
		8'd74 : tone = `NsG4;
		8'd75 : tone = `NsF4;
		8'd76 : tone = `NE4;
		8'd77 : tone = `NsF4; 
		8'd78 : tone = `NsG4;
		
		8'd79 : tone = `NB4;//14
		8'd80 : tone = `NsG4;
		8'd81 : tone = `NsF4;
		8'd82 : tone = `NE4;
		8'd83 : tone = `NsF4;
		8'd84 : tone = `NsG4;
		
		8'd85 : tone = `NB4;//15
		8'd86 : tone = `NsG4;
		8'd87 : tone = `NB4;
		8'd88 : tone = `NC5;
		8'd89 : tone = `NA4;
		8'd90 : tone = `NC5;
		
		8'd91 : tone = `ND5;//16
		8'd92 : tone = `NB4;
		8'd93 : tone = `NA4; 
		8'd94 : tone = `NG4;
		8'd95 : tone = `NG4;
		8'd96 : tone = `NG4;
		
		8'd97 : tone = `ND6;//17
		8'd98 : tone = `NB5; 
		8'd99 : tone = `NA5;
		8'd100 : tone = `NG5;
		8'd101 : tone = `NA5; 
		8'd102 : tone = `NB5;
		
		8'd103 : tone = `ND5;//18
		8'd104 : tone = `NB4;
		8'd105 : tone = `NA4;
		8'd106 : tone = `NG4;
		8'd107 : tone = `NA4;
		8'd108 : tone = `NB4;
		
		8'd109 : tone = `ND6;//19
		8'd110 : tone = `NB5; 
		8'd111 : tone = `NG5;
		8'd112 : tone = `ND5;
		8'd113 : tone = `NB4;
		8'd114 : tone = `NG4;
		
		8'd115 : tone = `ND6;//20
		8'd116 : tone = `NB5;
		8'd117 : tone = `NG5;
		8'd118 : tone = `ND5; 
		8'd119 : tone = `NB4;
		8'd120 : tone = `NG4;
		//AuMatin or MorningMood Finish
		
		8'd121 : tone = `NSIL;
		default : tone = `NSIL;
	endcase
end

endmodule