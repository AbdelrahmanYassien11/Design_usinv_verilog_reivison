module lights #(parameter ON = 1, OFF = 0)
	(
	input clk, rst_n, enable,
	output green, yellow, red
	);

	localparam IDLE = 2'b00, GREEN = 2'b01, YELLOW = 2'b10, RED = 2'b11; 

	integer counter;

	reg [1:0] state, next_state, past_state;
	reg yellow_reg, green_reg, red_reg;

	always@(posedge clk or negedge rst_n)begin//synchronous
	
		if(!rst_n) begin
			state <= IDLE;
		end
		else begin
			//state <= next_state;
			counter <= counter +1;
		end

	end

	always@(*)begin //next_state_logic
		case(state)
			IDLE: begin
				if(enable) begin
					// next_state <= GREEN;
					state <= GREEN;
					past_state <= state;
					counter <= 0;
				end
				else begin
					state <= IDLE;
				end
			end

			GREEN: begin 
				if(enable && counter == 70) begin
					$display("NEXT_STATE IS YELLOW");
					state <= YELLOW;
					past_state <= state;
					counter <= 0;
				end
				else begin
					$display("mistake");
					state <= GREEN;
				end
			end

			YELLOW: begin
				if(enable && counter == 5 && past_state == GREEN) begin
					state <= RED;
					past_state <= state;
					counter <= 0;
				end
				else if(enable && counter == 5 && past_state == RED) begin
					state <= GREEN;
					past_state <= state;
					counter <= 0;
				end
				else begin
					state <= YELLOW;
				end
			end

			RED: begin
				if(enable && counter == 75) begin
					state <= YELLOW;
					past_state <= state;
					counter <= 0;
				end
				else begin
					state <= RED;
				end
			end
		endcase
	end



	always@(*)begin //output
		case(state)
			GREEN: begin
				green_reg <= 1;
				yellow_reg <= 0;
				red_reg <= 0;
			end

			YELLOW: begin
				green_reg <= 0;
				yellow_reg <= 1;
				red_reg <= 0;
			end

			RED: begin
				green_reg <= 0;
				yellow_reg <= 0;
				red_reg <= 1;
			end

			default: begin
			end
		endcase
	end

	assign green = green_reg;
	assign yellow = yellow_reg;
	assign red = red_reg;


endmodule