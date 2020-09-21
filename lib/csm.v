// Carry Save Array Multiplier (Unsigned)
// with support for C = C + A*B
`timescale 1ns / 1ps

module carry_save_mult
 (input    [W-1:0] A,B,
  input  [2*W-1:0] C,
  output [2*W-1:0] S,
  output   [W-1:0] Co);

  parameter W = 4;
  parameter DLY = 5;

  wire [W-1:0] ab  [W-1:0];
  wire [W-1:0] sum   [W:0];
  wire [W-1:0] carry [W:0];

  assign carry[0] = C[W-1:0];
  assign sum[0]   = 0;

  generate genvar i,j;
    //Build a big matrix of A and B values
    //Note A[j] & B[i]!
    for (i=0; i<W; i=i+1) begin
      for (j=0; j<W; j=j+1) begin
        and #DLY and_inst(ab[i][j],A[j],B[i]);
      end
    end

    // Stack carry save addders
    for (i=0; i<W; i=i+1) begin
      carry_save_adder csa_inst({C[W-1+i],sum[i][W-1:1]},ab[i],carry[i],sum[i+1],carry[i+1]);
      assign S[i] = sum[i+1][0];
    end
  endgenerate
  
  // The structure has some special casing because it's a parallelogram
  assign S[2*W-1:W] = {C[2*W-1],sum[W][W-1:1]};
  assign Co = carry[W];

endmodule
