module fifo_wrapper

	import fifo_pkg::*;
	(
		input bit wr_clk,
		input bit rd_clk,
		input bit wr_rst,
		input bit rd_rst
	);

	fifo_if itf();
	fifo_top dut(
		.wr_clk(wr_clk),
		.rd_clk(rd_clk),
		.wr_rst(wr_rst),
		.rd_rst(rd_rst),
		.itf(itf)
	);

endmodule
