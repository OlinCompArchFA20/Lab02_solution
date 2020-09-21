// Testbench for carry save multiplier
`timescale 1ns / 1ps

module test_csm;

  // Regs and wires for input/output
  reg    [W-1:0] A;
  reg    [W-1:0] B;
  reg  [2*W-1:0] C;
  wire [2*W-1:0] S;
  wire   [W-1:0] Carry;
  wire [2*W-1:0] P;
  wire           Co;

  // Define the width of the Multiplier
  parameter W = 4;
  parameter DLY = 50*W;

  defparam DUT.W=W;
  defparam RCA.W=W;

  //Instantiate your "Device Under Test"
  carry_save_mult DUT(A,B,C,S,Carry);
  ripple_carry_adder RCA(S[2*W-1:W],Carry,1'b0,P[W*2-1:W],Co);
  assign P[W-1:0] = S[W-1:0];

  initial begin
    // Hooks for vvp/gtkwave
    // the *.vcd filename should match the *.v filename for Makefile cleanliness
    $dumpfile("test_csm.vcd");
    $dumpvars(0,test_csm);

    for (int a=0;a<2**(W);a=a+1) begin
      for (int b=0;b<2**(W);b=b+1) begin
        A = a; B = b; C = 0;
        #DLY
        $display("%d x %d = %d",A,B,P);
      end
    end
    
  end
endmodule
