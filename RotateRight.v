module rotate_right(
    input  wire [31:0] A,
    output reg  [31:0] Result
);

    always @(*) begin
        Result = {A[0], A[31:1]};   // bit zero wraps, rest shifts right
    end

endmodule
