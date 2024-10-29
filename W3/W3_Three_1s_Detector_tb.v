`timescale 1ns/1ns

module three_1s_detector_tb;
    reg [7:0] data;
    wire flag;

    initial begin
        repeat(20) begin
            data = $random;
            #10;
        end
        $stop;
    end

    initial begin
        $display("|Time|  input  |flag|");
        $monitor(" %04d %b %b", $time, data, flag);
    end

    three_1s_detector UUT (.data(data), .flag(flag));
endmodule