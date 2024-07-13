module Event_Controller(
    inout wire PS2_DATA,
    inout wire PS2_CLK,
    input wire clk,
    input rst,
    output [3:0] an,
    output [6:0] seg,
    output dp,
    output reg [3:0] vgaRed,
    output reg [3:0] vgaGreen,
    output reg [3:0] vgaBlue,
    output hsync,
    output vsync,
	output reg pmod_1,
	output reg pmod_2,
	output reg pmod_4
);

     wire clk_25MHz;
    wire clk_segment;
    wire clk_20;
    wire clk_22;
    wire clk_24;
    wire clk_25;
    wire valid_screen;
    wire [9:0] h_cnt; //640
    wire [9:0] v_cnt;  //480
    
    //Keyboard Buttons
    wire wEnterP, wFP, wRP, wTP;
    wire wWP, wAP, wSP, wDP;
    wire wUpA, wRiA, wLeA, wDoA;
    
    //Segment Displays
    wire [3:0]wChosenInput;
    
    //Variable for States
    parameter [3:0]SPick1 = 4'd1;
    parameter [3:0]SPick2 = 4'd2;
    parameter [3:0]SPick3 = 4'd3;
    parameter [3:0]SPick4 = 4'd4;
    parameter [3:0]SPick5 = 4'd5;
    parameter [3:0]SEnter_SnakeGame = 4'd10;
    reg [3:0] CurState = SPick1;
    
    //wire for VGAs
    wire [3:0] VGARedMenu;
    wire [3:0] VGAGreenMenu;
    wire [3:0] VGABlueMenu;
    wire [3:0] VGARedSnake;
    wire [3:0] VGAGreenSnake;
    wire [3:0] VGABlueSnake;
    
    //wire for music
    wire wpmod1_AUMM;
    wire wpmod2_AUMM;
    wire wpmod4_AUMM;
    wire wpmod1_ENT;
    wire wpmod2_ENT;
    wire wpmod4_ENT;
    
    //Testing VGA
//    assign vgaRed = VGARedMenu;
//    assign vgaGreen = VGAGreenMenu;
//    assign vgaBlue = VGABlueMenu;

    //Testing Music
//    assign pmod_1 = wpmod1_AUMM;
//    assign pmod_2 = wpmod2_AUMM;
//    assign pmod_4 = wpmod4_AUMM;
    
    //Control VGA & PMOD Output
    always@(posedge clk_25MHz) begin
        if(CurState<4'd7) begin //if in menu
            vgaRed <= VGARedMenu;
            vgaGreen <= VGAGreenMenu;
            vgaBlue <= VGABlueMenu;
            pmod_1 <= wpmod1_AUMM;
            pmod_2 <= wpmod2_AUMM;
            pmod_4 <= wpmod4_AUMM;
        end
        else begin
            vgaRed <= VGARedSnake;
            vgaGreen <= VGAGreenSnake;
            vgaBlue <= VGABlueSnake;
            pmod_1 <= wpmod1_ENT;
            pmod_2 <= wpmod2_ENT;
            pmod_4 <= wpmod4_ENT;
        end
    end
    
    
    wire OPD_rst;
    CombineOnePulseDebounce OPD_rstn_inst(
      .input_b(rst),
      .clk(clk),
      .out_op(OPD_rst)
    );
    
    
    //Clock Divisor for VGA: 25Mhz & 7Segment
    clock_divisor clk_div_vga_seg(
      .clk(clk),
      .clk1(clk_25MHz),
      .clk17(clk_segment),
      .clk20(clk_20),
      .clk22(clk_22),
      .clk24(clk_24),
      .clk25(clk_25)
    );
    
    //Keyboard Control
    Keyboard_Control KB_c(
    .Enter_Press(wEnterP), .F_Press(wFP), .R_Press(wRP), .T_Press(wTP),
    .W_Press(wWP), .A_Press(wAP), .S_Press(wSP), .D_Press(wDP),
    .UpArrow_Press(wUpA), .RightArrow_Press(wRiA), .LeftArrow_Press(wLeA), .DownArrow_Press(wDoA),
    .PS2_DATA(PS2_DATA),
    .PS2_CLK(PS2_CLK),
    .clk(clk),
    .rst(OPD_rst)
    );
    
    wire wOnePulseWP;
    wire wOnePulseSP;
    wire wOnePulseEnterP;
    wire wOnePulseRST;
    OnePulse OPWP_M(wOnePulseWP, wWP, clk_22);
    OnePulse OPSP_M(wOnePulseSP, wSP, clk_22);
    OnePulse OPEnterP_M(wOnePulseEnterP, wEnterP, clk_22);
    OnePulse OPReset_M(wOnePulseRST, rst, clk_22);
    
    
    //States
    always@(posedge clk_22) begin
        if(wOnePulseRST) begin
            CurState <= SPick1;
        end
        else begin
            if(CurState==SPick1)begin
                if(wOnePulseSP)begin
                    CurState <= SPick2; 
                end
                else if(wOnePulseEnterP)begin
                    CurState <= SEnter_SnakeGame; 
                end
                else begin
                    CurState <= CurState;
                end
            end
            else if(CurState==SPick2)begin
                if(wOnePulseWP)begin
                    CurState <= SPick1; 
                end
                else if(wOnePulseSP)begin
                    CurState <= SPick3; 
                end
                else begin
                    CurState <= CurState;
                end
            end
            else if(CurState==SPick3)begin
                if(wOnePulseWP)begin
                    CurState <= SPick2; 
                end
                else if(wOnePulseSP)begin
                    CurState <= SPick4; 
                end
                else begin
                    CurState <= CurState;
                end
            end
            else if(CurState==SPick4)begin
                if(wOnePulseWP)begin
                    CurState <= SPick3; 
                end
                else if(wOnePulseSP)begin
                    CurState <= SPick5; 
                end
                else begin
                    CurState <= CurState;
                end
            end
            else if(CurState==SPick5)begin
                if(wOnePulseWP)begin
                    CurState <= SPick4; 
                end
                else begin
                    CurState <= CurState;
                end
            end
            else begin
                CurState <= CurState;
            end
        end
    end

    //For Menu
    MenuPixelGen1 MPG1(
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .valid(valid_screen),
    .CurState(CurState),
    .clk(clk),
    .vgaRed(VGARedMenu),
    .vgaGreen(VGAGreenMenu),
    .vgaBlue(VGABlueMenu)
    );
    
    //For Snake Game
    wire consume_snake;
    wire [3:0]len_snake;
    wire [2:0]SG_DirectState;
    wire resSignal;
    
    direction_SG Direction_SG_Go(
    .clk(clk_25MHz),
    .w(wWP),
    .a(wAP),
    .s(wSP),
    .d(wDP),
    .state(SG_DirectState),
    .length(len_snake),
    .r(rst||wRP||wEnterP),
    .reset(resSignal)
    );
    
    SnakeGame SG_Go(
    .clkTarget(clk_22),
    .clkVGA(clk_25MHz),
    .mainCLK(clk),
    .h_cnt(h_cnt),
    .v_cnt(v_cnt),
    .valid(valid_screen),
    .CurState(SG_DirectState),
    .vgaRed(VGARedSnake),
    .vgaGreen(VGAGreenSnake),
    .vgaBlue(VGABlueSnake),
    .Consume(consume_snake),
    .length(len_snake),
    .reset(rst||wRP||wEnterP)
    );
    
    
    //VGA Controller: To Control VGA
    vga_controller vga_inst(
      .pclk(clk_25MHz),
      .reset(OPD_rst),
      .hsync(hsync),
      .vsync(vsync),
      .valid(valid_screen),
      .h_cnt(h_cnt),
      .v_cnt(v_cnt)
    );
    
    //For Music
    TOP_AM_MM AUMM_Music_Go(
    .clk(clk),
    .reset(rst||wRP||wEnterP),
    .pmod_1(wpmod1_AUMM),
    .pmod_2(wpmod2_AUMM),
    .pmod_4(wpmod4_AUMM)
    );
    
    TOP_Entertainer ENT_Music_Go(
    .clk(clk),
    .reset(rst||wRP||wEnterP),
    .pmod_1(wpmod1_ENT),
    .pmod_2(wpmod2_ENT),
    .pmod_4(wpmod4_ENT)
    );
    
    //Input for SegmentDisplay
    SegDis_IC SegDisIC_ins(
    .Enter_Press(wEnterP), .F_Press(wFP),  .R_Press(wRP), .T_Press(wTP),
    .W_Press(wWP), .A_Press(wAP),  .S_Press(wSP), .D_Press(wDP),
    .UpArrow_Press(wUpA), .RightArrow_Press(wRiA),  .LeftArrow_Press(wLeA), .DownArrow_Press(wDoA),
    .clk(clk),
    .rst(OPD_rst),
    .ChosenInput(wChosenInput)
);
    
    //Segment Display Control
    SegDis SegDis_c(
    .clk(clk_segment),
    .ChosenInput(wChosenInput),
    .AN(an),
    .SEG(seg),
    .DP(dp)
    );

endmodule