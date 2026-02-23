module subtractor(
input wire [31:0] A,
input wire [31:0] B,
output wire [63:0] result

);



reg [31:0] negated_b;
integer i;
reg carry;
reg oldbit;

always @(*) begin
	 carry = 1'b1;

    for (i = 0; i < 32; i = i + 1) begin
        oldbit = ~B[i];
		  negated_b[i] = oldbit ^ carry;
		  carry = oldbit & carry;
    end
end

adder add_negate(A, negated_b, result);

endmodule
