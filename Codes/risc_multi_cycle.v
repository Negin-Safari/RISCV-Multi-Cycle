module RISCV_multi_cycle (rst, clk,dataIN,dataOUT,inst_adr,inst, MemWrite, MemRead,DATA);
  
  input clk,rst;
  output  MemWrite, MemRead;
  wire pcen, IorD, IRWrite, RegWrite, ALUSrcA, PCSrc, sw;
  wire [1:0] ALUSrcB, MemtoReg;
  wire [3:0] alu_ctrl;
  input [63:0] dataIN;
  wire zero;
  output [63:0] dataOUT,inst_adr;
  output [31:0] inst;
  output [63:0] DATA;

  
  datapath  DP( clk,rst, pcen, IorD, MemWrite, MemRead, IRWrite, MemtoReg,
   RegWrite, ALUSrcA, ALUSrcB, PCSrc, sw, alu_ctrl, dataIN, zero, dataOUT, inst_adr, inst, DATA);
   
   
   controller CU(clk,rst, {inst[30],inst[14:12]},inst[6:0],zero,pcen, IorD, MemWrite, MemRead,
    IRWrite, MemtoReg, RegWrite, ALUSrcA,ALUSrcB, PCSrc, sw, alu_ctrl);

   
  
endmodule
