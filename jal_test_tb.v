`timescale 1ns/10ps

module jal_test_tb;

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
          Reg_load2a = 5'b00111,
          Reg_load2b = 5'b01000,
          Reg_load2c = 5'b01001,
          Reg_load2d = 5'b01010,
          Reg_load2e = 5'b01011,
          Reg_load2f = 5'b01100,
          Reg_load3a = 5'b01101,
          Reg_load3b = 5'b01110,
          T0         = 5'b01111,
          T1         = 5'b10000,
          T2         = 5'b10001,
          T3         = 5'b10010,
          T4         = 5'b10011;

reg [4:0] Present_state = Default;

DataPath DP(
    clock, clear, read, write,
    HIin, LOin, RZin, PCin, MDRin, ALUin, IncPC, CONin, Outportin, PCbranch,
    HIout, LOout, ZHIout, ZLOout, PCout, MDRout, inportout,
    MARin, IRin, RYin, Gra, Grb, Grc, Rin, Rout, BAout, Cout, inportdata
);

initial begin
    clock = 0;
    forever #10 clock = ~clock;
end

initial begin
    $readmemh("C:/Users/owner/OneDrive/Desktop/Verilog Files/memoryinit.mem", DP.memory.RAM1);
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
        Reg_load1f : Present_state = Reg_load2a;
        Reg_load2a : Present_state = Reg_load2b;
        Reg_load2b : Present_state = Reg_load2c;
        Reg_load2c : Present_state = Reg_load2d;
        Reg_load2d : Present_state = Reg_load2e;
        Reg_load2e : Present_state = Reg_load2f;
        Reg_load2f : Present_state = Reg_load3a;
        Reg_load3a : Present_state = Reg_load3b;
        Reg_load3b : Present_state = T0;
        T0         : Present_state = T1;
        T1         : Present_state = T2;
        T2         : Present_state = T3;
        T3         : Present_state = T4;
    endcase
end

always @(Present_state) begin
    case(Present_state)
		
    Default: begin
        read    <= 0;
        write   <= 0;
        clear   <= 1;
		  
        HIin <= 0; LOin <= 0;
        RZin <= 0; PCin <= 0; MDRin <= 0; ALUin <= 0; IncPC <= 0; CONin <= 0; Outportin <= 0; PCbranch <= 0;
		  
        HIout <= 0; LOout <= 0; ZHIout <= 0; ZLOout <= 0; PCout <= 0; MDRout <= 0; inportout <= 0;

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

    Reg_load2a: begin
         PCout <= 1; MARin <= 1; IncPC <= 1; 
         #15 PCout <= 0; MARin <= 0; IncPC <= 0; 
    end

    Reg_load2b: begin
        read <= 1; MDRin <= 1;
        #15 read <= 0; MDRin <= 0;
    end

    Reg_load2c: begin
        MDRout <= 1; IRin <= 1; ALUin <= 1;
        #15 MDRout <= 0; IRin <= 0; ALUin <= 0;
    end

    Reg_load2d: begin
        #1 Grb <= 1; BAout <= 1; RYin <= 1;
        #15 Grb <= 0; BAout <= 0; RYin <= 0;
    end

    Reg_load2e: begin
        #1 Cout <= 1; RZin <= 1;
        #15 Cout <= 0; RZin <= 0;
    end
	 
    Reg_load2f: begin
        #1 ZLOout <= 1; Gra <= 1; Rin <= 1;
        #15 ZLOout <= 0; Gra <= 0; Rin <= 0;
    end


    Reg_load3a: begin
        #1 inportdata <= 32'h00000010;
    end

    Reg_load3b: begin
        #1 inportout <= 1; PCin <= 1;
        #15 inportout <= 0; PCin <= 0;
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
        #1 PCout <= 1; Rin <= 1;
        #15 PCout <= 0; Rin <= 0;
    end
	 
    T4: begin
        #1 Gra <= 1; Rout <= 1; PCin <= 1;
        #15 Gra <= 0; Rout <= 0; PCin <= 0;
    end

    endcase
end

endmodule