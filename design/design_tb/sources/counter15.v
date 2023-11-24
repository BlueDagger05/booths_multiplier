`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2023 12:03:19
// Design Name: 
// Module Name: counter_15
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

module counter #(parameter COUNT_WIDTH = 4)(
   output   reg   [COUNT_WIDTH -1:0] count_out,
   input                             clk,
   input                             reset_n,
   input                             count_en,
   input                             decr   
    );

always @(posedge clk, negedge reset_n)
begin
   if(!reset_n)
      count_out <= 'b0;
   else if(count_en) 
      count_out <= 'b10000;
   else if(decr)  
      count_out <= count_out - 1'b1;      
end    

endmodule
