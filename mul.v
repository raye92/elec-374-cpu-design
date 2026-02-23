module multiply(

input  wire signed [31:0] M,
input  wire 		 [31:0] Q,
output reg signed	 [63:0] result

);


integer i;

//creating accumulator reg    [65:33]   [32:1]   [0:0]
reg signed [65:0] acc; // // {A[32:0], Q[31:0], q_minus1}

always@(*) begin
	acc = {33'sd0, Q, 1'b0};

	
	for (i = 0; i < 32; i = i + 2) begin
		//0: 000, 111
		if ((~acc[2] & ~acc[1] & ~acc[0]) | (acc[2] & acc[1] & acc[0])) begin
			acc[65:33] = acc[65:33] + 0;
		end
		
		//+1: 001, 010
		else if ((~acc[2] & ~acc[1] & acc[0]) | (~acc[2] & acc[1] & ~acc[0])) begin
			acc[65:33] = acc[65:33] + {{1{M[31]}}, M};
		end
		
		//+2: 011
		else if (~acc[2] & acc[1] & acc[0]) begin
			acc[65:33] = acc[65:33] + ({{1{M[31]}}, M} <<< 1);
		end
		
		//-2: 100
		else if (acc[2] & ~acc[1] & ~acc[0]) begin
			acc[65:33] = acc[65:33] - ({{1{M[31]}}, M} <<< 1);
		end
		
		//-1: 101, 110
		else if ((acc[2] & ~acc[1] & acc[0]) | (acc[2] & acc[1] & ~acc[0])) begin
			acc[65:33] = acc[65:33] - {{1{M[31]}}, M};
		end
		
		acc = acc >>> 2;
	end
	result = acc[64:1];
end

endmodule