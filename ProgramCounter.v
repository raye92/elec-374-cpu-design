module programCounter #(parameter DATA_WIDTH_IN = 32, DATA_WIDTH_OUT = 32, INIT = 32'h0)(
    input clear,
    input clock,
    input enable,
    input PCbranch,
    input branchbool,
    input IncPC,
    input [DATA_WIDTH_IN-1:0] BusMuxOut,
    output wire [DATA_WIDTH_OUT-1:0] BusMuxInPC
);

reg [DATA_WIDTH_IN-1:0] q;
reg [DATA_WIDTH_IN-1:0] next_pc;
reg carry;
integer i;

initial q = INIT;
initial next_pc = INIT;

always @(*) begin
    next_pc = q;
    carry = 1'b0;

    if (IncPC) begin
        carry = 1'b1;
        for (i = 0; i < DATA_WIDTH_IN; i = i + 1) begin
            next_pc[i] = q[i] ^ carry;
            carry = q[i] & carry;
        end
    end
end

always @(negedge clock or posedge clear) begin
    if (clear) begin
        q <= {DATA_WIDTH_IN{1'b0}};
    end
    else if (enable) begin
        q <= BusMuxOut;
    end
    else if (PCbranch && branchbool) begin
        q <= BusMuxOut;
    end
    else if (IncPC) begin
        q <= next_pc;
    end
end

assign BusMuxInPC = q[DATA_WIDTH_OUT-1:0];

endmodule