module module3 (
	input  A, B, C, D, E, F, G, H, I,
	output ODD
);
	xor (ODD, A, B, C, D, E, F, G, H, I);
endmodule