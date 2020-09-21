// Testbench for Full Adder
`timescale 1ns / 1ps

module test_FA;
  // Regs and wires for input/output
  reg A,B,Ci;
  wire S,Co;

  //Instantiate your "Device Under Test"
  full_adder DUT(A,B,Ci,S,Co);

  initial begin
    // Hooks for vvp/gtkwave
    // the *.vcd filename should match the *.v filename for Makefile cleanliness
    $dumpfile("test_fa.vcd"); 
    $dumpvars(0,test_FA);

    // Fancy Formatting
    $display("A B Ci | S Co");
    $display("-------------");

    // Make things easy for ourselves with for 
    // and wire bundle assignments
    for (int i=0; i < 8; i=i+1) begin
      {A,B,Ci} = i; // The order here doesn't matter
      #50           // Wait a bit for things to settle

      // Let's do some self checking, shall we?
      // This time the wire bundle order DOES matter
      if (A+B+Ci != {Co,S}) 
        $display("%b %b %b  | %b  %b FAIL",A,B,Ci,S,Co);
      else
        $display("%b %b %b  | %b  %b PASS",A,B,Ci,S,Co);
    end
  end
endmodule
