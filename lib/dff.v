// Emulated D Flip Flop
`timescale 1ns / 1ps

module DFF(
  input              clk,
  input              _rst,
  input      [W-1:0] D,  
  output reg [W-1:0] Q);

  // Default width is 1
  parameter W = 1;
  
  // Initial data with asynchronous reset (i.e. not clocked)
  parameter INITVAL = 0;

  always @(posedge clk or negedge _rst)
    if (~_rst) 
      Q <= INITVAL;
    else 
      Q <= D;
endmodule
