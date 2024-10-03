module binary2gray#(parameter WIDTH = 4)
	(	
		input [WIDTH-1:0] binary,
		output [WIDTH-1:0] gray
		);


	assign gray[WIDTH-1] = binary[WIDTH-1];

	genvar i;
	generate
		for(i = 0; i < WIDTH-1; i = i+1)begin
			assign gray[i] = binary[i] ^ binary[i+1];
		end
	endgenerate

endmodule