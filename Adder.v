module adder(
    input  wire [31:0] A,
    input  wire [31:0] B,
    output reg  [63:0] Result
);

reg [32:0] LocalCarry;
integer i;

     always @(*) begin
            Result     = 64'd0;     // clear upper and carry bits
            LocalCarry = 33'd0;
                    for (i = 0; i < 32; i = i + 1) begin
                        Result[i]      = A[i] ^ B[i] ^ LocalCarry[i];
                        LocalCarry[i+1]= (A[i] & B[i]) | (LocalCarry[i] & (A[i] | B[i]));
                    end
                    Result[32] = LocalCarry[32]; // carry-out
                end
endmodule