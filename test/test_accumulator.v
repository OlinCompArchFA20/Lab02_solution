// Testbench for carry save adder
`timescale 1ns / 1ps

module test_accumulator;

  // Regs and wires for input/output
  reg  signed [W-1:0] A;
  wire signed [W-1:0] S;
  wire Co;
  reg  clk;
  reg  _rst;

  // Define the width of the Carry Save Adder
  parameter W = 4+1;
  // Delay should scale as a function of W
  // to account for worst-case carry length
  parameter CLK = 100;
  // It's already defined in ripple_carry_adder
  // but let's go ahead and override it here for fun.
  defparam DUT.W=W;

  //Instantiate your "Device Under Test"
  carry_save_accumulator DUT(clk,_rst,A,1'b0,S,Co);

  initial begin
    // Hooks for vvp/gtkwave
    // the *.vcd filename should match the *.v filename for Makefile cleanliness
    $dumpfile("test_accumulator.vcd");
    $dumpvars(0,test_accumulator);
    
    clk  = 1'b0;
    _rst = 1'b0;
    A = 1;
    // Wait for reset nodes to settle
    #40 _rst = 1'b1; 

    $display("Accumulating %d...",A);
    for (int i = 0; i < 2**(W-1)-1; i = i+1) begin
      #(2*CLK) $display("%d",S);
    end

    A = -1;
    $display("Accumulating %d...",A);
    for (int i = 0; i < 2**(W-1)-1; i = i+1) begin
      #(2*CLK) $display("%d",S);
    end

    A = 2;
    $display("Accumulating %d...",A);
    for (int i = 0; i < 2**(W-2)-1; i = i+1) begin
      #(2*CLK) $display("%d",S);
    end

    A = -1;
    $display("Accumulating %d...",A);
    for (int i = 0; i < 2**(W-1)-2; i = i+1) begin
      #(2*CLK) $display("%d",S);
    end

    $finish;
    // Since we're only printing failures...
  end
  
  // Toggle clock
  always #CLK clk = ~clk;


endmodule
