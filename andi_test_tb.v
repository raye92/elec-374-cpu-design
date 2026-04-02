`timescale 1ns/10ps

module andi_test_tb;

//INPUTS TO DP
reg clock, clear, read, write;

reg HIin, LOin, RZin, PCin, MDRin, ALUin, IncPC;
reg HIout, LOout, ZHIout, ZLOout, PCout, MDRout, inportout;
reg MARin, IRin, RYin;
reg Gra, Grb, Grc, Rin, Rout, BAout, Cout;
reg CONin, Outportin, PCbranch;
reg [31:0] inportdata;	

parameter Default    = 4'b0000,
          Reg_load1a = 4'b0001,
          Reg_load1b = 4'b0010,
          Reg_load1c = 4'b0011,
          Reg_load1d = 4'b0100,
          Reg_load1e = 4'b0101,
          Reg_load1f = 4'b0110,
          T0         = 4'b0111,
          T1         = 4'b1000,
          T2         = 4'b1001,
          T3         = 4'b1010,
          T4         = 4'b1011,
          T5         = 4'b1100;

reg [3:0] Present_state = Default;

DataPath DP(
    clock, clear, read, write,
    HIin, LOin, RZin, PCin, MDRin, ALUin, IncPC, CONin, Outportin, PCbranch,
    HIout, LOout, ZHIout, ZLOout, PCout, MDRout,inportout,
    MARin, IRin, RYin, Gra, Grb, Grc, Rin, Rout, BAout, Cout, inportdata
);

initial begin
    clock = 0;
    forever #10 clock = ~clock;
end

initial begin
    $readmemh("C:/Users/owner/OneDrive/Desktop/Verilog Files/memoryinit.mem", DP.memory.RAM1);
//	 DP.memory.RAM1[0]      = 32'h83800065;
//    DP.memory.RAM1[9'h065] = 32'h00000084;
	 #1;
    $display("RAM[0]   = %h", DP.memory.RAM1[0]);
    $display("RAM[101] = %h", DP.memory.RAM1[9'h065]);
end

always @(posedge clock) begin
    case (Present_state)
        Default    : Present_state = Reg_load1a;
        Reg_load1a : Present_state = Reg_load1b;
        Reg_load1b : Present_state = Reg_load1c;
        Reg_load1c : Present_state = Reg_load1d;
        Reg_load1d : Present_state = Reg_load1e;
        Reg_load1e : Present_state = Reg_load1f;
        Reg_load1f : Present_state = T0;
        T0         : Present_state = T1;
        T1         : Present_state = T2;
        T2         : Present_state = T3;
        T3         : Present_state = T4;
        T4         : Present_state = T5;
    endcase
end

always @(Present_state) 
	begin
		case(Present_state)
		
		Default: begin
        read    <= 0;
        write   <= 0;
		  clear   <= 1;
		  
        HIin <= 0; LOin <= 0;
        RZin <= 0; PCin <= 0; MDRin <= 0; ALUin <= 0; IncPC <= 0; CONin <= 0; Outportin <= 0; PCbranch <= 0;
		  
        HIout <= 0; LOout <= 0; ZHIout <= 0; ZLOout <=0; PCout <= 0; MDRout <= 0; inportout <= 0;

        MARin <= 0; IRin <= 0; RYin <= 0; 
		  
		  Gra <= 0; Grb <= 0; Grc <= 0; Rin <= 0; Rout <= 0; BAout <= 0; Cout <= 0;
		  
		  inportdata <= 32'h00000000;
		  
		  #10 clear <= 0;
		  
    end

    Reg_load1a: begin
         PCout <= 1; MARin <= 1; IncPC <= 1; 
         #15 PCout <= 0; MARin <= 0; IncPC <= 0; 
    end

    Reg_load1b: begin
        read <= 1; MDRin <= 1;
        #15 read <= 0; MDRin <= 0;
    end

    Reg_load1c: begin
        MDRout <= 1; IRin <= 1; ALUin <= 1;
        #15 MDRout <= 0; IRin <= 0; ALUin <= 0;
    end

    Reg_load1d: begin
        #1 Grb <= 1; BAout <= 1; RYin <= 1;
        #15 Grb <= 0; BAout <= 0; RYin <= 0;
    end

    Reg_load1e: begin
        #1 Cout <= 1; RZin <= 1;
        #15 Cout <= 0; RZin <= 0;
    end
	 
    Reg_load1f: begin
        #1 ZLOout <= 1; Gra <= 1; Rin <= 1;
        #15 ZLOout <= 0; Gra <= 0; Rin <= 0;
    end
	 
    T0: begin
         PCout <= 1; MARin <= 1; IncPC <= 1; 
			#15 PCout <= 0; MARin <= 0; IncPC <= 0; 
    end

    T1: begin
        read <= 1; MDRin <= 1;
		  #15 read <= 0; MDRin <= 0;
    end

    T2: begin
        MDRout <= 1; IRin <= 1; ALUin <= 1;
		  #15 MDRout <= 0; IRin <= 0; ALUin <= 0;
    end

    T3: begin
        #1 Grb <= 1; Rout <= 1; RYin <= 1;
        #15 Grb <= 0; Rout <= 0; RYin <= 0;
    end

    T4: begin
        #1 Cout <= 1; RZin <= 1;
        #15 Cout <= 0; RZin <= 0;
		  
    end
	 
	 T5: begin
        #1 ZLOout <= 1; Gra <= 1; Rin <= 1;
        #15 ZLOout <= 0; Gra <= 0; Rin <= 0;
    end

    endcase
end

endmodule
