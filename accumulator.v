// Carry Save Accumulator
`timescale 1ns / 1ps

module carry_save_accumulator
  (input          clk, //Clock
   input          _rst,//Asynchronous Active Low Reset
   input  [W-1:0] A,   //Input operand
   input          Ci,  //Carry in to allow for subtraction
   output [W-1:0] S,   //Sum Out
   output         Co); //Carry out

  parameter W = 4; //Operand Width

  wire [W-1:0] csa_sum;
  wire [W-1:0] dff_sum;
  wire [W-1:0] csa_co;
  wire [W-1:0] dff_co;
  wire [W-1:0]   sum;
  wire         co;

  defparam    CSA.W = W;
  defparam    RCA.W = W;
  defparam DFF_CO.W = W;
  defparam  DFF_S.W = W;

  carry_save_adder CSA(A,dff_sum,{dff_co[W-2:0],1'b0},csa_sum,csa_co);
  DFF DFF_S(clk,_rst,csa_sum,dff_sum);
  DFF DFF_CO(clk,_rst,csa_co,dff_co);

    
  ripple_carry_adder RCA(dff_co,{1'b0,dff_sum[W-1:1]},1'b0,sum,co);
  assign S[0] = dff_sum[0];
  assign S[W-1:1] = sum[W-2:0];
  assign Co = sum[W-1];

endmodule

