module layer_mean
#(
	parameter size = 16,
	parameter IL = 4, 
	parameter FL = 16
)
(
	input start,
	input logic signed [IL+FL-1:0] inp [size-1:0][size-1:0],
	input clk,
	output logic signed [IL+FL-1:0] out
);

parameter tile = size*size;
parameter width = $clog2(size);

logic signed [(IL+FL)*2-1:0] sum;
integer i, j;

always_ff @(posedge clk) begin
	if (start) begin
		sum <= '{default: '0};
	end else begin
		for (i = 0; i < size; i = i + 1) begin
			for (j = 0; j < size; j = j + 1) begin
				sum <= sum + inp[i][j];		
			end
		end	
		out <= sum / tile;
	end
end

endmodule
