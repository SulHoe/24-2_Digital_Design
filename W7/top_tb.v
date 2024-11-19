`timescale 1ns / 1ns
module top_tb;
reg clk;
reg n_reset;
reg [7:0] x;
wire cycle, fix;
wire [7:0] x_out;

initial begin
    clk = 1;
    n_reset = 0;
    x = 8'b0;
    forever #5 clk = ~clk;
end

initial begin
    #50;
    n_reset = 1;
end

always @(posedge cycle or posedge fix) begin
    $display("x= %b x_out= %b\tcycle= %b\tfix= %b\n", x, x_out, cycle, fix);
    #10;
    x = x + 1'b1;
    n_reset = 0;
    #10;
    n_reset = 1;
    if (x == 8'hff) $stop;
end


gene_net    GENE    (.clk(clk), .n_reset(n_reset), .x_in(x), .x_out(x_out));
cycle_chk   CYCLE   (.clk(clk), .n_reset(n_reset), .stage0(x_out), .cycle(cycle));
fixed_chk   FIX     (.clk(clk), .n_reset(n_reset), .stage0(x_out), .fix(fix));

endmodule
