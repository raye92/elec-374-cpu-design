module control_unit #(parameter x = 7)(

    output reg HIin, LOin, RZin, PCin, MDRin, ALUin, IncPC,
    output reg HIout, LOout, ZHIout, ZLOout, PCout, MDRout, inportout,
    output reg MARin, IRin, RYin, Gra, Grb, Grc, Rin, Rout, BAout, Cout,
    output reg CONin, Outportin, PCbranch,
    output reg read, write, clear,
    input clock, reset, stop,
    input [31:0] IR_input,
    output reg run
);

parameter reset_state = 7'd0,
          fetch0      = 7'd1,
          fetch1      = 7'd2,
          fetch2      = 7'd3,

          add3        = 7'd4,
          add4        = 7'd5,
          add5        = 7'd6,

          sub3        = 7'd7,
          sub4        = 7'd8,
          sub5        = 7'd9,

          and3        = 7'd10,
          and4        = 7'd11,
          and5        = 7'd12,

          or3         = 7'd13,
          or4         = 7'd14,
          or5         = 7'd15,

          shr3        = 7'd16,
          shr4        = 7'd17,
          shr5        = 7'd18,

          shra3       = 7'd19,
          shra4       = 7'd20,
          shra5       = 7'd21,

          shl3        = 7'd22,
          shl4        = 7'd23,
          shl5        = 7'd24,

          ror3        = 7'd25,
          ror4        = 7'd26,
          ror5        = 7'd27,

          rol3        = 7'd28,
          rol4        = 7'd29,
          rol5        = 7'd30,

          addi3       = 7'd31,
          addi4       = 7'd32,
          addi5       = 7'd33,

          andi3       = 7'd34,
          andi4       = 7'd35,
          andi5       = 7'd36,

          ori3        = 7'd37,
          ori4        = 7'd38,
          ori5        = 7'd39,

          div3        = 7'd40,
          div4        = 7'd41,
          div5        = 7'd42,
          div6        = 7'd43,

          mul3        = 7'd44,
          mul4        = 7'd45,
          mul5        = 7'd46,
          mul6        = 7'd47,

          neg3        = 7'd48,
          neg4        = 7'd49,

          not3        = 7'd50,
          not4        = 7'd51,
          not5        = 7'd52,

          ld3         = 7'd53,
          ld4         = 7'd54,
          ld5         = 7'd55,
          ld6         = 7'd56,
          ld7         = 7'd57,

          ldi3        = 7'd58,
          ldi4        = 7'd59,
          ldi5        = 7'd60,

          st3         = 7'd61,
          st4         = 7'd62,
          st5         = 7'd63,
          st6         = 7'd64,
          st7         = 7'd65,

          jal3        = 7'd66,
          jal4        = 7'd67,

          jr3         = 7'd68,

          br3         = 7'd69,
          br4         = 7'd70,
          br5         = 7'd71,
          br6         = 7'd72,

          in3         = 7'd73,
          out3        = 7'd74,
          mfhi3       = 7'd75,
          mflo3       = 7'd76,
          nop3        = 7'd77,
          halt3       = 7'd78;

reg [6:0] present_state, next_state;

always @(posedge clock or posedge reset) begin
    if (reset == 1'b1) begin
        present_state <= reset_state;
        run <= 1'b1;
    end
    else if (stop == 1'b1) begin
        present_state <= halt3;
        run <= 1'b0;
    end
    else begin
        present_state <= next_state;

        if (next_state == halt3)
            run <= 1'b0;
        else
            run <= 1'b1;
    end
end

always @(*) begin
    case (present_state)
        reset_state: next_state = fetch0;
        fetch0:      next_state = fetch1;
        fetch1:      next_state = fetch2;

        fetch2: begin
            case (IR_input[31:27])
                5'b00000: next_state = add3;
                5'b00001: next_state = sub3;
                5'b00010: next_state = and3;
                5'b00011: next_state = or3;
                5'b00100: next_state = shr3;
                5'b00101: next_state = shra3;
                5'b00110: next_state = shl3;
                5'b00111: next_state = ror3;
                5'b01000: next_state = rol3;

                5'b01001: next_state = addi3;
                5'b01010: next_state = andi3;
                5'b01011: next_state = ori3;

                5'b01100: next_state = div3;
                5'b01101: next_state = mul3;
                5'b01110: next_state = neg3;
                5'b01111: next_state = not3;

                5'b10000: next_state = ld3;
                5'b10001: next_state = ldi3;
                5'b10010: next_state = st3;

                5'b10011: next_state = jal3;
                5'b10100: next_state = jr3;
                5'b10101: next_state = br3;

                5'b10110: next_state = in3;
                5'b10111: next_state = out3;
                5'b11000: next_state = mfhi3;
                5'b11001: next_state = mflo3;

                5'b11010: next_state = nop3;
                5'b11011: next_state = halt3;

                default:  next_state = reset_state;
            endcase
        end

        add3:   next_state = add4;
        add4:   next_state = add5;
        add5:   next_state = fetch0;

        sub3:   next_state = sub4;
        sub4:   next_state = sub5;
        sub5:   next_state = fetch0;

        and3:   next_state = and4;
        and4:   next_state = and5;
        and5:   next_state = fetch0;

        or3:    next_state = or4;
        or4:    next_state = or5;
        or5:    next_state = fetch0;

        shr3:   next_state = shr4;
        shr4:   next_state = shr5;
        shr5:   next_state = fetch0;

        shra3:  next_state = shra4;
        shra4:  next_state = shra5;
        shra5:  next_state = fetch0;

        shl3:   next_state = shl4;
        shl4:   next_state = shl5;
        shl5:   next_state = fetch0;

        ror3:   next_state = ror4;
        ror4:   next_state = ror5;
        ror5:   next_state = fetch0;

        rol3:   next_state = rol4;
        rol4:   next_state = rol5;
        rol5:   next_state = fetch0;

        addi3:  next_state = addi4;
        addi4:  next_state = addi5;
        addi5:  next_state = fetch0;

        andi3:  next_state = andi4;
        andi4:  next_state = andi5;
        andi5:  next_state = fetch0;

        ori3:   next_state = ori4;
        ori4:   next_state = ori5;
        ori5:   next_state = fetch0;

        div3:   next_state = div4;
        div4:   next_state = div5;
        div5:   next_state = div6;
        div6:   next_state = fetch0;

        mul3:   next_state = mul4;
        mul4:   next_state = mul5;
        mul5:   next_state = mul6;
        mul6:   next_state = fetch0;

        neg3:   next_state = neg4;
        neg4:   next_state = fetch0;

        not3:   next_state = not4;
        not4:   next_state = not5;
        not5:   next_state = fetch0;

        ld3:    next_state = ld4;
        ld4:    next_state = ld5;
        ld5:    next_state = ld6;
        ld6:    next_state = ld7;
        ld7:    next_state = fetch0;

        ldi3:   next_state = ldi4;
        ldi4:   next_state = ldi5;
        ldi5:   next_state = fetch0;

        st3:    next_state = st4;
        st4:    next_state = st5;
        st5:    next_state = st6;
        st6:    next_state = st7;
        st7:    next_state = fetch0;

        jal3:   next_state = jal4;
        jal4:   next_state = fetch0;

        jr3:    next_state = fetch0;

        br3:    next_state = br4;
        br4:    next_state = br5;
        br5:    next_state = br6;
        br6:    next_state = fetch0;

        in3:    next_state = fetch0;
        out3:   next_state = fetch0;
        mfhi3:  next_state = fetch0;
        mflo3:  next_state = fetch0;
        nop3:   next_state = fetch0;

        halt3:  next_state = halt3;

       default: next_state = reset_state;
    endcase
end

always @(*) begin
    HIin      = 1'b0;
    LOin      = 1'b0;
    RZin      = 1'b0;
    PCin      = 1'b0;
    MDRin     = 1'b0;
    ALUin     = 1'b0;
    IncPC     = 1'b0;

    HIout     = 1'b0;
    LOout     = 1'b0;
    ZHIout    = 1'b0;
    ZLOout    = 1'b0;
    PCout     = 1'b0;
    MDRout    = 1'b0;
    inportout = 1'b0;

    MARin     = 1'b0;
    IRin      = 1'b0;
    RYin      = 1'b0;
    Gra       = 1'b0;
    Grb       = 1'b0;
    Grc       = 1'b0;
    Rin       = 1'b0;
    Rout      = 1'b0;
    BAout     = 1'b0;
    Cout      = 1'b0;

    CONin     = 1'b0;
    Outportin = 1'b0;
    PCbranch  = 1'b0;
    read      = 1'b0;
    write     = 1'b0;
	 
	 clear	  = 1'b0;

    case (present_state)
		  reset_state: begin
				clear = 1'b1;
		  
		  end
		  
        fetch0: begin
            PCout = 1'b1;
            MARin = 1'b1;
            IncPC = 1'b1;
        end

        fetch1: begin
            read  = 1'b1;
            MDRin = 1'b1;
        end

        fetch2: begin
            MDRout = 1'b1;
            IRin   = 1'b1;
            ALUin  = 1'b1;
        end

        add3: begin
            Grb  = 1'b1;
            Rout = 1'b1;
            RYin = 1'b1;
        end

        add4: begin
            Grc  = 1'b1;
            Rout = 1'b1;
            RZin = 1'b1;
        end

        add5: begin
            ZLOout = 1'b1;
            Gra    = 1'b1;
            Rin    = 1'b1;
        end
		  
        sub3: begin
            Grb  = 1'b1;
            Rout = 1'b1;
            RYin = 1'b1;
        end

        sub4: begin
            Grc  = 1'b1;
            Rout = 1'b1;
            RZin = 1'b1;
        end

        sub5: begin
            ZLOout = 1'b1;
            Gra    = 1'b1;
            Rin    = 1'b1;
        end
		  
        and3: begin
            Grb  = 1'b1;
            Rout = 1'b1;
            RYin = 1'b1;
        end

        and4: begin
            Grc  = 1'b1;
            Rout = 1'b1;
            RZin = 1'b1;
        end

        and5: begin
            ZLOout = 1'b1;
            Gra    = 1'b1;
            Rin    = 1'b1;
        end
		  
        or3: begin
            Grb  = 1'b1;
            Rout = 1'b1;
            RYin = 1'b1;
        end

        or4: begin
            Grc  = 1'b1;
            Rout = 1'b1;
            RZin = 1'b1;
        end

        or5: begin
            ZLOout = 1'b1;
            Gra    = 1'b1;
            Rin    = 1'b1;
        end
		  
        shr3: begin
            Grb  = 1'b1;
            Rout = 1'b1;
            RYin = 1'b1;
        end

        shr4: begin
            Grc  = 1'b1;
            Rout = 1'b1;
            RZin = 1'b1;
        end

        shr5: begin
            ZLOout = 1'b1;
            Gra    = 1'b1;
            Rin    = 1'b1;
        end
		  
        shra3: begin
            Grb  = 1'b1;
            Rout = 1'b1;
            RYin = 1'b1;
        end

        shra4: begin
            Grc  = 1'b1;
            Rout = 1'b1;
            RZin = 1'b1;
        end

        shra5: begin
            ZLOout = 1'b1;
            Gra    = 1'b1;
            Rin    = 1'b1;
        end

        shl3: begin
            Grb  = 1'b1;
            Rout = 1'b1;
            RYin = 1'b1;
        end

        shl4: begin
            Grc  = 1'b1;
            Rout = 1'b1;
            RZin = 1'b1;
        end

        shl5: begin
            ZLOout = 1'b1;
            Gra    = 1'b1;
            Rin    = 1'b1;
        end

        ror3: begin
            Grb  = 1'b1;
            Rout = 1'b1;
            RYin = 1'b1;
        end

        ror4: begin
            Grc  = 1'b1;
            Rout = 1'b1;
            RZin = 1'b1;
        end

        ror5: begin
            ZLOout = 1'b1;
            Gra    = 1'b1;
            Rin    = 1'b1;
        end

        rol3: begin
            Grb  = 1'b1;
            Rout = 1'b1;
            RYin = 1'b1;
        end

        rol4: begin
            Grc  = 1'b1;
            Rout = 1'b1;
            RZin = 1'b1;
        end

        rol5: begin
            ZLOout = 1'b1;
            Gra    = 1'b1;
            Rin    = 1'b1;
        end

        addi3: begin
            Grb  = 1'b1;
            Rout = 1'b1;
            RYin = 1'b1;
        end

        addi4: begin
            Cout = 1'b1;
            RZin = 1'b1;
        end

        addi5: begin
            ZLOout = 1'b1;
            Gra    = 1'b1;
            Rin    = 1'b1;
        end

        andi3: begin
            Grb  = 1'b1;
            Rout = 1'b1;
            RYin = 1'b1;
        end

        andi4: begin
            Cout = 1'b1;
            RZin = 1'b1;
        end

        andi5: begin
            ZLOout = 1'b1;
            Gra    = 1'b1;
            Rin    = 1'b1;
        end

        ori3: begin
            Grb  = 1'b1;
            Rout = 1'b1;
            RYin = 1'b1;
        end

        ori4: begin
            Cout = 1'b1;
            RZin = 1'b1;
        end

        ori5: begin
            ZLOout = 1'b1;
            Gra    = 1'b1;
            Rin    = 1'b1;
        end

        div3: begin
            Gra  = 1'b1;
            Rout = 1'b1;
            RYin = 1'b1;
        end

        div4: begin
            Grb  = 1'b1;
            Rout = 1'b1;
            RZin = 1'b1;
        end

        div5: begin
            ZLOout = 1'b1;
            LOin   = 1'b1;
        end

        div6: begin
            ZHIout = 1'b1;
            HIin   = 1'b1;
        end

        mul3: begin
            Gra  = 1'b1;
            Rout = 1'b1;
            RYin = 1'b1;
        end

        mul4: begin
            Grb  = 1'b1;
            Rout = 1'b1;
            RZin = 1'b1;
        end

        mul5: begin
            ZLOout = 1'b1;
            LOin   = 1'b1;
        end

        mul6: begin
            ZHIout = 1'b1;
            HIin   = 1'b1;
        end
		  
        neg3: begin
            Grb  = 1'b1;
            Rout = 1'b1;
            RZin = 1'b1;
        end

        neg4: begin
            ZLOout = 1'b1;
            Gra    = 1'b1;
            Rin    = 1'b1;
        end

        not3: begin
            Grb  = 1'b1;
            Rout = 1'b1;
            RYin = 1'b1;
        end

        not4: begin
            Grc  = 1'b1;
            Rout = 1'b1;
            RZin = 1'b1;
        end

        not5: begin
            ZLOout = 1'b1;
            Gra    = 1'b1;
            Rin    = 1'b1;
        end

        ld3: begin
            Grb  = 1'b1;
            BAout = 1'b1;
            RYin = 1'b1;
        end

        ld4: begin
            Cout = 1'b1;
            RZin = 1'b1;
        end

        ld5: begin
            ZLOout = 1'b1;
            MARin  = 1'b1;
        end

        ld6: begin
            read  = 1'b1;
            MDRin = 1'b1;
        end

        ld7: begin
            MDRout = 1'b1;
            Gra    = 1'b1;
            Rin    = 1'b1;
        end

        ldi3: begin
            Grb  = 1'b1;
            BAout = 1'b1;
            RYin = 1'b1;
        end

        ldi4: begin
            Cout = 1'b1;
            RZin = 1'b1;
        end

        ldi5: begin
            ZLOout = 1'b1;
            Gra    = 1'b1;
            Rin    = 1'b1;
        end

        st3: begin
            Grb   = 1'b1;
            BAout = 1'b1;
            RYin  = 1'b1;
        end

        st4: begin
            Cout = 1'b1;
            RZin = 1'b1;
        end

        st5: begin
            ZLOout = 1'b1;
            MARin  = 1'b1;
        end

        st6: begin
            Gra   = 1'b1;
            Rout  = 1'b1;
            MDRin = 1'b1;
        end

        st7: begin
            write = 1'b1;
        end

        jal3: begin
            PCout = 1'b1;
            Rin   = 1'b1;
        end

        jal4: begin
            Gra   = 1'b1;
            Rout  = 1'b1;
            PCin  = 1'b1;
        end

        jr3: begin
            Gra  = 1'b1;
            Rout = 1'b1;
            PCin = 1'b1;
        end

        br3: begin
            Gra   = 1'b1;
            Rout  = 1'b1;
            CONin = 1'b1;
        end

        br4: begin
            PCout = 1'b1;
            RYin  = 1'b1;
        end

        br5: begin
            Cout = 1'b1;
            RZin = 1'b1;
        end

        br6: begin
            ZLOout   = 1'b1;
            PCbranch = 1'b1;
        end
		  
        in3: begin
            inportout = 1'b1;
            Gra       = 1'b1;
            Rin       = 1'b1;
        end

        out3: begin
            Gra       = 1'b1;
            Rout      = 1'b1;
            Outportin = 1'b1;
        end

        mfhi3: begin
            HIout = 1'b1;
            Gra   = 1'b1;
            Rin   = 1'b1;
        end

        mflo3: begin
            LOout = 1'b1;
            Gra   = 1'b1;
            Rin   = 1'b1;
        end

        nop3: begin
        end

        halt3: begin
        end
    endcase
end

endmodule