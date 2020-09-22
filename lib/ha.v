// Half Adder

module half_adder(
  input  A, B, // Input Operands
  output S,    // Sum
  output Co);  // Carry Out

  parameter DLY = 5; // Gate Delay

  xor #DLY ha_xor(S,A,B); //Compute Sum
  and #DLY ha_and(Co,A,B);//Compute Carry Out
endmodule
