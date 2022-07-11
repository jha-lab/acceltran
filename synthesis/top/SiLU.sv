module SiLU
(
    n_en,       //i
	clk,		//i
	reset,		//i
	i,		    //i
	f		    //o
);

parameter IL = 4, FL = 16;

input n_en, clk, reset;
input signed [IL+FL-1:0] i;
output logic signed [IL+FL-1:0] f;

reg signed [IL+FL-1:0] y, z, sum;
reg signed [2*(IL+FL-1)+1:0] sq,sh;

always_comb begin
    if (n_en == 0) begin
    	if(i[IL+FL-1]==1'b1) begin
	    	y=-i;
        end
	    else begin
		    y=i;
        end

	    z=y>>>2;
	    sum = z+20'b1111111111_0000000000;
    	sq = sum*sum;
    	sh = sq>>>1;

	    if(i[IL+FL-1]==1'b1) begin
		    f = sh;
		    f = f*i;
        end
    	else begin
	    	f = 40'b00000000000000000001_00000000000000000000-sh;
		    f = f*i;
        end
    end
end

endmodule
