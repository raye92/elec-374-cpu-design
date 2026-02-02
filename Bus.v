module Bus (
	//mux
	
	input [31:0] BusMuxIn_R0, input [31:0] BusMuxIn_R1, input [31:0] BusMuxIn_R2, input [31:0] BusMuxIn_R3, input [31:0] BusMuxIn_R4, 
	input [31:0] BusMuxIn_R5, input [31:0] BusMuxIn_R6, input [31:0] BusMuxIn_R7, input [31:0] BusMuxIn_R8, input [31:0] BusMuxIn_R9, 
	input [31:0] BusMuxIn_R10, input [31:0] BusMuxIn_R11, input [31:0] BusMuxIn_R12, input [31:0] BusMuxIn_R13, input [31:0] BusMuxIn_R14, 
	input [31:0] BusMuxIn_R15,
	
	input [31:0]BusMuxIn_HI, input [31:0]BusMuxIn_LO,
	
	input [31:0]BusMuxIn_Z_HI, input [31:0]BusMuxIn_Z_LO,
	
	input [31:0]BusMuxIn_PC,
	
	input [31:0]BusMuxIn_MDR,
	
	//encoder
	
	input R0out, input R1out, input R2out, input R3out, input R4out, input R5out, input R6out, input R7out, input R8out, 
	input R9out, input R10out, input R11out, input R12out, input R13out, input R14out, input R15out,
	
	input HIout, input LOout,
	
	input ZHIout, input ZLOout,
	
	input PCout,
	
	input MDRout,
	
	output wire [31:0]BusMuxOut
	
);

reg [31:0]q;

always @ (*) begin
	if (R0out)   q = BusMuxIn_R0;
    if (R1out)   q = BusMuxIn_R1;
    if (R2out)   q = BusMuxIn_R2;
    if (R3out)   q = BusMuxIn_R3;
    if (R4out)   q = BusMuxIn_R4;
    if (R5out)   q = BusMuxIn_R5;
    if (R6out)   q = BusMuxIn_R6;
    if (R7out)   q = BusMuxIn_R7;
    if (R8out)   q = BusMuxIn_R8;
    if (R9out)   q = BusMuxIn_R9;
    if (R10out)  q = BusMuxIn_R10;
    if (R11out)  q = BusMuxIn_R11;
    if (R12out)  q = BusMuxIn_R12;
    if (R13out)  q = BusMuxIn_R13;
    if (R14out)  q = BusMuxIn_R14;
    if (R15out)  q = BusMuxIn_R15;

    if (HIout)   q = BusMuxIn_HI;
    if (LOout)   q = BusMuxIn_LO;

    if (ZHIout)  q = BusMuxIn_Z_HI;
    if (ZLOout)  q = BusMuxIn_Z_LO;

    if (PCout)   q = BusMuxIn_PC;
	
	if (MDRout)	 q = BusMuxIn_MDR;
end

assign BusMuxOut = q;
endmodule