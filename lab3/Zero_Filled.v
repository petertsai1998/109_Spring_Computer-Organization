module Zero_Filled( data_i, data_o );

//I/O ports
input	[16-1:0] data_i;
output	reg [32-1:0] data_o;

//Internal Signals
/*
wire	[32-1:0] data_o;
*/
genvar i;
//Zero_Filled
/*your code here*/

always@(data_i)begin
data_o[15:0] <= data_i[15:0];
data_o[31:16] <= 0;
end
/*
generate
for  (i = 0; i < 16; i = i+1)begin
    assign data_o[i] = data_i[i];
end
endgenerate

generate
for  (i = 16; i < 32; i = i+1)begin
    data_o[i] = 0;
end
endgenerate
*/

endmodule      
