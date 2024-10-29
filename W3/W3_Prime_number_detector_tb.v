module prime_number_detector_tb;
    reg [3:0] number;
    wire flag;

    initial begin
        for(number = 0; number < 4'b1111; number = number+1)
            #10;
        #10;
        $stop;
    end

    initial begin
        $display("|Time| input |flag|");
        $monitor(" %03d %d:%b %b", $time, number, number, flag);
    end

    prime_number_detector UUT (.N3(number[3]), .N2(number[2]), .N1(number[1]), .N0(number[0]), .flag(flag));

endmodule
