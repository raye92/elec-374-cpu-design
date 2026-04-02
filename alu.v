module alu(
    input  wire [31:0] A,
    input  wire [31:0] B,
	 input  wire        clock,
	 input  wire [4:0]  opcode,
	 input  wire        enable,
    output reg  [63:0] Result
);

reg [4:0]q;
initial q = 5'b0;

always @(negedge clock) begin
	if (enable) begin
		q <= opcode;
	end
end
	

//wire en_add = (q == 5'b00000);
//wire en_sub = (q == 5'b00001);
//wire en_mul = (q == 5'b01101);
//wire en_div = (q == 5'b01100);

wire [63:0] add_res;
wire [63:0] sub_res;
wire [63:0] mul_res;
wire [63:0] div_res;

// each adder, subtractor, multiplier, and divider modules will have internals
// to decode opcodes 

adder add(A, B, add_res);

subtractor sub(A, B, sub_res);

multiply mul(A, B, mul_res);
	
divide div(A, B, div_res);

integer shamt;
integer i;
reg carry;
reg oldbit;
reg sign_bit;

always @ (*) begin
	Result = 64'd0;
	shamt = B[4:0];

	if (q == 5'b00000 || q == 5'b10000 || q == 5'b10001 || q == 5'b10010 || q == 5'b01001 || q == 5'b10101) begin //add, ld, ldi, st, addi, branch
		Result = add_res;
	end
	
	else if (q == 5'b00001) begin //sub
		Result = sub_res;
	end

	else if (q == 5'b01101) begin //mul
		Result = mul_res;
	end

	else if (q == 5'b01100) begin //div
		Result = div_res;
	end
	
	else if (q == 5'b00010 || q == 5'b01010) begin //and, andi
		Result = 32'd0;
		for (i = 0; i < 32; i = i + 1) begin
			Result[i] = A[i] & B[i];
		end
	end
	else if (q == 5'b00011 || q == 5'b01011) begin //or, ori
		Result = 32'd0;
		for (i = 0; i < 32; i = i + 1) begin
			Result[i] = A[i] | B[i];
		end
		
	end
	else if (q == 5'b00100) //shr
		begin
			Result = {32'd0, A};
			for (i = 0; i < shamt; i = i + 1) begin
				Result = Result >> 1;
			end
		end
	else if (q == 5'b00101) //shra
		begin
			sign_bit = A[31];
			
			Result = {32'd0, A};
			for (i = 0; i < shamt; i = i + 1) begin
				Result = Result >> 1;
				Result[31] = sign_bit;
			end
		end
	else if (q == 5'b00110) //shl
		begin
			Result = {32'd0, A};
			for (i = 0; i < shamt; i = i + 1) begin
				Result = Result << 1;
			end
		end
	else if (q == 5'b00111) //ror
		begin
		Result = {32'd0, A};
		for (i = 0; i < shamt; i = i + 1) begin
			Result = {Result[0], Result[31:1]};
		end
		
		
		end
	else if (q == 5'b01000) //rol
		begin
		Result = {32'd0, A};
		for (i = 0; i < shamt; i = i + 1) begin
			Result = {Result[30:0], Result[31]};
		end
		
		end
	else if (q == 5'b01111) begin //not
	 Result = 32'd0;
    for (i = 0; i < 32; i = i + 1) begin
        Result[i] = ~A[i];
    end
	end
	else if (q == 5'b01110) begin //neg
		carry = 1'b1;
		for (i = 0; i < 32; i = i + 1) begin
			oldbit = ~B[i];
			Result[i] = oldbit ^ carry;
			carry = oldbit & carry;
    end
		
	end
end
endmodule 