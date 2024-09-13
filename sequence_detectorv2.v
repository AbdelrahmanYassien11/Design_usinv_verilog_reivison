module sequence_detectorv2(
	input input1, clk, rst_n,
	output reg out_flag, error_flag
	);

	localparam S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, ERROR = 3'b100, CORRECT = 3'b111;
	reg [2:0] state, next_state;
	reg error, out;

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			out_flag <= 0;
			error_flag <=0;
			state <= S0;
		end
		else begin
			out_flag <= out;
			error_flag <= error;
			case(state) 
				S0: begin
					if(input1 == 1'b1) begin
						state <= S1;
					end
					else begin
						state <= S0;
					end
				end
				S1: begin
					if(input1 == 1'b1) begin
						$display("AAAAAAAAAA");
						state <= S2;
					end
					else begin
						state <= ERROR;
					end
				end

				S2: begin
					if(input1 == 1'b0) begin
						state <= S3;
					end
					else begin
						state <= ERROR;
					end				
				end

				S3: begin
					if(input1 == 1'b0) begin
						state <= CORRECT;
					end
					else begin
						state <= ERROR;
					end				
				end

				ERROR: begin
					state <= S0;
				end
			endcase
		end
	end


	// always@(*)begin
	// 	case(state)
	// 		// IDLE: begin
	// 		// 	state <= S0;
	// 		// end

	// 		S0: begin
	// 			if(input1 == 1'b1) begin
	// 				next_state <= S1;
	// 			end
	// 			else begin
	// 				next_state <= S0;
	// 			end
	// 		end

	// 		S1: begin
	// 			if(input1 == 1'b1) begin
	// 				$display("AAAAAAAAAA");
	// 				next_state <= S2;
	// 			end
	// 			else begin
	// 				next_state <= ERROR;
	// 			end
	// 		end

	// 		S2: begin
	// 			if(input1 == 1'b0) begin
	// 				next_state <= S3;
	// 			end
	// 			else begin
	// 				next_state <= ERROR;
	// 			end				
	// 		end

	// 		S3: begin
	// 			if(input1 == 1'b0) begin
	// 				next_state <= CORRECT;
	// 			end
	// 			else begin
	// 				next_state <= ERROR;
	// 			end				
	// 		end

	// 		ERROR: begin
	// 			next_state <= S0;
	// 		end
	// 	endcase
	// end

	always@(state) begin
		case(state)
			S0, S1, S2, S3: begin
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