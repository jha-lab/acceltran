module PE
(
	clk,
	reset,
	input_ready,
	output_taken,
	mode,
	in,
	w,
	i_mask,
	w_mask,
	rd_en,
	wr_en,
	pre_sparsity_output_taken,
	post_sparsity_im,
	post_sparsity_input_ready,
	forward_batch,
	forward_num,
	forward_gamma,
	forward_beta,
	forward_input_ready,
	forward_output_taken,
	backward_dout,
	backward_num,
	backward_batch,
	backward_norm,
	backward_mu,
	backward_vari,
	backward_gamma,
	backward_input_ready,
	backward_output_taken,
	post_sparsity_o_im,
	backward_dX,
	backward_dgamma,
	backward_dbeta,
	forward_out,
	forward_norm,
	forward_mu,
	forward_vari,
	scalar_mode,
	scalar_input_ready,
	scalar_output_taken,
	scalar_in1,
	scalar_in2,
	loss_model,
	loss_num,
	loss_yHat,
	loss_y,
	loss_input_ready,
	loss_output_taken,
	loss_out,
	scalar_out,
	pooling_im,
	pooling_input_ready,
	pooling_output_taken,
	pooling_mode,
	pooling_om,
    global_avg_pooling_im,
    global_avg_pooling_en,
    global_avg_pooling_size,
    global_avg_pooling_input_ready,
    global_avg_pooling_om,
    global_avg_pooling_done
);

parameter IL = 4, FL = 16;
parameter row = 4, col = 4;
parameter length = 32;
parameter p_length = $clog2(length);
parameter size = 16;
parameter width = $clog2(size);
parameter pooling_size = 4;
parameter pooling_width = $clog2(pooling_size);
parameter number = 512;
parameter FIFO_DEPTH = 32;
parameter IN_BUS_WIDTH = IL + FL;
parameter FIFO_CNT_WIDTH = $clog2(FIFO_DEPTH);

input clk;
input reset;
input input_ready;
input output_taken;
input mode;
input signed [IL+FL-1:0] in [number-1:0][row-1:0][col-1:0];
input signed [IL+FL-1:0] w [number-1:0][row-1:0][col-1:0];
input [length-1:0] i_mask [number-1:0];
input [length-1:0] w_mask [number-1:0];
input rd_en;
input wr_en;
input pre_sparsity_output_taken [number-1:0];
input signed [IL+FL-1:0] post_sparsity_im [number-1:0][size-1:0];
input post_sparsity_input_ready [number-1:0];
input signed [IL+FL-1:0] forward_batch [number-1:0][size-1:0];
input [4:0] forward_num [number-1:0];
input signed [IL+FL-1:0] forward_gamma [number-1:0];
input signed [IL+FL-1:0] forward_beta [number-1:0];
input forward_input_ready [number-1:0];
input forward_output_taken [number-1:0];
input signed [IL+FL-1:0] backward_dout [number-1:0][size-1:0];
input [4:0] backward_num [number-1:0];
input signed [IL+FL-1:0] backward_batch [number-1:0][size-1:0];
input signed [IL+FL-1:0] backward_norm [number-1:0][size-1:0];
input signed [IL+FL-1:0] backward_mu [number-1:0];
input signed [IL+FL-1:0] backward_vari [number-1:0];
input signed [IL+FL-1:0] backward_gamma [number-1:0];
input backward_input_ready [number-1:0];
input backward_output_taken [number-1:0];

input [1:0] scalar_mode;
input scalar_input_ready [number-1:0];
input scalar_output_taken [number-1:0];
input signed [IL+FL-1:0] scalar_in1 [number-1:0][size-1:0];
input signed [IL+FL-1:0] scalar_in2 [number-1:0][size-1:0];

input loss_model;
input [width-1:0] loss_num [number-1:0];
input signed [IL+FL-1:0] loss_yHat [number-1:0][size-1:0];
input signed [IL+FL-1:0] loss_y [number-1:0][size-1:0];
input loss_input_ready [number-1:0];
input loss_output_taken [number-1:0];

input signed [IL+FL-1:0] pooling_im [number-1:0][pooling_size-1:0];
input pooling_input_ready [number-1:0];
input pooling_output_taken [number-1:0];
input [1:0] pooling_mode;

input signed [IL+FL-1:0] global_avg_pooling_im [number-1:0]
input global_avg_pooling_en
input [IL+FL-1:0] global_avg_pooling_size [number-1:0]
input global_avg_pooling_input_ready [number-1:0]

output logic signed [IL+FL-1:0] pooling_om [number-1:0];
output logic signed [IL+FL-1:0] loss_out [number-1:0];
output logic signed [IL+FL-1:0] scalar_out [number-1:0][size-1:0];

output logic signed [IL+FL-1:0] backward_dX [number-1:0];
output logic signed [IL+FL-1:0] backward_dgamma [number-1:0];
output logic signed [IL+FL-1:0] backward_dbeta [number-1:0];

output logic signed [IL+FL-1:0] forward_out [number-1:0][size-1:0];
output logic signed [IL+FL-1:0] forward_norm [number-1:0][size-1:0];
output logic signed [IL+FL-1:0] forward_mu [number-1:0];
output logic signed [IL+FL-1:0] forward_vari [number-1:0];

output logic [IL+FL-1:0] post_sparsity_o_im [number-1:0][size-1:0];

logic [1:0] transposer_state [number-1:0];
logic transposer_output_taken [number-1:0];
logic signed [IL+FL-1:0] transposer_out [number-1:0][col-1:0][row-1:0];

logic signed [IL+FL-1:0] pre_sparsity_in [number-1:0][col-1:0][row-1:0];
logic [1:0] pre_sparsity_state [number-1:0];
logic pre_sparsity_input_ready [number-1:0];
logic pre_sparsity_input_taken [number-1:0];
logic signed [IL+FL-1:0] pre_sparsity_out [number-1:0][size-1:0];
logic signed [IL+FL-1:0] pre_sparsity_w [number-1:0][size-1:0];
logic [length-1:0] pre_sparsity_o_mask [number-1:0];

logic fifo_i_empty [number-1:0][size-1:0];
logic fifo_i_full [number-1:0][size-1:0];
logic signed [IL+FL-1:0] fifo_i_out [number-1:0][size-1:0];
logic fifo_w_empty [number-1:0][size-1:0];
logic fifo_w_full [number-1:0][size-1:0];
logic signed [IL+FL-1:0] fifo_w_out [number-1:0][size-1:0];

logic signed [IL+FL-1:0] mac_out [number-1:0];

logic post_sparsity_output_taken [number-1:0];
logic [length-1:0] post_sparsity_o_mask [number-1:0];
logic [1:0] post_sparsity_state [number-1:0];

logic [1:0] forward_state [number-1:0];
logic [1:0] backward_state [number-1:0];

logic [1:0] scalar_state [number-1:0];

logic [1:0] loss_state [number-1:0];
logic [1:0] pooling_state [number-1:0];

genvar i;
generate
for (i = 0; i < number; i++) begin : Lane

always_comb begin
	if (pre_sparsity_state[i] == 2'b01) begin
		transposer_output_taken[i] = 1;
	end
	else begin
		transposer_output_taken[i] = 0;
	end
end

transposer	#(.IL(IL), .FL(FL), .row(row), .col(col))	transposer_0
(
        .clk		(clk),
        .reset		(reset),
        .input_ready	(input_ready),
        .output_taken	(transposer_output_taken[i]),
        .state		(transposer_state[i]),
        .in		(in[i]),
        .out		(transposer_out[i])
);

always_comb begin
	if (mode) begin
		pre_sparsity_in[i] = in[i];
		pre_sparsity_input_ready[i] = input_ready;
	end
	else begin
		pre_sparsity_in[i] = transposer_out[i];
		if (transposer_state[i] == 2'b10) begin
			pre_sparsity_input_ready[i] = 1;
		end
		else begin
			pre_sparsity_input_ready[i] = 0;
		end
	end
end



sparsity	#(.IL(IL), .FL(FL), .length(length), .p_length(p_length))	pre_sparsity_0
(
        .clk		(clk),
        .reset		(reset),
        .i_0		(pre_sparsity_in[i][0][0]),
        .i_1		(pre_sparsity_in[i][0][1]),
        .i_2		(pre_sparsity_in[i][0][2]),
        .i_3		(pre_sparsity_in[i][0][3]),
        .i_4		(pre_sparsity_in[i][1][0]),
        .i_5		(pre_sparsity_in[i][1][1]),
        .i_6		(pre_sparsity_in[i][1][2]),
        .i_7		(pre_sparsity_in[i][1][3]),
        .i_8		(pre_sparsity_in[i][2][0]),
        .i_9		(pre_sparsity_in[i][2][1]),
        .i_10		(pre_sparsity_in[i][2][2]),
        .i_11		(pre_sparsity_in[i][2][3]),
        .i_12		(pre_sparsity_in[i][3][0]),
        .i_13		(pre_sparsity_in[i][3][1]),
        .i_14		(pre_sparsity_in[i][3][2]),
        .i_15		(pre_sparsity_in[i][3][3]),
        .w_0		(w[i][0][0]),
        .w_1		(w[i][0][1]),
        .w_2		(w[i][0][2]),
        .w_3		(w[i][0][3]),
        .w_4		(w[i][1][0]),
        .w_5		(w[i][1][1]),
        .w_6		(w[i][1][2]),
        .w_7		(w[i][1][3]),
        .w_8		(w[i][2][0]),
        .w_9		(w[i][2][1]),
        .w_10		(w[i][2][2]),
        .w_11		(w[i][2][3]),
        .w_12		(w[i][3][0]),
        .w_13		(w[i][3][1]),
        .w_14		(w[i][3][2]),
        .w_15		(w[i][3][3]),
        .i_mask		(i_mask[i]),
        .w_mask		(w_mask[i]),
        .input_ready	(pre_sparsity_input_ready[i]),
        .output_taken	(pre_sparsity_output_taken[i]),
        .oi_0		(pre_sparsity_out[i][0]),
        .oi_1		(pre_sparsity_out[i][1]),
        .oi_2		(pre_sparsity_out[i][2]),
        .oi_3		(pre_sparsity_out[i][3]),
        .oi_4		(pre_sparsity_out[i][4]),
        .oi_5		(pre_sparsity_out[i][5]),
        .oi_6		(pre_sparsity_out[i][6]),
        .oi_7		(pre_sparsity_out[i][7]),
        .oi_8		(pre_sparsity_out[i][8]),
        .oi_9		(pre_sparsity_out[i][9]),
        .oi_10		(pre_sparsity_out[i][10]),
        .oi_11		(pre_sparsity_out[i][11]),
        .oi_12		(pre_sparsity_out[i][12]),
        .oi_13		(pre_sparsity_out[i][13]),
        .oi_14		(pre_sparsity_out[i][14]),
        .oi_15		(pre_sparsity_out[i][15]),
        .ow_0		(pre_sparsity_w[i][0]),
        .ow_1		(pre_sparsity_w[i][1]),
        .ow_2		(pre_sparsity_w[i][2]),
        .ow_3		(pre_sparsity_w[i][3]),
        .ow_4		(pre_sparsity_w[i][4]),
        .ow_5		(pre_sparsity_w[i][5]),
        .ow_6		(pre_sparsity_w[i][6]),
        .ow_7		(pre_sparsity_w[i][7]),
        .ow_8		(pre_sparsity_w[i][8]),
        .ow_9		(pre_sparsity_w[i][9]),
        .ow_10		(pre_sparsity_w[i][10]),
        .ow_11		(pre_sparsity_w[i][11]),
        .ow_12		(pre_sparsity_w[i][12]),
        .ow_13		(pre_sparsity_w[i][13]),
        .ow_14		(pre_sparsity_w[i][14]),
        .ow_15		(pre_sparsity_w[i][15]),
        .o_mask		(pre_sparsity_o_mask[i]),
        .state		(pre_sparsity_state[i]),
        .input_taken	(pre_sparsity_input_taken[i])
);


fifo	#(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))	fifo_i_0
(
    .clk	(clk),
    .reset	(reset),
    .data_in	(pre_sparsity_out[i][0]),
    .rd_en	(rd_en),
    .wr_en	(wr_en),
    .empty	(fifo_i_empty[i][0]),
    .full	(fifo_i_full[i][0]),
    .data_out	(fifo_i_out[i][0])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_i_1
(   
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_out[i][1]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_i_empty[i][1]),
    .full       (fifo_i_full[i][1]),
    .data_out   (fifo_i_out[i][1])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_i_2
(       
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_out[i][2]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_i_empty[i][2]),
    .full       (fifo_i_full[i][2]),
    .data_out   (fifo_i_out[i][2])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_i_3
(       
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_out[i][3]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_i_empty[i][3]),
    .full       (fifo_i_full[i][3]),
    .data_out   (fifo_i_out[i][3])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_i_4
(       
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_out[i][4]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_i_empty[i][4]),
    .full       (fifo_i_full[i][4]),
    .data_out   (fifo_i_out[i][4])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_i_5
(       
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_out[i][5]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_i_empty[i][5]),
    .full       (fifo_i_full[i][5]),
    .data_out   (fifo_i_out[i][5])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_i_6
(       
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_out[i][6]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_i_empty[i][6]),
    .full       (fifo_i_full[i][6]),
    .data_out   (fifo_i_out[i][6])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_i_7
(       
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_out[i][7]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_i_empty[i][7]),
    .full       (fifo_i_full[i][7]),
    .data_out   (fifo_i_out[i][7])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_i_8
(       
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_out[i][8]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_i_empty[i][8]),
    .full       (fifo_i_full[i][8]),
    .data_out   (fifo_i_out[i][8])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_i_9
(       
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_out[i][9]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_i_empty[i][9]),
    .full       (fifo_i_full[i][9]),
    .data_out   (fifo_i_out[i][9])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_i_10
(       
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_out[i][10]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_i_empty[i][10]),
    .full       (fifo_i_full[i][10]),
    .data_out   (fifo_i_out[i][10])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_i_11
(       
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_out[i][11]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_i_empty[i][11]),
    .full       (fifo_i_full[i][11]),
    .data_out   (fifo_i_out[i][11])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_i_12
(       
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_out[i][12]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_i_empty[i][12]),
    .full       (fifo_i_full[i][12]),
    .data_out   (fifo_i_out[i][12])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_i_13
(       
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_out[i][13]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_i_empty[i][13]),
    .full       (fifo_i_full[i][13]),
    .data_out   (fifo_i_out[i][13])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_i_14
(       
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_out[i][14]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_i_empty[i][14]),
    .full       (fifo_i_full[i][14]),
    .data_out   (fifo_i_out[i][14])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_i_15
(       
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_out[i][15]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_i_empty[i][15]),
    .full       (fifo_i_full[i][15]),
    .data_out   (fifo_i_out[i][15])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_w_0
(
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_w[i][0]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_w_empty[i][0]),
    .full       (fifo_w_full[i][0]),
    .data_out   (fifo_w_out[i][0])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_w_1
(
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_w[i][1]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_w_empty[i][1]),
    .full       (fifo_w_full[i][1]),
    .data_out   (fifo_w_out[i][1])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_w_2
(
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_w[i][2]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_w_empty[i][2]),
    .full       (fifo_w_full[i][2]),
    .data_out   (fifo_w_out[i][2])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_w_3
(
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_w[i][3]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_w_empty[i][3]),
    .full       (fifo_w_full[i][3]),
    .data_out   (fifo_w_out[i][3])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_w_4
(
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_w[i][4]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_w_empty[i][4]),
    .full       (fifo_w_full[i][4]),
    .data_out   (fifo_w_out[i][4])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_w_5
(
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_w[i][5]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_w_empty[i][5]),
    .full       (fifo_w_full[i][5]),
    .data_out   (fifo_w_out[i][5])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_w_6
(
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_w[i][6]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_w_empty[i][6]),
    .full       (fifo_w_full[i][6]),
    .data_out   (fifo_w_out[i][6])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_w_7
(
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_w[i][7]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_w_empty[i][7]),
    .full       (fifo_w_full[i][7]),
    .data_out   (fifo_w_out[i][7])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_w_8
(
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_w[i][8]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_w_empty[i][8]),
    .full       (fifo_w_full[i][8]),
    .data_out   (fifo_w_out[i][8])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_w_9
(
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_w[i][9]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_w_empty[i][9]),
    .full       (fifo_w_full[i][9]),
    .data_out   (fifo_w_out[i][9])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_w_10
(
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_w[i][10]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_w_empty[i][10]),
    .full       (fifo_w_full[i][10]),
    .data_out   (fifo_w_out[i][10])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_w_11
(
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_w[i][11]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_w_empty[i][11]),
    .full       (fifo_w_full[i][11]),
    .data_out   (fifo_w_out[i][11])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_w_12
(
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_w[i][12]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_w_empty[i][12]),
    .full       (fifo_w_full[i][12]),
    .data_out   (fifo_w_out[i][12])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_w_13
(
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_w[i][13]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_w_empty[i][13]),
    .full       (fifo_w_full[i][13]),
    .data_out   (fifo_w_out[i][13])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_w_14
(
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_w[i][14]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_w_empty[i][14]),
    .full       (fifo_w_full[i][14]),
    .data_out   (fifo_w_out[i][14])
);

fifo    #(.IL(IL), .FL(FL), .FIFO_DEPTH(FIFO_DEPTH), .IN_BUS_WIDTH(IN_BUS_WIDTH), .FIFO_CNT_WIDTH(FIFO_CNT_WIDTH))      fifo_w_15
(
    .clk        (clk),
    .reset      (reset),
    .data_in    (pre_sparsity_w[i][15]),
    .rd_en      (rd_en),
    .wr_en      (wr_en),
    .empty      (fifo_w_empty[i][15]),
    .full       (fifo_w_full[i][15]),
    .data_out   (fifo_w_out[i][15])
);




mac_lane #(.IL(IL), .FL(FL))		mac_lane_0
(
        .clk		(clk),
        .reset		(reset),
        .i_0		(fifo_i_out[i][0]),
        .i_1		(fifo_i_out[i][1]),
        .i_2		(fifo_i_out[i][2]),
        .i_3		(fifo_i_out[i][3]),
        .i_4		(fifo_i_out[i][4]),
        .i_5		(fifo_i_out[i][5]),
        .i_6		(fifo_i_out[i][6]),
        .i_7		(fifo_i_out[i][7]),
        .i_8		(fifo_i_out[i][8]),
        .i_9		(fifo_i_out[i][9]),
        .i_10		(fifo_i_out[i][10]),
        .i_11		(fifo_i_out[i][11]),
        .i_12		(fifo_i_out[i][12]),
        .i_13		(fifo_i_out[i][13]),
        .i_14		(fifo_i_out[i][14]),
        .i_15		(fifo_i_out[i][15]),
        .w_0		(fifo_w_out[i][0]),
        .w_1		(fifo_w_out[i][1]),
        .w_2		(fifo_w_out[i][2]),
        .w_3		(fifo_w_out[i][3]),
        .w_4		(fifo_w_out[i][4]),
        .w_5		(fifo_w_out[i][5]),
        .w_6		(fifo_w_out[i][6]),
        .w_7		(fifo_w_out[i][7]),
        .w_8		(fifo_w_out[i][8]),
        .w_9		(fifo_w_out[i][9]),
        .w_10		(fifo_w_out[i][10]),
        .w_11		(fifo_w_out[i][11]),
        .w_12		(fifo_w_out[i][12]),
        .w_13		(fifo_w_out[i][13]),
        .w_14		(fifo_w_out[i][14]),
        .w_15		(fifo_w_out[i][15]),
        .f		(mac_out[i])
);


post_sparsity	#(.IL(IL), .FL(FL), .length(length), .p_length(p_length))	post_sparsity_0
(
        .clk		(clk),
        .reset		(reset),
        .i_im		(post_sparsity_im[i]),
        .i_mask		(pre_sparsity_o_mask[i]),
        .input_ready	(post_sparsity_input_ready[i]),
        .output_taken	(post_sparsity_output_taken[i]),
        .o_im		(post_sparsity_o_im[i]),
        .o_mask		(post_sparsity_o_mask[i]),
        .state		(post_sparsity_state[i])
);


forward  #(.IL(IL), .FL(FL), .size(size), .width(width))	forward_batch_normalization_0
(
        .clk		(clk),
        .reset		(reset),
        .batch		(forward_batch[i]),
        .num		(forward_num[i]),
        .gamma		(forward_gamma[i]),
        .beta		(forward_beta[i]),
        .input_ready	(forward_input_ready[i]),
        .output_taken	(forward_output_taken[i]),
        .out		(forward_out[i]),
        .norm		(forward_norm[i]),
        .mu		(forward_mu[i]),
        .vari		(forward_vari[i]),
        .state		(forward_state[i]),
        .done		()
);


backward  #(.IL(IL), .FL(FL), .size(size), .width(width))	backward_batch_normalization_0
(
        .clk		(clk),
        .reset		(reset),
        .dout		(backward_dout[i]),
        .num		(backward_num[i]),
        .batch		(backward_batch[i]),
        .norm		(backward_norm[i]),
        .mu		(backward_mu[i]),
        .vari		(backward_vari[i]),
        .gamma		(backward_gamma[i]),
        .input_ready	(backward_input_ready[i]),
        .output_taken	(backward_output_taken[i]),
        .dX		(backward_dX[i]),
        .dgamma		(backward_dgamma[i]),
        .dbeta		(backward_dbeta[i]),
        .state		(backward_state[i]),
        .done		()
);


pooling  #(.IL(IL), .FL(FL), .size(pooling_size), .width(pooling_width))	pooling_0
(
        .clk		(clk),
        .reset		(reset),
        .im		(pooling_im[i]),
        .input_ready	(pooling_input_ready[i]),
        .output_taken	(pooling_output_taken[i]),
        .mode		(pooling_mode),
        .om		(pooling_om[i]),
        .state		(pooling_state[i])
);

global_avg_pooling  #(.IL(IL), .FL(FL))	global_avg_pooling_0
(
        .clk		    (clk),
        .im		        (global_avg_pooling_im[i]),
        .en             (global_avg_pooling_en),
        .size           (global_avg_pooling_size[i]),
        .input_ready	(global_avg_pooling_input_ready[i]),
        .om		        (global_avg_pooling_om[i]),
        .done		    (global_avg_pooling_done[i])
);

scalar  #(.IL(IL), .FL(FL), .size(size), .width(width))		scalar_0
(
        .clk		(clk),
        .reset		(reset),
        .mode		(scalar_mode),
        .state		(scalar_state[i]),
        .input_ready	(scalar_input_ready[i]),
        .output_taken	(scalar_output_taken[i]),
        .in1		(scalar_in1[i]),
        .in2		(scalar_in2[i]),
        .out		(scalar_out[i])
);



loss  #(.IL(IL), .FL(FL), .size(size), .width(width))	loss_0
(
        .clk		(clk),
        .reset		(reset),
        .model		(loss_model),
        .yHat		(loss_yHat[i]),
        .y		(loss_y[i]),
        .num		(loss_num[i]),
        .input_ready	(loss_input_ready[i]),
        .output_taken	(loss_output_taken[i]),
        .state		(loss_state[i]),
        .out		(loss_out[i])
);

end
endgenerate
endmodule
