`timescale 1ns/100ps
module gene_net(
    input clk, 
    input n_reset,
    input      [7:0] x_in,
    output reg [7:0] x_out
);
    reg [7:0] n_gene, c_gene;

    //state
	always @(posedge clk or n_reset) begin
        if(!n_reset) n_gene <= x_in;
        else c_gene <= n_gene;
    end

    //next state
	always @(c_gene)	begin		//synchronized with positive edge clock signal
		n_gene[0] = ~c_gene[2] & c_gene[6] & ~c_gene[7];
		n_gene[1] = (c_gene[4] | c_gene[5]) & ~c_gene[7];
		n_gene[2] = c_gene[7];
		n_gene[3] = c_gene[1] & ~c_gene[6];
		n_gene[4] = c_gene[1] | c_gene[3];
		n_gene[5] = c_gene[2] & ~c_gene[7];
		n_gene[6] = c_gene[1] & ~c_gene[7];
		n_gene[7] = ~(c_gene[0] | c_gene[1]) & (c_gene[3] | c_gene[6]);
	end

    //output
    always @(*) begin
        x_out = c_gene;
    end

endmodule