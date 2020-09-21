// Test D flip flop
`timescale 1ns / 1ps

module test_dff;
  reg          clk;
  reg          _rst;
  reg [W-1:0]  D;
  wire [W-1:0] Q;

  parameter W = 1;
  defparam dut.W = 1;

  DFF dut(clk,_rst,D,Q);

  initial begin
    // Hooks for vvp/gtkwave
    // the *.vcd filename should match the *.v filename for Makefile cleanliness
    $dumpfile("test_dff.vcd");
    $dumpvars(0,test_dff);

    D    = 0;
    clk  = 1'b0;
    _rst = 1'b0;

    // Wait for reset nodes to settle
    #20; _rst = 1'b1; 

    for (int i = 0; i < 100; i = i + 1) begin
      // Flip D just for testing
      #33 D = ~D; 
    end
    $finish;
  end

  // Toggle clock
  always #10 clk = ~clk;
endmodule
