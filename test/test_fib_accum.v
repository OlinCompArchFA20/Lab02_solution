// Testbench for carry save adder
`timescale 1ns / 1ps

module test_fib_accum;

  // Regs and wires for input/output
  reg  [W-1:0] A;
  wire [W-1:0] S;
  wire         Co;
  reg          clk;
  reg          _rst;

  // Define the width of the Fibonnaci number storage register
  parameter W = 16;
  // Delay should scale as a function of W
  // to account for worst-case carry length
  parameter CLK = 100;
  // It's already defined in ripple_carry_adder
  // but let's go ahead and override it here for fun.
  defparam DUT.W=W;

  //Instantiate your "Device Under Test"
  fibonacci_accumulator DUT(clk,_rst,S);

  initial begin
    // Hooks for vvp/gtkwave
    // the *.vcd filename should match the *.v filename for Makefile cleanliness
    $dumpfile("test_fib_accum.vcd");
    $dumpvars(0,test_fib_accum);
    
    clk  = 1'b0;
    _rst = 1'b0;

    // Wait for reset nodes to settle
    #40 _rst = 1'b1; 
    // Output the first 24 numbers
    for (int i = 0; i < 24; i = i+1) begin
      #(2*CLK) $display("%d",S);
    end
    $finish;
  end
  
  // Toggle clock
  always #CLK clk = ~clk;


endmodule
