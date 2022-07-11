module top
(
	clk,
	reset,
	dataflow_mode,
	data_in,
	weight_in,
	im2col_start,
	im2col_idle,
	im2col_ready,
	im2col_channels,
	im2col_height,
	im2col_width,
	im2col_kernel_h,
	im2col_kernel_w,
	im2col_pad_h,
	im2col_pad_w,
	im2col_stride_h,
	im2col_stride_w,
	im2col_dilation_h,
	im2col_dilation_w,
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
	pooling_im,
	pooling_input_ready,
	pooling_output_taken,
	pooling_mode,
	pooling_om,
	loss_out,
	scalar_out,
	backward_dX,
	backward_dgamma,
	backward_dbeta,
	forward_out,
	forward_norm,
	forward_mu,
	forward_vari,
	post_sparsity_o_im,
	PE_output_taken
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
parameter tile = 4;

input clk, reset;
input dataflow_mode;
input [IL+FL-1:0] data_in [tile-1:0][number-1:0][15:0];
input [IL+FL-1:0] weight_in [tile-1:0][number-1:0][15:0];

input   im2col_start;
output   im2col_idle [tile-1:0];
output   im2col_ready [tile-1:0];
input  [31:0] im2col_channels;
input  [31:0] im2col_height;
input  [31:0] im2col_width;
input  [31:0] im2col_kernel_h;
input  [31:0] im2col_kernel_w;
input  [31:0] im2col_pad_h;
input  [31:0] im2col_pad_w;
input  [31:0] im2col_stride_h;
input  [31:0] im2col_stride_w;
input  [31:0] im2col_dilation_h;
input  [31:0] im2col_dilation_w;

input mode;
input signed [IL+FL-1:0] in [tile-1:0][number-1:0][row-1:0][col-1:0];
input signed [IL+FL-1:0] w [tile-1:0][number-1:0][row-1:0][col-1:0];
input [length-1:0] i_mask [tile-1:0][number-1:0];
input [length-1:0] w_mask [tile-1:0][number-1:0];
input rd_en;
input wr_en;
input pre_sparsity_output_taken [number-1:0];
input signed [IL+FL-1:0] post_sparsity_im [tile-1:0][number-1:0][size-1:0];
input post_sparsity_input_ready [number-1:0];
input signed [IL+FL-1:0] forward_batch [tile-1:0][number-1:0][size-1:0];
input [4:0] forward_num [tile-1:0][number-1:0];
input signed [IL+FL-1:0] forward_gamma [tile-1:0][number-1:0];
input signed [IL+FL-1:0] forward_beta [tile-1:0][number-1:0];
input forward_input_ready [number-1:0];
input forward_output_taken [number-1:0];
input signed [IL+FL-1:0] backward_dout [tile-1:0][number-1:0][size-1:0];
input [4:0] backward_num [tile-1:0][number-1:0];
input signed [IL+FL-1:0] backward_batch [tile-1:0][number-1:0][size-1:0];
input signed [IL+FL-1:0] backward_norm [tile-1:0][number-1:0][size-1:0];
input signed [IL+FL-1:0] backward_mu [tile-1:0][number-1:0];
input signed [IL+FL-1:0] backward_vari [tile-1:0][number-1:0];
input signed [IL+FL-1:0] backward_gamma [tile-1:0][number-1:0];
input backward_input_ready [number-1:0];
input backward_output_taken [number-1:0];
input [1:0] scalar_mode;
input scalar_input_ready [number-1:0];
input scalar_output_taken [number-1:0];
input signed [IL+FL-1:0] scalar_in1 [tile-1:0][number-1:0][size-1:0];
input signed [IL+FL-1:0] scalar_in2 [tile-1:0][number-1:0][size-1:0];
input loss_model;
input [width-1:0] loss_num [tile-1:0][number-1:0];
input signed [IL+FL-1:0] loss_yHat [tile-1:0][number-1:0][size-1:0];
input signed [IL+FL-1:0] loss_y [tile-1:0][number-1:0][size-1:0];
input loss_input_ready [number-1:0];
input loss_output_taken [number-1:0];
input signed [IL+FL-1:0] pooling_im [tile-1:0][number-1:0][pooling_size-1:0];
input pooling_input_ready [number-1:0];
input pooling_output_taken [number-1:0];
input [1:0] pooling_mode;
input PE_output_taken [tile-1:0];
output logic signed [IL+FL-1:0] pooling_om [tile-1:0][number-1:0];
output logic signed [IL+FL-1:0] loss_out [tile-1:0][number-1:0];
output logic signed [IL+FL-1:0] scalar_out [tile-1:0][number-1:0][size-1:0];
output logic signed [IL+FL-1:0] backward_dX [tile-1:0][number-1:0];
output logic signed [IL+FL-1:0] backward_dgamma [tile-1:0][number-1:0];
output logic signed [IL+FL-1:0] backward_dbeta [tile-1:0][number-1:0];
output logic signed [IL+FL-1:0] forward_out [tile-1:0][number-1:0][size-1:0];
output logic signed [IL+FL-1:0] forward_norm [tile-1:0][number-1:0][size-1:0];
output logic signed [IL+FL-1:0] forward_mu [tile-1:0][number-1:0];
output logic signed [IL+FL-1:0] forward_vari [tile-1:0][number-1:0];
output logic [IL+FL-1:0] post_sparsity_o_im [tile-1:0][number-1:0][size-1:0];


logic [IL+FL-1:0] reg_data [tile-1:0][number-1:0][15:0];
logic [IL+FL-1:0] reg_weight [tile-1:0][number-1:0][15:0];
logic   im2col_done [tile-1:0];

genvar i;
generate
for (i = 0; i < tile; i++) begin : tiling

dataflow  #(.IL(IL), .FL(FL), .lane(number))    dataflow_activation
(
        .clk            (clk),
        .reset          (reset),
        .mode           (dataflow_mode),
        .in             (data_in[i]),
        .out            (reg_data[i])
);

dataflow  #(.IL(IL), .FL(FL), .lane(number))	dataflow_weight
(
        .clk		(clk),
        .reset		(reset),
        .mode		(dataflow_mode),
        .in		(weight_in[i]),
        .out		(reg_weight[i])
);

im2col_cpu 	im2col
(
        .ap_clk		(clk),
        .ap_rst		(reset),
        .ap_start	(im2col_start),
        .ap_done	(im2col_done[i]),
        .ap_idle	(im2col_idle[i]),
        .ap_ready	(im2col_ready[i]),
        .channels	(im2col_channels),
        .height		(im2col_height),
        .width		(im2col_width),
        .kernel_h	(im2col_kernel_h),
        .kernel_w	(im2col_kernel_w),
        .pad_h		(im2col_pad_h),
        .pad_w		(im2col_pad_w),
        .stride_h	(im2col_stride_h),
        .stride_w	(im2col_stride_w),
        .dilation_h	(im2col_dilation_h),
        .dilation_w	(im2col_dilation_w)
);


PE
#(
.IL(IL), .FL(FL), .row(row), .col(col),
.length(length), .p_length(p_length),
.size(size), .width(width),
.pooling_size(pooling_size),
.pooling_width(pooling_width),
.number(number), .FIFO_DEPTH(FIFO_DEPTH),
.IN_BUS_WIDTH(IN_BUS_WIDTH),
.FIFO_CNT_WIDTH(FIFO_CNT_WIDTH)
)
PE_0
(
	.clk		(clk),
        .reset		(reset),
        .input_ready	(im2col_done[i]),
        .output_taken	(PE_output_taken[i]),
        .mode		(mode),
        .in		(in[i]),
        .w		(w[i]),
        .i_mask		(i_mask[i]),
        .w_mask		(w_mask[i]),
        .rd_en		(rd_en),
        .wr_en		(wr_en),
        .pre_sparsity_output_taken	(pre_sparsity_output_taken),
        .post_sparsity_im		(post_sparsity_im[i]),
        .post_sparsity_input_ready	(post_sparsity_input_ready),
        .forward_batch	(forward_batch[i]),
        .forward_num	(forward_num[i]),
        .forward_gamma	(forward_gamma[i]),
        .forward_beta	(forward_beta[i]),
        .forward_input_ready		(forward_input_ready),
        .forward_output_taken		(forward_output_taken),
        .backward_dout	(backward_dout[i]),
        .backward_num	(backward_num[i]),
        .backward_batch	(backward_batch[i]),
        .backward_norm	(backward_norm[i]),
        .backward_mu	(backward_mu[i]),
        .backward_vari	(backward_vari[i]),
        .backward_gamma	(backward_gamma[i]),
        .backward_input_ready		(backward_input_ready),
        .backward_output_taken		(backward_output_taken),
        .post_sparsity_o_im		(post_sparsity_o_im[i]),
        .backward_dX	(backward_dX[i]),
        .backward_dgamma		(backward_dgamma[i]),
        .backward_dbeta	(backward_dbeta[i]),
        .forward_out	(forward_out[i]),
        .forward_norm	(forward_norm[i]),
        .forward_mu	(forward_mu[i]),
        .forward_vari	(forward_vari[i]),
        .scalar_mode	(scalar_mode),
        .scalar_input_ready		(scalar_input_ready),
        .scalar_output_taken		(scalar_output_taken),
        .scalar_in1	(scalar_in1[i]),
        .scalar_in2	(scalar_in2[i]),
        .loss_model	(loss_model),
        .loss_num	(loss_num[i]),
        .loss_yHat	(loss_yHat[i]),
        .loss_y		(loss_y[i]),
	.loss_input_ready		(loss_input_ready),
        .loss_output_taken		(loss_output_taken),
        .loss_out	(loss_out[i]),
        .scalar_out	(scalar_out[i]),
        .pooling_im	(pooling_im[i]),
        .pooling_input_ready		(pooling_input_ready),
        .pooling_output_taken		(pooling_output_taken),
        .pooling_mode	(pooling_mode),
        .pooling_om	(pooling_om[i])
);

end
endgenerate
endmodule
