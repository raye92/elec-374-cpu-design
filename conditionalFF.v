module conditionalFF (
    input clear,
	 input clock,
    input CONin,
    input [31:0] BusMuxOut,
    input [3:0] c2,
    output wire branchbool
);

reg q;
wire zero;

assign zero = ~|BusMuxOut;

always @(negedge clock) begin
    if (clear) begin
        q <= 1'b0;
    end
    else if (CONin) begin
        case (c2[1:0])
            2'b00: q <= zero;                         // brzr
            2'b01: q <= ~zero;                        // brnz
            2'b10: q <= (~BusMuxOut[31] && ~zero);    // brpl
            2'b11: q <= BusMuxOut[31];                // brmi
            default: q <= 1'b0;
        endcase
    end
end

assign branchbool = q;

endmodule