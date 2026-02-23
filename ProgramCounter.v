
module programCounter #(parameter DATA_WIDTH_IN = 32, DATA_WIDTH_OUT = 32, INIT = 32'h0)(
input clear,
input clock,
input enable,
input IncPC,
input [DATA_WIDTH_IN-1:0]BusMuxOut,

output wire [DATA_WIDTH_OUT-1:0]BusMuxInPC
);

reg [DATA_WIDTH_IN-1:0]q;
initial q = INIT;

reg [DATA_WIDTH_IN-1:0]next_pc;
initial next_pc = INIT;
reg carry;
integer i;

always @(*) begin
	if (IncPC) begin
		carry = 1'b1;
		for (i = 0; i < DATA_WIDTH_IN; i = i + 1) begin
			next_pc[i] = q[i] ^ carry;
			carry = q[i] & carry;		
		end
	end
end


always @(negedge clock)
		begin
			if (enable) begin
				q <= BusMuxOut;
			end
			else if (IncPC) begin
				q <= next_pc;
			end
		end
	assign BusMuxInPC = q[DATA_WIDTH_OUT-1:0];
	
endmodule