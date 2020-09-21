################################################################################
# Tools
################################################################################

# -Wall turns on all warnings
# -g2012 selects the 2012 version of iVerilog
IVERILOG=iverilog -Wall -g2012
VVP=vvp

# Look up .PHONY rules for Makefiles
.PHONY: clean

# This calls iVerilog on a particular *.v file to generate a *.bin file
# Look up Makefile special variables to find out what all the details are
%.bin: test/%.v *.v 
	${IVERILOG} -o $@ $^

# This calls VVP on the *.bin file you generated to make a *.vcd file
# for GTKWave
%.vcd: %.bin
	${VVP} $^

# Call this to clean up all your generated files
clean:
	rm -f *.bin *.vcd
