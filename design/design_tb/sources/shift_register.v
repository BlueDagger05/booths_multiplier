`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2023 11:57:37
// Design Name: 
// Module Name: shift_register
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
module shift_register #(parameter DATA_WIDTH = 16)(
output reg  [DATA_WIDTH -1:0 ]  data_out,
input       [DATA_WIDTH -1:0 ]  data_in,
input                            clk,
input                            clear,
input                            load,
input                            s_in,
input                            shift
);

always @(posedge clk, negedge clear)
begin
   // if clear is active, output is tied to zero
   if(!clear)
      data_out <= 8'b0000_0000;
   // if load == 1, output is assigned the value of input       
   else if(load)
      data_out <= data_in;      
   // when load == 0, shifted data is tied to output      
   else if(shift)
         data_out <= {s_in, data_in[15:1]};  
end    
endmodule
