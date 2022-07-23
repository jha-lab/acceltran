module softmax_8
(
	reset,
	en,
	clk,
	inp,
	out
);

parameter IL = 4, FL = 16;
parameter size = 8;
parameter tile = size*size; // size * size
parameter width = $clog2(size);

input reset;
input en;
input clk;
input signed [IL+FL-1:0] inp [size-1:0][size-1:0];

logic signed [IL+FL-1:0] exp_sum [size-1:0];

output logic signed [IL+FL-1:0] out [size-1:0][size-1:0];

integer i, j, k, l;

always_ff @(posedge clk) begin
	if (reset == 1) begin
		exp_sum <= '{default: '0};
	end else begin
		if (en == 1) begin
			for (i = 0; i < size; i = i + 1) begin
				for (j = 0; j < size; j = j + 1) begin
					exp_sum[i] <= exp_sum[i] + (inp[i][j] <<< 1);
				end
			end
		end	
	end
end

always_comb begin
	if (reset == 1) begin
		out = '{default: '0};
	end else begin
		if (en == 1) begin
			for (k = 0; k < size; k = k + 1) begin
				for (l = 0; l < size; l = l + 1) begin
					out[k][l] = (inp[k][l] <<< 1) / exp_sum[k];
				end
			end
		end
	end
end

endmodule

module softmax_16
(
	reset,
	en,
	clk,
	inp,
	out
);

parameter IL = 4, FL = 16;
parameter size = 16;
parameter tile = size*size; // size * size
parameter width = $clog2(size);

input reset;
input en;
input clk;
input signed [IL+FL-1:0] inp [size-1:0][size-1:0];

logic signed [IL+FL-1:0] exp_sum [size-1:0];

output logic signed [IL+FL-1:0] out [size-1:0][size-1:0];

integer i, j, k, l;

always_ff @(posedge clk) begin
	if (reset == 1) begin
		exp_sum <= '{default: '0};
	end else begin
		if (en == 1) begin
			for (i = 0; i < size; i = i + 1) begin
				for (j = 0; j < size; j = j + 1) begin
					exp_sum[i] <= exp_sum[i] + (inp[i][j] <<< 1);
				end
			end
		end	
	end
end

always_comb begin
	if (reset == 1) begin
		out = '{default: '0};
	end else begin
		if (en == 1) begin
			for (k = 0; k < size; k = k + 1) begin
				for (l = 0; l < size; l = l + 1) begin
					out[k][l] = (inp[k][l] <<< 1) / exp_sum[k];
				end
			end
		end
	end
end

endmodule

module softmax_32
(
	reset,
	en,
	clk,
	inp,
	out
);

parameter IL = 4, FL = 16;
parameter size = 32;
parameter tile = size*size; // size * size
parameter width = $clog2(size);

input reset;
input en;
input clk;
input signed [IL+FL-1:0] inp [size-1:0][size-1:0];

logic signed [IL+FL-1:0] exp_sum [size-1:0];

output logic signed [IL+FL-1:0] out [size-1:0][size-1:0];

integer i, j, k, l;

always_ff @(posedge clk) begin
	if (reset == 1) begin
		exp_sum <= '{default: '0};
	end else begin
		if (en == 1) begin
			for (i = 0; i < size; i = i + 1) begin
				for (j = 0; j < size; j = j + 1) begin
					exp_sum[i] <= exp_sum[i] + (inp[i][j] <<< 1);
				end
			end
		end	
	end
end

always_comb begin
	if (reset == 1) begin
		out = '{default: '0};
	end else begin
		if (en == 1) begin
			for (k = 0; k < size; k = k + 1) begin
				for (l = 0; l < size; l = l + 1) begin
					out[k][l] = (inp[k][l] <<< 1) / exp_sum[k];
				end
			end
		end
	end
end

endmodule
