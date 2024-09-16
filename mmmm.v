module Q2 (
    input wire clk,         // Clock input
    input wire rst_n,       // Active-low asynchronous reset
    input wire in_flag,     // Input flag
    output reg out_flag     // Output flag
);

    // State variables
    reg in_flag_d;          // Delayed in_flag for edge detection

    // Sequential logic for flag generation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Asynchronous reset: clear output flag and delayed in_flag
            out_flag <= 1'b0;
            in_flag_d <= 1'b1;
        end else begin
            // Capture the current state of in_flag
            in_flag_d <= in_flag;

            // Detect falling edge of in_flag
            if (in_flag_d && !in_flag) begin
                out_flag <= 1'b1; // Assert out_flag immediately on falling edge
            end else if (in_flag_d == 1'b0 && in_flag == 1'b0) begin
                out_flag <= 1'b0; // Clear out_flag in the next cycle after the falling edge
            end
        end
    end

endmodule