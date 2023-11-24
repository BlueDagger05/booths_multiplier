`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2023 13:37:51
// Design Name: 
// Module Name: tb_control_unit
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


module tb_control_unit();
reg clk;
reg q_0;
reg  [1:0] count;
reg q_1;
wire load;
wire sub;
wire add;
wire shift;
wire decr;

control_unit DUT (.clk(clk),
                  .q_0(q_0),
                  .q_1(q_1),
                  .count(count),
                  .load(load),
                  .sub(sub),
                  .add(add),
                  .shift(shift),
                  .decr(decr));

initial begin
   clk   = 0;
   count = 0;
   q_1   = 0;
   q_0   = 0;
   
   $monitor("Time = %0t, q_0 = %0b,  q_1 = %0b, count = %0b, load = %0b, add = %0b, sub = %0b, shift = %0b, decr = %0b",
                  $time, q_0, q_1, count, load, add, sub, shift, decr);
   #1000 $finish();
end 

always #10 clk = ~clk;
always #10 count = count + 1'b1;
always #10 {q_0, q_1} = {q_0, q_1} + 1'b1;

endmodule
