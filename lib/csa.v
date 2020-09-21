// W-bit Carry Save Adder
`timescale 1ns / 1ps

module carry_save_adder(
  input  [W-1:0] A,B,C, // W-bit Input Operands
  output [W-1:0] S,     // W-bit Sum
  output [W-1:0] Co);   // Carry Out

  parameter W = 4;      // Default width

  // Hook up W full adders in parallel
  generate genvar i;
    for (i=0; i < W; i=i+1) begin
      full_adder fa_inst(A[i],B[i],C[i],S[i],Co[i]);
    end
  endgenerate

endmodule
