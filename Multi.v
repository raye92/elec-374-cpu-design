module multiply(M, Q, Result);

input [31:0] M, Q;
output [63:0] Result;

reg [63:0] Result;
reg [31:0] M_Comp;
integer i;

twos_comp comp(M, M_Comp);

always@(M or Q)
	Result = {32'b0, Q};
	
	for(i = 0; i < 64; i = i + i)
	begin
		if (!Result[1] & Result[0]) begin
			Result = Result + {M_Comp, 32'b0};
		end
		else if (Result[1] & !Result[0]) begin
			Result = Result + {M, 32'b0};
		end
		Result = Result >>> 1;
	end
endmodule