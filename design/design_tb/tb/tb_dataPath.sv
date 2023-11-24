`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.11.2023 11:05:12
// Design Name: 
// Module Name: tb_dataPath
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
module tb_dataPath #(parameter DATA_WIDTH = 16)();
logic                     eqz;     // eqz == HIGH, when counter completes counting
logic                     qm1;     // Q-1 bit 
logic                     q0;      // Q0 bit

logic [DATA_WIDTH -1:0]   AregOut;
logic [DATA_WIDTH -1:0]   QregOut;

logic                      clk;
logic [DATA_WIDTH -1:0]    data_in;

logic                      loadA;   // A shift register signals
logic                      clearA;  // A shift register signals
logic                      shiftA;  // A shift register signals

logic                      loadQ;   // Q shift register signals
logic                      clearQ;  // Q shift register signals
logic                      shiftQ;  // Q shift register signals

logic                      loadM;   // M register signals
logic                      clearM;  // M register signals

logic                      clearff; // DFF signals
logic                      addSub;  // performs add/sub

logic                      clearCounter;    // counter clear
logic                      decr;            // counter decrement
logic                      count_en;        // count enable

dataPath DUT (.*);

integer multplr, multplcnd;
localparam timePeriod = 10; // setting timePeriod as 10units
 
initial #5000 $finish();

initial begin: signal_reset
      clk      = 0;
      data_in  = 0;
      loadA    = 0;
      clearA   = 0;
      shiftA   = 0;
      
      loadQ    = 0;
      clearQ   = 0;
      shiftQ   = 0;
      
      loadM    = 0;
      clearM   = 0;
      
      clearff  = 0;
      addSub   = 0;
      
      clearCounter = 0;
      decr         = 0;
      count_en     = 0;
end:signal_reset

initial begin: clock_generate
   forever #(timePeriod/2) clk = ~clk;
end: clock_generate

task counterStart();
begin
   clearCounter   = 1;
   count_en       = 1;
   @(posedge clk) decr = 1;
end
endtask: counterStart

task loadMultiplier();
begin
   clearM   = 1;
   loadM    = 1;
   @(posedge clk) data_in  = $urandom();
                  multplr  = data_in;
   $display(" +--------------------------------------+ ");
   $display(" +------------loadMultiplier------------+ ");
   $display(" +--------------------------------------+ ");
end
endtask: loadMultiplier

task loadMultiplicand();
begin
   clearQ   = 1;
   loadQ    = 1;
   @(posedge clk) data_in   = $urandom();
                  multplcnd = data_in;
   $display(" +----------------------------------------+ ");
   $display(" +------------loadMultiplicand------------+ ");
   $display(" +----------------------------------------+ ");
end
endtask: loadMultiplicand

task addsub();
begin
   addSub = 1;
   clearA = 1;
   loadA  = 1;
   $display(" +------------------------------+ ");
   $display(" +------------addSub------------+ ");
   $display(" +------------------------------+ ");
end
endtask:addsub

initial begin

   fork
   loadMultiplier();
   @(posedge clk) repeat(16)counterStart();
   join_any
   
   wait (loadM) loadMultiplicand();
   addsub();
end

initial $monitor("@%0t, Multiplier = 0x%0h, Multiplicand = 0x%0h, eqz = %0h, q0 = %0h, qm1 = %0h", 
                  $time, multplr, multplcnd,eqz, q0, qm1);
                  
endmodule
