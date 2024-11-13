`timescale 1ns / 1ns

module SequenceDetector_tb();

parameter  CLOCK_PS  = 10;
parameter  HCLOCK_PS = 5;

reg  clk;
reg  reset_n;
reg  d_in;
wire d_out;

SequenceDetector top (
	.clk(clk), .reset_n(reset_n), .d_in(d_in), .d_out(d_out)
);

// Clock signal generation
initial begin : CLOCK_GENERATOR
    clk = 1'b0;
    forever
        #HCLOCK_PS clk = ~clk;
end


// Test
reg [15:0] in_seq   = 16'b0010_0101_0110_1010;  // input sequence
reg [15:0] ref_res  = 16'b0000_0100_0010_1000;  // reference result
reg [15:0] test_res = 16'd0;                    // test result

integer i;

initial begin
    $display("\n:: INITIALIZATION STAGE ::");
    reset_n = 1'b0;
	d_in    = 1'b0;

    #2;
    reset_n = 1'b1;

	$display("\n:: TEST ::");
    d_in = in_seq[0];
    #CLOCK_PS;
	for (i = 0; i < 16; i = i + 1) begin
        test_res[i] = d_out;
        $display("#%3d \td_out = %b  (%s)", i, d_out, (d_out == ref_res[i]) ? "passed" : "failed");
		d_in = in_seq[i+1 > 15? 15 : i+1];
        #CLOCK_PS;
	end
    
	$display("#%3d \ttest %s", i, (test_res == ref_res) ? "passed" : "failed");
	$display("reference result: %b", ref_res);
	$display("test result:      %b", test_res);

    $stop;
end

endmodule
 