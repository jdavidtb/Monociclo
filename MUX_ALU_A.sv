module MUX_ALU_A(
    input logic [31:0] rs1,
    input logic [31:0] pc,
    input logic ALUASrc,
    output logic [31:0] ALUOp1
);

assign ALUOp1 = ALUASrc ? pc : rs1;

endmodule