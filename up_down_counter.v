module up_down_counter #(parameter WIDTH = 8)

	(
		input reset, clk, enable_button, up_down,
		input 		[WIDTH-1:0] init_value,
		output reg  [WIDTH-1:0] count
		
	);


	always@(posedge clk or posedge reset) begin
		if(reset) begin
			count <= init_value;
		end
		else begin
			if(enable_button) begin 
				if(up_down) begin
					count <= count + 1;
				end
				else begin
					count <= count -1;
				end
			end
		end
	end
endmodule
