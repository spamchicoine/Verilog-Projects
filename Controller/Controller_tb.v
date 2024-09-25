module Controller_tb();

// Declare inputs for the control unit
reg clk;
reg [31:0] instr;

// Declare outputs for simulation
wire PCWriteCondition;
wire PCWrite;
wire IorD;
wire MemRead;
wire MemWrite;
wire MemtoReg;
wire IRWrite;
wire PCSource;
wire [1:0] ALUOp;
wire ALUSrcA;
wire [1:0] ALUSrcB;
wire RegWrite;
wire [2:0]state;

// Link to control unit
Controller dut(clk, instr, PCWriteCondition, PCWrite, IorD, MemRead,
				MemWrite, MemtoReg, IRWrite, PCSource, ALUOp, ALUSrcA,
				ALUSrcB, RegWrite, state);

// Begin clock squarewave
initial begin 
clk=0;
forever #5 clk=~clk;
end

initial begin
#5;

// lw x5, 12(x2)
instr = 32'b00000000110000010010001010000011;
#50

// sw x7, 16(x22)
instr = 32'b00000000011110110010100000100011;
#40

// sub x3, x9, x31
instr = 32'b01000001111101001000000110110011;
#40

// beq x8, x11, L1 (L1 is -16 twos complement)
instr = 32'b11111110101101000000100011100011;
#30
// Force an end to it doesnt continue to compute states and controls
$finish;
end
endmodule