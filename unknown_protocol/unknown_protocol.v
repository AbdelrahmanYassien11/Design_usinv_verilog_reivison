module unknown_protocol#(parameter COUNT_FOR_VALID = 2, SEQUENCE_WIDTH = 3)
	(
		input resetn, clk, enable,
		input [SEQUENCE_WIDTH-1:0] sequence,
		output valid_flag
		);

	reg [1:0] shifter;
	always@(posedge clk or negedge resetn) begin
		if(~resetn) begin
			valid_reg <=0;
			shifter <= 0;
		end
		else if(enable) begin
			if(sequence = 3'b101) begin
				shifter <= {shifter[COUNT_FOR_VALID-2:0],1'b1};
			end
			else begin
				shifter <= 0;
			end
		end
	end

	assign valid_flag = (shifter == 'b11);
endmodule