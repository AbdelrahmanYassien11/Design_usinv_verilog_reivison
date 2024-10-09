module top#(parameter SEQUENCE_WIDTH = 3)
	(
		input clk, resetn,
		input [SEQUENCE_WIDTH-1:0] sequence,
		output valid
		);


	wire enable_i;

	binary_counter bc1(
		.clk(clk),
		.resetn(resetn),
		.count(enable_i)
		);

	unknown_protocl up1(
		.clk(clk),
		.resetn(resetn),
		.enable(enable_i),
		.sequence(sequence),
		.valid_flag(valid)
		);

endmodule
