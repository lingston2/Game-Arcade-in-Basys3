module Keyboard_Control(
    output Enter_Press, output F_Press,  output R_Press, output T_Press,
    output W_Press, output A_Press,  output S_Press, output D_Press,
    output UpArrow_Press, output RightArrow_Press,  output LeftArrow_Press, output DownArrow_Press,
    inout wire PS2_DATA,
    inout wire PS2_CLK,
    input wire clk,
    input wire rst
);

//Keyboard Variables
wire [511:0] key_down;
wire [8:0] last_change;
wire been_ready;

KeyboardDecoder key_decode (
        .key_down(key_down),
        .last_change(last_change),
        .key_valid(been_ready),
        .PS2_DATA(PS2_DATA),
        .PS2_CLK(PS2_CLK),
        .rst(rst),
        .clk(clk)
);


//MainFunction - Start
parameter [8:0] Enter_Code = 9'b0_0101_1010; //5A or 5-10
parameter [8:0] W_Code = 9'b0_0001_1101; //1D or 1-13
parameter [8:0] R_Code = 9'b0_0010_1101; //2D or 2-13
parameter [8:0] T_Code = 9'b0_0010_1100; //2C or 2-12

parameter [8:0] A_Code = 9'b0_0001_1100; //1C or 1-12
parameter [8:0] S_Code = 9'b0_0001_1011; //1B or 1-11
parameter [8:0] D_Code = 9'b0_0010_0011; //23 or 1-3
parameter [8:0] F_Code = 9'b0_0010_1011; //2B or 1-11

parameter [8:0] UpArrow_Code = 9'b1_0111_0101;      //EO75 or 1-7-5
parameter [8:0] RightArrow_Code = 9'b1_0111_0100;   //EO74 or 1-7-4
parameter [8:0] LeftArrow_Code = 9'b1_0110_1011;    //EO6B or 1-6-11
parameter [8:0] DownArrow_Code = 9'b1_0111_0010;    //EO72 or 1-7-2

parameter [8:0] I_Code = 9'b0_0100_0011; //43 or 4-3
parameter [8:0] O_Code = 9'b0_0100_0100; //44 or 4-4
parameter [8:0] P_Code = 9'b0_0100_1101; //4D or 4-13
parameter [8:0] J_Code = 9'b0_0011_1011; //3B or 3-11
parameter [8:0] K_Code = 9'b0_0100_0010; //42 or 4-2
parameter [8:0] L_Code = 9'b0_0100_1011; //4B or 4-11

//Keyboard Signals
assign Enter_Press = (key_down[Enter_Code] == 1'b1) ?1'b1 : 1'b0;
assign W_Press = (key_down[W_Code] == 1'b1) ?1'b1 : 1'b0;
assign R_Press = (key_down[R_Code] == 1'b1) ?1'b1 : 1'b0;
assign T_Press = (key_down[T_Code] == 1'b1) ?1'b1 : 1'b0;

assign A_Press = (key_down[A_Code] == 1'b1) ?1'b1 : 1'b0;
assign S_Press = (key_down[S_Code] == 1'b1) ?1'b1 : 1'b0;
assign D_Press = (key_down[D_Code] == 1'b1) ?1'b1 : 1'b0;
assign F_Press = (key_down[F_Code] == 1'b1) ?1'b1 : 1'b0;

assign UpArrow_Press = (key_down[I_Code] == 1'b1) ?1'b1 : 1'b0;
assign RightArrow_Press = (key_down[L_Code] == 1'b1) ?1'b1 : 1'b0;
assign LeftArrow_Press = (key_down[J_Code] == 1'b1) ?1'b1 : 1'b0;
assign DownArrow_Press = (key_down[K_Code] == 1'b1) ?1'b1 : 1'b0;

//assign UpArrow_Press = (key_down[I_Code] == 1'b1) ?1'b1 : 1'b0;
//assign RightArrow_Press = (key_down[L_Code] == 1'b1) ?1'b1 : 1'b0;
//assign LeftArrow_Press = (key_down[J_Code] == 1'b1) ?1'b1 : 1'b0;
//assign DownArrow_Press = (key_down[K_Code] == 1'b1) ?1'b1 : 1'b0;

//assign UpArrow_Press = (key_down[UpArrow_Code] == 1'b1) ?1'b1 : 1'b0;
//assign RightArrow_Press = (key_down[RightArrow_Code] == 1'b1) ?1'b1 : 1'b0;
//assign LeftArrow_Press = (key_down[LeftArrow_Code] == 1'b1) ?1'b1 : 1'b0;
//assign DownArrow_Press = (key_down[DownArrow_Code] == 1'b1) ?1'b1 : 1'b0;
endmodule