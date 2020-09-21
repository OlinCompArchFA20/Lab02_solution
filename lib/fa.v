// Full Adder
`timescale 1ns / 1ps

module full_adder(
  input  A,B, // Input Operands
  input  Ci,  // Carry In
  output S,   // Sum
  output Co); // Carry Out
  
  parameter DLY = 5;    // Gate Delay
  wire xor1,nand1,nand2;// Intermediary nodes

  // Compute Sum
  xor  #DLY G1(xor1,A,B);
  xor  #DLY G2(S,xor1,Ci);
  // Compute Carry Out
  nand #DLY G3(nand1,xor1,Ci);
  nand #DLY G4(nand2,A,B);
  nand #DLY G5(Co,nand1,nand2);
endmodule
