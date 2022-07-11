module mean_pooling
(
	clk,
	im,
	en,
	input_ready,
	om,
	done
);

parameter IL = 4, FL = 16;
parameter size = 4;
parameter width = $clog2(size);

input clk;
input [IL+FL-1:0] im [size-1:0];
input en;
input input_ready;

output logic [IL+FL-1:0] om;
output logic done;

logic [IL+FL-1:0] sum;
logic [width-1:0] pointer;

always_ff @(posedge clk) begin
	if (en == 1) begin
		if (input_ready == 1) begin
			om <= {(IL+FL){1'b0}};
			pointer <= 0;
		end
		else begin
			pointer <= pointer + 1;
			if (done == 1) begin
				om <= sum / size;
			end
		end
	end
end

always_comb begin
	if (en == 1) begin
		if (input_ready == 1) begin
			sum = 0;
		end
		else begin
			sum = sum + im[pointer];
		end
		done = (pointer == {(width){1'b1}}) ? 1 : 0;
	end
end

endmodule
