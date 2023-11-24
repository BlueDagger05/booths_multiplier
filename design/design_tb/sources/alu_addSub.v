`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2023 12:21:36
// Design Name: 
// Module Name: alu_addSub
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


module alu_addSub #(parameter DATA_WIDTH = 16)
(
	output 	reg 	[DATA_WIDTH -1:0] y_out, // have to check if we want to increase the width of the outptut
	input 		   [DATA_WIDTH -1:0] a_in,
	input 		   [DATA_WIDTH -1:0] b_in,
	input 			                  addSub
);
    
always @*
begin
   case(addSub)
      1'b0: y_out = a_in + b_in;
      1'b1: y_out = a_in - b_in;
   endcase
end    
endmodule
   
