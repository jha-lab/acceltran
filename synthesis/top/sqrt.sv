module sqrt
(
	clk,
	reset,
	in,
	input_ready,
	output_taken,
	out,
	state,
	done
);

parameter IL = 4, FL = 16;

input clk, reset;
input [IL+FL-1:0] in;
input input_ready;
input output_taken;

output logic [IL+FL-1:0] out;
output logic [1:0] state;
output logic done;

logic [(IL+FL)*2-1:0] reg_in;
logic [(IL+FL)*2-1:0] Y;
logic [(IL+FL)*2-1:0] P;
logic [5:0] index;

always_ff @(posedge clk) begin
	if (reset) begin
		state <= 2'b00;
	end
	else begin
		if (state == 2'b00 && input_ready == 1) begin
			state <= 2'b01;
		end
		if (state == 2'b01 && done == 1) begin
			state <= 2'b10;
		end
		if (state == 2'b10 && output_taken == 1) begin
			state <= 2'b00;
		end
	end
end

always_ff @(posedge clk) begin
	if (reset || (state == 2'b10 && output_taken == 1)) begin
		reg_in <= 0;
	end
	else begin
		if (state == 2'b00 && input_ready == 1) begin
			reg_in[IL+FL-1:0] <= in;
		end
		if (state == 2'b01 && Y <= reg_in) begin
			reg_in <= reg_in - Y;
		end
	end
end

always_ff @(posedge clk) begin
	if (reset || (state == 2'b10 && output_taken == 1)) begin
		index <= IL + FL - 1;
	end
	else begin
		if (state == 2'b01) begin
			index <= index - 1;
		end
	end
end

always_comb begin
	done = (index < (IL + FL)) ? 0 : 1;
end

always_comb begin
	if (reset || (state == 2'b10 && output_taken == 1)) begin
		Y = 0;
		P = 0;
		out = 0;
	end
	else begin
		if (state == 2'b01) begin
			Y = (P <<< (index+1)) + (1 <<< (index+index));
			if (Y <= reg_in) begin
                                P = 1 <<< index;
                                out[index] = 1;
                        end
                        else begin
                                out[index] = 0;
                        end

		end
	end
end

endmodule
