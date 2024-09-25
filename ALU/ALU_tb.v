module ALU_tb();
reg clk;	// Clock output
reg [3:0] ALU_control;	// ALU_control output
reg [31:0] arg1;	// Argument 1 output
reg [31:0] arg2;	// Argument 2 output
wire Zero;	// Zero result
wire [31:0] ALU_result;	//ALU result of operation

ALU dut(clk, ALU_control, arg1, arg2, Zero, ALU_result);	// Link to ALU file
initial begin 
clk=0;
forever #5 clk=~clk;	// Creates squarewave
end

// Setting values sent to ALU to display operations
initial begin
#5;
ALU_control=4'b0000;
arg1=32'h4e0f92be;
arg2=32'h080011F3;
#10;
ALU_control=4'b0001;
#10;
arg1=32'h1234fedc;
arg2=32'h00742069;
#10;
ALU_control=4'b0110;
#10;
ALU_control=4'b0010;
#10;
ALU_control=4'b0110;
arg1=32'h11110000;
arg2=32'h11110000;
#10;
arg1=32'h00000001;
arg2=32'h00000000;
ALU_control=4'b000;
end
endmodule