module TOP_Entertainer (
	input clk,
	input reset,
	output pmod_1,
	output pmod_2,
	output pmod_4
);
parameter BEAT_FREQ = 32'd5;	//one beat=0.125sec
parameter DUTY_BEST = 10'd512;	//duty cycle=50%

wire [31:0] freq;
wire [7:0] ibeatNum;
wire beatFreq;

assign pmod_2 = 1'd1;	//no gain(6dB)
assign pmod_4 = 1'd1;	//turn-on

//Generate beat speed
PWM_gen btSpeedGen_Ent ( .clk(clk), 
					 .reset(reset),
					 .freq(BEAT_FREQ),
					 .duty(DUTY_BEST), 
					 .PWM(beatFreq)
);
	
//manipulate beat
PlayerCtrl_Entertainer playerCtrl_Ent ( .clk(beatFreq), 
                                        .reset(reset),
						                .ibeat(ibeatNum)
);	
	
//Generate variant freq. of tones
Music_Ent music_Ent ( .ibeatNum(ibeatNum),
				.tone(freq)
);

// Generate particular freq. signal
PWM_gen toneGen_Ent ( .clk(clk), 
				  .reset(reset), 
				  .freq(freq),
				  .duty(DUTY_BEST), 
				  .PWM(pmod_1)
);
endmodule

module PlayerCtrl_Entertainer (
	input clk,
	input reset,
	output reg [7:0] ibeat
);
parameter BEATLEAGTH = 160;

always @(posedge clk, posedge reset) begin
	if (reset)
		ibeat <= 0;
	else if (ibeat < BEATLEAGTH) 
		ibeat <= ibeat + 1;
	else 
		ibeat <= 0;
end

endmodule