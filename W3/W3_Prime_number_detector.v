module prime_number_detector (
    input N3, N2, N1, N0,
    output flag
);
    assign flag = ~N3&~N2& N1 |
                  ~N3& N2& N0 |
                   N2&~N1& N0 |
                  ~N2& N1& N0;

endmodule