module Inport  #(parameter DATA_WIDTH_IN = 32, DATA_WIDTH_OUT = 32, INIT = 32'h0)(
	input clear,
	input clock,
	input [DATA_WIDTH_IN-1:0]inputdata,
	output wire [DATA_WIDTH_OUT-1:0]BusMuxIn_inport
);

reg [DATA_WIDTH_IN-1:0]q;
initial q = INIT;
always @(negedge clock)
		begin
			if (clear) begin 
				q <= {DATA_WIDTH_IN{1'b0}};
			end
			else begin
				q <= inputdata;
			end
		end
	assign BusMuxIn_inport = q[DATA_WIDTH_OUT-1:0];
endmodule


