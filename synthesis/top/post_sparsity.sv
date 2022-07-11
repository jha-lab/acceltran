module post_sparsity
(
	clk,
	reset,
	i_im,
	i_mask,
	input_ready,
	output_taken,
	o_im,
	o_mask,
	state
);

parameter IL = 4, FL = 16;
parameter length = 32;
parameter p_length = $clog2(length);

input clk, reset;
input signed [IL+FL-1:0] i_im [15:0];
input [length-1:0] i_mask;
input input_ready;
input output_taken;

output logic signed [IL+FL-1:0] o_im [15:0];
output logic [length-1:0] o_mask;
output logic [1:0] state;

logic done;
logic [1:0] mask_state;
logic [1:0] output_state;

always_ff @(posedge clk) begin
	if (reset == 1) begin
		state <= 2'b00;
	end
	else begin
		if (state == 2'b00 && input_ready == 1) begin
			state <= 2'b01;
		end
		if (state == 2'b01 && done == 1) begin
			state <= 2'b10;
		end
		if (state == 2'b10 && output_taken == 1) begin
			state <= 2'b00;
		end
	end
end

update_mask #(.IL(IL), .FL(FL), .length(length), .p_length(p_length))	update_mask_0
(
	.clk		(clk),
	.reset		(reset),
        .i_mask		(i_mask),
        .out		(i_im),
        .input_ready	(input_ready),
        .output_taken	(output_taken),
        .o_mask		(o_mask),
        .state		(mask_state)
);

update_output #(.IL(IL), .FL(FL))	update_output_0
(
	.clk		(clk),
        .reset		(reset),
        .i_im		(i_im),
        .input_ready	(input_ready),
        .output_taken	(output_taken),
        .o_im		(o_im),
        .state		(output_state)
);

always_comb begin
	if (mask_state == 2'b10 && output_state == 2'b10) begin
		done = 1;
	end
	else begin
		done = 0;
	end
end

endmodule
