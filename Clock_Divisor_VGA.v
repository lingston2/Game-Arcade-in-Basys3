module clock_divisor(clk25, clk24, clk22, clk20, clk17, clk1, clk);
    input clk;
    output clk1;
    output clk17;
    output clk20;
    output clk22;
    output clk24;
    output clk25;
    
    reg [30:0] num;
    wire [30:0] next_num;
    
    always @(posedge clk) begin
      num <= next_num;
    end
    
    assign next_num = num + 1'b1;
    assign clk1 = num[1];
    assign clk17 = num[17];
    assign clk20 = num[20];
    assign clk22 = num[22];
    assign clk24 = num[24];
    assign clk25 = num[25];

endmodule
