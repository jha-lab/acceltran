module L2
(
	reset,
	en,
	yHat,
	y,
	num,
	sum	
);

parameter IL = 4, FL = 16;
parameter size = 16;
parameter width = $clog2(size);

input reset;
input en;
input signed [IL+FL-1:0] yHat [size-1:0];
input signed [IL+FL-1:0] y [size-1:0];
input [width-1:0] num;

output logic signed [IL+FL-1:0] sum;

logic signed [IL+FL-1:0] square [size-1:0];

integer i,j,k;

always_comb begin
	if (reset) begin
		sum = 0;
	end
	else begin
		if (en) begin
			for (i = 0; i < num; i = i + 1) begin
				sum = sum + square[i];
			end
		end	
	end
end

always_comb begin
	if (reset) begin
		for (j = 0; j < size; j = j + 1) begin
			square[j] = 0;
		end
	end
	else begin
		if (en == 1) begin
			for (k = 0; k < size; k = k + 1) begin
				if (k < num) begin
					square[k] = (yHat[k] - y[k]) * (yHat[k] - y[k]);
				end
			end
		end
	end
end

endmodule
