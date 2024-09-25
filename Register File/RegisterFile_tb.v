// Testbench Verilog code for up counter
module RegisterFile_tb();
reg clk, RegWrite;
reg [31:0] instr;
reg [31:0] Writedata;
wire [31:0] rd1;
wire [31:0] rd2;

RegisterFile dut(clk, RegWrite, instr, Writedata, rd1, rd2);

// Begin clock squarewave
initial begin 
clk=0;
forever #5 clk=~clk;
end

//Assert Regwrite control while we want to write to registers.
initial begin
RegWrite=1;
#40;
RegWrite=0;
end

// Assign input values for the register file
initial begin
#5;
instr=32'h00000000;
Writedata=32'h00000000;
#10;
instr=32'h00000080;
Writedata=32'hffffeeee;
#10;
instr=32'h00000100;
Writedata=32'h00001111;
#10;
instr=32'h00208000;
#10;
instr=32'h00000000;
end
endmodule