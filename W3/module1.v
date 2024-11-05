module three_1s_detector (
    input [7:0] data,
    output flag
);
    wire a1, a2, a3, a4, a5, a6;

    and (a1, data[7], data[6], data[5]);
    and (a2, data[6], data[5], data[4]);
    and (a3, data[5], data[4], data[3]);
    and (a4, data[4], data[3], data[2]);
    and (a5, data[3], data[2], data[1]);
    and (a6, data[2], data[1], data[0]);
    or  (flag, a1, a2, a3, a4, a5,a6);
    
endmodule