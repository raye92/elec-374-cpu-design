`timescale 1ns/10ps

module ld_test2_tb;

//INPUTS TO DP
reg clock, clear, read, write;

reg HIin, LOin, RZin, PCin, MDRin, ALUin, IncPC;
reg HIout, LOout, ZHIout, ZLOout, PCout, MDRout, inportout;
reg MARin, IRin, RYin;
reg Gra, Grb, Grc, Rin, Rout, BAout, Cout;
reg CONin, Outportin, PCbranch;
reg [31:0] inportdata;	

parameter Default    = 5'b00000,
          Reg_load1a = 5'b00001,
          Reg_load1b = 5'b00010,
          Reg_load1c = 5'b00011,
          Reg_load1d = 5'b00100,
          Reg_load1e = 5'b00101,
          Reg_load1f = 5'b00110,
          Reg_load1g = 5'b00111,
          Reg_load1h = 5'b01000,
          T0         = 5'b01001,
          T1         = 5'b01010,
          T2         = 5'b01011,
          T3         = 5'b01100,
          T4         = 5'b01101,
          T5         = 5'b01110,
          T6         = 5'b01111,
          T7         = 5'b10000;

reg [4:0] Present_state = Default;

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
        Reg_load1f : Present_state = Reg_load1g;
        Reg_load1g : Present_state = Reg_load1h;
		  Reg_load1h : Present_state = T0;
        T0         : Present_state = T1;
        T1         : Present_state = T2;
        T2         : Present_state = T3;
        T3         : Present_state = T4;
        T4         : Present_state = T5;
        T5         : Present_state = T6;
        T6         : Present_state = T7;
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
        #1 ZLOout <= 1; MARin <= 1;
        #15 ZLOout <= 0; MARin <= 0;
    end
	 
    Reg_load1g: begin
        #1 read <= 1; MDRin <= 1;
        #15 read <= 0; MDRin <= 0;
    end
	 
	 Reg_load1h: begin
        #1 MDRout <= 1; Gra <= 1; Rin <= 1;
        #15 MDRout <= 0; Gra <= 0; Rin <= 0;
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
        #1 Grb <= 1; BAout <= 1; RYin <= 1;
        #15 Grb <= 0; BAout <= 0; RYin <= 0;
    end

    T4: begin
        #1 Cout <= 1; RZin <= 1;
        #15 Cout <= 0; RZin <= 0;
		  
    end
	 
	 T5: begin
        #1 ZLOout <= 1; MARin <= 1;
        #15 ZLOout <= 0; MARin <= 0;
    end
	 
	 T6: begin
        #1 read <= 1; MDRin <= 1;
        #15 read <= 0; MDRin <= 0;
		  
	 end
	 
	 T7: begin
        #1 MDRout <= 1; Gra <= 1; Rin <= 1;
        #15 MDRout <= 0; Gra <= 0; Rin <= 0;
	 end

    endcase
end

endmodule
