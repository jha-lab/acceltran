module scalar
(
	clk,
	reset,
	mode,
	state,
	input_ready,
	output_taken,
	in1,
	in2,
	out
);

parameter IL = 4, FL = 16;
parameter size = 16;
parameter width = $clog2(size);

input clk, reset;
input [1:0] mode;
input input_ready, output_taken;
input signed [IL+FL-1:0] in1 [size-1:0];
input signed [IL+FL-1:0] in2 [size-1:0];

output logic [1:0] state;
output logic signed [IL+FL-1:0] out [size-1:0];

logic signed [IL+FL-1:0] reg_in1 [size-1:0];
logic signed [IL+FL-1:0] reg_in2 [size-1:0];
logic done;
logic signed [IL+FL-1:0] reg_out [size-1:0];

always_ff @(posedge clk) begin
	if (reset) begin
		state <= 2'b00;
	end
	else begin
		if (state == 2'b00 && input_ready) begin
			state <= 2'b01;
		end
		if (state == 2'b01 && done) begin
			state <= 2'b10;
		end
		if (state == 2'b10 && output_taken) begin
			state <= 2'b00;
		end
	end
end

int k;
always_ff @(posedge clk) begin
	if (reset || (state == 2'b10 && output_taken)) begin
		for (k = 0; k < size; k++) begin		
			reg_in1[k] <= 0;
			reg_in2[k] <= 0;
		end
	end
	else if (state == 2'b00 && input_ready) begin
		reg_in1 <= in1;
		reg_in2 <= in2;
	end
end

int i;
always_comb begin
	for (i = 0; i < size; i++) begin
		if (mode == 2'b00) begin
			reg_out[i] = reg_in1[i] + reg_in2[i];
		end	
		if (mode == 2'b01) begin
			reg_out[i] = reg_in1[i] - reg_in2[i];
		end
		if (mode == 2'b10) begin
			reg_out[i] = reg_in1[i] * reg_in2[i];
		end
		if (mode == 2'b11) begin
			reg_out[i] = reg_in1[i] / reg_in2[i];
		end
	end
end

int j;
always_ff @(posedge clk) begin
	if (reset || (state == 2'b10 && output_taken)) begin
		for (j = 0; j < size; j++) begin
			out[j] <= 0;
		end
	end
	else if (state == 2'b01 && done) begin
		out <= reg_out;
	end
end

always_ff @(posedge clk) begin
	if (state == 2'b00 && input_ready) begin
		done <= 1;
	end
	else begin
		done <= 0;
	end
end

endmodule
