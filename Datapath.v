module DataPath(

//Control Wires
	input wire clock,
	
	input wire clear,
	input wire read,
	
	//Register Controls
	input wire R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in,
	
	input wire HIin, LOin,
	
	input wire RZin,
	
	input wire PCin,
	
	input wire MDRin,
	
	//Bus Controls
	input wire R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
	
	input wire HIout, LOout,
	
	input wire RZout,
	
	input wire PCout,
	
	input wire MDRout,
	
	
	input wire MARin,
	
	input wire IRin,
	
	input wire RYin
);
	
	
	
	
//Connector Wires

wire [31:0] BusMuxOut;

//R0-15
wire [31:0] BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, 
BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15;

// RHI/RLO
wire [31:0] BusMuxIn_HI, BusMuxIn_LO;

//Z wires
wire [63:0] Zregin;
wire [31:0] BusMuxInZ_HI, BusMuxInZ_LO;

//PC wires
wire [31:0] BusMuxIn_PC;

//MDR wires
wire [31:0] BusMuxIn_MDR;
wire [31:0] Mdatain;
wire [31:0] RAMIn;

//MAR wires
wire [31:0] MemoryIn;

//IR wires
wire [31:0] ControlIn;

wire [31:0] A;


//Devices


//R0-15
Register R0(clear, clock, R0in, BusMuxOut, BusMuxIn_R0);
Register R1(clear, clock, R1in, BusMuxOut, BusMuxIn_R1);
Register R2(clear, clock, R2in, BusMuxOut, BusMuxIn_R2);
Register R3(clear, clock, R3in, BusMuxOut, BusMuxIn_R3);
Register R4(clear, clock, R4in, BusMuxOut, BusMuxIn_R4);
Register R5(clear, clock, R5in, BusMuxOut, BusMuxIn_R5);
Register R6(clear, clock, R6in, BusMuxOut, BusMuxIn_R6);
Register R7(clear, clock, R7in, BusMuxOut, BusMuxIn_R7);
Register R8(clear, clock, R8in, BusMuxOut, BusMuxIn_R8);
Register R9(clear, clock, R9in, BusMuxOut, BusMuxIn_R9);
Register R10(clear, clock, R10in, BusMuxOut, BusMuxIn_R10);
Register R11(clear, clock, R11in, BusMuxOut, BusMuxIn_R11);
Register R12(clear, clock, R12in, BusMuxOut, BusMuxIn_R12);
Register R13(clear, clock, R13in, BusMuxOut, BusMuxIn_R13);
Register R14(clear, clock, R14in, BusMuxOut, BusMuxIn_R14);
Register R15(clear, clock, R15in, BusMuxOut, BusMuxIn_R15);

// RHI/RLO

HI HI(clear, clock, HIin, BusMuxOut, BusMuxIn_HI);
LO LO(clear, clock, LOin, BusMuxOut, BusMuxIn_LO);

//RZ
registerZ RZ(clear, clock, RZin, Zregin, BusMuxInZ_HI, BusMuxInZ_LO);

//PC

programCounter PC(clear, clock, PCin, BusMuxOut, BusMuxIn_PC);

//MDR
MDR MDR(BusMuxOut, Mdatain, read, clear, clock, MDRin, BusMuxIn_MDR, RAMIn);

//MAR
MAR MAR(clear, clock, MARin, BusMuxOut, MemoryIn);

//IR
instructionRegister IR(clear, clock, IRin, BusMuxOut, ControlIn);

//RY
registerY RY(clear, clock, RYin, BusMuxOut, A);

//adder
adder add(A, BusMuxOut, Zregin);

//Bus

Bus bus(

BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, 
BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15,

BusMuxIn_HI, BusMuxIn_LO,

BusMuxInZ_HI, BusMuxInZ_LO,

BusMuxIn_PC,

BusMuxIn_MDR,

R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,

HIout, LOout,
	
RZout,
	
PCout,
	
MDRout,

BusMuxOut);




endmodule