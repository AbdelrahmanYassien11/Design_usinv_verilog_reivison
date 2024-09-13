module sequence_detector(
	input input1, clk, rst_n,
	output reg out_flag, error_flag
	);

	localparam FIRST = 3'b001, SECOND = 3'b010, THIRD = 3'b011, FOURTH = 3'b100, ERROR = 3'b000, CORRECT = 3'b111;
	reg [2:0] state, next_state;
	reg error, out;

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			out_flag <= 0;
			error_flag <=0;
			state <= FIRST;
		end
		else begin
			out_flag <= out;
			error_flag <= error;

			state <= next_state;
		end
	end


	always@(*)begin
		case(state)
			// IDLE: begin
			// 	state <= FIRST;
			// end

			FIRST: begin
				if(input1 == 1'b1) begin
					next_state <= SECOND;
				end
				else begin
					next_state <= FIRST;
				end
			end

			SECOND: begin
				if(input1 == 1'b1) begin
					$display("AAAAAAAAAA");
					next_state <= THIRD;
				end
				else begin
					next_state <= ERROR;
				end
			end

			THIRD: begin
				if(input1 == 1'b0) begin
					next_state <= FOURTH;
				end
				else begin
					next_state <= ERROR;
				end				
			end

			FOURTH: begin
				if(input1 == 1'b0) begin
					next_state <= CORRECT;
				end
				else begin
					next_state <= ERROR;
				end				
			end

			ERROR: begin
				next_state <= FIRST;
			end
		endcase
	end

	always@(state) begin
		case(state)
			FIRST, SECOND, THIRD, FOURTH: begin
				out <= 0;
				error <= 0;
			end
			CORRECT: begin
				out <= 1;
				error <= 0;
			end
			ERROR: begin
				out <= 0;
				error <= 1;
			end
		endcase
	end
endmodule