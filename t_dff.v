module t_dff#(parameter WIDTH = 1)
	(
		input clk, resetn,
		output reg [WIDTH-1:0] Q, Q_not
		);

	always@(posedge clk or negedge resetn) begin
		if(!resetn)begin
			Q <= 0;
			Q_not <= 1;
		end
		else begin
			Q <= Q_not;
			Q_not <= ~Q;
		end
	end
endmodule