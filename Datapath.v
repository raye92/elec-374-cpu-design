module DataPath(

//Control Wires
	input wire clock, //change back to clock and comment out 18-33 for normal functionality again
	input wire reset,
	input wire stop,
	
	//inport data
	
	input wire [31:0] inportdata,
	
	output wire [31:0] Outportout,
	
	output wire run

	
);


wire [31:0] rawoutputdata;

// Control wires
wire HIin, LOin, RZin, PCin, MDRin, ALUin, IncPC;
wire HIout, LOout, ZHIout, ZLOout, PCout, MDRout, inportout;
wire MARin, IRin, RYin, Gra, Grb, Grc, Rin, Rout, BAout, Cout;
wire CONin, Outportin, PCbranch;
wire read, write, clear;
	
	
//Connector Wires

wire [31:0] BusMuxOut;

//R0_15
wire [31:0] BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, 
BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15;
//

// RHI/RLO
wire [31:0] BusMuxIn_HI, BusMuxIn_LO;
//

//Z wires
wire [63:0] Zregin;
wire [31:0] BusMuxInZ_HI, BusMuxInZ_LO;
//

//PC wires
wire [31:0] BusMuxIn_PC;
//

//MDR wires
wire [31:0] BusMuxIn_MDR;
wire [31:0] RAMin;
//

//MAR wires
wire [8:0] address;
//

//IR wires
wire [31:0] ControlIn;
wire [31:0] BusMuxIn_IR;
wire [3:0] c2;

wire R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, 
R10in, R11in, R12in, R13in, R14in, R15in;

wire R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out,
R11out, R12out, R13out, R14out, R15out;

//

//CON FF WIRES
wire branchbool;
//

wire [31:0] A;


//Devices
wire [31:0] BusMuxIn_inport;


wire [31:0] Mdatain;

//R0_15
registerzero R0(clear, clock, R0in, BAout, BusMuxOut, BusMuxIn_R0);
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

HI High(clear, clock, HIin, BusMuxOut, BusMuxIn_HI);
LO Low(clear, clock, LOin, BusMuxOut, BusMuxIn_LO);

//RZ
registerZ RZ(clear, clock, RZin, Zregin, BusMuxInZ_HI, BusMuxInZ_LO);
//PC

programCounter PC(clear, clock, PCin, PCbranch, branchbool, IncPC, BusMuxOut, BusMuxIn_PC);

//MDR
MDR MDR(BusMuxOut, Mdatain, read, clear, clock, MDRin, BusMuxIn_MDR, RAMin);

//MAR
MAR MAR(clear, clock, MARin, BusMuxOut, address);

//IR
instructionRegister IR(
clear, clock, IRin, BusMuxOut,

Gra, Grb, Grc, Rin, Rout, BAout, Cout, ControlIn, c2, BusMuxIn_IR,

R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, 
R10in, R11in, R12in, R13in, R14in, R15in,

R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out,
R11out, R12out, R13out, R14out, R15out

);

//inport
Inport inputport(clear, clock, inportdata, BusMuxIn_inport);
//outport
outport outputport(clear, clock, Outportin, BusMuxOut, rawoutputdata);

//Conditional FF Logic
conditionalFF conFF(clear, clock, CONin, BusMuxOut, c2, branchbool);

//RAM
RAM memory(read, write, clock, RAMin, address, Mdatain);

//RY
registerY RY(clear, clock, RYin, BusMuxOut, A);

//adder
alu arithmetic(A, BusMuxOut, clock, BusMuxOut[31:27], ALUin, Zregin);

//Bus

Bus bus(

BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, 
BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15,

BusMuxIn_HI, BusMuxIn_LO,

BusMuxInZ_HI, BusMuxInZ_LO,

BusMuxIn_PC,

BusMuxIn_MDR,

BusMuxIn_inport,

BusMuxIn_IR,

R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,

HIout, LOout,

ZHIout, ZLOout,
	
PCout,
	
MDRout,

inportout,

Cout,

BusMuxOut);

Seven_Seg_Display_Out segConverter0(Outportout[7:0], rawoutputdata[3:0]);
Seven_Seg_Display_Out segConverter1(Outportout[15:8], rawoutputdata[7:4]);
Seven_Seg_Display_Out segConverter2(Outportout[23:16], rawoutputdata[11:8]);
Seven_Seg_Display_Out segConverter3(Outportout[31:24], rawoutputdata[15:12]);

// Control Unit
control_unit CU(
    .HIin(HIin),
    .LOin(LOin),
    .RZin(RZin),
    .PCin(PCin),
    .MDRin(MDRin),
    .ALUin(ALUin),
    .IncPC(IncPC),

    .HIout(HIout),
    .LOout(LOout),
    .ZHIout(ZHIout),
    .ZLOout(ZLOout),
    .PCout(PCout),
    .MDRout(MDRout),
    .inportout(inportout),

    .MARin(MARin),
    .IRin(IRin),
    .RYin(RYin),
    .Gra(Gra),
    .Grb(Grb),
    .Grc(Grc),
    .Rin(Rin),
    .Rout(Rout),
    .BAout(BAout),
    .Cout(Cout),

    .CONin(CONin),
    .Outportin(Outportin),
    .PCbranch(PCbranch),

    .read(read),
    .write(write),
    .clear(clear),

    .clock(clock),
    .reset(reset),
    .stop(stop),
    .IR_input(ControlIn),

    .run(run)
);

endmodule