// W-bit Ripple Carry Adder
`timescale 1ns / 1ps

module ripple_carry_adder(
  input  [W-1:0] A,B, // W-bit Input Operands
  input          Ci,  // Carry In
  output [W-1:0] S,   // W-bit Sum
  output         Co); // Carry Out

  parameter W = 4; //Operand Width

  wire[W:0] carry; // Intermediary Nodes, note array size is W, not W-1

  // Hook up W full adders to implement ripple carry
  generate genvar i;
    for (i=0; i < W; i=i+1) begin
      full_adder fa_inst(A[i],B[i],carry[i],S[i],carry[i+1]);
    end
  endgenerate

  // Handle fencepost problem by hooking up Carry In and Out
  assign carry[0] = Ci; //Ci is an input
  assign Co = carry[W]; //Co is an output
endmodule
