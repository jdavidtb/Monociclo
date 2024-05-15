module DataMemory(
    input logic clk,
    input logic DMWr,
    input logic [2:0] DMCtrl,
    input logic [31:0] Address,
    input logic [31:0] DataWr,
    output logic [31:0] DataRd
);

// Memoria de datos
reg [31:0] memory [0:1023]; // 1024 palabras de 32 bits

// Leer datos de la memoria
always_comb begin
    case (DMCtrl)
        3'b000: DataRd = memory[Address[31:2]];     // Lectura de palabra (32 bits)
        3'b001: DataRd = {{24{memory[Address[31:2]][7]}}, memory[Address[31:2]][7:0]};   // Lectura de byte con signo
        3'b010: DataRd = {{16{memory[Address[31:2]][15]}}, memory[Address[31:2]][15:0]}; // Lectura de media palabra con signo
        3'b100: DataRd = {{24{1'b0}}, memory[Address[31:2]][7:0]};   // Lectura de byte sin signo
        3'b101: DataRd = {{16{1'b0}}, memory[Address[31:2]][15:0]};  // Lectura de media palabra sin signo
        default: DataRd = 32'b0;
    endcase
end

// Escribir datos en la memoria
always_ff @(posedge clk) begin
    if (DMWr) begin
        case (DMCtrl)
            3'b000: memory[Address[31:2]] <= DataWr;                    // Escritura de palabra (32 bits)
            3'b001: memory[Address[31:2]][7:0] <= DataWr[7:0];          // Escritura de byte
            3'b010: memory[Address[31:2]][15:0] <= DataWr[15:0];        // Escritura de media palabra
            default: memory[Address[31:2]] <= memory[Address[31:2]];   // No escribir en otros casos
        endcase
    end
end

endmodule