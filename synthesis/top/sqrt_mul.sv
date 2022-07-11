module sqrt
(
	clk,
	reset,
	in,
	input_ready,
	output_taken,
	out,
	state,
	done
);

parameter IL = 4, FL = 16;

input clk, reset;
input signed [IL+FL-1:0] in;
input input_ready;
input output_taken;

output logic signed [IL+FL-1:0] out;
output logic [1:0] state;
output logic done;

logic [IL+FL-1:0] reg_in;
logic [(IL+FL)/2-1:0] A;
logic [4:0] index;

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
		reg_in <= 0;
	end
	else begin
		if (state == 2'b00 && input_ready == 1) begin
			reg_in <= in;
		end
	end
end

always_ff @(posedge clk) begin
	if (reset || (state == 2'b10 && output_taken == 1)) begin
		index <= (IL + FL) / 2;
	end
	else begin
		if (state == 2'b01) begin
			index <= index - 1;
		end
	end
end

always_comb begin
	done = (index == 0) ? 1 : 0;
end

always_comb begin
	if (reset || (state == 2'b10 && output_taken == 1)) begin
		A = 0;
	end
	else begin
		A[index] = 1;
		if (A * A > reg_in) begin
			A[index] = 0;
		end
	end
end

always_ff @(posedge clk) begin
	if (reset || (state == 2'b10 && output_taken == 1)) begin
		out <= 0;
	end
	else begin
		if (done) begin
			out <= {out[IL+FL-1:(IL+FL)/2], A};
		end
	end
end

endmodule
