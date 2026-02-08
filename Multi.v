module multiply(M, Q, Result);

input [31:0] M, Q;
output [63:0] Result;

reg [63:0] Result;
reg [31:0] M_Comp;
reg q_zero;
integer i;

twos_comp comp(M, M_Comp);

always@(M or Q) 
begin
	Result = {32'b0, Q};
	q_zero = 1'b0;
	for(i = 0; i < 32; i = i + 1)
	begin
		if (!Result[0] & q_zero) begin //-1
			Result = Result + {M_Comp, 32'b0};
		end
		else if (Result[0] & !q_zero) begin //+1
			Result = Result + {M, 32'b0};
		end
		q_zero = Result[0];
		Result = Result >>> 1;
	end
end
endmodule