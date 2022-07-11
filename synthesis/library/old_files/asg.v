// asg library

// flip-flop
`celldefine // celldefine allows ingoring internal signals of cells in SAIF files

module dff_asg(
	D,
	CP,
	Q
);

input	D;
input	CP;
output	Q;

reg	Q;

always @(posedge CP)
begin
	Q <= D;
end

endmodule

// inv
module inv_x1_asg(
	A,
	X
);

input	A;
output	X;

assign X = ~A;

endmodule

// nand
module nand_x1_asg(
	A,
	B,
	X
);

input	A;
input	B;
output	X;

assign X = ~(A&B);

endmodule

// nor
module nor_x1_asg(
	A,
	B,
	X
);

input	A;
input	B;
output	X;

assign X = ~(A|B);

endmodule

// inv
module inv_x2_asg(
	A,
	X
);

input	A;
output	X;

assign X = ~A;

endmodule

// nand
module nand_x2_asg(
	A,
	B,
	X
);

input	A;
input	B;
output	X;

assign X = ~(A&B);

endmodule

// nor
module nor_x2_asg(
	A,
	B,
	X
);

input	A;
input	B;
output	X;

assign X = ~(A|B);

endmodule

`endcelldefine
