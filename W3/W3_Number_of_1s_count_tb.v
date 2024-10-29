`timescale 1ns/1ns

module number_of_1s_count_tb;
    reg [2:0] data;
    wire [1:0] count;

    initial begin
        for(data = 0; data < 3'b111; data = data+1)
            #10;
        #10;
        $stop;
    end

    initial begin
        $display("|Time|input|count|");
        $monitor(" %04d  %b   %b", $time, data, count);
    end

    number_of_1s_count UUT (.data(data), .count(count));

endmodule