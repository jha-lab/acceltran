module upsample
(
	clk,
	im,
	k, // upsampling ratio
	en,
	input_ready,
	om,
	done
);

parameter IL = 4, FL = 16;
parameter size = 4;
parameter width = $clog2(size);
parameter ratio = $clog2(k);

input clk;
input [IL+FL-1:0] im [size-1:0];
input [IL+FL-1:0] k;
input en;
input input_ready;

output logic [IL+FL-1:0] om [ratio*size-1:0];
output logic done;

logic [IL+FL-1:0] interp;
logic [width-1:0] pointer1;
logic [ratio*width-1:0] pointer2;
logic next;

always_ff @(posedge clk) begin
	if (en == 1) begin
		if (input_ready == 1) begin
			pointer1 <= 0;
			pointer2 <= 0;
		end
		else begin
			pointer2 <= pointer2 + 1;
			if (next == 1) begin
				pointer1 <= pointer1 + 1;
			end
		end
	end
end

always_comb begin
	if (en == 1) begin
		if (input_ready == 1) begin
			interp = 0;
		end
		else begin
			pointer_prev = pointer2 - pointer2 % ratio;
			interp = om[pointer_prev] + (pointer2 - pointer_prev) / ratio * (im[pointer1+1] - im[pointer1]);
		end
		om[pointer2] = interp;
		next = (pointer2 % ratio == 0) ? 1 : 0;
		done = (pointer1 == {(width){1'b1}}) ? 1 : 0;
	end
end

endmodule
