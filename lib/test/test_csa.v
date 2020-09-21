// Testbench for carry save adder
`timescale 1ns / 1ps

module test_csa;

  // Regs and wires for input/output
  reg[W-1:0]  A,B,C;
  wire[W-1:0] csa_s;
  wire[W-1:0] csa_co;
  wire[W:0]   S;
  wire        Co;

  // Define the width of the Carry Save
  parameter W = 4;
  // Delay should scale as a function of W
  // to account for worst-case carry length
  // We still have ot use the ripple carry adder to "decode" the CSA output
  parameter DLY = 30*W;
  // It's already defined in ripple_carry_adder
  // but let's go ahead and override it here for fun.
  defparam DUT.W=W;
  defparam RCA.W=W;

  //Instantiate your "Device Under Test"
  carry_save_adder  DUT(A,B,C,csa_s,csa_co);
  ripple_carry_adder RCA(csa_co,{1'b0,csa_s[W-1:1]},1'b0,S[W:1],Co);
  assign S[0] = csa_s[0];

  initial begin
    // Hooks for vvp/gtkwave
    // the *.vcd filename should match the *.v filename for Makefile cleanliness
    $dumpfile("test_csa.vcd");
    $dumpvars(0,test_csa);

    // Make things easy for ourselves with for loops
    for (int a=0; a<2**W; a=a+1) begin
      for (int b=0; b<2**W; b=b+1) begin
        for (int c=0; c<2**W; c=c+1) begin
          A=a; B=b; C=c;        
          #DLY // Wait a bit for things to settle
        
          // Let's do some self-checking, shall we?
          if (a+b+c != {Co,S}) 
            $display("0x%x + 0x%x returned 0x%x, expected 0x%x",A,B,{Co,S},a+b);
        end
      end
    end
    // Since we're only printing failures...
    $display("No news is good news! Test finished...");
  end
endmodule
