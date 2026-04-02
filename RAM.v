module RAM (read, write, clk, datain, address, dataout);

input read;
input write;
input clk;
input [31:0] datain;
input [8:0] address;
output reg [31:0] dataout;

reg [31:0] RAM1 [0:511];

initial begin
    $readmemh("memoryinit.mem", RAM1);
end

always @(negedge clk) begin
    if (write) begin
        RAM1[address] <= datain;
    end
end

always @(*) begin
    if (read)
        dataout = RAM1[address];
    else
        dataout = 32'b0;
end

endmodule