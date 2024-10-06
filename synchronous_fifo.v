module synchronous_fifo#(parameter FIFO_WIDTH = 16, NO_OF_ELEMENTS = 16, FIFO_DEPTH = $clog2(NO_OF_ELEMENTS-1))
(	input clk, resetn, w_en, r_en

	input [FIFO_WIDTH-1:0] d_in,

	output [FIFO_WIDTH-1:0] d_out

	);
	
	reg [FIFO_WIDTH-1:0] d_out_reg;
	reg [FIFO_WIDTH-1:0] mem [FIFO_DEPTH-1:0];
	reg [FIFO_DEPTH:0] w_ptr, r_ptr;

	wire full, empty;

	assign full = ((w_ptr[FIFO_DEPTH] == !r_ptr[FIFO_DEPTH]) & (w_ptr[FIFO_DEPTH-1:0] == r_ptr[FIFO_DEPTH-1:0]))//10000

	assign empty = (w_ptr == r_ptr);


	always@(posedge clk or negedge resetn) begin
		if(~resetn)begin
			w_ptr <= 0;
		end
		else if(w_en && !full) begin
			mem[w_ptr] <= d_in;
			if(w_ptr < NO_OF_ELEMENTS-1) begin
				w_ptr <= w_ptr+1;
			end
			else begin
				w_ptr <= 0;
			end
		end
	end


	always@(posedge clk or negedge resetn) begin
		if(~resetn)begin
			r_ptr <= 0;
		end
		else if(r_en && !empty) begin
			d_out_reg <= mem[r_ptr];
			if(r_ptr < NO_OF_ELEMENTS-1) begin
				r_ptr <= r_ptr+1;
			end
			else begin
				r_ptr <= 0;
			end
		end
	end

	assign d_out = d_out_reg; 

endmodule

