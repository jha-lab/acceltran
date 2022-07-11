module mask
(
	clk,
	reset,
	i_mask,
	w_mask,
	input_ready,
	output_taken,
	o_mask,
	xor_i_mask,
	xor_w_mask,
	state
);

parameter length = 32;

input clk, reset;
input [length-1:0] i_mask;
input [length-1:0] w_mask;
input input_ready;
input output_taken;
output logic [length-1:0] o_mask;
output logic [length-1:0] xor_i_mask;
output logic [length-1:0] xor_w_mask;
output logic [1:0] state;

logic [length-1:0] reg_i_mask;
logic [length-1:0] reg_w_mask;
logic [length-1:0] reg_ii_mask;
logic [length-1:0] reg_ww_mask;
logic [length-1:0] out_mask;
logic [length-1:0] reg_o_mask;
logic [1:0] counter;
logic done;

always_ff @(posedge clk) begin
	if (reset == 1) begin
		state <= 2'b00;
	end
	else begin
		if (state == 2'b00 && input_ready == 1) begin
			state <= 2'b01;
		end
		if (state == 2'b01 && done == 1) begin
			state <= 2'b10;
		end
		if (state == 2'b10 && output_taken) begin
			state <= 2'b00;
		end
	end
end

always_ff @(posedge clk) begin
	if (reset == 1 || (state == 2'b10 && output_taken == 1)) begin
		reg_i_mask <= {(length){1'b0}};
		reg_w_mask <= {(length){1'b0}};
	end
	else begin
		if (state == 2'b00 && input_ready == 1) begin
			reg_i_mask <= i_mask;
			reg_w_mask <= w_mask;
		end
	end
end

always_ff @(posedge clk) begin
	if (state == 2'b00 && input_ready == 1) begin
		counter <= 2'b00;
	end
	else begin
		if (state == 2'b01) begin
			counter <= counter + 1;
		end
	end
end

always_comb begin
	done = (counter == 2'b00) ? 1 : 0;
end

always_comb begin
	out_mask = reg_i_mask & reg_w_mask;
end

always_ff @(posedge clk) begin
	if (reset == 1 || (state == 2'b10 && output_taken == 1)) begin
		reg_o_mask <= {(length){1'b0}};
	end
	else begin
		if (state == 2'b01) begin
			reg_o_mask <= out_mask;
		end
	end
end

always_ff @(posedge clk) begin
	if (reset == 1 || (state == 2'b10 && output_taken == 1)) begin 
		reg_ii_mask <= {(length){1'b0}};
		reg_ww_mask <= {(length){1'b0}};
	end
	else begin
		if (state == 2'b01) begin
			reg_ii_mask <= reg_i_mask;
			reg_ww_mask <= reg_w_mask;
		end
	end
end

always_comb begin
	xor_i_mask = reg_ii_mask ^ reg_o_mask;
	xor_w_mask = reg_ww_mask ^ reg_o_mask;
	o_mask = reg_o_mask;
end

endmodule
