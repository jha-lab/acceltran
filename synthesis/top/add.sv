module add
(
	clk,	//i
	reset,	//i
	a,	//i
	b,	//i
	f	//o
);

parameter WL = 20;
input clk, reset;
input signed [WL-1:0] a, b;
output logic signed [WL:0] f;

always_comb begin
	f = a + b;
end;

endmodule
