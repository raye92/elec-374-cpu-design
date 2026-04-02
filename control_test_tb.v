`timescale 1ns/10ps

module control_test_tb;

reg clock;
reg reset;
reg stop;
reg [31:0] inportdata;

wire [31:0] Outportout;
wire run;

DataPath DP(
    clock,
    reset,
    stop,
    inportdata,
    Outportout,
	 run
);

initial begin
    clock = 0;
    forever #10 clock = ~clock;
end

initial begin
    $readmemh("C:/Users/owner/OneDrive/Desktop/Verilog Files/memoryinit.mem", DP.memory.RAM1);
end

initial begin
    reset = 1'b1;
    stop = 1'b0;
    inportdata = 32'h000000E0;

    #35;
    reset = 1'b0;
end

initial begin
    #8000;
    
end

endmodule