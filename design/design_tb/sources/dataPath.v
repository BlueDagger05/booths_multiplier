`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2023 12:29:13
// Design Name: 
// Module Name: dataPath
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

module dataPath #(parameter DATA_WIDTH = 16)(
output                     eqz,     // eqz == HIGH, when counter completes counting
output                     qm1,     // Q-1 bit 
output                     q0,      // Q0 bit

output [DATA_WIDTH -1:0]   AregOut,
output [DATA_WIDTH -1:0]   QregOut,

input                      clk,
input [DATA_WIDTH -1:0]    data_in,

input                      loadA,   // A shift register signals
input                      clearA,  // A shift register signals
input                      shiftA,  // A shift register signals

input                      loadQ,   // Q shift register signals
input                      clearQ,  // Q shift register signals
input                      shiftQ,  // Q shift register signals

input                      loadM,   // M register signals
input                      clearM,  // M register signals

input                      clearff, // DFF signals
input                      addSub,  // performs add/sub

input                      clearCounter,    // counter clear
input                      decr,            // counter decrement
input                      count_en         // count enable
    );

wire [3:0] count;
wire [DATA_WIDTH -1:0] Mout, Aout, Qout, ALUout;
assign eqz = ~|count;
assign q0  = Qout[0];
 
assign AregOut = Aout;
assign QregOut = Qout;
 
pipo_register M ( .clk(clk), 
                  .clear(clearM), 
                  .data_in(data_in), 
                  .load(loadM), 
                  .y_out(Mout));
                  
alu_addSub ALU ( .addSub(addSub), 
                 .a_in(Mout), 
                 .b_in(Aout), 
                 .y_out(ALUout));
                 
shift_register A (.data_out(Aout),
                  .data_in(ALUout), 
                  .clk(clk), 
                  .clear(clearA), 
                  .load(loadA), 
                  .s_in(Aout[15]), 
                  .shift(shiftA) );
                  
shift_register Q (.data_out(Qout),
                  .data_in(data_in), 
                  .clk(clk), 
                  .clear(clearQ), 
                  .load(loadQ), 
                  .s_in(Aout[0]),    
                  .shift(shiftQ));
                       
dff_async_clear Qm1 (.y_out(qm1), 
                     .clk(clk), 
                     .clear(clearff),  
                     .d_in(Qout[0]));
                     
counter C   ( .count_out(count), 
            .clk(clk), 
            .reset_n(clearCounter), 
            .count_en(count_en),    
            .decr(decr));

endmodule
