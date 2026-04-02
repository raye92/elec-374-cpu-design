module MDR #(parameter DATA_WIDTH_IN = 32, DATA_WIDTH_OUT = 32, INIT = 32'h0) (
	input [DATA_WIDTH_IN-1:0]BusMuxOut,
	input [DATA_WIDTH_IN-1:0]Mdatain,
	input read,
	input clear,
	input clock,
	input enable,
	
	output wire [DATA_WIDTH_OUT-1:0]BusMuxInMDR,
	output wire [DATA_WIDTH_OUT-1:0]RAMin

);

reg [DATA_WIDTH_IN-1:0]q
initial q = INIT;

always @(posedge clock) 
		begin
			if (clear) begin
				q <= {DATA_WIDTH_IN{1'b0}};
			end
			if (enable) begin
				if (read) begin
					q <= Mdatain;
				end
				else begin
					q <= BusMuxOut;
				end
			end
		end
	assign BusMuxInMDR = q[DATA_WIDTH_OUT-1:0];
	assign RAMin = q[DATA_WIDTH_OUT-1:0];

endmodule