module loss
(
	clk,
	reset,
	model,
	yHat,
	y,
	num,
	input_ready,
	output_taken,
	state,
	out
);

parameter IL = 4, FL = 16;
parameter size = 16;
parameter width = $clog2(size);

input clk, reset;
input model;
input [width-1:0] num;
input signed [IL+FL-1:0] yHat [size-1:0];
input signed [IL+FL-1:0] y [size-1:0];
input input_ready;
input output_taken;

output logic [1:0] state;
output logic signed [IL+FL-1:0] out;

logic done;
logic signed [IL+FL-1:0] reg_yHat [size-1:0];
logic signed [IL+FL-1:0] reg_y [size-1:0];
logic [width-1:0] reg_num;
logic reg_model;
logic en_L1;
logic en_L2;
logic reset_loss;
logic signed [IL+FL-1:0] out_L1;
logic signed [IL+FL-1:0] out_L2;

integer i;

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
	if (reset || (state == 2'b10 && output_taken == 1)) begin
		for (i = 0; i < size; i++) begin
			reg_yHat[i] <= 0;
			reg_y[i] <= 0;
		end
		reg_num <= 0;
		reg_model <= 0;
	end
	else begin
		if (state == 2'b00 && input_ready == 1) begin
			reg_yHat <= yHat;
			reg_y <= y;
			reg_num <= num;
			reg_model <= model;
		end
	end
end

always_comb begin
	en_L1 = reg_model;
	en_L2 = !reg_model;
end

always_comb  begin
	if (reset || (state == 2'b10 && output_taken == 1)) begin
		reset_loss = 1;
	end
	else begin
		reset_loss = 0;
	end
end

L1 #(.IL(IL), .FL(FL), .size(size), .width(width))	L1_0
(
	.reset          (reset_loss),
        .en             (en_L1),
        .yHat           (reg_yHat),
        .y              (reg_y),
        .num            (reg_num),
        .sum            (out_L1)
);

L2 #(.IL(IL), .FL(FL), .size(size), .width(width))	L2_0
(
	.reset          (reset_loss),
        .en             (en_L2),
        .yHat           (reg_yHat),
        .y              (reg_y),
        .num            (reg_num),
        .sum            (out_L2)
);

always_ff @(posedge clk) begin
	if ((state == 2'b00 && input_ready == 1)) begin
		done <= 1;
	end
	else begin
		done <= 0;
	end
end

always_comb begin
	if (reg_model) begin
		out = out_L1;
	end
	else begin
		out = out_L2;
	end
end
endmodule
