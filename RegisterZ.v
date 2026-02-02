module registerZ #(parameter DATA_WIDTH_IN = 64, DATA_WIDTH_OUT = 32, INIT = 64'h0)(
	input clear,
	input clock,
	input enable,
	
	input [DATA_WIDTH_IN-1:0]Zregin,
	output wire [DATA_WIDTH_OUT-1:0]BusMuxInZ_HI,
	output wire [DATA_WIDTH_OUT-1:0]BusMuxInZ_LO
);

reg [DATA_WIDTH_IN-1:0]q;
initial q = INIT;

always @(posedge clock)
		begin
			if (clear) begin 
				q <= {DATA_WIDTH_IN{1'b0}};
			end
			else if (enable) begin
				q <= Zregin;
			end
		end
	assign BusMuxInZ_HI = q[DATA_WIDTH_IN-1: DATA_WIDTH_OUT]; // 63-32
	assign BusMuxInZ_LO = q[DATA_WIDTH_OUT-1:0]; //31 - 0
endmodule