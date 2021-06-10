all:
	echo 'Welcome to SA JIKKEN 3'

download: output_files/addsubled.sof
	quartus_pgm -c 1 -m JTAG -o "p;$<"

compile:output_files/addsubled.sof

output_files/addsubled.sof: addsubled.qsf addsubled.v addsub4.v bintoled.v
	quartus_cmd addsubled -c addsubled.qsf

bintoled.vcd: bintoled.out
	vvp $<

addsub4.vcd: addsub4.out
	vvp $<

bintoled.out: bintoled_tb.v bintoled.v
	iverilog -g 2012 -o $@ $^

addsub4.out: addsub4_tb.v addsub4.v
	iverilog -g 2012 -o $@ $^

clean:
	rm -rf *.qpf output_files db incremental_db simulation *.vcd *.out
