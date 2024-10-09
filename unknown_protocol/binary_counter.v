module binary_counter#(parameter COUNT_STOP = 72)
	(
		input clk, resetn,
		output count
		);


	reg [COUNT_STOP-1:0] count_reg;
	
	always@(posedge clk or negedge resetn) begin
		if(!resetn) begin
			count_reg <= 0;
		end
		else begin
			if(count_reg == COUNT_STOP-1) begin
				count_reg <= 0;
			end
			else begin
				count_reg <= count_reg+1;
			end
		end
	end

	assign count = (count_reg == COUNT_STOP-1);



endmodule : binary_counter