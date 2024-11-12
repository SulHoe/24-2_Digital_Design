`timescale 100ps / 100ps

// OP CODE
// TODO : If your module and its pin have different OP_CODE, you should change the mapping.

// Arithmetic
`define	OP_ADD	    4'b0000
`define	OP_SUB	    4'b0001
//  Bitwise Boolean operation
`define	OP_ID		4'b1000
`define	OP_NAND	    4'b1001
`define	OP_NOR      4'b1010
`define	OP_XNOR     4'b1011
`define	OP_NOT      4'b1100
`define	OP_AND      4'b1101
`define	OP_OR		4'b1110
`define	OP_XOR      4'b1111
// Shifting
`define	OP_LRS      4'b0010
`define	OP_ARS      4'b0100
`define	OP_RR       4'b0110
`define	OP_LLS      4'b0011
`define	OP_ALS      4'b0101
`define	OP_RL       4'b0111

module ALU_TB;

//Internal signals declarations:
	reg     [15:0]  A_i;
	reg     [15:0]  B_i;
	reg     [3:0]   OP_i;
	reg             C_i;
	
	wire    [15:0]  F_o;
	wire            C_o;

	reg     [15:0]  Passed;
	reg     [15:0]  Failed;

// Unit Under Test port map
// TODO : If your module and its pin have different name, you should change the mapping.
	ALU UUT (
		.A_i        (A_i),
		.B_i        (B_i),
		.OP_i       (OP_i),
		.C_i        (C_i),
		.F_o        (F_o),
		.C_o        (C_o)
	);

initial begin
	Passed = 0;
	Failed = 0;
	
	ArithmeticTest;
	BitwiseBooleanTest;
	ShiftingTest;
	
	$display("Passed = %0d, Failed = %0d", Passed, Failed);	
	$finish;
end

task ArithmeticTest;
begin
	AddTest;
	SubTest;
end
endtask					 

task BitwiseBooleanTest;
begin
	IdTest;
	NandTest;
	NorTest;
	XnorTest;
	NotTest;
	AndTest;
	OrTest;
	XorTest;
end
endtask

task ShiftingTest;
begin
	LrsTest;
	ArsTest;
	RrTest;
	LlsTest;
	AlsTest;
	RlTest;
end
endtask

task AddTest;
begin
	OP_i = `OP_ADD;
	
	Test("Add-1", 0, 0, 0, 0, 0);
	Test("Add-2", 0, 0, 1, 1, 0);
	Test("Add-3", 2, 3, 0, 5, 0);
	Test("Add-4", 3, 2, 0, 5, 0);
	Test("Add-5", 2, 3, 1, 6, 0);
	Test("Add-6", 3, 2, 1, 6, 0);
	Test("Add-7", 16'h8000, 16'h8000, 0, 0, 1);
	Test("Add-8", 16'hffff, 1, 0, 0, 1);
	Test("Add-9", 16'hffff, 16'hffff, 0, 16'hfffe, 1);
end
endtask

task SubTest;
begin
	OP_i = `OP_SUB;
	
	Test("Sub-1", 0, 0, 0, 0, 0);
	Test("Sub-2", 1, 0, 0, 1, 0);
	Test("Sub-3", 0, 1, 0, 16'hffff, 1);
	Test("Sub-4", 0, 0, 1, 16'hffff, 1);
	Test("Sub-5", 3, 2, 0, 1, 0);
	Test("Sub-6", 3, 2, 1, 0, 0);
	Test("Sub-7", 0, 16'hffff, 1, 0, 1);
end
endtask		  

task IdTest;
begin
	OP_i = `OP_ID;
	
	Test("Id-1", 0, 0, 0, 0, 0);
	Test("Id-2", 1, 0, 0, 1, 0);
	Test("Id-3", 16'habcd, 0, 0, 16'habcd, 0);
end
endtask

task NandTest;
begin
	OP_i = `OP_NAND;												 
	
	Test("Nand-1", {4{4'b0011}}, {4{4'b0101}}, 0, {4{4'b1110}}, 0);
	Test("Nand-2", {4{4'b1100}}, {4{4'b0101}}, 0, {4{4'b1011}}, 0); 
end
endtask

task NorTest;
begin
	OP_i = `OP_NOR;												 
	
	Test("Nor-1", {4{4'b0011}}, {4{4'b0101}}, 0, {4{4'b1000}}, 0);
	Test("Nor-2", {4{4'b1100}}, {4{4'b0101}}, 0, {4{4'b0010}}, 0);
end
endtask

task XnorTest;
begin
	OP_i = `OP_XNOR;												 
	
	Test("Xnor-1", {4{4'b0011}}, {4{4'b0101}}, 0, {4{4'b1001}}, 0);
	Test("Xnor-2", {4{4'b1100}}, {4{4'b0101}}, 0, {4{4'b0110}}, 0);
end
endtask

task NotTest;
begin
	OP_i = `OP_NOT;
		
	Test("Not-1", 0, 0, 0, 16'hffff, 0);
	Test("Not-2", 1, 0, 0, 16'hfffe, 0);
	Test("Not-3", 16'habcd, 0, 0, 16'h5432, 0);
end
endtask

task AndTest;
begin
	OP_i = `OP_AND;												 
		
	Test("And-1", {4{4'b0011}}, {4{4'b0101}}, 0, {4{4'b0001}}, 0);
	Test("And-2", {4{4'b1100}}, {4{4'b0101}}, 0, {4{4'b0100}}, 0);
end
endtask

task OrTest;
begin
	OP_i = `OP_OR;												 
		
	Test("Or-1", {4{4'b0011}}, {4{4'b0101}}, 0, {4{4'b0111}}, 0);
	Test("Or-2", {4{4'b1100}}, {4{4'b0101}}, 0, {4{4'b1101}}, 0);
end
endtask

task XorTest;
begin
	OP_i = `OP_XOR;												 
		
	Test("Xor-1", {4{4'b0011}}, {4{4'b0101}}, 0, {4{4'b0110}}, 0);
	Test("Xor-2", {4{4'b1100}}, {4{4'b0101}}, 0, {4{4'b1001}}, 0);
end
endtask

task LrsTest;
begin
	OP_i = `OP_LRS;
		
	Test("Lrs-1", 16'ha, 0, 0, 5, 0);
	Test("Lrs-2", 1, 0, 0, 0, 0);
	Test("Lrs-3", 16'hfffa, 0, 0, 16'h7ffd, 0);
	Test("Lrs-4", 16'hffff, 0, 0, 16'h7fff, 0);
end
endtask

task ArsTest;
begin
	OP_i = `OP_ARS;
		
	Test("Ars-1", 16'ha, 0, 0, 5, 0);
	Test("Ars-2", 1, 0, 0, 0, 0);
	Test("Ars-3", 16'hfffa, 0, 0, 16'hfffd, 0);
	Test("Ars-4", 16'hffff, 0, 0, 16'hffff, 0);
end
endtask

task RrTest;
begin
	OP_i = `OP_RR;
		
	Test("Rr-1", 16'ha, 0, 0, 16'h5, 0);
	Test("Rr-2", 16'hb, 0, 0, 16'h8005, 0);
end
endtask

task LlsTest;
	begin
	OP_i = `OP_LLS;
		
	Test("Lls-1", 16'ha, 0, 0, 16'h14, 0);
	Test("Lls-2", 16'hf000, 0, 0, 16'he000, 0);
end
endtask

task AlsTest;
begin
	OP_i = `OP_ALS;
		
	Test("Als-1", 16'ha, 0, 0, 16'h14, 0);
	Test("Als-2", 16'hf000, 0, 0, 16'he000, 0);
end
endtask

task RlTest;
begin
	OP_i = `OP_RL;
		
	Test("Rl-1", 16'h7000, 0, 0, 16'he000, 0);
	Test("Rl-2", 16'hf000, 0, 0, 16'he001, 0);
end
endtask

task Test; 
	input   [16 * 8 : 0]    Testname;
	input   [15:0]          A_;
	input   [15:0]          B_;
	input                   Cin_;
	input   [15:0]          F_expected;
	input                   Cout_expected;  
begin
	$display("TEST %s :", Testname);
	A_i = A_;
	B_i = B_;
	C_i = Cin_;
	#1;
	if (F_o == F_expected && C_o == Cout_expected) begin
		$display("PASSED\n");
		Passed = Passed + 1;
	end
	else begin
		$display("FAILED");
		$display("A = %0b, B = %0b, Cin = %0b, F = %0b (Ans : %0b), Cout = %0b (Ans : %0b)\n", A_, B_, Cin_, F_o, F_expected, C_o, Cout_expected);
		Failed = Failed + 1;
	end
end
endtask

endmodule