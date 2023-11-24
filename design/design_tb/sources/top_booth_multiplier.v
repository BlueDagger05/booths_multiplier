`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2023 19:32:19
// Design Name: 
// Module Name: top_booth_multiplier
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
module top_booth_multiplier #(parameter DATA_WIDTH    = 16,
                              parameter OUTPUT_WIDTH  = 32)
                              
(
output [OUTPUT_WIDTH - 1:0] data_out,  // 32-bit wide output
output                      done,      // 1-bit done signal

input                       clk,                 
input                       clear,     // Active-Low asynchronous clear

input [DATA_WIDTH -1:0]     data_in,   // 16-bit wide input data
input                       start      // start signal
);

wire                      masterrst;   // async reset assertion, sync assert de-assertion
    
wire                      eqz_top;     // eqz == HIGH, when counter completes counting
wire                      qm1_top;     // Q-1 bit 
wire                      q0_top;      // Q0 bit

wire  [DATA_WIDTH -1:0]   AregOut_top;
wire  [DATA_WIDTH -1:0]   QregOut_top;

wire  [DATA_WIDTH -1:0]   data_in_top;
wire                      loadA_top;   // A shift register signals
wire                      clearA_top;  // A shift register signals
wire                      shiftA_top;  // A shift register signals

wire                      loadQ_top;   // Q shift register signals
wire                      clearQ_top;  // Q shift register signals
wire                      shiftQ_top;  // Q shift register signals

wire                      loadM_top;   // M register signals
wire                      clearM_top;  // M register signals

wire                      clearff_top; // DFF signals
wire                      addSub_top;  // performs add/sub

wire                      clearCounter; // clear counter
wire                      decr_top;      // counter decrement
wire                      count_en_top;  // count enable

    
masterrst RST(.masterrst(masterrst),
              .reset_n(clear), 
              .clk(clk)); 
               
dataPath DP (.clk(clk), 
             .data_in(data_in), 
             .addSub(addSub_top), 
             .loadA(loadA_top), 
             .clearA(clearA_top), 
             .shiftA(shiftA_top), 
             .loadQ(loadQ_top), 
             .clearQ(clearQ_top), 
             .shiftQ(shiftQ_top),
             .loadM(loadM_top), 
             .clearM(clearM_top),
             .clearff(clearff_top),
             .clearCounter(clearCounter),
             .decr(decr_top),
             .count_en(count_en_top),
             .eqz(eqz_top),
             .q0(q0_top),
             .qm1(qm1_top),
             .AregOut(data_out[31:16]), 
             .QregOut(data_out[15:0]));


controlPath CP (.loadA(loadA_top), 
                .clearA(clearA_top), 
                .shiftA(shiftA_top), 
                .loadQ(loadQ_top), 
                .clearQ(clearQ_top), 
                .shiftQ(shiftQ_top),
                .loadM(loadM_top),
                .clearM(clearM_top),
                .clearff(clearff_top),
                .decr(decr_top),
                .addSub(addSub_top),
                .eqz(eqz_top),
                .q0(q0_top),
                .qm1(qm1_top), 
                .loadCount(count_en_top),
                .clearCounter(clearCounter),
                .clk(clk), 
                .clear(masterrst), 
                .start(start), 
                .done(done));    

endmodule
