module CombineOnePulseDebounce(
    input wire input_b,
    input wire clk,
    output out_op
);
    wire wDebounce;
    wire wout_op;
    
    //Debounce and OnePulse
    debounce_FPGA DeTopRST_N(wDebounce, input_b, clk);
    OnePulse OP_TopRST_N(wout_op, wDebounce, clk);
    
    assign out_op=wout_op;

endmodule



module OnePulse(
  output reg signal_single_pulse,
  input wire signal,
  input wire clock
  );

  reg signal_delay;

  always @(posedge clock) begin
      if (signal == 1'b1 & signal_delay == 1'b0)
          signal_single_pulse <= 1'b1;
      else
          signal_single_pulse <= 1'b0;
      signal_delay <= signal;
  end
endmodule

module debounce_FPGA(outsignal, insignal, clk);
output outsignal;
input insignal;
input clk;
reg[3:0]DFlipFlop;
assign outsignal = ((DFlipFlop==4'b1111) ? 1'b1:1'b0);

always @(posedge clk)begin
    DFlipFlop[3:1]<= DFlipFlop[2:0];
    DFlipFlop[0] <= insignal;
end
endmodule