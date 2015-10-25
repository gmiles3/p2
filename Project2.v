module Project2(SW,KEY,LEDR,LEDG,HEX0,HEX1,HEX2,HEX3,CLOCK_50);
	input  [9:0] SW;
	input  [3:0] KEY;
	input  CLOCK_50;
	output [9:0] LEDR;
	output [7:0] LEDG;
	output [6:0] HEX0,HEX1,HEX2,HEX3;

	parameter DBITS         				 = 32;
	parameter INST_SIZE      			 = 32'd4;
	parameter INST_BIT_WIDTH				 = 32;
	parameter START_PC       			 = 32'h40;
	parameter REG_INDEX_BIT_WIDTH 		 = 4;
	parameter ADDR_KEY  					 = 32'hF0000010;
	parameter ADDR_SW   					 = 32'hF0000014;
	parameter ADDR_HEX  					 = 32'hF0000000;
	parameter ADDR_LEDR 					 = 32'hF0000004;
	parameter ADDR_LEDG 					 = 32'hF0000008;
	  
	parameter IMEM_INIT_FILE				 = "LightTest.mif";
	parameter IMEM_ADDR_BIT_WIDTH 		 = 11;
	parameter IMEM_DATA_BIT_WIDTH 		 = INST_BIT_WIDTH;
	parameter IMEM_PC_BITS_HI     		 = IMEM_ADDR_BIT_WIDTH + 2;
	parameter IMEM_PC_BITS_LO     		 = 2;
	
	// Add parameters for various secondary opcode values

	//PLL, clock genration, and reset generation
	wire clk, lock;
	//Pll pll(.inclk0(CLOCK_50), .c0(clk), .locked(lock));
	PLL	PLL_inst (.inclk0 (CLOCK_50),.c0 (clk),.locked (lock));
	wire reset = ~lock;
	 
	// Create PC and its logic
	wire pcWrtEn = 1'b1;
	wire[DBITS - 1: 0] pcIn; // Implement the logic that generates pcIn; you may change pcIn to reg if necessary
	wire[DBITS - 1: 0] pcOut;

	// This PC instantiation is your starting point
	Register #(.BIT_WIDTH(DBITS), .RESET_VALUE(START_PC)) pc (clk, reset, pcWrtEn, pcIn, pcOut);

	// Creat instruction memeory
	wire[IMEM_DATA_BIT_WIDTH - 1: 0] instWord;
	InstMemory #(IMEM_INIT_FILE, IMEM_ADDR_BIT_WIDTH, IMEM_DATA_BIT_WIDTH) instMem (pcOut[IMEM_PC_BITS_HI - 1: IMEM_PC_BITS_LO], instWord);
	
	// Put the code for getting opcode1, rd, rs, rt, imm, etc. here
	wire[3:0] key;
	wire[7:0] ledg;
	wire[9:0] sw, ledr;
	wire[15:0] imm, hex;
	wire[31:0] selRegRead1, selRegRead2, selRegWrite, pcNext, regWriteData, regReadData1, regReadData2, aluSource, aluResult, memReadData;
	wire[5:0] selALUop;
	wire enBranch, enRegWrite, enMemWrite, aluSrcIsReg, memToReg;
	
	assign regWriteData = memToReg ? memReadData : aluResult;
	assign aluSource = aluSrcIsReg ? regReadData2 : imm;
	assign pcIn = (selALUop[5] ? regReadData1 : pcNext) + (((enBranch && aluResult) || selALUop[5]) ? (imm * 4) : 0);
	
	SevenSeg hex0(hex[3:0], HEX0);
	SevenSeg hex1(hex[7:4], HEX1);
	SevenSeg hex2(hex[11:8], HEX2);
	SevenSeg hex3(hex[15:12], HEX3);
	
	Controller controller(clk, pcOut, instWord, 
		selRegRead1, selRegRead2, selRegWrite, imm, selALUop, pcNext, 
		enBranch, enRegWrite, enMemWrite, aluSrcIsReg, memToReg);
	  
	// Create the registers
	DPRF dprf(clk, reset, enRegWrite, selRegWrite, selRegRead1, selRegRead2, regWriteData, regReadData1, regReadData2);
	  
	// Create ALU unit
	ALU alu(clk, selALUop, regReadData1, aluSource, aluResult);
	  
	// Put the code for data memory and I/O here
	// KEYS, SWITCHES, HEXS, and LEDS are memeory mapped IO
	DataMemory #(IMEM_INIT_FILE) datamem(clk, enMemWrite, aluResult, regReadData2, SW, KEY, LEDR, LEDG, hex, memReadData);
endmodule

