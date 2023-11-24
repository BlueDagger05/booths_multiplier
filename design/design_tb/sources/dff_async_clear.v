`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2023 12:09:16
// Design Name: 
// Module Name: dff_async_clear
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
module dff_async_clear(
   output   reg   y_out,
   input          d_in,
   input          clk,
   input          clear   
);
  
always @(posedge clk, negedge clear)
begin
   if(!clear)
      y_out <= 'b0;
   else 
      y_out <= d_in;      
end    
endmodule
