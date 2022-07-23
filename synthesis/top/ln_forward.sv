module ln_forward_8
(
	clk,
	reset,
	input_ready,
	output_taken,
	inp,
	out,
	norm,
	mu,
	vari,
	state,
	done
);

parameter IL = 4, FL = 16;
parameter size = 8;
parameter width = $clog2(size);

input clk, reset;
input signed [IL+FL-1:0] inp [size-1:0][size-1:0];
input input_ready;
input output_taken;

output logic signed [IL+FL-1:0] out [size-1:0][size-1:0];
output logic signed [IL+FL-1:0] norm [size-1:0][size-1:0];
output logic signed [IL+FL-1:0] mu;
output logic signed [IL+FL-1:0] vari;
output logic [1:0] state;
output logic done;

logic [3:0] reg_num;
logic start_0;
logic start_1;
logic start_2;
logic signed [IL+FL-1:0] inp_square [size-1:0][size-1:0];
logic signed [IL+FL-1:0] square_mu;
logic signed [IL+FL-1:0] mu_square;
logic signed [IL+FL-1:0] root;
logic signed [IL+FL-1:0] varii;
logic done_sqrt;

integer i, j, k, l;

always_ff @(posedge clk) begin
	if (reset) begin
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
	if (start_0) begin
		start_0 <= 0;
	end
	else begin
		if (state == 2'b00 && input_ready == 1) begin
			start_0 <= 1;
		end
	end
	start_1 <= start_0;
	start_2 <= start_1;
end

layer_mean #(.IL(IL), .FL(FL), .size(size))		layer_mean_0
(
	.clk		(clk),
	.start		(start_0),
	.inp		(inp),
	.out		(mu)
);

always_comb begin
	if (state == 2'b01) begin
		for (i = 0; i < size; i = i + 1) begin
			for (j = 0; j < size; j = j + 1) begin
				inp_square[i][j] = inp[i][j] * inp[i][j];
			end
		end
	end
end

layer_mean #(.IL(IL), .FL(FL), .size(size))           layer_mean_1
(
        .clk		(clk),
        .start          (start_1),
        .inp            (inp_square),
        .out            (square_mu)
);

sqrt #(.IL(IL), .FL(FL))		sqrt_0
(
	.clk		(clk),
	.reset		(reset),
	.in		(varii),
        .input_ready	(start_2),
        .output_taken	(output_taken),
        .out		(root),
        .state		(),
        .done		(done_sqrt)	
);

always_ff @(posedge clk) begin
	done <= done_sqrt;
end 

always_comb begin
	if (state == 2'b01) begin
		mu_square = mu * mu;
		vari = square_mu - mu_square;
		varii = vari + 1;
		for (k = 0; k < size; k = k + 1) begin
			for (l = 0; l < size; l = l + 1) begin
				out[k][l] = (inp[k][l] - mu) / root;
			end
		end
	end
end

endmodule

module ln_forward_16
(
	clk,
	reset,
	input_ready,
	output_taken,
	inp,
	out,
	norm,
	mu,
	vari,
	state,
	done
);

parameter IL = 4, FL = 16;
parameter size = 16;
parameter width = $clog2(size);

input clk, reset;
input signed [IL+FL-1:0] inp [size-1:0][size-1:0];
input input_ready;
input output_taken;

output logic signed [IL+FL-1:0] out [size-1:0][size-1:0];
output logic signed [IL+FL-1:0] norm [size-1:0][size-1:0];
output logic signed [IL+FL-1:0] mu;
output logic signed [IL+FL-1:0] vari;
output logic [1:0] state;
output logic done;

logic [3:0] reg_num;
logic start_0;
logic start_1;
logic start_2;
logic signed [IL+FL-1:0] inp_square [size-1:0][size-1:0];
logic signed [IL+FL-1:0] square_mu;
logic signed [IL+FL-1:0] mu_square;
logic signed [IL+FL-1:0] root;
logic signed [IL+FL-1:0] varii;
logic done_sqrt;

integer i, j, k, l;

always_ff @(posedge clk) begin
	if (reset) begin
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
	if (start_0) begin
		start_0 <= 0;
	end
	else begin
		if (state == 2'b00 && input_ready == 1) begin
			start_0 <= 1;
		end
	end
	start_1 <= start_0;
	start_2 <= start_1;
end

layer_mean #(.IL(IL), .FL(FL), .size(size))		layer_mean_0
(
	.clk		(clk),
	.start		(start_0),
	.inp		(inp),
	.out		(mu)
);

always_comb begin
	if (state == 2'b01) begin
		for (i = 0; i < size; i = i + 1) begin
			for (j = 0; j < size; j = j + 1) begin
				inp_square[i][j] = inp[i][j] * inp[i][j];
			end
		end
	end
end

layer_mean #(.IL(IL), .FL(FL), .size(size))           layer_mean_1
(
        .clk		(clk),
        .start          (start_1),
        .inp            (inp_square),
        .out            (square_mu)
);

sqrt #(.IL(IL), .FL(FL))		sqrt_0
(
	.clk		(clk),
	.reset		(reset),
	.in		(varii),
        .input_ready	(start_2),
        .output_taken	(output_taken),
        .out		(root),
        .state		(),
        .done		(done_sqrt)	
);

always_ff @(posedge clk) begin
	done <= done_sqrt;
end 

always_comb begin
	if (state == 2'b01) begin
		mu_square = mu * mu;
		vari = square_mu - mu_square;
		varii = vari + 1;
		for (k = 0; k < size; k = k + 1) begin
			for (l = 0; l < size; l = l + 1) begin
				out[k][l] = (inp[k][l] - mu) / root;
			end
		end
	end
end

endmodule

module ln_forward_32
(
	clk,
	reset,
	input_ready,
	output_taken,
	inp,
	out,
	norm,
	mu,
	vari,
	state,
	done
);

parameter IL = 4, FL = 16;
parameter size = 32;
parameter width = $clog2(size);

input clk, reset;
input signed [IL+FL-1:0] inp [size-1:0][size-1:0];
input input_ready;
input output_taken;

output logic signed [IL+FL-1:0] out [size-1:0][size-1:0];
output logic signed [IL+FL-1:0] norm [size-1:0][size-1:0];
output logic signed [IL+FL-1:0] mu;
output logic signed [IL+FL-1:0] vari;
output logic [1:0] state;
output logic done;

logic [3:0] reg_num;
logic start_0;
logic start_1;
logic start_2;
logic signed [IL+FL-1:0] inp_square [size-1:0][size-1:0];
logic signed [IL+FL-1:0] square_mu;
logic signed [IL+FL-1:0] mu_square;
logic signed [IL+FL-1:0] root;
logic signed [IL+FL-1:0] varii;
logic done_sqrt;

integer i, j, k, l;

always_ff @(posedge clk) begin
	if (reset) begin
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
	if (start_0) begin
		start_0 <= 0;
	end
	else begin
		if (state == 2'b00 && input_ready == 1) begin
			start_0 <= 1;
		end
	end
	start_1 <= start_0;
	start_2 <= start_1;
end

layer_mean #(.IL(IL), .FL(FL), .size(size))		layer_mean_0
(
	.clk		(clk),
	.start		(start_0),
	.inp		(inp),
	.out		(mu)
);

always_comb begin
	if (state == 2'b01) begin
		for (i = 0; i < size; i = i + 1) begin
			for (j = 0; j < size; j = j + 1) begin
				inp_square[i][j] = inp[i][j] * inp[i][j];
			end
		end
	end
end

layer_mean #(.IL(IL), .FL(FL), .size(size))           layer_mean_1
(
        .clk		(clk),
        .start          (start_1),
        .inp            (inp_square),
        .out            (square_mu)
);

sqrt #(.IL(IL), .FL(FL))		sqrt_0
(
	.clk		(clk),
	.reset		(reset),
	.in		(varii),
        .input_ready	(start_2),
        .output_taken	(output_taken),
        .out		(root),
        .state		(),
        .done		(done_sqrt)	
);

always_ff @(posedge clk) begin
	done <= done_sqrt;
end 

always_comb begin
	if (state == 2'b01) begin
		mu_square = mu * mu;
		vari = square_mu - mu_square;
		varii = vari + 1;
		for (k = 0; k < size; k = k + 1) begin
			for (l = 0; l < size; l = l + 1) begin
				out[k][l] = (inp[k][l] - mu) / root;
			end
		end
	end
end

endmodule
