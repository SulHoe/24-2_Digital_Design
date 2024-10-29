module number_of_1s_count(
    input [2:0] data,
    output [1:0] count
);
    wire a1, a2, a3, a4, a5, a6, a7;

    //count[1]
    and (a1, data[2], data[1]);
    and (a2, data[1], data[0]);
    and (a3, data[2], data[0]);
    or  (count[1], a1, a2, a3);

    //count[0]
    and (a4, ~data[2], ~data[1],  data[0]);
    and (a5, ~data[2],  data[1], ~data[0]);
    and (a6,  data[2],  data[1],  data[0]);
    and (a7,  data[2], ~data[1], ~data[0]);
    or  (count[0], a4, a5, a6, a7);
    
endmodule