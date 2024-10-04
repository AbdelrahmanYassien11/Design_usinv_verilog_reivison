`define structural 1
`ifdef structural
module ripple_counter#(parameter COUNTER_WIDTH = 4)
	(
		input clk, resetn,
		output [COUNTER_WIDTH-1:0] Q
		);


	wire [COUNTER_WIDTH-1:0] Q_not_clk;
	wire Q_not_clk0, Q_not_clk1, Q_not_clk2, Q_not_clk3;


	t_dff t_dff0(
		.clk(clk),
		.resetn(resetn),
		.Q(Q[0]),
		.Q_not(Q_not_clk0)
		);

	generate
		genvar i;
		for(i = 1; i < COUNTER_WIDTH; i = i+1) begin
			t_dff t_dff1(
				.clk(Q_not_clk[i-1]),
				.resetn(resetn),
				.Q(Q[i]),
				.Q_not(Q_not_clk[i])
				);
		end
	endgenerate

`else

module ripple_counter#(parameter COUNTER_WIDTH = 4)
	(
		input clk, resetn,
		output [COUNTER_WIDTH-1:0] Q
		);	

	always@(posedge clk or negedge resetn) begin
		if(~resetn) begin
			Q <= 0;
		end
		else begin
			Q <= Q + 1;
		end
	end
	initial begin
		$display("AAAAAAA");
	end

`endif
endmodule 

