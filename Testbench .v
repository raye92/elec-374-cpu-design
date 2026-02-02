`timescale 1ns/10ps

module tutorial_tb();

reg clock, clear, read, R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in,
HIin, LOin, RZin, PCin, MDRin,
R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
HIout, LOout, RZout, PCout, MDRout, 
MARin, IRin, RYin, BusImmon;

reg[31:0] BusImmediate;

reg[3:0] present_state;

DataPath DP(
clock, clear, read, compute, R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in,
HIin, LOin, RZin, PCin, MDRin,
R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
HIout, LOout, RZout, PCout, MDRout, 
MARin, IRin, RYin, BusImmon, BusImmediate
);

parameter init= 4'd1, T0 = 4'd2, T1 = 4'd3, T2 = 4'd4, T3 = 4'd5, T4 = 4'd6;

initial begin clock = 0; present_state = 4'd0; end
always #10 clock = ~clock;
always @ (negedge clock) present_state = present_state + 1;

always @(present_state) begin
	case(present_state)
		init: begin
			clear <= 1;
			read <= 0;
			compute <= 0;
			R0in <= 0; R1in <= 0; R2in <= 0; R3in <= 0; R4in <= 0; R5in <= 0; R6in <= 0; R7in <= 0;
			R8in <= 0; R9in <= 0; R10in <= 0; R11in <= 0; R12in <= 0; R13in <= 0; R14in <= 0; R15in <= 0;
			HIin <= 0; LOin <= 0;
			RZin <= 0; PCin <= 0; MDRin <= 0;
			R0out <= 0; R1out <= 0; R2out <= 0; R3out <= 0; R4out <= 0; R5out <= 0; R6out <= 0;
			R7out <= 0; R8out <= 0; R9out <= 0; R10out <= 0; R11out <= 0; R12out <= 0; R13out <= 0; R14out <= 0; R15out <= 0;
			HIout <= 0; LOout <= 0; RZout <= 0; PCout <= 0; MDRout <= 0;
			MARin <= 0; IRin <= 0; RYin <= 0; BusImmon <= 0;
		
			BusImmediate <= 32'h00;
		
			#15 clear <= 0;
		end
		//load r0in with immediate bus input
		T0: begin
			BusImmediate <= 32'd5; BusImmon <= 1;
			R0in <= 1;
			#15 BusImmediate <= 32'h0000; BusImmon <= 0; R0in <= 0;
		end
	
		T1: begin
			BusImmediate <= 32'd10; BusImmon = 1;
			R1in <= 1;
			#15 BusImmediate <= 32'h0000; BusImmon = 0; R1in = 0;
		end
	
		T2: begin
			R0out <= 1; RYin <= 1;
			#15 R0out <= 0; RYin <= 0;
		end
	
		T3: begin
			R1out <= 1; compute <= 1; RZin <= 1;
			#15 R1out <= 0; compute <= 0; RZin <= 0;
		T4: begin
			RZout <= 1; R2in <= 1; 
			#15 RZout <= 0; R2in <= 0; 
		end
	endcase
end
endmodule
		
		

