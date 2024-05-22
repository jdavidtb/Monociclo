module ImmGen(
    input logic [31:0] Inst,
    input logic [2:0] ImmSrc,
    output logic [31:0] ImmExt
);

always_comb begin
    case (ImmSrc)
        3'b000: begin // Tipo I
            ImmExt = {{20{Inst[31]}}, Inst[31:20]};
        end
        3'b001: begin // Tipo S
            ImmExt = {{20{Inst[31]}}, Inst[31:25], Inst[11:7]};
        end
        3'b010: begin // Tipo U
            ImmExt = {Inst[31:12], 12'b0};
        end
        3'b101: begin // Tipo B
            ImmExt = {{20{Inst[31]}}, Inst[7], Inst[30:25], Inst[11:8], 1'b0};
        end
        3'b110: begin // Tipo J
            ImmExt = {{12{Inst[31]}}, Inst[19:12], Inst[20], Inst[30:21], 1'b0};
        end
        default: begin // Valor predeterminado
            ImmExt = 32'b0;
        end
    endcase
end

endmodule2
