module instructionRegister #(parameter DATA_WIDTH_IN = 32, DATA_WIDTH_OUT = 32, INIT = 32'h0)(
    input clear,
    input clock,
    input enable,
    input [DATA_WIDTH_IN-1:0] BusMuxOut,
    input Gra, Grb, Grc, Rin, Rout, BAout, Cout,
    output wire [DATA_WIDTH_OUT-1:0] ControlIn,
	 output wire [3:0] c2,
	 output wire [DATA_WIDTH_OUT-1:0] BusMuxIn_IR,

    output reg R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in,
    output reg R12in, R13in, R14in, R15in,
    output reg R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out,
    output reg R11out, R12out, R13out, R14out, R15out
);

wire is_jal;
reg [DATA_WIDTH_IN-1:0] q;
reg [3:0] register_select;

reg [DATA_WIDTH_IN-1:0] c;

initial c = INIT;
initial q = INIT;


always @(negedge clock) begin
    if (clear) q <= INIT;          
    else if (enable) q <= BusMuxOut;
	 
		if (q[18]) begin
			c <= {13'h1FFF, q[18:0]};
		end
		else begin
			c <= {13'h0000, q[18:0]};
		end
end


assign is_jal = (q[31:27] == 5'b10011);

assign ControlIn = q[DATA_WIDTH_OUT-1:0];
assign c2 = q[22:19];
assign BusMuxIn_IR = c[DATA_WIDTH_OUT-1:0];

always @(*) begin
    // default
    register_select = 4'b0000;
	 
	 //Set all signals to 0
    {R0in,R1in,R2in,R3in,R4in,R5in,R6in,R7in,R8in,R9in,R10in,R11in,R12in,R13in,R14in,R15in} = 16'b0;
    {R0out,R1out,R2out,R3out,R4out,R5out,R6out,R7out,R8out,R9out,R10out,R11out,R12out,R13out,R14out,R15out} = 16'b0;

    // choose register field
    if (Gra)      register_select = q[26:23];
    else if (Grb) register_select = q[22:19];
    else if (Grc) register_select = q[18:15];
	 
	 

    // Rin decode
    if (Rin) begin
		  if (is_jal) begin
				R12in = 1'b1;
		  end
		  else begin
			  case (register_select)
					4'h0: R0in  = 1'b1;
					4'h1: R1in  = 1'b1;
					4'h2: R2in  = 1'b1;
					4'h3: R3in  = 1'b1;
					4'h4: R4in  = 1'b1;
					4'h5: R5in  = 1'b1;
					4'h6: R6in  = 1'b1;
					4'h7: R7in  = 1'b1;
					4'h8: R8in  = 1'b1;
					4'h9: R9in  = 1'b1;
					4'hA: R10in = 1'b1;
					4'hB: R11in = 1'b1;
					4'hC: R12in = 1'b1;
					4'hD: R13in = 1'b1;
					4'hE: R14in = 1'b1;
					4'hF: R15in = 1'b1;
			  endcase
		   end
    end

    // Rout/BAout decode
    if (Rout || BAout) begin
        case (register_select)
            4'h0: R0out  = 1'b1;
            4'h1: R1out  = 1'b1;
            4'h2: R2out  = 1'b1;
            4'h3: R3out  = 1'b1;
            4'h4: R4out  = 1'b1;
            4'h5: R5out  = 1'b1;
            4'h6: R6out  = 1'b1;
            4'h7: R7out  = 1'b1;
            4'h8: R8out  = 1'b1;
            4'h9: R9out  = 1'b1;
            4'hA: R10out = 1'b1;
            4'hB: R11out = 1'b1;
            4'hC: R12out = 1'b1;
            4'hD: R13out = 1'b1;
            4'hE: R14out = 1'b1;
            4'hF: R15out = 1'b1;
        endcase
    end
end

endmodule