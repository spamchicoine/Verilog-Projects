module ALU (input clk,		// Clock input
				input [3:0] ALU_control,	// Control values for the ALU
				input [31:0] arg1,	// Argument 1 for the operation
				input [31:0] arg2,	// Argument 2 for the operation
				output reg Zero,		// Zero output for branch operations
				output reg[31:0] ALU_result	// Result output from the operation
						);


always @ (posedge clk) begin

	if (ALU_control == 4'b0000) // And
		ALU_result <= arg1 & arg2;
		
	if (ALU_control == 4'b0001)	// Or
		ALU_result <= arg1 | arg2;
		
	if (ALU_control == 4'b0010)	// Add
		ALU_result <= arg1 + arg2;
	
	if (ALU_control == 4'b0110)	// Subtract
		ALU_result <= arg1 - arg2;
		
	if ((arg1 - arg2) == 0)		// Check subtraction for branch instructions
		Zero <= 1;
	else
		Zero <= 0;
		
end  
endmodule