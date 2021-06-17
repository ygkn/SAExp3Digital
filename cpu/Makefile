
DEFFILE = defines.h
VFILE = cpu.v alu.v count16rle.v reg16.v regfile.v muxreg16.v sm.v
IMEMFILE = bin.txt

cpu.vcd: cpu.out
	vvp $< 2| grep -v '^VCD warning: array word cpu_tb.dmem.* will conflict with an escaped identifier.'

cpu.out: cpu_tb.v $(DEFFILE) $(VFILE) $(IMEMFILE)
	iverilog -g2012 -D "IMEMFILE=\"$(IMEMFILE)\"" -o $@ cpu_tb.v $(VFILE)

alu.vcd: alu.out
	vvp $<

alu.out: alu_tb.v $(DEFFILE) alu.v
	iverilog -g2012 -o $@ alu_tb.v alu.v

clean:
	rm -rf *.qpf output_files db incremental_db simulation *.vcd *.out
