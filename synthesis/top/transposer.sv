module transposer
(
	clk,
	reset,
	input_ready,
	output_taken,
	state,
	in,
	out
);

parameter IL = 4, FL = 16;
parameter row = 4, col = 4;

input clk, reset;
input input_ready;
input output_taken;

input signed [IL+FL-1:0] in [row-1:0][col-1:0];

output logic [1:0] state;
output logic signed [IL+FL-1:0] out [col-1:0][row-1:0];

logic signed [IL+FL-1:0] reg_in [row-1:0][col-1:0];
logic signed [IL+FL-1:0] reg_out [col-1:0][row-1:0];
logic done;

always_ff @(posedge clk) begin
	if (reset) begin
		state <= 2'b00;
	end
	else begin
		if (state == 2'b00 && input_ready) begin
			state <= 2'b01;
		end
		if (state == 2'b01 && done) begin
			state <= 2'b10;
		end
		if (state == 2'b10 && output_taken) begin
			state <= 2'b00;
		end
	end
end

int p,q;
always_ff @(posedge clk) begin
	if (reset || (state == 2'b10 && output_taken)) begin
		for (p = 0; p < row; p++) begin
			for (q = 0; q < col; q++) begin
				reg_in[p][q] <= 0;
			end
		end	
	end
	else if (state == 2'b00 && input_ready) begin
		reg_in <= in;
	end
end

int i, j;
always_comb begin
	if (state == 2'b01) begin
		for (i = 0; i < row; i++) begin
			for (j = 0; j < col; j++) begin
				reg_out[j][i] = reg_in[i][j];
			end
		end	
	end
end

int l,m;
always_ff @(posedge clk) begin
	if (reset || (state == 2'b10 && output_taken)) begin
		for (l = 0; l < row; l++) begin
			for (m = 0; m < col; m++) begin
				out[l][m] <= 0;
			end
		end	
	end
	else if (state == 2'b01 && done) begin
		out <= reg_out;
	end
end

always_comb begin
	if (state == 2'b01) begin
		done = 1;
	end
	else begin
		done = 0;
	end
end

endmodule
