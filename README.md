# Lab 2: Verilog Accumulator

Please submit your answers to the following problems by commiting and pushing
your code and testbench to github.

The key concepts we're covering in this lab are how to glue together modules in
verilog and how to debug your modules. We're also going to be covering examples
of twos complement numbers, accumulators, and flip flops.

Don't forget about verilator as a lint tool. Icarus Verilog has notoriously bad feedback.

	verilator_bin --lint-only your_file_01.v your_file_02.v

Verilator is far more paranoid than Icarus Varilog, but gives much better feedback.

## Part 1 - Accumulator

### What

Using a carry save adder, implement an accumulator which computes the following
function:

    A = A + B

Your accumulator should be able to handle negative numbers, so your testbench
should show it counting up and down as you ``B = 1`` or ``B = -1``, for example.
You may make use of the "signed" keyword when declaring ports and wires to let
Icarus Verilog know that your number is signed. You may assume a 5-bit signed
representation for your adder, but ideally it would parameterized.

You may make use of the full, half, and ripple carry adders you built in Lab 01,
or you may use the provided ones in the lib/ directory. There's also a DFF
available in ``lib/dff.v`` which has an asynchronous reset (i.e. not aligned to
a clock). This will just allow you to set a default value by overriding the
INITVAL parameter. See the Lab01 solution for how to do this.

You'll be *building a carry save adder* (CSA) in the lib directory, which will
form the basis of the rest of this lab.  Fill in the code stub in ``lib/csa.v``.

Once you've done that, you'll want to edit ``accumulator.v`` and actually
implement your accumulator.

You'll want to draw your CSA and Accumulator in block diagram form--things are
going to be getting complicated and you'll want to be able to reason about in
graphical format. Plus, it's a deliverable!

As before, I've provided a Makefile. If you want to test anything in the lib/
directory, you can do the following:

    cd lib/
    make test_ha.bin
    ./test_ha.bin

If you want to test the thing you're working on, you'll want to be in the root
of the git repo, and you can run the same command:

    make test_accumulator.bin
    ./test_accumulator.bin


This will compile your Verilog. If there are no errors, you can run the
resulting file and look at the output! If you want to have a look at the
waveforms in gtkwave, you can do the following:

    make test_accumulator.vcd
    gtkwave test_accumulator.vcd

Note that for gtkwave to work, you have to have a correctly compiling Verilog
codebase. 

As before, you can use verilator to get some more helpful feedback by running something
like:

    verilator_bin --lint-only my_file.v
  
Note that verilator is way more paranoid than iverilog, so expect a bunch of
scary looking warnings which you can mostly ignore. You'll also have to pass all
the required files, so for the ripple carry adder you'll have to do something
like:

    cd lib/
    verilator_bin --lint-only test/test_ripple.v ripple.v fa.v

### Deliverables

* Carry Save Adder implementation in ``lib/csa.v``
* Carry Save Adder test bench in ``lib/test/test_csa.v``
* Accumulator implementation (with testbench) -- You should show adding and
  subtracting numbers!
* A block diagram of your accumulator with buses labeled. 

### Why

We're jumping straight into getting the carry save adder to work with a DFF.
Remember you'll need to have the system output the final number in a
non-redundant format (carry save outputs in a redundant format).

You can learn more about that on Wikipedia here:

[https://en.wikipedia.org/wiki/Redundant_binary_representation](Redundant Binary
Representation)

## Part 2 - Array Multiplier

### What

Build an array multiplier out of carry save adders. You may assume unsigned
operands here if you like, to make things easier for yourself. Edit the code
stub in ``array_mult.v`` to implement your multiplier. We'll assume W bit inputs
and 2W bit outputs. If you don't want to build a multiplier with parameterized
width, you may hard code W = 4.

You should edit ``test/test_array_mult.v`` to build your testbench.

As a *heavy lift*, extend your array mutiplier to support signed multiplication.
You can either use the sign extension method we learned in class or the
Baugh-Wooley method to save on hardware.

You can also extend your multiplier to support multiply accumulate, i.e.

    Out = A*B + C

### Deliverables

* Array multiplier implementation (with testbench) -- for a 4-bit multiplier,
  just show all possible operands-- 0x0, 0x1 ...,  to 15x15.
* If you do the heavy lift to support negative numbers, show negative operands.
* A block diagram of your multiplier with buses labeled. 

### Why

Array multipliers get pretty complicated quick.  This is an exercise to get you
to think carefully about how you structure your code to make it readable and
easy to connect modules up with. It also is a test of your understanding of the
block diagram -> verilog transformation. In practice, you will probably never
build one of these unless you're heavily optimizing some sort of computation.

## Heavy Lift

### What

Build a Fibonacci number generator by extending your accumulator with a shift
register.

    x(n) = x(n-1) + x(n-2)
    x(0) = 0
    x(1) = 1
    x(2) = 1
    x(3) = 2
    etc

### Why

This is to show you how to build structures with multiple DFF stages.
