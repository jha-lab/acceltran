module forward
(
	clk,
	reset,
	batch,
	num,
	gamma,
	beta,
	input_ready,
	output_taken,
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
input signed [IL+FL-1:0] batch [size-1:0];
input [3:0] num;
input signed [IL+FL-1:0] gamma;
input signed [IL+FL-1:0] beta;
input input_ready;
input output_taken;

output logic signed [IL+FL-1:0] out [size-1:0];
output logic signed [IL+FL-1:0] norm [size-1:0];
output logic signed [IL+FL-1:0] mu;
output logic signed [IL+FL-1:0] vari;
output logic [1:0] state;
output logic done;

logic signed [IL+FL-1:0] reg_batch [size-1:0];
logic [3:0] reg_num;
logic signed [IL+FL-1:0] reg_gamma;
logic signed [IL+FL-1:0] reg_beta;
logic start_0;
logic start_1;
logic start_2;
logic signed [IL+FL-1:0] batch_square [size-1:0];
logic signed [IL+FL-1:0] square_mu;
logic signed [IL+FL-1:0] mu_square;
logic signed [IL+FL-1:0] root;
logic signed [IL+FL-1:0] varii;
logic done_sqrt;

integer i,j,k;

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
	if (reset) begin
		for (i = 0; i < size; i = i + 1) begin
			reg_batch[i] <= 0;
		end
		reg_num <= 0;
		reg_gamma <= 0;
		reg_beta <= 0;
	end
	else begin
		if (state == 2'b00 && input_ready == 1) begin
			reg_batch <= batch;
			reg_num <= num;
			reg_gamma <= gamma;
			reg_beta <= beta;
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

mean #(.IL(IL), .FL(FL), .size(size))		mean_0
(
	.start		(start_0),
	.batch		(reg_batch),
	.num		(reg_num),
	.out		(mu)
);

always_comb begin
	if (state == 2'b01) begin
		for (j = 0; j < num; j = j + 1) begin
			batch_square[j] = reg_batch[j] * reg_batch[j];
		end
	end
end

mean #(.IL(IL), .FL(FL), .size(size))           mean_1
(
        .start          (start_1),
        .batch          (batch_square),
        .num            (reg_num),
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
		for (k = 0; k < num; k = k + 1) begin
			norm[k] = (reg_batch[k] - mu) / root;
			out[k] = norm[k] * gamma + beta;
		end
	end
end


endmodule
