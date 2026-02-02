module adder(A, B, Control, Result);

input [31:0] A, B;
input Control;
output [31:0] Result;

reg [31:0] Result;
reg [31:0] SignedB;
reg [32:0] LocalCarry;

integer i;

always@(A or B or Control)
	begin
		LocalCarry = 33'd0;
		if (Control) begin
			SignedB = ~B + 1;
		end
		for(i = 0; i < 32; i = i + 1)
		begin
			Result[i] = A[i]^SignedB[i]^LocalCarry[i];
			LocalCarry[i+1] = (A[i] & SignedB[i])|(LocalCarry[i] & (A[i]|SignedB[i]));
		end
	end
endmodule