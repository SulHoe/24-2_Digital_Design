`timescale 1ns/1ns
module module2_delay #(
	parameter delay = 5
) (
	input        READ, WRITE,
	input  [0:7] DIN,
	input        PIN,
	output [0:7] DOUT,
	output       POUT
);
wire [0:7] m_DIN;
assign m_DIN = {DIN[0:3], DIN[0] & DIN[1], DIN[5:7]};

bufif1 #(delay) (POUT, PIN, ~READ & WRITE);

generate
	genvar i;
	for (i = 0; i < 8; i = i + 1)
		bufif1 #(delay) (DOUT[i], m_DIN[i], ~READ & WRITE);
endgenerate


endmodule