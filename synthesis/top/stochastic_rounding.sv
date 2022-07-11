module stochastic_rounding
(
	clk,		//i
	reset,		//i
	i,		//i
	f		//o
);

parameter IL = 4, FL = 16;

input clk, reset;
input signed [4+(IL+FL)*2-1:0] i;
output logic signed [IL+FL-1:0] f;

logic signed [4+(IL+FL)*2-1:0] bottom, upper;
logic signed [IL+FL-1:0] r_bottom, r_upper, round;
logic [15:0] random;

always_comb begin
//	bottom = -{{(4+IL){1'b0}}, 1'b1, {(IL-1+FL*2){1'b0}}};
//	r_bottom = -{1'b1,  {(IL-1+FL){1'b0}}};
//	upper = {{(4+IL){1'b0}}, 1'b1, {(IL-1+FL*2){1'b0}}} - {{(4+IL*2+FL-1){1'b0}}, 1'b1, {(FL){1'b0}}};
//	r_upper = {1'b1, {(IL-1+FL){1'b0}}} - {{(IL+FL-1){1'b0}}, 1'b1};	
	bottom = {{(5+IL){1'b1}}, {(IL-1+FL*2){1'b0}}};
	r_bottom = {1'b1, {(IL+FL-1){1'b0}}};
	upper = {{(5+IL){1'b0}}, {(IL+FL-1){1'b1}}, {(FL){1'b0}}};
	r_upper = {1'b0, {(IL+FL-1){1'b1}}};
end

LFSR lfsr
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.data		(random)	//o
);

always_comb begin
	round = (i[4+(IL+FL)*2-1] == 0) ? ((random[FL-1:0] >= i[FL-1:0]) ? {1'b0, i[IL+FL*2-2:FL]} : {1'b0, i[IL+FL*2-2:FL] + 1})
					: ((random[FL-1:0] >= (~i[FL-1:0]+1)) ? {1'b1, i[IL+FL*2-2:FL]} : {1'b1, i[IL+FL*2-2:FL] - 1});
end

always_comb begin
	f = (i <= bottom) ? r_bottom :
	    ((i >= upper) ? r_upper : round);
end

endmodule
