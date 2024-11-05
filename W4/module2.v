module module2 (
	input            READ, WRITE,
	input      [0:7] DIN,
	input            PIN,
	output reg [0:7] DOUT,
	output reg       POUT
);
always @(READ or WRITE) begin
	if (~READ & WRITE) begin
		POUT = PIN;
		DOUT = {DIN[0:1], 1'b1, DIN[3:7]};
	end
end
endmodule