`timescale 1ns / 1ps

module ControlUnit_tb;

    // Inputs
    reg [6:0] OpCode;
    reg [2:0] Funct3;
    reg [6:0] Funct7;

    // Outputs
    wire [2:0] ImmSrc;
    wire ALUASrc;
    wire ALUBSrc;
    wire [3:0] ALUOp;
    wire DMWr;
    wire [2:0] DMCtrl;
    wire [1:0] RUDataWrSrc;
    wire RUWr;
    wire BrOp;

    // Instantiate the ControlUnit module
    ControlUnit UUT (
        .OpCode(OpCode),
        .Funct3(Funct3),
        .Funct7(Funct7),
        .ImmSrc(ImmSrc),
        .ALUASrc(ALUASrc),
        .ALUBSrc(ALUBSrc),
        .ALUOp(ALUOp),
        .DMWr(DMWr),
        .DMCtrl(DMCtrl),
        .RUDataWrSrc(RUDataWrSrc),
        .RUWr(RUWr),
        .BrOp(BrOp)
    );

    initial begin
        // Test case 1: Type R instruction
        OpCode = 7'b0110011;
        Funct3 = 3'b000;
        Funct7 = 7'b0000000;
        #10;
        $display("Test case 1 - Type R instruction:");
        $display("ImmSrc = %b", ImmSrc);
        $display("ALUASrc = %b", ALUASrc);
        $display("ALUBSrc = %b", ALUBSrc);
        $display("ALUOp = %b", ALUOp);
        $display("DMWr = %b", DMWr);
        $display("DMCtrl = %b", DMCtrl);
        $display("RUDataWrSrc = %b", RUDataWrSrc);
        $display("RUWr = %b", RUWr);
        $display("BrOp = %b", BrOp);

        // Test case 2: Type I instruction
        OpCode = 7'b0010011;
        Funct3 = 3'b001;
        Funct7 = 7'b0000000;
        #10;
        $display("Test case 2 - Type I instruction:");
        $display("ImmSrc = %b", ImmSrc);
        $display("ALUASrc = %b", ALUASrc);
        $display("ALUBSrc = %b", ALUBSrc);
        $display("ALUOp = %b", ALUOp);
        $display("DMWr = %b", DMWr);
        $display("DMCtrl = %b", DMCtrl);
        $display("RUDataWrSrc = %b", RUDataWrSrc);
        $display("RUWr = %b", RUWr);
        $display("BrOp = %b", BrOp);

        

        $finish;
    end

endmodule
