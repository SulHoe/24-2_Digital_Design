`timescale 1ns/1ns

module module_tb;
    reg [7:0] number;
    wire flag;

    initial begin
        repeat(20) begin
            number = $random;
            #10;
        end
    end

    three_1s_detector UNIT (.data(number), .flag(flag));
endmodule