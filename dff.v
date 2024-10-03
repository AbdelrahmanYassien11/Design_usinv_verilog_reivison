module dff#(parameter WIDTH = 2)
	(
		input resetn, clk,
		input [WIDTH-1:0] D,
		output reg [WIDTH-1:0] Q
		);

	always@(posedge clk or negedge resetn) begin
		if(!resetn)begin
			Q <= 0;
		end
		else begin
			Q <= D;
		end
	end
endmodule