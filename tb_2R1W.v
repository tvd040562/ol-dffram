`timescale 1ns/100ps
`define PERIOD 20
module tb;
	reg clk;
	wire clk_delay;
	reg [7:0] addr0, addr1;
	reg [15:0] din;
	wire [15:0] dout0, dout1;
	reg [15:0] rd_data_out0, rd_data_out1;
	reg we;
	reg rd_val0, rd_val1;
	reg sel0, sel1;

	always @(posedge clk) begin
		if (rd_val0)
			rd_data_out0 = dout0;
		if (rd_val1)
			rd_data_out1 = dout1;
	end

	initial begin
		clk = 0;
		forever
			#(`PERIOD/2) clk = ~clk;
	end

	assign #1 clk_delay = clk;

	DFFRAM256x16_2R1W DUT (
			.CLK(clk),
			.EN0(sel0),
			.EN1(sel1),
			.A0(addr0),
			.A1(addr1),
			.Di0(din),
			.Do0(dout0),
			.Do1(dout1),
			.WE0({we,we})
		);

	integer i;

	initial begin
		$dumpfile("test.vcd");
		$dumpvars(0, tb);
		addr0 = 0;
		din = 0;
		we = 0;
		sel0 = 0;
		sel1 = 0;
		rd_val0 = 0;
		rd_val1 = 0;

		@(posedge clk_delay);
		@(posedge clk_delay);
		// Write 256 incremental value to 256 RAM locations
		for (i=0; i<256; i=i+1) begin
			sel0 = 1;
			we = 1;
			addr0 = i;
			din = i;
			@(posedge clk_delay);
		end

		we = 0;
		@(posedge clk_delay);
		@(posedge clk_delay);
		// Read from 256 locations
		for (i=0; i<256; i=i+1) begin
			sel0 = 1;
			we = 0;
			addr0 = i;
			@(posedge clk_delay);
			rd_val0 = 1;
			@(posedge clk_delay);
			rd_val0 = 0;
		end

		sel0 = 0;
		@(posedge clk_delay);
		@(posedge clk_delay);
		// Read from 256 locations
		for (i=0; i<256; i=i+1) begin
			sel1 = 1;
			we = 0;
			addr1 = 255-i;
			@(posedge clk_delay);
			rd_val1 = 1;
			@(posedge clk_delay);
			rd_val1 = 0;
		end
		$finish();
	end
endmodule
