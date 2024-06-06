module MUX_RegData(
    input logic [31:0] ALUResult,
    input logic [31:0] DataMemRead,
    input logic [31:0] PCPlus4,
    input logic [1:0] RegDataSrc,
    output logic [31:0] RegWriteData
);

always_comb begin
    case (RegDataSrc)
        2'b00: RegWriteData = ALUResult;
        2'b01: RegWriteData = DataMemRead;
        2'b10: RegWriteData = PCPlus4;
        default: RegWriteData = 32'b0;
    endcase
end

endmodule
