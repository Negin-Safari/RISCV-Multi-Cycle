module datapath ( clk,rst, pcen, IorD, MemWrite, MemRead, IRWrite, MemtoReg, RegWrite, ALUSrcA, ALUSrcB, PCSrc, sw, alu_ctrl, dataIN, zero, dataOUT, inst_adr, inst, mux6_out);
  
  
input clk,rst, pcen, IorD, MemWrite, MemRead, IRWrite, RegWrite, ALUSrcA, PCSrc, sw;
input [1:0] ALUSrcB, MemtoReg;
input [3:0] alu_ctrl;
input [63:0] dataIN;
output zero;
output [63:0] dataOUT,inst_adr;
  
  wire [63:0] mux1_out;
  wire [63:0] pc_out;
  wire [63:0] alu_result;
  wire [63:0] alu_out;
  output [31:0] inst;
  wire [63:0] MDR_out;
  wire [63:0] mux3_out;
  wire [63:0] read_data1, read_data2;
  wire [63:0] A_out;
  wire [63:0] B_out;
  wire [63:0] mux4_out;
  wire [63:0] mux5_out;
  output [63:0] mux6_out;
  wire [63:0] ImmGen_out;
  wire [63:0] sgn_ext_out1;
  wire [63:0] sgn_ext_out2;
  
  mux2to1_64b MUX1(alu_result,alu_out,PCSrc,mux1_out);
  
  reg_64b PC(mux1_out, rst, pcen, clk, pc_out);
  
  mux2to1_64b MUX2(pc_out,alu_out,IorD,dataOUT);
  
  reg_32b IR(dataIN[31:0] , rst, IRWrite, clk, inst);
  
  reg_64b MDR(dataIN, rst, 1'b1, clk, MDR_out);
  
  mux4to1_64b MUX3(alu_out, MDR_out, pc_out, sgn_ext_out2, MemtoReg, mux3_out);
  
  reg_file  RF(mux3_out, inst[19:15], inst[24:20], inst[11:7], RegWrite, rst, clk, read_data1, read_data2);
  
  reg_64b A(read_data1, rst, 1'b1, clk, A_out);
  
  reg_64b B(read_data2, rst, 1'b1, clk, B_out);
  
  mux2to1_64b MUX4(pc_out,A_out,ALUSrcA,mux4_out);
  
  mux4to1_64b MUX5(B_out,64'd4,ImmGen_out,alu_out,ALUSrcB,mux5_out);
  
  alu ALU(mux4_out, mux5_out, alu_ctrl, alu_result, zero);
  
  reg_64b ALU_Out(alu_result, rst, 1'b1, clk, alu_out);
  
  Imm_Gen IMM_GEN(inst, ImmGen_out);
  
  sign_ext SGN_EXT1(B_out[31:0], sgn_ext_out1);
  
  mux2to1_64b MUX6(B_out, sgn_ext_out1, sw, mux6_out);
  
  sign_ext SGN_EXT2(MDR_out[31:0], sgn_ext_out2);
  
  assign inst_adr = pc_out;

  
endmodule
