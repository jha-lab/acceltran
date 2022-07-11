module adder_tree
(
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
	f	//o
);

parameter IL = 4, FL = 16;

input clk, reset;
input signed [(IL+FL)*2-1:0] i_0;
input signed [(IL+FL)*2-1:0] i_1;
input signed [(IL+FL)*2-1:0] i_2;
input signed [(IL+FL)*2-1:0] i_3;
input signed [(IL+FL)*2-1:0] i_4;
input signed [(IL+FL)*2-1:0] i_5;
input signed [(IL+FL)*2-1:0] i_6;
input signed [(IL+FL)*2-1:0] i_7;
input signed [(IL+FL)*2-1:0] i_8;
input signed [(IL+FL)*2-1:0] i_9;
input signed [(IL+FL)*2-1:0] i_10;
input signed [(IL+FL)*2-1:0] i_11;
input signed [(IL+FL)*2-1:0] i_12;
input signed [(IL+FL)*2-1:0] i_13;
input signed [(IL+FL)*2-1:0] i_14;
input signed [(IL+FL)*2-1:0] i_15;
output logic signed [4+(IL+FL)*2-1:0] f;

logic signed [1+(IL+FL)*2-1:0] out_0;
logic signed [1+(IL+FL)*2-1:0] out_1;
logic signed [1+(IL+FL)*2-1:0] out_2;
logic signed [1+(IL+FL)*2-1:0] out_3;
logic signed [1+(IL+FL)*2-1:0] out_4;
logic signed [1+(IL+FL)*2-1:0] out_5;
logic signed [1+(IL+FL)*2-1:0] out_6;
logic signed [1+(IL+FL)*2-1:0] out_7;

logic signed [2+(IL+FL)*2-1:0] out_8;
logic signed [2+(IL+FL)*2-1:0] out_9;
logic signed [2+(IL+FL)*2-1:0] out_10;
logic signed [2+(IL+FL)*2-1:0] out_11;

logic signed [3+(IL+FL)*2-1:0] out_12;
logic signed [3+(IL+FL)*2-1:0] out_13;

// First level adders
add #(.WL((IL+FL)*2)) add_0
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.a		(i_0),		//i
	.b		(i_1),		//i
	.f		(out_0)		//o
);

add #(.WL((IL+FL)*2)) add_1
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.a		(i_2),		//i
	.b		(i_3),		//i
	.f		(out_1)		//o
);

add #(.WL((IL+FL)*2)) add_2
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.a		(i_4),		//i
	.b		(i_5),		//i
	.f		(out_2)		//o
);

add #(.WL((IL+FL)*2)) add_3
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.a		(i_6),		//i
	.b		(i_7),		//i
	.f		(out_3)		//o
);

add #(.WL((IL+FL)*2)) add_4
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.a		(i_8),		//i
	.b		(i_9),		//i
	.f		(out_4)		//o
);

add #(.WL((IL+FL)*2)) add_5
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.a		(i_10),		//i
	.b		(i_11),		//i
	.f		(out_5)		//o
);

add #(.WL((IL+FL)*2)) add_6
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.a		(i_12),		//i
	.b		(i_13),		//i
	.f		(out_6)		//o
);

add #(.WL((IL+FL)*2)) add_7
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.a		(i_14),		//i
	.b		(i_15),		//i
	.f		(out_7)		//o
);

// Second level adders
add #(.WL(1+(IL+FL)*2)) add_8
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.a		(out_0),	//i
	.b		(out_1),	//i
	.f		(out_8)		//o
);

add #(.WL(1+(IL+FL)*2)) add_9
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.a		(out_2),	//i
	.b		(out_3),	//i
	.f		(out_9)		//i
);

add #(.WL(1+(IL+FL)*2)) add_10
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.a		(out_4),	//i
	.b		(out_5),	//i
	.f		(out_10)	//o
);

add #(.WL(1+(IL+FL)*2)) add_11
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.a		(out_6),	//i
	.b		(out_7),	//i
	.f		(out_11)	//o
);

// Third level adders
add #(.WL(2+(IL+FL)*2)) add_12
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.a		(out_8),	//i
	.b		(out_9),	//i
	.f		(out_12)	//o
);

add #(.WL(2+(IL+FL)*2)) add_13
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.a		(out_10),	//i
	.b		(out_11),	//i
	.f		(out_13)	//o
);

// Forth level adder
add #(.WL(3+(IL+FL)*2)) add_14
(
	.clk		(clk),		//i
	.reset		(reset),	//i
	.a		(out_12),	//i
	.b		(out_13),	//i
	.f		(f)		//o
);

endmodule
