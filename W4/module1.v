module module1 (
    input  A, B, C, D, E, F, G, H,
    output ODD
);
    xor (ODD, A, B, C, D, E, F, G, H);
endmodule