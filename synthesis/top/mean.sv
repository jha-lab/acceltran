module mean
(
	start,
	batch,
	num,
	out
);

parameter IL = 4, FL = 16;
parameter size = 16;

input start;
input signed [IL+FL-1:0] batch [size-1:0];
input [3:0] num;

output logic signed [IL+FL-1:0] out;

logic signed [(IL+FL)*2-1:0] sum;
integer i;

always_comb begin
	if (start) begin
		sum = 0;
	end
	else begin
		for (i = 0; i < num; i = i + 1) begin
			sum = sum + batch[i];		
		end	
		out = sum / num;
	end
end

endmodule
