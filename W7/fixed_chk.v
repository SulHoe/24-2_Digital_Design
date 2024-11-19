module fixed_chk (
    input clk,
    input n_reset,
    input [7:0] stage0,
    output reg fix
);
reg [7:0] stage1;

//state
always @(posedge clk or n_reset) begin
    if (!n_reset) stage1 <= 8'b0;
    else stage1 <= stage0;
end

//output
always @(posedge clk) begin
    fix = stage1 == stage0;
end
endmodule
