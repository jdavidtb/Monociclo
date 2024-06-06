`timescale 1ns / 1ps

module DataMemory_tb;

    // Inputs
    reg clk;
    reg DMWr;
    reg [2:0] DMCtrl;
    reg [31:0] Address;
    reg [31:0] DataWr;

    // Outputs
    wire [31:0] DataRd;

    // Instantiate the DataMemory module
    DataMemory UUT (
        .clk(clk),
        .DMWr(DMWr),
        .DMCtrl(DMCtrl),
        .Address(Address),
        .DataWr(DataWr),
        .DataRd(DataRd)
    );

    always #5 clk = ~clk;

    // Stimulus
    initial begin
        clk = 0;
        DMWr = 0;
        DMCtrl = 3'b000;
        Address = 32'h00000000;
        DataWr = 32'h00000000;

        #10;
        DMWr = 1;
        DMCtrl = 3'b000;
        Address = 32'h00000000;
        DataWr = 32'hABCD1234;
        #10;
        DMWr = 0;
        #10;
        $display("Test case 1 - Write word and read word:");
        $display("Address: %h, Written Data: %h, Read Data: %h", Address, DataWr, DataRd);

        #10;
        DMWr = 1;
        DMCtrl = 3'b001;
        Address = 32'h00000004;
        DataWr = 32'h000000FF;
        #10;
        DMWr = 0;
        DMCtrl = 3'b001;
        #10;
        $display("Test case 2 - Write byte and read byte (signed):");
        $display("Address: %h, Written Data: %h, Read Data: %h", Address, DataWr, DataRd);

        #10;
        DMWr = 1;
        DMCtrl = 3'b010;
        Address = 32'h00000008;
        DataWr = 32'h0000FFFF;
        #10;
        DMWr = 0;
        DMCtrl = 3'b010;
        #10;
        $display("Test case 3 - Write half-word and read half-word (signed):");
        $display("Address: %h, Written Data: %h, Read Data: %h", Address, DataWr, DataRd);


        $finish;
    end

endmodule
