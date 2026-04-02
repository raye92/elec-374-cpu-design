`timescale 1ns/10ps

module Initialtestbench;

//INPUTS TO DP
reg clock, clear, read, compute;

reg R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in,
    R12in, R13in, R14in, R15in;

reg HIin, LOin, RZin, PCin, MDRin;

reg R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out,
    R11out, R12out, R13out, R14out, R15out;

reg HIout, LOout, ZHIout, ZLOout, PCout, MDRout;

reg MARin, IRin, RYin;

reg [31:0] Mdatain;	

parameter Default   = 4'b0000,
          Reg_load1a = 4'b0001,
          Reg_load1b = 4'b0010,
          Reg_load2a = 4'b0011,
          Reg_load2b = 4'b0100,
          Reg_load3a = 4'b0101,
          Reg_load3b = 4'b0110,
          T0        = 4'b0111,
          T1        = 4'b1000,
          T2        = 4'b1001,
          T3        = 4'b1010,
          T4        = 4'b1011,
          T5        = 4'b1100;

reg [3:0] Present_state = Default;

DataPath DP(
    clock, clear, read, compute,
    R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in,
    HIin, LOin, RZin, PCin, MDRin,
    R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
    HIout, LOout, ZHIout, ZLOout, PCout, MDRout,
    MARin, IRin, RYin, Mdatain
);

initial begin
    clock = 0;
    forever #10 clock = ~clock;
end

always @(posedge clock) begin
    case (Present_state)
        Default   : Present_state = Reg_load1a;
        Reg_load1a: Present_state = Reg_load1b;
        Reg_load1b: Present_state = Reg_load2a;
        Reg_load2a: Present_state = Reg_load2b;
        Reg_load2b: Present_state = Reg_load3a;
        Reg_load3a: Present_state = Reg_load3b;
        Reg_load3b: Present_state = T0;
        T0        : Present_state = T1;
        T1        : Present_state = T2;
        T2        : Present_state = T3;
        T3        : Present_state = T4;
        T4        : Present_state = T5;
    endcase
end

always @(Present_state) 
	begin
		case(Present_state)
		
		Default: begin
        read    <= 0;
        compute <= 0;
		  clear   <= 1;

        R0in <= 0; R1in <= 0; R2in <= 0; R3in <= 0; R4in <= 0; R5in <= 0; R6in <= 0; R7in <= 0;
        R8in <= 0; R9in <= 0; R10in <= 0; R11in <= 0; R12in <= 0; R13in <= 0; R14in <= 0; R15in <= 0;

        HIin <= 0; LOin <= 0;
        RZin <= 0; PCin <= 0; MDRin <= 0;

        R0out <= 0; R1out <= 0; R2out <= 0; R3out <= 0; R4out <= 0; R5out <= 0; R6out <= 0;
        R7out <= 0; R8out <= 0; R9out <= 0; R10out <= 0; R11out <= 0; R12out <= 0; R13out <= 0; R14out <= 0; R15out <= 0;

        HIout <= 0; LOout <= 0; ZHIout <= 0; ZLOout <=0; PCout <= 0; MDRout <= 0;

        MARin <= 0; IRin <= 0; RYin <= 0; Mdatain <= 32'h00000000;
		  
		  #10 clear <= 0;
		  
    end

    Reg_load1a: begin
		  #1 Mdatain <= 32'h00000010;
        //read = 0; MDRin = 0; clear = 0;
        read <= 1; MDRin <= 1;
        #15 read <= 0; MDRin <= 0;
    end

    Reg_load1b: begin
        #1 MDRout <= 1; R1in <= 1;
        #15 MDRout <= 0; R1in <= 0;
    end

    Reg_load2a: begin
        #1 Mdatain <= 32'h00000015;
        read <= 1; MDRin <= 1;
        #15 read <= 0; MDRin <= 0;
	 end

    Reg_load2b: begin
        #1 MDRout <= 1; R2in <= 1;
        #15 MDRout <= 0; R2in <= 0;
    end

    Reg_load3a: begin
        #1 Mdatain <= 32'h00000054;
        read <= 1; MDRin <= 1;
        #15 read <= 0; MDRin <= 0;
	end
    Reg_load3b: begin
        #1 MDRout <= 1; R3in <= 1;
        #15 MDRout <= 0; R3in <= 0;
    end

    T0: begin
        // PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1;
    end

    T1: begin
        // Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
        // Mdatain <= 32'h01890000; // opcode for "add R3, R1, R2"
    end

    T2: begin
        // MDRout <= 1; IRin <= 1;
    end

    T3: begin
        #1 R1out <= 1; RYin <= 1;
        #15 R1out <= 0; RYin <= 0;
    end

    T4: begin
        // compute = ADD signal
        #1 R2out <= 1; #1 compute <= 1; RZin <= 1;
        #14 R2out <= 0; compute <= 0; RZin <= 0;
		  
    end

    T5: begin
        #1 ZLOout <= 1; R3in <= 1;
        #15 ZLOout <= 0; R3in <= 0;
    end

    endcase
end

endmodule
