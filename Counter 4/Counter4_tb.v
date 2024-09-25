// Testbench Verilog code for up counter
module Counter4_tb();
reg clk, reset, updn;
wire [3:0] counter;

Counter4 dut(clk, reset, updn, counter);
initial begin 
clk=0;
forever #5 clk=~clk;
end
initial begin
reset=0;
#10;
reset=1;
#130;
reset=0;
#10
reset=1;
end
initial begin
#5;
updn=1;
forever #160 updn=~updn;
end
endmodule 