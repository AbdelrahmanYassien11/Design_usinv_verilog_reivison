`define dff_counter
module clock_divider#(parameter DIV = 6)
	(	
		input clk, resetn,
		output clk_div
		);

`ifdef latch_counter //DIV = 6 will divide by 12 FYI

	integer counter;
	reg clk_div_reg;

	always@(clk or negedge resetn) begin
		if(!resetn)begin
			counter <= 0;
			clk_div_reg <= 0;
		end
		else begin
			if(counter == DIV-1) begin
				clk_div_reg <= ~clk_div_reg;
				counter <= 0;
			end
			else begin
				counter <= counter + 1;
			end
		end
	end
	assign  clk_div = clk_div_reg;

`elsif dff_counter_paramterized

	integer counter;
	reg clk_div_reg;

	always@(posedge clk or negedge resetn) begin
		if(!resetn)begin
			counter <= 0;
			clk_div_reg <= 0;
		end
		else begin
			if(counter < DIV-1) begin
				counter <= counter + 1;
			end
			else begin
				clk_div_reg <= ~clk_div_reg;
				counter <= 0;
			end
		end
	end
	assign  clk_div = clk_div_reg;	

`elsif dff_paramterized
	
	reg [DIV-1:0] clk_div_reg;
	integer i;
	always@(posedge clk or negedge resetn) begin
		if(!resetn)begin
			clk_div_reg <= 0;
		end
		else begin
			clk_div_reg <= {clk_div_reg[DIV-2:0],~clk_div_reg[DIV-1]};// 00 -> 01 -> 10 -> 
		end
	end

	assign clk_div = clk_div_reg[DIV-1];

`endif
endmodule