
module programCounter #(parameter DATA_WIDTH_IN = 32, DATA_WIDTH_OUT = 32, INIT = 32'h0)(
input clear,
input clock,
input enable,
input [DATA_WIDTH_IN-1:0]BusMuxOut,

output wire [DATA_WIDTH_OUT-1:0]BusMuxInPC
)

reg [DATA_WIDTH_IN-1:0]q;
initial q = INIT;

always @(posedge clock)
		begin
			if (enable) begin
				q <= BusMuxOut;
			end
		end
	assign BusMuxInPC = q[DATA_WIDTH_OUT-1:0];
endmodule