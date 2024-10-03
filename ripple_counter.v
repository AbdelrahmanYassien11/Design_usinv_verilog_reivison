`ifdef structural
module ripple_counter#()
	(
		input clk, resetn,
		output reg [WIDTH-1:0] Q, Q_not
		);


generate
	genvar i;
	for(i = 0; i < WIDTH-1; i = i+1) begin
		dff dff1(
			.clk(clk),
			.resetn(resetn),
			.D(Q_not),
			.Q(Q)
			);
		end
	end
endgenerate
