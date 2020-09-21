// Carry Save Array Multiplier (Unsigned)
`timescale 1ns / 1ps

module array_mult
 (input    [W-1:0] A,B, //Input operands
  output [2*W-1:0] P,   //Output operand
  output           Co);

  parameter W   = 4;
  parameter DLY = 5;

  wire [W-1:0] ab  [W-1:0];
  wire [W-1:0] sum   [W:0];
  wire [W-1:0] carry [W:0];

  assign carry[0] = 0;
  assign sum[0] = 0;

  generate genvar i,j;
    for (i=0; i<W; i=i+1) begin
      for (j=0; j<W; j=j+1) begin
        and #DLY and_inst(ab[i][j],A[j],B[i]);
      end
      carry_save_adder csa_inst({1'b0,sum[i][W-1:1]},ab[i],carry[i],sum[i+1],carry[i+1]);
      assign P[i] = sum[i+1][0];
    end
  endgenerate

  ripple_carry_adder rca({1'b0,sum[W][W-1:1]},carry[W],1'b0,P[W*2-1:W],Co);
endmodule
