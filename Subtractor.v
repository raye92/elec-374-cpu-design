module subtractor(
    input  wire [31:0] A,
    input  wire [31:0] B,
    output wire [63:0] Result
);

    wire [31:0] negated_b;
    negate negate_circuit(B, negated_b);
    adder add_circuit(A, negated_b, Result);

endmodule
