`timescale 1ns/1ns

module tb_top;
	reg  [0:7] DATAIN;
	reg        RD, WR;
	wire [0:7] DATAOUT;
	wire       ERROR;

	integer i;
	wire PI, PO, PE;

	initial begin
		RD = 1;
		WR = 0;
		for(i = 0; i < 10; i = i + 1) begin
			DATAIN = $random;
			#10;
			RD = 0;
			WR = 1;
			#10;
			RD = 1;
			WR = 0;
			#10;
		end
		$stop;
	end

	module1 GENERATOR  (.A(DATAIN[0]), .B(DATAIN[1]), .C(DATAIN[2]),
						.D(DATAIN[3]), .E(DATAIN[4]), .F(DATAIN[5]),
						.G(DATAIN[6]), .H(DATAIN[7]), .ODD(PI));
	module2 MEMORY     (.READ(RD), .WRITE(WR), .DIN(DATAIN), .PIN(PI),
						.DOUT(DATAOUT), .POUT(PO));
	module3 CHECKER    (.A(DATAOUT[0]), .B(DATAOUT[1]), .C(DATAOUT[2]),
						.D(DATAOUT[3]), .E(DATAOUT[4]), .F(DATAOUT[5]),
						.G(DATAOUT[6]), .H(DATAOUT[7]), .I(PO),
						.ODD(PE));
	module4 FLAG       (.RD(RD), .PE(PE), .ERROR(ERROR));
endmodule