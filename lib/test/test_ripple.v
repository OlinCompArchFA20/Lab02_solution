// Testbench for ripple carry adder
`timescale 1ns/1ps

module test_ripple;

  // Regs and wires for input/output
  reg[W-1:0] A,B;
  reg Ci;
  wire[W-1:0] S;
  wire Co;

  // Define the width of the Ripple Carry Adder
  parameter W = 4;
  // Delay should scale as a function of W
  // to account for worst-case carry length
  parameter DLY = 30*W;
  // It's already defined in ripple_carry_adder
  // but let's go ahead and override it here for fun.
  defparam DUT.W=W;
  //Instantiate your "Device Under Test"
  ripple_carry_adder DUT(A,B,Ci,S,Co);

  initial begin
    // Hooks for vvp/gtkwave
    // the *.vcd filename should match the *.v filename for Makefile cleanliness
    $dumpfile("test_ripple.vcd");
    $dumpvars(0,test_ripple);

    // Make things easy for ourselves with for loops
    for (int a=0; a<2**W; a=a+1) begin
      for (int b=0; b<2**W; b=b+1) begin
        // Asssume Cin is always false
        A=a; B=b; Ci=0;        
        #DLY // Wait a bit for things to settle
        
        // Let's do some self-checking, shall we?
        if (a+b != {Co,S}) 
          $display("0x%x + 0x%x returned 0x%x, expected 0x%x",A,B,{Co,S},a+b);
      end
    end
    // Since we're only printing failures...
    $display("No news is good news! Test finished...");
  end
endmodule
