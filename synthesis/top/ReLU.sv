module ReLU
(
	en,         //i
    clk,		//i
	reset,		//i
	i,		    //i
	f		    //o
);

parameter IL = 4, FL = 16;

input en, clk, reset;
input signed [IL+FL-1:0] i;
output logic signed [IL+FL-1:0] f;

always_comb begin
    if (en == 1) begin
    	f = (i[IL+FL-1] == 0) ? i : {(IL+FL){1'b0}};
    end
end

endmodule
