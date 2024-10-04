module clock_divider#(parameter DIV = 2)
	(	
		input clk, resetn,
		output reg clk_div
		);

	integer counter;

	always@(clk or negedge resetn) begin
		if(!resetn)begin
			counter <= 0;
			clk_div <= 0;
		end
		else begin
			if(counter == DIV-1) begin
				clk_div <= ~clk_div;
				counter <= 0;
			end
			else begin
				counter <= counter + 1;
			end
		end
	end

endmodule