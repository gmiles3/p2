module ALU(clk, opsel, A, B, out);
	input clk;
	input[3:0] opsel;
	input[31:0] A, B;
	output reg[31:0] out;
	
	parameter ADD=0, SUB=1, AND=2, OR=3, XOR=4, NAND=5, NOR=6, XNOR=7, MVHI=8;
	
	always @(posedge clk) begin
		case (opsel)
			ADD: 
				out = A + B;
			SUB:
				out = A - B;
			AND:
				out = A & B;
			OR:
				out = A | B;
			XOR:
				out = A ^ B;
			NAND:
				out = ~(A & B);
			NOR:
				out = ~(A | B);
			XNOR:
				out = ~(A ^ B);
			MVHI:
				out[31:16] = B[15:0];
		endcase
	end
endmodule
			
			
	
	
	