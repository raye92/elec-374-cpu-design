module twos_comp(B, B_Comp);

input [31:0] B;
output [31:0] B_Comp;

reg [31:0] B_Comp;

always@(B)
	begin
		B_Comp = ~B + 1;
	end
endmodule
