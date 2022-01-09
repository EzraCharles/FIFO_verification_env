module tb_fifo ();
	`include "tester_fifo.svh";


	import fifo_pkg::*;

	bit wr_clk 		= 1'b0;
	bit rd_clk 		= 1'b0;

	bit wr_rst 		= 1'b1;
	bit rd_rst 		= 1'b1;

	tester_fifo fifo;

	fifo_if itf();

	fifo_top DUT (
		.wr_clk (wr_clk),
		.wr_rst (wr_rst),
		.rd_clk (rd_clk),
		.rd_rst (rd_rst),
		.itf	(itf.fifo)
	);
		
	initial begin
		fork
			forever #1 wr_clk = ~wr_clk;
			forever #1 rd_clk = ~rd_clk;
		join
	end
		
	initial begin	
		fifo = new(itf);

		#1 wr_rst = 1'b1;
		#2 rd_rst = 1'b1;	
		#1 wr_rst = 1'b0;
		#2 rd_rst = 1'b0;	
		#1 wr_rst = 1'b1;	
		#2 rd_rst = 1'b1;

		repeat (20)	@(posedge wr_clk) t.push_generate();
		repeat (20)	@(posedge rd_clk) t.pop_generate();

	end

endmodule
