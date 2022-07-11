module backward
(
	clk,
	reset,
	dout,
	num,
	batch,
	norm,
	mu,
	vari,
	gamma,
	input_ready,
	output_taken,
	dX,
	dgamma,
	dbeta,
	state,
	done
);

parameter IL = 4, FL = 16;
parameter size = 16;
parameter width = $clog2(size);

input clk, reset;
input signed [IL+FL-1:0] dout [size-1:0];
input [3:0] num;
input signed [IL+FL-1:0] batch [size-1:0];
input signed [IL+FL-1:0] norm [size-1:0];
input signed [IL+FL-1:0] mu;
input signed [IL+FL-1:0] vari;
input signed [IL+FL-1:0] gamma;
input input_ready;
input output_taken;

output logic signed [IL+FL-1:0] dX [size-1:0];
output logic signed [IL+FL-1:0] dgamma;
output logic signed [IL+FL-1:0] dbeta;
output logic [1:0] state;
output logic done;

logic signed [IL+FL-1:0] reg_dout [size-1:0];
logic [3:0] reg_num;
logic signed [IL+FL-1:0] reg_batch [size-1:0];
logic signed [IL+FL-1:0] reg_norm [size-1:0];
logic signed [IL+FL-1:0] reg_mu;
logic signed [IL+FL-1:0] reg_vari;
logic signed [IL+FL-1:0] reg_gamma;

logic signed [IL+FL-1:0] X_mu [size-1:0];
logic signed [IL+FL-1:0] std_inv;
logic signed [IL+FL-1:0] varri;
logic signed [IL+FL-1:0] dX_norm [size-1:0];
logic signed [IL+FL-1:0] dvar;
logic signed [IL+FL-1:0] dmu;
logic signed [IL+FL-1:0] root;
logic signed [IL+FL-1:0] mean;
logic signed [IL+FL-1:0] dvar_sum;
logic signed [IL+FL-1:0] dmu_sum;

logic input_ready_sqrt_0;
logic input_ready_sqrt_1;
logic done_sqrt;
logic start_mean_0;
logic start_mean_1;

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
			reg_dout[i] <= 0;
			reg_batch[i] <= 0;
			reg_norm[i] <= 0;
		end
		reg_num <= 0;	
		reg_mu <= 0;
		reg_vari <= 0;
		reg_gamma <= 0;
	end
	else begin
		if (state == 2'b00 && input_ready == 1) begin
			reg_dout <= dout;
			reg_batch <= batch;
			reg_norm <= norm;
			reg_num <= num;
			reg_mu <= mu;
			reg_vari <= vari;
			reg_gamma <= gamma;
		end
	end
end

always_ff @(posedge clk) begin
	if (start_mean_0) begin
		start_mean_0 <= 0;
	end
	else begin
		if (state == 2'b00 && input_ready == 1) begin
			start_mean_0 <= 1;
		end
	end
	start_mean_1 <= start_mean_0;
end

mean #(.IL(IL), .FL(FL), .size(size))		mean_0
(
	.start		(start_mean_1),
	.batch		(X_mu),
	.num		(reg_num),
	.out		(mean)
);

always_ff @(posedge clk) begin
	if (input_ready_sqrt_0) begin
		input_ready_sqrt_0 <= 0;
	end
	else begin
		if (state == 2'b00 && input_ready == 1) begin
			input_ready_sqrt_0 <= 1;
		end
	end
	input_ready_sqrt_1 <= input_ready_sqrt_0;
end

sqrt #(.IL(IL), .FL(FL))		sqrt_0
(
	.clk		(clk),
        .reset		(reset),
        .in		(varri),
        .input_ready	(input_ready_sqrt_0),
        .output_taken	(output_taken),
        .out		(root),
        .state		(),
        .done		(done_sqrt)

);

always_ff @(posedge clk) begin
	done <= done_sqrt;
end

always_comb begin
	if (reset || (state == 2'b10 && output_taken == 1)) begin
		dvar_sum = 0;
		dmu_sum = 0;
		dgamma = 0;
		dbeta = 0;
	end
	else begin
		if (state == 2'b01) begin
			varri = vari + 1;
            std_inv = (1 <<< FL) / (root+1);
			for (j = 0; j < reg_num; j = j + 1) begin
				X_mu[j] = reg_batch[j] - reg_mu;
				dX_norm[j] = reg_dout[j] * reg_gamma;			
				dvar_sum = dvar_sum + dX_norm[j] * X_mu[j];
				dmu_sum = dmu_sum + dX_norm[j] * (-std_inv);
			end 
			dvar = dvar_sum * -(1<<<(FL-1)) * std_inv * std_inv * std_inv;
			dmu = dmu_sum + dvar * (-(1<<<(FL+1))) * mean;
			for (k = 0; k < reg_num; k = k + 1) begin
				dX[k] = dX_norm[k] * std_inv + (dvar<<<1) * X_mu[k] / reg_num + dmu / reg_num;
				dgamma = dgamma + dout[k] * reg_norm[k];
				dbeta = dbeta + dout[k];
			end
		end
	end
end

endmodule
