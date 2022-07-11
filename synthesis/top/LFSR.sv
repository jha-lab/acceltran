module LFSR
(
	clk,		//i
	reset,		//i
	data		//o
);

input clk, reset;
output logic [15:0] data;

logic feedback;

always_comb begin
	feedback = data[15] ^ data[0];
end

always_ff @(posedge clk) begin
	if (reset == 1) begin
		data <= 16'b1111111111111111;
	end
	else begin
		data <= {data[14:1], feedback, data[15]};
	end
end

endmodule
