module module4 (
    input      RD, PE,
    output reg ERROR
);
always @(RD) begin 
    if (RD)
        ERROR = RD & PE;
end

endmodule