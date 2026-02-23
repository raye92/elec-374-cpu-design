module divide
(

input  wire 		 [31:0] Q, //Dividend
input  wire 		 [31:0] M, //Divisor
output reg 			 [63:0] result

);


integer i;

//creating accumulator reg    [64:32]   [31:0]   
reg signed [64:0] acc; // // {A[32:0], Q[31:0],} 


wire sign_q = Q[31];
wire sign_m = M[31];
wire quot_neg = sign_q ^ sign_m;
wire 	rem_neg = sign_q;

wire signed [32:0] Qw = {Q[31], Q};
wire signed [32:0] Mw = {M[31], M};

wire [31:0]q_mag = sign_q ? (~Qw[31:0] + 1'b1) : Q;
wire [31:0]m_mag = sign_m ? (~Mw[31:0] + 1'b1) : M;

wire [31:0] quot_u = acc[31:0];
wire [31:0] rem_u = acc[63:32];

wire [31:0] quot_out = quot_neg ? (~quot_u + 1'b1) : quot_u;
wire [31:0] rem_out = rem_neg ? (~rem_u + 1'b1) : rem_u;

always@(*) begin
	acc = {33'sd0, q_mag};

	
	for (i = 0; i < 32; i = i + 1) begin
		acc = acc <<< 1; // shift a bit of dividend
		if (acc[64]) begin // if negative, try adding divisor
			acc[64:32] = acc[64:32] + {1'b0, m_mag};
			
			if (acc[64]) begin //if still negative, then it doesnt yet fit
				acc[0] = 1'b0;
			end
			
			else begin //if sign swapped then it fit
				acc[0] = 1'b1;
			end
			
		end
		
		else begin
			acc[64:32] = acc[64:32] - {1'b0, m_mag};
			if (acc[64]) begin
				acc[0] = 1'b0;
			end
			
			else begin
				acc[0] = 1'b1;
			end
		end
	end
	
	if (acc[64]) acc[64:32] = acc[64:32] + {1'b0, m_mag}; // Final Restore if needed 
	
	result = {rem_out, quot_out};// {remainder[63:32], quotient [31:0]}
	
end

endmodule