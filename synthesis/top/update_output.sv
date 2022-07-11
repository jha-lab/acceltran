module update_output
(
	clk,
	reset,
	i_im,
	input_ready,
	output_taken,
	o_im,
	state
);

parameter IL = 4, FL = 16;

input clk, reset;
input signed [IL+FL-1:0] i_im [15:0];
input input_ready;
input output_taken;

output logic signed [IL+FL-1:0] o_im [15:0];
output logic [1:0] state;

logic signed [IL+FL-1:0] reg_i_im [15:0];
logic signed [IL+FL-1:0] pre_o_im [15:0];
logic done;
logic [3:0] i_pointer;
logic [3:0] o_pointer;
logic increment;


integer i,j;

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
		for (i = 0; i < 16; i = i + 1) begin
			reg_i_im[i] <= {(IL+FL){1'b0}};
		end	
	end
	else begin
		if (state == 2'b00 && input_ready == 1) begin
			reg_i_im <= i_im;
		end
	end
end

always_ff @(posedge clk) begin
	if (reset == 1 || (state == 2'b00 && input_ready == 1)) begin
		i_pointer <= 4'b0000;
		o_pointer <= 4'b0000;
	end
	else begin
		if (state == 2'b01) begin
			i_pointer <= i_pointer + 1;
			if (increment == 1) begin
				o_pointer <= o_pointer + 1;
			end
		end
	end
end

always_ff @(posedge clk) begin
	if (reset == 1 || (state == 2'b00 && input_ready == 1)) begin
		for (j = 0; j < 16; j = j + 1) begin
			o_im[j] <= {(IL+FL){1'b0}};
		end
	end
	else begin
		if (state == 2'b01) begin
			if (i_im[i_pointer] != 0) begin
				o_im[o_pointer] <= pre_o_im[o_pointer];
			end
		end
	end
end

always_comb begin
	if (state == 2'b01) begin
		if (i_im[i_pointer] == 0) begin
			increment = 0;
		end
		else begin
			pre_o_im[o_pointer] = i_im[i_pointer];
			increment = 1;
		end
	end
end

always_comb begin
	done = (i_pointer == 15) ? 1 : 0;
end

endmodule
