module MUX_NextPC(
    input logic [31:0] ALUResult,
    input logic [31:0] BranchAddr,
    input logic NextPCSrc,
    output logic [31:0] NextPC
);

assign NextPC = NextPCSrc ? BranchAddr : ALUResult;

endmodule