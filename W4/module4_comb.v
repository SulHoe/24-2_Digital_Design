module module4_comb (
    input  RD, PE,
    output ERROR
);
    assign ERROR = RD ? RD & PE : 1'bz;

endmodule