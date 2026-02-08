module rotate_left(
    input  wire [31:0] A,
    output reg  [31:0] Result
);

    always @(*) begin
        Result = {A[30:0], A[31]};  // bits 31:1 go left, bit 0 position gets bit 31
    end

endmodule
