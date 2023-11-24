`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2023 23:35:33
// Design Name: 
// Module Name: controlPath
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


module controlPath(
output reg  loadA,      // A register signals
output reg  clearA,     // A register signals
output reg  shiftA,     // A register signals

output reg  loadQ,      // Q register signals
output reg  clearQ,     // Q register signals
output reg  shiftQ,     // Q register signals

output reg  loadM,      // M register signals
output reg  clearM,     // M register signals

output reg  clearff,    // clear ff signal
output reg  addSub,     // ALU addsub signal

output reg  decr,       // counter decrement signal
output reg  loadCount,  // counter loadCount signal
output reg  clearCounter,  // resets counter
output reg  done,       // valid output done signal

input q0,               // Q0 bit input
input qm1,              // Qm1 bit input

input start,            // top module start signal
input eqz,              // eqz signal from counter

input clk,              // synchronous clk signal
input clear             // asynchronous clear signal
    );

// FSM states    
parameter STATE0 = 3'b000;    
parameter STATE1 = 3'b001;    
parameter STATE2 = 3'b010;    
parameter STATE3 = 3'b011;    
parameter STATE4 = 3'b100;    
parameter STATE5 = 3'b101;    
parameter STATE6 = 3'b110;
    
// temporary variables for present and next state    
reg [2:0] present_state, next_state;

// next state logic
always @*    
begin
   case(present_state)
      STATE0:  begin
                  if(start)
                     present_state = STATE1;
               end
               
      STATE1:  present_state <= STATE2;
                       
      STATE2:  begin
                  if({q0, qm1}==2'b01)
                     present_state = STATE3;
                  else if({q0, qm1} == 2'b10)
                     present_state  = STATE4;
                  else
                     present_state = STATE5;                                          
               end               
      STATE3: present_state = STATE5;
      
      STATE4: present_state = STATE5;
      
      STATE5: begin
                  if(( {q0,qm1} == 2'b01) && !eqz) 
                  present_state = STATE3;
                  
                  else if(( {q0,qm1} == 2'b10) && !eqz) 
                  present_state = STATE4;
                  
                  else if(eqz)
                     present_state = STATE6;
               end            
      STATE6: present_state = STATE6;
      default: present_state = STATE0;                                       
   endcase
end

// state register logic
always @(posedge clk, negedge clear)
begin

   if(!clear) present_state <= STATE0;
   else       present_state <= next_state;
   
end

// output logic 
always @*
begin
   case(present_state)
      STATE0: begin
                  clearA                  = 0; 
                  loadA                   = 0; 
                  shiftA                  = 0;
                  clearQ                  = 0;
                  loadQ                   = 0;
                  shiftQ                  = 0;
                  loadM                   = 0;
                  clearM                  = 0;
                  clearff                 = 0;
                  done                    = 0;
              end
              
      STATE1: begin
                  clearA   = 1;
                  clearff  = 1;
                  loadCount= 1;
                  loadM    = 1;
              end
              
      STATE2: begin
                  clearA   = 0;
                  clearff  = 0;
                  loadCount= 0;
                  loadM    = 0;
                  loadQ    = 1;
              end
              
      STATE3: begin
                  loadA    = 1;
                  addSub   = 1;
                  loadQ    = 0;
                  shiftA   = 0;
                  shiftQ   = 0;
                  decr     = 0;
              end 
              
      STATE4: begin
                  loadA    = 1;
                  addSub   = 0;
                  loadQ    = 0;
                  shiftA   = 0;
                  shiftQ   = 0;
                  decr     = 0;
              end              
              
      STATE5: begin
                  shiftA   = 1;
                  shiftQ   = 1;
                  loadA    = 0;
                  loadQ    = 0;
                  decr     = 1;
              end
              
      STATE6: begin
                  clearCounter  = 0;
                  done          = 1;
              end          
              
      default: begin
                  clearA = 0;
                  shiftQ = 0;
                  loadA  = 0;
                  loadQ  = 0;
                  decr   = 1;
               end                                              
   endcase
end
endmodule
