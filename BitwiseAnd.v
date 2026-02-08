module bitwise_and(
    input  wire [31:0] A,
    input  wire [31:0] B,
    output reg  [31:0] Result
);

integer i;

always @(*) begin
    Result = 32'd0;

    for (i = 0; i < 32; i = i + 1) begin
        Result[i] = A[i] & B[i];
    end
end
endmodule
