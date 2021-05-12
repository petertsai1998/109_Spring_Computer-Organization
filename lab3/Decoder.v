module Decoder( instr_op_i, RegWrite_o,	ALUOp_o, ALUSrc_o, RegDst_o );
     
//I/O ports
input	[6-1:0] instr_op_i;

output	reg	RegWrite_o;
output	reg [3-1:0] ALUOp_o;
output	reg	ALUSrc_o;
output	reg	RegDst_o;
/*
output		RegWrite_o;
output	 [3-1:0] ALUOp_o;
output		ALUSrc_o;
output		RegDst_o;

//Internal Signals

wire	[3-1:0] ALUOp_o;
wire			ALUSrc_o;
wire			RegWrite_o;
wire			RegDst_o;
*/


//Main function
/*your code here*/
always @(instr_op_i) begin
    case(instr_op_i)
        6'b000000: begin
            RegWrite_o = 1'b1;
            ALUOp_o = 3'b010;
            ALUSrc_o = 1'b0;
            RegDst_o = 1'b1;
        end
        6'b001000: begin
            RegWrite_o = 1'b1;
            ALUOp_o = 3'b000;
            ALUSrc_o = 1'b1;
            RegDst_o = 1'b0;    
        end
    endcase
end
endmodule
   