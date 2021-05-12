module Sign_Extend( data_i, data_o );

//I/O ports
input	[16-1:0] data_i;
output reg	[32-1:0] data_o;

//Internal Signals
/*
wire	[32-1:0] data_o;
*/
genvar i;
//Sign extended
/*your code here*/
always@(data_i)begin
    if(data_i[15] == 0)begin
        data_o[31:16] = 16'b0000000000000000; 
        data_o[15:0] = data_i[15:0]; 
    end
    else begin
        data_o[31:16] = 16'b1111111111111111; 
        data_o[15:0] = data_i[15:0]; 
    end
end

endmodule      
