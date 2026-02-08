module negate(
    input wire [31:0] A,
    output wire [31:0] Result
);
    
    wire [31:0] NotResult;
    wire [63:0] AddResult;

    bitwise_not not_stage(A, 32'd0, NotResult[31:0]);
    adder add_stage(NotResult, 32'd1, AddResult);
    assign Result = AddResult[31:0];
endmodule
