module bitwise_not(
    input  wire [31:0] A,
    output reg  [31:0] Result
);

integer i;

always @(*) begin
    Result = 32'd0;

    for (i = 0; i < 32; i = i + 1) begin
        Result[i] = ~A[i];
    end
end
endmodule
