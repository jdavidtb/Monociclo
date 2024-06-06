`timescale 1ns / 1ps

module pc_tb;

    // Entradas
    reg clk;
    reg reset;
    reg [31:0] pc_in;

    // Salidas
    wire [31:0] pc_out;

    // Instanciar el módulo pc
    pc UUT (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    // Generación de señal de reloj
    always #5 clk = ~clk;

    // Estímulos de prueba
    initial begin
        // Inicializar entradas
        clk = 0;
        reset = 1;
        pc_in = 32'h00000000;

        // Esperar un ciclo de reloj para que se aplique el reset
        #10;
        reset = 0;

        // Caso de prueba 1: Verificar el funcionamiento normal del Program Counter
        #10;
        pc_in = 32'h00000004;
        #10;
        $display("Caso de prueba 1 - Funcionamiento normal del Program Counter:");
        $display("Entrada PC: %h, Salida PC: %h", pc_in, pc_out);

        // Caso de prueba 2: Verificar el funcionamiento del reset
        #10;
        reset = 1;
        #10;
        $display("Caso de prueba 2 - Funcionamiento del reset:");
        $display("Entrada PC: %h, Salida PC: %h", pc_in, pc_out);

        // Caso de prueba 3: Verificar el funcionamiento después del reset
        #10;
        reset = 0;
        pc_in = 32'h00000008;
        #10;
        $display("Caso de prueba 3 - Funcionamiento después del reset:");
        $display("Entrada PC: %h, Salida PC: %h", pc_in, pc_out);


        $finish;
    end

endmodule
