NETLIST ?= ./DFFRAM256x16/DFFRAM256x16.nl.v
PRIM ?= ~/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v
CELL ?= ~/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v

gate: tb.v
	iverilog -o gate -D FUNCTIONAL -D UNIT_DELAY=#1 ${PRIM} ${CELL} ${NETLIST} tb.v

test.vcd: gate
	./gate

view: test.vcd
	gtkwave test.vcd

clean:
	rm ./gate ./test.vcd
