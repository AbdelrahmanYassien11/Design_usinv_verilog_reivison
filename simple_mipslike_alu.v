module alu(
	input signed [31:0] A, B,
	input opcode [4:0],
	output signed ALU_out
	);

	localparam ADD = 4'b0001, SUB = 4'b0010, MUL = 4'b0011, DIV = 4'b0100, SLL = 4'b0101,
			   SLT = 4'b0110, SLTU = 4'b0111, AND = 4'b1000, OR = 4'b1001, SRL = 4'b1010,
			   SRA = 4'b1011, XOR = 4'b1100;
	
	wire exception, zeros_flag;

	always@(*)begin
		case(opcode)
			NOOP:

			ADD: begin
				if(A + B <= (2**31)-1 ) begin 
					ALU_out <= A+B;
				end 
				else begin
					exception = 1;
				end

			SUB: begin
				if(A-B <= (-(2**31)+1)) begin
					ALU_out <= A-B;
				end
				else begin
					exception = 1;
				end
			end

			MUL: begin
				if(A*B <= (2**31)-1) begin
					ALU_out <= A*B;
				end
				else begin
					exception <= 1;
				end
			end

			DIV: begin
					ALU_out <= A/B;
			end

			SLL: ALU_out <= (A << B);

			SLT: ALU_out <= (A <= B);

			SLTU: ALU_out <= (A[30:0] <= B[30:0]);

			AND: ALU_out <= (A & B);

			OR: ALU_out <= (A | B);

			SRL: ALU_out <= (A >> B);

			SRA: ALU_out <= {A[31], (A>>B)};

			XOR: ALU_out <= (A^B);

			default: ALU_out <= 0;
		endcase
	end


	assign zeros_flag = ~(|ALU_out);

endmodule