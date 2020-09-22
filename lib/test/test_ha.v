// Testbench for Half Adder
module test_HA;
  // Regs and wires for input/output
  reg A,B;
  wire S,Co;

  //Instantiate your "Device Under Test"
  half_adder DUT(A,B,S,Co);

  initial begin
    // Hooks for vvp/gtkwave
    $dumpfile("test_ha.vcd");
    $dumpvars(0,test_HA);

    // Fancy Formatting
    $display("A B | S Co");
    $display("-------------");

    // Make things easy for ourselves with for loops
    // and wire bundle assignments
    for (int i=0; i < 4; i=i+1) begin
      {A,B} = i; // The order here doesn't matter
      #50           // Wait a bit for things to settle

      // Let's do some self checking, shall we?
      // This time the wire bundle order DOES matter
      if (A+B != {Co,S}) 
        $display("%b %b | %b  %b FAIL",A,B,S,Co);
      else
        $display("%b %b | %b  %b PASS",A,B,S,Co);
    end
  end
endmodule
