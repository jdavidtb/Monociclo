`include "BranchUnit.sv"
`include "ControlUnit.sv"
`include "ALU.sv"
`include "InstructionMemory.sv"
`include "DataMemory.sv"
`include "PC.sv"
`include "RegisterUnit.sv"
`include "ImmGen.sv"
`include "MUX_ALU_A.sv"
`include "MUX_ALU_B.sv"
`include "MUX_RegData.sv"
`include "MUX_NextPC.sv"

module riscv_processor(
    input logic clk,
    input logic reset
);

wire [31:0] pc_in, pc_out, instruction, alu_result, reg_data1, reg_data2, imm_ext, alu_op1, alu_op2, data_mem_out, reg_write_data;
wire [4:0] branch_op;
wire [3:0] alu_op;
wire [2:0] imm_src, dm_ctrl;
wire [1:0] reg_data_src;
wire alu_a_src, alu_b_src, dm_wr, reg_wr, next_pc_src;

PC program_counter(
    .clk(clk),
    .reset(reset),
    .pc_in(pc_in),
    .pc_out(pc_out)
);

InstructionMemory instruction_memory(
    .pc(pc_out),
    .instruction(instruction)
);

ControlUnit control_unit(
    .OpCode(instruction[6:0]),
    .Funct3(instruction[14:12]),
    .Funct7(instruction[31:25]),
    .ImmSrc(imm_src),
    .ALUASrc(alu_a_src),
    .ALUBSrc(alu_b_src),
    .ALUOp(alu_op),
    .DMWr(dm_wr),
    .DMCtrl(dm_ctrl),
    .RUDataWrSrc(reg_data_src),
    .RUWr(reg_wr),
    .BrOp(branch_op)
);

RegisterUnit register_unit(
    .CLK(clk),
    .rs1(instruction[19:15]),
    .rs2(instruction[24:20]),
    .rd(instruction[11:7]),
    .DataWr(reg_write_data),
    .RuWr(reg_wr),
    .Rus1(reg_data1),
    .Rus2(reg_data2)
);

ImmGen immediate_generator(
    .Inst(instruction),
    .ImmSrc(imm_src),
    .ImmExt(imm_ext)
);

MUX_ALU_A mux_alu_a(
    .rs1(reg_data1),
    .pc(pc_out),
    .ALUASrc(alu_a_src),
    .ALUOp1(alu_op1)
);

MUX_ALU_B mux_alu_b(
    .rs2(reg_data2),
    .ImmExt(imm_ext),
    .ALUBSrc(alu_b_src),
    .ALUOp2(alu_op2)
);

ALU alu(
    .clk(clk),
    .operand1(alu_op1),
    .operand2(alu_op2),
    .funct3_alu(instruction[14:12]),
    .Type_alu(instruction[30]),
    .result(alu_result)
);

DataMemory data_memory(
    .clk(clk),
    .DMWr(dm_wr),
    .DMCtrl(dm_ctrl),
    .Address(alu_result),
    .DataWr(reg_data2),
    .DataRd(data_mem_out)
);

MUX_RegData mux_reg_data(
    .ALUResult(alu_result),
    .DataMemRead(data_mem_out),
    .PCPlus4(pc_out + 4),
    .RegDataSrc(reg_data_src),
    .RegWriteData(reg_write_data)
);

BranchUnit branch_unit(
    .A(reg_data1),
    .B(reg_data2),
    .BrOp(branch_op),
    .NextPCSrc(next_pc_src)
);

MUX_NextPC mux_next_pc(
    .ALUResult(alu_result),
    .BranchAddr(pc_out + imm_ext),
    .NextPCSrc(next_pc_src),
    .NextPC(pc_in)
);

endmodule
