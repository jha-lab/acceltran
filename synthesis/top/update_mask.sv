module update_mask
(
	clk,
	reset,
	i_mask,
	out,
	input_ready,
	output_taken,
	o_mask,
	state
); 

parameter IL = 4, FL = 16;
parameter length = 32;
parameter p_length = $clog2(length);

input clk, reset;
input [length-1:0] i_mask;
input signed [IL+FL-1:0] out [15:0];
input input_ready;
input output_taken;

output logic [length-1:0] o_mask;
output logic [1:0] state;

logic [length-1:0] reg_i_mask;
logic signed [IL+FL-1:0] reg_out [15:0];
logic done;
logic [p_length-1:0] m_pointer;
logic [3:0] o_pointer;
logic increment;

integer i, j;

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
		if (state == 2'b10 && output_taken == 1) begin
			state <= 2'b00;
		end
	end
end

always_ff @(posedge clk) begin
	if (reset == 1) begin
		reg_i_mask <= {(length){1'b0}};
		for (i = 0; i < 16; i = i + 1) begin
			reg_out[i] = {(IL+FL){1'b0}};
		end
	end
	else begin
		if (state == 2'b00 && input_ready == 1) begin
			reg_i_mask <= i_mask;
			reg_out[15:0] = out[15:0];
		end
	end
end

always_ff @(posedge clk) begin
	if (reset == 1 || (state == 2'b00 && input_ready == 1)) begin
		m_pointer <= {(p_length){1'b0}};
		o_pointer <= 4'b0000;
	end
	else begin
		if (state == 2'b01) begin
			m_pointer <= m_pointer + 1;
			if (increment == 1) begin
				o_pointer <= o_pointer + 1;
			end
		end
	end
end

always_comb begin
	if (reset == 1 || (state == 2'b10 && output_taken == 1)) begin
		for (j = 0; j < length; j = j + 1) begin
			o_mask[j] = 0;
		end
	end
	else begin
		if (state == 2'b01) begin
			if (reg_i_mask[m_pointer] == 1) begin
				if (reg_out[o_pointer] == 0) begin
					o_mask[m_pointer] = 0;
				end
				else begin
					o_mask[m_pointer] = 1;
				end
				increment = 1;
			end 
			else begin
				o_mask[m_pointer] = reg_i_mask[m_pointer];
				increment = 0;
			end
		end
	end
end

always_comb begin
	done = (m_pointer == {(p_length){1'b1}}) ? 1 : 0; 
end

endmodule
