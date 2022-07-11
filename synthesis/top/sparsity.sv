module sparsity
(
	clk,
	reset,
	i_0,
	i_1,
	i_2,
	i_3,
	i_4,
	i_5,
	i_6,
	i_7,
	i_8,
	i_9,
	i_10,
	i_11,
	i_12,
	i_13,
	i_14,
	i_15,
	w_0,
	w_1,
	w_2,
	w_3,
	w_4,
	w_5,
	w_6,
	w_7,
	w_8,
	w_9,
	w_10,
	w_11,
	w_12,
	w_13,
	w_14,
	w_15,
	i_mask,
	w_mask,
	input_ready,
	output_taken,
	oi_0,
	oi_1,
	oi_2,
	oi_3,
	oi_4,
	oi_5,
	oi_6,
	oi_7,
	oi_8,
	oi_9,
	oi_10,
	oi_11,
	oi_12,
	oi_13,
	oi_14,
	oi_15,
	ow_0,
	ow_1,
	ow_2,
	ow_3,
	ow_4,
	ow_5,
	ow_6,
	ow_7,
	ow_8,
	ow_9,
	ow_10,
	ow_11,
	ow_12,
	ow_13,
	ow_14,
	ow_15,
	o_mask,
	state,
	input_taken
);

parameter IL = 4, FL = 16;
parameter length = 32;
parameter p_length = $clog2(length);

input clk, reset;
input signed [IL+FL-1:0] i_0;
input signed [IL+FL-1:0] i_1;
input signed [IL+FL-1:0] i_2;
input signed [IL+FL-1:0] i_3;
input signed [IL+FL-1:0] i_4;
input signed [IL+FL-1:0] i_5;
input signed [IL+FL-1:0] i_6;
input signed [IL+FL-1:0] i_7;
input signed [IL+FL-1:0] i_8;
input signed [IL+FL-1:0] i_9;
input signed [IL+FL-1:0] i_10;
input signed [IL+FL-1:0] i_11;
input signed [IL+FL-1:0] i_12;
input signed [IL+FL-1:0] i_13;
input signed [IL+FL-1:0] i_14;
input signed [IL+FL-1:0] i_15;
input signed [IL+FL-1:0] w_0;
input signed [IL+FL-1:0] w_1;
input signed [IL+FL-1:0] w_2;
input signed [IL+FL-1:0] w_3;
input signed [IL+FL-1:0] w_4;
input signed [IL+FL-1:0] w_5;
input signed [IL+FL-1:0] w_6;
input signed [IL+FL-1:0] w_7;
input signed [IL+FL-1:0] w_8;
input signed [IL+FL-1:0] w_9;
input signed [IL+FL-1:0] w_10;
input signed [IL+FL-1:0] w_11;
input signed [IL+FL-1:0] w_12;
input signed [IL+FL-1:0] w_13;
input signed [IL+FL-1:0] w_14;
input signed [IL+FL-1:0] w_15;
input [length-1:0] i_mask;
input [length-1:0] w_mask;

input input_ready;
input output_taken;

output logic signed [IL+FL-1:0] oi_0;
output logic signed [IL+FL-1:0] oi_1;
output logic signed [IL+FL-1:0] oi_2;
output logic signed [IL+FL-1:0] oi_3;
output logic signed [IL+FL-1:0] oi_4;
output logic signed [IL+FL-1:0] oi_5;
output logic signed [IL+FL-1:0] oi_6;
output logic signed [IL+FL-1:0] oi_7;
output logic signed [IL+FL-1:0] oi_8;
output logic signed [IL+FL-1:0] oi_9;
output logic signed [IL+FL-1:0] oi_10;
output logic signed [IL+FL-1:0] oi_11;
output logic signed [IL+FL-1:0] oi_12;
output logic signed [IL+FL-1:0] oi_13;
output logic signed [IL+FL-1:0] oi_14;
output logic signed [IL+FL-1:0] oi_15;
output logic signed [IL+FL-1:0] ow_0;
output logic signed [IL+FL-1:0] ow_1;
output logic signed [IL+FL-1:0] ow_2;
output logic signed [IL+FL-1:0] ow_3;
output logic signed [IL+FL-1:0] ow_4;
output logic signed [IL+FL-1:0] ow_5;
output logic signed [IL+FL-1:0] ow_6;
output logic signed [IL+FL-1:0] ow_7;
output logic signed [IL+FL-1:0] ow_8;
output logic signed [IL+FL-1:0] ow_9;
output logic signed [IL+FL-1:0] ow_10;
output logic signed [IL+FL-1:0] ow_11;
output logic signed [IL+FL-1:0] ow_12;
output logic signed [IL+FL-1:0] ow_13;
output logic signed [IL+FL-1:0] ow_14;
output logic signed [IL+FL-1:0] ow_15;
output logic [length-1:0] o_mask;
output logic [1:0] state;
output logic input_taken;

logic signed [IL+FL-1:0] reg_i_0;
logic signed [IL+FL-1:0] reg_i_1;
logic signed [IL+FL-1:0] reg_i_2;
logic signed [IL+FL-1:0] reg_i_3;
logic signed [IL+FL-1:0] reg_i_4;
logic signed [IL+FL-1:0] reg_i_5;
logic signed [IL+FL-1:0] reg_i_6;
logic signed [IL+FL-1:0] reg_i_7;
logic signed [IL+FL-1:0] reg_i_8;
logic signed [IL+FL-1:0] reg_i_9;
logic signed [IL+FL-1:0] reg_i_10;
logic signed [IL+FL-1:0] reg_i_11;
logic signed [IL+FL-1:0] reg_i_12;
logic signed [IL+FL-1:0] reg_i_13;
logic signed [IL+FL-1:0] reg_i_14;
logic signed [IL+FL-1:0] reg_i_15;
logic signed [IL+FL-1:0] reg_w_0;
logic signed [IL+FL-1:0] reg_w_1;
logic signed [IL+FL-1:0] reg_w_2;
logic signed [IL+FL-1:0] reg_w_3;
logic signed [IL+FL-1:0] reg_w_4;
logic signed [IL+FL-1:0] reg_w_5;
logic signed [IL+FL-1:0] reg_w_6;
logic signed [IL+FL-1:0] reg_w_7;
logic signed [IL+FL-1:0] reg_w_8;
logic signed [IL+FL-1:0] reg_w_9;
logic signed [IL+FL-1:0] reg_w_10;
logic signed [IL+FL-1:0] reg_w_11;
logic signed [IL+FL-1:0] reg_w_12;
logic signed [IL+FL-1:0] reg_w_13;
logic signed [IL+FL-1:0] reg_w_14;
logic signed [IL+FL-1:0] reg_w_15;

logic signed [IL+FL-1:0] reg_ii_0;
logic signed [IL+FL-1:0] reg_ii_1;
logic signed [IL+FL-1:0] reg_ii_2;
logic signed [IL+FL-1:0] reg_ii_3;
logic signed [IL+FL-1:0] reg_ii_4;
logic signed [IL+FL-1:0] reg_ii_5;
logic signed [IL+FL-1:0] reg_ii_6;
logic signed [IL+FL-1:0] reg_ii_7;
logic signed [IL+FL-1:0] reg_ii_8;
logic signed [IL+FL-1:0] reg_ii_9;
logic signed [IL+FL-1:0] reg_ii_10;
logic signed [IL+FL-1:0] reg_ii_11;
logic signed [IL+FL-1:0] reg_ii_12;
logic signed [IL+FL-1:0] reg_ii_13;
logic signed [IL+FL-1:0] reg_ii_14;
logic signed [IL+FL-1:0] reg_ii_15;
logic signed [IL+FL-1:0] reg_ww_0;
logic signed [IL+FL-1:0] reg_ww_1;
logic signed [IL+FL-1:0] reg_ww_2;
logic signed [IL+FL-1:0] reg_ww_3;
logic signed [IL+FL-1:0] reg_ww_4;
logic signed [IL+FL-1:0] reg_ww_5;
logic signed [IL+FL-1:0] reg_ww_6;
logic signed [IL+FL-1:0] reg_ww_7;
logic signed [IL+FL-1:0] reg_ww_8;
logic signed [IL+FL-1:0] reg_ww_9;
logic signed [IL+FL-1:0] reg_ww_10;
logic signed [IL+FL-1:0] reg_ww_11;
logic signed [IL+FL-1:0] reg_ww_12;
logic signed [IL+FL-1:0] reg_ww_13;
logic signed [IL+FL-1:0] reg_ww_14;
logic signed [IL+FL-1:0] reg_ww_15;

logic signed [IL+FL-1:0] reg_iii_0;
logic signed [IL+FL-1:0] reg_iii_1;
logic signed [IL+FL-1:0] reg_iii_2;
logic signed [IL+FL-1:0] reg_iii_3;
logic signed [IL+FL-1:0] reg_iii_4;
logic signed [IL+FL-1:0] reg_iii_5;
logic signed [IL+FL-1:0] reg_iii_6;
logic signed [IL+FL-1:0] reg_iii_7;
logic signed [IL+FL-1:0] reg_iii_8;
logic signed [IL+FL-1:0] reg_iii_9;
logic signed [IL+FL-1:0] reg_iii_10;
logic signed [IL+FL-1:0] reg_iii_11;
logic signed [IL+FL-1:0] reg_iii_12;
logic signed [IL+FL-1:0] reg_iii_13;
logic signed [IL+FL-1:0] reg_iii_14;
logic signed [IL+FL-1:0] reg_iii_15;
logic signed [IL+FL-1:0] reg_www_0;
logic signed [IL+FL-1:0] reg_www_1;
logic signed [IL+FL-1:0] reg_www_2;
logic signed [IL+FL-1:0] reg_www_3;
logic signed [IL+FL-1:0] reg_www_4;
logic signed [IL+FL-1:0] reg_www_5;
logic signed [IL+FL-1:0] reg_www_6;
logic signed [IL+FL-1:0] reg_www_7;
logic signed [IL+FL-1:0] reg_www_8;
logic signed [IL+FL-1:0] reg_www_9;
logic signed [IL+FL-1:0] reg_www_10;
logic signed [IL+FL-1:0] reg_www_11;
logic signed [IL+FL-1:0] reg_www_12;
logic signed [IL+FL-1:0] reg_www_13;
logic signed [IL+FL-1:0] reg_www_14;
logic signed [IL+FL-1:0] reg_www_15;

logic [length-1:0] reg_i_mask;
logic [length-1:0] reg_w_mask;
logic [length-1:0] reg_o_mask;
logic [length-1:0] reg_xor_i_mask;
logic [length-1:0] reg_xor_w_mask;

logic signed [IL+FL-1:0] reg_oi_0;
logic signed [IL+FL-1:0] reg_oi_1;
logic signed [IL+FL-1:0] reg_oi_2;
logic signed [IL+FL-1:0] reg_oi_3;
logic signed [IL+FL-1:0] reg_oi_4;
logic signed [IL+FL-1:0] reg_oi_5;
logic signed [IL+FL-1:0] reg_oi_6;
logic signed [IL+FL-1:0] reg_oi_7;
logic signed [IL+FL-1:0] reg_oi_8;
logic signed [IL+FL-1:0] reg_oi_9;
logic signed [IL+FL-1:0] reg_oi_10;
logic signed [IL+FL-1:0] reg_oi_11;
logic signed [IL+FL-1:0] reg_oi_12;
logic signed [IL+FL-1:0] reg_oi_13;
logic signed [IL+FL-1:0] reg_oi_14;
logic signed [IL+FL-1:0] reg_oi_15;
logic signed [IL+FL-1:0] reg_ow_0;
logic signed [IL+FL-1:0] reg_ow_1;
logic signed [IL+FL-1:0] reg_ow_2;
logic signed [IL+FL-1:0] reg_ow_3;
logic signed [IL+FL-1:0] reg_ow_4;
logic signed [IL+FL-1:0] reg_ow_5;
logic signed [IL+FL-1:0] reg_ow_6;
logic signed [IL+FL-1:0] reg_ow_7;
logic signed [IL+FL-1:0] reg_ow_8;
logic signed [IL+FL-1:0] reg_ow_9;
logic signed [IL+FL-1:0] reg_ow_10;
logic signed [IL+FL-1:0] reg_ow_11;
logic signed [IL+FL-1:0] reg_ow_12;
logic signed [IL+FL-1:0] reg_ow_13;
logic signed [IL+FL-1:0] reg_ow_14;
logic signed [IL+FL-1:0] reg_ow_15;

logic [1:0] mask_state;
logic mask_output_filter_input_taken;
logic [1:0] filter_state;
logic filter_output_shifter_input_taken;
logic [1:0] shifter_state;
logic done;

logic mask_input_ready;
logic delayed_input_ready;
logic filter_input_ready;
logic shifter_input_ready;

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

always_ff @(posedge clk) begin
	if (reset == 1 || (state == 2'b10 && output_taken == 1)) begin
		reg_i_0 <= {(IL+FL){1'b0}};
		reg_i_1 <= {(IL+FL){1'b0}};
		reg_i_2 <= {(IL+FL){1'b0}};
		reg_i_3 <= {(IL+FL){1'b0}};
		reg_i_4 <= {(IL+FL){1'b0}};
		reg_i_5 <= {(IL+FL){1'b0}};
		reg_i_6 <= {(IL+FL){1'b0}};
		reg_i_7 <= {(IL+FL){1'b0}};
		reg_i_8 <= {(IL+FL){1'b0}};
		reg_i_9 <= {(IL+FL){1'b0}};
		reg_i_10 <= {(IL+FL){1'b0}};
		reg_i_11 <= {(IL+FL){1'b0}};
		reg_i_12 <= {(IL+FL){1'b0}};
		reg_i_13 <= {(IL+FL){1'b0}};
		reg_i_14 <= {(IL+FL){1'b0}};
		reg_i_15 <= {(IL+FL){1'b0}};
		reg_w_0 <= {(IL+FL){1'b0}};
		reg_w_1 <= {(IL+FL){1'b0}};
		reg_w_2 <= {(IL+FL){1'b0}};
		reg_w_3 <= {(IL+FL){1'b0}};
		reg_w_4 <= {(IL+FL){1'b0}};
		reg_w_5 <= {(IL+FL){1'b0}};
		reg_w_6 <= {(IL+FL){1'b0}};
		reg_w_7 <= {(IL+FL){1'b0}};
		reg_w_8 <= {(IL+FL){1'b0}};
		reg_w_9 <= {(IL+FL){1'b0}};
		reg_w_10 <= {(IL+FL){1'b0}};
		reg_w_11 <= {(IL+FL){1'b0}};
		reg_w_12 <= {(IL+FL){1'b0}};
		reg_w_13 <= {(IL+FL){1'b0}};
		reg_w_14 <= {(IL+FL){1'b0}};	
		reg_w_15 <= {(IL+FL){1'b0}};

		reg_ii_0 <= {(IL+FL){1'b0}};
                reg_ii_1 <= {(IL+FL){1'b0}};
                reg_ii_2 <= {(IL+FL){1'b0}};
                reg_ii_3 <= {(IL+FL){1'b0}};
                reg_ii_4 <= {(IL+FL){1'b0}};
                reg_ii_5 <= {(IL+FL){1'b0}};
                reg_ii_6 <= {(IL+FL){1'b0}};
                reg_ii_7 <= {(IL+FL){1'b0}};
                reg_ii_8 <= {(IL+FL){1'b0}};
                reg_ii_9 <= {(IL+FL){1'b0}};
                reg_ii_10 <= {(IL+FL){1'b0}};
                reg_ii_11 <= {(IL+FL){1'b0}};
                reg_ii_12 <= {(IL+FL){1'b0}};
                reg_ii_13 <= {(IL+FL){1'b0}};
                reg_ii_14 <= {(IL+FL){1'b0}};
                reg_ii_15 <= {(IL+FL){1'b0}};
                reg_ww_0 <= {(IL+FL){1'b0}};
                reg_ww_1 <= {(IL+FL){1'b0}};
                reg_ww_2 <= {(IL+FL){1'b0}};
                reg_ww_3 <= {(IL+FL){1'b0}};
                reg_ww_4 <= {(IL+FL){1'b0}};
                reg_ww_5 <= {(IL+FL){1'b0}};
                reg_ww_6 <= {(IL+FL){1'b0}};
                reg_ww_7 <= {(IL+FL){1'b0}};
                reg_ww_8 <= {(IL+FL){1'b0}};
                reg_ww_9 <= {(IL+FL){1'b0}};
                reg_ww_10 <= {(IL+FL){1'b0}};
                reg_ww_11 <= {(IL+FL){1'b0}};
                reg_ww_12 <= {(IL+FL){1'b0}};
                reg_ww_13 <= {(IL+FL){1'b0}};
                reg_ww_14 <= {(IL+FL){1'b0}};
                reg_ww_15 <= {(IL+FL){1'b0}};

		reg_iii_0 <= {(IL+FL){1'b0}};
                reg_iii_1 <= {(IL+FL){1'b0}};
                reg_iii_2 <= {(IL+FL){1'b0}};
                reg_iii_3 <= {(IL+FL){1'b0}};
                reg_iii_4 <= {(IL+FL){1'b0}};
                reg_iii_5 <= {(IL+FL){1'b0}};
                reg_iii_6 <= {(IL+FL){1'b0}};
                reg_iii_7 <= {(IL+FL){1'b0}};
                reg_iii_8 <= {(IL+FL){1'b0}};
                reg_iii_9 <= {(IL+FL){1'b0}};
                reg_iii_10 <= {(IL+FL){1'b0}};
                reg_iii_11 <= {(IL+FL){1'b0}};
                reg_iii_12 <= {(IL+FL){1'b0}};
                reg_iii_13 <= {(IL+FL){1'b0}};
                reg_iii_14 <= {(IL+FL){1'b0}};
                reg_iii_15 <= {(IL+FL){1'b0}};
                reg_www_0 <= {(IL+FL){1'b0}};
                reg_www_1 <= {(IL+FL){1'b0}};
                reg_www_2 <= {(IL+FL){1'b0}};
                reg_www_3 <= {(IL+FL){1'b0}};
                reg_www_4 <= {(IL+FL){1'b0}};
                reg_www_5 <= {(IL+FL){1'b0}};
                reg_www_6 <= {(IL+FL){1'b0}};
                reg_www_7 <= {(IL+FL){1'b0}};
                reg_www_8 <= {(IL+FL){1'b0}};
                reg_www_9 <= {(IL+FL){1'b0}};
                reg_www_10 <= {(IL+FL){1'b0}};
                reg_www_11 <= {(IL+FL){1'b0}};
                reg_www_12 <= {(IL+FL){1'b0}};
                reg_www_13 <= {(IL+FL){1'b0}};
                reg_www_14 <= {(IL+FL){1'b0}};
                reg_www_15 <= {(IL+FL){1'b0}};

		reg_i_mask <= {(length){1'b0}};
		reg_w_mask <= {(length){1'b0}};

		input_taken <= 0;
	end
	else begin
		if (state == 2'b00 && input_ready == 1) begin
			reg_i_0 <= i_0;
			reg_i_1 <= i_1;
			reg_i_2 <= i_2;
			reg_i_3 <= i_3;
			reg_i_4 <= i_4;
			reg_i_5 <= i_5;
			reg_i_6 <= i_6;
			reg_i_7 <= i_7;
			reg_i_8 <= i_8;
			reg_i_9 <= i_9;
			reg_i_10 <= i_10;
			reg_i_11 <= i_11;
			reg_i_12 <= i_12;
			reg_i_13 <= i_13;
			reg_i_14 <= i_14;
			reg_i_15 <= i_15;
			reg_w_0 <= w_0;
                        reg_w_1 <= w_1;
                        reg_w_2 <= w_2;
                        reg_w_3 <= w_3;
                        reg_w_4 <= w_4;
                        reg_w_5 <= w_5;
                        reg_w_6 <= w_6;
                        reg_w_7 <= w_7;
                        reg_w_8 <= w_8;
                        reg_w_9 <= w_9;
                        reg_w_10 <= w_10;
                        reg_w_11 <= w_11;
                        reg_w_12 <= w_12;
                        reg_w_13 <= w_13;
                        reg_w_14 <= w_14;
                        reg_w_15 <= w_15;

			reg_i_mask <= i_mask;
			reg_w_mask <= w_mask;
			
			input_taken <= 1;
		end
		if (state == 2'b01) begin
			reg_ii_0 <= reg_i_0;
			reg_ii_1 <= reg_i_1;
			reg_ii_2 <= reg_i_2;
			reg_ii_3 <= reg_i_3;
			reg_ii_4 <= reg_i_4;
			reg_ii_5 <= reg_i_5;
			reg_ii_6 <= reg_i_6;
			reg_ii_7 <= reg_i_7;
                        reg_ii_8 <= reg_i_8;
                        reg_ii_9 <= reg_i_9;
                        reg_ii_10 <= reg_i_10;
                        reg_ii_11 <= reg_i_11;
                        reg_ii_12 <= reg_i_12;
                        reg_ii_13 <= reg_i_13;
			reg_ii_14 <= reg_i_14;
                        reg_ii_15 <= reg_i_15;
			reg_ww_0 <= reg_w_0;
                        reg_ww_1 <= reg_w_1;
                        reg_ww_2 <= reg_w_2;
                        reg_ww_3 <= reg_w_3;
                        reg_ww_4 <= reg_w_4;
                        reg_ww_5 <= reg_w_5;
                        reg_ww_6 <= reg_w_6;
                        reg_ww_7 <= reg_w_7;
                        reg_ww_8 <= reg_w_8;
                        reg_ww_9 <= reg_w_9;
                        reg_ww_10 <= reg_w_10;
                        reg_ww_11 <= reg_w_11;
                        reg_ww_12 <= reg_w_12;
                        reg_ww_13 <= reg_w_13;
                        reg_ww_14 <= reg_w_14;
                        reg_ww_15 <= reg_w_15;

			reg_iii_0 <= reg_ii_0;
                        reg_iii_1 <= reg_ii_1;
                        reg_iii_2 <= reg_ii_2;
                        reg_iii_3 <= reg_ii_3;
                        reg_iii_4 <= reg_ii_4;
                        reg_iii_5 <= reg_ii_5;
                        reg_iii_6 <= reg_ii_6;
                        reg_iii_7 <= reg_ii_7;
                        reg_iii_8 <= reg_ii_8;
                        reg_iii_9 <= reg_ii_9;
                        reg_iii_10 <= reg_ii_10;
                        reg_iii_11 <= reg_ii_11;
                        reg_iii_12 <= reg_ii_12;
                        reg_iii_13 <= reg_ii_13;
                        reg_iii_14 <= reg_ii_14;
                        reg_iii_15 <= reg_ii_15;
                        reg_www_0 <= reg_ww_0;
                        reg_www_1 <= reg_ww_1;
                        reg_www_2 <= reg_ww_2;
                        reg_www_3 <= reg_ww_3;
                        reg_www_4 <= reg_ww_4;
                        reg_www_5 <= reg_ww_5;
                        reg_www_6 <= reg_ww_6;
                        reg_www_7 <= reg_ww_7;
                        reg_www_8 <= reg_ww_8;
                        reg_www_9 <= reg_ww_9;
                        reg_www_10 <= reg_ww_10;
                        reg_www_11 <= reg_ww_11;
                        reg_www_12 <= reg_ww_12;
                        reg_www_13 <= reg_ww_13;
                        reg_www_14 <= reg_ww_14;
                        reg_www_15 <= reg_ww_15;
		end
	end
end

always_ff @(posedge clk) begin
	mask_input_ready <= input_ready;
end

mask #(.length(length)) mask_0
(
	.clk 		(clk),
	.reset		(reset),
	.i_mask		(reg_i_mask),
	.w_mask		(reg_w_mask),
	.input_ready	(mask_input_ready),
	.output_taken	(mask_output_filter_input_taken),
	.o_mask		(reg_o_mask),
	.xor_i_mask	(reg_xor_i_mask),
	.xor_w_mask	(reg_xor_w_mask),
	.state		(mask_state)
);

always_ff @(posedge clk) begin
	delayed_input_ready <= mask_input_ready;
	filter_input_ready <= delayed_input_ready;
end

filter #(.IL(IL), .FL(FL), .length(length), .p_length(p_length)) filter_0
(
	.clk		(clk),
	.reset		(reset),
	.i_0		(reg_iii_0),
	.i_1		(reg_iii_1),
	.i_2		(reg_iii_2),
	.i_3		(reg_iii_3),
	.i_4		(reg_iii_4),
	.i_5		(reg_iii_5),
	.i_6		(reg_iii_6),
	.i_7		(reg_iii_7),
	.i_8		(reg_iii_8),
	.i_9		(reg_iii_9),
	.i_10		(reg_iii_10),
	.i_11		(reg_iii_11),
	.i_12		(reg_iii_12),
	.i_13		(reg_iii_13),
	.i_14		(reg_iii_14),
	.i_15		(reg_iii_15),
	.w_0		(reg_www_0),
	.w_1		(reg_www_1),
	.w_2		(reg_www_2),
	.w_3		(reg_www_3),
	.w_4		(reg_www_4),
	.w_5		(reg_www_5),
	.w_6		(reg_www_6),
	.w_7		(reg_www_7),
	.w_8		(reg_www_8),
	.w_9		(reg_www_9),
	.w_10		(reg_www_10),
	.w_11		(reg_www_11),
	.w_12		(reg_www_12),
	.w_13		(reg_www_13),
	.w_14		(reg_www_14),
	.w_15		(reg_www_15),	
	.o_mask		(reg_o_mask),
	.xor_i_mask	(reg_xor_i_mask),
	.xor_w_mask	(reg_xor_w_mask),
	.input_ready	(filter_input_ready),
	.output_taken	(filter_output_shifter_input_taken),
	.oi_0		(reg_oi_0),	
	.oi_1		(reg_oi_1),
	.oi_2		(reg_oi_2),
	.oi_3		(reg_oi_3),
	.oi_4		(reg_oi_4),
	.oi_5		(reg_oi_5),
	.oi_6		(reg_oi_6),
	.oi_7		(reg_oi_7),
	.oi_8		(reg_oi_8),
	.oi_9		(reg_oi_9),
	.oi_10		(reg_oi_10),
	.oi_11		(reg_oi_11),
	.oi_12		(reg_oi_12),
	.oi_13		(reg_oi_13),
	.oi_14		(reg_oi_14),
	.oi_15		(reg_oi_15),
	.ow_0		(reg_ow_0),
	.ow_1		(reg_ow_1),
	.ow_2		(reg_ow_2),
	.ow_3		(reg_ow_3),
	.ow_4		(reg_ow_4),
	.ow_5		(reg_ow_5),
	.ow_6		(reg_ow_6),
	.ow_7		(reg_ow_7),
	.ow_8		(reg_ow_8),
	.ow_9		(reg_ow_9),
	.ow_10		(reg_ow_10),
	.ow_11		(reg_ow_11),
	.ow_12		(reg_ow_12),
	.ow_13		(reg_ow_13),
	.ow_14		(reg_ow_14),
	.ow_15		(reg_ow_15),
	.state		(filter_state),
	.input_taken	(mask_output_filter_input_taken)
);

always_comb begin
	shifter_input_ready = (filter_state == 2'b10) ? 1 : 0;
end

shifter #(.IL(IL), .FL(FL)) shifter_0
(
	.clk		(clk),
	.reset		(reset),
	.i_0		(reg_oi_0),
	.i_1		(reg_oi_1),
	.i_2		(reg_oi_2),
	.i_3		(reg_oi_3),
	.i_4		(reg_oi_4),
	.i_5		(reg_oi_5),
	.i_6		(reg_oi_6),
	.i_7		(reg_oi_7),
	.i_8		(reg_oi_8),
	.i_9		(reg_oi_9),
	.i_10		(reg_oi_10),
	.i_11		(reg_oi_11),
	.i_12		(reg_oi_12),
	.i_13		(reg_oi_13),
	.i_14		(reg_oi_14),
	.i_15		(reg_oi_15),
	.w_0		(reg_ow_0),
	.w_1		(reg_ow_1),
	.w_2		(reg_ow_2),
	.w_3		(reg_ow_3),
	.w_4		(reg_ow_4),
	.w_5		(reg_ow_5),
	.w_6		(reg_ow_6),
	.w_7		(reg_ow_7),
	.w_8		(reg_ow_8),
	.w_9		(reg_ow_9),
	.w_10		(reg_ow_10),
	.w_11		(reg_ow_11),
	.w_12		(reg_ow_12),
	.w_13		(reg_ow_13),
	.w_14		(reg_ow_14),
	.w_15		(reg_ow_15),
	.input_ready	(shifter_input_ready),
	.output_taken	(output_taken),
	.oi_0		(oi_0),
	.oi_1		(oi_1),
	.oi_2		(oi_2),
	.oi_3		(oi_3),
	.oi_4		(oi_4),
	.oi_5		(oi_5),
	.oi_6		(oi_6),
	.oi_7		(oi_7),
	.oi_8		(oi_8),
	.oi_9		(oi_9),
	.oi_10		(oi_10),
	.oi_11		(oi_11),
	.oi_12		(oi_12),
	.oi_13		(oi_13),
	.oi_14		(oi_14),
	.oi_15		(oi_15),
	.ow_0		(ow_0),
	.ow_1		(ow_1),
	.ow_2		(ow_2),
	.ow_3		(ow_3),
	.ow_4		(ow_4),
	.ow_5		(ow_5),
	.ow_6		(ow_6),
	.ow_7		(ow_7),
	.ow_8		(ow_8),
	.ow_9		(ow_9),
	.ow_10		(ow_10),
	.ow_11		(ow_11),
	.ow_12		(ow_12),
	.ow_13		(ow_13),
	.ow_14		(ow_14),
	.ow_15		(ow_15),	
	.state		(shifter_state),
	.input_taken	(filter_output_shifter_input_taken)
); 

always_comb begin
	o_mask = reg_o_mask;
	done = (shifter_state == 2'b10) ? 1 : 0;
end

endmodule
