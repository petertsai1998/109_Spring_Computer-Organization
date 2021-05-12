`include"Adder.v"
`include"ALU_Ctrl.v"
`include"ALU.v"
`include"Decoder.v"
`include"Instr_Memory.v"
`include"Mux2to1.v"
`include"Mux3to1.v"
`include"Program_Counter.v"
`include"Reg_File.v"
`include"Shifter.v"
`include"Sign_Extend.v"
`include"Zero_Filled.v"


module Simple_Single_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles

wire [31:0] pc;
wire [31:0] pc_4;
wire [31:0] instruction;
wire RegDst;
wire RegWrite;
wire [2:0]ALUOP;
wire ALUSrc;
wire [4:0] Write_Register;
wire [31:0] Read_Data_1;
wire [31:0] Read_Data_2;
wire [31:0] Sign_extend_32;
wire [31:0] ALUSrc_2;
wire [31:0] Write_Back;
wire [3:0] ALU_operation;
wire [1:0] FURslt;
wire [31:0] Zero_Filled_32;
wire zero;
wire [31:0] Result;
wire [31:0] Shifter_Result;
wire overflow;
//wire leftRight;
reg leftRight;

always@(ALU_operation)begin
        case(ALU_operation)
                4'b0000: leftRight=0;
                4'b0001: leftRight=1;
        endcase
end

//modules
Program_Counter PC(
        .clk_i(clk_i),      
	    .rst_n(rst_n),     
	    .pc_in_i(pc_4) ,   
	    .pc_out_o(pc) 
	    );
	
Adder Adder1(
        .src1_i(pc),     
	    .sum_o(pc_4)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc),  
	    .instr_o(instruction)    
	    );

Mux2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instruction[20:16]),
        .data1_i(instruction[15:11]),
        .select_i(RegDst),
        .data_o(Write_Register)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_n(rst_n) ,     
        .RSaddr_i(instruction[25:21]) ,  
        .RTaddr_i(instruction[20:16]) ,  
        .RDaddr_i(Write_Register) ,  
        .RDdata_i(Write_Back)  , 
        .RegWrite_i(RegWrite),
        .RSdata_o(Read_Data_1) ,  
        .RTdata_o(Read_Data_2)   
        );
	
Decoder Decoder(
        .instr_op_i(instruction[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALUOp_o(ALUOP),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst)   
		);

ALU_Ctrl AC(
        .funct_i(instruction[5:0]),   
        .ALUOp_i(ALUOP),   
        .ALU_operation_o(ALU_operation),
		.FURslt_o(FURslt)
        );
	
Sign_Extend SE(
        .data_i(instruction[15:0]),
        .data_o(Sign_extend_32)
        );

Zero_Filled ZF(
        .data_i(instruction[15:0]),
        .data_o(Zero_Filled_32)
        );
		
Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(Read_Data_2),
        .data1_i(Sign_extend_32),
        .select_i(ALUSrc),
        .data_o(ALUSrc_2)
        );	
		
ALU ALU(
		.aluSrc1(Read_Data_1),
	    .aluSrc2(ALUSrc_2),
	    .ALU_operation_i(ALU_operation),
		.result(Result),
		.zero(Zero),
		.overflow(overflow) 
	    );
		
Shifter shifter( 
		.result(Shifter_Result), 
		.leftRight(leftRight),
		.shamt(instruction[10:6]),
		.sftSrc(ALUSrc_2) 
		);
		
Mux3to1 #(.size(32)) RDdata_Source(
        .data0_i(Result),
        .data1_i(Shifter_Result),
		.data2_i(Zero_Filled_32),
        .select_i(FURslt),
        .data_o(Write_Back)
        );			

endmodule