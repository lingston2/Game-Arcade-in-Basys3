module SegDis(
  input clk,
  input [3:0]ChosenInput,
  output reg [3:0] AN,
  output reg [6:0] SEG,
  output reg DP
);

reg [3:0] AN_next;

always@(posedge clk)begin
  AN <= AN_next;
  DP <= 1'b1;
end

always@(*)begin
  AN_next = 4'b1110;
  if(AN==4'b1110) begin
    AN_next = 4'b1101;
  end else if(AN==4'b1101) begin
    AN_next = 4'b1011;
  end else if(AN==4'b1011) begin
    AN_next = 4'b1110;
  end
end

//W, A, S, D: 0, 1, 2, 3
//UpA, RiA, LeA, DoA: 4, 5, 6, 7
//Ent, F, R, T: 8, 9, 10 ,11
always@(*)begin
  case(ChosenInput)
    4'd0: SEG = 7'b0000001; //0
    4'd1: SEG = 7'b1001111; //1
    4'd2: SEG = 7'b0010010; //2
    4'd3: SEG = 7'b0000110; //3
    4'd4: SEG = 7'b1001100; //4
    4'd5: SEG = 7'b0100100; //5
    4'd6: SEG = 7'b0100000; //6
    4'd7: SEG = 7'b0001111; //7 
    4'd8: SEG = 7'b0000000; //8
    4'd9: SEG = 7'b0000100; //9
    4'd10: SEG = 7'b0001000; //A
    4'd11: SEG = 7'b1100000; //b
    default: SEG = 7'b1111111;
  endcase
end

endmodule