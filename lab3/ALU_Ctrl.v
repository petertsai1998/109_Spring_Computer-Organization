module ALU_Ctrl( funct_i, ALUOp_i, ALU_operation_o, FURslt_o );

//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output   reg  [4-1:0] ALU_operation_o;  
output   reg  [2-1:0] FURslt_o;
     
//Internal Signals
/*
wire    [4-1:0] ALU_operation_o;
wire	[2-1:0] FURslt_o;

//Main function
/*your code here*/
always@(funct_i or ALUOp_i )begin
    case(ALUOp_i)
        3'b010:begin
            case(funct_i)
                6'b010011:begin
                    FURslt_o = 0;
                    ALU_operation_o = 4'b0010;
                end
                6'b010001:begin
                    FURslt_o = 0;
                    ALU_operation_o = 4'b0110;
                end
                6'b010100:begin
                    FURslt_o = 0;
                    ALU_operation_o = 4'b0000;
                end
                6'b010110:begin
                    FURslt_o = 0;
                    ALU_operation_o = 4'b0001;
                end
                6'b010101:begin
                    FURslt_o = 0;
                    ALU_operation_o = 4'b1100;
                end
                6'b110000:begin
                    FURslt_o = 0;
                    ALU_operation_o = 4'b0111;
                end
                6'b000000:begin
                    FURslt_o = 1;
                    ALU_operation_o = 4'b0000;
                end
                6'b000010:begin
                    FURslt_o = 1;
                    ALU_operation_o = 4'b0001;
                end
            endcase
        end
        3'b000:begin
            FURslt_o = 0;
            ALU_operation_o = 4'b0010;
        end
    endcase
end

endmodule     
