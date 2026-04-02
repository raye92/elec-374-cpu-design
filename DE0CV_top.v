module DE0CV_top (
    input  wire        CLOCK_50,
    input  wire [3:0]  KEY,
    input  wire [9:0]  SW,
    output wire [9:0]  LEDR,
    output wire [6:0]  HEX0,
    output wire [6:0]  HEX1
);

    wire reset;
    wire stop;
    wire run;

    reg  [25:0] clk_div_count;
    reg         slow_clock;

    wire [31:0] inportdata;
    wire [31:0] Outportout;

    assign reset = ~KEY[0]; // PIN_U7
    assign stop  = ~KEY[1]; // PIN_W9
    assign inportdata = {24'b0, SW[7:0]}; //PIN_U13, PIN_V13, PIN_T13, PIN_T12, PIN_AA15, PIN_AB15,
														//PIN_AA14, and PIN_AA13

    always @(posedge CLOCK_50 or posedge reset) begin
        if (reset) begin
            clk_div_count <= 26'd0;
            slow_clock <= 1'b0;
        end else begin
            if (clk_div_count == 26'd24) begin
                clk_div_count <= 26'd0;
                slow_clock <= ~slow_clock;
            end else begin
                clk_div_count <= clk_div_count + 26'd1;
            end
        end
    end

    DataPath dp (
        .clock(slow_clock),
        .reset(reset),
        .stop(stop),
        .inportdata(inportdata),
        .Outportout(Outportout),
        .run(run),
    );

    assign LEDR[0] = slow_clock; //PIN_AA2
    assign LEDR[5] = run; //PIN_N1
    assign LEDR[4:1] = 4'b0; //PIN_AA1, PIN_W2, PIN_Y3, PIN_N2, 
    assign LEDR[9:6] = 4'b0; //PIN_U2, PIN_U1, PIN_L2, PIN_L1

    assign HEX0 = Outportout[6:0]; //PIN_U21, PIN_V21, PIN_W22, PIN_W21, PIN_Y22, PIN_Y21, PIN_AA22
    assign HEX1 = Outportout[14:8]; // PIN_AA20, PIN_AB20, PIN_AA19, PIN_AA18, PIN_AB18, PIN_AA17, PIN_U22

endmodule