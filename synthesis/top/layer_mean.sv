module mean
(
	start,
	inp,
	size,
	out
);

parameter IL = 4, FL = 16;
parameter tile = size * size;
parameter width = $clog2(size);

input start;

output logic signed [IL+FL-1:0] out;

logic signed [(IL+FL)*2-1:0] sum;
integer i, j;

always_comb begin
	if (start) begin
		sum = 0;
	end
	else begin
		for (i = 0; i < size; i = i + 1) begin
			for (j = 0; j < size; j = j + 1) begin
				sum = sum + inp[i][j];		
			end
		end	
		out = sum / tile;
	end
end

endmodule
