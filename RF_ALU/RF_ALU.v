module RF_ALU (input clk,
						input RegSet,	// For getting some initial values into registers
						input RegWrite,	// The actual control for writing ALU result to register
						input [3:0] ALU_control,	// 4 bit ALU control code
						input [31:0] instr,	// 32 bit instruction
						input [31:0] Writedata,	// 32 bit data for some initial register values
						output reg[31:0] rd1,	// Data from rs1
						output reg[31:0] rd2,	// Data from rs2
						output reg[31:0] ALU_result,	// Result from ALU operation
						output reg  Zero);	// Zero for branches

// Local variable initialization for type/size
reg [31:0] registers [31:0];
integer i;
reg [4:0] rs1;
reg [4:0] rs2;
reg [4:0] rd;

initial begin	// Set all registers to 0 initially, probably unessecary.
	for(i=0;i<32;i=i+1)
		registers[i] <= 32'h00000000;
end

always @ (posedge clk) begin
	registers[0] = 0;	// Make sure x0 is 0 before reads
	
	rs1 = instr[19:15];	// Isolate rs1 field
	rs2 = instr[24:20];	// Isolate rs2 field
	rd = instr[11:7];		// Isolate rd field

	rd1 = registers[rs1];	// Get value at rs1
	rd2 = registers[rs2];	// Get value at rs2
	
	if (RegSet)		// If RegWrite control asserted
		registers[rd] = Writedata;	// Write data to rd
	
	registers[0] = 0;	// Make sure x0 is 0 before operations
	
	if (ALU_control == 4'b0000) // And
		ALU_result = rd1 & rd2;
		
	if (ALU_control == 4'b0001)	// Or
		ALU_result = rd1 | rd2;
		
	if (ALU_control == 4'b0010)	// Add
		ALU_result = rd1 + rd2;
	
	if (ALU_control == 4'b0110)	// Subtract
		ALU_result = rd1 - rd2;
		
	if ((rd1 - rd2) == 0)		// Check subtraction for branch instructions
		Zero = 1;
	else
		Zero = 0;
		
	if (RegWrite)	// Write result from ALU
		registers[rd] = ALU_result;
end  
endmodule