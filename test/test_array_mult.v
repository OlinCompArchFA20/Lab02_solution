// Testbench for carry save adder
`timescale 1ns / 1ps

module test_array_mult;

  // Regs and wires for input/output
  reg  [W-1:0] A;
  reg  [W-1:0] B;
  wire [2*W-1:0] P;
  wire         Co;

  // Define the width of the Multiplier
  parameter W = 4;
  parameter DLY = 50*W;

  defparam DUT.W=W;

  //Instantiate your "Device Under Test"
  array_mult DUT(A,B,P,Co);

  initial begin
    // Hooks for vvp/gtkwave
    // the *.vcd filename should match the *.v filename for Makefile cleanliness
    $dumpfile("test_array_mult.vcd");
    $dumpvars(0,test_array_mult);

    for (int a=0;a<2**W;a=a+1) begin
      for (int b=0;b<2**W;b=b+1) begin
        A = a; B = b;
        #DLY
        $display("%d x %d = %d",A,B,P);
      end
    end
    
  end
endmodule
