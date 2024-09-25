module Controller (input clk,	// Clock for squarewave
						input [31:0] instr,
						output reg PCWriteCondition,
						output reg PCWrite,
						output reg IorD,
						output reg MemRead,
						output reg MemWrite,
						output reg MemtoReg,
						output reg IRWrite,
						output reg PCSource,
						output reg [1:0] ALUOp,
						output reg ALUSrcA,
						output reg [1:0] ALUSrcB,
						output reg RegWrite,
						output reg [2:0] state);

// Define space for local variables
reg [6:0] opcode;

// Define instruction type for comparisons
parameter R = 7'b0110011;
parameter lw = 7'b0000011;
parameter sw = 7'b0100011;
parameter beq = 7'b1100011;

// Define stages as number for case statement
parameter Instr_fetch = 3'b000;
parameter Decode = 3'b001;
parameter Exc = 3'b010;
parameter MemA_Rcom = 3'b011;
parameter Memcom = 4'b100;

// Set stage to 0 at the very start
initial begin
	state = 3'b000;
end
				

// Every positive edge of the clock
always @ (posedge clk) begin
	
	case(state)
	
		// Instruction fetch
		Instr_fetch: begin
			
			// Control for new instruction
			IorD = 0;
			MemRead = 1;
			
			// Control for PC = PC + 4
			ALUOp = 2'b00;
			ALUSrcA = 0;
			ALUSrcB = 2'b01;
			PCSource = 0;
			PCWrite = 1;
			
			// Go to Decode stage
			state = state + 1;
			
		end
		
		// Instruction decode/register fetch
		Decode: begin
			
			// Get Opcode
			opcode = instr[6:0];
			
			// Control for beq address
			if (opcode == beq) begin
				ALUSrcA = 0;
				ALUSrcB = 2'b10;
				ALUOp = 2'b00;
			end
			
			// Go to Exc
			state = state + 1;
			
		end
		
		// Execution, address computation, branch/jump completion
		Exc: begin
			
			// Controls for execution of type R instructions
			if (opcode == R) begin
				ALUOp = 2'b10;
				ALUSrcA = 1;
				ALUSrcB = 2'b00;
				
				// Go to next stage
				state = state + 1;
			end
			
			// Controls for execution of immediate instruction
			else if (opcode == lw || opcode == sw) begin
				ALUOp = 2'b00;
				ALUSrcA = 1;
				ALUSrcB = 2'b10;
				
				// Go to next stage
				state = state + 1;
			end
			
			// Controls for beq execution
			else if (opcode == beq) begin
				ALUOp = 2'b01;
				ALUSrcA = 1;
				ALUSrcB = 2'b00;
				PCWriteCondition = 1;
				
				// beq complete new instruction
				state = 3'b000;
			end
		
		end
		
		// Memory access or R type completion
		MemA_Rcom: begin
			
			// R type completion
			if (opcode == R) begin
				MemtoReg = 0;
				RegWrite = 1;
				
				// R type complete new instruction
				state = 3'b000;
			end
			
			// Load memory access
			else if (opcode == lw) begin
				IorD = 1;
				MemRead = 1;
				
				// Go to next state
				state = state + 1;
			end
			
			// Save memory access
			else if (opcode == sw) begin
				IorD = 1;
				MemWrite = 1;
				
				// sw complete next instruction
				state = 3'b000;
			end
		
		end
		
		// Memory Completion
		Memcom: begin
		
			// Assumed that this is a lw if going into this stage no need for if statement
			MemtoReg = 1;
			RegWrite = 1;
			
			// Store instruction complete
			state = 3'b000;
			
		end
		
	endcase
	
end
endmodule