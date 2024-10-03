module gray2binary#(parameter WIDTH = 4)
	(
		input [WIDTH-1:0] gray,
		output [WIDTH-1:0] binary
		);


	assign binary[WIDTH-1] = gray[WIDTH-1];

	genvar i;
	generate
		for(i = 0; i<WIDTH-1; i = i+1)begin
			assign binary[i] = gray[i] ^ binary[i+1];
		end
	endgenerate

endmodule