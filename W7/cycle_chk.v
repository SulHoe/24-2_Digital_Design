module cycle_chk (
    input clk,
    input n_reset,
    input [7:0] stage0,
    output reg cycle
);
    reg [7:0] stage1, stage2;

//state
always @(posedge clk or n_reset) begin
    if (!n_reset) begin
        stage1 <= 8'b0;
        stage2 <= 8'b0;
    end else begin
        stage2 <= stage1;
        stage1 <= stage0;
    end
end

//output
always @(posedge clk) begin
    cycle = stage2 == stage0;
end
endmodule
