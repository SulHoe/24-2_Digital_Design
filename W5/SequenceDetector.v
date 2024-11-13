/* detect 0101 sequence in stream
 * mealym machine
**/
module SequenceDetector (
    input clk, reset_n, d_in,
    output reg d_out
);
    reg [1:0] n_state;       //next state
    reg [1:0] c_state;       //current state

    //define state
    localparam RO       = 2'b00;
    localparam RZ       = 2'b01;
    localparam Z2O      = 2'b10;
    localparam Z2O2Z    = 2'b11;

    //Part 1: initialize and update the state register
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)   begin
            c_state <= RO;
            n_state <= RO;
        end else
            c_state <= n_state;
    end

    //Part 2: Determine next state using function
    always @(*) begin
        case (c_state)
            RO:      n_state = d_in ? RO : RZ;
            RZ:      n_state = d_in ? Z2O : RZ;
            Z2O:     n_state = d_in ? RO : Z2O2Z;
            Z2O2Z:   n_state = d_in ? Z2O : RZ;
            default: n_state = RO;
        endcase
    end

    //Part 3: Determine ouput
    always @(*) begin
        case (c_state)
            RO:      d_out = d_in ? 0 : 0;
            RZ:      d_out = d_in ? 0 : 0;
            Z2O:     d_out = d_in ? 0 : 0;
            Z2O2Z:   d_out = d_in ? 1 : 0;
            default: d_out = 1'bX;
        endcase
    end
endmodule