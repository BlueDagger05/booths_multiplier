`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2023 11:46:16
// Design Name: 
// Module Name: pipo_register_4bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pipo_register #(parameter DATA_WIDTH = 16)(
	output 	reg 	[DATA_WIDTH -1:0]  y_out,
	input 				                clk, 
	input 				                load,
	input 				                clear,
	input 		[DATA_WIDTH -1:0]     data_in
);
    
always @(posedge clk, negedge clear)
begin
   // if clear == 1, output is 16'b0000_0000_0000_0000
   if(!clear)  
      y_out <= 'b0;
   // else if load == 1, load the data      
   else if(load)
      y_out <= data_in;      
end    
endmodule
