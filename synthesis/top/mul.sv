module mul
(
	clk,	//i
	reset,	//i
	i,	//i
	w,	//i
	f	//o
);

parameter IL = 4, FL = 16;

input clk, reset;
input signed [IL+FL-1:0] i, w;
output logic signed [(IL+FL)*2-1:0] f;

always_comb begin
	f = i * w;
end

endmodule
