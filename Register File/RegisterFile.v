module RegisterFile (input clk,	// Clock for squarewave
						input RegWrite,	// Control for writing data to RD
						input [31:0] instr,	// 32 bit instruction
						input [31:0] Writedata,	// Data to write if RegWrite asserted
						output reg[31:0] rd1,	// Data from RS1
						output reg[31:0] rd2);	// Data from RS2

// Declare local variables type/size	
reg [31:0] registers [31:0];
integer i;
reg [4:0] rs1;
reg [4:0] rs2;
reg [4:0] rd;

initial begin	// Set registers to 0 initially
	for(i=0;i<32;i=i+1)
		registers[i] <= 0;
end

always @ (posedge clk) begin
	registers[0] <= 0;	// Make sure register 0 is 0
	
	rs1 = instr[19:15];	// Isolate RS1 value
	rs2 = instr[24:20];	// Isolate RS2 value
	rd = instr[11:7];	// Isolate RD value

	rd1 = registers[rs1];	// Get data from register RS1
	rd2 = registers[rs2];	// get data from register RS2
	
	if (RegWrite)	// If control RegWrite asserted
		registers[rd] = Writedata;	// Register RD gets Writedata
		
	registers[0] <= 0;	// Make sure register 0 is 0
end  
endmodule