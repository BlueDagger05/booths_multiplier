`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2023 17:54:35
// Design Name: 
// Module Name: masterrst
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


module masterrst(
output  reg masterrst,
input       clk,
input       reset_n
    );

reg resetOut;
    
always @(posedge clk, negedge reset_n)
begin
    if(!reset_n)    {resetOut, masterrst} <= 'b0;
    else            {masterrst,resetOut}  <= {resetOut,1'b1};
end    
endmodule
