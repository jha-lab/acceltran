module min_pooling
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

logic [IL+FL-1:0] min_num;
logic [width-1:0] pointer;

always_ff @(posedge clk) begin
	if (en == 1) begin
		if (input_ready == 1) begin
			om <= im[0];
			pointer <= 0;
		end
		else begin
			om <= min_num;
			pointer <= pointer + 1;
		end
	end
end

always_comb begin
	if (en == 1) begin
		min_num = (im[pointer] < om) ? im[pointer] : om;
		done = (pointer == {(width){1'b1}}) ? 1 : 0;
	end
end

endmodule
