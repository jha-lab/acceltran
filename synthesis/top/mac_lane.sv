module mac_lane
(
    mode,   //i     //add
	clk,	//i
	reset,	//i
	i_0,	//i
	i_1,	//i
	i_2,	//i
	i_3,	//i
	i_4,	//i
	i_5,	//i
	i_6,	//i
	i_7,	//i
	i_8,	//i
	i_9,	//i
	i_10,	//i
	i_11,	//i
	i_12,	//i
	i_13,	//i
	i_14,	//i
	i_15,	//i
	w_0,	//i
	w_1,	//i
	w_2,	//i
	w_3,	//i
	w_4,	//i
	w_5,	//i
	w_6,	//i
	w_7,	//i
	w_8,	//i
	w_9,	//i
	w_10,	//i
	w_11,	//i
	w_12,	//i
	w_13,	//i
	w_14,	//i
	w_15,	//i
	f	    //o
);

parameter IL = 4, FL = 16;

input mode, clk, reset;     //add
input signed [IL+FL-1:0] i_0;
input signed [IL+FL-1:0] i_1;
input signed [IL+FL-1:0] i_2;
input signed [IL+FL-1:0] i_3;
input signed [IL+FL-1:0] i_4;
input signed [IL+FL-1:0] i_5;
input signed [IL+FL-1:0] i_6;
input signed [IL+FL-1:0] i_7;
input signed [IL+FL-1:0] i_8;
input signed [IL+FL-1:0] i_9;
input signed [IL+FL-1:0] i_10;
input signed [IL+FL-1:0] i_11;
input signed [IL+FL-1:0] i_12;
input signed [IL+FL-1:0] i_13;
input signed [IL+FL-1:0] i_14;
input signed [IL+FL-1:0] i_15;
input signed [IL+FL-1:0] w_0;
input signed [IL+FL-1:0] w_1;
input signed [IL+FL-1:0] w_2;
input signed [IL+FL-1:0] w_3;
input signed [IL+FL-1:0] w_4;
input signed [IL+FL-1:0] w_5;
input signed [IL+FL-1:0] w_6;
input signed [IL+FL-1:0] w_7;
input signed [IL+FL-1:0] w_8;
input signed [IL+FL-1:0] w_9;
input signed [IL+FL-1:0] w_10;
input signed [IL+FL-1:0] w_11;
input signed [IL+FL-1:0] w_12;
input signed [IL+FL-1:0] w_13;
input signed [IL+FL-1:0] w_14;
input signed [IL+FL-1:0] w_15;
output logic signed [IL+FL-1:0] f;

logic signed [IL+FL-1:0] reg_i_0;
logic signed [IL+FL-1:0] reg_i_1;
logic signed [IL+FL-1:0] reg_i_2;
logic signed [IL+FL-1:0] reg_i_3;
logic signed [IL+FL-1:0] reg_i_4;
logic signed [IL+FL-1:0] reg_i_5;
logic signed [IL+FL-1:0] reg_i_6;
logic signed [IL+FL-1:0] reg_i_7;
logic signed [IL+FL-1:0] reg_i_8;
logic signed [IL+FL-1:0] reg_i_9;
logic signed [IL+FL-1:0] reg_i_10;
logic signed [IL+FL-1:0] reg_i_11;
logic signed [IL+FL-1:0] reg_i_12;
logic signed [IL+FL-1:0] reg_i_13;
logic signed [IL+FL-1:0] reg_i_14;
logic signed [IL+FL-1:0] reg_i_15;
logic signed [IL+FL-1:0] reg_w_0;
logic signed [IL+FL-1:0] reg_w_1;
logic signed [IL+FL-1:0] reg_w_2;
logic signed [IL+FL-1:0] reg_w_3;
logic signed [IL+FL-1:0] reg_w_4;
logic signed [IL+FL-1:0] reg_w_5;
logic signed [IL+FL-1:0] reg_w_6;
logic signed [IL+FL-1:0] reg_w_7;
logic signed [IL+FL-1:0] reg_w_8;
logic signed [IL+FL-1:0] reg_w_9;
logic signed [IL+FL-1:0] reg_w_10;
logic signed [IL+FL-1:0] reg_w_11;
logic signed [IL+FL-1:0] reg_w_12;
logic signed [IL+FL-1:0] reg_w_13;
logic signed [IL+FL-1:0] reg_w_14;
logic signed [IL+FL-1:0] reg_w_15;

logic signed [(IL+FL)*2-1:0] out_mul_0;
logic signed [(IL+FL)*2-1:0] out_mul_1;
logic signed [(IL+FL)*2-1:0] out_mul_2;
logic signed [(IL+FL)*2-1:0] out_mul_3;
logic signed [(IL+FL)*2-1:0] out_mul_4;
logic signed [(IL+FL)*2-1:0] out_mul_5;
logic signed [(IL+FL)*2-1:0] out_mul_6;
logic signed [(IL+FL)*2-1:0] out_mul_7;
logic signed [(IL+FL)*2-1:0] out_mul_8;
logic signed [(IL+FL)*2-1:0] out_mul_9;
logic signed [(IL+FL)*2-1:0] out_mul_10;
logic signed [(IL+FL)*2-1:0] out_mul_11;
logic signed [(IL+FL)*2-1:0] out_mul_12;
logic signed [(IL+FL)*2-1:0] out_mul_13;
logic signed [(IL+FL)*2-1:0] out_mul_14;
logic signed [(IL+FL)*2-1:0] out_mul_15;
logic signed [(IL+FL)*2-1:0] reg_mul_0;
logic signed [(IL+FL)*2-1:0] reg_mul_1;
logic signed [(IL+FL)*2-1:0] reg_mul_2;
logic signed [(IL+FL)*2-1:0] reg_mul_3;
logic signed [(IL+FL)*2-1:0] reg_mul_4;
logic signed [(IL+FL)*2-1:0] reg_mul_5;
logic signed [(IL+FL)*2-1:0] reg_mul_6;
logic signed [(IL+FL)*2-1:0] reg_mul_7;
logic signed [(IL+FL)*2-1:0] reg_mul_8;
logic signed [(IL+FL)*2-1:0] reg_mul_9;
logic signed [(IL+FL)*2-1:0] reg_mul_10;
logic signed [(IL+FL)*2-1:0] reg_mul_11;
logic signed [(IL+FL)*2-1:0] reg_mul_12;
logic signed [(IL+FL)*2-1:0] reg_mul_13;
logic signed [(IL+FL)*2-1:0] reg_mul_14;
logic signed [(IL+FL)*2-1:0] reg_mul_15;

logic signed [4+(IL+FL)*2-1:0] out_add;
logic signed [4+(IL+FL)*2-1:0] reg_add;
logic signed [IL+FL-1:0] r_add;
logic signed [IL+FL-1:0] reg_r_add;

logic signed [IL+FL-1:0] f_R;   //add
logic signed [IL+FL-1:0] f_S;   //add


always_ff @(posedge clk) begin
	if (reset == 1) begin
		reg_i_0 <= {(IL+FL){1'b0}};
		reg_i_1 <= {(IL+FL){1'b0}};
		reg_i_2 <= {(IL+FL){1'b0}};
		reg_i_3 <= {(IL+FL){1'b0}};
		reg_i_4 <= {(IL+FL){1'b0}};
		reg_i_5 <= {(IL+FL){1'b0}};
		reg_i_6 <= {(IL+FL){1'b0}};
		reg_i_7 <= {(IL+FL){1'b0}};
		reg_i_8 <= {(IL+FL){1'b0}};
		reg_i_9 <= {(IL+FL){1'b0}};
		reg_i_10 <= {(IL+FL){1'b0}};
		reg_i_11 <= {(IL+FL){1'b0}};
		reg_i_12 <= {(IL+FL){1'b0}};
		reg_i_13 <= {(IL+FL){1'b0}};
		reg_i_14 <= {(IL+FL){1'b0}};
		reg_i_15 <= {(IL+FL){1'b0}};
		reg_w_0 <= {(IL+FL){1'b0}};
		reg_w_1 <= {(IL+FL){1'b0}};
		reg_w_2 <= {(IL+FL){1'b0}};
		reg_w_3 <= {(IL+FL){1'b0}};
		reg_w_4 <= {(IL+FL){1'b0}};
		reg_w_5 <= {(IL+FL){1'b0}};
		reg_w_6 <= {(IL+FL){1'b0}};
		reg_w_7 <= {(IL+FL){1'b0}};
		reg_w_8 <= {(IL+FL){1'b0}};
		reg_w_9 <= {(IL+FL){1'b0}};
		reg_w_10 <= {(IL+FL){1'b0}};
		reg_w_11 <= {(IL+FL){1'b0}};
		reg_w_12 <= {(IL+FL){1'b0}};
		reg_w_13 <= {(IL+FL){1'b0}};
		reg_w_14 <= {(IL+FL){1'b0}};
		reg_w_15 <= {(IL+FL){1'b0}};
	end
	else begin
		reg_i_0 <= i_0;
		reg_i_1 <= i_1;
		reg_i_2 <= i_2;
		reg_i_3 <= i_3;
		reg_i_4 <= i_4;
		reg_i_5 <= i_5;
		reg_i_6 <= i_6;
		reg_i_7 <= i_7;
		reg_i_8 <= i_8;
		reg_i_9 <= i_9;
		reg_i_10 <= i_10;
		reg_i_11 <= i_11;
		reg_i_12 <= i_12;
		reg_i_13 <= i_13;
		reg_i_14 <= i_14;
		reg_i_15 <= i_15;
		reg_w_0 <= w_0;
		reg_w_1 <= w_1;
		reg_w_2 <= w_2;
		reg_w_3 <= w_3;
		reg_w_4 <= w_4;
		reg_w_5 <= w_5;
		reg_w_6 <= w_6;
		reg_w_7 <= w_7;
		reg_w_8 <= w_8;
		reg_w_9 <= w_9;
		reg_w_10 <= w_10;
		reg_w_11 <= w_11;
		reg_w_12 <= w_12;
		reg_w_13 <= w_13;
		reg_w_14 <= w_14;
		reg_w_15 <= w_15;
	end
end

// MUL
mul #(.IL(IL), .FL(FL)) mul_0
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.i		(reg_i_0),	//i
	.w		(reg_w_0),	//i
	.f		(out_mul_0)	//o
);

mul #(.IL(IL), .FL(FL)) mul_1
(
	.clk            (clk),          //i
	.reset          (reset),        //i
	.i              (reg_i_1),      //i
	.w              (reg_w_1),      //i
	.f              (out_mul_1)     //o
);

mul #(.IL(IL), .FL(FL)) mul_2
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.i		(reg_i_2),	//i
	.w		(reg_w_2),	//i
	.f		(out_mul_2)	//o
);

mul #(.IL(IL), .FL(FL)) mul_3
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.i		(reg_i_3),	//i
	.w		(reg_w_3),	//i
	.f		(out_mul_3)	//o
);

mul #(.IL(IL), .FL(FL)) mul_4
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.i		(reg_i_4),	//i
	.w		(reg_w_4),	//i
	.f		(out_mul_4)	//o
);

mul #(.IL(IL), .FL(FL)) mul_5
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.i		(reg_i_5),	//i
	.w		(reg_w_5),	//i
	.f		(out_mul_5)	//i
);

mul #(.IL(IL), .FL(FL)) mul_6
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.i		(reg_i_6),	//i
	.w		(reg_w_6),	//i
	.f		(out_mul_6)	//o
);

mul #(.IL(IL), .FL(FL)) mul_7
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.i		(reg_i_7),	//i
	.w		(reg_w_7),	//i
	.f		(out_mul_7)	//o
);

mul #(.IL(IL), .FL(FL)) mul_8
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.i		(reg_i_8),	//i
	.w		(reg_w_8),	//i
	.f		(out_mul_8)	//o
);

mul #(.IL(IL), .FL(FL)) mul_9
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.i		(reg_i_9),	//i
	.w		(reg_w_9),	//i
	.f		(out_mul_9)	//o
);

mul #(.IL(IL), .FL(FL)) mul_10
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.i		(reg_i_10),	//i
	.w		(reg_w_10),	//i
	.f		(out_mul_10)	//o
);

mul #(.IL(IL), .FL(FL)) mul_11
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.i		(reg_i_11),	//i
	.w		(reg_w_11),	//i
	.f		(out_mul_11)	//o
);

mul #(.IL(IL), .FL(FL)) mul_12
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.i		(reg_i_12),	//i
	.w		(reg_w_12),	//i
	.f		(out_mul_12)	//o
);

mul #(.IL(IL), .FL(FL)) mul_13
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.i		(reg_i_13),	//i
	.w		(reg_w_13),	//i
	.f		(out_mul_13)	//o
);

mul #(.IL(IL), .FL(FL)) mul_14
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.i		(reg_i_14),	//i
	.w		(reg_w_14),	//i
	.f		(out_mul_14)	//o
);

mul #(.IL(IL), .FL(FL)) mul_15
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.i		(reg_i_15),	//i
	.w		(reg_w_15),	//i
	.f		(out_mul_15)	//o
);

always_ff @(posedge clk) begin
	if (reset == 1) begin
		reg_mul_0 <= {((IL+FL)*2){1'b0}};
		reg_mul_1 <= {((IL+FL)*2){1'b0}};
		reg_mul_2 <= {((IL+FL)*2){1'b0}};
		reg_mul_3 <= {((IL+FL)*2){1'b0}};
		reg_mul_4 <= {((IL+FL)*2){1'b0}};
		reg_mul_5 <= {((IL+FL)*2){1'b0}};
		reg_mul_6 <= {((IL+FL)*2){1'b0}};
		reg_mul_7 <= {((IL+FL)*2){1'b0}};
		reg_mul_8 <= {((IL+FL)*2){1'b0}};
		reg_mul_9 <= {((IL+FL)*2){1'b0}};
		reg_mul_10 <= {((IL+FL)*2){1'b0}};
		reg_mul_11 <= {((IL+FL)*2){1'b0}};
		reg_mul_12 <= {((IL+FL)*2){1'b0}};
		reg_mul_13 <= {((IL+FL)*2){1'b0}};
		reg_mul_14 <= {((IL+FL)*2){1'b0}};
		reg_mul_15 <= {((IL+FL)*2){1'b0}};
	end
	else begin
		reg_mul_0 <= out_mul_0;
		reg_mul_1 <= out_mul_1;
		reg_mul_2 <= out_mul_2;
		reg_mul_3 <= out_mul_3;
		reg_mul_4 <= out_mul_4;
		reg_mul_5 <= out_mul_5;
		reg_mul_6 <= out_mul_6;
		reg_mul_7 <= out_mul_7;
		reg_mul_8 <= out_mul_8;
		reg_mul_9 <= out_mul_9;
		reg_mul_10 <= out_mul_10;
		reg_mul_11 <= out_mul_11;
		reg_mul_12 <= out_mul_12;
		reg_mul_13 <= out_mul_13;
		reg_mul_14 <= out_mul_14;
		reg_mul_15 <= out_mul_15;
	end
end

// Adder tree
adder_tree #(.IL(IL), .FL(FL)) adder_tree_0
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.i_0		(reg_mul_0),	//i
	.i_1		(reg_mul_1),	//i
	.i_2		(reg_mul_2),	//i
	.i_3		(reg_mul_3),	//i
	.i_4		(reg_mul_4),	//i
	.i_5		(reg_mul_5),	//i
	.i_6		(reg_mul_6),	//i
	.i_7		(reg_mul_7),	//i
	.i_8		(reg_mul_8),	//i
	.i_9		(reg_mul_9),	//i
	.i_10		(reg_mul_10),	//i
	.i_11		(reg_mul_11),	//i
	.i_12		(reg_mul_12),	//i
	.i_13		(reg_mul_13),	//i
	.i_14		(reg_mul_14),	//i
	.i_15		(reg_mul_15),	//i
	.f		(out_add)	//o
);

always_ff @(posedge clk) begin
	if (reset == 1) begin
		reg_add <= {(4+(IL+FL)*2){1'b0}};
	end
	else begin
		reg_add <= out_add;
	end
end

stochastic_rounding #(.IL(IL), .FL(FL)) sr_0
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.i		(reg_add),	//i
	.f		(r_add)		//o
);

always_ff @(posedge clk) begin
	if (reset == 1) begin
		reg_r_add <= {(IL+FL){1'b0}};
	end
	else begin
		reg_r_add <= reg_r_add + r_add;
	end
end

//add
always_ff @(posedge clk) begin
	if (reset == 1) begin
		f <= {(IL+FL){1'b0}};
	end
	else begin
        case (mode)
            1'b1: f <= f_R;
            1'b0: f <= f_S;
        endcase
	end
end
//

ReLU #(.IL(IL), .FL(FL)) ReLU_0
(
    .en         (mode),         //i     //add
	.clk		(clk),		    //i
	.reset		(reset),	    //i
	.i		    (reg_r_add),    //i
	.f		    (f_R)		    //o
);

SiLU #(.IL(IL), .FL(FL)) SiLU_0
(
    .n_en       (mode),         //i     //add
	.clk		(clk),		    //i
	.reset		(reset),	    //i
	.i		    (reg_r_add),	//i
	.f		    (f_S)		    //o
);

endmodule
