module MUX_ALU_B(
    input logic [31:0] rs2,
    input logic [31:0] ImmExt,
    input logic ALUBSrc,
    output logic [31:0] ALUOp2
);

assign ALUOp2 = ALUBSrc ? ImmExt : rs2;

endmodule