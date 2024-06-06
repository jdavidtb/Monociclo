module BranchUnit(
    input logic [31:0] A,
    input logic [31:0] B,
    input logic [4:0] BrOp,
    output logic NextPCSrc
);

always_comb begin
    case (BrOp)
        5'b00000: NextPCSrc = 1'b0;                       // No branch
        5'b01000: NextPCSrc = (A == B) ? 1'b1 : 1'b0;     // BEQ
        5'b01001: NextPCSrc = (A != B) ? 1'b1 : 1'b0;     // BNE
        5'b01100: NextPCSrc = ($signed(A) < $signed(B)) ? 1'b1 : 1'b0;   // BLT
        5'b01101: NextPCSrc = ($signed(A) >= $signed(B)) ? 1'b1 : 1'b0;  // BGE
        5'b01110: NextPCSrc = (A < B) ? 1'b1 : 1'b0;      // BLTU
        5'b01111: NextPCSrc = (A >= B) ? 1'b1 : 1'b0;     // BGEU
        5'b11000: NextPCSrc = 1'b1;                       // JAL
        5'b11001: NextPCSrc = 1'b1;                       // JALR
        default: NextPCSrc = 1'b0;
    endcase
end

endmodule