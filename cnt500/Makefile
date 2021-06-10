cnt500.vcd: cnt500.out
	vvp $<

cnt10.vcd: cnt10.out
	vvp $<

phase.vcd: phase.out
	vvp $<

cnt500.out: cnt500_tb.v cnt500.v phase.v cnt10.v
	iverilog -g 2012 -o $@ $^

cnt10.out: cnt10_tb.v cnt10.v
	iverilog -g 2012 -o $@ $^

phase.out: phase_tb.v phase.v
	iverilog -g 2012 -o $@ $^

clean:
	rm -rf *.qpf output_files db incremental_db simulation *.vcd *.out
