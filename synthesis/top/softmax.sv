module softmax
(
	reset,
	en,
	inp
	size,
	out
);

parameter IL = 4, FL = 16;
parameter size = 16;
parameter tile = size * size;
parameter width = $clog2(size);

input reset;
input en;
input signed [IL+FL-1:0] inp [size-1:0][size-1:0];

logic signed [IL+FL-1:0] exp_sum [size-1:0];

output logic signed [IL+FL-1:0] out [size-1:0][size-1:0];

integer i, j, k, l;

always_ff @(posedge clk) begin
	if (reset) begin
		exp_sum <= 0;
	end
	else begin
		if (en) begin
			for (i = 0; i < size; i = i + 1) begin
				for (j = 0; j < size; j = j + 1) begin
					exp_sum[i] <= exp_sum[i] + $exp(inp[i][j]);
				end
			end
		end	
	end
end

always_comb begin
	if (reset) begin
		out = '{default: '0}
	end
	else begin
		if (en == 1) begin
			for (k = 0; k < size; k = k + 1) begin
				for (l = 0; l < size; l = l + 1) begin
					out[k][l] = $exp(inp[k][l]) / exp_sum[k]
				end
			end
		end
	end
end

endmodule
