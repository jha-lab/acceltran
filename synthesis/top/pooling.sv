module pooling
(
	clk,
	reset,
	im,
	input_ready,
	output_taken,
	mode,
	om,
	state
);

parameter IL = 4, FL = 16;
parameter size = 4;
parameter width = $clog2(size);

input clk, reset;
input signed [IL+FL-1:0] im [size-1:0];
input input_ready;
input output_taken;
input [1:0] mode;

output logic signed [IL+FL-1:0] om;
output logic [1:0] state;

logic signed [IL+FL-1:0] reg_im [size-1:0];
logic reg_input_ready;
logic [1:0] reg_mode;
logic en_max;
logic en_mean;
logic en_min;
logic done_max;
logic done_mean;
logic done_min;
logic done;
logic signed [IL+FL-1:0] om_max;
logic signed [IL+FL-1:0] om_mean;
logic signed [IL+FL-1:0] om_min;

integer i;

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
		for (i = 0; i < size; i = i + 1) begin
			reg_im[i] = 0;
		end
	end
	else begin
		if (state == 2'b00 && input_ready == 1) begin
			reg_im = im;
		end
	end
end

always_ff @(posedge clk) begin
	if (reset != 1 && state == 2'b00 && input_ready == 1) begin
		reg_input_ready <= 1;
	end
	else begin
		reg_input_ready <= 0;
	end
end

always_comb begin
	if (state == 2'b01) begin
		if (mode == 2'b00) begin
			en_max = 1;
			en_mean = 0;
			en_min = 0;
		end
		if (mode == 2'b01) begin
			en_max = 0;
			en_mean = 1;
			en_min = 0;
		end
		if (mode == 2'b10) begin
			en_max = 0;
			en_mean = 0;
			en_min = 1;
		end	
	end
	else begin
		en_max = 0;
		en_mean = 0;
		en_min = 0;
	end
end

always_comb begin
	case (mode)
		2'b00:done = done_max;
		2'b01:done = done_mean;
		2'b10:done = done_min;
	endcase
end

always_comb begin
	case (mode)
		2'b00:om = om_max;
		2'b01:om = om_mean;
		2'b10:om = om_min;
	endcase
end

max_pooling #(.IL(IL), .FL(FL), .size(size), .width(width))		max_pooling_0
(
	.clk		(clk),
	.im		(reg_im),
        .en		(en_max),
        .input_ready	(reg_input_ready),
        .om		(om_max),
        .done		(done_max)
);

mean_pooling #(.IL(IL), .FL(FL), .size(size), .width(width))		mean_pooling_0
(
	.clk		(clk),
        .im		(reg_im),
        .en		(en_mean),
        .input_ready	(reg_input_ready),
        .om		(om_mean),
        .done		(done_mean)
);

min_pooling #(.IL(IL), .FL(FL), .size(size), .width(width))		min_pooling_0
(
	.clk		(clk),
        .im		(reg_im),
        .en		(en_min),
        .input_ready	(reg_input_ready),
        .om		(om_min),
        .done		(done_min)
);

endmodule
