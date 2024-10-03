module clock_divider#(parameter DIV = 2)
	(	
		input clk,
		output reg clk_div
		);

	integer counter;

	always@(clk or negedge resetn) begin
		if(!resetn)begin
			counter <= 0;
			clk_div <= clk;
		end
		else begin
			if(counter == DIV) begin
				clk_div = ~clk_div;
			end
			counter <= counter + 1;
		end
	end

endmodule