module dataflow
(
	clk,
	reset,
	mode,
	in,
	out
);

parameter IL = 4, FL = 16;
parameter lane = 128;

input clk, reset;
input mode;
input signed [IL+FL-1:0] in [lane-1:0][15:0];
output logic signed [IL+FL-1:0] out [lane-1:0][15:0];

logic signed [IL+FL-1:0] reg_in [lane-1:0][15:0];

int j,k;
always_ff @(posedge clk) begin
	for (j = 0; j < lane; j++) begin
		for (k = 0; k < 16; k++) begin
			if (reset) begin
				reg_in[j][k] <= 0;
			end
			else begin
				reg_in[j][k] <= in[j][k];
			end
		end
	end
end

always_ff @(posedge clk) begin
	if (!mode) begin
		int i;
		for (i = 0; i < lane; i++) begin
			out[i] <= reg_in[0];	
		end
	end
	else begin
		out <= reg_in;
	end
end

endmodule
