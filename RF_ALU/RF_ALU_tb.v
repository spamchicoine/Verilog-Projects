module RF_ALU_tb();
reg clk, RegSet, RegWrite;
reg [3:0] ALU_control;
reg [31:0] instr;
reg [31:0] Writedata;
wire [31:0] rd1;
wire [31:0] rd2;
wire [31:0] ALU_result;
wire Zero;

RF_ALU dut(clk, RegSet, RegWrite, ALU_control, instr, Writedata, rd1, rd2, ALU_result, Zero);
initial begin 
clk=0;
forever #5 clk=~clk;
end

// Controls for getting initial values into a couple registers, then swapping to use data from ALU results.
initial begin
RegWrite=0;
RegSet=1;
#35;
RegSet=0;
#10;
RegWrite=1;
#25;
RegWrite=0;

end

// Assigning inputs to the Register File and ALU
initial begin
#5;
instr=32'h00000000;
Writedata=32'h00000000;
#10;
instr=32'h00000080;
Writedata=32'h0003eeee;
#10;
instr=32'h00000100;
Writedata=32'h00001111;
#10;
instr=32'h00208000;
#10;
ALU_control=4'b0000;
instr=32'h00208500;
#10;
ALU_control=4'b0010;
instr=32'h00208600;
#10;
ALU_control=4'bxxxx;
instr=32'h00a60000;
#10;
instr=32'h00000000;
end
endmodule