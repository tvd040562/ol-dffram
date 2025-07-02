`timescale 1ns/100ps
`define PERIOD 20
module tb;
	reg clk;
	wire clk_delay;
	reg [7:0] addr;
	reg [15:0] din;
	wire [15:0] dout;
	reg [15:0] rd_data_out;
	reg we;
	reg rd_val;

	always @(posedge clk)
		if (rd_val)
			rd_data_out = dout;

	initial begin
		clk = 0;
		forever
			#(`PERIOD/2) clk = ~clk;
	end

	assign #1 clk_delay = clk;

	DFFRAM256x16 DUT (
			.CLK(clk),
			.EN0(1'b1),
			.A0(addr),
			.Di0(din),
			.Do0(dout),
			.WE0({we,we})
		);

	integer i;

	initial begin
		$dumpfile("test.vcd");
		$dumpvars(0, tb);
		addr = 0;
		din = 0;
		we = 0;
		rd_val = 0;

		@(posedge clk_delay);
		@(posedge clk_delay);
		// Write 256 incremental value to 256 RAM locations
		for (i=0; i<256; i=i+1) begin
			we = 1;
			addr = i;
			din = i;
			@(posedge clk_delay);
		end

		we = 0;
		@(posedge clk_delay);
		@(posedge clk_delay);
		// Read from 256 locations
		for (i=0; i<256; i=i+1) begin
			we = 0;
			addr = i;
			@(posedge clk_delay);
			rd_val = 1;
			@(posedge clk_delay);
			rd_val = 0;
		end
		$finish();
	end
endmodule
