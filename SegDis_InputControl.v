module SegDis_IC(
    input Enter_Press, input F_Press,  input R_Press, input T_Press,
    input W_Press, input A_Press,  input S_Press, input D_Press,
    input UpArrow_Press, input RightArrow_Press,  input LeftArrow_Press, input DownArrow_Press,
    input clk,
    input rst,
    output reg [3:0]ChosenInput
);


always@(clk)begin
    if(rst) begin
        ChosenInput = 4'd12; 
    end
    else begin
        if(W_Press==1'd1 && A_Press==1'd0 && S_Press==1'd0 && D_Press==1'd0
        && UpArrow_Press==1'd0 && RightArrow_Press==1'd0 && LeftArrow_Press==1'd0 && DownArrow_Press==1'd0
        && Enter_Press==1'd0 && F_Press==1'd0 && R_Press==1'd0 && T_Press==1'd0) begin
            ChosenInput <= 4'd0;
        end else if(A_Press==1'd1 && W_Press==1'd0 && S_Press==1'd0 && D_Press==1'd0
        && UpArrow_Press==1'd0 && RightArrow_Press==1'd0 && LeftArrow_Press==1'd0 && DownArrow_Press==1'd0
        && Enter_Press==1'd0 && F_Press==1'd0 && R_Press==1'd0 && T_Press==1'd0) begin
            ChosenInput <= 4'd1;
        end else if(S_Press==1'd1 && W_Press==1'd0 && A_Press==1'd0 && D_Press==1'd0
        && UpArrow_Press==1'd0 && RightArrow_Press==1'd0 && LeftArrow_Press==1'd0 && DownArrow_Press==1'd0
        && Enter_Press==1'd0 && F_Press==1'd0 && R_Press==1'd0 && T_Press==1'd0) begin
            ChosenInput <= 4'd2;
        end else if(D_Press==1'd1 && W_Press==1'd0 && A_Press==1'd0 && S_Press==1'd0
        && UpArrow_Press==1'd0 && RightArrow_Press==1'd0 && LeftArrow_Press==1'd0 && DownArrow_Press==1'd0
        && Enter_Press==1'd0 && F_Press==1'd0 && R_Press==1'd0 && T_Press==1'd0) begin
            ChosenInput <= 4'd3;
            
        end else if(UpArrow_Press==1'd1 && RightArrow_Press==1'd0 && LeftArrow_Press==1'd0 && DownArrow_Press==1'd0
        && W_Press==1'd0 && A_Press==1'd0 && S_Press==1'd0 && D_Press==1'd0
        && Enter_Press==1'd0 && F_Press==1'd0 && R_Press==1'd0 && T_Press==1'd0) begin
            ChosenInput <= 4'd4;
        end else if(RightArrow_Press==1'd1 && UpArrow_Press==1'd0 && LeftArrow_Press==1'd0 && DownArrow_Press==1'd0
        && W_Press==1'd0 && A_Press==1'd0 && S_Press==1'd0 && D_Press==1'd0
        && Enter_Press==1'd0 && F_Press==1'd0 && R_Press==1'd0 && T_Press==1'd0) begin
            ChosenInput <= 4'd5;
        end else if(LeftArrow_Press==1'd1 && UpArrow_Press==1'd0 && RightArrow_Press==1'd0 && DownArrow_Press==1'd0
        && W_Press==1'd0 && A_Press==1'd0 && S_Press==1'd0 && D_Press==1'd0
        && Enter_Press==1'd0 && F_Press==1'd0 && R_Press==1'd0 && T_Press==1'd0) begin
            ChosenInput <= 4'd6;
        end else if(DownArrow_Press==1'd1 && UpArrow_Press==1'd0 && RightArrow_Press==1'd0 && LeftArrow_Press==1'd0
        && W_Press==1'd0 && A_Press==1'd0 && S_Press==1'd0 && D_Press==1'd0
        && Enter_Press==1'd0 && F_Press==1'd0 && R_Press==1'd0 && T_Press==1'd0) begin
            ChosenInput <= 4'd7;
            
        end else if(Enter_Press==1'd1 && F_Press==1'd0 && R_Press==1'd0 && T_Press==1'd0
        && W_Press==1'd0 && A_Press==1'd0 && S_Press==1'd0 && D_Press==1'd0
        && UpArrow_Press==1'd0 && RightArrow_Press==1'd0 && LeftArrow_Press==1'd0 && DownArrow_Press==1'd0) begin
            ChosenInput <= 4'd8;
        end else if(F_Press==1'd1 && Enter_Press==1'd0 && R_Press==1'd0 && T_Press==1'd0
        && W_Press==1'd0 && A_Press==1'd0 && S_Press==1'd0 && D_Press==1'd0
        && UpArrow_Press==1'd0 && RightArrow_Press==1'd0 && LeftArrow_Press==1'd0 && DownArrow_Press==1'd0) begin
            ChosenInput <= 4'd9;
        end else if(R_Press==1'd1 && Enter_Press==1'd0 && F_Press==1'd0 && T_Press==1'd0
        && W_Press==1'd0 && A_Press==1'd0 && S_Press==1'd0 && D_Press==1'd0
        && UpArrow_Press==1'd0 && RightArrow_Press==1'd0 && LeftArrow_Press==1'd0 && DownArrow_Press==1'd0) begin
            ChosenInput <= 4'd10;
        end else if(T_Press==1'd1 && Enter_Press==1'd0 && F_Press==1'd0 && R_Press==1'd0
        && W_Press==1'd0 && A_Press==1'd0 && S_Press==1'd0 && D_Press==1'd0
        && UpArrow_Press==1'd0 && RightArrow_Press==1'd0 && LeftArrow_Press==1'd0 && DownArrow_Press==1'd0) begin
            ChosenInput <= 4'd11;
        end else begin
            ChosenInput <= 4'd12; 
        end    
    end
end


endmodule