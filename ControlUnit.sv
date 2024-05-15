module ControlUnit(
    input logic [6:0] OpCode,
    input logic [2:0] Funct3,
    input logic [6:0] Funct7,
    output logic [2:0] ImmSrc,
    output logic ALUASrc,
    output logic ALUBSrc,
    output logic [3:0] ALUOp,
    output logic DMWr,
    output logic [2:0] DMCtrl,
    output logic [1:0] RUDataWrSrc,
    output logic RUWr,
    output logic BrOp
);

always_comb begin
    case (OpCode)
        7'b0110011: begin // Type R
            ImmSrc = 3'b000;
            ALUASrc = 1'b0;
            ALUBSrc = 1'b0;
            ALUOp = {Funct7[5], Funct3};
            DMWr = 1'b0;
            DMCtrl = 3'b000;
            RUDataWrSrc = 2'b00;
            RUWr = 1'b1;
            BrOp = 1'b0;
        end
        7'b0010011: begin // Type I
            ImmSrc = 3'b000;
            ALUASrc = 1'b0;
            ALUBSrc = 1'b1;
            ALUOp = {1'b0, Funct3};
            DMWr = 1'b0;
            DMCtrl = 3'b000;
            RUDataWrSrc = 2'b00;
            RUWr = 1'b1;
            BrOp = 1'b0;
        end
        // ... (otros casos de instrucciones)
        default: begin // Instrucción desconocida
            ImmSrc = 3'b000;
            ALUASrc = 1'b0;
            ALUBSrc = 1'b0;
            ALUOp = 4'b0000;
            DMWr = 1'b0;
            DMCtrl = 3'b000;
            RUDataWrSrc = 2'b00;
            RUWr = 1'b0;
            BrOp = 1'b0;
        end
    endcase
end

endmodule