// Fibonacci Generator
`timescale 1ns / 1ps

module fibonacci_accumulator
  (input          clk, //Clock
   input          _rst,//Asynchronous Active Low Reset
   output [W-1:0] S);  //Sum Out

  parameter W = 4; //Operand Width

  wire [W-1:0] sum   [3:0];
  wire [W-1:0] carry [3:0];

  wire [W-1:0] rsum;
  wire         rco;

  defparam csa1.W = W;
  defparam csa0.W = W;
  defparam dff1_sum.W = W;
  defparam dff1_carry.W = W;
  defparam dff0_sum.W = W;
  defparam dff0_carry.W = W;
  defparam rca.W = W;

  // Initialize the first two fibbonacci numbers
  defparam dff0_sum.INITVAL = 0;
  defparam dff1_sum.INITVAL = 1;

  // Add the numbers, it takes two cascaded CSA adders
  // because we have to add two sums, two carrys, and a CSA
  // only accepts 3 inputs. We could use a 4-2 compressor in ripple mode,
  // but we don't want to ripple till the end.
  //
  // We _could_ use the ripple at the end to get rid of one of these, but
  // the point is to show how to do this.
  carry_save_adder csa1({carry[0][W-2:0],1'b0},{carry[1][W-2:0],1'b0},sum[0],sum[3],carry[3]);
  carry_save_adder csa0({carry[3][W-2:0],1'b0},sum[3],sum[1],sum[2],carry[2]);

  DFF dff1_sum(clk,_rst,sum[2],sum[1]);
  DFF dff1_carry(clk,_rst,carry[2],carry[1]);
  DFF dff0_sum(clk,_rst,sum[1],sum[0]);
  DFF dff0_carry(clk,_rst,carry[1],carry[0]);

  // Add the carry and sum to get rid of the carry save representation    
  ripple_carry_adder rca(carry[0],{1'b0,sum[0][W-1:1]},1'b0,rsum,rco);
  assign S[0] = sum[0][0];
  assign S[W-1:1] = rsum[W-2:0];
endmodule

